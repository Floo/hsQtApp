//#include "shared.h"
//DECLARATIVE_EXAMPLE_MAIN(main)

#include "appsettings.h"
#include <QApplication>
#include <QQmlApplicationEngine>
//#include <QtQuick/QQuickView>
//#include <QGuiApplication>
#include <QtQml>




int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    qmlRegisterType<AppSettings>("AppSettings", 1, 0, "AppSettings");

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:///main.qml")));

//    QGuiApplication app(argc, argv);

//    qmlRegisterType<AppSettings>("AppSettings", 1, 0, "AppSettings");

//    QQuickView view;
//    view.setResizeMode(QQuickView::SizeRootObjectToView);
//    view.setSource(QUrl("qrc:///main.qml"));
//    view.show();



    return app.exec();
}

