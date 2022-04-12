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

    QString myLogin;
    QString getMyLogin() const;
    void setMyLogin(const QString &value);

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

    int getCountMessages(int index);
    QString getTextMessage(int d_index, int m_index);
    int getSizeTextMessage(int d_index, int m_index){return getTextMessage(d_index,m_index).length();}
    QString getDateMessage(int d_index, int m_index);
    int getStatusMessage(int d_index, int m_index);
    bool getIsSenderMessage(int d_index, int m_index);



    //    QString getNameDialog(int index){return dialogs[index].();}
signals:

};

#endif // CLIENTDATA_H
