#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <pihole_api.h>
#include <QQmlContext>
#include <QtQuickControls2/QQuickStyle>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    QQuickStyle::setStyle("Fusion");

    app.setQuitOnLastWindowClosed(false);

    PiholeApi api;
    engine.rootContext()->setContextProperty("piholeApi", &api);

    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.loadFromModule("hole_monitor", "Main");

    return QCoreApplication::exec();
}
