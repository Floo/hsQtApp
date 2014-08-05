import QtQuick 2.2

Item {
    id: infoElement

    property alias source: pic.source
    property alias text: text.text

    width: infoLeiste.breite
    height: 80
    Row {
        anchors.left: parent.left
        anchors.leftMargin: 0
        Item {
            width: 120
            height: infoElement.height
            Image {
                id: pic
                anchors.centerIn: parent
                width: 60
                height: 60
                fillMode: Image.PreserveAspectFit
            }
        }
        Rectangle {
            width: 1
            height: infoElement.height - 10
            anchors.verticalCenter: parent.verticalCenter
            color: "black"
        }
        Item {
            height: infoElement.height
            width: infoElement.width - 121
            Text {
                id: text
                anchors { left: parent.left; leftMargin: 20; verticalCenter: parent.verticalCenter }
                font { family: "Abel"; pointSize: infoLeiste.smallFont }
                verticalAlignment: Qt.AlignVCenter

            }
        }
    }
    Rectangle {
        height: 1
        anchors.bottom: parent.bottom
        width: infoElement.width
        color: "black"
    }
}
