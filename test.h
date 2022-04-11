#ifndef TEST_H
#define TEST_H

#include <QObject>
#include <QVector>
#include "massagetest.h"
#include "contactslist.h"

class Test : public QObject
{
    Q_OBJECT
public:
    explicit Test(QObject *parent = nullptr);

    QVector<MassageTest*> array;


public slots:

    QString getMassage(int index);
    bool getIsCheked(int index);
    int getSizeVector();

    int getSizeMessage(int index);

    void createNewMessage(QString message, bool status);

    void createNewDialog(QString login);

signals:
    void onCreateNewMassage();

    void onCreateNewDialog();

};

#endif // TEST_H
