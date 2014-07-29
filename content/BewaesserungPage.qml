import QtQuick 2.2
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.2

Item {
    id: rootBewaesserungPage
    width: parent.width
    height: parent.height
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
                checked: true
            }
        }
    }
}

