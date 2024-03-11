import QtQuick 2.15
import QtQuick.Controls 2.0
import "Common"
Rectangle{
    id: rectContainClockSender
    width: 600
    height: 300
    // signal to send time
    signal sendTime(string time)

    // object name to interact with qt c++
    objectName: "QMLSender"

    Rectangle{
        id: rectContaionTextTitle
        width: 320
        height: 50
        anchors.horizontalCenter: parent.horizontalCenter
        Text{
            text: qsTr("CLOCK SENDER")
            font.pixelSize: 22
            anchors.centerIn: parent
        }
    }

    TextField{
        id: tfTime
        width: 400
        height: 50
        anchors.top: rectContaionTextTitle.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.topMargin: 10
        font.pixelSize: 14
    }

    Rectangle{
        id: rectContaionTextGuides
        width: 320
        height: 50
        anchors.left: tfTime.left
        anchors.top: tfTime.bottom
        anchors.topMargin: 10
        Text{
            text: qsTr("Đinh dạng yêu cầu: HH:mm:ss (Ví dụ: 21:21:59)")
            font.pixelSize: 12
            anchors.left: parent.left
            font.italic: true
        }
    }

    Rectangle{
        id: rectContaionTextWarning
        width: 320
        height: 50
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: rectContaionTextGuides.bottom
        anchors.topMargin: 10
        Text{
            id: textWarning
            text: qsTr("Format")
            font.pixelSize: 12
            anchors.centerIn: parent
        }
    }

    Button{
        id: btnSend
        nameButton: qsTr("Send")
        height: 50
        width: 100
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: rectContaionTextWarning.bottom
        anchors.topMargin: 10
        onButtonClicked: {
            textWarning.text = qsTr("");
            var time = tfTime.text.trim()
            sendTime(time)
        }
    }

    Connections{
        target: LockSender
        function onConnectToServerPortFail()
        {
            textWarning.color = "red"
            textWarning.text = qsTr("Connect to TCP Server port 42000 FAIL!");
        }

        function onConnectToServerPortSuccess()
        {
            textWarning.color = "green"
            textWarning.text = qsTr("Connect to TCP Server port 42000 SUCCESSFULLY!");
        }

        function onFormatTimeFail()
        {
            console.log("IN HERE")
            textWarning.color = "red"
            textWarning.text = qsTr("Format time FAIL!");
        }

        function onCantSendMessage(strTime)
        {
            textWarning.color = "red"
            textWarning.text = qsTr("Cant send message!");
        }

        function onSendMessageSuccess(strTime)
        {
            textWarning.color = "green"
            textWarning.text = qsTr("Send message SUCCESSFULLY!");
        }
    }
}
