import QtQuick 2.2
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.2
import QtGraphicalEffects 1.0
import "../javascript/hsClient.js" as Hsclient
import "../javascript/global.js" as Global

Rectangle {
    id: rootVerlaufPage
    width: parent.width
    height: parent.height
    z: -1

    property bool init: true
    readonly property string name: "Verlauf"

    property bool hasChangedSelection: false

    function isVisibleDialog() {
        return false
    }

    Component.onCompleted: {
        var i;
        auswahl.y = -500;

        for(i = 0; i < modelKurve1.count; i++) {
            if(modelKurve1.get(i).wert === Global.kurve1) {
                textKurve1.text = modelKurve1.get(i).name;
            }
        }
        for(i = 0; i < modelKurve2.count; i++) {
            if(modelKurve2.get(i).wert === Global.kurve2) {
                textKurve2.text = modelKurve2.get(i).name;
            }
        }
        for(i = 0; i < modelIintervall.count; i++) {
            if(modelIintervall.get(i).wert === Global.intervall) {
                textIntervall.text = modelIintervall.get(i).name;
            }
        }
        Hsclient.getVerlauf(Global.kurve1, Global.kurve2, Global.intervall);
        hasChangedSelection = false;
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            auswahl.y = -500
            Global.mainobj.state = "nothingVisible";
        }
    }

    ListModel {
        id: modelKurve1
        property int liste: 1
        ListElement { name: "Temperatur<br>innen"; wert: 1 }
        ListElement { name: "Temperatur<br>außen"; wert: 2 }
        ListElement { name: "Luftfeuchte"; wert: 3 }
        ListElement { name: "Wind-<br>geschwindigkeit"; wert: 4 }
        ListElement { name: "Regen"; wert: 5 }
        ListElement { name: "Helligkeit"; wert: 6 }
        ListElement { name: "Empfang"; wert: 7 }
    }

    ListModel {
        id: modelKurve2
        property int liste: 2
        ListElement { name: "-------"; wert: 0 }
        ListElement { name: "Temperatur<br>innen"; wert: 1 }
        ListElement { name: "Temperatur<br>außen"; wert: 2 }
        ListElement { name: "Luftfeuchte"; wert: 3 }
        ListElement { name: "Wind-<br>geschwindigkeit"; wert: 4 }
        ListElement { name: "Regen"; wert: 5 }
        ListElement { name: "Helligkeit"; wert: 6 }
    }

    ListModel {
        id: modelIintervall
        property int liste: 3
        ListElement { name: "Tag"; wert: 1 }
        ListElement { name: "3 Tage"; wert: 2 }
        ListElement { name: "Woche"; wert: 3 }
        ListElement { name: "Monat"; wert: 4 }
    }

    Image {
        id: verlaufImage
        width: parent.width - 30
        height: parent.height - 90
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: 30
        anchors.horizontalCenter: parent.horizontalCenter
        fillMode: Image.PreserveAspectFit
        visible: status === Image.Ready
    }

    ProgressBar {
        anchors.centerIn: parent
        width: 300
        style: touchStyle
        value: verlaufImage.status === Image.Null ? 0 : verlaufImage.progress
        visible: verlaufImage.status === Image.Loading || verlaufImage.status === Image.Null
    }

    Text {
        id: errorMessage
        text: "Ladefehler"
        font.family: "Abel"
        font.pointSize: 22
        color: "grey"
        visible: verlaufImage.status === Image.Error
    }

    Item {
        id: auswahl
        width: rootVerlaufPage.width / 4 + 60
        height: 440
        x: 0
        y: -600

        Behavior on y { NumberAnimation { easing.type: Easing.OutCubic }}

        ListView {
            id: listviewAuswahl
            width: rootVerlaufPage.width / 4 + 40
            height: 420
            model: modelKurve1
            delegate: Rectangle {
                width: rootVerlaufPage.width / 4 + 40
                height: 60
                border.color: "black"
                border.width: 1
                color: auswahlMouse.pressed ? Qt.lighter("lightgrey", 0.8) : "lightgrey"

                Text {
                    anchors.centerIn: parent
                    font.family: "Abel"
                    font.pixelSize: 22
                    horizontalAlignment: Text.AlignHCenter
                    text: name
                }
                MouseArea {
                    id: auswahlMouse
                    anchors.fill: parent
                    onClicked: {
                        auswahl.y = -500
                        Global.mainobj.state = "nothingVisible";
                        if(listviewAuswahl.model.liste === 1) {
                            Global.kurve1 = wert;
                            textKurve1.text = name;
                        } else if(listviewAuswahl.model.liste === 2) {
                            textKurve2.text = name;
                            Global.kurve2 = wert;
                        } else if(listviewAuswahl.model.liste === 3) {
                            textIntervall.text = name;
                            Global.intervall = wert;
                        }
                    }
                }
            }

        }
    }
    DropShadow {
        anchors.fill: source
        horizontalOffset: 4
        verticalOffset: 4
        radius: 14
        samples: 24
        spread: 0.3
        color: "#80000000"
        source: auswahl
    }

    Row {
        height: 60
        width: parent.width
        Rectangle {
            id: kurve1
            width: parent.width / 4
            height: parent.height
            color: mouseKurve1.pressed ? Qt.lighter("grey", 0.8) : "grey"

            Text {
                id: textKurve1
                anchors.centerIn: parent
                font.family: "Abel"
                font.pixelSize: 22
                horizontalAlignment: Text.AlignHCenter
                color: "#E3905C"
                onTextChanged: hasChangedSelection = true
            }

            MouseArea {
                id: mouseKurve1
                anchors.fill: parent
                onClicked: {
                    Global.mainobj.state = "nothingVisible";
                    listviewAuswahl.model = modelKurve1
                    if(auswahl.y < 0) {
                        auswahl.x = 0
                        auswahl.y = 60
                    } else {
                        menuAnimation.xValue = 0
                        menuAnimation.start()
                    }
                }

            }
            Rectangle {
                width: 1
                height: parent.height - 20
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right
                color: "#E3905C"
            }
        }
        Rectangle {
            id: kurve2
            width: parent.width / 4
            height: parent.height
            color: mouseKurve2.pressed ? Qt.lighter("grey", 0.8) : "grey"

            Text {
                id: textKurve2
                anchors.centerIn: parent
                font.family: "Abel"
                font.pixelSize: 22
                horizontalAlignment: Text.AlignHCenter
                color: "#E3905C"
                onTextChanged: hasChangedSelection = true
            }

            MouseArea {
                id: mouseKurve2
                anchors.fill: parent
                onClicked: {
                    Global.mainobj.state = "nothingVisible";
                    listviewAuswahl.model = modelKurve2
                    if(auswahl.y < 0) {
                        auswahl.x = rootVerlaufPage.width / 4
                        auswahl.y = 60
                    } else {
                        menuAnimation.xValue = rootVerlaufPage.width / 4
                        menuAnimation.start()
                    }
                }
            }
            Rectangle {
                width: 1
                height: parent.height - 20
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right
                color: "#E3905C"
            }
        }
        Rectangle {
            id: intervall
            width: parent.width / 4
            height: parent.height
            color: mouseIntervall.pressed ? Qt.lighter("grey", 0.8) : "grey"

            Text {
                id: textIntervall
                anchors.centerIn: parent
                font.family: "Abel"
                font.pixelSize: 22
                horizontalAlignment: Text.AlignHCenter
                color: "#E3905C"
                onTextChanged: hasChangedSelection = true
            }

            MouseArea {
                id: mouseIntervall
                anchors.fill: parent
                onClicked: {
                    Global.mainobj.state = "nothingVisible";
                    listviewAuswahl.model = modelIintervall
                    if(auswahl.y < 0) {
                        auswahl.x = rootVerlaufPage.width / 2
                        auswahl.y = 60
                    } else {
                        menuAnimation.xValue = rootVerlaufPage.width / 2
                        menuAnimation.start()
                    }
                }
            }
            Rectangle {
                width: 1
                height: parent.height - 20
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right
                color: "#E3905C"
            }
        }
        Rectangle {
            id: reload
            width: parent.width / 4
            height: parent.height
            color: mouseReload.pressed ? Qt.lighter("grey", 0.8) : "grey"

            Text {
                anchors.centerIn: parent
                font.family: "Abel"
                font.pixelSize: 22
                horizontalAlignment: Text.AlignHCenter
                font.weight: Font.DemiBold
                color: "#E3905C"
                text: "Reload"
            }

            MouseArea {
                id: mouseReload
                anchors.fill: parent
                onClicked: {
                    Global.mainobj.state = "nothingVisible";
                    auswahl.y = -500;
                    if(hasChangedSelection) Hsclient.getVerlauf(Global.kurve1, Global.kurve2, Global.intervall);
                    hasChangedSelection = false;
                }
            }
        }
    }

    SequentialAnimation {
        id: menuAnimation
        property alias xValue: menuAnimationAction.value
        NumberAnimation { target: auswahl ; property: "y"; duration: 200; from: 60; to: -500; easing.type: Easing.OutCubic }
        PropertyAction { id: menuAnimationAction; target: auswahl; property: "x"; value: rootVerlaufPage.width / 4 }
        NumberAnimation { target: auswahl; property: "y"; duration: 200; from: -500; to: 60; easing.type: Easing.OutCubic }
    }

    Rectangle {
        id: buttonRotate
        width: 80
        height: width
        anchors.bottom: parent.bottom
        anchors.rightMargin: 20
        anchors.right: parent.right
        anchors.bottomMargin: 20
        radius: 3
        color: mouseRotate.pressed ? "lightgrey" : "transparent"

        Image {
            anchors.fill: parent
            fillMode: Image.PreserveAspectFit
            source: "../images/rotate_qt.png"

            MouseArea {
                id: mouseRotate
                anchors.fill: parent
                anchors.margins: -20
                onClicked: {
                    Global.mainobj.state = "nothingVisible";
                    auswahl.y = -500;
                    if(verlaufImage.rotation === 0) {
                        verlaufImage.rotation = 90
                        verlaufImage.height = rootVerlaufPage.width - 30
                        verlaufImage.width = rootVerlaufPage.height - 90
                    } else {
                        verlaufImage.rotation = 0
                        verlaufImage.height = rootVerlaufPage.height - 90
                        verlaufImage.width = rootVerlaufPage.width - 30
                    }
                }
            }
        }
    }

    Component {
        id: touchStyle
        ProgressBarStyle {
            panel: Rectangle {
                implicitHeight: 15
                implicitWidth: 300
                color: "#444"
                opacity: 0.8
                Rectangle {
                    antialiasing: true
                    radius: 1
                    color: "#E3905C"
                    height: parent.height
                    width: parent.width * control.value / control.maximumValue
                }
            }
        }
    }
}
