#include "clientgeneral.h"

void ClientGeneral::onConnected()
{
    qDebug() << "WebSocketServer connected";
    connect(&socketServer,
            &QWebSocket::textMessageReceived,
            this,
            &ClientGeneral::onTextMessageReceived);



}

void ClientGeneral::onTextMessageReceived(QString message)
{
    QWebSocket *socket = qobject_cast<QWebSocket *>(sender());

    //    qDebug() << /*message*/;

    QJsonObject object = ProtocolTrade::StringToJsonObject(message);

    if(ProtocolTrade::CompareSocket(socket, &socketServer))
    {
        ClientGeneral::processingEventFromServer(&object);
    }
    else
    {
        qDebug() << "от другого клиента";
    }
}

void ClientGeneral::onSslErrors(const QList<QSslError> &errors)
{
    Q_UNUSED(errors);
    socketServer.ignoreSslErrors();
}

ClientGeneral::ClientGeneral(QObject *parent) : QObject(parent)
{
    connect(&socketServer,
            &QWebSocket::connected,
            this,
            &ClientGeneral::onConnected);

    connect(&socketServer,
            QOverload<const QList<QSslError>&>::of(&QWebSocket::sslErrors),
            this,
            &ClientGeneral::onSslErrors);

    socketServer.open(URL_SERVER);
}

//void ClientGeneral::authorization(QString login, QString password)
//{
//    ClientGeneral::authorization(login, password, &socketServer);
//}


//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

void ClientGeneral::handlerCmdAuthorization(QJsonObject *object)
{
    QString status = ((*object)[ProtocolTrade::___STATUS]).toString();

    if(status == ProtocolTrade::___STS_DONE)
    {
        // Пользователь авторизовался
        QString userName = ((*object)[ProtocolTrade::___USER_NAME]).toString();
        QString birthDate = ((*object)[ProtocolTrade::___BIRTH_DATE]).toString();



        QJsonObject jObj = ((*object)[ProtocolTrade::___AVATAR]).toObject();

        QString filePath =ProtocolTrade::SaveBinaryFile(// PATH GDE
                                      jObj[ProtocolTrade::___BINARY_FILE].toString(),
                "userAvatar_"+jObj[ProtocolTrade::___NAME_FILE].toString() +userName,
                jObj[ProtocolTrade::___TYPE_FILE].toString(),
                "idMessage",
                "idChat");

//        QString filePath = "" + jObj[ProtocolTrade::___NAME_FILE].toString() + "."+jObj[ProtocolTrade::___TYPE_FILE].toString();

        Fix::isAuthorized = true;
        emit onAutorization(userName, filePath, birthDate, true);
    }
    else
    {
        emit onAutorization("", "", "", false);
        // Пользователь не авторизовался
    }
}

void ClientGeneral::handlerCmdSendMessage(QJsonObject *object)
{
    // Обработка входных данных
    QString idChat = ((*object)[ProtocolTrade::___ID_CHAT]).toString();
    QString idMessage = ((*object)[ProtocolTrade::___ID_MESSAGE]).toString();
    QString messageText = "";
    QJsonArray arrAttachment;

    if (!object->find(ProtocolTrade::___TEXT_MESSAGE)->isUndefined())
    {
        messageText = ((*object)[ProtocolTrade::___TEXT_MESSAGE]).toString("");
    }

    if (!object->find(ProtocolTrade::___ARR_ATTACHMENT)->isUndefined())
    {
        arrAttachment = ((*object)[ProtocolTrade::___ARR_ATTACHMENT]).toArray();
    }

    QVector<QString> paths;

    if(arrAttachment.size() > 0)
    {
        QJsonObject jObj;

        for(int i = 0; i < arrAttachment.size(); i++)
        {
            jObj = arrAttachment[i].toObject();
            paths.push_back(ProtocolTrade::SaveBinaryFile(
                                jObj[ProtocolTrade::___BINARY_FILE].toString(),
                            jObj[ProtocolTrade::___NAME_FILE].toString(),
                            jObj[ProtocolTrade::___TYPE_FILE].toString(),
                            idMessage,
                            idChat));
        }
    }

    clientData->AddMessage(idChat, idMessage, messageText, paths);
    // дописать отображение на фронте

    // Формирование ответа серверу
    QJsonObject* answer = new QJsonObject({
                                              {ProtocolTrade::___COMMAND, QJsonValue(ProtocolTrade::___CMD_SEND_MESSAGE)},
                                              {ProtocolTrade::___ID_CHAT, QJsonValue(idChat)},
                                              {ProtocolTrade::___ID_MESSAGE, QJsonValue(idMessage)},
                                              {ProtocolTrade::___STATUS_MESSAGE, QJsonValue(ProtocolTrade::___STS_TAKEN)}
                                          });

    ProtocolTrade::SendTextMessage(ProtocolTrade::JsonObjectToString(answer), &socketServer);
}

