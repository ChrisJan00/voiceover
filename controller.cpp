#include "controller.h"

Controller::Controller(QObject *parent) :
    QObject(parent)
{
}

void Controller::linkViews(QDeclarativeView *vmain, QDeclarativeView *vsecond)
{
    vMain = vmain;
    vSecond = vsecond;
}
