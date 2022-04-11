#ifndef USERDIALOG_H
#define USERDIALOG_H

#include <QVector>
#include <QString>
#include "message.h"
#include "user.h"
#include "myvector.h"
//#include "servercontroller.h"

class UserDialog
{

private:
    int dialog_id;
    QString name;
    QByteArray avatar;
    QString avatarPath;
    QVector<QString> members;
    QVector<Message> messages;
public:// очень важный комментарий

    UserDialog(int _dialog_id, QString _name="", QByteArray _avatar = nullptr, QString _avatarPath=""): dialog_id(_dialog_id), name(_name), avatar(_avatar), avatarPath(_avatarPath) {}
    UserDialog(QString _name="", QByteArray _avatar = nullptr): UserDialog(-1, _name, _avatar) {}

//    UserDialog(UserDialog& userdialog): dialog_id(userdialog.dialog_id), name(userdialog.name), avatar(userdialog.avatar), members(userdialog.members), messages(userdialog.messages) {};
//    UserDialog(){};

//    friend bool operator==(const UserDialog& userd1, const UserDialog& userd2) { return userd1.dialog_id == userd2.dialog_id; }


//    const UserDialog operator =(UserDialog d) const{
//        UserDialog d2(d);
//        return d2;
//    }

    void addMessage(Message msg);
//    UserDialog(){};
    QVector<Message> getMessages() {return messages;}
    Message getLastMessage();
    int addMember(User* user);
    QString getName() {return name;}
    QByteArray getAvatar() {return avatar;}
    QString getAvatarPath() {return avatarPath;}
//    QVector<int> getMemberIDs();
    QVector<QString> getMemberLogins();
    void setID(int id) {dialog_id = id;}
    int getID() {return dialog_id;}

    bool operator<(const UserDialog& d1) const;
    bool operator>(const UserDialog& d1) const;
};

#endif // USERDIALOG_H