//ЖОПиСАТЬ

//ЖОПиСАЛ)
void ClientGeneral::handlerCmdSendMessageAnswerServer(QJsonObject *object)
{
    QString idChat = ((*object)[ProtocolTrade::___ID_CHAT]).toString();
    QString idMessage = ((*object)[ProtocolTrade::___ID_MESSAGE]).toString();
    QString tmpIdMessage = ((*object)[ProtocolTrade::___TMP_ID_MESSAGE]).toString();
    QString statusMessage = ((*object)[ProtocolTrade::___STATUS_MESSAGE]).toString();

    clientData->UpdateMessageId(idChat, tmpIdMessage, idMessage, statusMessage);
}

void ClientGeneral::processingEventFromServer(QJsonObject *object)
{
    QString commandFromClient = ((*object)[ProtocolTrade::___COMMAND]).toString();

    if(commandFromClient == ProtocolTrade::___CMD_SEND_MESSAGE)
    {
        if(!object->find(ProtocolTrade::___TMP_ID_MESSAGE)->isUndefined())
        {
            // обработка ответа с сервера после отправки сообщения
            handlerCmdSendMessageAnswerServer(object);
        }
        else
        {
            // обработка входящего сообщения
            handlerCmdSendMessage(object);
        }
    }
    else if(commandFromClient == ProtocolTrade::___CMD_CREATE_PRIVATE_CHAT)
    {
        if(!object->find(ProtocolTrade::___STATUS)->isUndefined())
        {
            // Обработка полученного запроса на создание приватного чата от сервера
            getAnswerCreatePrivateChat(object);
        }
        else
        {
            // Обработка ответа на создание приватног чата
            getReqPrivateChat(object);
        }
    }
    else if(commandFromClient == ProtocolTrade::___CMD_AUTHORIZATION)
    {
        // Обработка ответа от сервера на авторизацию
        handlerCmdAuthorization(object);
    }
    else if(commandFromClient == ProtocolTrade::___CMD_GET_MESSAGES){
        // Обработка ответа от сервера на запрос сообщений из конкретного чата
        getAnswerMessagesInDialog(object);
    }
    else if(commandFromClient == ProtocolTrade::___CMD_GET_DATE_USER){
        // Обработка ответа от сервера на запрос информации об котнтакте
        getAnswerContact(object);
    }
    else if(commandFromClient == ProtocolTrade::___CMD_GET_CHATS){
        // Обработка ответа от сервера на запрос всех диалогов
        answerMyDialogs(object);
    }

}

void ClientGeneral::sendMessage(QString idChat, QString tmpIdMsg, QString textMsg, QVector<QString> paths)
{
    QJsonObject* jObj = new QJsonObject({
                                            {ProtocolTrade::___COMMAND, QJsonValue(ProtocolTrade::___CMD_SEND_MESSAGE)},
                                            {ProtocolTrade::___ID_CHAT, QJsonValue(idChat)},
                                            {ProtocolTrade::___TMP_ID_MESSAGE, QJsonValue(tmpIdMsg)}
                                        });

    if(!textMsg.isEmpty())
    {
        jObj->insert(ProtocolTrade::___TEXT_MESSAGE, QJsonValue(textMsg));
    }

    if(!paths.isEmpty())
    {
        QJsonArray arrAttachment;
        QJsonObject tmpJsonObject;
        QByteArray array;

        for(int i = 0; i < paths.size(); i++)
        {
            array = ProtocolTrade::LoadBinaryFile(paths[i]);
            tmpJsonObject.insert(ProtocolTrade::___BINARY_FILE, QJsonValue(ProtocolTrade::ByteArrayToString(array)));
            tmpJsonObject.insert(ProtocolTrade::___NAME_FILE, QJsonValue(ProtocolTrade::GetNameFromPathFile(paths[i])));
            tmpJsonObject.insert(ProtocolTrade::___TYPE_FILE, QJsonValue(ProtocolTrade::GetTypeFromPathFile(paths[i])));

            arrAttachment.push_back(tmpJsonObject);
        }

        jObj->insert(ProtocolTrade::___ARR_ATTACHMENT, arrAttachment);
    }

    ProtocolTrade::SendTextMessage(ProtocolTrade::JsonObjectToString(jObj), &socketServer);
}

