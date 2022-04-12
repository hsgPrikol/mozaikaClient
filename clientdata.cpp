#include "clientdata.h"

ClientData::ClientData(QObject *parent) : QObject(parent)
{

}

QVector<UserDialog> ClientData::getDialogs()
{
    return dialogs;
}

QVector<UserDialog> SortBy(QVector<UserDialog> arr){
    for(int startIndex = 0; startIndex < arr.length()-1; ++startIndex){
        int smallestIndex = startIndex;
        for(int currIndex = startIndex+1; currIndex < arr.length(); ++currIndex){
            if(arr[currIndex]>arr[smallestIndex])
                smallestIndex = currIndex;
        }
        std::swap(arr[startIndex], arr[smallestIndex]);
    }

    return arr;
}

void ClientData::setDialogs(QVector<UserDialog> value)
{

    this->dialogs=SortBy(value);
}


QString ClientData::getTextLastMessage(int index)
{
    if(dialogs.count()<=index) return "";
    Message msg=dialogs[index].getLastMessage();
    return msg.getMessage_data();
}

QString ClientData::getDateLastMessage(int index)
{
    if(dialogs.count()<=index) return "";
    Message msg=dialogs[index].getLastMessage();

    return getLastActiveDateTime(msg.getTime());
}

bool ClientData::getIsCheckedLastMessage(int index)
{
    if(dialogs.count()<=index) return false;
    Message msg=dialogs[index].getLastMessage();

    return msg.getStatus()==3;
}

bool ClientData::getDialogIsGroup(int index)
{
    if(dialogs.count()<=index) return false;

    return dialogs[index].getIsGroup();
}

int ClientData::getDialogCountUnChecked(int index)
{
    if(dialogs.count()<=index) return false;

    return dialogs[index].getCountUnChecked();
}

bool ClientData::getDialogIsOnline(int index)
{
    if(dialogs.count()<=index) return false;

    return dialogs[index].getIsOnline();
}

QString ClientData::getLastActiveDateTime(QDateTime date)
{
    QDateTime current=QDateTime::currentDateTime();
    double sec= date.secsTo(current);
    double mins = sec/60;
    double hours= mins/60;
    double days = hours/24;
    double mounth = days/30;
    double years = mounth/12;

    QString str;
    if(mins<=1){
        str = "Несколько секунд назад";
    }
    else if(mins <=20){
        int ddd=qRound(mins);
    str = QString::number(ddd)+ " минут назад";
    }

    else if(hours <= 1.5)
        str = "Час назад";
    else if(days <= 1 && current.date()==date.date())
        str = date.time().toString();
    else
        str = date.toString();

    return str;
}


