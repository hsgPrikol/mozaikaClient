#include "settingsdata.h"

SettingsData::SettingsData(QObject *parent) : QObject(parent)
{

}

QString SettingsData::getArrayAnswerSettingsThemes(int value)
{
    return arrayAnswerSettingsThemes.at(value);
}


QString SettingsData::getArrayPointSettingsThemes(int value)
{
    return arrayPointSettingsThemes.at(value);
}


QString SettingsData::getArrayAnswerSettingsMemory(int value)
{
    return arrayAnswerSettingsMemory.at(value);
}


QString SettingsData::getArrayPointSettingsMemory(int value)
{
    return arrayPointSettingsMemory.at(value);
}


QString SettingsData::getArrayAnswerSettingsNotification(int value)
{
    return arrayAnswerSettingsNotification.at(value);
}


QString SettingsData::getArrayPointSettingsNotification(int value)
{
    return arrayPointSettingsNotification.at(value);
}


QString SettingsData::getArrayAnswerPointSettingsAccount(int value)
{
    return arrayAnswerPointSettingsAccount.at(value);
}

QString SettingsData::getArrayPointSettingsAccount(int value)
{
    return arrayPointSettingsAccount.at(value);
}

QString SettingsData::getArrayPointSettings(int value)
{
    return arrayPointSettings.at(value);
}
