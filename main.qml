import QtQuick 2.2
import QtQuick.Controls 1.2
import QtQml.Models 2.1
import "content"

ApplicationWindow {
    visible: true
    width: 800
    height: 1280
    title: qsTr("Meth 9")

    Rectangle {
        id: root
        color: "#ffffff"
        anchors.fill: parent
    }

    toolBar: BorderImage {
        id: header
        border.bottom: 8
        source: "images/toolbar.png"
        width: parent.width
        height: 80

        Rectangle {
            id: backButton
            width: opacity ? 60 : 0
            anchors.left: parent.left
            anchors.leftMargin: 20
            opacity: stackView.depth > 1 ? 1 : 0
            anchors.verticalCenter: parent.verticalCenter
            antialiasing: true
            height: 60
            radius: 4
            color: backmouse.pressed ? "#222" : "transparent"
            Behavior on opacity { NumberAnimation{} }
            Image {
                anchors.verticalCenter: parent.verticalCenter
                source: "images/navigation_previous_item.png"
            }
            MouseArea {
                id: backmouse
                anchors.fill: parent
                anchors.margins: -10
                onClicked: stackView.pop()
            }
        }

        Text {
            font.pixelSize: 42
            Behavior on x { NumberAnimation{ easing.type: Easing.OutCubic} }
            x: backButton.x + backButton.width + 20
            anchors.verticalCenter: parent.verticalCenter
            color: "white"
            text: "Meth 9"
        }
    }
    ListModel {
        id: pageModel
        ListElement {
            title: "Jalousie"
            page: "content/JalousiePage.qml"
            pic: "images/jalousie_m.png"
        }
        ListElement {
            title: "Bewässerung"
            page: "content/BewaesserungPage.qml"
            pic: "images/bewaesserung_m.png"

        }
        ListElement {
            title: "Licht"
            page: "content/LichtPage.qml"
            pic: "images/licht_m.png"
        }
        ListElement {
            title: "Lichtszenen"
            page: "content/SzenePage.qml"
            pic: "images/szene_m.png"
        }
    }

    StackView {
        id: stackView
        anchors.fill: parent
        // Implements back key navigation
        focus: true
        Keys.onReleased: if (event.key === Qt.Key_Back && stackView.depth > 1) {
                             stackView.pop();
                             event.accepted = true;
                         }

        initialItem: Item {
            width: parent.width
            height: parent.height

            Column {
                id: meth9
                anchors.horizontalCenter: parent.horizontalCenter

                Image {
                    id: meth9Pic
                    anchors.horizontalCenter: parent.horizontalCenter
                    source: "images/haus_klein.png"
                }
                Text {
                    id: meth9Text
                    anchors.horizontalCenter: parent.horizontalCenter
                    color: "#E3905C"
                    font.family: "Abel"
                    font.pointSize: 15
                    text: "Haussteuerung - Methfesselstr. 9"
                }

                GridView {
                    anchors.horizontalCenter: parent.horizontalCenter
                    model: pageModel
                    width: 400; height: 400
                    cellWidth: 200; cellHeight: 200
                    delegate: StartButton {
                        source: pic
                        onButtonClicked: stackView.push(Qt.resolvedUrl(page))
                    }

                }
            }
        }
    }
}
