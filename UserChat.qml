import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtGraphicalEffects 1.0

Rectangle {
    id: chatDialog

    property int dfltWidth: 506
    property int dfltHeight: 900
    property color noColor: "#00000000"
    property real customOpacity: 0.7
    property color biruzoviu: "#068d9d"


    property int heightToolBar: 60
    property int countIndexVessage: 0


    property int fontSize: 14

    property var newMassege

    property var newMediaMessage

    function scrollToBottom()
    {
        scrollChat.ScrollBar.vertical.position = 1 - scrollChat.ScrollBar.vertical.size
    }


    function createMediaMessage()
    {
        var tmp = newMediaMessage.createObject(columnChat,
                                               {
                                                   flagWhenMessage: false
                                               });
    }

    function ebaka(){
//        repeaterChat.model = 0

        clientData.setAllReadMessageInDialog(currentDialogOpen);

        for(var i = 0; i < columnChat.data.length;i++)
        {
            columnChat.data[i].destroy()
        }

        for(var i=0;i < clientData.getCountMessages(currentDialogOpen);i++)
        {            
            var str="file:///" +currentDir+"/" +clientData.getAvatarPathContact(currentDialogOpen,i);
            console.log(str)
            var tmp=newMassege.createObject(columnChat,
                                            {
                                                sizeMessage: clientData.getLength(clientData.getTextMessage(currentDialogOpen,i)),
                                                messageText: clientData.getTextMessage(currentDialogOpen,i),
                                                flagWhenMessage: clientData.getIsSenderMessage(currentDialogOpen,i),
                                                messageTime: clientData.getDateMessage(currentDialogOpen,i),
                                                messageStatus: 3,
                                                avatarClient: str,
                                                isGroupDialog: clientData.getDialogIsGroup(currentDialogOpen)

                                            });
        }

        scrollToBottom();
    }

    function updateStatusMessage(d_id, m_id, status){
        if(clientData.getIdDialog(currentDialogOpen)==d_id)
        {
            ebaka()
        }
    }

    function updateChat(id_chat){

//        if(loader.sourceComponent == userChat)
//        {
            if(clientData.getIdDialog(currentDialogOpen) == id_chat)
            {

                ebaka()
                //client.getMessagesInDialog(clientData.getIdDialog(currentDialogOpen))

                //console.log("messageAnswer.lenght", messageAnswer.size())
//                repeaterChat.update()
            }
//        }
    }

    width: dfltWidth
    height: dfltHeight

    color: noColor

    Rectangle{
        anchors.fill: parent
        width: parent.width
        height: parent.height
        color: "black"

        Image {
            id: mainPhone
            anchors.fill: parent
            source: "qrc:/picture/phone.tif"
            opacity: 0.7
        }


        Rectangle {
            id: rectangle2
            x: 0
            y: 0
            width: parent.width
            height: heightToolBar
            color: biruzoviu

            Rectangle {
                id: rectangle
                x: 114
                y: 0
                width: 278
                height: heightToolBar
                color: noColor

                Rectangle {
                    id: rectangle1
                    width: rectangle1.height
                    height: heightToolBar
                    color: noColor
                    Rectangle {
                        id: rectangle5
                        x: 8
                        y: 8
                        width: 44
                        height: 44
                        color: "#ffffff"
                        radius: rectangle5.width / 2
                        Image {
                            id: image1
                            x: 8
                            y: 8
                            anchors.fill: parent
                            source: clientData.getPathAvatar(currentDialogOpen) ==""?"qrc:/resourses/avatar/efreitor.tif":"file:///" +currentDir+"/" + clientData.getPathAvatar(currentDialogOpen)
                            layer.enabled: true
                            anchors.rightMargin: 0
                            layer.effect: OpacityMask {
                                maskSource: parent
                            }
                            fillMode: Image.PreserveAspectCrop
                            anchors.leftMargin: 0
                            anchors.bottomMargin: 0
                        }
                    }
                }


                Rectangle {
                    id: rectangle3
                    x: 60
                    y: 0
                    width: 218
                    height: 30
                    color: noColor
                    Text {
                        id: text2
                        color: "#ffffff"
                        text: clientData.getNameDialog(currentDialogOpen)
                        anchors.fill: parent
                        font.pixelSize: fontSize
                        verticalAlignment: Text.AlignVCenter
                        anchors.leftMargin: 10
                    }
                }

                Rectangle {
                    id: rectangle4
                    x: 60
                    y: 30
                    width: 218
                    height: 30
                    color: noColor
                    Text {
                        id: text1
                        color: "#ffffff"
                        text: clientData.getDialogIsGroup(currentDialogOpen) ? clientData.getCountMembers(currentDialogOpen) + " участника" : (clientData.getDialogIsOnline(currentDialogOpen)? "в сети" : "не в сети")
                        anchors.fill: parent
                        font.pixelSize: fontSize
                        verticalAlignment: Text.AlignVCenter
                        anchors.leftMargin: 10
                    }
                }
            }

            Rectangle {
                id: rectangle6
                x: 0
                y: 0
                width: heightToolBar
                height: heightToolBar
                color: noColor

                Image {
                    id: image
                    x: 8
                    y: 0
                    width: 40
                    height: heightToolBar
                    source: "qrc:/resourses/resourses v4/ri_tochki.tif"
                    fillMode: Image.PreserveAspectFit

                    MouseArea {
                        id: mouseArea
                        anchors.fill: parent

                        onClicked: {
                            navDrawer.showNavDrawer()
                            console.log("navDrawer.showNavDrawer()")
                        }
                    }
                }
            }

            Rectangle {
                id: rectangle7
                x: 446
                y: 0
                width: 60
                height: heightToolBar
                color: noColor

                Image {
                    id: image2
                    anchors.fill: parent
                    source: "qrc:/picture/arrow.tif"
                    anchors.leftMargin: 7
                    anchors.topMargin: 7
                    anchors.rightMargin: 7
                    anchors.bottomMargin: 7
                    fillMode: Image.PreserveAspectFit

                    MouseArea{
                        anchors.fill: parent

                        onClicked: {
                            loader.sourceComponent = listDialog
                            //                            loader1.source = "ListDialogs.qml"
                        }
                    }
                }
            }
        }

        Rectangle {
            id: messageZone
            x: 0
            y: 61
            width: parent.width
            height: 839
            color: "#00000000"

            Rectangle {
                id: zoneChat
                x: 0
                y: 0
                anchors.top: rectangle2.bottom
                anchors.topMargin: 5
                width: parent.width
                height: 782
                color: "#00000000"


                ScrollView{
                    id: scrollChat
                    anchors.fill: parent
                    anchors.rightMargin: 0
                    anchors.leftMargin: 0
                    anchors.topMargin: 2
                    anchors.bottomMargin: 8

                    contentWidth: parent.width
//                    contentHeight: repeaterChat.model * (columnChat.spacing + message.height)

                    clip: true
                    //                    LayoutMirroring.enabled: true

//                    property var t: repeaterChat.model * (columnChat.spacing + message.height)
//                    ScrollBar.vertical.position: t


                    Column{
                        id: columnChat
                        anchors.fill: parent

                        spacing: 15

                        Rectangle{
                            width: 1
                            height: date.height - 10
                            color: "#00000000"
                        }

//                        Repeater{
//                            id: repeaterChat
//                            anchors.fill: parent

//                            model: clientData.getCountMessages(currentDialogOpen)

//                            Massage{
//                                id: message

//                                messageText: clientData.getTextMessage(currentDialogOpen, index)
//                                flagWhenMessage: clientData.getIsSenderMessage(currentDialogOpen, index)//testBoolArray[index]
//                                messageTime: clientData.getDateMessage(currentDialogOpen, index)
//                                sizeMessage: clientData.getSizeTextMessage(currentDialogOpen, index)
//                                messageStatus: clientData.getStatusMessage(currentDialogOpen, index)


//                                Component.onCompleted: {
//                                    console.log(repeaterChat.model)
//                                    console.log(index)

//                                    contactsss.setCountIndexMessage(countIndexVessage++)
//                                }
//                            }


//                        }
                    }

                    onContentHeightChanged: {
                        scrollToBottom();
//                        repeaterChat.update()
                    }

                    Component.onCompleted: {
                        scrollToBottom();

                    }

                }
            }

            DownBar {
                id: downBar
//                anchors.top: scrollChat.bottom
                anchors.right: parent.right
                anchors.left: parent.left
                anchors.bottom: parent.bottom
                //                currentDialogDownBar: currentDialog
            }
        }

        Rectangle {
            id: date
            x: 213
            y: 61
            width: 81
            height: 30
            color: "#ffffff"
            radius: 5
            opacity: customOpacity

            Text {
                id: text3
                anchors.fill: parent
                text: qsTr("Сегодня")
                font.pixelSize: 12
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }
        }
    }
    Component.onCompleted: {
        console.log("UserChar open");
        newMassege = Qt.createComponent("Massage.qml");

        newMediaMessage = Qt.createComponent("ForTest.qml");

//        client.onUpdateStatusMessage.connect(updateStatusMessage)
//        client.onMessageReceived.connect(updateChat);

//        testMap.onCreateNewMassage.connect(creareNewMessage);

//        testMap.onMediaMessage.connect(createMediaMessage)
        client.onUpdateChat.connect(updateChat)

    }
}

/*##^##
Designer {
    D{i:0;formeditorZoom:1.5}
}
##^##*/
