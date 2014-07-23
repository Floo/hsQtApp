import QtQuick 2.2
import QtQuick.Controls 1.1
import QtQml.Models 2.1
import "./content"

Rectangle {
    id: root
    width: 1000
    height: 700

    Rectangle {
        id: header
        height: 80
        anchors.top: parent.top
        width:  parent.width
        color: "#000000"

        Image {
            id: arrow
            source: "content/icon-left-arrow.png"
            anchors.left: header.left
            anchors.leftMargin: 20
            anchors.verticalCenter: header.verticalCenter

            MouseArea {
                anchors.fill: parent
                onClicked: ;
            }
        }
    }

    Item {
        id: meth9
        width:  meth9Text.width
        height: meth9Text.height + meth9Pic.height
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: header.bottom
        anchors.topMargin: 20

        Image {
            id: meth9Pic
            anchors.horizontalCenter: parent.horizontalCenter
            source: "content/haus_klein.png"
        }
        Text {
            id: meth9Text
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: meth9Pic.bottom
            color: "#E3905C"
            font.family: "Abel"
            font.pointSize: 15
            text: "Haussteuerung - Methfesselstr. 9"
        }
    }
    Item {
        id: buttons
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: meth9.bottom
        width: leftCol.width + rightCol.width
        height: leftCol.height

        Column {
            id: leftCol
            spacing: 2
            anchors.left: parent.left

            ButtonMeth {
                id: buttonJal
                source: "content/jalousie_m.png"
            }

            ButtonMeth {
                id: buttonLicht
                source: "content/licht_m.png"
            }
        }
        Column {
            id: rightCol
            spacing: 2
            anchors.right: parent.right

            ButtonMeth {
                id: buttonWasser
                source: "content/bewaesserung_m.png"
            }

            ButtonMeth {
                id: buttonSzene
                source: "content/szene_m.png"
            }
        }
    }
}
