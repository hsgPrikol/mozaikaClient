#ifndef USERDIALOG_H
#define USERDIALOG_H

#include <QVector>
#include <QString>
#include "message.h"
#include "user.h"
//#include "servercontroller.h"

class UserDialog
{
private:
    int dialog_id;
    QString name;
    QByteArray avatar;
    QVector<User> members;
    QVector<Message> messages;
public:
    UserDialog(int _dialog_id, QString _name="", QByteArray _avatar = nullptr): dialog_id(_dialog_id), name(_name), avatar(_avatar) {}
    UserDialog(QString _name="", QByteArray _avatar = nullptr): UserDialog(-1, _name, _avatar) {}

    void addMessage(Message msg);
    UserDialog(){};
    QVector<Message> getMessages() {return messages;}
    Message getLastMessage();
    int addMember(User user);
    QString getName() {return name;}
    QByteArray getAvatar() {return avatar;}
    QVector<int> getMemberIDs();
    QVector<QString> getMemberLogins();
    void setID(int id) {dialog_id = id;}
    int getID() {return dialog_id;}
};

#endif // USERDIALOG_H
