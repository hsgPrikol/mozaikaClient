import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtQuick.Dialogs 1.2
//import Qt.labs.platform 1.0

Window {
    id: root
    width: root.dfltWidth
    height: root.dfltHeight
    visible: true
    title: qsTr("Hello World")

    color: "#000000"

    property var whyNot


    property color biruzoviu: "#068d9d"

    property int dfltWidth: 506
    property int dfltHeight: 900

    property int currentDialogOpen: -1
    property int currentContactOpen: -1
    property string currentCharContactOpen

    property string createChatType: "none"


    property string privateCharReqLogin
    property string privateCharReqName

    ErrorDialog{
        id: errorDialog
        onClicked: {
            errorDialog.show()
        }
    }




    function sendMessage()
    {
        console.log("Вход")

        var passwor = password.text;
        var login = textField.text;

        client.authorization(login, passwor, clientData);
    }



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
            errorDialog.show()
            console.log("Авторизация - Иди в жопу");
        }
    }

    function openPrivateChat(login){
        privateCharReqLogin = login
        privateCharReqName = clientData.getNameContact(login)
        dialogPrivateChat.visible=false
        loader.sourceComponent = privateChat;
    }

    function getdialogs(){
        //        currentDialogs.setDialogs(nenuzhno)
        //        spisok_dialogov = currentDialogs.getMyDialogs()
        //a = 1000 * 555;
        //console.log("------------------------------------");
        //console.log(clientData.getTnps()[0].getName());
        console.log("------------------------------------");
        loader.sourceComponent = listDialog
        //        loader.setSource("ListDialogs.qml");
    }

    function getInviteInPrivat(login, name){
//        loader.sourceComponent = confidenceWidget
        privateCharReqLogin = login
        privateCharReqName = name
        dialogPrivateChat.visible=true
//        loader.sourceComponent = inviteSecretChat


//        client.getReqPrivateChat(login, name)
    }


//    Component{
//        id: inviteSecretChat


//    }

    Component{
        id: confidenceWidget
        ConfidenceWidget{

        }
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
            //            source: "file:///C:/Users/Tihon/Desktop/HackathonApril/build-SuperDesign-3_Desktop_Qt_5_15_2_MinGW_64_bit-Debug/client_garbarge/userAvatar_просто_картинкаMaksim Sergeevich.png"
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
                focus: true
                hoverEnabled: false
                placeholderTextColor: "#404040"
                placeholderText: qsTr("5NR_Operator_27")
                text: "maksim"
                color: "white"

                background: Image {

                    source: "qrc:/resourses/avtorisation/pole_vvoda_avtorization.tif"
                }
            }

            //            MouseArea{
            //                x: 0
            //                y: 0
            //                width:  parent.width / 2
            //                height: parent.height

            //                onClicked: {
            //                    textField.selectAll()
            //                }
            //            }
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
                id: password
                x: 0
                y: 0
                width: 231
                height: 51
                text: "123"
                placeholderText: "********"
                placeholderTextColor: "#404040"

                selectByMouse: true

                echoMode: TextInput.Password

                background: Image {
                    source: "qrc:/resourses/avtorisation/pole_vvoda_avtorization.tif"
                }
                hoverEnabled: false


            }

            //            MouseArea{
            //                x: 0
            //                y: 0
            //                width:  parent.width / 2
            //                height: parent.height

            //                onClicked: {
            //                    password.selectAll()
            //                }
            //            }
        }

        Rectangle {
            id: input
            x: 204
            y: 474
            width: 103
            height: 40
            color: mouseArea.containsPress ? Qt.darker(biruzoviu) : biruzoviu

            radius: input.height / 4

            //            Image {
            //                id: image2
            //                anchors.fill: parent
            //                source: "qrc:/resourses/avtorisation/vhod_avtorisation.tif"



            Text {
                anchors.fill: parent
                color: "#ffffff"



                text: "Вход"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }
            //                    fillMode: Image.PreserveAspectFit


            MouseArea {
                id: mouseArea
                anchors.fill: parent

                hoverEnabled: true

                onClicked: {
                    //вызываем сравнение логина и пароля


                    //                    loader.sourceComponent = audioWidget

                    //                        loader.sourceComponent = authorsWidget
                    //                    supporting.show()
                    root.sendMessage()

                    //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                    //Dialogs.qml
                    //                    loader.setSource("Dialogs.qml")
                    //                    console.log("open new dialog")


                    //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                    //                    ListDialogs.qml
                    //                                        this.visibale = false
                    //                                        loader.setSource("ListDialogs.qml")
                    //                                        console.log("open new Listdialog")


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
        Component.onCompleted: {
//            loader.sourceComponent = mediaTextMessage
            //            console.log(userDialog.getUs());
            console.log("Авторизация загружена")
        }
    }

//    Component{
//        id: audi

//        AudioWidget{

//        }
//    }


//    Component {
//        id: mediaTextMessage
//        MediaTextMessage{
////            flagWhenMessage: true
////            sizeMessage: 111
////            messageText: "2131321321312"
////            countAttachment: 5
////            dfltHeightMul: 1000

//        }
//    }

    Component{
        id: profileMember

        ProfileMember{

        }
    }

    Component {
        id: listDialog

        ListDialogs{

        }
    }

    Component{
        id: userChat

        //        property var tmpDialogId: -1



        UserChat{
            //            id: userChatObject
        }
    }

    Component{
        id: contactsList

        Contacts{

        }
    }

    Component{
        id: settingsNav

        Settings{

        }
    }




    Component.onCompleted: {
        console.log("Авторизация загружена");

        client.onAutorization.connect(autorization);
        client.onGetDialogs.connect(getdialogs);


        client.onGetInvitePrivat.connect(getInviteInPrivat);
        client.onOpenPrivateChat.connect(openPrivateChat);
    }

    Component{
        id: audioWidget

        AudioWidget{

        }
    }


    Component {
        id: fileDialog


        FileDialog {
            id: fileOpenDialog
            title: "Select an image file"
            folder: shortcuts.documents

            //            fileMode: FileDialog.OpenFiles
            nameFilters: [
                "Image files (*.png *.jpeg *.jpg)",
            ]
            onAccepted: {
                //                image2.source = fileOpenDialog.fileUrl
            }
        }
    }

    Loader{
        id: loader

        //        x: 100
        //        y: 100
        //        height: 250
        //        width: 250


        //        source: "Dialogs.qml"
    }




    //componentDialog




    NavigationDrawer{
        id: navDrawer
        x: -506
    }

    Component{
        id: privateChat

        PrivateUserChat{

        }
    }


    DialogPrivateChat{
        id: dialogPrivateChat
        visible: false
        x: 100
        y: 300
    }


}
/*##^##
Designer {
    D{i:0;formeditorZoom:1.5}
}
##^##*/
