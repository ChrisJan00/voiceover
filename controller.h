#ifndef CONTROLLER_H
#define CONTROLLER_H

#include <QObject>
#include <QDeclarativeView>
#include <QString>
#include "secondview.h"

class Controller : public QObject
{
    Q_OBJECT
public:
    explicit Controller(QObject *parent = 0);

    void linkViews(SecondView *vmain, SecondView *vsecond);
    
signals:
//    void showSentence(QVariant);
public slots:
    void updateSentence(QString newSentence);
    void startGame();
    void mainClosed();
    void secondClosed();

protected:
    SecondView *vMain, *vSecond;
    bool secondIsOpen;
};

#endif // CONTROLLER_H
