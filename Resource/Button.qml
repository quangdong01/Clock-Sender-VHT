import QtQuick 2.0
import QtQuick.Controls 2.15

Rectangle{
    id: rec
    property string nameButton
    signal buttonClicked()
    height: 30
    width: 80
    radius: 2
    border.color: "#3e3434"

    Text{
        anchors.centerIn: parent
        text: nameButton
        font.pixelSize: 16
    }

    MouseArea{
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        onClicked:
        {
            buttonClicked();
        }
        onPressed:
        {
            rec.color = "#feffa0"
        }
        onReleased:{
            rec.color = "transparent"
        }
        onEntered:{
            rec.color = "transparent"
        }
        onExited:{
            rec.color = "white"
        }
    }
}
