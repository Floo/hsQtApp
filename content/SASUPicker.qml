import QtQuick 2.2
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.2

Item {
    id: root
    width: 816

    property alias sonne: sonnenSlider.value
    property alias offset: offsetSlider.value
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
                var sonne = (sonnenSlider.value == 1 ? "SU" : "SA");
                var offset = (offsetSlider.value < 0 ? offsetSlider.value.toString() : ("+" + offsetSlider.value.toString()));
                return sonne + offset;
            }
            onTextChanged: root.valueChanged()
        }

        Slider {
            id: sonnenSlider
            anchors.horizontalCenter: parent.horizontalCenter
            minimumValue: 0
            maximumValue: 1
            stepSize: 1
            style: sonnenSliderStyle
            value: 1
        }

        Slider {
            id: offsetSlider
            anchors.horizontalCenter: parent.horizontalCenter
            minimumValue: -90
            maximumValue: 90
            stepSize: 15
            style: offsetSliderStyle
            value: 0
        }
    }

    Component {
        id: sonnenSliderStyle

        SliderStyle {
            handle: Rectangle {
                width: 408
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
                        model: ["SA", "SU"]
                        delegate: Text {
                            anchors.verticalCenter: parent.verticalCenter
                            width: 408
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
        id: offsetSliderStyle
        SliderStyle {
            handle: Rectangle {
                width: 63
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
                        model: ["-90", ".", "-60", ".", "-30", ".", "0", ".", "30", ".", "60", ".", "90"]
                        delegate: Text {
                            anchors.verticalCenter: parent.verticalCenter
                            width: 63
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

