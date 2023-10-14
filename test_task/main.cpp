#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "applicationmediator.h"
#include "databaseproxy.h"
#include "imagefromblobdisplayer.h"
int main(int argc, char *argv[])
{
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    qmlRegisterType<ImageFromBlobDisplayer>("ImageConnector",1,0,"ImageFromBlobDisplayer");
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QQmlContext* pContext = engine.rootContext();
    DatabaseProxy* dbproxy = new DatabaseProxy(QCoreApplication::instance(), pContext);
    ApplicationMediator* applicationMediator = new ApplicationMediator(QCoreApplication::instance(), dbproxy);
    pContext->setContextProperty("ApplicationMediator", applicationMediator);

    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);



    engine.load(url);

    return app.exec();
}