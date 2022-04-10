import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtGraphicalEffects 1.0

Rectangle {
    id: root

    property int dfltWidth: 506
    property int dfltHeight: 100
    property color noColor: "#00000000"
    property real customOpacity: 0.7
    property color biruzoviu: "#068d9d"

    property int fontSize: 20

    property int indexRepeaterChar: 0
    property string textRepeaterContactsName: "Balbes Balbesovich"
    property string textRepeaterChar: "s"


    property int dfltHeightContactList: 84

    width: dfltWidth
    height: dfltHeight
//    border.width: 1
//    border.color: "white"

    color: noColor

    Rectangle {
        id: rootCharContact
        width: 50
        height: 50
        color: noColor

        Text {
            id: rootCharContactText
            color: "#ffffff"
            anchors.fill: parent
            text: textRepeaterChar
            font.pixelSize: fontSize
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter

            Component.onCompleted: {
                // console.log("textRepeaterChar", textRepeaterChar)
            }
        }
    }

    Column {
        id: columnContactList

        Repeater{
            id: repeaterPage
            model: contactsss.getVectorSize(indexRepeaterChar)

            Component.onCompleted: {
                //console.log("contactsss.getVectorSize(indexRepeaterChar)", contactsss.getVectorSize(indexRepeaterChar))
            }

            Rectangle {
                id: contactPageMain
                x: 50
                y: 8
                width: 448
                height: 84
                color: noColor

                Rectangle {
                    id: contactPageAvatar
                    x: 0
                    y: 0
                    width: 84
                    height: parent.height
                    color: noColor

                    Rectangle {
                        id: contactPageAvatarMask
                        x: 10
                        y: 10
                        width: 64
                        height: 65
                        color: "#ffffff"
                        radius: contactPageAvatarMask.width / 2


                        Image {
                            id: image1
                            anchors.fill: parent
                            fillMode: Image.PreserveAspectCrop
                            source: "qrc:/resourses/avatar/cop.tif"
                            layer.enabled: true
                            layer.effect: OpacityMask {
                                maskSource: parent
                            }
                        }
                    }

                    Rectangle {
                        x: 80
                        y: 0
                        width: 367
                        height: 84
                        color: noColor

                        Text {
                            property int fontSize: 20
                            id: textName
                            anchors.fill: parent
                            text: contactsss.getName(textRepeaterChar,index)
                            font.pixelSize: textName.fontSize
                            color: "white"
                            verticalAlignment: Text.AlignVCenter
                            leftPadding: 10
                        }
                    }
                }
            }


//            Rectangle {
//                id: contactPage
//                x: 56
//                y: 8
//                width: 442
//                height: 84
//                color: noColor
//                border.width: 1
//                border.color: "black"

//                Text {
//                    color: "#ffffff"
//                    anchors.fill: parent
//                    anchors.leftMargin: 10
//                    text: contactsss.getName(textRepeaterChar,index)
//                    font.pixelSize: 30
//                    verticalAlignment: Text.AlignVCenter
//                    Component.onCompleted: {
//                        console.log("textRepeaterContactsName", textRepeaterContactsName)
//                    }
//                }
//            }
        }
    }

    Rectangle {
        id: rootLineCharList
        y: 0
        anchors.top: rootCharContact.bottom
        anchors.topMargin: 10
        anchors.bottomMargin: 10
        anchors.horizontalCenter: rootCharContact.horizontalCenter
        width: 2
        height: repeaterPage.model * dfltHeightContactList - 70
        color: "#ffffff"
    }




//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//    Rectangle {
//        id: contactPageMain
//        x: 50
//        y: 8
//        width: 448
//        height: 84
//        color: noColor

//        Rectangle {
//            id: contactPageAvatar
//            x: 0
//            y: 0
//            width: 84
//            height: parent.height
//            color: noColor

//            Rectangle {
//                id: contactPageAvatarMask
//                x: 10
//                y: 10
//                width: 64
//                height: 65
//                color: noColor


//                Image {
//                    id: image1
//                    anchors.fill: parent
//                    fillMode: Image.PreserveAspectCrop
//                    source: "qrc:/resourses/avatar/cop.tif"
//                    layer.enabled: true
//                    layer.effect: OpacityMask {
//                        maskSource: parent
//                    }
//                }
//            }

//            Rectangle {
//                x: 80
//                y: 0
//                width: 367
//                height: 84
//                color: noColor

//                Text {
//                    id: textName
//                    anchors.fill: parent
//                    text: contactsss.getName(textRepeaterChar,index)
//                    font.pixelSize: 30
//                    verticalAlignment: Text.AlignVCenter
//                    leftPadding: 10
//                }
//            }
//        }
//    }




//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
}

/*##^##
Designer {
    D{i:0;formeditorZoom:1.5}
}
##^##*/
