#ifndef SQLQUERYMODELGENERATOR_H
#define SQLQUERYMODELGENERATOR_H

#include <QSqlQueryModel>
#include <QSqlRecord>
#include <QSqlField>
#include <QImage>
class SqlQueryModelGenerator : public QSqlQueryModel
{
    Q_OBJECT
public:
    explicit SqlQueryModelGenerator(QObject *parent = nullptr);
    void setQuery(const QString &query, const QSqlDatabase &db = QSqlDatabase());
    QVariant data(const QModelIndex &index, int role) const;
    QHash<int, QByteArray> roleNames() const {	return m_roleNames;	}

private:
    void generateRoleNames();
    QHash<int, QByteArray> m_roleNames;
};

#endif // SQLQUERYMODELGENERATOR_H
