import QtQuick 2.2
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.2
import QtGraphicalEffects 1.0

Rectangle {
    width: parent.width
    height: parent.height

    Column {
        anchors.fill: parent
        Item {
            width: parent.width
            height: 100
            SetupCheckbox {
                id: wetter
                checked: true
                bezeichner: "Wettersteuerung"
                hilfetext: "Öffnet und schließt die Jalousien witterungsabhängig."
                onCheckedChanged: console.debug("Wetter")
            }
        }
        Item {
            width: parent.width
            height: 100
            SetupCheckbox {
                id: wind
                checked: true
                bezeichner: "Öffnen bei Wind"
                hilfetext: "Öffnet die Jalousien automatisch bei Überschreiten<br>einer festegelegten Windgeschwindigkeit."
                onCheckboxChanged: console.debug("Wind")
            }
        }
        Item {
            width: parent.width
            height: 100
            SetupCheckbox {
                id: regen
                checked: true
                bezeichner: "Öffnen bei Regen"
                hilfetext: "Öffnet die Jalousien automatisch bei Regen."
                onCheckboxChanged: console.debug("Regen")
            }
        }
        Item {
            width: parent.width
            height: 100
            SetupCheckbox {
                id: tuer
                checked: true
                bezeichner: "Tür bleibt offen"
                onCheckboxChanged: console.debug("Tür")
            }
        }
        Item {
            width: parent.width
            height: 100
            SetupCheckbox {
                id: luecke
                checked: true
                bezeichner: "Auf Lücke"
                onCheckboxChanged: console.debug("Lücke")
            }
        }
        Item {
            width: parent.width
            height: 30
            Rectangle {
                width: parent.width
                height: 2
                anchors.bottom: parent.bottom
                anchors.left: parent.left
                border.color: "grey"
                border.width: 1
            }
        }
        Item {
            width: parent.width
            height: 100
            SetupCheckbox {
                id: zeit
                checked: true
                bezeichner: "Zeitautomatik"
                hilfetext: "Öffnet und schließt die Jalousien zeitabhängig."
                onCheckboxChanged: { console.debug("Zeit"); dialog.state = "visible" }
            }
        }
    }
    Item {
        id: dialog

        states: State {
            name: "visible"
            PropertyChanges { target: dialogBackground; visible: true }
            PropertyChanges { target: dialogBody; visible: true }
            PropertyChanges { target: dialogShadow; visible: true }
        }

        anchors.fill: parent
        Rectangle {
            id: dialogBackground
            anchors.fill: parent
            color: "grey"
            opacity: 0.2
            visible: false
            MouseArea {
                anchors.fill: parent
                onClicked: { dialog.state = "" }
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
            Column {
                width: parent.width
                anchors.top: parent.top
                anchors.topMargin: 30
                spacing: 30
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
                    onClicked: { dialog.state = "" }
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
                    onClicked: { dialog.state = "" }
                }
            }


        }
        DropShadow {
            id: dialogShadow
            anchors.fill: dialogBody
            horizontalOffset: 5
            verticalOffset: 5
            visible: false
            radius: 12
            samples: 24
            spread: 1.0
            color: "#80000000"
            source: dialogBody
        }


        Component {
            id: stundenSliderStyle
            SliderStyle {
                handle: Rectangle {
                    width: 25
                    height: 46
                    radius: 1
                    antialiasing: true
                    color: "transparent"
                    border.color: "#E3905C"
                    border.width: 3
                }

                groove: Item {
                    implicitHeight: 50
                    implicitWidth: 600
                    Rectangle {
                        height: 40
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
                                width: 25
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
                    width: 50
                    height: 46
                    radius: 1
                    antialiasing: true
                    color: "transparent"
                    border.color: "#E3905C"
                    border.width: 3
                }

                groove: Item {
                    implicitHeight: 50
                    implicitWidth: 600
                    Rectangle {
                        height: 40
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
                                width: 50
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

}
