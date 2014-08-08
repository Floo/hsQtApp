import QtQuick 2.2
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.2
import QtGraphicalEffects 1.0
import "../javascript/hsClient.js" as Hsclient
import "../javascript/global.js" as Global

Rectangle {
    id: rootBewaesserungSetupPage
    width: parent.width
    height: parent.height
    z: -1

    property bool init: true
    readonly property string name: "Setup - Bewässerung"

    function isVisibleDialog() {
        return timepickerdialog.dialogvisible || valuepickerdialog.dialogvisible;
    }

    Component.onCompleted: Hsclient.getSetupBewaesserung()

    MouseArea {
        anchors.fill: parent
        onClicked: Global.mainobj.state = "";
    }

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
                onCheckedChanged: { if(!rootBewaesserungSetupPage.init) Hsclient.setSetupBewaesserung() }
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
                onCheckedChanged: { if(!rootBewaesserungSetupPage.init) Hsclient.setSetupBewaesserung() }
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
                value: "00:00"
                onClicked: {
                    timepickerdialog.obj = this;
                    Hsclient.initZeitDialog(beeteZeit.value)
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
                value: "0 min"
                onClicked: {
                    valuepickerdialog.obj = this;
                    valuepickerdialog.minValue = 1;
                    valuepickerdialog.maxValue = 30;
                    valuepickerdialog.stepSize = 1;
                    valuepickerdialog.modelData = ["1", ".", ".", ".", "5", ".", ".", ".", ".", "10", ".", ".", ".", ".", "15", ".", ".", ".", ".", "20", ".", ".", ".", ".", "25", ".", ".", ".", ".", "30"];
                    valuepickerdialog.einheit = " min";
                    Hsclient.initDauerDialog(beeteDauer.value)
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
                onCheckedChanged: { if(!rootBewaesserungSetupPage.init) Hsclient.setSetupBewaesserung() }
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
                onCheckedChanged: { if(!rootBewaesserungSetupPage.init) Hsclient.setSetupBewaesserung() }
            }
        }
        Item {
            width: parent.width
            height: 100
            SetupValue {
                id: kuebelZeit
                leftTextMargin: 50
                enabled: kuebelAuto.checked
                bezeichner: "Startzeit:"
                value: "00:00"
                onClicked: {
                    timepickerdialog.obj = this;
                    Hsclient.initZeitDialog(kuebelZeit.value)
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
                enabled: kuebelAuto.checked
                bezeichner: "Dauer:"
                value: "0 min"
                onClicked: {
                    valuepickerdialog.obj = this;
                    valuepickerdialog.minValue = 1;
                    valuepickerdialog.maxValue = 30;
                    valuepickerdialog.stepSize = 1;
                    valuepickerdialog.modelData = ["1", ".", ".", ".", "5", ".", ".", ".", ".", "10", ".", ".", ".", ".", "15", ".", ".", ".", ".", "20", ".", ".", ".", ".", "25", ".", ".", ".", ".", "30"];
                    Hsclient.initDauerDialog(kuebelDauer.value)
                    valuepickerdialog.einheit = " min";
                    valuepickerdialog.dialogvisible = true;
                }
            }
        }

    }
    TimePickerDialog {
        id: timepickerdialog
        onHasChanged: { obj.value = timepickerdialog.zeit; if(!rootBewaesserungSetupPage.init) Hsclient.setSetupBewaesserung()  }
    }
    ValuePickerDialog {
        id: valuepickerdialog
        onHasChanged: { obj.value = valuepickerdialog.value + " min"; if(!rootBewaesserungSetupPage.init) Hsclient.setSetupBewaesserung() }
    }
}