void ClientGeneral::authorization(QString login, QString password, ClientData *clientData)
{
    QJsonObject* jObj = new QJsonObject({
                                            {ProtocolTrade::___COMMAND, QJsonValue(ProtocolTrade::___CMD_AUTHORIZATION)},
                                            {ProtocolTrade::___LOGIN, QJsonValue(login)},
                                            {ProtocolTrade::___PASSWORD, QJsonValue(password)}
                                        });

    this->clientData=clientData;
    this->clientData->user->setLogin(login);

    ProtocolTrade::SendTextMessage(ProtocolTrade::JsonObjectToString(jObj), &socketServer);
}

void ClientGeneral::sendPrivateMessage(QString tmpIdMsg, QString textMsg, QVector<QString> paths)
{
    QJsonObject* jObj = new QJsonObject({
                                            {ProtocolTrade::___COMMAND, QJsonValue(ProtocolTrade::___CMD_SEND_PRIVATE_MESSAGE)},
                                            {ProtocolTrade::___TMP_ID_MESSAGE, QJsonValue(tmpIdMsg)}
                                        });

    if(!textMsg.isEmpty())
    {
        jObj->insert(ProtocolTrade::___TEXT_MESSAGE, QJsonValue(textMsg));
    }

    if(!paths.isEmpty())
    {
        QJsonArray arrAttachment;
        QJsonObject tmpJsonObject;
        QByteArray array;

        for(int i = 0; i < paths.size(); i++)
        {
            array = ProtocolTrade::LoadBinaryFile(paths[i]);
            tmpJsonObject.insert(ProtocolTrade::___BINARY_FILE, QJsonValue(ProtocolTrade::ByteArrayToString(array)));
            tmpJsonObject.insert(ProtocolTrade::___NAME_FILE, QJsonValue(ProtocolTrade::GetNameFromPathFile(paths[i])));
            tmpJsonObject.insert(ProtocolTrade::___TYPE_FILE, QJsonValue(ProtocolTrade::GetTypeFromPathFile(paths[i])));

            arrAttachment.push_back(tmpJsonObject);
        }

        jObj->insert(ProtocolTrade::___ARR_ATTACHMENT, arrAttachment);
    }

    ProtocolTrade::SendTextMessage(ProtocolTrade::JsonObjectToString(jObj), &socketServer);
}

void ClientGeneral::getMessagesInDialog(QString idChat)
{
    QJsonObject* jObj = new QJsonObject({
                                            {ProtocolTrade::___COMMAND, QJsonValue(ProtocolTrade::___CMD_GET_MESSAGES)},
                                            {ProtocolTrade::___ID_CHAT, QJsonValue(idChat)}
                                        });

    ProtocolTrade::SendTextMessage(ProtocolTrade::JsonObjectToString(jObj), &socketServer);
}

void ClientGeneral::getAnswerMessagesInDialog(QJsonObject *object)
{
    QString idChat = ((*object)[ProtocolTrade::___ID_CHAT]).toString();
    bool isGroup = false;

    UserDialog dialog(idChat.toInt(), isGroup);

    QJsonArray messages = ((*object)[ProtocolTrade::___ARR_MESSAGES]).toArray();
    foreach(QJsonValue objMsg, messages)
    {
        int idMessage = ((objMsg)[ProtocolTrade::___ID_MESSAGE]).toInt();
        QString textMessage = ((objMsg)[ProtocolTrade::___TEXT_MESSAGE]).toString();
        int statusMessage = ((objMsg)[ProtocolTrade::___STATUS_MESSAGE]).toInt();
        QString loginSender = ((objMsg)[ProtocolTrade::___LOGIN]).toString();
        QDateTime date= QDateTime::fromString(((objMsg)[ProtocolTrade::___BIRTH_DATE]).toString());

        Message msg(idMessage,idChat.toInt(),loginSender,textMessage,date,statusMessage);

        QJsonArray files = ((objMsg)[ProtocolTrade::___ARR_ATTACHMENT]).toArray();
        foreach(QJsonValue objFiles, files)
        {
            QString nameFile = ((objFiles)[ProtocolTrade::___NAME_FILE]).toString();
            QString typeFile = ((objFiles)[ProtocolTrade::___TYPE_FILE]).toString();
            QByteArray bytes = ProtocolTrade::StringToByteArray(((objFiles)[ProtocolTrade::___BINARY_FILE]).toString());

            MyFile file(-1,"",nameFile, typeFile);
            file.SetByteArray(bytes);

            msg.addFile(file);
        }

        dialog.addMessage(msg);
    }

    UserDialog* d= clientData->getDialogFromId(idChat.toInt());

//    for(int i=1;i<dialog.getMessages().count();i++)
//        d->addMessage(dialog.getMessages()[i]);
    d->setMessages(dialog.getMessages());
    d->SortBy();

    emit onGetMessages();
    qDebug() <<dialog.getID();
    // ОТДАТЬ ИГОРЮ ПОЛУЧЕННЫЙ ДИАЛОГ
}

