#include "controller.h"
#include <QGraphicsObject>
#include <QVariant>

Controller::Controller(QObject *parent) :
    QObject(parent)
{
}

void Controller::linkViews(QDeclarativeView *vmain, QDeclarativeView *vsecond)
{
    vMain = vmain;
    vSecond = vsecond;

    QObject *itemone = vmain->rootObject();
    QObject *itemscnd = vSecond->rootObject();

//    QObject::connect(itemone,SIGNAL(sentenceSelected(QString)),itemscnd,SLOT(showStr(QString)));
    QObject::connect(itemone,SIGNAL(sentenceSelected(QString)),this,SLOT(updateSentence(QString)));
    QObject::connect(itemone,SIGNAL(gameStarts()),itemscnd,SLOT(startGame()));

}

void Controller::updateSentence(QString newSentence)
{
//    emit showSentence(vMain->rootContext()->);
    vSecond->rootObject()->setProperty("stringToShow", newSentence);
}
