import QtQuick 2.0

Rectangle {
    id: outerborder
    width: 200
    height: width

    property alias source: image.source
    property alias text: buttontext.text
    signal buttonClicked()

    Column {
        width: parent.width
        anchors.centerIn: parent
        spacing: 6
        Image {
            id: image
            width: outerborder.width / 2
            height: outerborder.height / 2
            anchors.horizontalCenter: parent.horizontalCenter
            //anchors.centerIn: parent
            fillMode: Image.PreserveAspectFit
        }
        Text {
            id: buttontext
            anchors.horizontalCenter: parent.horizontalCenter
            color: "#E3905C"
            font.family: "Abel"
            font.pointSize: 12
        }
    }

    MouseArea {
        id: click
        anchors.fill: parent
        onClicked: {
            buttonClicked()
        }
    }
}
