import QtQuick 2.2
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.2
import QtGraphicalEffects 1.0
import "../javascript/hsClient.js" as Hsclient
import "../javascript/global.js" as Global

Rectangle {
    id: rootJalSetupPage
    width: parent.width
    height: parent.height
    z: -1

    property bool init: true
    readonly property string name: "Setup - Jalousie"

    function isVisibleDialog() {
        return dialog.dialogvisible
    }

    MouseArea {
        anchors.fill: parent
        onClicked: Global.mainobj.state = "nothingVisible";
    }

    Component.onCompleted: Hsclient.getSetupJal()

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
                onCheckedChanged: { if(!rootJalSetupPage.init) Hsclient.setSetupJal() }
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
                onCheckboxChanged:  { if(!rootJalSetupPage.init) Hsclient.setSetupJal() }
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
                onCheckboxChanged:  { if(!rootJalSetupPage.init) Hsclient.setSetupJal() }
            }
        }
        Item {
            width: parent.width
            height: 100
            SetupCheckbox {
                id: tuer
                checked: true
                bezeichner: "Tür bleibt offen"
                onCheckboxChanged:  { if(!rootJalSetupPage.init) Hsclient.setSetupJal() }
            }
        }
        Item {
            width: parent.width
            height: 100
            SetupCheckbox {
                id: luecke
                checked: true
                bezeichner: "Auf Lücke"
                onCheckboxChanged:  { if(!rootJalSetupPage.init) Hsclient.setSetupJal() }
            }
        }

        // Separator
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
                onCheckboxChanged:  { if(!rootJalSetupPage.init) Hsclient.setSetupJal() }
            }
        }
        Item {
            width: parent.width
            height: 100
            SetupValue {
                id: zeitOeffnen
                leftTextMargin: 50
                enabled: zeit.checked
                bezeichner: "Zeit zum Öffnen:"
                value: "00:00"
                onClicked: {
                    Hsclient.initJalTimeDialog(zeitOeffnen.value)
                    dialog.obj = this;
                    dialog.dialogvisible = true;
                }
            }
        }
        Item {
            width: parent.width
            height: 100
            SetupValue {
                id: zeitSchliessen
                leftTextMargin: 50
                enabled: zeit.checked
                bezeichner: "Zeit zum Schließen:"
                value: "00:00"
                onClicked: {
                    dialog.obj = this;
                    Hsclient.initJalTimeDialog(zeitSchliessen.value)
                    dialog.dialogvisible = true;
                }
            }
        }
    }

    TimePickerSASUDialog {
        id: dialog
        onHasChanged: { obj.value = dialog.zeit; if(!rootJalSetupPage.init) Hsclient.setSetupJal() }
    }
}
