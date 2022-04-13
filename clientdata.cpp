#include "clientdata.h"

ClientData::ClientData(QObject *parent) : QObject(parent)
{
}

void ClientData::addContact(User *user)
{
    for(int i=0;i< contacts.length();i++){
        if(contacts[i].login==user->getLogin())
            return;
    }

    contacts.append(UserData(user->getLogin(),user->getName(),user->getBirthDate(), user->getAvatarFile()));
}

QString ClientData::getNameContact(QString login)
{
    for(int i=0;i< contacts.length();i++){
        if(contacts[i].login==login)
            return contacts[i].name;
    }
    return "No contacts";
}

QString ClientData::getAvatarPathContact(QString login)
{
    for(int i=0;i< contacts.length();i++){
        if(contacts[i].login==login)
            return contacts[i].avatarFile;
    }
    return "";
}

QString ClientData::getAvatarPathContact(int d_index, int m_index)
{
    return getAvatarPathContact(dialogs[d_index].messages[m_index].getSender_login());
}

QString ClientData::getBirthDateContact(QString login)
{
    for(int i=0;i< contacts.length();i++){
        if(contacts[i].login==login)
            return contacts[i].avatarFile;
    }
    return "No contacts";
}

QVector<UserDialog> ClientData::getDialogs()
{
    return dialogs;
}

void ClientData::sortDialogs(){
    for(int startIndex = 0; startIndex < dialogs.length()-1; ++startIndex){
        int smallestIndex = startIndex;
        for(int currIndex = startIndex+1; currIndex < dialogs.length(); ++currIndex){
//            if(dialogs[currIndex].messages[dialogs[currIndex].messages.size() - 1]>dialogs[smallestIndex].messages[dialogs[smallestIndex].messages.size() - 1])
            if(dialogs[currIndex]>dialogs[smallestIndex])
                smallestIndex = currIndex;
        }
        dialogs.swapItemsAt(startIndex, smallestIndex);
//        std::swap(dialogs[startIndex], dialogs[smallestIndex]);
    }
}

//void ClientData::sortDialogs(){
//    for(int startIndex = 0; startIndex < dialogs.length()-1; ++startIndex){
//        int smallestIndex = startIndex;
//        for(int currIndex = startIndex+1; currIndex < dialogs.length(); ++currIndex){
//            if(dialogs[currIndex].>dialogs[smallestIndex])
//                smallestIndex = currIndex;
//        }
//        std::swap(dialogs[startIndex], dialogs[smallestIndex]);
//    }
//}

QVector<Message> SortBy(QVector<Message> arr){
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

    this->dialogs=value;
    sortDialogs();
}

void ClientData::sortDialog(int index)
{
    QVector<Message> mess=SortBy(dialogs[index].getMessages());
    QVector<Message> mess2=SortBy(mess);

    dialogs[index].setMessages(mess2);
}

UserDialog *ClientData::getDialogFromId(int id)
{
    for(int i=0;i<dialogs.count();i++){
        if(dialogs[i].getID()==id)
            return &dialogs[i];
    }

    return nullptr;
}

int ClientData::getCountMembers(int index)
{
    if(dialogs.count()<=index) return -1;
    Message msg=dialogs[index].getLastMessage();
    return dialogs[index].getMemberLogins().count();
}


QString ClientData::getTextLastMessage(int index)
{
    if(dialogs.count()<=index) return "";
    Message msg=dialogs[index].getLastMessage();
    QString text;
    bool isGroup = dialogs[index].getIsGroup();
    if(msg.getSender_login() == user->getLogin())
        text = "Вы: " + msg.getMessage_data();
    else if (isGroup)
        text = getNameContact(msg.getSender_login()) + ": " + msg.getMessage_data();
    else
        text = msg.getMessage_data();
    return text;
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
        str = "Только что";
    }
    else if(mins <=30){
        int ddd=qRound(mins);
        str = QString::number(ddd)+ " минут назад";
    }
    else if(hours <= 1.5)
        str = "Час назад";
    else if(days <= 1 && current.date()==date.date())
        str = date.time().toString();
    else
        str = date.toString("dd.MM hh:mm");

    return str;
}

