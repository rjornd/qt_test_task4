#include "databaseproxy.h"
DatabaseProxy::DatabaseProxy(QObject *parent, QQmlContext *pContext)
    : QObject{parent}, pContext{pContext}
{
    Q_ASSERT(pContext != nullptr);
    connectToDataBase();
    familyModel = new SqlQueryModelGenerator(this);
    familyModel->setQuery("SELECT * FROM " FAMILY_TABLE " WHERE isDeleted=0;");
    transactionsModel = new SqlQueryModelGenerator(this);
    transactionsModel->setQuery("SELECT * FROM " INCOMES_TABLE " JOIN "
                                FAMILY_TABLE " ON " INCOMES_TABLE".familyMemberId = " FAMILY_TABLE".id");

    pContext->setContextProperty("familyModel", familyModel);
    pContext->setContextProperty("transactionsModel", transactionsModel);
}

void DatabaseProxy::onUpdateFamilyMember(const QString &id, const QString &firstName, const QString &lastName, const QByteArray &image)
{
    if (db.isOpen())
    {
        QSqlQuery query(db);
        QImage img;
        if (img.loadFromData(image)) { // confirm that selected file is image
            query.prepare("UPDATE " FAMILY_TABLE " SET firstName=:firstName, lastName=:lastName, iconBlob=:image WHERE id=:id");
            query.bindValue(":image", image);
        }
        else { // if not do not update image blob
            query.prepare("UPDATE " FAMILY_TABLE " SET firstName=:firstName, lastName=:lastName WHERE id=:id");
        }

        query.bindValue(":firstName", firstName);
        query.bindValue(":lastName", lastName);
        query.bindValue(":id", id);

        if (!query.exec()) qDebug() << query.lastError().text();
        familyModel->updateModel();
    }
}

void DatabaseProxy::onDeleteFamilyMember(const QString &id)
{
    if (db.isOpen())
    {
        QSqlQuery query(db);
        query.prepare("UPDATE " FAMILY_TABLE " SET isDeleted=1 WHERE id=:id");
        query.bindValue(":id", id);

        if (!query.exec()) qDebug() << query.lastError().text();
        familyModel->updateModel();
    }
}

void DatabaseProxy::onAddFamilyMember(const QString &firstName, const QString &lastName, const QByteArray &image)
{
    if (db.isOpen())
    {
        QSqlQuery query(db);
        QImage img;
        if (img.loadFromData(image)) { // confirm that selected file is image
            query.prepare("INSERT INTO " FAMILY_TABLE " (firstName, lastName, iconBlob) VALUES (:firstName, :lastName, :image)");
            query.bindValue(":image", image);
        }
        else { // if not do not update image blob
            query.prepare("INSERT INTO " FAMILY_TABLE " (firstName, lastName) VALUES (:firstName, :lastName)");
        }

        query.bindValue(":firstName", firstName);
        query.bindValue(":lastName", lastName);

        if (!query.exec()) qDebug() << query.lastError().text();
        familyModel->updateModel();
    }
}

void DatabaseProxy::onAddTransactionItem(const int &familyId, const QString &type,
                                         const QString &category, const float &amount, const QString &desctiption)
{
    if (db.isOpen())
    {
        QSqlQuery query(db);
        query.prepare("INSERT INTO " INCOMES_TABLE " (familyMemberId, type, category, operationAmount, description, datetime) "
                                                   " VALUES (:familyMemeberId, :type, :category, :operationAmount, :description, :datetime) ");
        query.bindValue(":familyMemeberId", familyId);
        query.bindValue(":type", type);
        query.bindValue(":category", category);
        query.bindValue(":operationAmount", amount);
        query.bindValue(":description", desctiption);
        QDateTime currentDateTime = QDateTime::currentDateTime();
        qint64 unixTime = currentDateTime.toSecsSinceEpoch();
        query.bindValue(":datetime", unixTime);
        if (!query.exec()) qDebug() << query.lastError().text();
        transactionsModel->updateModel();
    }
}


bool DatabaseProxy::openDataBase()
{
    db = QSqlDatabase::addDatabase("QSQLITE");
    db.setDatabaseName( QDir::homePath() + "/database/" + DATABASE_NAME);
    if(db.open()){
        return true;
    } else {
        qDebug() << db.lastError().text();
        return false;
    }
}

bool DatabaseProxy::restoreDataBase()
{
    if(this->openDataBase()){
        if(!this->createTable()){
            return false;
        } else {
            return true;
        }
    } else {
        qDebug() << "Failed to restore the database";
        return false;
    }
    return false;
}

bool DatabaseProxy::createTable()
{
    /* In this case, a forming raw SQL-query with its subsequent execution.
     * */
    QSqlQuery query(db);
    if(!query.exec( "CREATE TABLE " FAMILY_TABLE " ("
                            "id INTEGER PRIMARY KEY AUTOINCREMENT, "
                            "firstName"     " VARCHAR(255)   NOT NULL,"
                            "lastName"      " VARCHAR(255)   NOT NULL,"
                            "iconBlob"      " BLOB, "
                            "isDeleted"     " INTEGER  DEFAULT 0 NOT NULL "
                        " )"
                    )
            ||
        !query.exec( "CREATE TABLE " INCOMES_TABLE " ("
                            "id INTEGER PRIMARY KEY AUTOINCREMENT, "
                            "familyMemberId"  " INTEGER   NOT NULL,"
                            "type"            " TEXT   NOT NULL,"
                            "category"        " TEXT   NOT NULL,"
                            "operationAmount" " REAL   NOT NULL, "
                            "description"     " TEXT,   "
                            "datetime"        " INTEGER,   "
                            "FOREIGN KEY(familyMemberId) REFERENCES  " FAMILY_TABLE "(id)"
                        " )"
                    )
            )
    {
        qDebug() << "Database table create error " << FAMILY_TABLE;
        qDebug() << query.lastError().text();
        return false;
    } else {
        return true;
    }
    return false;
}

void DatabaseProxy::connectToDataBase()
{
    if(!QFile(QDir::homePath() + "/database/" + DATABASE_NAME).exists()){
            this->restoreDataBase();
        }
    else {
            this->openDataBase();
    }
}


