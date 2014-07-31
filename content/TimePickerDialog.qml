import QtQuick 2.2
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.2
import QtGraphicalEffects 1.0

Item {
    id: dialog

    property alias dialogvisible: dialogBody.visible
    property alias hour: picker.hour
    property alias minute: picker.minute
    property bool valid: false
    signal hasChanged

    anchors.fill: parent

    Rectangle {
        id: dialogBackground
        anchors.fill: parent
        color: "grey"
        opacity: 0.2
        visible: dialogBody.visible
        MouseArea {
            anchors.fill: parent
            onClicked: { dialogBody.visible = false }
        }
    }

    Rectangle {
        id: dialogBody
        width: 700
        height: 400
        opacity: 1.0
        visible: false
        anchors.centerIn: parent
        color: "grey"
        border.color: "black"
        border.width: 1
        radius: 3

        onVisibleChanged: { if (visible == true) dialog.valid = false }

        TimePicker {
            id: picker
            width: parent.width
            anchors.top: parent.top
            anchors.topMargin: 30
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Rectangle {
            id: okButton
            width: parent.width / 2
            height: 80
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            color: "transparent"
            Rectangle {
                width: parent.width
                height: 2
                border.color: "#E3905C"
                border.width: 1
            }
            Text {
                anchors.fill: parent
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.family: "Abel"
                font.pointSize: 18
                text: "Übernehmen"
            }
            MouseArea {
                anchors.fill: parent
                onClicked: { dialogBody.visible = false; dialog.valid = true; dialog.hasChanged() }
            }
        }
        Rectangle {
            width: 2
            height: 80
            anchors.bottom: parent.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            border.color: "#E3905C"
            border.width: 1
        }

        Rectangle {
            id: abbruchButton
            width: parent.width / 2
            height: 80
            anchors.bottom: parent.bottom
            anchors.right: parent.right
            color: "transparent"
            Rectangle {
                width: parent.width
                height: 2
                border.color: "#E3905C"
                border.width: 1
            }
            Text {
                anchors.fill: parent
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.family: "Abel"
                font.pointSize: 18
                text: "Abbrechen"
            }
            MouseArea {
                anchors.fill: parent
                onClicked: { dialogBody.visible = false }
            }
        }
    }

    DropShadow {
        id: dialogShadow
        anchors.fill: dialogBody
        horizontalOffset: 5
        verticalOffset: 5
        visible: dialogBody.visible
        radius: 12
        samples: 24
        spread: 1.0
        color: "#80000000"
        source: dialogBody
    }
}
