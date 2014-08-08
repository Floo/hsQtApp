import QtQuick 2.2
import QtQuick.Controls 1.2
import QtQuick.Dialogs 1.2
import QtQml.Models 2.1
import QtGraphicalEffects 1.0
import AppSettings 1.0
import "content"
import "javascript/hsClient.js" as Hsclient
import "javascript/global.js" as Global
import "javascript/storage.js" as Storage

ApplicationWindow {
    visible: true
    width: 800
    height: 1280
    title: qsTr("Meth 9")

    Component.onCompleted: {
        // Initialize the database
        Storage.initialize();

        Global.hostname = Storage.getSetting("hostname");
        Global.username = Storage.getSetting("username");
        Global.password = Storage.getSetting("password");

        Global.mainobj = mainPage;

        Hsclient.checkNetworkSettings();

        if (!Global.networkconfigOK) {
            messageDialog.title = "Netzwerkfehler"
            messageDialog.informativeText = "Netzwerkkonfiguration unvollständig."
            messageDialog.visible = true;
        }

        Hsclient.getStatus()
    }

    AppSettings {
        id: settings
        Component.onCompleted: console.log("Version " + version)
    }

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
            id: infoButton
            width:  80
            height: 80
            x: -30
            visible: stackView.depth == 1
            anchors.verticalCenter: parent.verticalCenter
            color: "transparent"

            Behavior on x { NumberAnimation {} }

            Image {
                width: 70; height: 70
                anchors.centerIn: parent
                source: "images/info_white.png"
            }
            MouseArea {
                id: infomouse
                anchors.fill: parent
                anchors.margins: -10
                onClicked: {
                    if (mainPage.state == "infoVisible") {
                        mainPage.state = "nothingVisible"
                    } else {
                        mainPage.state = "infoVisible"
                        Hsclient.getStatus()
                    }
                }
            }
        }

        Rectangle {
            id: homeButton
            width: 80
            height: 80
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: setupButton.left
            anchors.rightMargin: 30
            visible: opacity
            opacity: stackView.depth > 1 ? 1 : 0
            color: "transparent"

            Behavior on opacity { NumberAnimation{} }

            Image {
                fillMode: Image.PreserveAspectFit
                width: 65
                height: 65
                anchors.centerIn: parent
                source: "images/navigation_home.png"
            }

            MouseArea {
                anchors.fill: parent
                anchors.margins: -10
                onClicked: {
                    stackView.pop(null)
                    textStatuszeile.text = stackView.currentItem.name;
                    mainPage.state = "nothingVisible";
                }
            }
        }

        Rectangle {
            id: setupButton
            width: 70
            height: 70
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: 30

            color: "transparent"

            Image {
                anchors.fill: parent
                source: "images/setup_white.png"
            }

            MouseArea {
                anchors.fill: parent
                anchors.margins: -10
                onClicked: {
                    if (mainPage.state == "setupVisible") {
                        mainPage.state = "nothingVisible"
                    } else {
                        if (!stackView.currentItem.isVisibleDialog()) {
                            mainPage.state = "setupVisible"
                        }
                    }
                }
            }
        }

        Rectangle {
            id: backButton
            width: 60
            anchors.left: parent.left
            anchors.leftMargin: 60
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
                onClicked: {
                    stackView.pop();
                    textStatuszeile.text = stackView.currentItem.name;
                    mainPage.state = "nothingVisible";
                }
            }
        }

        Text {
            id: textStatuszeile
            font.pixelSize: 42
            //Behavior on x { NumberAnimation{ easing.type: Easing.OutCubic} }
            x: backButton.x + 80
            anchors.verticalCenter: parent.verticalCenter
            color: "white"
            text: "Meth 9"
        }
    }


    ListModel {
        id: setupModel
        ListElement {
            title: "Einstellungen"
        }
        ListElement {
            title: "Jalousie"
            page: "content/JalousieSetup.qml"
            name: "Setup - Jalousie"
        }
        ListElement {
            title: "Bewässerung"
            page: "content/BewaesserungSetup.qml"
            name: "Setup - Bewässerung"
        }
        ListElement {
            title: "Lüftung"
            page: "content/AbluftSetup.qml"
            name: "Setup - Lüftung"
        }
        ListElement {
            title: "System"
            page: "content/SystemSetup.qml"
            name: "Setup - System"
        }
    }

    ListModel {
        id: pageModel
        ListElement {
            title: "Jalousie"
            page: "content/JalousiePage.qml"
            pic: "images/jalousie_m.png"
            buttontext: "Jalousie"
        }
        ListElement {
            title: "Bewässerung"
            page: "content/BewaesserungPage.qml"
            pic: "images/bewaesserung_m.png"
            buttontext: "Bewässerung"

        }
        ListElement {
            title: "Licht"
            page: "content/LichtPage.qml"
            pic: "images/licht_m.png"
            buttontext: "Licht"
        }
        ListElement {
            title: "Lichtszenen"
            page: "content/SzenePage.qml"
            pic: "images/szene_m.png"
            buttontext: "Lichtszenen"
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
            id: mainPage
            width: parent.width
            height: parent.height
            z: -1

            readonly property string name: "Meth 9"

            function isVisibleDialog() {
                return false
            }

//            MouseArea {
//                property bool gestActive: false
//                property real oldX
//                anchors.fill: parent
//                onPressed: {
//                    if (mouseX < parent.width / 5) {
//                        //console.log("startGesture")
//                        gestActive = true;
//                        oldX = mouseX;
//                    }
//                    Global.mainobj.state = "";
//                }
//                onMouseXChanged: {
//                    if (gestActive && mouseX - oldX > 100) {
//                        mainPage.state = "infoVisible"
//                    }
//                }
//                onReleased: {
//                    gestActive = false;
//                }
//            }

            MouseArea {
                property bool gestActive: false
                anchors.fill: parent
                onPressed: {
                    if (mouseX < 20) {
                        gestActive = true;
                    }
                }
                onMouseXChanged: {
                    if (gestActive) {
                        infoLeiste.x = mouseX - infoLeiste.breite;
                    }
                }
                onReleased: {
                    if (gestActive) {
                        gestActive = false;
                        if(mouseX > infoLeiste.breite/2) {
                            mainPage.state = "infoVisible";
                        } else {
                            infoLeiste.x = -infoLeiste.width
                        }
                    } else {
                        mainPage.state = "nothingVisible";
                    }
                }
            }

            Column {
                id: meth9

                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                anchors.topMargin: 20

                Image {
                    id: meth9Pic
                    height: 280
                    width: 280
                    anchors.horizontalCenter: parent.horizontalCenter
                    source: "images/haus_klein.png"
                    fillMode: Image.PreserveAspectFit
                }
                Text {
                    id: meth9Text
                    anchors.horizontalCenter: parent.horizontalCenter
                    color: "#E3905C"
                    font.family: "Abel"
                    font.pointSize: 18
                    text: "Haussteuerung - Methfesselstr. 9"
                }

                GridView {
                    id: gridView
                    anchors.horizontalCenter: parent.horizontalCenter
                    model: pageModel
                    width: 600; height: 600
                    cellWidth: width/2; cellHeight: height/2
                    delegate: StartButton {
                        width: gridView.cellWidth
                        source: pic
                        text: buttontext
                        color: pressed ? "lightgrey" : "transparent"
                        onButtonClicked: {
                            if (overlay.visible == false) {
                                mainPage.state = "nothingVisible";
                                stackView.push(Qt.resolvedUrl(page));
                                textStatuszeile.text = buttontext;
                            }
                        }
                    }
                }
            }

            Item {
                id: infoLeiste

                property int breite: 0.75 * parent.width
                property int largeFont: 12
                property int smallFont: 14

                width: breite + 20
                height: parent.height
                anchors.top: parent.top
                z: 2
                x: -width

                Behavior on x {NumberAnimation { easing.type: Easing.OutCubic } }

                MouseArea {
                    property bool gestActive: false
                    property real oldX
                    anchors.fill: parent
                    onPressed: {
                        gestActive = true;
                        oldX = mouseX;
                    }
                    onMouseXChanged: {
                        if (gestActive && mouseX - oldX < - 200) {
                            mainPage.state = "nothingVisible"
                        }
                    }
                    onReleased: {
                        gestActive = false;
                    }
                }

                Rectangle {
                    height: parent.height
                    width: parent.breite
                    anchors.top: parent.top
                    color: "#eeeeee"

                    Column {
                        //anchors.horizontalCenter: parent.horizontalCenter
                        property int largeFont: 12
                        property int smallFont: 10

                        anchors.top: parent.top
                        anchors.topMargin: 10
                        Rectangle {
                            height: 100
                            width: infoLeiste.breite
                            color: "transparent"
                            Row {
                                anchors.horizontalCenter: parent.horizontalCenter
                                spacing: 20
                                Text {
                                    height: 100
                                    font.family: "Abel"
                                    font.pixelSize: 22
                                    font.bold: true
                                    verticalAlignment: Qt.AlignVCenter
                                    text: "aktuell:"
                                }

                                Image {
                                    width: 90
                                    height: 100
                                    fillMode: Image.PreserveAspectFit
                                    id: aktuellesWetter
                                    source: "images/Sonne.png"
                                }
                            }
                            Rectangle {
                                height: 1
                                anchors.bottom: parent.bottom
                                width: infoLeiste.breite
                                color: "black"
                            }
                        }

                        InfoElement {
                            id: temperatur
                            source: "images/temp_qt.png"
                            bezeichner: "innen:<br>außen:"
                        }
                        InfoElement {
                            id: regen
                            height: 110
                            source: "images/regentropfen_qt.png"
                            bezeichner: "Regen (1h):<br>Regen (24h):<br>Regen (7d):"
                        }
                        InfoElement {
                            id: jalousie
                            height: 140
                            source: "images/jalousie_qt.png"
                            bezeichner: "Jalousie 1:<br>Jalousie 2:<br>Jalousie 3:<br>Jalousie 4:"
                        }
                        InfoElement {
                            id: lueftung
                            source: "images/lueftung_qt.png"
                            bezeichner: "Orientierungslicht:<br>Abluft HWR:"
                        }
                        InfoElement {
                            id: sasu
                            source: "images/sasu_qt.png"
                            bezeichner: "Sonnenaufgang:<br>Sonnenuntergang:"
                        }
                        InfoElement {
                            id: empfang
                            source: "images/funk_qt.png"
                            bezeichner: "Helligkeit:<br>Wetter:"
                        }
                    }


                    Column {
                        anchors.bottom: parent.bottom

                        //Separator
                        Rectangle {
                            width: infoLeiste.breite - 30
                            height: 1
                            anchors.horizontalCenter: menuLog.horizontalCenter
                            color: "black"
                        }

                        Rectangle {
                            id: menuLog
                            width: infoLeiste.breite
                            height: 80
                            color: logMouse.pressed ? "grey" : "transparent"

                            Text {
                                text: "Logfile"
                                font { family: "Abel"; pointSize: 18}
                                anchors.centerIn: parent
                            }

                            MouseArea {
                                id: logMouse
                                anchors.fill: parent
                                onClicked: { mainPage.state = "nothingVisible"; stackView.push(Qt.resolvedUrl("content/Logfile.qml")) }
                            }
                        }

                        //Separator
                        Rectangle {
                            width: infoLeiste.breite - 30
                            height: 1
                            anchors.horizontalCenter: menuLog.horizontalCenter
                            color: "black"
                        }

                        Rectangle {
                            width: infoLeiste.breite
                            height: 80
                            color: verlaufMouse.pressed ? "grey" : "transparent"

                            Text {
                                text: "Verlauf"
                                font { family: "Abel"; pointSize: 18}
                                anchors.centerIn: parent
                            }

                            MouseArea {
                                id: verlaufMouse
                                anchors.fill: parent
                                onClicked: { mainPage.state = "nothingVisible"; }
                            }
                        }
                    }
                }
            }

            states: [
                State {
                    name: "infoVisible"
                    PropertyChanges { target: infoLeiste; x: 0 }
                    //AnchorChanges { target: infoLeiste; anchors.left: mainPage.left }
                    PropertyChanges { target: setupMenu; y: -500 }
                    PropertyChanges { target: overlay; opacity: 0.5; visible: true }
                    PropertyChanges { target: infoButton; x: -50 }
                },
                State {
                    name: "setupVisible"
                    PropertyChanges { target: setupMenu; y: -10 }
                    PropertyChanges { target: infoLeiste; x: -infoLeiste.width }
                    PropertyChanges { target: overlay; opacity: 0; visible: false }
                    PropertyChanges { target: infoButton; x: -30 }
                },
                State {
                    name: "nothingVisible"
                    PropertyChanges { target: setupMenu; y: -500 }
                    PropertyChanges { target: infoLeiste; x: -infoLeiste.width }
                    PropertyChanges { target: overlay; opacity: 0; visible: false }
                    PropertyChanges { target: infoButton; x: -30 }
                }

            ]
            transitions: Transition {
                //AnchorAnimation { duration: 200 }
            }
            Rectangle {
                id: overlay
                anchors.fill: parent
                color: "grey"
                opacity: 0
                visible: false

                Behavior on opacity { NumberAnimation {}}
                MouseArea {
                    id: overlayMouse
                    width: parent.width - infoLeiste.breite
                    height: parent.height
                    anchors.right: parent.right
                    onClicked: { overlay.visible ? mainPage.state = "nothingVisible" : {} }
                }

            }
            DropShadow {
                anchors.fill: source
                horizontalOffset: 4
                verticalOffset: 0
                radius: 14
                samples: 24
                spread: 0.3
                color: "#80000000"
                source: infoLeiste
            }
        }

        Rectangle {
            id: setupMenu
            width: 220
            height: 320
            anchors.right: parent.right
            anchors.rightMargin: 15
            color: "transparent"
            z: 99
            y: -500

            Rectangle {
                width: 200
                height: 300
                anchors.centerIn: parent
                color: "white"
                border.color: "grey"

                ListView {
                    anchors.fill: parent
                    model: setupModel
                    delegate: Rectangle {
                        width: 200
                        height: 60
                        color: index == setupMouse.pressed ? "lightgrey" : "transparent"
                        border.color: "grey"
                        Text {
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.left: parent.left
                            anchors.leftMargin: 20
                            font.family: "Abel"
                            font.pointSize: 14
                            text: title
                        }
                        MouseArea {
                            id: setupMouse
                            anchors.fill: parent
                            onClicked: { if (index > 0) {
                                    mainPage.state = "nothingVisible"
                                    if (stackView.currentItem.name !== name) {
                                        stackView.push(Qt.resolvedUrl(page))
                                        textStatuszeile.text = name;
                                    }
                                }
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
            source: setupMenu
        }

    }
    MessageDialog {
        id: messageDialog
        //        onAccepted: {
        //            console.log("And of course you could only agree.")
        //            //Qt.quit()
        //        }
        //Component.onCompleted: visible = true
    }
}

/*
TODO TODO TODO
==============
- Fehlerbehandlung bei Netzwerkfehlern, 200 muss bei OK zurückgegeben werden
- Gestensteuerung
- Unabhängigkeit von der Bildschirmauflösung, Schriftgröße mit font.pixelSize an Größe des Feldes angepasst, relative Größe bezogen aif Screen-Größe
- GridView in GridLayout verändern
- Hardware-Back-Key muss stackView.pop() auslösen
- Timer-gesteuerte Aktualisierung des Status auf Bewässerung und Jalousie-Seite
- vorab laden der Daten
*/

