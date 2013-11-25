#include "secondview.h"

#include <QDeclarativeEngine>

SecondView::SecondView(QWidget *parent) :
    QDeclarativeView(parent)
{
    connect(engine(), SIGNAL(quit()), this, SLOT(close()));
    setResizeMode(QDeclarativeView::SizeRootObjectToView);
}

SecondView::~SecondView()
{
}

void SecondView::closeEvent(QCloseEvent *)
{
    emit winClosed();
}
