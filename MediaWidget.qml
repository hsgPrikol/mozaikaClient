import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtGraphicalEffects 1.0
import QtMultimedia 5.12

Rectangle{
    id: messageMultimedia

    width: 300
    height: 230
    color: "#00000000"
    //    border.color: "black"
    //    border.width: 1

    property bool flagWhenMessage: true

    property string fileNameText

    property int customHeight: 200

    anchors.right: {
        if (flagWhenMessage)
            parent.right

    }
    anchors.left: {
        if (!flagWhenMessage)
            parent.left
    }

    property bool isPlay: true

    Rectangle{
        id: videoMesageMask
        width: parent.width
        height: customHeight
        anchors.fill: parent
        anchors.bottomMargin: 0
        anchors.leftMargin: 0
        color: noColor
        Video{
            id: videoMesage
            anchors.fill: parent
            width: parent.width
            height: parent.height

            source: "file:///C:/Users/rota/Pictures/Camera Roll/WIN_20220124_10_16_51_Pro.mp4"

            MouseArea{
                anchors.fill: parent

                onClicked: {

                    if (isPlay)
                        videoMesage.pause()
                    else
                        videoMesage.play()

                    isPlay = !isPlay
                }
            }
        }

        MouseArea{
            id: mouseContent
            anchors.fill: parent

            hoverEnabled: true

            onClicked: {

            }
        }
    }

    Rectangle{
        width: parent.width
        height: customHeight
        color: "gray"
        visible: mouseContent.containsPress ? false : true
        opacity: 0.3


    }

    Rectangle{
        x: 0
        y: customHeight
        width: parent.width
        height: 30
        color: noColor
//        border.width: 1
//        border.color: "black"
        Text{
            x: 0
            y: 0
            width: customHeight
            height: 30
            text: fileNameText + "sssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss"
            elide: Text.ElideRight
            verticalAlignment: Text.AlignVCenter
            leftPadding: 10
        }

        MouseArea{
            anchors.fill: parent

            onClicked: {

            }
        }
    }

    Component.onCompleted: {
        videoMesage.play()
        videoMesage.pause()
    }

}

/*##^##
Designer {
    D{i:0;formeditorZoom:1.66}
}
##^##*/
