import QtQuick 2.2
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.2


Item {
    id: root
    property alias bezeichner: bezeichner.text
    property alias hilfetext: hilfetext.text
    property alias checked: checkbox.checked
    property int leftTextMargin: 30
    signal checkboxChanged

    anchors.fill: parent

    Column {
        anchors.fill: parent
        Rectangle {
            width: parent.width
            height: 100
            color: windMouse.pressed ? "lightgrey" : "transparent"
            Column {
                anchors.verticalCenter: parent.verticalCenter
                Text {
                    id: bezeichner
                    anchors.left: parent.left
                    anchors.leftMargin: root.leftTextMargin
                    font.family: "Abel"
                    font.pointSize: 16
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
                    font.pointSize: 10
                    color: root.enabled ? "black" : "grey"
                    text: ""
                }
            }

            CheckBox {
                id: checkbox
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right
                anchors.rightMargin: 50
                checked: true
                enabled: root.enabled
                style: checkBoxStyle
                onCheckedChanged: root.checkboxChanged()
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
                id: windMouse
                anchors.fill: parent
                onClicked: checkbox.checked == true ? checkbox.checked = false : checkbox.checked = true
            }
        }
    }

    Component {
        id: checkBoxStyle
        CheckBoxStyle {
            indicator: Rectangle {
                implicitWidth: 32
                implicitHeight: 32
                radius: 3
                border.color: control.activeFocus ? "darkblue" : "gray"
                border.width: 2
                Rectangle {
                    visible: control.checked
                    color: "#E3905C"
                    border.color: Qt.darker("#E3905C", 1.2)
                    border.width: 1
                    radius: 1
                    anchors.margins: 8
                    anchors.fill: parent
                }
            }
        }

    }
}
