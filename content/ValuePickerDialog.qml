import QtQuick 2.2
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.2
import QtGraphicalEffects 1.0

Item {
    id: dialog

    property alias dialogvisible: dialogBody.visible
    property int value
    property bool valid: false
    property int minValue: 0
    property int maxValue: 10
    property int stepSize: 1
    property var modelData: ["0", ".", "2", ".", "4", ".", "6", ".", "8", ".", "10"]
    property string einheit: ""
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
        height: 480
        visible: false
        anchors.centerIn: parent

        onVisibleChanged: {
            if (visible == true) {
                dialog.valid = false
            }
        }

        Rectangle {
            width: 940
            height: 450
            opacity: 1.0
            anchors.centerIn: parent
            color: "grey"
            border.color: Qt.lighter("grey", 0.9)
            border.width: 1
            radius: 3

            Column {
                width: 816
                anchors.top: parent.top
                anchors.topMargin: 45
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 45
                Text {
                    id: valueText
                    anchors.horizontalCenter: parent.horizontalCenter
                    font.family: "Abel"
                    font.pointSize: 30
                    color: "#E3905C"
                    font.bold: true
                    text: valueSlider.value + dialog.einheit
                }

                Slider {
                    id: valueSlider
                    anchors.horizontalCenter: parent.horizontalCenter
                    minimumValue: minValue
                    maximumValue: maxValue
                    stepSize: dialog.stepSize
                    style: valueSliderStyle
                    value: dialog.value
                }
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
                        dialog.value = valueSlider.value;
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

    Component {
        id: valueSliderStyle

        SliderStyle {
            handle: Rectangle {
                width: Math.round(816 / dialog.modelData.length)
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
                        model: dialog.modelData
                        delegate: Text {
                            anchors.verticalCenter: parent.verticalCenter
                            width: Math.round(816 / dialog.modelData.length)
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
