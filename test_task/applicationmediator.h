#ifndef APPLICATIONMEDIATOR_H
#define APPLICATIONMEDIATOR_H
#include "databaseproxy.h"
#include <QObject>

class ApplicationMediator : public QObject
{
    Q_OBJECT
private:
    DatabaseProxy* dbproxy = nullptr;
public:
    explicit ApplicationMediator(QObject *parent = nullptr, DatabaseProxy *dbproxy = nullptr);

signals:

};

#endif // APPLICATIONMEDIATOR_H
