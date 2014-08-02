import QtQuick 2.2
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.2

Item {
    id: panelBewaesserung

    property alias statusText: status.text
    property alias value: slider_id.value
    property alias checked: schalter.checked
    signal switched

    width: 100

    Column {
        spacing: 30

        Text {
            id: status
            font.family: "Abel"
            font.pointSize: 16
            font.bold: true
            text: "Status: "
        }

        Slider {
            id: slider_id
            style: touchStyle
            minimumValue: 1
            maximumValue: 30
            stepSize: 1
            value: 6
        }

        Rectangle {
            height: schalter.height
            width: slider_id.width
            color: "transparent"

            Switch {
                id: schalter
                style: switchStyle
                onCheckedChanged: panelBewaesserung.switched()
            }

            Text {
                id: text
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right
                font.family: "Abel"
                font.pointSize: 18
                text: "Dauer: " + slider_id.value + " min"
            }
        }
    }

    Component {
        id: touchStyle
        SliderStyle {
            handle: Rectangle {
                width: 30
                height: 30
                radius: height
                antialiasing: true
                color: Qt.lighter("#E3905C", 1.2)
            }

            groove: Item {
                implicitHeight: 50
                implicitWidth: 400
                Rectangle {
                    height: 8
                    width: parent.width
                    anchors.verticalCenter: parent.verticalCenter
                    color: "#444"
                    opacity: 0.8
                    Rectangle {
                        antialiasing: true
                        radius: 1
                        color: "#E3905C"
                        height: parent.height
                        width: parent.width * control.value / control.maximumValue
                    }
                }
            }
        }
    }

    Component {
        id: switchStyle
        SwitchStyle {

            groove: Rectangle {
                implicitHeight: 50
                implicitWidth: 152
                Rectangle {
                    anchors.top: parent.top
                    anchors.left: parent.left
                    anchors.bottom: parent.bottom
                    width: parent.width/2 - 2
                    height: 20
                    anchors.margins: 2
                    color: control.checked ? "#E3905C" : "#222"
                    Behavior on color {ColorAnimation {}}
                    Text {
                        font.pixelSize: 23
                        color: "white"
                        anchors.centerIn: parent
                        text: "ON"
                    }
                }
                Item {
                    width: parent.width/2
                    height: parent.height
                    anchors.right: parent.right
                    Text {
                        font.pixelSize: 23
                        color: "white"
                        anchors.centerIn: parent
                        text: "OFF"
                    }
                }
                color: "#222"
                border.color: "#444"
                border.width: 2
            }
            handle: Rectangle {
                width: parent.parent.width/2
                height: control.height
                color: "#444"
                border.color: "#555"
                border.width: 2
            }
        }
    }
}
