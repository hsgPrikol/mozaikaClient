import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtGraphicalEffects 1.0

Rectangle {
    id: mediaTextMessage

    property int dfltHeight: 230
    property int dfltWidth: 300
    property color noColor: "#00000000"

    property int countAttachment: 1
    property int heightAttachment: 230

    property int calcHeightText

    property int calcHeight: (sizeOneLineHeight + 1) * textMessage.lineCount

//    property int heightmulimedua: 230

    property bool flagWhenMessage: true
    property string messageText: "Ay"

    property string attachmentFileName: "filename.wmv"

    property real customOpacity: 0.7

    property int fontSize: 12

    //~~~~~~~~~~~~~~~~~Color~~~~~~~~~~~~~~~~~~~~~~~~
    property color enemyColor: "gray"
    property color selfColor: "#068d9d"
    property color selfColorText: "#ffffff"
    property color enemyColorText: "#000000"

    //~~~~~~~~~~~~~~~~~~Width~~~~~~~~~~~~~~~~~~~~~~~
    property real sizeOnePXWidth: 5
    property int sizeMessage: 10

    //~~~~~~~~~~~~~~~~~~Height~~~~~~~~~~~~~~~~~~~~~~~
    property int sizeOneLineHeight: 14
    property int dfltHeightText: 36
    property int dfltHeightRect: 50

    anchors.leftMargin: 7
    anchors.rightMargin: 7

    anchors.right: {
        if (flagWhenMessage)
        {
            parent.right
        }
    }

    anchors.left: {
        if (!flagWhenMessage)
        {
            parent.left
        }
    }

    width: dfltWidth
    height: calcHeightText + 24 + (heightAttachment + 2) * countAttachment

    color: flagWhenMessage ? selfColor : enemyColor
    radius: 15

    Column{
        Rectangle {
            id: maskTextMessage
            width: dfltWidth
            height: {
                if (textMessage.lineCount == 1 || textMessage.lineCount == 2)
                {
                    dfltHeightRect
                    calcHeightText = dfltHeightRect
                }
                else
                {
                    calcHeight + 14
                    calcHeightText = calcHeight + 14
                }
            }
            color: noColor

            Text {
                id: textMessage
                anchors.fill: parent
//                anchors.right: parent.right
//                anchors.left: parent.left
//                anchors.bottom: timeMessage.top
//                anchors.top: parent.top
        //        anchors.topMargin: 10
                anchors.leftMargin: 10
                anchors.rightMargin: 10
        //        width: 100
                height: {
                    if (calcHeight < 50)
                    {
                        dfltHeightText - 10
                    }
                    else
                    {
                        calcHeight
                    }
                }

                text: messageText
                font.pixelSize: 12
                verticalAlignment: Text.AlignVCenter
//                leftPadding: 10
                color: flagWhenMessage ? selfColorText : enemyColorText

                wrapMode: Text.Wrap
            }
        }

        Column {
            id: columnMaskMedia
//            x: 0
//            y: 35

            spacing: 2

            Repeater{
                id: repeaterMediaGroup

                anchors.fill: parent
                model: countAttachment

                Rectangle {
                    id: mediaMask
                    width: dfltWidth
                    height: 230
                    color: noColor

                    MediaWidget{
                        anchors.fill: parent
                        fileNameText: attachmentFileName
                    }                
                }
            }
        }
        Rectangle {
            id: timeMask
            width: dfltWidth
            height: 24
            color: noColor
        }
    }
}

/*##^##
Designer {
    D{i:0;formeditorZoom:1.5}D{i:7;locked:true}
}
##^##*/
