import QtQuick 1.1

Rectangle {
    id: rootMain
    width: 360
    height: 360

    signal sentenceSelected(string str)


//    Text {
//        text: qsTr("First")
//        anchors.centerIn: parent
//    }
//    MouseArea {
//        anchors.fill: parent
//        onClicked: {
//            Qt.quit();
//        }
//    }

    ListModel {
        id: strmdl
        ListElement {
            name: "testing123"
        }
        ListElement {
            name: "testing456"
        }
        ListElement {
            name: "testing789"
        }
    }


    ListView {
        id: strview
        model: strmdl
        anchors.fill: parent
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
//                    rootMain.currentString = name;
                    rootMain.sentenceSelected(name);
                }
            }
        }
    }
}
