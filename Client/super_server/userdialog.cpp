#include "userdialog.h"

void UserDialog::addMessage(Message msg)
{
    messages.append(msg);
    //    messages.append(msg);
}

Message UserDialog::getLastMessage()
{
    if(messages.count()!=0)
        return messages.first();
}

int UserDialog::addMember(User *user)
{

    if (!members.contains(user->getLogin())) {
        members.append(user->getLogin());
        return 0;
    }
    return 1;
}

//QVector<int> UserDialog::getMemberIDs()
//{
//    return members;
//}

QVector<QString> UserDialog::getMemberLogins()
{
    return members;
}

bool UserDialog::operator<(const UserDialog &d1) const
{

    Message m1=messages.first();
    Message m2=d1.messages.first();

    return m1.getTime()<m2.getTime();
}

bool UserDialog::operator>(const UserDialog &d1) const
{

    Message m1=messages.first();
    Message m2=d1.messages.first();

    return m1.getTime()>m2.getTime();
}
