import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

Rectangle {
    id: listDialog

    width: dfltWidth
    height: dfltHeight

    property int dfltWidth: 506
    property int dfltHeight: 900
    property color noColor: "#00000000"
    property real customOpacity: 0.7
    property color biruzoviu: "#068d9d"

    property var tmpNewDialog

    color: noColor

    property int countRep: 6
    function addNewDialogs()
    {
        var tmpDialog = tmpNewDialog.createObject(columnDialogs,
                                                  {



                                                  });

        repDialogs.itemAdded(++countRep ,tmpDialog)
        console.log(repDialogs.model)

    }

    function showDialog()
    {
        loader.sourceComponent  = userChat
    }


    Rectangle{
        id: root
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

        Drawer {
            id: drawer
            width: Math.min(dfltWidth, dfltHeight) / 3 * 2
            height: parent.height

            ListView{
                focus: true
                currentIndex: 0
                anchors.fill: parent

                delegate: ItemDelegate {
                    width: parent.width
                    text: model.text
                    highlighted: ListView.isCurrentItem
                    onClicked: {
                        drawer.close()
                        model.triggered()
                    }
                }

                model: ListModel {
                    ListElement {
                        text: qsTr("Open...")
                        triggered: function()


                        {
                            console.log("Open...")
                        }
                    }
                    ListElement {

                        text: qsTr("About...")
                        triggered: function()
                        {
                            console.log("About...");
                        }
                    }
                }

                ScrollIndicator.vertical: ScrollIndicator { }
            }
        }

        Rectangle {
            id: rectangle
            x: 0
            y: 0
            width: 506
            height: 60
            color: "#068d9d"

            Rectangle {
                id: rectangle1
                x: 0
                y: 0
                width: 117
                height: 60
                color: "#00000000"

                Image {
                    id: image
                    x: 8
                    y: 0
                    width: 40
                    height: 60
                    source: "qrc:/resourses/resourses v4/ri_tochki.tif"
                    fillMode: Image.PreserveAspectFit


                }
                MouseArea {
                    anchors.fill: parent

                    onClicked: {
                        navDrawer.showNavDrawer()
                        console.log("navDrawer.showNavDrawer()")
                    }
                }
            }

            Rectangle {
                id: rectangle2
                x: 195
                y: 0
                width: 117
                height: 60
                color: "#00000000"

                Text {
                    id: text2
                    x: 0
                    y: 0
                    width: 117
                    height: 60
                    color: "#ffffff"
                    text: qsTr("Диалоги")
                    font.pixelSize: 20
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
            }

            Rectangle {
                id: rectangle3
                x: 389
                y: 0
                width: 117
                height: 60
                color: "#00000000"

                Image {
                    id: image1
                    x: 44
                    y: 8
                    width: 65
                    height: 44
                    source: "qrc:/picture/luppa.tif"
                    fillMode: Image.PreserveAspectFit
                }
            }
        }

        property int sizeDialogs: 10

        ScrollView {
            id: scrollView
            anchors.topMargin: 6
            anchors.bottomMargin: 0
            anchors.top: rectangle.bottom
            anchors.right: rectangle.right
            anchors.left: rectangle.left
            anchors.bottom: parent.bottom

            contentHeight: repDialogs.model * (columnDialogs.spacing + dialogs.dfltHeight)
            contentWidth: parent.width
            clip: true

            Column {
                id: columnDialogs
                anchors.fill: parent
                spacing: 10

                Repeater {
                    id: repDialogs
                    anchors.fill: parent
                    model: clientData.getCountDialogs()

                    Dialogs {
                        id: dialogs
//                        anchors.horizontalCenter: parent.horizontalCenter

                        MouseArea{
                           anchors.fill: parent

                            onClicked: {
                                currentDialogOpen = index
                                client.getMessagesInDialog(clientData.getIdDialog(index))
                                client.onGetMessages.connect(showDialog);
                                client.onUpda

                            }
                        }

                        nameFamilia: clientData.getNameDialog(index)
//                        avatarClients: "file:///C:/Users/rota/Documents/build-SuperDesign-MinGW64-Debug/" + clientData.getPathAvatar(index)
                         avatarClients: clientData.getPathAvatar(index) != ""?"file:///" +currentDir+"/" + clientData.getPathAvatar(index):"qrc:/resourses/avatar/cop.tif"

                        lastMessageUser: clientData.getTextLastMessage(index)
                        timeMessage: clientData.getDateLastMessage(index)
                        isChecked: clientData.getIsCheckedLastMessage(index)
                        isGroup: clientData.getDialogIsGroup(index)
                        isOnline: clientData.getDialogIsOnline(index)
                        countUnChecked: clientData.getDialogCountUnChecked(index)

                    }
                }
            }
        }

        Rectangle {
            id: addNewDialogMask
            x: 434
            y: 828
            width: 72
            height: 72

            anchors.right: root.right
            anchors.rightMargin: 15

            anchors.bottom: root.bottom
            anchors.bottomMargin: 15

            radius: addNewDialogMask.width / 7

            opacity: customOpacity

            color: addNewDialogMouse.containsPress ? Qt.lighter(biruzoviu) : biruzoviu

            Image {
                id: addNewDialog
                x: 11
                y: 11
                width: 50
                height: 50
                source: "qrc:/resourses/create chat_2.tif"
                fillMode: Image.PreserveAspectFit
            }

            MouseArea{
                id: addNewDialogMouse
                anchors.fill: parent

                onClicked: {
//                    loader.sourceComponent = contactsList


                    var str = "123213"
                    testMap.createNewDialog(str)


                    console.log("loader.source = contactsList")
                }
            }
        }
    }

    Component.onCompleted: {

        testMap.onCreateNewDialog.connect(addNewDialogs)
        tmpNewDialog = Qt.createComponent("Dialogs.qml");
    }
}

/*##^##
Designer {
    D{i:0;formeditorZoom:1.33}
}
##^##*/
