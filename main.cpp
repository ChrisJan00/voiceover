#include <QApplication>
#include "qmlapplicationviewer.h"
#include "secondview.h"
#include "controller.h"

Q_DECL_EXPORT int main(int argc, char *argv[])
{
    QScopedPointer<QApplication> app(createApplication(argc, argv));

    QmlApplicationViewer viewer;
    viewer.addImportPath(QLatin1String("modules"));
    viewer.setOrientation(QmlApplicationViewer::ScreenOrientationAuto);
    viewer.setMainQmlFile(QLatin1String("qml/voiceover/main.qml"));

    SecondView audienceViewer;
    audienceViewer.setSource(QUrl(QLatin1String("qml/voiceover/secondscreen.qml")));


    Controller gameControl;
    gameControl.linkViews(&viewer, &audienceViewer);

    viewer.showExpanded();
    audienceViewer.show();

    return app->exec();
}
