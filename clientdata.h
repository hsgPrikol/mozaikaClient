#ifndef CLIENTDATA_H
#define CLIENTDATA_H

#include <QObject>
#include <Client/super_server/userdialog.h>
#include <algorithm>
#include "Client/protocoltrade.h"

class ClientData : public QObject
{
    Q_OBJECT
public:
    explicit ClientData(QObject *parent = nullptr);

    QVector<UserDialog> dialogs;

//<<<<<<< HEAD
    User *user;
//=======
//    QString myLogin;
//    QString getMyLogin() const;
//    void setMyLogin(const QString &value);
//>>>>>>> origin/back

public slots:



    QVector<UserDialog> getDialogs();
    void setDialogs( QVector<UserDialog> value);
    void sortDialog(int index);

    UserDialog* getDialogFromId(int id);
    int getCountDialogs() {return dialogs.count();}
    int getCountMembers(int index);
    QString getNameDialog(int index){return dialogs[index].getName();}
    int getIdDialog(int index){return dialogs[index].getID();}
    QString getPathAvatar(int index){return dialogs[index].getAvatarPath();}

    QString getTextLastMessage(int index);

    QString getDateLastMessage(int index);
    bool getIsCheckedLastMessage(int index);
    bool getDialogIsGroup(int index);
    int getDialogCountUnChecked(int index);
    bool getDialogIsOnline(int index);
    //    QVector<UserDialog> SortBy(QVector<UserDialog> arr);
    //    bool greater(UserDialog a, UserDialog b);

    QString getLastActiveDateTime(QDateTime date);

//<<<<<<< HEAD
    QString getIdDialogString(int index);

    void AddMessage(QString idDialog, QString idMessage, QString message, QVector<QString> paths);
    void UpdateMessageId(QString idDialog, QString tmpIdMessage, QString idMessage, QString statusMessage);
//    QString getNameDialog(int index){return dialogs[index].();}
//=======
    int getCountMessages(int index);
    QString getTextMessage(int d_index, int m_index);
    int getSizeTextMessage(int d_index, int m_index){return getTextMessage(d_index,m_index).length();}
    QString getDateMessage(int d_index, int m_index);
    int getStatusMessage(int d_index, int m_index);
    bool getIsSenderMessage(int d_index, int m_index);



    //    QString getNameDialog(int index){return dialogs[index].();}
//>>>>>>> origin/back
signals:

};

#endif // CLIENTDATA_H
