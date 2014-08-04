import QtQuick 2.2
import QtQuick.Controls 1.2
import QtQuick.Dialogs 1.2
import QtQml.Models 2.1
import QtGraphicalEffects 1.0
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
                onClicked: { if (setupMenu.y < 0) setupMenu.y = 0; else setupMenu.y = -320 }
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

    Rectangle {
        id: setupMenu

        Component.onCompleted: console.log(setupMenu.z)

        width: 200
        height: 300
        anchors.right: parent.right
        anchors.rightMargin: 10
        y: -320
        z: 2
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
                            setupMenu.y = -320;
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
    DropShadow {
        anchors.fill: setupMenu
        horizontalOffset: 5
        verticalOffset: 5
        z: 2
        radius: 12
        samples: 24
        spread: 1.0
        color: "#80000000"
        source: setupMenu
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

            Rectangle {
                id: infoLeiste
                height: parent.height
                width: 0.75 * parent.width
                anchors.top: parent.top
                color: "#eeeeee"
                x: -width - 5
                z: 2

                Column {
                    property int largeFont: 12
                    property int smallFont: 10

                    spacing: 4

                    anchors.top: parent.top
                    anchors.topMargin: 40
                    Text {
                        anchors { left: parent.left; leftMargin: 10 }
                        font { family: "Abel"; pointSize: parent.largeFont; bold: true}
                        text: "Temperatur:"
                    }
                    Text {
                        id: tempAussen
                        anchors { left: parent.left; leftMargin: 18 }
                        font { family: "Abel"; pointSize: parent.smallFont; bold: false}
                    }
                    Text {
                        id: tempInnen
                        anchors { left: parent.left; leftMargin: 18 }
                        font { family: "Abel"; pointSize: parent.smallFont; bold: false}
                    }
                    Text {
                        anchors { left: parent.left; leftMargin: 10 }
                        font { family: "Abel"; pointSize: parent.largeFont; bold: true}
                        text: "Jalousie:"
                    }
                    Text {
                        id: jal1
                        anchors { left: parent.left; leftMargin: 18 }
                        font { family: "Abel"; pointSize: parent.smallFont; bold: false}
                    }
                    Text {
                        id: jal2
                        anchors { left: parent.left; leftMargin: 18 }
                        font { family: "Abel"; pointSize: parent.smallFont; bold: false}
                    }
                    Text {
                        id: jal3
                        anchors { left: parent.left; leftMargin: 18 }
                        font { family: "Abel"; pointSize: parent.smallFont; bold: false}
                    }
                    Text {
                        id: jal4
                        anchors { left: parent.left; leftMargin: 18 }
                        font { family: "Abel"; pointSize: parent.smallFont; bold: false}
                    }
                    Text {
                        anchors { left: parent.left; leftMargin: 10 }
                        font { family: "Abel"; pointSize: parent.largeFont; bold: true}
                        text: "Schaltzustände:"
                    }
                    Text {
                        id: orient
                        anchors { left: parent.left; leftMargin: 18 }
                        font { family: "Abel"; pointSize: parent.smallFont; bold: false}
                    }
                    Text {
                        id: abluftHWR
                        anchors { left: parent.left; leftMargin: 18 }
                        font { family: "Abel"; pointSize: parent.smallFont; bold: false}
                    }
                    Text {
                        id: zentraleAbluft
                        anchors { left: parent.left; leftMargin: 18 }
                        font { family: "Abel"; pointSize: parent.smallFont; bold: false}
                    }

                    Text {
                        anchors { left: parent.left; leftMargin: 10 }
                        font { family: "Abel"; pointSize: parent.largeFont; bold: true}
                        text: "Sonnenzeiten:"
                    }
                    Text {
                        id: sa
                        anchors { left: parent.left; leftMargin: 18 }
                        font { family: "Abel"; pointSize: parent.smallFont; bold: false}
                    }
                    Text {
                        id: su
                        anchors { left: parent.left; leftMargin: 18 }
                        font { family: "Abel"; pointSize: parent.smallFont; bold: false}
                    }
                    Text {
                        anchors { left: parent.left; leftMargin: 10 }
                        font { family: "Abel"; pointSize: parent.largeFont; bold: true}
                        text: "Letzter Funkempfang:"
                    }
                    Text {
                        id: funkWetter
                        anchors { left: parent.left; leftMargin: 18 }
                        font { family: "Abel"; pointSize: parent.smallFont; bold: false}
                    }
                    Text {
                        id: funkHell
                        anchors { left: parent.left; leftMargin: 18 }
                        font { family: "Abel"; pointSize: parent.smallFont; bold: false}
                    }
                }
                Column {
                    anchors.bottom: parent.bottom

                    //Separator
                    Rectangle {
                        width: infoLeiste.width - 30
                        height: 1
                        anchors.horizontalCenter: menuSetup.horizontalCenter
                        color: "black"
                    }

                    Rectangle {
                        id: menuSetup
                        width: infoLeiste.width
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
                        width: infoLeiste.width - 30
                        height: 1
                        anchors.horizontalCenter: menuSetup.horizontalCenter
                        color: "black"
                    }

                    Rectangle {
                        width: infoLeiste.width
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
                anchors.fill: infoLeiste
                horizontalOffset: 5
                verticalOffset: 0
                radius: 12
                samples: 24
                spread: 1.0
                color: "#80000000"
                source: infoLeiste
            }
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
