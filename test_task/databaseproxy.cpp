#include "databaseproxy.h"
DatabaseProxy::DatabaseProxy(QObject *parent, QQmlContext *pContext)
    : QObject{parent}, pContext{pContext}
{
    Q_ASSERT(pContext != nullptr);
    connectToDataBase();
    SqlQueryModelGenerator* familyModel = new SqlQueryModelGenerator(nullptr);
    familyModel->setQuery("SELECT * FROM " TABLE);
    pContext->setContextProperty("familyModel", familyModel);
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
    if(!query.exec( "CREATE TABLE " TABLE " ("
                            "id INTEGER PRIMARY KEY AUTOINCREMENT, "
                            "firstName"     " VARCHAR(255)   NOT NULL,"
                            "lastName"      " VARCHAR(255)   NOT NULL,"
                            "iconBlob"      " BLOB           NOT NULL"
                        " )"
                    )){
        qDebug() << "Database table create error " << TABLE;
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


