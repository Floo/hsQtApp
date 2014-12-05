import QtQuick 2.2
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.2


Item {
    id: root
    width: parent.width
    height: 150
    property alias bezeichner: bezeichner.text
    property alias subtext: hilfetext.text
    property alias icon: icon.source
    property bool hasIcon: true
    property bool selected: false
    property int leftTextMargin: 45
    signal clicked

    Rectangle {
        anchors.fill: parent
        color: myMouse.pressed ? "lightgrey" : "transparent"
        Column {
            anchors.verticalCenter: parent.verticalCenter
            Text {
                id: bezeichner
                anchors.left: parent.left
                anchors.leftMargin: root.leftTextMargin
                font.family: "Abel"
                font.pointSize: 16
                font.bold: selected
                color: root.enabled ? "black" : "grey"
                text: ""
            }
            Text {
                id: hilfetext
                width: parent.width
                visible: text.length > 0
                anchors.left: parent.left
                anchors.leftMargin: root.leftTextMargin
                font.family: "Abel"
                font.pointSize: 12
                font.bold: selected
                color: root.enabled ? "black" : "grey"
                text: ""
            }
        }

        Image {
            id: icon
            width: parent.height / 2; height: parent.height / 2
            fillMode: Image.PreserveAspectFit
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: 65
            visible: root.hasIcon
            source: "../images/next_page_pan472c.png"
        }

        Rectangle {
            width: parent.width
            height: 2
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            border.color: "grey"
            border.width: 1
        }
        MouseArea {
            id: myMouse
            anchors.fill: parent
            onClicked: root.clicked()
        }
    }
}

