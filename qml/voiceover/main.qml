import QtQuick 1.1
import "strpool.js" as StrPool

Rectangle {
    id: rootMain
    width: 800
    height: 600
    color: StrPool.getColor(7);

    signal sentenceSelected(string str)

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
}
