import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtGraphicalEffects 1.0
import QtQuick.Dialogs 1.2

Rectangle {
    id: textWidget

    property var sourceText


    FileDialog{
        id: fileDialog

        onAccepted: {
            console.log("filedialog")
        }
    }

    width: 300
    height: 50

    color: "white"
    opacity: 0.7
    radius: 25

    Text {
        anchors.fill: parent
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        font.underline: true
        font.bold: true
        font.pointSize: 16
        text: sourceText
    }

    MouseArea{
        anchors.fill: parent

        onClicked: {
            fileDialog.open()
        }
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
