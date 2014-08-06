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
            width: stackView.depth > 1 ? 0 : 80
            height: 80
            x: -30
            anchors.verticalCenter: parent.verticalCenter
            color: "transparent"

            Behavior on x { NumberAnimation {} }

            Image {
                width: parent.width; height: parent.height
                anchors.verticalCenter: parent.verticalCenter
                source: "images/info_white.png"
            }

            MouseArea {
                id: infomouse
                anchors.fill: parent
                anchors.margins: -10
                onClicked: {
                    //console.debug("infomouse")
                    if (mainPage.state == "infoVisible") {
                        overlay.visible = false
                        overlay.opacity = 0
                        mainPage.state = ""
                        infoButton.x = -30
                    } else {
                        overlay.visible = true
                        overlay.opacity = 0.5
                        mainPage.state = "infoVisible"
                        infoButton.x = -50
                        Hsclient.getStatus()
                    }
                }
            }
        }
        Rectangle {
            id: setupButton
            width: 80
            height: 80
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
                onClicked: { if (setupMenu.y < -100) setupMenu.y = -10; else setupMenu.y = -380; }
            }
        }

        Rectangle {
            id: backButton
            width: opacity ? 60 : 0
            anchors.left: parent.left
            anchors.leftMargin: 80
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
                }
            }
        }

        Text {
            id: textStatuszeile
            font.pixelSize: 42
            Behavior on x { NumberAnimation{ easing.type: Easing.OutCubic} }
            x: backButton.x + backButton.width + 20
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
        ListElement {
            title: "Logfile"
            page: "content/Logfile.qml"
            name: "Logfile"
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

            Column {
                id: meth9

                anchors.horizontalCenter: parent.horizontalCenter

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
                        onButtonClicked: {
                            if (overlay.visible == false) {
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

                        InfoElement {
                            id: temperatur
                            source: "images/Sonne.png"
                        }
                        InfoElement {
                            id: regen
                            height: 110
                            source: "images/regentropfen_qt.png"
                        }
                        InfoElement {
                            id: jalousie
                            height: 140
                            source: "images/jalousie_qt.png"
                        }
                        InfoElement {
                            id: lueftung
                            source: "images/lueftung_qt.png"
                        }
                        InfoElement {
                            id: sasu
                            source: "images/sasu_qt.png"
                        }
                        InfoElement {
                            id: empfang
                            source: "images/funk_qt.png"
                        }
                    }


                    Column {
                        anchors.bottom: parent.bottom

                        //Separator
                        Rectangle {
                            width: infoLeiste.breite - 30
                            height: 1
                            anchors.horizontalCenter: menuSetup.horizontalCenter
                            color: "black"
                        }

                        Rectangle {
                            id: menuSetup
                            width: infoLeiste.breite
                            height: 80
                            color: "transparent"

                            Text {
                                text: "Setup"
                                font { family: "Abel"; pointSize: 18}
                                anchors.centerIn: parent
                            }

                            MouseArea {
                                anchors.fill: parent
                                onClicked: { }
                            }
                        }

                        //Separator
                        Rectangle {
                            width: infoLeiste.breite - 30
                            height: 1
                            anchors.horizontalCenter: menuSetup.horizontalCenter
                            color: "black"
                        }

                        Rectangle {
                            width: infoLeiste.breite
                            height: 80
                            color: "transparent"

                            Text {
                                text: "Verlauf"
                                font { family: "Abel"; pointSize: 18}
                                anchors.centerIn: parent
                            }

                            MouseArea {
                                anchors.fill: parent
                                onClicked: {  }
                            }
                        }
                    }
                }
            }

            states: State {
                name: "infoVisible"
                AnchorChanges { target: infoLeiste; anchors.left: mainPage.left}
            }
            transitions: Transition {
                AnchorAnimation { duration: 200 }
            }
            Rectangle {
                id: overlay
                anchors.fill: parent
                color: "grey"
                opacity: 0
                visible: false

                Behavior on opacity { NumberAnimation {}}

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
            height: 380
            anchors.right: parent.right
            anchors.rightMargin: 15
            color: "transparent"
            z: 99
            y: -height

            Rectangle {
                width: 200
                height: 360
                anchors.centerIn: parent
                color: "white"
                border.color: "grey"

                ListView {
                    anchors.fill: parent
                    model: setupModel
                    delegate: Rectangle {
                        width: 200
                        height: 60
                        color: index == 0 ? "lightgrey" : "transparent"
                        border.color: "grey"
                        Text {
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.left: parent.left
                            anchors.leftMargin: 20
                            font.family: "Abel"
                            font.pointSize: 18
                            text: title
                        }
                        MouseArea {
                            anchors.fill: parent
                            onClicked: { if (index > 0) {
                                    setupMenu.y = -380;
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
