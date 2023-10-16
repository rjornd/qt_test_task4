#ifndef SQLQUERYMODELGENERATOR_H
#define SQLQUERYMODELGENERATOR_H

#include <QSqlQueryModel>
#include <QSqlRecord>
#include <QSqlField>
#include <QImage>
#include <QUrl>
#include <QSqlQuery>
class SqlQueryModelGenerator : public QSqlQueryModel
{
    Q_OBJECT
public:
    explicit SqlQueryModelGenerator(QObject *parent = nullptr);
    void setQuery(const QString &query, const QSqlDatabase &db = QSqlDatabase());
    Q_INVOKABLE QVariant getItemByIndexName(int index, QByteArray roleName);
    QVariant data(const QModelIndex &index, int role) const;
    QHash<int, QByteArray> roleNames() const {	return m_roleNames;	}
    void updateModel();
private:
    void generateRoleNames();
    QHash<int, QByteArray> m_roleNames;
    QString savedQuery;
};

#endif // SQLQUERYMODELGENERATOR_H
