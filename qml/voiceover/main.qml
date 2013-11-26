import QtQuick 1.1
import "strpool.js" as StrPool

// TODO:
// countdown at start to give player time for reaction
// text alignment/spacing in the selection
// If possible only single-sentence texts
// rewrite text / fit better into anim

Rectangle {
    id: rootMain
    width: 800
    height: 600
    color: StrPool.getColor(7);

    property bool replayAvailable: false;
    property bool isReplaying: false;
    property bool canClick: false;

    signal sentenceSelected(string str)
    signal gameStarts
    signal interruptRecord

    function startGame() {
        isReplaying = false;
        overlay.visible = false;
        animDone = false;
        StrPool.restart();
        StrPool.startRecording();
        gameStarts(); // emit signal
        animscene.start();
        clickDelay.start();
        canClick = false;
    }

    property alias animDone: animscene.done
    onAnimDoneChanged: {
        if (animDone) {
            replayAvailable = true;
            overlay.visible = true;
        }
    }

    function replay() {
        animscene.reset();
        isReplaying = true;
        overlay.visible = false;
        gameStarts();
        startDelay.start();
        replayTimer.begin();
    }

    function stopReplay() {
        interruptRecord();
        animscene.stop();
        isReplaying = false;
        replayTimer.stop();
        overlay.visible = true;

    }

    Timer {
        id: clickDelay
        running: false
        repeat: false
        interval: 3000
        onTriggered: {
            canClick = true;
        }
    }

    Timer {
        id: replayTimer
        running: false
        repeat: true
        triggeredOnStart: true
        interval: 0
        property string lastSentence : "";
        function begin() {
            stop();
            interval = 0;
            StrPool.restart();
            lastSentence = "";
            restart();
        }
        onTriggered: {
            rootMain.sentenceSelected(lastSentence);
            var nextSentencePack = StrPool.getNextSentence();
            if (nextSentencePack == -1) {
                stop();
            } else {
                interval = nextSentencePack[1];
                lastSentence = nextSentencePack[0]
            }
        }
    }

    FontLoader { id: scrog; source: "Scrogglet.ttf"; name:"scrogglet" }

    AnimatedScene {
        id: animscene
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 10
        width: 250
        height: 250
        showcountdown: true
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
        visible: !animscene.aboutToFinish
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
                enabled: canClick
                onClicked: {
                    if (name != "SKIP") {
                        rootMain.sentenceSelected(name);
                        StrPool.recordSentence(name);
                    }
                    StrPool.clicked(opt);
                }
            }
        }
    }

    Rectangle {
        id: replayOverlay
        anchors.fill: parent
        color: StrPool.getColor(7);
        enabled: visible
        visible: isReplaying
        Column {
            anchors.centerIn: parent
            Text {
                anchors.horizontalCenter: parent.horizontalCenter
                font.family: scrog.name
                font.pixelSize: 48
                horizontalAlignment:  Text.AlignHCenter
                color: StrPool.getColor(-1);
                text: "Stop replay"

            }
        }
            MouseArea {
                anchors.fill:parent
                onClicked: {
                    rootMain.stopReplay();
                }
            }
    }


    // Start
     Rectangle {
         id: overlay
         anchors.fill: parent
         color: StrPool.getColor(7);
         enabled: visible
         MouseArea {
             anchors.fill:parent
             onClicked: {
                 // eat all the clicks
             }
         }
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
                 text: "Replay recording"

                 MouseArea {
                     anchors.fill:parent
                     onClicked: {
                         rootMain.replay();
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
