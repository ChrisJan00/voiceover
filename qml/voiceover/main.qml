import QtQuick 1.1
import "strpool.js" as StrPool

Rectangle {
    id: rootMain
    width: 800
    height: 600
    color: StrPool.getColor(7);

    property bool replayAvailable: false

    signal sentenceSelected(string str)
    signal gameStarts
    function startGame() {
        overlay.visible = false;
        animDone = false;
        StrPool.restart();
        gameStarts(); // emit signal
        startDelay.restart();
        futurescene.startSkip();
    }

    Timer {
        id: startDelay
        running: false
        interval: 1000
        repeat: false
        onTriggered: {
            animscene.start();
        }
    }

    property alias animDone: animscene.done
    onAnimDoneChanged: {
        if (animDone) {
            overlay.visible = true;
        }
    }


    FontLoader { id: scrog; source: "Scrogglet.ttf"; name:"scrogglet" }

    Text {
        x: animscene.x
        width: animscene.width
        font.family: scrog.name
        font.pixelSize: 16
        horizontalAlignment:  Text.AlignHCenter
        color: StrPool.getColor(-1);
        text: "now"
    }

    AnimatedScene {
        id: animscene
        //anchors.horizontalCenter: parent.horizontalCenter
        x: 100
        anchors.top: parent.top
        anchors.topMargin: 30
        width: 250
        height: 250
    }

    Text {
        x: futurescene.x
        width: futurescene.width
        font.family: scrog.name
        font.pixelSize: 16
        horizontalAlignment:  Text.AlignHCenter
        color: StrPool.getColor(-1);
        text: "2 seconds ahead"
    }

    AnimatedScene {
        id: futurescene
        //anchors.horizontalCenter: parent.horizontalCenter
        x: 450
        anchors.top: parent.top
        anchors.topMargin: 30
        width: 250
        height: 250
    }

    ListModel {
        id: strmdl
    }

    Component.onCompleted: StrPool.restart();


    ListView {
        id: strview
        model: strmdl
        anchors.horizontalCenter: parent.horizontalCenter
        width: parent.width
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 20
        height: rootMain.height - animscene.height - 60
        visible: !animDone
        enabled: visible

        interactive:false
        delegate: Rectangle {
            color: "transparent"
//            border.color: "black"
//            border.width: 1
            height: 42
            width: parent.width
            Text {
                font.family: scrog.name
                font.pixelSize: 20
                anchors.centerIn: parent
                text: name
                color: StrPool.getColor(-1);
            }
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    if (name != "SKIP")
                        rootMain.sentenceSelected(name);
                    StrPool.clicked(opt);
                }
            }
        }
    }


    // Start
     Rectangle {
         id: overlay
         anchors.fill: parent
         color: StrPool.getColor(7);
         enabled: visible
         Column {
             anchors.centerIn: parent
             Text {
                 anchors.horizontalCenter: parent.horizontalCenter
                 font.family: scrog.name
                 font.pixelSize: 48
                 horizontalAlignment:  Text.AlignHCenter
                 color: StrPool.getColor(-1);
                 text: "New game"

                 MouseArea {
                     anchors.fill:parent
                     onClicked: {
                         rootMain.startGame();
                     }
                 }
             }
             Text {
                 visible: replayAvailable
                 anchors.horizontalCenter: parent.horizontalCenter
                 font.family: scrog.name
                 font.pixelSize: 48
                 horizontalAlignment:  Text.AlignHCenter
                 color: StrPool.getColor(-1);
                 text: "Replay last"

                 MouseArea {
                     anchors.fill:parent
                     onClicked: {
//                         Qt.quit();
                     }
                 }
             }
             Text {
                 anchors.horizontalCenter: parent.horizontalCenter
                 font.family: scrog.name
                 font.pixelSize: 48
                 horizontalAlignment:  Text.AlignHCenter
                 color: StrPool.getColor(-1);
                 text: "Exit"

                 MouseArea {
                     anchors.fill:parent
                     onClicked: {
                         Qt.quit();
                     }
                 }
             }
         }
     }
}
