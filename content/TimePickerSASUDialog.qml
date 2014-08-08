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

    Item {
        id: dialogBody
        width: 720
        height: 470
        visible: false
        anchors.centerIn: parent

        onVisibleChanged: {
            if (visible == true) {
                dialog.valid = false;
                dialog.sasu ? tabview.currentIndex = 1 : tabview.currentIndex = 0;
            }
        }

        Rectangle {

            width: 700
            height: 450
            opacity: 1.0

            anchors.centerIn: parent
            color: "grey"
            border.color: Qt.lighter("grey", 0.9)
            border.width: 1
            radius: 3

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
                opacity : okMouse.pressed ? 0.2 : 1
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
                    id : okMouse
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
                opacity: abbruchMouse.pressed ? 0.2 : 1
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
                    id: abbruchMouse
                    anchors.fill: parent
                    onClicked: { dialogBody.visible = false }
                }
            }
        }
    }

    DropShadow {
        id: dialogShadow
        anchors.fill: source
        horizontalOffset: 4
        verticalOffset: 4
        visible: dialogBody.visible
        radius: 14
        samples: 24
        spread: 0.3
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
                Rectangle {
                    anchors.fill: parent
                    color: Qt.lighter("grey", 0.8)

//                BorderImage {
//                    anchors.fill: parent
//                    border.bottom: 8
//                    border.top: 8
//                    source: styleData.selected ? "../images/toolbar.png" : ""
                    Text {
                        anchors.centerIn: parent
                        color: "white"
                        text: styleData.title.toUpperCase()
                        font.pixelSize: 18
                    }
                    Rectangle {
                        visible: index > 0
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.margins: 10
                        width:1
                        color: Qt.lighter("grey", 1.2)//"#3a3a3a"
                    }
                    Rectangle {
                        width: parent.width
                        height: 4
                        anchors.bottom: parent.bottom
                        color: "#E3905C"
                        visible: styleData.selected
                    }
                }
            }
        }
    }
}
