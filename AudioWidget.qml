import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtGraphicalEffects 1.0
import QtMultimedia 5.12

Rectangle {
    width: 300
    height: 50
    color: "#00000000"
    radius: 10

    property bool flagMusic: false



    property int sizeSong: playMusic.duration / 10 / 60
    property real procentSong: playMusic.duration / 100 / 1000
    property int secondSong: playMusic.duration / 1000 / 60 / 100
    property int minuteSong: 0
     property int minuteSizeSong: sizeSong / 100
    property int secondSizeSong: sizeSong % 100

        Audio{
            id: playMusic
            source: "file:///C:/Users/rota/Desktop/Minelli - Rampampam.mp3"
        }

    Timer{
        id: timer
        interval: 1000;
        running: false;
        repeat: true
        onTriggered: {
            progressBar.value += procentSong
            secondSong +=1
//            console.log(progressBar.value)

            if (secondSong == 60)
            {
                minuteSong++;
                secondSong = 0;
            }

        }
    }

    Text {
        id: text1
        x: 224
        y: 33
        width: 56
        height: 17
        text: minuteSizeSong + ":" + secondSizeSong
        font.pixelSize: 12
    }

    ProgressBar {
        id: progressBar
        x: 48
        y: 21
        width: 232
        height: 8
        from: 0
        to: sizeSong

    }

    Text {
        id: text2
        x: 48
        y: 33
        width: 56
        height: 17
        text:
        {
            if (secondSong < 10)
            {
               minuteSong + ":0" + secondSong
            }
            else
            {
                minuteSong + ":" + secondSong
            }
        }
        font.pixelSize: 12
    }

    Image {
        id: playerAudio
        x: 15
        y: 8
        width: 34
        height: 35
        source: "qrc:/picture/button/play.png"
        fillMode: Image.PreserveAspectFit
        scale: mousePlayerAudio.containsPress ? 1.1 : 1

        MouseArea{
            id: mousePlayerAudio
            anchors.fill: parent

            hoverEnabled: true

            onClicked: {
                if (!flagMusic)
                {
                    playerAudio.source = "qrc:/picture/button/pause.png"
                    timer.start()
                    playMusic.play()
                }
                else
                {
                    playMusic.pause()
                    timer.stop()
                   playerAudio.source = "qrc:/picture/button/play.png"
                }
                flagMusic = !flagMusic
            }


        }
    }

}

/*##^##
Designer {
    D{i:0;formeditorZoom:6}
}
##^##*/
