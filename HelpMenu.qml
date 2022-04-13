import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

Rectangle{
    id: root

    function unLoginAccount()
    {
        console.log("unLoginAccount")
    }

    function helping()
    {
        console.log("helping")
    }

    function aboutDeveloper()
    {
        console.log("aboutDeveloper")
    }

    property var functionHelpingArray: [unLoginAccount,helping,aboutDeveloper ]

    property color noColor: "#00000000"
    property int sizeHelpHeight: 40
    property int dfltWidthElementMenu: 337

    property var textHelpArray: ["Выход", "Поддержка", "О разработчике"]
    property var colorHelpArray: ["#FA7E61", "#ffffff"]
    property int sizeFont: 20


    width: dfltWidthElementMenu
    height: sizeHelpHeight
    color: noColor

    Text {
        id: textHelpMenu
        anchors.fill: parent
        font.pixelSize: sizeFont
        color: {
            if (index === 0)
            {
                textHelpMenu.color = colorHelpArray[0]
            }
            else
            {
                textHelpMenu.color = colorHelpArray[1]
            }
        }

        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }

    MouseArea{
        anchors.fill: parent

        onClicked: {
            functionHelpingArray[index]()
        }
    }

    Component.onCompleted: {
        textHelpMenu.text = textHelpArray[index]

        if (index >=1)
        {
            textHelpMenu.color = colorHelpArray[1]
        }
    }
}
