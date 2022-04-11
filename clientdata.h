#ifndef CLIENTDATA_H
#define CLIENTDATA_H

#include <QObject>
#include <Client/super_server/userdialog.h>
#include <algorithm>

class ClientData : public QObject
{
    Q_OBJECT
public:
    explicit ClientData(QObject *parent = nullptr);

    QVector<UserDialog> dialogs;


public slots:
    QVector<UserDialog> getDialogs();
    void setDialogs( QVector<UserDialog> value);

    int getCountDialogs() {return dialogs.count();}
    QString getNameDialog(int index){return dialogs[index].getName();}
    QString getPathAvatar(int index){return dialogs[index].getAvatarPath();}

    QString getTextLastMessage(int index);
    QString getDateLastMessage(int index);
//    QVector<UserDialog> SortBy(QVector<UserDialog> arr);
//    bool greater(UserDialog a, UserDialog b);

    QString getLastActiveDateTime(QDateTime date);
//    QString getNameDialog(int index){return dialogs[index].();}
signals:

};

#endif // CLIENTDATA_H
