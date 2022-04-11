#ifndef CONTACTSLIST_H
#define CONTACTSLIST_H

#include <QObject>
#include <QMap>
#include <QVector>
#include <QDebug>
#include <QList>
#include "whynot.h"

class ContactsList : public QObject
{
    Q_OBJECT
public:
    explicit ContactsList(QObject *parent = nullptr);

    QMap<QString, QVector<QString>> map;
    QList<QString> list;

    int countIndexMessage;

    QVector<int> sds = {1,2,3,4};

    WhyNot why;


public slots:

    WhyNot gett()
    {
        return why;
    }

    QVector<int> getSds(){
        return sds;
    }
    void setMulti(QString symbol, QVector<QString> tmp);

    QString getSymbol(int index);

    QString getName(QString str, int index);

    int getMapSize();

    int getVectorSize(int index);

    int getAllVectorSize();


    int getCountIndexMessage();
    void setCountIndexMessage(int value);



signals:

};

#endif // CONTACTSLIST_H
