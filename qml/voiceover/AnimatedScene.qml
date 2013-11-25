import QtQuick 1.1
import "strpool.js" as StrPool

Rectangle {
    id:animatedScene
    property int cellW: width/15
    property int baseW: width

    color: StrPool.getColor(7);

    property bool moveFriends: false
    property bool done:false
    property bool aboutToFinish: false

    function start() {
        mainAnim.start()
        timecount.start()
    }

    property string mytime:"0:0"
    property int scnds:0
    Timer {
        id: timecount
        running: false
        repeat: true
        interval: 1000
        onTriggered: {
            scnds++;
            mytime = Math.floor(scnds/60)+":"+(scnds%60)
        }
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
            property bool resetTrigger: !animatedScene.moveFriends
            onResetTriggerChanged: if (resetTrigger) {
                                       x = origX;
                                       y = origY;
                                   }
            ParallelAnimation {
                property bool doit: animatedScene.moveFriends
                onDoitChanged: if (doit) start();
                PropertyAnimation { target:otherbox; properties:"x"; to:destX; duration:3500 }
                PropertyAnimation { target:otherbox; properties:"y"; to:destY; duration:3500 }
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
        ScriptAction {
            script: {
                protag.opacity = 1;
                protag.color = StrPool.getColor(3);
                protag.x = cellW*3;
                protag.y = cellW*2;
                friend.opacity = 0;
                friend.x = cellW*12;
                friend.y = cellW*7;
                moveFriends = false;
                done = false;
                aboutToFinish = false;
            }
        }
        PauseAnimation { duration: 1200 }
        ParallelAnimation {
            PropertyAnimation { target:protag; properties:"x"; to:cellW*7; duration:2500 }
            PropertyAnimation { target:protag; properties:"y"; to:cellW*7; duration:2500 }
        }
        PauseAnimation { duration: 4000 }
        PropertyAnimation { target: otherBoxesView; properties:"myopacity"; from:"0"; to:"1"; duration:3500}
        PauseAnimation { duration: 2500 }
        ScriptAction { script: animatedScene.moveFriends = true; }
        PauseAnimation { duration: 6000 }
        ParallelAnimation {
            PropertyAnimation { target:protag; properties:"scale"; to:10; duration:8000 }
            SequentialAnimation {
                PropertyAnimation { target: otherBoxesView; properties:"myopacity"; from:"1"; to:"0"; duration:3000}
                PauseAnimation { duration: 3000 }
                ColorAnimation { target: protag; properties:"color"; from: StrPool.getColor(3); to: StrPool.getColor(5); duration: 2000 }
            }
        }
        PauseAnimation { duration: 5000 }
        ParallelAnimation {
            PropertyAnimation { target:protag; properties:"scale"; to:1; duration:5000 }
            PropertyAnimation { target:protag; properties:"x"; to: cellW*3; duration: 5000 }
            PropertyAnimation { target:friend; properties: "opacity"; to: 1; duration: 5000 }
        }
        PauseAnimation { duration: 3000 }
        ParallelAnimation {
            PropertyAnimation { target:protag; properties:"y"; to: cellW*10; duration: 2500 }
            PropertyAnimation { target:friend; properties: "y"; to: cellW*3; duration: 2500 }
        }
        ParallelAnimation {
            PropertyAnimation { target:protag; properties:"x"; to: cellW*12; duration: 2500 }
            PropertyAnimation { target:friend; properties: "x"; to: cellW*3; duration: 2500 }
        }
        ParallelAnimation {
            PropertyAnimation { target:protag; properties:"y"; to: cellW*7; duration: 2500 }
            PropertyAnimation { target:friend; properties: "y"; to: cellW*7; duration: 2500 }
        }

        PauseAnimation { duration: 3000 }



        ParallelAnimation {
            PropertyAnimation { target:protag; properties:"x"; to: cellW*8; duration: 4000 }
            PropertyAnimation { target:friend; properties: "x"; to: cellW*7; duration: 4000 }
            SequentialAnimation {
                PauseAnimation { duration: 3600 }
                ParallelAnimation {
                    PropertyAnimation { target:protag; properties:"opacity"; to: 0; duration: 400 }
                    PropertyAnimation { target:friend; properties: "opacity"; to: 0; duration: 400 }
                }
            }
        }

//        PauseAnimation { duration: 2000 }
//        PropertyAnimation { target: otherBoxesView; properties:"myopacity"; from:"0"; to:"1"; duration:400}
//        PropertyAnimation { target: otherBoxesView; properties:"myopacity"; from:"1"; to:"0"; duration:4000}
        PauseAnimation { duration: 3000 }
        ScriptAction { script: animatedScene.aboutToFinish=true; }
        PropertyAnimation { target: endText; properties:"opacity"; from:"0"; to:"1"; duration:1000 }
        PauseAnimation { duration: 2500 }
        PropertyAnimation { target: endText; properties:"opacity"; from:"1"; to:"0"; duration:2000 }
        ScriptAction { script: animatedScene.done=true; }

    }

//    Text {
//        text: mytime
//    }
}
