import QtQuick 2.0

Rectangle {
    width: 200
    height: 200

    property alias source: image.source
    signal buttonClicked()

    Image {
        id: image
        width: parent.width
        height: parent.height
        fillMode: Image.PreserveAspectFit
        source: "content/jalousie_m.png"
    }

    MouseArea {
        id: click
        anchors.fill: parent
        onClicked: {
            buttonClicked()
        }
    }
}
