#ifndef SETTINGSDATA_H
#define SETTINGSDATA_H

#include <QObject>
#include <QMap>
#include <QVector>

class SettingsData : public QObject
{
    Q_OBJECT
public:
    explicit SettingsData(QObject *parent = nullptr);

    QMap<QString, QVector<QString>> map;

    QVector<QString> arrayPointSettings = {"Аккаунт", "Уведомления", "Память", "Тема"};

    //Account
    QVector<QString> arrayPointSettingsAccount = {"Логин", "Пароль", "Телефон", "Дата рождения", "Язык"};
    QVector<QString> arrayAnswerPointSettingsAccount = {"5NR_Operator_27", "Сменить", "*********", "27.09.1997", "Русский"};

    //Notification
    QVector<QString> arrayPointSettingsNotification = {"Уведомления", "Отображать содержимое сообщение"};
    QVector<QString> arrayAnswerSettingsNotification = {"Включены", "Только при разблокировке"};

    //Memory
    QVector<QString> arrayPointSettingsMemory = {"Место сохранения файлов", "Автоматическая загрузка медиаконтента", "Автоматически очищать медиаконтент"};
    QVector<QString> arrayAnswerSettingsMemory {"Внутренняя память", "Выключено", "Спустя 3 месяца"};

    //Themes
    QVector<QString> arrayPointSettingsThemes = {"Фон диалогов", "Палитра"};
    QVector<QString> arrayAnswerSettingsThemes = {"Выбрать", "ХЗ"};



public slots:
    QString getArrayPointSettings(int value);
    QString getArrayPointSettingsAccount(int value);
    QString getArrayAnswerPointSettingsAccount(int value);
    QString getArrayPointSettingsNotification(int value);
    QString getArrayAnswerSettingsNotification(int value);
    QString getArrayPointSettingsMemory(int value);
    QString getArrayAnswerSettingsMemory(int value);
    QString getArrayPointSettingsThemes(int value);
    QString getArrayAnswerSettingsThemes(int value);

signals:

};

#endif // SETTINGSDATA_H
