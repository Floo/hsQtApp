import QtQuick 2.2
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.2

Item {
    id: root
    width: 816

    property alias hour: stundenSlider.value
    property alias minute: minutenSlider.value
    property alias uhrzeit: uhrzeit.text
    signal valueChanged

    Column {
        width: parent.width
        spacing: 45
        Text {
            id: uhrzeit
            anchors.horizontalCenter: parent.horizontalCenter
            font.family: "Abel"
            font.pointSize: 30
            color: "#E3905C"
            font.bold: true
            text: {
                var hour = "0" + stundenSlider.value;
                var min = "0" + minutenSlider.value;
                hour = hour.substring(hour.length - 2, hour.length);
                min = min.substring(min.length - 2, min.length);
                return hour + ":" + min
            }
            onTextChanged: root.valueChanged()
        }

        Slider {
            id: stundenSlider
            anchors.horizontalCenter: parent.horizontalCenter
            minimumValue: 0
            maximumValue: 23
            stepSize: 1
            style: stundenSliderStyle
            value: 8
        }

        Slider {
            id: minutenSlider
            anchors.horizontalCenter: parent.horizontalCenter
            minimumValue: 0
            maximumValue: 55
            stepSize: 5
            style: minutenSliderStyle
            value: 20
        }
    }

    Component {
        id: stundenSliderStyle

        SliderStyle {
            handle: Rectangle {
                width: 34
                height: 64
                radius: 1
                antialiasing: true
                color: "transparent"
                border.color: "#E3905C"
                border.width: 3
            }

            groove: Item {
                implicitHeight: 68
                implicitWidth: 816
                Rectangle {
                    height: 54
                    width: parent.width
                    anchors.verticalCenter: parent.verticalCenter
                    color: "#444"
                    opacity: 0.8
                    ListView {
                        anchors.fill: parent
                        orientation: Qt.Horizontal
                        model: ["0", ".", ".", "3", ".", ".", "6", ".", ".", "9", ".", ".", "12", ".", ".", "15", ".", ".", "18", ".", ".", "21", ".", "."]
                        delegate: Text {
                            anchors.verticalCenter: parent.verticalCenter
                            width: 34
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            font.family: "Abel"
                            font.pointSize: 15
                            text: modelData
                        }
                    }

                }
            }
        }
    }

    Component {
        id: minutenSliderStyle
        SliderStyle {
            handle: Rectangle {
                width: 68
                height: 64
                radius: 1
                antialiasing: true
                color: "transparent"
                border.color: "#E3905C"
                border.width: 3
            }

            groove: Item {
                implicitHeight: 68
                implicitWidth: 816
                Rectangle {
                    height: 54
                    width: parent.width
                    anchors.verticalCenter: parent.verticalCenter
                    color: "#444"
                    opacity: 0.8
                    ListView {
                        anchors.fill: parent
                        orientation: Qt.Horizontal
                        model: ["00", ".", ".", "15", ".", ".", "30", ".", ".", "45", ".", "."]
                        delegate: Text {
                            anchors.verticalCenter: parent.verticalCenter
                            width: 68
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            font.family: "Abel"
                            font.pointSize: 15
                            text: modelData
                        }
                    }

                }
            }
        }
    }
}

