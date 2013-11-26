import QtQuick 1.1
import SDLMixerWrapper 1.0
import "strpool.js" as StrPool

Rectangle {
    width: 1000
    height: 600
    color: StrPool.getColor(7);
    property string stringToShow: ""

    function startGame() {
        animscene.start();
        startFadeAnim.restart();
    }

    function interruptPlay() {
        animscene.stop();
    }

    property alias animAboutToFinish: animscene.aboutToFinish
    onAnimAboutToFinishChanged: if (animAboutToFinish) {
        fadeoutAnim.start();
        mainTheme.fadeOut(1000);
    }

    property alias animDone: animscene.done
    onAnimDoneChanged: if (animDone) {
        endFadeAnim.start();
    }


    AnimatedScene {
        id: animscene
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.topMargin: 10
        anchors.top: parent.top
        width: 500
        height: 500
        showcountdown: false
    }

    FontLoader { id: scrog; source: "Scrogglet.ttf"; name:"scrogglet" }

    // Legend
    Text {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: animscene.bottom
        anchors.topMargin: 10

        id: txt
        font.family: scrog.name
        font.pixelSize: 28
        horizontalAlignment:  Text.AlignHCenter
        color: StrPool.getColor(-1);
        text: stringToShow
        opacity: 0
        onTextChanged: {
            fadeoutAnim.stop();
            if (opacity == 0)
                fadeinAnim.start();
            else
                opacity = 1;
            showtime.stop();
            showtime.interval = stringToShow.length * 40 + 1500;
            showtime.restart();
        }

        PropertyAnimation {
            id: fadeoutAnim
            target: txt
            properties: "opacity"
//            from: 1
            to: 0
            duration: 400
        }

        PropertyAnimation {
            id: fadeinAnim
            target: txt
            properties: "opacity"
            from: 0
            to: 1
            duration: 100
        }

        Timer {
            id: showtime
            interval: 3000
            repeat: false
            running: false
            onTriggered: {
                fadeoutAnim.start();
            }
        }
    }

    // StartScreen
    Rectangle {
        id: overlay
        anchors.fill: parent
        color: StrPool.getColor(7);
        SequentialAnimation {
            id: startFadeAnim
            PauseAnimation { duration: 2000 }
            PropertyAnimation {
                target: overlay
                properties: "opacity"
                to: 0
                duration: 1000
            }
            ScriptAction {
                script: {
                    mainTheme.play();
                }
            }
        }
        PropertyAnimation {
            id: endFadeAnim
                target: overlay
                properties: "opacity"
                to: 1
                duration: 1000
        }

        Column {
            anchors.centerIn: parent
            Text {
                font.family: scrog.name
                font.pixelSize: 52
                horizontalAlignment:  Text.AlignHCenter
                color: StrPool.getColor(-1);
                text: "Voice Over"
            }
            Text {
                font.family: scrog.name
                font.pixelSize: 28
                horizontalAlignment:  Text.AlignHCenter
                color: StrPool.getColor(-1);
                text: "by Christiaan Janssen"
            }
            Text {
                font.family: scrog.name
                font.pixelSize: 18
                horizontalAlignment:  Text.AlignHCenter
                color: StrPool.getColor(-1);
                text: "Berlin Mini Jam November 2013"
            }
            Text {
                font.family: scrog.name
                font.pixelSize: 14
                horizontalAlignment:  Text.AlignHCenter
                color: StrPool.getColor(-1);
                text: "\n\nMusic: The Open Goldberg Variations\n        by Kimiko Ishizaka (CC0)"
            }
        }
    }

    // sound
    MusicClip {
        id: mainTheme
        source: "qml/voiceover/goldberg.ogg"
        fadeInTime: 200
    }
}
