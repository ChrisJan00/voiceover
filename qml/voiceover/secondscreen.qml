import QtQuick 1.1

Rectangle {
    width: 400
    height: 300
    property string stringToShow: ""

    AnimatedScene {

    }

    Text {
        id: txt
//        text: qsTr("Second")
        text: stringToShow
        anchors.centerIn: parent
    }

//    function onShowStr(str) {
//        txt.text = str;
//    }

}
