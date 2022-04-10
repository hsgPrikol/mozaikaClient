import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtGraphicalEffects 1.0

Rectangle {
    id: downBar

    property int dfltWidth: 506
    property int dfltHeight: 56

    property color enemyColor: "gray"
    property color biruzoviu: "#068d9d"
    property color noColor: "#00000000"
    property real customOpacity: 0.7
    property int fontSize: 12


    width: dfltWidth
    height: dfltHeight
    color: noColor
    opacity: customOpacity

    Rectangle {
        id: dontKnowButton
        x: 14
        y: 4
        width: 49
        height: 48
        color: biruzoviu
        radius: 5

        Image {
            id: image
            x: 5
            y: 5
            width: 39
            height: 38
            //            anchors.fill: parent
            source: "qrc:/resourses/chat/treugol`nik.tif"
            anchors.rightMargin: 0
            anchors.bottomMargin: 0
            rotation: 180
            fillMode: Image.PreserveAspectFit

            MouseArea{
                anchors.fill: parent

                onClicked: {
                    console.log("Я не понимаю, что это такое сука...")
                }
            }
        }
    }

    Rectangle {
        id: chooseFile
        x: 69
        y: 4
        width: 49
        height: 48
        color: biruzoviu
        radius: 5

        Image {
            id: image1
            x: 5
            y: 5
            width: 39
            height: 38
            //            anchors.fill: parent
            source: "qrc:/resourses/chat/prikrepit`.tif"
            fillMode: Image.PreserveAspectFit

            MouseArea{
                anchors.fill: parent

                onClicked: {
                    console.log("Выберите файл")
                }
            }
        }
    }

    TextField {
        id: textField
        x: 124
        y: 4
        width: 319
        height: 48
        placeholderText: qsTr("Написать сообщение...")

        selectByMouse: true
        color: "#ffffff"
        opacity: 1

        background: Rectangle {
            anchors.fill: parent
            color: biruzoviu
            radius: 7

        }
    }

//    Massage{
//        id: ert
//        anchors.leftMargin: 7
//        anchors.rightMargin: 7
//        sizeMessage: 40
//        messageText: "sadsdasdsadddddddd sssssssss ssssssss ssssss "
//        flagWhenMessage: true//testBoolArray[index]
//        anchors.right: {
//            if (flagWhenMessage)
//            {
//                parent.right
//            }
//        }

//        anchors.left: {
//            if (!flagWhenMessage)
//            {
//                parent.left
//            }
//        }
//        visible: false
//    }

    Rectangle {
        id: sendFileOrMessage
        x: 449
        y: 4
        width: 49
        height: 48
        color: biruzoviu
        radius: 5

        Image {
            id: image2
            x: 5
            y: 5
            width: 39
            height: 38
            source: "qrc:/resourses/chat/otpravit`.tif"
            fillMode: Image.PreserveAspectFit
            opacity: 1

            MouseArea{
                id: sendMessage
                anchors.fill: parent

                onClicked: {

                    testMap.createNewMessage(textField.text, true);
                    contactsss.setCountIndexMessage(contactsss.getCountIndexMessage());
                    textField.clear();
                    testMap.createNewMessage("My answer", false);
                    contactsss.setCountIndexMessage(contactsss.getCountIndexMessage());


                    console.log("Сообщение отправлено")
                }
            }
        }
    }
}

/*##^##
Designer {
    D{i:0;formeditorZoom:2}D{i:3}D{i:6}
}
##^##*/
