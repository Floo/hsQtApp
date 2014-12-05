import QtQuick 2.2
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.2
import "../javascript/global.js" as Global


Item {
    id: root
    property alias bezeichner: bezeichner.text
    property alias value: value.text
    property int leftTextMargin: 45
    signal clicked

    anchors.fill: parent

    Column {
        anchors.fill: parent
        Rectangle {
            width: parent.width
            height: 150
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
                    id: value
                    width: parent.width
                    visible: text.length > 0
                    anchors.left: parent.left
                    anchors.leftMargin: root.leftTextMargin
                    font.family: "Abel"
                    font.pointSize: 12
                    color: root.enabled ? "black" : "grey"
                    text: ""
                }
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
                onClicked: {
                    Global.mainobj.state = "nothingVisible";
                    root.clicked();
                }
            }
        }
    }

}
