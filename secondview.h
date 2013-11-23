#ifndef SECONDVIEW_H
#define SECONDVIEW_H

#include <QDeclarativeView>

class SecondView : public QDeclarativeView
{
    Q_OBJECT
public:
    explicit SecondView(QWidget *parent = 0);
    virtual ~SecondView();


    
signals:
    
public slots:
    
};

#endif // SECONDVIEW_H
