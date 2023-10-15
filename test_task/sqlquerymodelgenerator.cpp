#include "sqlquerymodelgenerator.h"

SqlQueryModelGenerator::SqlQueryModelGenerator(QObject *parent)
    : QSqlQueryModel{parent}
{

}

void SqlQueryModelGenerator::setQuery(const QString &query, const QSqlDatabase &db)
{
    QSqlQueryModel::setQuery(query, db);
    generateRoleNames();
}

void SqlQueryModelGenerator::generateRoleNames()
{
    m_roleNames.clear();
    for( int i = 0; i < record().count(); i ++) {
        m_roleNames.insert(Qt::UserRole + i + 1, record().fieldName(i).toUtf8());
    }
}

QVariant SqlQueryModelGenerator::data(const QModelIndex &index, int role) const
{
    QVariant value;

    if(role < Qt::UserRole) {
        value = QSqlQueryModel::data(index, role);
    }
    else {
        int columnIdx = role - Qt::UserRole - 1;
        QModelIndex modelIndex = this->index(index.row(), columnIdx);
        value = QSqlQueryModel::data(modelIndex, Qt::DisplayRole);
        if(roleNames().value(role) == "iconBlob") {
            QImage img;
            if (img.loadFromData(value.toByteArray())) return img;
            else {
                img.load(":/icons/missingImage");

                return img;
            }
        }
    }
    return value;
}
