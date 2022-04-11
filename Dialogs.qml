import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtGraphicalEffects 1.0

Rectangle {
    id: rootDialog
    width: dfltWidth
    height: dfltHeight

    property int dfltWidth: 446
    property int dfltHeight: 100
    property color noColor: "#00000000"
    property real customOpacity: 0.7

    color: rootDialog.noColor


    property var nameFamilia

    property var avatarClients:"qrc:/resourses/avatar/cop.tif"

    property var timeMessage: "Когда-то"

    property var lastMessageUser

    //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

    //много проверти для забирания данных с класса user и message


//    property type name: value
//    property type name: value
//    property type name: value
//    property type name: value


    //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


    Image {
        id: image
        anchors.fill: parent
        source: "qrc:/resourses/kontacti/uvedomlenie_o_soobshenii.tif"
        opacity: rootDialog.customOpacity
    }

    //общий
    Rectangle {
        id: rectangle
        anchors.fill: parent
        color: rootDialog.noColor


        Rectangle {
            id: rectangle1
            x: 99
            y: 0
            width: 280
            height: 50
            color: rootDialog.noColor

            Text {
                id: text1
                x: 0
                y: 0
                width: 280
                height: 50
                text: nameFamilia
                font.pixelSize: 12
                verticalAlignment: Text.AlignVCenter
            }
        }

        Rectangle {
            id: rectangle2
            x: 99
            y: 50
            width: 280
            height: 50
            color: rootDialog.noColor

            Text {
                id: text2
                x: 0
                y: 0
                width: 280
                height: 50
                text: lastMessageUser
                font.pixelSize: 12
                font.bold: true
                verticalAlignment: Text.AlignTop
            }
        }

        Rectangle {
            id: rectangle3
            x: 379
            y: 78
            width: 67
            height: 22
            color: rootDialog.noColor

            Text {
                id: text3
                anchors.fill: parent
                text: timeMessage
                font.pixelSize: 12
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }
        }
        Rectangle{
            id: mask
            x: 0
            y: 0
            width: 100
            height: 100
            color: rootDialog.noColor
            clip: true

            Rectangle{
                width: parent.width - 30
                height: parent.height - 30
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                radius: 35
                border.width: 1
                border.color: "#068d9d"
                clip: true


                Image {
                    id: image1
                    anchors.fill: parent
                    fillMode: Image.PreserveAspectCrop
                    source: avatarClients
                    anchors.rightMargin: 8
                    anchors.bottomMargin: 7
                    anchors.leftMargin: 8
                    anchors.topMargin: 8

                    layer.enabled: true
                    layer.effect: OpacityMask {
                        maskSource: parent
                    }
                }
            }                //                    fillMode: Image.PreserveAspectCrop
        }

        Rectangle {
            id: rectangle4
            x: 379
            y: 0
            width: 67
            height: 78
            color: rootDialog.noColor
        }

        Rectangle {
            id: rectangle6
            x: 391
            y: 17
            width: 44
            height: 44
            color: "#068d9d"
            radius: 7

            Text {
                id: text4
                x: -12
                y: -17
                color: "#ffffff"
                text: qsTr("2")
                anchors.fill: parent
                font.pixelSize: 12
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }
        }

        Rectangle {
            id: rectangle5
            x: 22
            y: 69
            width: 12
            height: 12
            color: "#068d9d"
            radius: 6
        }

    }
    MouseArea{
        anchors.fill: parent

        onClicked: {

            console.log("Открыть диалог с данным юзером" + index)
        }
    }

    Component{
        id: componen

        UserChat{

        }
    }
}


/*##^##
Designer {
    D{i:0;formeditorZoom:2}
}
##^##*/
