#include "userdialog.h"

void UserDialog::addMessage(Message msg)
{
    messages.append(msg);
}

int UserDialog::addMember(User user)
{
    if (!members.contains(user)) {
        members.append(user);
        return 0;
    }
    return 1;
}

QVector<int> UserDialog::getMemberIDs()
{
    QVector<int> ids;
    for(int i=0;i<3;i++){
        ids.append(members[i].getID());
    }
    return ids;
}

QVector<QString> UserDialog::getMemberLogins()
{
    QVector<QString> logins;
    for(int i=0;i<3;i++){
        logins.append(members[i].getLogin());
    }

    return logins;
}
