import QtQuick 2.2
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.2
import "../javascript/hsClient.js" as Hsclient

Item {
    id: rootBewaesserungPage
    width: parent.width
    height: parent.height

    Component.onCompleted: Hsclient.getStatusBewaesserung()

    Column {
        Rectangle {
            height: 80
            width: rootBewaesserungPage.width
            color: "#E3905C"

            Text {
                anchors.centerIn: parent
                color: "#000000"
                font.family: "Abel"
                font.pointSize: 38
                text: "Beete:"
            }
        }
        Item {
            width: 400; height: 400
            PanelBewaesserung {
                anchors { horizontalCenter: parent.horizontalCenter; top: parent.top; topMargin: 50 }
                id: beete
                value: 10
                checked: statusText.indexOf("An") > -1
                onSwitched: Hsclient.setBewaesserung(1, checked, value)
            }
        }
        Rectangle {
            height: 80
            width: rootBewaesserungPage.width
            color: "#E3905C"

            Text {
                anchors.centerIn: parent
                color: "#000000"
                font.family: "Abel"
                font.pointSize: 38
                text: "Kübel:"
            }
        }
        Item {
            width: 400; height: 400
            PanelBewaesserung {
                anchors { horizontalCenter: parent.horizontalCenter; top: parent.top; topMargin: 50 }
                id: kuebel
                value: 8
                checked: statusText.indexOf("An") > -1
                onSwitched: Hsclient.setBewaesserung(2, checked, value)
            }
        }
    }
}

