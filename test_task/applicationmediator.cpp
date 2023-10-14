#include "applicationmediator.h"

ApplicationMediator::ApplicationMediator(QObject *parent, DatabaseProxy *dbproxy)
    : QObject{parent}, dbproxy{dbproxy}
{
    Q_ASSERT(dbproxy != nullptr);

}
