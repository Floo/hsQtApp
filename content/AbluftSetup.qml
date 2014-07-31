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
                text: "Abluft HWR:"
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
        ExclusiveGroup { id: hwrGroup }
        Item {
            width: parent.width
            height: 100
            SetupCheckbox {
                id: hwrAus
                checked: true
                exclusiveGroup: hwrGroup
                radioButton: true
                bezeichner: "Aus"
                onCheckedChanged: {}
            }
        }
        Item {
            width: parent.width
            height: 100
            SetupCheckbox {
                id: hwrAn
                checked: false
                radioButton: true
                bezeichner: "An"
                exclusiveGroup: hwrGroup
                onCheckedChanged: {}
            }
        }
        Item {
            width: parent.width
            height: 100
            SetupCheckbox {
                id: hwrTemp
                checked: false
                radioButton: true
                exclusiveGroup: hwrGroup
                bezeichner: "Temperaturabhängig"
                onCheckedChanged: {}
            }
        }
        Item {
            width: parent.width
            height: 100
            SetupValue {
                id: hwrTempValue
                leftTextMargin: 50
                enabled: hwrTemp.checked
                bezeichner: "Temperaturschwelle:"
                value: "28 °C"
                onClicked: {
                    valuepickerdialog.obj = this;
                    valuepickerdialog.minValue = 18;
                    valuepickerdialog.maxValue = 37;
                    valuepickerdialog.stepSize = 1;
                    valuepickerdialog.modelData = [".", ".", "20", ".", ".", ".", ".", "25", ".", ".", ".", ".", "30", ".", ".", ".", ".", "35", ".", "."];
                    valuepickerdialog.value = 28;
                    valuepickerdialog.einheit = " °C"
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
                text: "Zentrale Abluft:"
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
                id: abluft
                checked: true
                radioButton: false
                bezeichner: "Dauerbetrieb"
                hilfetext: "Dauerbetrieb auf niedriger Stufe"
                onCheckedChanged: {}
            }
        }

    }
    ValuePickerDialog {
        id: valuepickerdialog
        onHasChanged: { obj.value = valuepickerdialog.value + " °C" }
    }
}

