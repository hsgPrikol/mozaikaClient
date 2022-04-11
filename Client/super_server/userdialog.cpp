#include "userdialog.h"

void UserDialog::addMessage(Message msg)
{
    messages.append(msg);
//    messages.append(msg);
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
