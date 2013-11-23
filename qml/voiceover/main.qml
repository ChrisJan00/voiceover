import QtQuick 1.1
import "strpool.js" as StrPool

Rectangle {
    id: rootMain
    width: 800
    height: 600
    color: StrPool.getColor(7);

    signal sentenceSelected(string str)
    signal gameStarts
    function startGame() {
        startDelay.restart();
    }

    Timer {
        id: startDelay
        running: false
        interval: 1000
        repeat: false
        onTriggered: animscene.start();
    }


    FontLoader { id: scrog; source: "Scrogglet.ttf"; name:"scrogglet" }

    AnimatedScene {
        id: animscene
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 20
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
         Text {
             anchors.centerIn: parent
             font.family: scrog.name
             font.pixelSize: 48
             horizontalAlignment:  Text.AlignHCenter
             color: StrPool.getColor(-1);
             text: "Click here to start"
         }
         MouseArea {
             anchors.fill:parent
             onClicked: {
                 overlay.enabled = false;
                 overlay.visible = false;
                 rootMain.gameStarts();
                 rootMain.startGame();
             }
         }
     }
}
