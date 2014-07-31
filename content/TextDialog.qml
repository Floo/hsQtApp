import QtQuick 2.2
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.2
import QtGraphicalEffects 1.0

Item {
    id: dialog

    property alias dialogvisible: dialogBody.visible
    property string text
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

    Rectangle {
        id: dialogBody
        width: 700
        height: 300
        opacity: 1.0
        visible: false
        anchors.centerIn: parent
        color: "grey"
        border.color: "black"
        border.width: 1
        radius: 3

        onVisibleChanged: {
            if (visible == true) {
                dialog.valid = false
            }
        }

        TextField {
            id: eingabeFeld
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 100
            text: dialog.text
            style: touchStyle
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
                anchors.fill: parent
                onClicked: {
                    dialogBody.visible = false;
                    dialog.valid = true;
                    dialog.text = eingabeFeld.text;
                    dialog.hasChanged();
                }
            }
        }
        Rectangle {
            width: 2
            height: 80
            anchors.bottom: parent.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            border.color: Qt.lighter("grey", 1.2)
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

    Component {
        id: touchStyle

        TextFieldStyle {
            textColor: "white"
            font.pixelSize: 28
            background: Item {
                implicitHeight: 50
                implicitWidth: 500
                BorderImage {
                    source: "../images/textinput.png"
                    border.left: 8
                    border.right: 8
                    anchors.bottom: parent.bottom
                    anchors.left: parent.left
                    anchors.right: parent.right
                }
            }
        }
    }
}
