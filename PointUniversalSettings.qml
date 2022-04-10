import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtGraphicalEffects 1.0

Rectangle {
    id: pointUniversalSettings

    property int dfltWidth: 506
    property int dfltHeight: 400
    property color noColor: "#00000000"
    property real customOpacity: 0.7
    property color biruzoviu: "#068d9d"


    property int countIndex: 0
    //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

    property var arrayPointSettings: ["Аккаунт", "Уведомления", "Память", "Тема"]

    //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    //for Account

    property var arrayPointSettingsAccount: ["Логин", "Пароль", "Телефон", "Дата рождения", "Язык"]

    property var arrayAnswerPointSettingsAccount: ["5NR_Operator_27", "Сменить", "*********", "27.09.1997", "Русский"]

    //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    //for Push Notification

    property var arrayPointSettingsNotification: ["Уведомления", "Отображать содержимое сообщение"]

    property var arrayAnswerSettingsNotification: ["Включены", "Только при разблокировке"]

    //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    //for Memory

    property var arrayPointSettingsMemory: ["Место сохранения файлов", "Автоматическая загрузка медиаконтента", "Автоматически очищать медиаконтент"]

    property var arrayAnswerSettingsMemory: ["Внутренняя память", "Выключено", "Спустя 3 месяца"]

    //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    //for Themes

    property var arrayPointSettingsThemes: ["Фон диалогов", "Палитра"]

    property var arrayAnswerSettingsThemes: ["Выбрать", "ХЗ"]

    //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    width: dfltWidth
    height: 300

    color: noColor

    Column{
        anchors.fill: parent
        spacing: 10

        HatMask {
            id: hatAccountMask
            nameText: arrayPointSettings[countIndex]

//            border.width: 3
//            border.color: "red"
            Component.onCompleted: {
                console.log("arrayPointSettings[index]", arrayPointSettings[countIndex])
            }
        }

        Repeater{
            model: 4

            Row{
                width: parent.width
                height: 50

                Rectangle{
                    id: keyUniversal
                    width: parent.width / 2
                    height: 50
                    border.width: 1
                    border.color: "black"

                    Text {

                        text: qsTr("text")
                    }
                }

                Rectangle{
                    id: valueUniversal
                    width: parent.width / 2
                    height: 50
                    anchors.left: keyUniversal.right
                    anchors.right: parent.right
                    border.width: 1
                    border.color: "black"

                    Text {

                        text: qsTr("text")
                    }
                }
            }
        }
    }
}


