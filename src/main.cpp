#include <QCoreApplication>
#include <QQmlApplicationEngine>
#include <QGuiApplication>
#include <QQuickView>
#include <QDebug>


int main(int argc, char *argv[])
{
    
    QGuiApplication app(argc, argv);
    
    QQuickView _view{};
    _view.connect(_view.engine(), SIGNAL(quit()), SLOT(close()));
    _view.setResizeMode(QQuickView::SizeRootObjectToView);
    _view.setSource(QUrl("qrc:/main.qml"));
    _view.show();

    return app.exec();
}
