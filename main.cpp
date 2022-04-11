#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "test.h"
#include "contactslist.h"
#include "settingsdata.h"
#include "Client/clientgeneral.h"
#include "Client/super_server/user.h"


int main(int argc, char *argv[])
{
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    Test testMap;
    ContactsList contacts;
    SettingsData settingsData;

    User *currentUser = new User();

    ClientGeneral client;



    contacts.getVectorSize(0);

    engine.rootContext()->setContextProperty("testMap", &testMap);
    engine.rootContext()->setContextProperty("contactsss", &contacts);
    engine.rootContext()->setContextProperty("settingsData",&settingsData);
    engine.rootContext()->setContextProperty("client", &client);

    engine.rootContext()->setContextProperty("currentUser", currentUser);

    const QUrl url(QStringLiteral("qrc:/main.qml"));
//    const QUrl url(QStringLiteral("qrc:/Dialogs.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
