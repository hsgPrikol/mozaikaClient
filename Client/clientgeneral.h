#ifndef CLIENTGENERAL_H
#define CLIENTGENERAL_H

#include <QObject>
#include <QtNetwork/QSslError>
#include <QtWebSockets/QWebSocket>
#include "handlercommand.h"
#include <QThread>
#include "clientdata.h"
//#include "super_server/user.h"

class ClientGeneral : public QObject
{
    Q_OBJECT

private slots:
    void onConnected();
    void onTextMessageReceived(QString message);
    void onSslErrors(const QList<QSslError> &errors);

private:

    const QUrl URL_SERVER = QUrl(QStringLiteral("ws://localhost:1234"));

public:
    explicit ClientGeneral(QObject *parent = nullptr);

    ClientData* clientData;
    QWebSocket socketServer;
public slots:
//    void sendMessage(QString idChat, QString tmpIdMsg, QString textMsg, QVector<QString> paths);
//    void authorization(QString login, QString password);
//    void sendPrivateMessage(QString tmpIdMsg, QString textMsg, QVector<QString> paths);


    //HandlerController
    //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    ///Обработчик ответа от сервера на авторизацию
    void handlerCmdAuthorization(QJsonObject* object);

    ///Обработчик получения нового сообщения
    void handlerCmdSendMessage(QJsonObject* object);

    ///Обработчик ответа после отправки сообщения
    void handlerCmdSendMessageAnswerServer(QJsonObject* object);

    void processingEventFromServer(QJsonObject* object);

    /// Отправка запроса на создание приватного чата
    void createPrivateChat(QString receiver_login);

    /// Обработка разрешения на создание приватного чата
    void getReqPrivateChat(QJsonObject* qObj);

    /// Получение ответа на создание приватного чата
    void getAnswerCreatePrivateChat(QJsonObject* qObj);

    void sendMessage(QString idChat, QString tmpIdMsg, QString textMsg, QVector<QString> paths);
    void authorization(QString login, QString password, ClientData* clientData);
    void sendPrivateMessage(QString tmpIdMsg, QString textMsg, QVector<QString> paths);
    /// Запрос клиента на получение сообщений из конкретного диалога
    void getMessagesInDialog(QString idChat);

    /// Получение ответа от сервера на запрос сообщений из конкретного чата
    void getAnswerMessagesInDialog(QJsonObject* qObj);

    /// Запрос на получение контакта
    void getContact(QString login);

    /// Ответ на запрос на получение контакта
    void getAnswerContact(QJsonObject* qObj);

    /// Запрос на получение списка всех диалогов
    void getMyDialogs();

    /// Ответ на запрос получения списка всех диалогов
    void answerMyDialogs(QJsonObject* qObj);

    /// Отправка запроса на создание чата
    void createChat(QVector<QString> logins, QString name, QByteArray avatar, bool isGroup);

signals:
    void onAutorization(QString, QString, QString, bool);
    void onGetDialogs();
    void onGetMessages();
};

#endif // CLIENTGENERAL_H
