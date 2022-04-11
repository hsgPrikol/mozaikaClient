import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtGraphicalEffects 1.0
import QtMultimedia 5.12

Rectangle{
    width: 200
    height: 200
    color: "#00000000"
    border.color: "black"
    border.width: 1

    property bool flagWhenMessage: true

    anchors.right: {
        if (flagWhenMessage)
            parent.right

    }
    anchors.left: {
        if (!flagWhenMessage)
            parent.left
    }

    property bool isPlay: true

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
                    videoMesage.play()
                else
                    videoMesage.stop()

                isPlay = !isPlay
            }
        }
        Component.onCompleted: {
            videoMesage.play()
        }
    }
}
