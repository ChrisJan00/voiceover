import QtQuick 1.1
import "strpool.js" as StrPool

Rectangle {
    width: 1000
    height: 600
    color: StrPool.getColor(7);
    property string stringToShow: ""

    AnimatedScene {
        id: animsc
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.topMargin: 10
        anchors.top: parent.top
        width: 500
        height: 500
    }

    FontLoader { id: scrog; source: "Scrogglet.ttf"; name:"scrogglet" }

    Text {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: animsc.bottom
        anchors.topMargin: 10

        id: txt
        font.family: scrog.name
        font.pixelSize: 28
        color: StrPool.getColor(-1);
//        text: qsTr("Second")
        text: stringToShow
    }

//    function onShowStr(str) {
//        txt.text = str;
//    }

}
