import QtQuick 2.0

Rectangle {
    width: 200
    height: 200

    property alias source: image.source
    signal buttonClicked()

    Image {
        id: image
        width: parent.width / 2
        height: parent.height / 2
        anchors.centerIn: parent
        fillMode: Image.PreserveAspectFit
    }

    MouseArea {
        id: click
        anchors.fill: parent
        onClicked: {
            buttonClicked()
        }
    }
}
