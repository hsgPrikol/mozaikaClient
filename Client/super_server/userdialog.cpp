#include "userdialog.h"

int UserDialog::getCountUnChecked()
{
    return countUnChecked;
}

void UserDialog::setCountUnChecked(int value)
{
    countUnChecked = value;
}

bool UserDialog::getIsOnline()
{
    return isOnline;
}

void UserDialog::setIsOnline(bool value)
{
    isOnline = value;
}

void UserDialog::SortBy()
{
    for(int startIndex = 0; startIndex < messages.length()-1; ++startIndex){
        int smallestIndex = startIndex;
        for(int currIndex = startIndex+1; currIndex < messages.length(); ++currIndex){
            if(messages[currIndex]<messages[smallestIndex])
                smallestIndex = currIndex;
        }
        std::swap(messages[startIndex], messages[smallestIndex]);
    }

}

void UserDialog::addMessage(Message msg)
{
    messages.append(msg);
    //    messages.append(msg);
}

Message UserDialog::getLastMessage()
{
    if(messages.count()!=0)
        return messages.last();
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
