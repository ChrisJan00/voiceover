import QtQuick 1.1
import SDLMixerWrapper 1.0
import "strpool.js" as StrPool

Rectangle {
    width: 1000
    height: 600
    color: StrPool.getColor(7);
    property string stringToShow: ""

    function startGame() {
        startFadeAnim.start();
        mainTheme.play();
    }

    property alias animDone: animsc.done
    onAnimDoneChanged: if (animDone) {
        fadeoutAnim.start();
        mainTheme.fadeOut(1000);
    }


    AnimatedScene {
        id: animsc
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.topMargin: 10
        anchors.top: parent.top
        width: 500
        height: 500
    }

    FontLoader { id: scrog; source: "Scrogglet.ttf"; name:"scrogglet" }

    // Legend
    Text {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: animsc.bottom
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
            from: 1
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
            PropertyAnimation {
                target: overlay
                properties: "opacity"
                from: 1
                to: 0
                duration: 1000
            }
            ScriptAction {
                script: animsc.start();
            }
        }
        Column {
            anchors.centerIn: parent
            Text {
                font.family: scrog.name
                font.pixelSize: 48
                horizontalAlignment:  Text.AlignHCenter
                color: StrPool.getColor(-1);
                text: "Voice Over"
            }
            Text {
                font.family: scrog.name
                font.pixelSize: 24
                horizontalAlignment:  Text.AlignHCenter
                color: StrPool.getColor(-1);
                text: "by Christiaan Janssen"
            }
            Text {
                font.family: scrog.name
                font.pixelSize: 16
                horizontalAlignment:  Text.AlignHCenter
                color: StrPool.getColor(-1);
                text: "Berlin Mini Jam November 2013"
            }
        }
    }

    // sound
    MusicClip {
        id: mainTheme
        source: "qml/voiceover/goldberg.mp3"
        fadeInTime: 200
    }
}
