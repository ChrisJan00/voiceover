import QtQuick 1.1
import "strpool.js" as StrPool

Rectangle {
    id: rootMain
    width: 400
    height: 300

    signal sentenceSelected(string str)

    AnimatedScene {

    }

    ListModel {
        id: strmdl
    }

    Component.onCompleted: StrPool.restart();


    ListView {
        id: strview
        model: strmdl
        anchors.fill: parent
        interactive:false
        delegate: Rectangle {
            color: "transparent"
            border.color: "black"
            border.width: 1
            height: 30
            width: parent.width
            Text {
                anchors.centerIn: parent
                text: name
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
