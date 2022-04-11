import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtGraphicalEffects 1.0

Rectangle {
    id: contacts

    property int dfltWidth: 506
    property int dfltHeight: 900
    property color noColor: "#00000000"
    property real customOpacity: 0.7
    property color biruzoviu: "#068d9d"

    property int sizeHeightRectName: 84

    property int fontSize: 14

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
            opacity: customOpacity
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
                    text: qsTr("Контакты")
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
                MouseArea{
                    anchors.fill: parent

                    onClicked: {
                        loader.sourceComponent = listDialog
                    }
                }
            }
        }

        Rectangle {
            id: rectangle4
            x: 0
            y: 59
            width: 506
            height: 841
            color: "#00000000"

            ScrollView{
                id: scrollContacts
                anchors.fill: parent
                width: parent.width
                height: parent.height
                contentWidth: parent.width
                contentHeight: contactsss.getAllVectorSize() * sizeHeightRectName

                clip: true

                Column{
                    id: columnContact
                    anchors.fill: parent
//                    width: parent.width
//                    height: parent.height

                    Repeater{
                        id: repSymbol
                        anchors.fill: parent

                        model: contactsss.getMapSize()

                        Component.onCompleted: {
                            console.log("contactsss.getMapSize()", contactsss.getMapSize())
                        }

                        ContactsChar {
                            dfltHeight: contactsss.getVectorSize(index) * sizeHeightRectName
                            indexRepeaterChar: index
                            textRepeaterChar: contactsss.getSymbol(index)
//                            textRepeaterContactsName: contactsss.getName(index)

                            Component.onCompleted: {
                                console.log("ContactsChar{}textRepeaterContactsName", textRepeaterContactsName)
                            }
                        }
                    }
                }
            }
        }
    }
}

/*##^##
Designer {
    D{i:0;formeditorZoom:0.5}
}
##^##*/
