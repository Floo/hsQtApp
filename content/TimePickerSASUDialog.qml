import QtQuick 2.2
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.2
import QtGraphicalEffects 1.0

Item {
    id: dialog

    property alias dialogvisible: dialogBody.visible
    property string zeit: ""
    property int hour
    property int minute
    property int sonne // 0 - SA, 1 - SU
    property int offset
    property QtObject obj
    property bool sasu: false // true - Sonnenstand, false - Uhrzeit
    property bool valid: false
    signal hasChanged

    QtObject {
        id: shield
        property string tmpSASU: ""
        property string tmpUrzeit: ""
    }

    anchors.fill: parent

    Rectangle {
        id: dialogBackground
        anchors.fill: parent
        color: "grey"
        opacity: 0.2
        visible: dialogBody.visible
        MouseArea {
            anchors.fill: parent
            onClicked: { dialogBody.visible = false }
        }
    }

    Rectangle {
        id: dialogBody
        width: 700
        height: 400
        opacity: 1.0
        visible: false
        anchors.centerIn: parent
        color: "grey"
        border.color: "black"
        border.width: 1
        radius: 3

        onVisibleChanged: {
            if (visible == true) {
                dialog.valid = false;
                dialog.sasu ? tabview.currentIndex = 1 : tabview.currentIndex = 0;
            }
        }

        TabView {
            id: tabview
            width: parent.width
            height: 300
            style: tabTouchStyle
            Tab {
                title: "Uhrzeit"
                TimePicker {
                    id: uhrzeitPicker
                    width: parent.width
                    anchors.top: parent.top
                    anchors.topMargin: 30
                    anchors.horizontalCenter: parent.horizontalCenter
                    hour: dialog.hour
                    minute: dialog.minute
                    onValueChanged: { dialog.hour = hour; dialog.minute = minute; shield.tmpUrzeit = uhrzeit }
                }
            }
            Tab {
                title: "Sonnenstand"
                SASUPicker {
                    id: sonnenstandPicker
                    width: parent.width
                    anchors.top: parent.top
                    anchors.topMargin: 30
                    anchors.horizontalCenter: parent.horizontalCenter
                    sonne: dialog.sonne
                    offset: dialog.offset
                    onValueChanged: { dialog.sonne = sonne; dialog.offset = offset; shield.tmpSASU = uhrzeit }
                }
            }
        }

        Rectangle {
            id: okButton
            width: parent.width / 2
            height: 80
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            color: "transparent"
            Rectangle {
                width: parent.width
                height: 2
                border.color: Qt.lighter("grey", 1.2)
                border.width: 1
            }
            Text {
                anchors.fill: parent
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.family: "Abel"
                font.pointSize: 18
                text: "Übernehmen"
            }
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    dialogBody.visible = false;
                    dialog.valid = true;
                    dialog.sasu = tabview.currentIndex == 0 ? false : true;
                    if (dialog.sasu) {
                        dialog.zeit = shield.tmpSASU;
                    } else {
                        dialog.zeit = shield.tmpUrzeit
                    }
                    dialog.hasChanged()
                }
            }
        }
        Rectangle {
            width: 2
            height: 80
            anchors.bottom: parent.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            border.color: Qt.lighter("grey", 1.2)
            border.width: 1
        }

        Rectangle {
            id: abbruchButton
            width: parent.width / 2
            height: 80
            anchors.bottom: parent.bottom
            anchors.right: parent.right
            color: "transparent"
            Rectangle {
                width: parent.width
                height: 2
                border.color: Qt.lighter("grey", 1.2)
                border.width: 1
            }
            Text {
                anchors.fill: parent
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.family: "Abel"
                font.pointSize: 18
                text: "Abbrechen"
            }
            MouseArea {
                anchors.fill: parent
                onClicked: { dialogBody.visible = false }
            }
        }
    }

    DropShadow {
        id: dialogShadow
        anchors.fill: dialogBody
        horizontalOffset: 5
        verticalOffset: 5
        visible: dialogBody.visible
        radius: 12
        samples: 24
        spread: 1.0
        color: "#80000000"
        source: dialogBody
    }

    Component {
        id: tabTouchStyle
        TabViewStyle {
            tabsAlignment: Qt.AlignVCenter
            tabOverlap: 0
            frame: Item { }
            tab: Item {
                implicitWidth: control.width/control.count
                implicitHeight: 50
                BorderImage {
                    anchors.fill: parent
                    border.bottom: 8
                    border.top: 8
                    source: styleData.selected ? "../images/tab_selected.png":"../images/tabs_standard.png"
                    Text {
                        anchors.centerIn: parent
                        color: "white"
                        text: styleData.title.toUpperCase()
                        font.pixelSize: 16
                    }
                    Rectangle {
                        visible: index > 0
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.margins: 10
                        width:1
                        color: "#3a3a3a"
                    }
                }
            }
        }
    }
}
