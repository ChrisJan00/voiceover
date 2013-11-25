#include "controller.h"
#include <QGraphicsObject>
#include <QVariant>

Controller::Controller(QObject *parent) :
    QObject(parent)
{
}

void Controller::linkViews(SecondView *vmain, SecondView *vsecond)
{
    vMain = vmain;
    vSecond = vsecond;
    secondIsOpen = vsecond->isVisible();

    QObject *itemone = vmain->rootObject();
    QObject *itemscnd = vSecond->rootObject();

//    QObject::connect(itemone,SIGNAL(sentenceSelected(QString)),itemscnd,SLOT(showStr(QString)));
    QObject::connect(itemone,SIGNAL(sentenceSelected(QString)),this,SLOT(updateSentence(QString)));
    QObject::connect(itemone,SIGNAL(gameStarts()),itemscnd,SLOT(startGame()));
    QObject::connect(vMain,SIGNAL(winClosed()),this,SLOT(mainClosed()));
    QObject::connect(vSecond,SIGNAL(winClosed()),this,SLOT(secondClosed()));
    QObject::connect(itemone,SIGNAL(gameStarts()),this,SLOT(startGame()));
    QObject::connect(itemone,SIGNAL(interruptRecord()),itemscnd,SLOT(interruptPlay()));

}

void Controller::updateSentence(QString newSentence)
{
//    emit showSentence(vMain->rootContext()->);
    vSecond->rootObject()->setProperty("stringToShow", newSentence);
}

void Controller::startGame()
{
    if (!secondIsOpen) {
        vSecond->show();
        linkViews(vMain, vSecond);
    }
}

void Controller::mainClosed()
{
    if (secondIsOpen) {
        vSecond->close();
    }
}

void Controller::secondClosed()
{
    secondIsOpen = false;
}
