#ifndef DATABASEPROXY_H
#define DATABASEPROXY_H

#include <QObject>
#include <QtSql>
#include <QQmlContext>
#include "sqlquerymodelgenerator.h"

#define DATABASE_HOSTNAME   "DataBaseHostname"
#define DATABASE_NAME       "database8.db"

#define FAMILY_TABLE        "FamilyExample"
#define INCOMES_TABLE       "IncomesTable"

class DatabaseProxy : public QObject
{
    Q_OBJECT

private:
    QSqlDatabase db;
    QQmlContext* pContext;
    SqlQueryModelGenerator* familyModel;
    SqlQueryModelGenerator* transactionsModel;
    bool openDataBase();
    bool restoreDataBase();
    void closeDataBase();
    bool createTable();
    void connectToDataBase();
public:
    explicit DatabaseProxy(QObject *parent = nullptr, QQmlContext* pContext = nullptr);
public slots:
    void onUpdateFamilyMember(const QString &id, const QString &firstName,
                              const QString &lastName, const QByteArray &image);
    void onDeleteFamilyMember(const QString &id);
    void onAddFamilyMember(const QString &firstName,
                            const QString &lastName, const QByteArray &image);
    void onAddTransactionItem( const int &familyId, const QString &type, const QString &category,
                               const float &amount, const QString &desctiption);
signals:
    void dbError(QString);
    void dbAnswer(QString);
};

#endif // DATABASEPROXY_H
