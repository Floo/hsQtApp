import QtQuick 2.2
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.2
import "../javascript/hsClient.js" as Hsclient
import "../javascript/global.js" as Global

Item {
    id: rootBewaesserungPage
    width: parent.width
    height: parent.height
    z: -1

    readonly property string name: "Bewässerung"
    property bool cancelBeeteEvent: false
    property bool cancelKuebelEvent: false
    function isVisibleDialog() {
        return false
    }

    MouseArea {
        anchors.fill: parent
        onClicked: Global.mainobj.state = "nothingVisible";
    }

    Component.onCompleted: Hsclient.getStatusBewaesserung()

    Timer {
        id: reloadStatusTimer
        interval: 1000
        repeat: false
        onTriggered: Hsclient.getStatusBewaesserung()
    }

    Column {
        Rectangle {
            height: 120
            width: rootBewaesserungPage.width
            color: "#E3905C"

            Text {
                anchors.centerIn: parent
                color: "#000000"
                font.family: "Abel"
                font.pointSize: 16
                font.bold: true
                text: "Beete:"
            }
        }
        Item {
            width: 600; height: 600
            PanelBewaesserung {
                id: beete
                anchors { horizontalCenter: parent.horizontalCenter; top: parent.top; topMargin: 65 }
                enabled: !kuebel.checked
                value: 6
                //checked: statusText.indexOf("Aus") < 0
                onSwitched: {
                    if(!cancelBeeteEvent) {
                        Hsclient.setBewaesserung(1, checked, value);
                        reloadStatusTimer.restart();
                    }
                    cancelBeeteEvent = false;
                }
            }
        }
        Rectangle {
            height: 120
            width: rootBewaesserungPage.width
            color: "#E3905C"

            Text {
                anchors.centerIn: parent
                color: "#000000"
                font.family: "Abel"
                font.pointSize: 16
                font.bold: true
                text: "Kübel:"
            }
        }
        Item {
            width: 600; height: 600
            PanelBewaesserung {
                id: kuebel
                anchors { horizontalCenter: parent.horizontalCenter; top: parent.top; topMargin: 65 }
                enabled: !beete.checked
                value: 6
                //checked: statusText.indexOf("Aus") < 0
                onSwitched: {
                    if(!cancelKuebelEvent) {
                        Hsclient.setBewaesserung(2, checked, value);
                        reloadStatusTimer.restart();
                    }
                    cancelKuebelEvent = false;
                }
            }
        }
    }
}

