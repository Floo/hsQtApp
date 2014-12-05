import QtQuick 2.2
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.2
import QtGraphicalEffects 1.0

Item {
    id: dialog

    property alias dialogvisible: dialogBody.visible
    property string zeit: ""
    property alias hour: picker.hour
    property alias minute: picker.minute
    property bool valid: false
    property QtObject obj
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
    Item {
        id: dialogBody
        width: 970
        height: 640
        visible: false
        anchors.centerIn: parent

        onVisibleChanged: {
            if (visible == true) {
                dialog.valid = false
            }
        }

        Rectangle {
            width: 940
            height: 600
            opacity: 1.0
            anchors.centerIn: parent
            color: "grey"
            border.color: Qt.lighter("grey", 0.9)
            border.width: 1
            radius: 3

            TimePicker {
                id: picker
                width: parent.width
                anchors.top: parent.top
                anchors.topMargin: 45
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Rectangle {
                id: okButton
                width: parent.width / 2
                height: 120
                anchors.bottom: parent.bottom
                anchors.left: parent.left
                color: "transparent"
                opacity: okMouse.pressed ? 0.2 : 1
                Rectangle {
                    width: parent.width
                    height: 2
                    border.color: Qt.lighter("grey", 1.2)
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
                    id: okMouse
                    anchors.fill: parent
                    onClicked: {
                        dialogBody.visible = false;
                        dialog.valid = true;
                        dialog.zeit = picker.uhrzeit;
                        dialog.hasChanged();
                    }
                }
            }
            Rectangle {
                width: 2
                height: 120
                anchors.bottom: parent.bottom
                anchors.horizontalCenter: parent.horizontalCenter
                border.color: Qt.lighter("grey", 1.2)
                border.width: 1
            }

            Rectangle {
                id: abbruchButton
                width: parent.width / 2
                height: 120
                anchors.bottom: parent.bottom
                anchors.right: parent.right
                color: "transparent"
                opacity: abbruchMouse.pressed ? 0.2 : 1
                Rectangle {
                    width: parent.width
                    height: 2
                    border.color: Qt.lighter("grey", 1.2)
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
                    id: abbruchMouse
                    anchors.fill: parent
                    onClicked: { dialogBody.visible = false }
                }
            }
        }
    }

        DropShadow {
            id: dialogShadow
            anchors.fill: source
            horizontalOffset: 4
            verticalOffset: 4
            visible: dialogBody.visible
            radius: 14
            samples: 24
            spread: 0.3
            color: "#80000000"
            source: dialogBody
        }
    }
