#ifndef CLIENTGENERAL_H
#define CLIENTGENERAL_H

#include <QObject>
#include <QtNetwork/QSslError>
#include <QtWebSockets/QWebSocket>
#include "handlercommand.h"
#include <QThread>

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

    QWebSocket socketServer;
public slots:
    void sendMessage(QString idChat, QString tmpIdMsg, QString textMsg, QVector<QString> paths);
    void authorization(QString login, QString password);
    void sendPrivateMessage(QString tmpIdMsg, QString textMsg, QVector<QString> paths);
    void createPrivateChat(QString login);


    //HandlerController
    //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    ///Обработчик ответа от сервера на авторизацию
    void handlerCmdAuthorization(QJsonObject* object, QWebSocket* client);

    ///Обработчик получения нового сообщения
    void handlerCmdSendMessage(QJsonObject* object, QWebSocket* client);

    ///Обработчик ответа после отправки сообщения
    void handlerCmdSendMessageAnswerServer(QJsonObject* object, QWebSocket* client);

    void processingEventFromServer(QJsonObject* object, QWebSocket* socket);

    /// Отправка запроса на создание приватного чата
    void createPrivateChat(QString receiver_login, QWebSocket *socket);

    /// Обработка разрешения на создание приватного чата
    void getReqPrivateChat(QJsonObject* qObj, QWebSocket *socket);

    /// Получение ответа на создание приватного чата
    void getAnswerCreatePrivateChat(QJsonObject* qObj, QWebSocket *socket);

    void sendMessage(QString idChat, QString tmpIdMsg, QString textMsg, QVector<QString> paths, QWebSocket* socket);
    void authorization(QString login, QString password, QWebSocket* socket);
    void sendPrivateMessage(QString tmpIdMsg, QString textMsg, QVector<QString> paths, QWebSocket* socket);
    /// Запрос клиента на получение сообщений из конкретного диалога
    void getMessagesInDialog(QString idChat, QWebSocket *socket);

    /// Получение ответа от сервера на запрос сообщений из конкретного чата
    void getAnswerMessagesInDialog(QJsonObject* qObj, QWebSocket *socket);

    /// Запрос на получение контакта
    void getContact(QString login, QWebSocket *socket);

    /// Ответ на запрос на получение контакта
    void getAnswerContact(QJsonObject* qObj, QWebSocket *socket);

    /// Запрос на получение списка всех диалогов
    void getMyDialogs(QWebSocket *socket);

    /// Ответ на запрос получения списка всех диалогов
    void answerMyDialogs(QJsonObject* qObj, QWebSocket *socket);

    /// Отправка запроса на создание чата
    void createChat(QVector<QString> logins, QString name, QByteArray avatar, QWebSocket *socket);

signals:
    void onAutorization(QString, QString, QString, bool);
};

#endif // CLIENTGENERAL_H
