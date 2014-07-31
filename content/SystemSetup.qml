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
            SetupValue {
                id: hostname
                bezeichner: "Hostname:"
                value: "snugata.selfhost.eu"
                onClicked: {
                    textdialog.text = value;
                    textdialog.obj = this;
                    textdialog.dialogvisible = true;
                }
            }
        }
        Item {
            width: parent.width
            height: 100
            SetupValue {
                id: username
                bezeichner: "Benutzername:"
                value: "florian"
                onClicked: {
                    textdialog.text = value;
                    textdialog.obj = this;
                    textdialog.dialogvisible = true;
                }
            }
        }
        Item {
            width: parent.width
            height: 100
            SetupValue {
                id: password
                bezeichner: "Passwort"
                value: "*******"
                onClicked: {
                    textdialog.text = value;
                    textdialog.obj = this;
                    textdialog.dialogvisible = true;
                }
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
                id: autostartGUI
                checked: true
                bezeichner: "Autostart GUI"
                hilfetext: "Zeitabhängiger Neustart des Touchscreens."
                onCheckedChanged: {}
            }
        }
        Item {
            width: parent.width
            height: 100
            SetupValue {
                id: autostartGUIZeit
                leftTextMargin: 50
                enabled: autostartGUI.checked
                bezeichner: "Startzeit:"
                value: "7:00"
                onClicked: {
                    timepickerdialog.obj = this;
                    timepickerdialog.hour = 7;
                    timepickerdialog.minute = 0;
                    timepickerdialog.dialogvisible = true;
                }
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
            SetupValue {
                id: showLogfile
                bezeichner: "Logfile anzeigen"
                onClicked: { console.debug("Logfile anzeigen") }
            }
        }
    }
    TimePickerDialog {
        id: timepickerdialog
        onHasChanged: { obj.value = timepickerdialog.zeit }
    }
    TextDialog {
        id: textdialog
        onHasChanged: { obj.value = textdialog.text }
    }
}
