#include "user.h"

User::User(QObject *parent)  : QObject(parent)
{

}

//User User::operator=(const User &user)
//{

//    id=user.id;
//    login=user.login;
//    name=user.name;
//    birthdate=user.birthdate;
//    avatar=user.avatar;
//    avatarFile=user.avatarFile;

//    return *this;
//}

//User User::operator=(const User& user)
//{

//    id=user.id;
//    login=user.login;
//    name=user.name;
//    birthdate=user.birthdate;
//    avatar=user.avatar;
//    avatarFile=user.avatarFile;

//    return *this;
//}

//User User::operator=(User *user)
//{

//    id=user->id;
//    login=user->login;
//    name=user->name;
//    birthdate=user->birthdate;
//    avatar=user->avatar;
//    avatarFile=user->avatarFile;

//    return *this;
//}

QString User::getAvatarFile()
{
    return avatarFile;
}

int User::getID()
{
    return id;
}
