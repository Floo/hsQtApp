import QtQuick 2.2
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.2
import QtGraphicalEffects 1.0
import "../javascript/hsClient.js" as Hsclient
import "../javascript/global.js" as Global


Rectangle {
    id: rootAbluftSetupPage
    width: parent.width
    height: parent.height
    z: -1

    property bool init: true
    readonly property string name: "Setup - Lüftung"
    function isVisibleDialog() {
        return valuepickerdialog.dialogvisible
    }

    MouseArea {
        anchors.fill: parent
        onClicked: Global.mainobj.state = "nothingVisible";
    }

    Component.onCompleted: Hsclient.getSetupAbluft()

    Column {
        anchors.fill: parent
        Rectangle {
            width: parent.width
            height: 90
            color: "#E3905C"
            Text {
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: 45
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

        ExclusiveGroup {
            id: hwrGroup
            onCurrentChanged: if(!rootAbluftSetupPage.init) Hsclient.setSetupAbluft()
        }

        Item {
            width: parent.width
            height: 150
            SetupCheckbox {
                id: hwrAus
                checked: true
                exclusiveGroup: hwrGroup
                radioButton: true
                bezeichner: "Aus"
            }
        }
        Item {
            width: parent.width
            height: 150
            SetupCheckbox {
                id: hwrAn
                checked: false
                radioButton: true
                bezeichner: "Dauerbetrieb"
                exclusiveGroup: hwrGroup
            }
        }
        Item {
            width: parent.width
            height: 150
            SetupCheckbox {
                id: hwrTemp
                checked: false
                radioButton: true
                exclusiveGroup: hwrGroup
                bezeichner: "Temperaturabhängig"
            }
        }
        Item {
            width: parent.width
            height: 150
            SetupValue {
                id: hwrTempValue
                leftTextMargin: 65
                enabled: hwrTemp.checked
                bezeichner: "Temperaturschwelle:"
                value: valuepickerdialog.value + " °C"
                onClicked: {
                    valuepickerdialog.obj = this;
                    valuepickerdialog.minValue = 18;
                    valuepickerdialog.maxValue = 37;
                    valuepickerdialog.stepSize = 1;
                    valuepickerdialog.modelData = [".", ".", "20", ".", ".", ".", ".", "25", ".", ".", ".", ".", "30", ".", ".", ".", ".", "35", ".", "."];
                    Hsclient.initAbluftTempDialog( hwrTempValue.value );
                    valuepickerdialog.einheit = " °C"
                    valuepickerdialog.dialogvisible = true;
                }
            }
        }
        Rectangle {
            width: parent.width
            height: 90
            color: "#E3905C"
            Text {
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: 45
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
            height: 150
            SetupCheckbox {
                id: abluft
                radioButton: false
                bezeichner: "Dauerbetrieb"
                hilfetext: "Dauerbetrieb auf niedriger Stufe"
                onCheckedChanged: {
                    Global.mainobj.state = "nothingVisible";
                    if(!rootAbluftSetupPage.init) Hsclient.setSetupAbluft()
                }
            }
        }

    }
    ValuePickerDialog {
        id: valuepickerdialog
        onHasChanged: { obj.value = valuepickerdialog.value + " °C"; if(!rootAbluftSetupPage.init) Hsclient.setSetupAbluft() }
    }
}

