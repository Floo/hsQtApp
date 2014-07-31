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
                onCheckboxChanged: { dialog.dialogvisible = true }
            }
        }
    }

    TimePickerDialog {
        id: dialog
        hour: 12
        minute: 40
        onHasChanged: console.debug(hour + ":" + minute)
    }


}
