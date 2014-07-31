import QtQuick 2.2
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.2
import QtGraphicalEffects 1.0

Rectangle {
    width: parent.width
    height: parent.height

    Column {
        anchors.fill: parent
        Rectangle {
            width: parent.width
            height: 60
            color: "#E3905C"
            Text {
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: 30
                font.family: "Abel"
                font.pointSize: 16
                font.bold: true
                text: "Beete:"
            }
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
                id: beeteRegen
                checked: true
                bezeichner: "Regenabhängig"
                hilfetext: "Bewässerung nur, wenn kein Regen gefallen ist."
                onCheckedChanged: {}
            }
        }
        Item {
            width: parent.width
            height: 100
            SetupCheckbox {
                id: beeteAuto
                checked: true
                bezeichner: "Automatik"
                hilfetext: "Bewässerung zeitabhängig."
                onCheckedChanged: {}
            }
        }
        Item {
            width: parent.width
            height: 100
            SetupValue {
                id: beeteZeit
                leftTextMargin: 50
                enabled: beeteAuto.checked
                bezeichner: "Startzeit:"
                value: "12:40"
                onClicked: {
                    timepickerdialog.obj = this;
                    timepickerdialog.hour = 12;
                    timepickerdialog.minute = 40;
                    timepickerdialog.dialogvisible = true;
                }
            }
        }
        Item {
            width: parent.width
            height: 100
            SetupValue {
                id: beeteDauer
                leftTextMargin: 50
                enabled: beeteAuto.checked
                bezeichner: "Dauer:"
                value: "8 min"
                onClicked: {
                    valuepickerdialog.obj = this;
                    valuepickerdialog.minValue = 1;
                    valuepickerdialog.maxValue = 30;
                    valuepickerdialog.stepSize = 1;
                    valuepickerdialog.modelData = ["1", ".", ".", ".", "5", ".", ".", ".", ".", "10", ".", ".", ".", ".", "15", ".", ".", ".", ".", "20", ".", ".", ".", ".", "25", ".", ".", ".", ".", "30"];
                    valuepickerdialog.einheit = " min";
                    valuepickerdialog.value = 8;
                    valuepickerdialog.dialogvisible = true;
                }
            }
        }
        Rectangle {
            width: parent.width
            height: 60
            color: "#E3905C"
            Text {
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: 30
                font.family: "Abel"
                font.pointSize: 16
                font.bold: true
                text: "Kübel:"
            }
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
                id: kuebelRegen
                checked: true
                bezeichner: "Regenabhängig"
                hilfetext: "Bewässerung nur, wenn kein Regen gefallen ist."
                onCheckedChanged: {}
            }
        }
        Item {
            width: parent.width
            height: 100
            SetupCheckbox {
                id: kuebelAuto
                checked: true
                bezeichner: "Automatik"
                hilfetext: "Bewässerung zeitabhängig."
                onCheckedChanged: {}
            }
        }
        Item {
            width: parent.width
            height: 100
            SetupValue {
                id: kuebelZeit
                leftTextMargin: 50
                enabled: beeteAuto.checked
                bezeichner: "Startzeit:"
                value: "12:40"
                onClicked: {
                    timepickerdialog.obj = this;
                    timepickerdialog.hour = 12;
                    timepickerdialog.minute = 40;
                    timepickerdialog.dialogvisible = true;
                }
            }
        }
        Item {
            width: parent.width
            height: 100
            SetupValue {
                id: kuebelDauer
                leftTextMargin: 50
                enabled: beeteAuto.checked
                bezeichner: "Dauer:"
                value: "8 min"
                onClicked: {
                    valuepickerdialog.obj = this;
                    valuepickerdialog.minValue = 1;
                    valuepickerdialog.maxValue = 30;
                    valuepickerdialog.stepSize = 1;
                    valuepickerdialog.modelData = ["1", ".", ".", ".", "5", ".", ".", ".", ".", "10", ".", ".", ".", ".", "15", ".", ".", ".", ".", "20", ".", ".", ".", ".", "25", ".", ".", ".", ".", "30"];
                    valuepickerdialog.value = 8;
                    valuepickerdialog.einheit = " min";
                    valuepickerdialog.dialogvisible = true;
                }
            }
        }

    }
    TimePickerDialog {
        id: timepickerdialog
        onHasChanged: { obj.value = timepickerdialog.zeit }
    }
    ValuePickerDialog {
        id: valuepickerdialog
        onHasChanged: { obj.value = valuepickerdialog.value + " min" }
    }
}
