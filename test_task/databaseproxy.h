#ifndef DATABASEPROXY_H
#define DATABASEPROXY_H

#include <QObject>
#include <QtSql>
#include <QQmlContext>
#include "sqlquerymodelgenerator.h"

#define DATABASE_HOSTNAME   "DataBaseHostname"
#define DATABASE_NAME       "database.db"

#define TABLE               "FamilyExample"


class DatabaseProxy : public QObject
{
    Q_OBJECT

private:
    QSqlDatabase db;
    QQmlContext* pContext;
    SqlQueryModelGenerator* familyModel;
    bool openDataBase();
    bool restoreDataBase();
    void closeDataBase();
    bool createTable();
    void connectToDataBase();
public:
    explicit DatabaseProxy(QObject *parent = nullptr, QQmlContext* pContext = nullptr);
public slots:
    void onUpdateFamilyMember(const QString id, const QString firstName,
                              const QString lastName, const QByteArray image);
signals:
    void dbError(QString);
    void dbAnswer(QString);
};

#endif // DATABASEPROXY_H
