import QtQuick 2.2
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.2

Item {
    id: panelBewaesserung

    property alias statusText: status.text
    property alias value: slider_id.value
    property alias checked: schalter.checked
    property alias enabled: schalter.enabled
    signal switched

    width: 100

    Column {
        spacing: 45

        Text {
            id: status
            font.family: "Abel"
            font.pointSize: 16
            font.bold: false
            text: "Status: "
        }

        Slider {
            id: slider_id
            style: touchStyle
            minimumValue: 1
            maximumValue: 20
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
                font.pointSize: 16
                text: "Dauer: " + slider_id.value + " min"
            }
        }
    }

    Component {
        id: touchStyle
        SliderStyle {
            handle: Rectangle {
                width: 45
                height: 45
                radius: height
                antialiasing: true
                color: Qt.lighter("#E3905C", 1.2)
            }

            groove: Item {
                implicitHeight: 65
                implicitWidth: 600
                Rectangle {
                    height: 10
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
                implicitHeight: 65
                implicitWidth: 228
                Rectangle {
                    anchors.top: parent.top
                    anchors.left: parent.left
                    anchors.bottom: parent.bottom
                    width: parent.width/2 - 2
                    height: 26
                    anchors.margins: 2
                    color: control.checked ? "#E3905C" : "#222"
                    Behavior on color {ColorAnimation {}}
                    Text {
                        font.pixelSize: 34
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
                        font.pixelSize: 34
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
