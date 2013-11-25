#include <QApplication>
#include <QtDeclarative>
#include "qmlapplicationviewer.h"
#include "secondview.h"
#include "controller.h"
#include "soundclip.h"

Q_DECL_EXPORT int main(int argc, char *argv[])
{
    QScopedPointer<QApplication> app(createApplication(argc, argv));

    MixerInstance mI;
    if (!mI.isValid())
        return -1;

    qmlRegisterType<SoundClip>("SDLMixerWrapper",1,0,"SoundClip");
    qmlRegisterType<MusicClip>("SDLMixerWrapper",1,0,"MusicClip");

    SecondView viewer;
    viewer.setSource(QUrl(QLatin1String("qml/voiceover/main.qml")));
    viewer.setWindowTitle(QLatin1String("Control panel"));

    SecondView audienceViewer;
    audienceViewer.setSource(QUrl(QLatin1String("qml/voiceover/secondscreen.qml")));
    audienceViewer.setWindowTitle(QLatin1String("Voice Over"));

    Controller gameControl;

    viewer.show();
    audienceViewer.show();
    gameControl.linkViews(&viewer, &audienceViewer);

    return app->exec();
}
