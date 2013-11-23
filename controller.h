#ifndef CONTROLLER_H
#define CONTROLLER_H

#include <QObject>
#include <QDeclarativeView>
#include <QString>

class Controller : public QObject
{
    Q_OBJECT
public:
    explicit Controller(QObject *parent = 0);

    void linkViews(QDeclarativeView *vmain, QDeclarativeView *vsecond);
    
signals:
//    void showSentence(QVariant);
public slots:
    void updateSentence(QString newSentence);

protected:
    QDeclarativeView *vMain, *vSecond;
};

#endif // CONTROLLER_H
