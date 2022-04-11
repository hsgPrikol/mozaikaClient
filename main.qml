import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

Window {
    id: root
    width: root.dfltWidth
    height: root.dfltHeight
    visible: true
    title: qsTr("Hello World")

    color: "#000000"

    property int dfltWidth: 506
    property int dfltHeight: 900





    function autorization(name, avatar, birthDay, status)
    {
        if (status)
        {

            currentUser.setAvatarFile(avatar)
            currentUser.setName(name)
            currentUser.setLogin(textField.text)
            currentUser.setBirthDate(birthDay)
            client.getMyDialogs()
            console.log("Авторизация - И");
        }
        else
        {
            console.log("Авторизация - Иди в жопу");
        }
    }

    function getdialogs(){
//        currentDialogs.setDialogs(nenuzhno)
//        spisok_dialogov = currentDialogs.getMyDialogs()
        //a = 1000 * 555;
        //console.log("------------------------------------");
        //console.log(clientData.getTnps()[0].getName());
        console.log("------------------------------------");
        loader.setSource("ListDialogs.qml");
    }

    //autorization
    Rectangle{
        anchors.fill: parent
        width: parent.width
        height: parent.height
        color: "#000000"

        Image {
            id: mainPhone
            anchors.fill: parent
            source: "qrc:/picture/phone.tif"
//            source: "file:///C:/Users/Tihon/Desktop/HackathonApril/SuperDesign/ava.png"
            opacity: 0.7

            Component.onCompleted: {
                console.log(source)
            }
        }

        Rectangle {
            id: rectangle
            x: 156
            y: 268
            width: 195
            height: 60
            color: "#00000000"

            Text {
                id: text1
                x: 0
                y: 0
                width: 195
                height: 60
                color: "#ffffff"
                text: qsTr("Авторизация")
                font.pixelSize: 20
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                styleColor: "#000000"
            }
        }

        Rectangle {
            id: rectangle1
            x: 55
            y: 334
            width: 164
            height: 51
            color: "#00000000"

            Image {
                id: image
                width: 164
                height: 51
                source: "qrc:/resourses/avtorisation/nadpis`_parol`_ili_login.tif"
                opacity: 0.7

                //                    fillMode: Image.PreserveAspectFit
            }

            Text {
                id: text2
                x: 0
                y: 0
                width: 164
                height: 51
                color: "#000000"
                text: qsTr("Логин")
                font.pixelSize: 12
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }
        }

        Rectangle {
            id: rectangle2
            x: 204
            y: 334
            width: 231
            height: 51
            color: "#00000000"
            radius: 0

            TextField {
                id: textField
                x: 0
                y: 0
                width: 231
                height: 51
                hoverEnabled: false
                placeholderTextColor: "#ffffff"
                placeholderText: qsTr("5NR_Operator_27")
                text: "maksim"
                color: "white"

                background: Image {

                    source: "qrc:/resourses/avtorisation/pole_vvoda_avtorization.tif"
                }
            }
        }

        Rectangle {
            id: rectangle3
            x: 55
            y: 400
            width: 164
            height: 51
            color: "#00000000"
            Image {
                id: image1
                width: 164
                height: 51
                opacity: 0.7
                source: "qrc:/resourses/avtorisation/nadpis%60_parol%60_ili_login.tif"
            }

            Text {
                id: text3
                x: 0
                y: 0
                width: 164
                height: 51
                color: "#000000"
                text: qsTr("Пароль")
                font.pixelSize: 12
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }
        }

        Rectangle {
            id: rectangle4
            x: 204
            y: 400
            width: 231
            height: 51
            color: "#00000000"
            radius: 0
            TextField {
                id: textField1
                x: 0
                y: 0
                width: 231
                height: 51
                text: "123"
                color: "white"
                placeholderText: "********"
                placeholderTextColor: "#ffffff"
                background: Image {
                    source: "qrc:/resourses/avtorisation/pole_vvoda_avtorization.tif"
                }
                hoverEnabled: false
            }
        }

        Rectangle {
            id: rectangle5
            x: 204
            y: 474
            width: 103
            height: 40
            color: "#00000000"

            Image {
                id: image2
                anchors.fill: parent
                source: "qrc:/resourses/avtorisation/vhod_avtorisation.tif"

                Text {
                    anchors.fill: parent
                    color: "#ffffff"

                    text: "Вход"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
//                    fillMode: Image.PreserveAspectFit
            }

            MouseArea {
                id: mouseArea
                anchors.fill: parent


                onClicked: {
                    //вызываем сравнение логина и пароля
                    console.log("Вход")

                    var password = textField1.text;
                    var login = textField.text;

                   client.authorization(login, password, clientData);



//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                    //Dialogs.qml
//                    loader.setSource("Dialogs.qml")
//                    console.log("open new dialog")


//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                    //ListDialogs.qml
//                    loader.setSource("ListDialogs.qml")
//                    console.log("open new Listdialog")


//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                    //NavigationDrawer.qml
//                    loader.setSource("NavigationDrawer.qml")
//                    console.log("NavigationDrawer.qml")


//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                    //UserChat.qml
//                    loader.setSource("UserChat.qml")
//                    console.log("UserChat.qml")

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                    //Message.qml
//                    loader.setSource("Massage.qml")
//                    console.log("Massage.qml")

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                    //Contacts.qml
//                    loader.setSource("Contacts.qml")
//                    console.log("Contacts.qml")

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                    //ContactsChar.qml
//                    loader.setSource("ContactsChar.qml")
//                    console.log("ContactsChar.qml")

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                    //Settings.qml
//                    loader.setSource("Settings.qml")
//                    console.log("Settings.qml")



                }
            }
        }

//        Component {
//            //id:
//        }

        Component.onCompleted: {
            console.log("Авторизация загружена");

            client.onAutorization.connect(autorization);
            client.onGetDialogs.connect(getdialogs);
        }
    }


    //componentDialog
    Loader{
        id: loader
//        source: "Dialogs.qml"
    }




}
    /*##^##
Designer {
    D{i:0;formeditorZoom:1.5}
}
##^##*/
