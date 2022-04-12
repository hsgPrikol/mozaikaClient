import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtGraphicalEffects 1.0


Rectangle {
    id: rootMessage
    clip: true
    //~~~~~~~~~~~~~~~~~~Width~~~~~~~~~~~~~~~~~~~~~~~
    property real sizeOnePXWidth: 5
    property int sizeMessage: 10
    property int maxWidthMessage: 303

    //~~~~~~~~~~~~~~~~~~Height~~~~~~~~~~~~~~~~~~~~~~~
    property int sizeOneLineHeight: 14
    property int dfltHeightText: 36
    property int dfltHeightRect: 50


    property int calcWidth: sizeOnePXWidth * sizeMessage
    property int calcHeight: (sizeOneLineHeight + 1) * textMessage.lineCount
    property color enemyColor: "gray"
    property color selfColor: "#068d9d"
    property color noColor: "#00000000"
    property real customOpacity: 0.7
    property int fontSize: 12

    property color selfColorText: "#ffffff"
    property color enemyColorText: "#000000"

    property bool flagWhenMessage: true
    property string messageText: "Ay"

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



    width: {
        if (calcWidth < 100)
        {
            100
        }
        else if (calcWidth > maxWidthMessage)
        {
            maxWidthMessage
        }
        else
        {
            calcWidth
        }
    }

    height: {
        if (textMessage.lineCount == 1 || textMessage.lineCount == 2)
        {
            dfltHeightRect
        }
        else
        {
            calcHeight + 14
        }
    }

    color: flagWhenMessage ? selfColor : enemyColor
    radius: 10

    Text {
        id: textMessage
        anchors.right: parent.right
        anchors.left: parent.left
        anchors.bottom: timeMessage.top
        anchors.top: parent.top
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
        color: flagWhenMessage ? selfColorText : enemyColorText
        verticalAlignment: Text.AlignVCenter

        wrapMode: Text.Wrap
//        rightPadding: 7
//        leftPadding: 7
//        bottomPadding: 5
//        topPadding: 5

        Component.onCompleted: {
            console.log(index + ") ", textMessage.lineCount)
        }
    }

    Text {
        id: timeMessage
        x: 32
        y: 36
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        font.pixelSize: 9
        width: 69
        height: 14
        color: flagWhenMessage ? selfColorText : enemyColorText
        text: qsTr("5 минут назад")
        horizontalAlignment: Text.AlignLeft
        verticalAlignment: Text.AlignVCenter
    }

    Image {
        id: image
        anchors.left: parent.left
        anchors.top: textMessage.bottom
        width: 32
        height: 14
        source: "qrc:/picture/SendedMessage.tif"
        fillMode: Image.PreserveAspectFit
    }
}

/*##^##
Designer {
    D{i:0;formeditorZoom:1.66}
}
##^##*/
