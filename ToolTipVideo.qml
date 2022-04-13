import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtGraphicalEffects 1.0
import QtMultimedia 5.12

Rectangle{
    color: "transparent"
    width: 300
    height: 200
    //    opacity: 0.3

    property int sizeVideo: videoMessage.duration / 10 / 60
    property real procentVideo: videoMessage.duration / 100 / 1000
    property int secondVideo: videoMessage.duration / 1000 / 60 / 100
    property int minuteVideo: 0
    property int minuteSizeVideo: sizeVideo / 100
    property int secondSizeVideo: sizeVideo % 100

    Rectangle {
        id: mask
        x: 0
        y: 0
        width: 300
        height: 200
        color: "transparent"

        Image {
            id: startstop
            x: 125
            y: 75
            width: 50
            height: 50
            source: "qrc:/picture/button/play.png"
            fillMode: Image.PreserveAspectFit
            scale: mouseStartstop.containsPress ? 1.2 : 1

            MouseArea{
                id: mouseStartstop
                anchors.fill: parent
                onClicked: {
                    if (!isPlay)
                    {
                        videoMessage.pause()
                        timerVideo.stop()
                        startstop.source = "qrc:/picture/button/play.png"
                        isPlay = !isPlay
                    }
                    else
                    {
                        videoMessage.play()
                        timerVideo.start()
                        startstop.source = "qrc:/picture/button/pause.png"
                        isPlay = !isPlay
                    }
                }
            }
        }

        Image {
            id: zoom
            x: 250
            y: 0
            width: 50
            height: 50
            source: "qrc:/picture/button/scale.png"
            fillMode: Image.PreserveAspectFit
            scale: mouseZoom.containsPress ? 1.2 : 1

            MouseArea{
                id: mouseZoom
                anchors.fill: parent

                hoverEnabled: true

                onClicked: {

                }
            }

        }

        Timer{
            id: timerVideo
            interval: 1000;
            running: false;
            repeat: true
            onTriggered: {
                progressBar.value += procentVideo
                secondVideo +=1
//                console.log(progressBar.value)

                if (secondVideo == 60)
                {
                    minuteVideo++;
                    secondVideo = 0;
                }
            }
        }


        ProgressBar {
            id: progressBar
            x: 35
            y: 184
            width: 230
            height: 8
            value: 0
            from: 0
            to: sizeVideo
        }

        Text {
            id: text1
            x: 8
            y: 168
            width: 42
            height: 17
            text:
            {
                if (secondVideo < 10)
                {
                    minuteVideo + ":0" + secondVideo
                }
                else
                {
                    minuteVideo + ":" + secondVideo
                }
            }

            font.pixelSize: 12
        }

        Text {
            id: text2
            x: 250
            y: 168
            width: 42
            height: 17
            text: minuteSizeVideo + ":" + secondSizeVideo
            font.pixelSize: 12
        }
    }
}

/*##^##
Designer {
    D{i:0;formeditorZoom:1.66}D{i:6}
}
##^##*/
