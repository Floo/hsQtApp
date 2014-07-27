import QtQuick 2.2
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.1
import "../content"

    //ScrollView {
    Item {
        width: parent.width
        height: parent.height
        Rectangle {
            id: singleHeadline
            height: 80
            width: parent.width
            color: "#E3905C"

            Text {
                anchors.centerIn: parent
                color: "#000000"
                font.family: "Abel"
                font.pointSize: 15
                text: "Einzeln:"
            }
        }
        ListView {
            id: listSingle
            anchors.fill: parent
            anchors.top: parent.top
            anchors.topMargin: 80
            model: SingleJalModel {}
            delegate: SingleJalDelegate {text: name; subtext: "Undefiniert/Stop"}
        }
        Rectangle {
            id: groupHeadline
            anchors.top: parent.top
            anchors.topMargin: 432
            height: 80
            width: parent.width
            color: "#E3905C"
            Text {
                anchors.centerIn: parent
                color: "#000000"
                font.family: "Abel"
                font.pointSize: 15
                text: "Gruppe:"
            }
        }
        ListView {
            id: listGroup
            anchors.fill: parent
            anchors.top: parent.top
            anchors.topMargin: 512
            model: GroupJalModel {}
            delegate: SingleJalDelegate {text: name}
        }
    }