int ClientData::getCountMessages(int index)
{
    if(dialogs.count()<=index) return false;
    return dialogs[index].getMessages().count();
}

QString ClientData::getTextMessage(int d_index, int m_index)
{
    if(dialogs.count()<=d_index) return "WARNING: not mesage";

    Message msg=dialogs[d_index].getMessages()[m_index];
    QString text;
    bool isGroup = dialogs[d_index].getIsGroup();
    if (isGroup && msg.getSender_login()!=user->getLogin())
        text = getNameContact(msg.getSender_login()) + ": " + msg.getMessage_data();
    else
        text = msg.getMessage_data();
    return text;
}

QString ClientData::getDateMessage(int d_index, int m_index)
{
    if(dialogs.count()<=d_index) return "WARNING: not date";

    return getLastActiveDateTime(dialogs[d_index].getMessages()[m_index].getTime());
}

int ClientData::getStatusMessage(int d_index, int m_index)
{
    if(dialogs.count()<=d_index) return 0;

    return dialogs[d_index].getMessages()[m_index].getStatus();
}

bool ClientData::getIsSenderMessage(int d_index, int m_index)
{
    if(dialogs.count()<=d_index) return false;

    return dialogs[d_index].getMessages()[m_index].getSender_login()== user->getLogin();
}

int ClientData::setAllReadMessageInDialog(int indexDialog)
{
    for(int i = 0; i < dialogs[indexDialog].messages.size(); i++)
    {
        dialogs[indexDialog].messages[i].setStatus(3);
    }
}

//QString ClientData::getMyLogin() const
//{
//    return myLogin;
//}

//void ClientData::setMyLogin(const QString &value)
//{
//    myLogin = value;
//}

QString ClientData::getIdDialogString(int index)
{
    return QString::number(dialogs[index].getID());
}

void ClientData::AddMessage(QString idDialog, QString idMessage, QString loginSender, QDateTime date, QString status, QString message, QVector<QString> paths)
{
    int id_dialog = idDialog.toInt();
    int tmp_id_message = idMessage.toInt();

    for(int i = 0; i < dialogs.size(); i++)
    {
        if(dialogs[i].getID() == id_dialog)
        {
            Message* tmpMessage = new Message(tmp_id_message, id_dialog, loginSender, message, date, 0);
            tmpMessage->setStatus(status);

            for(int j = 0; j < paths.size(); j++)
            {
                MyFile* tmpFile = new MyFile(tmp_id_message, paths[j], ProtocolTrade::GetNameFromPathFile(paths[j]), ProtocolTrade::GetTypeFromPathFile(paths[j]));
                tmpMessage->addFile(*tmpFile);
            }

            dialogs[i].addMessage(*tmpMessage);
            dialogs[i].SortBy();
            break;
        }
    }

}

void ClientData::UpdateMessageId(QString idDialog, QString tmpIdMessage, QString idMessage, QString statusMessage)
{
    int id_dialog = idDialog.toInt();
    int tmp_id_message = tmpIdMessage.toInt();
    int id_message = idMessage.toInt();

    for(int i = 0; i < dialogs.size(); i++)
    {
        if(dialogs[i].getID() == id_dialog)
        {
            for(int j = 0; dialogs[i].getMessages().size(); j++)
            {
                if(dialogs[i].getMessages()[j].getId() == tmp_id_message)
                {
                    dialogs[i].messages[j].setId(id_message);
                    dialogs[i].messages[j].setStatus(statusMessage);
                    break;
                }
            }

//            Message* tmpMessage = new Message(tmp_id_message, id_dialog, user->getLogin(), message, QDateTime::currentDateTime(), 0);

//            for(int j = 0; j < paths.size(); j++)
//            {
//                MyFile* tmpFile = new MyFile(tmp_id_message, paths[j], ProtocolTrade::GetNameFromPathFile(paths[j]), ProtocolTrade::GetTypeFromPathFile(paths[j]));
//                tmpMessage->addFile(*tmpFile);
//            }

            break;
        }
    }
}


