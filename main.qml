import QtQuick 2.2
import QtQuick.Controls 1.2
import QtQuick.Dialogs 1.2
import QtQml.Models 2.1
import QtQml 2.2
import QtGraphicalEffects 1.0
import AppSettings 1.0
import QtQuick.Window 2.0
import "content"
import "javascript/hsClient.js" as Hsclient
import "javascript/global.js" as Global
import "javascript/storage.js" as Storage

ApplicationWindow {
    visible: true
    title: qsTr("Meth 9")

//    width: 800
//    height: 1280

    width: 1080
    height: 1920

    Component.onCompleted: {
        // Initialize the database
        Storage.initialize();

        Global.hostname = Storage.getSetting("hostname");
        Global.username = Storage.getSetting("username");
        Global.password = Storage.getSetting("password");

        Global.mainobj = mainPage;
        Global.errorButton = errorButton;

        Hsclient.checkNetworkSettings();

        Hsclient.getStatus()
    }

    AppSettings {
        id: settings
    }

    property int appstate: Qt.application.state

    onAppstateChanged: {
        if(Qt.application.state === Qt.ApplicationActive && stackView.depth > 1) {
            stackView.pop({item: null, immediate: true});
            textStatuszeile.text = stackView.currentItem.name;
        }
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
        height: 120

        Rectangle {
            id: infoButton
            width:  height
            height: header.height - 15
            radius: 4
            x: -30
            visible: stackView.depth == 1
            anchors.verticalCenter: parent.verticalCenter
            color: infoButtonMouse.pressed ? "grey" : "transparent"

            Behavior on x { NumberAnimation { easing.type: Easing.OutCubic } }

            Image {
                anchors.fill: parent
                source: "images/info_white.png"
            }
            MouseArea {
                id: infoButtonMouse
                anchors.fill: parent
                anchors.margins: -10
                onClicked: {
                    if (mainPage.state == "infoVisible") {
                        mainPage.state = "nothingVisible"
                    } else {
                        infoLeisteXBehaviour.enabled = true;
                        mainPage.state = "infoVisible";
                    }
                }
            }
        }

        Rectangle {
            id: homeButton
            width: height
            height: header.height - 15
            radius: 4
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: setupButton.left
            anchors.rightMargin: 40
            visible: opacity
            opacity: stackView.depth > 1 ? 1 : 0
            color: homeButtonMouse.pressed ? "grey" : "transparent"

            Behavior on opacity { NumberAnimation{} }

            Image {
                fillMode: Image.PreserveAspectFit
                anchors.fill: parent
                anchors.margins: 7
                anchors.centerIn: parent
                source: "images/navigation_home.png"
            }

            MouseArea {
                id: homeButtonMouse
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
            id: errorButton

            function showErrorButton(infoTitle, infoText) {
                messageDialog.informativeText = infoText;
                messageDialog.title = infoTitle;
                opacity = 1;
                errorButtonTimer.start()
            }

            Timer {
                id: errorButtonTimer
                interval: 10000
                repeat: false
                onTriggered: errorButton.opacity = 0
            }

            width: height
            height: header.height - 15
            radius: 4
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: homeButton.left
            anchors.rightMargin: 45
            visible: opacity
            opacity: 0
            color: errorButtonMouse.pressed ? "grey" : "transparent"

            Behavior on opacity { NumberAnimation{} }

            Image {
                fillMode: Image.PreserveAspectFit
                anchors.fill: parent
                anchors.margins: 15
                source: "images/hinweis_white.png"
            }

            MouseArea {
                id: errorButtonMouse
                anchors.fill: parent
                anchors.margins: -10
                onClicked: {
                    mainPage.state = "nothingVisible";
                    messageDialog.visible = true;
                }
            }
        }

        Rectangle {
            id: setupButton
            width: height
            height: header.height - 10
            radius: 4
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: 45

            color: setupButtonMouse.pressed ? "grey" : "transparent"

            Image {
                anchors.fill: parent
                source: "images/setup_white.png"
            }

            MouseArea {
                id: setupButtonMouse
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
            width: height
            height: header.height - 10
            radius: 4
            anchors.left: parent.left
            anchors.leftMargin: 60
            opacity: stackView.depth > 1 ? 1 : 0
            anchors.verticalCenter: parent.verticalCenter
            antialiasing: true

            color: backButtonMouse.pressed ? "grey" : "transparent"
            Behavior on opacity { NumberAnimation{} }
            Image {
                anchors.fill: parent
                anchors.margins: 5
                source: "images/navigation_previous_item.png"
            }
            MouseArea {
                id: backButtonMouse
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
            //font.pixelSize: 63
            font.pointSize: 18
            //Behavior on x { NumberAnimation{ easing.type: Easing.OutCubic} }
            x: backButton.x + 120
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
        Keys.onReleased: if (event.key === Qt.Key_Back) {
                             if (stackView.depth > 1) {
                                 stackView.pop();
                                 textStatuszeile.text = stackView.currentItem.name;
                             } else {
                                 mainPage.state = "nothingVisible";
                             }
                             event.accepted = true;
                         }

        initialItem: Item {
            id: mainPage
            width: parent.width
            height: parent.height
            z: -1

            onStateChanged: if(state == "infoVisible") Hsclient.getStatus()

            readonly property string name: "Meth 9"

            function isVisibleDialog() {
                return false
            }

            MouseArea {
                property bool gestActive: false
                anchors.fill: parent
                onPressed: {
                    if (mouseX < 80) {
                        gestActive = true;
                    }
                }
                onMouseXChanged: {
                    if (gestActive && mouseX < infoLeiste.breite) {
                        infoLeiste.x = mouseX - infoLeiste.breite;
                        infoButton.x = -30 - (mouseX / infoLeiste.breite * 20);
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
                    height: 420
                    width: height
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
                Item {
                    // Separator
                    width: parent.width
                    height: 50
                }

                GridView {
                    id: gridView
                    anchors.horizontalCenter: parent.horizontalCenter
                    model: pageModel
                    width: 840
                    height: width
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

                x: -width
                width: breite + 20
                height: parent.height
                anchors.top: parent.top

                Behavior on x {
                    id: infoLeisteXBehaviour
                    enabled: false
                    NumberAnimation { easing.type: Easing.OutCubic }
                }

                MouseArea {
                    property bool gestActive: false
                    property real oldX
                    anchors.fill: parent
                    onPressed: {
                        gestActive = true;
                        oldX = mouseX;
                        infoLeisteXBehaviour.enabled = true;
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
                        property int largeFont: 18
                        property int smallFont: 15

                        anchors.top: parent.top
                        anchors.topMargin: 10
                        Rectangle {
                            height: 150
                            width: infoLeiste.breite
                            color: "transparent"
                            Row {
                                anchors.horizontalCenter: parent.horizontalCenter
                                spacing: 20
                                Text {
                                    height: 150
                                    font.family: "Abel"
                                    font.pixelSize: 36
                                    font.bold: true
                                    verticalAlignment: Qt.AlignVCenter
                                    text: "aktuell:"
                                }

                                Image {
                                    width: 135
                                    height: 150
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
                            height: 165
                            source: "images/regentropfen_qt.png"
                            bezeichner: "Regen (1h):<br>Regen (24h):<br>Regen (7d):"
                        }
                        InfoElement {
                            id: jalousie
                            height: 210
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
                            height: 100
                            color: logMouse.pressed ? "grey" : "transparent"

                            Text {
                                text: "Logfile"
                                font { family: "Abel"; pointSize: 18}
                                anchors.centerIn: parent
                            }

                            MouseArea {
                                id: logMouse
                                anchors.fill: parent
                                onClicked: {
                                    mainPage.state = "nothingVisible";
                                    stackView.push(Qt.resolvedUrl("content/LogfilePage.qml"))
                                    textStatuszeile.text = stackView.currentItem.name;
                                }
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
                            height: 100
                            color: verlaufMouse.pressed ? "grey" : "transparent"

                            Text {
                                text: "Verlauf"
                                font { family: "Abel"; pointSize: 18}
                                anchors.centerIn: parent
                            }

                            MouseArea {
                                id: verlaufMouse
                                anchors.fill: parent
                                onClicked: {
                                    mainPage.state = "nothingVisible";
                                    stackView.push(Qt.resolvedUrl("content/VerlaufPage.qml"))
                                    textStatuszeile.text = stackView.currentItem.name;
                                }
                            }
                        }
                    }
                }
            }

            states: [
                State {
                    name: "infoVisible"
                    PropertyChanges { target: infoLeiste; x: 0 }
                    PropertyChanges { target: setupMenu; y: -700 }
                    PropertyChanges { target: overlay; opacity: 0.5; visible: true }
                    PropertyChanges { target: infoButton; x: -60 }
                },
                State {
                    name: "setupVisible"
                    PropertyChanges { target: setupMenu; y: -20 }
                    PropertyChanges { target: infoLeiste; x: -infoLeiste.width }
                    PropertyChanges { target: overlay; opacity: 0; visible: false }
                    PropertyChanges { target: infoButton; x: -30 }
                },
                State {
                    name: "nothingVisible"
                    PropertyChanges { target: setupMenu; y: -700 }
                    PropertyChanges { target: infoLeiste; x: -infoLeiste.width }
                    PropertyChanges { target: overlay; opacity: 0; visible: false }
                    PropertyChanges { target: infoButton; x: -30 }
                }

            ]

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
            width: 380
            height: 565
            anchors.right: parent.right
            anchors.rightMargin: 20
            color: "transparent"
            z: 99
            y: -700

            Rectangle {
                width: 340
                height: 525
                anchors.centerIn: parent
                color: "white"
                border.color: "grey"

                ListView {
                    anchors.fill: parent
                    model: setupModel
                    delegate: Rectangle {
                        width: 340
                        height: 105
                        color: index == setupMouse.pressed ? "lightgrey" : "transparent"
                        border.color: "grey"
                        Text {
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.left: parent.left
                            anchors.leftMargin: 25
                            font.family: "Abel"
                            font.pointSize: 16
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
    }
}

/*
TODO TODO TODO
==============
- auf Update prüfen
- Bug bei Eingabe mit virtueller Tastatur (nur bei Password)


nice to have
------------
- Timer-gesteuerte Aktualisierung des Status auf Bewässerung und Jalousie-Seite (nur wenn App nicht im Background/Suspend)
- vorab laden der Daten
- Unabhängigkeit von der Bildschirmauflösung, Schriftgröße mit font.pixelSize an Größe des Feldes angepasst, relative Größe bezogen auf Screen-Größe

*/

