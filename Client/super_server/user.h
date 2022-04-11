#ifndef USER_H
#define USER_H

#include <QObject>
#include <QString>
#include "myfile.h"
#include <QVector>
#include <QDate>

class User : public QObject
{
    Q_OBJECT
private:
    int id;
    QString login;
    QString name;
    QString birthdate;
    QByteArray avatar;
    QString avatarFile;

public:
    explicit User(QObject *parent = nullptr);
    User(User& user): id(user.id), login(user.login), name(user.name), avatar(user.avatar), birthdate(user.birthdate) {};
    User(int _id, QString _login, QString _name, QByteArray _avatar, QString _birthdate): id(_id), login(_login), name(_name), avatar(_avatar), birthdate(_birthdate){}

//    User& operator=(User user);
//    User& operator=(User &user);
//    User operator =(const User &user);
    User& operator =(const User user){

        id=user.id;
        login=user.login;
        name=user.name;
        birthdate=user.birthdate;
        avatar=user.avatar;
        avatarFile=user.avatarFile;
    User user2;
        return user2;
    }

//    User operator =(const User user) const{

////        id=user.id;
////        login=user.login;
////        name=user.name;
////        birthdate=user.birthdate;
////        avatar=user.avatar;
////        avatarFile=user.avatarFile;
//    User user2;
//        return user2;
//    }
//    User& operator =(User &user) const{

////        id=user.id;
////        login=user.login;
////        name=user.name;
////        birthdate=user.birthdate;
////        avatar=user.avatar;
////        avatarFile=user.avatarFile;
//    User user2;
//        return user2;
//    }
//    User& operator =(User &user){

//        id=user.id;
//        login=user.login;
//        name=user.name;
//        birthdate=user.birthdate;
//        avatar=user.avatar;
//        avatarFile=user.avatarFile;
//    User user2;
//        return user2;
//    }
//    User operator =(User *user);
//    User operator =(User &user);

public slots:
    int getID();
    QString getName(){return name;}
    QByteArray getAvatar(){return avatar;}
    QString getBirthDate(){return birthdate;}
    QString getLogin() {return login;}

    QString getAvatarFile();

    int setID(int value) {id = value; }
    QString setName(QString str){name = str; }
    QByteArray setAvatar(QByteArray tmp){avatar = tmp; }
    QString setAvatarFile(QString tmp){avatarFile = tmp; }
    QString setBirthDate(QString date){birthdate = date; }
    QString setLogin(QString tmp) {login = tmp; }



    friend bool operator==(const User& user1, const User& user2) { return user1.login == user2.login; }
};


#endif // USER_H
