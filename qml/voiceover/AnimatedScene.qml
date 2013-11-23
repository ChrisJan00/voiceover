import QtQuick 1.1
import "strpool.js" as StrPool

Rectangle {
    id:animatedScene
    property int cellW: width/15
    property int baseW: width

    color: StrPool.getColor(7);

    property bool moveFriends: false
    property bool done:false

    function start() {
        mainAnim.start()
    }

    Component.onCompleted: {
        for (var xx=0; xx<15;xx++) {
            otherBoxesMdl.append({"origX":xx*cellW,"origY":0,
                                     "destX":2*cellW + Math.random()*cellW*11,
                                     "destY":cellW+Math.random()*cellW*2});
            otherBoxesMdl.append({"origX":xx*cellW,"origY":14*cellW,
                                     "destX":2*cellW + Math.random()*cellW*11,
                                     "destY":13*cellW-Math.random()*cellW*2});
            if (xx!= 0 && xx!=14) {
            otherBoxesMdl.append({"origX":0,"origY":xx*cellW,
                                     "destY":2*cellW + Math.random()*cellW*11,
                                     "destX":cellW+Math.random()*cellW*2});
            otherBoxesMdl.append({"origX":14*cellW,"origY":xx*cellW,
                                     "destY":2*cellW + Math.random()*cellW*11,
                                     "destX":13*cellW-Math.random()*cellW*2});
            }
        }
    }


    Rectangle {
        id: protag
        color: StrPool.getColor(3);
        width: cellW
        height: cellW
        x: cellW*3
        y: cellW*2
    }

    Rectangle {
        id: friend
        opacity: 0
        color: StrPool.getColor(4);
        width: cellW
        height: cellW
        x: cellW*12
        y: cellW*7
    }

    ListModel {
       id: otherBoxesMdl
    }

    Repeater {
        id: otherBoxesView
        model: otherBoxesMdl
        property real myopacity: 0
        delegate: Rectangle {
            id: otherbox
            color: StrPool.getColor(1);
            width: cellW; height: cellW;
            opacity: otherBoxesView.myopacity
            x: origX
            y: origY
            ParallelAnimation {
                property bool doit: animatedScene.moveFriends
                onDoitChanged: if (doit) start();
                PropertyAnimation { target:otherbox; properties:"x"; to:destX; duration:2500 }
                PropertyAnimation { target:otherbox; properties:"y"; to:destY; duration:2500 }
            }
        }
    }

        Text {
            id:endText
            font.family: scrog.name
            font.pixelSize: 48
            anchors.centerIn: parent
            color: StrPool.getColor(-1);
            text: "The end."
            opacity: 0
        }



    SequentialAnimation {
        id: mainAnim
        ParallelAnimation {
            PropertyAnimation { target:protag; properties:"x"; to:cellW*7; duration:1500 }
            PropertyAnimation { target:protag; properties:"y"; to:cellW*7; duration:1500 }
        }
        PauseAnimation { duration: 2000 }
        PropertyAnimation { target: otherBoxesView; properties:"myopacity"; from:"0"; to:"1"; duration:1500}
        PauseAnimation { duration: 500 }
        ScriptAction { script: animatedScene.moveFriends = true; }
        PauseAnimation { duration: 4500 }
        ParallelAnimation {
            PropertyAnimation { target:protag; properties:"scale"; to:10; duration:5000 }
            SequentialAnimation {
                PropertyAnimation { target: otherBoxesView; properties:"myopacity"; from:"1"; to:"0"; duration:1000}
                PauseAnimation { duration: 1000 }
                ColorAnimation { target: protag; properties:"color"; from: StrPool.getColor(3); to: StrPool.getColor(5); duration: 1500 }
            }
        }
        PauseAnimation { duration: 2000 }
        ParallelAnimation {
            PropertyAnimation { target:protag; properties:"scale"; to:1; duration:4000 }
            PropertyAnimation { target:protag; properties:"x"; to: cellW*3; duration: 4000 }
            PropertyAnimation { target:friend; properties: "opacity"; to: 1; duration: 4000 }
        }
        PauseAnimation { duration: 5000 }
        ParallelAnimation {
            PropertyAnimation { target:protag; properties:"x"; to: cellW*7; duration: 2000 }
            PropertyAnimation { target:friend; properties: "x"; to: cellW*8; duration: 2000 }
            SequentialAnimation {
                PauseAnimation { duration: 1700 }
                ParallelAnimation {
                    PropertyAnimation { target:protag; properties:"opacity"; to: 0; duration: 300 }
                    PropertyAnimation { target:friend; properties: "opacity"; to: 0; duration: 300 }
                }
            }
        }

//        PauseAnimation { duration: 2000 }
//        PropertyAnimation { target: otherBoxesView; properties:"myopacity"; from:"0"; to:"1"; duration:400}
//        PropertyAnimation { target: otherBoxesView; properties:"myopacity"; from:"1"; to:"0"; duration:4000}
        PauseAnimation { duration: 4000 }
        ScriptAction { script: animatedScene.done=true; }
        PropertyAnimation { target: endText; properties:"opacity"; from:"0"; to:"1"; duration:1000 }
    }
}
