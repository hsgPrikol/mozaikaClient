#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "test.h"
#include "contactslist.h"

int main(int argc, char *argv[])
{
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    Test testMap;
    ContactsList contacts;
    contacts.getVectorSize(0);

    engine.rootContext()->setContextProperty("testMap", &testMap);
    engine.rootContext()->setContextProperty("contactsss", &contacts);

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