void ClientGeneral::getContact(QString login)
{
    QJsonObject * object = new QJsonObject({
                                               {ProtocolTrade::___COMMAND, QJsonValue(ProtocolTrade::___CMD_GET_DATE_USER)},
                                               {ProtocolTrade::___LOGIN, QJsonValue(login)}
                                           });
    ProtocolTrade::SendTextMessage(ProtocolTrade::JsonObjectToString(object), &socketServer);
}

void ClientGeneral::getAnswerContact(QJsonObject *qObj)
{
    bool status = ((*qObj)[ProtocolTrade::___STATUS]) == ProtocolTrade::___STS_DONE;
    if(status){
        QString name = ((*qObj)[ProtocolTrade::___USER_NAME]).toString();
        QByteArray avatar = ProtocolTrade::StringToByteArray(((*qObj)[ProtocolTrade::___BINARY_FILE]).toString());
        QDate date= QDate::fromString(((*qObj)[ProtocolTrade::___BIRTH_DATE]).toString());
        bool isOnline = ((*qObj)[ProtocolTrade::___STATUS_USER]) == ProtocolTrade::___STS_ONLINE;


        // takogo polsovatelya est'
    }
    else{
        // takogo polsovatelya net
    }
}

void ClientGeneral::getMyDialogs()
{
    QJsonObject* object = new QJsonObject({{ProtocolTrade::___COMMAND, QJsonValue(ProtocolTrade::___CMD_GET_CHATS)}});
    ProtocolTrade::SendTextMessage(ProtocolTrade::JsonObjectToString(object), &socketServer);
}

void ClientGeneral::answerMyDialogs(QJsonObject *qObj)
{
    QJsonArray chats = (*qObj)[ProtocolTrade::___ARR_CHATS].toArray();
    QVector<UserDialog> dialogs;
    foreach(QJsonValue c, chats){
        QString dialog_name = c[ProtocolTrade::___USER_NAME].toString();
        QString dialog_avatar = c[ProtocolTrade::___AVATAR].toString();
        int id = c[ProtocolTrade::___ID_CHAT].toInt();
        QString avatarPath = ProtocolTrade::SaveBinaryFile(dialog_avatar,"dialogAvatar_"+QString::number(id)+"_"+dialog_name,c.toString(),"","");
        QJsonArray members = c[ProtocolTrade::___ARR_USERS].toArray();
        bool isGroup = c[ProtocolTrade::___CHAT_GROUP].toBool();
        UserDialog dialog(id, isGroup, dialog_name,ProtocolTrade::StringToByteArray(dialog_avatar), avatarPath);
        foreach(QJsonValue m, members){
            QString login = m[ProtocolTrade::___LOGIN].toString();
            QByteArray user_avatar = ProtocolTrade::StringToByteArray(m[ProtocolTrade::___AVATAR].toString());
            QString user_name = m[ProtocolTrade::___USER_NAME].toString();
            QString birthdate = m[ProtocolTrade::___BIRTH_DATE].toString();
            User user(-1, login, user_name, user_avatar, birthdate);
            dialog.addMember(&user);
        }

        QJsonValue jlastMsg= c[ProtocolTrade::___ARR_MESSAGES];
        Message last(jlastMsg[ProtocolTrade::___ID_MESSAGE].toInt(),
                id,
                jlastMsg[ProtocolTrade::___USER_NAME].toString(),
                jlastMsg[ProtocolTrade::___TEXT_MESSAGE].toString(),
                QDateTime::fromString(jlastMsg[ProtocolTrade::___BIRTH_DATE].toString()),
                jlastMsg[ProtocolTrade::___STATUS_MESSAGE].toInt());
        dialog.addMessage(last);
        int countUnChecked=c[ProtocolTrade::___COUNT_MESSAGE].toInt();
        bool isOnline=c[ProtocolTrade::___STATUS_USER].toString()==ProtocolTrade::___STS_ONLINE;
        dialog.setCountUnChecked(countUnChecked);
        dialog.setIsOnline(isOnline);
        dialogs.append(dialog);
    }
    clientData->setDialogs(dialogs);


    emit onGetDialogs();
    // СДЕЛАЙ ЧТО ТО С ДИАЛОГС
}

