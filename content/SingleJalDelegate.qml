import QtQuick 2.0


Item {
    id: root
    width: parent.width
    height: 88

    property alias text: text.text
    property alias subtext: subtext.text
    signal clicked

    Rectangle {
        anchors.fill: parent
        color: "#aaaaaa"
    }
    Rectangle {
        anchors.fill: parent
        color: "#00ffff"
        visible: mouse.pressed
    }
    Column {
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: 30
        Text {
            id: text
            color: "#000000"
            font.family: "Abel"
            font.pointSize: 10
        }
        Text {
            id: subtext
            color: "#000000"
            font.family: "Abel"
            font.pointSize: 6
        }
    }
    Rectangle {
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.margins: 15
        height: 1
        color: "#424246"
    }

    Image {
        anchors.right: parent.right
        anchors.rightMargin: 20
        anchors.verticalCenter: parent.verticalCenter
        source: "../images/navigation_next_item.png"
    }
    MouseArea {
        id: mouse
        anchors.fill: parent
        onClicked: root.clicked()

    }
}



