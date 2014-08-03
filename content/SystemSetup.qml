import QtQuick 2.2
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.2
import QtGraphicalEffects 1.0
import "../javascript/hsClient.js" as Hsclient
import "../javascript/global.js" as Global

Rectangle {
    id: rootSystemSetupPage
    width: parent.width
    height: parent.height

    property bool init: true

    Component.onCompleted: {
        Hsclient.getSetupSystem();
        initSystemSettings();
    }

    function initSystemSettings() {
        hostname.value = Global.hostname;
        username.value = Global.username;
        password.setPassword(Global.password);
    }

    Column {
        anchors.fill: parent

        Item {
            width: parent.width
            height: 100
            SetupValue {
                id: hostname

                property string tmpvalue

                bezeichner: "Hostname:"
                onClicked: {
                    textdialog.text = value;
                    textdialog.obj = this;
                    textdialog.dialogvisible = true;
                }
                onTmpvalueChanged: {
                    Global.hostname = tmpvalue;
                    value = tmpvalue;
                }
            }
        }
        Item {
            width: parent.width
            height: 100
            SetupValue {
                id: username

                property string tmpvalue

                bezeichner: "Benutzername:"
                value: Global.username
                onClicked: {
                    textdialog.text = value;
                    textdialog.obj = this;
                    textdialog.dialogvisible = true;
                }
                onTmpvalueChanged: {
                    Global.username = tmpvalue;
                    value = tmpvalue;
                }
            }
        }
        Item {
            width: parent.width
            height: 100
            SetupValue {
                id: password

                property string tmpvalue

                bezeichner: "Passwort"
                onClicked: {
                    textdialog.text = value;
                    textdialog.obj = this;
                    textdialog.dialogvisible = true;
                }
                onTmpvalueChanged: {
                    Global.password = tmpvalue;
                    setPassword(tmpvalue);
                }
                function setPassword (value) {
                    var str = "";
                    for (var i = 0; i < value.length; i++)
                        str = str + "*";
                    password.value = str;
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
                bezeichner: "Autostart GUI"
                hilfetext: "Zeitabhängiger Neustart des Touchscreens."
                onCheckedChanged: { if(!rootSystemSetupPage.init) Hsclient.setSetupSystem() }
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
                    Hsclient.initBewaesserungZeitDialog(autostartGUIZeit.value)
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
        onHasChanged: { obj.value = timepickerdialog.zeit; if(!rootSystemSetupPage.init) Hsclient.setSetupSystem() }
    }
    TextDialog {
        id: textdialog
        onHasChanged: { obj.tmpvalue = textdialog.text }
    }
}
