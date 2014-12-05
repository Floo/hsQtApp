import QtQuick 2.2
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.2
import QtGraphicalEffects 1.0
import AppSettings 1.0
import "../javascript/hsClient.js" as Hsclient
import "../javascript/global.js" as Global
import "../javascript/storage.js" as Storage

Rectangle {
    id: rootSystemSetupPage
    width: parent.width
    height: parent.height
    z: -1

    property bool init: true
    readonly property string name: "Setup - System"

    function isVisibleDialog() {
        return textdialog.dialogvisible || timepickerdialog.dialogvisible
    }

    Component.onCompleted: {
        Hsclient.getSetupSystem();
        initSystemSettings();
    }

    function initSystemSettings() {
        hostname.value = Global.hostname;
        username.value = Global.username;
        password.setPassword(Global.password);
    }

    MouseArea {
        anchors.fill: parent
        onClicked: Global.mainobj.state = "nothingVisible";
    }

    Column {
        anchors.fill: parent

        Item {
            width: parent.width
            height: 150
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
                    Global.hostname = tmpvalue.toLowerCase();
                    Storage.setSetting("hostname", tmpvalue.toLowerCase());
                    Hsclient.checkNetworkSettings();
                    value = tmpvalue.toLowerCase();
                }
            }
        }
        Item {
            width: parent.width
            height: 150
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
                    Storage.setSetting("username", tmpvalue);
                    Hsclient.checkNetworkSettings();
                    value = tmpvalue;
                }
            }
        }
        Item {
            width: parent.width
            height: 150
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
                    Storage.setSetting("password", tmpvalue);
                    Hsclient.checkNetworkSettings();
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
            height: 45
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
                id: autostartGUI
                bezeichner: "Autostart GUI"
                hilfetext: "Zeitabhängiger Neustart des Touchscreens."
                onCheckedChanged: { if(!rootSystemSetupPage.init) Hsclient.setSetupSystem() }
            }
        }
        Item {
            width: parent.width
            height: 150
            SetupValue {
                id: autostartGUIZeit
                leftTextMargin: 65
                enabled: autostartGUI.checked
                bezeichner: "Startzeit:"
                value: "7:00"
                onClicked: {
                    timepickerdialog.obj = this;
                    Hsclient.initZeitDialog(autostartGUIZeit.value)
                    timepickerdialog.dialogvisible = true;
                }
            }
        }

        // Separator
        Item {
            width: parent.width
            height: 45
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
            SetupValue {
                id: showVersion
                bezeichner: "App Info"
                value: "Meth9, Version: " + appsettings.version + ", Build: " +
                       appsettings.builddate + ", " + appsettings.buildtime
            }
        }
    }
    TimePickerDialog {
        id: timepickerdialog
        onHasChanged: { obj.value = timepickerdialog.zeit; if(!rootSystemSetupPage.init) Hsclient.setSetupSystem() }
    }
    TextDialog {
        id: textdialog
        onHasChanged: { obj.tmpvalue = textdialog.text.replace(/ /g, '') }
    }

    AppSettings {
        id: appsettings
    }
}
