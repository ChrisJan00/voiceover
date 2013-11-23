import QtQuick 1.1

Rectangle {
    width: 300
    height: 362
    property string stringToShow: ""
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