void ClientGeneral::createChat(QVector<QString> logins, QString name, QByteArray avatar, bool isGroup)
{
    QJsonObject* jObj = new QJsonObject({
                                            {ProtocolTrade::___COMMAND, QJsonValue(ProtocolTrade::___CMD_CREATE_CHAT)},
                                            {ProtocolTrade::___USER_NAME, QJsonValue(name)},
                                            {ProtocolTrade::___AVATAR, QJsonValue(ProtocolTrade::ByteArrayToString(avatar))},
                                            {ProtocolTrade::___CHAT_GROUP, QJsonValue(isGroup)}
                                        });

    QJsonArray* jlogins=new QJsonArray();
    foreach(QString login, logins){
        QJsonObject* jlogin = new QJsonObject({
                                                  {ProtocolTrade::___LOGIN, QJsonValue(login)}
                                              });
        jlogins->append(*jlogin);
    }
    jObj->insert(ProtocolTrade::___ARR_USERS, *jlogins);

    ProtocolTrade::SendTextMessage(ProtocolTrade::JsonObjectToString(jObj), &socketServer);
}

QString ClientGeneral::generateTmpIdMsg()
{
    return QString::number(QTime::currentTime().msecsSinceStartOfDay());
}

void ClientGeneral::addMessage(QString idDialog, QString tmpIdMessage, QString message, QVector<QString> paths)
{
    clientData->AddMessage(idDialog, tmpIdMessage, message, paths);
}

void ClientGeneral::createPrivateChat(QString receiver_login)
{
    QJsonObject* jObj = new QJsonObject({
                                            {ProtocolTrade::___COMMAND, QJsonValue(ProtocolTrade::___CMD_CREATE_PRIVATE_CHAT)},
                                            {ProtocolTrade::___LOGIN, QJsonValue(receiver_login)}
                                        });

    ProtocolTrade::SendTextMessage(ProtocolTrade::JsonObjectToString(jObj), &socketServer);
}

void ClientGeneral::getReqPrivateChat(QJsonObject *qObj)
{
    QString requester_login = ((*qObj)[ProtocolTrade::___LOGIN]).toString();
    bool isAccepted;// НУЖНО СПРОСИТЬ У ПОЛЬЗОВАТЕЛЯ ХОЧЕТ ЛИ ОН СОЗДАТЬ ДИАЛОГ
    isAccepted = requester_login == "1";


    QString status = isAccepted ? ProtocolTrade::___STS_DONE : ProtocolTrade::___STS_NOPE;
    QJsonObject* answer;

    if(isAccepted)
    {
        quint16 port = Fix::START_PORT_LISTENER + Fix::privateChatsDst.size() + Fix::privateChatsSrc.size();
        DstPrivateChat* tmpDst = new DstPrivateChat(requester_login, Fix::loginUser, port);
        Fix::privateChatsDst.push_back(tmpDst);
        answer = new QJsonObject({
                                     {ProtocolTrade::___COMMAND, QJsonValue(ProtocolTrade::___CMD_CREATE_PRIVATE_CHAT)},
                                     {ProtocolTrade::___STATUS, QJsonValue(ProtocolTrade::___STS_DONE)},
                                     {ProtocolTrade::___PORT_USER, QJsonValue(QString::number(port))},
                                     {ProtocolTrade::___LOGIN, QJsonValue(requester_login)}
                                 });
    }

    else
    {
        answer = new QJsonObject({
                                     {ProtocolTrade::___COMMAND, QJsonValue(ProtocolTrade::___CMD_CREATE_PRIVATE_CHAT)},
                                     {ProtocolTrade::___STATUS, QJsonValue(ProtocolTrade::___STS_NOPE)},
                                     {ProtocolTrade::___LOGIN, QJsonValue(requester_login)}
                                 });
    }

    ProtocolTrade::SendTextMessage(ProtocolTrade::JsonObjectToString(answer), &socketServer);
}

void ClientGeneral::getAnswerCreatePrivateChat(QJsonObject *qObj)
{
    QString status = ((*qObj)[ProtocolTrade::___STATUS]).toString();
    if(status == ProtocolTrade::___STS_DONE){
        QString ip = ((*qObj)[ProtocolTrade::___IP_USER]).toString();
        QString port = ((*qObj)[ProtocolTrade::___PORT_USER]).toString();
        QString login = ((*qObj)[ProtocolTrade::___LOGIN]).toString();

        //чувак согласился на првиатный чат надо с этим что-то делать

        SrcPrivateChat* tmpSrc = new SrcPrivateChat(login, Fix::loginUser, port.toUInt(), ip);
        Fix::privateChatsSrc.push_back(tmpSrc);
    }
    else {
        // чувак не согласился на првиатный чат ну и ладно
    }
}



