import QtQuick 2.2
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.1
import QtGraphicalEffects 1.0
import "../content"
import "../javascript/hsClient.js" as Hsclient
import "../javascript/global.js" as Global

//ScrollView {
Item {
    id: rootJalPage
    width: parent.width
    height: parent.height

    z: -1;

    Component.onCompleted: { Hsclient.getStatusJal() }

    property int listViewDelegateHeight: 100
    property var jalNr
    readonly property string name: "Jalousie"

    function isVisibleDialog() {
        return false
    }

    MouseArea {
        anchors.fill: parent
        onClicked: Global.mainobj.state = "nothingVisible";
    }

    Rectangle {
        id: singleHeadline
        height: 80
        width: parent.width
        color: "#E3905C"

        Text {
            anchors.centerIn: parent
            color: "#000000"
            font.family: "Abel"
            font.pointSize: 16
            font.bold: true
            text: "Einzeln:"
        }
    }

    ListModel {
        id: singleJalModel
        ListElement {
            name: "Süd links"
            position: ""
            checked: false
            jalNr: "0"
        }
        ListElement {
            name: "Süd Tür"
            position: ""
            checked: false
            jalNr: "1"
        }
        ListElement {
            name: "Süd rechts"
            position: ""
            checked: false
            jalNr: "2"
        }
        ListElement {
            name: "West"
            position: ""
            checked: false
            jalNr: "3"
        }
    }

    ListModel {
        id: groupJalModel
        ListElement {
            name: "alle"
            checked: false
            jalNr: "0123"
        }
        ListElement {
            name: "alle (Tür offen)"
            checked: false
            jalNr: "023"
        }
        ListElement {
            name: "Süd"
            checked: false
            jalNr: "012"
        }
        ListElement {
            name: "Süd (Tür offen)"
            checked: false
            jalNr: "02"
        }
    }


    ListView {
        id: listSingle
        anchors.fill: parent
        anchors.top: parent.top
        anchors.topMargin: 80
        model: singleJalModel
        delegate: ListViewDelegate {
            bezeichner: name
            subtext: position
            height: listViewDelegateHeight
            selected: checked
            onClicked: {
                rootJalPage.state = "buttonVisible";
                for ( var i = 0; i < listSingle.model.count; i++ ) listSingle.model.setProperty( i, "checked", false );
                for ( i = 0; i < listGroup.model.count; i++ ) listGroup.model.setProperty( i, "checked", false );
                listSingle.model.setProperty(index, "checked", true);
                rootJalPage.jalNr = singleJalModel.get(index).jalNr;
            }
        }
    }
    Rectangle {
        id: groupHeadline
        anchors.top: parent.top
        anchors.topMargin: listViewDelegateHeight * singleJalModel.count + singleHeadline.height
        height: singleHeadline.height
        width: parent.width
        color: "#E3905C"
        Text {
            anchors.centerIn: parent
            color: "#000000"
            font.family: "Abel"
            font.pointSize: 16
            font.bold: true
            text: "Gruppe:"
        }
    }
    ListView {
        id: listGroup
        anchors.fill: parent
        anchors.top: parent.top
        anchors.topMargin: listViewDelegateHeight * singleJalModel.count + singleHeadline.height + groupHeadline.height
        model: groupJalModel
        delegate: ListViewDelegate {
            bezeichner: name
            selected: checked
            height: listViewDelegateHeight
            onClicked: {
                rootJalPage.state = "buttonVisible";
                for ( var i = 0; i < listSingle.model.count; i++ ) listSingle.model.setProperty( i, "checked", false );
                for ( i = 0; i < listGroup.model.count; i++) listGroup.model.setProperty(i, "checked", false);
                listGroup.model.setProperty(index, "checked", true);
                rootJalPage.jalNr = groupJalModel.get(index).jalNr;
            }
        }
    }
    Item {
        id: buttonListe
        height: parent.height
        width: 140
        x: parent.width
        Rectangle {
            height: parent.height
            anchors.top: parent.top
            anchors.right: parent.right
            width: 120
            color: "#eeeeee"
            Column {
                width: parent.width
                anchors.verticalCenter: parent.verticalCenter
                spacing: 2
                StartButton {
                    color: Qt.lighter("#E3905C", 1.2)
                    border.color: Qt.lighter("#E3905C", 1.5)
                    border.width: 2
                    width: parent.width; height: parent.width
                    source: "../images/ImpAuf.png"
                    onButtonClicked: {
                        rootJalPage.state = "";
                        Hsclient.drvJalousie(jalNr, "IMPAUF");
                    }
                }
                StartButton {
                    color: Qt.lighter("#E3905C", 1.2)
                    border.color: Qt.lighter("#E3905C", 1.5)
                    border.width: 2
                    width: parent.width; height: parent.width
                    source: "../images/Auf.png"
                    onButtonClicked: {
                        rootJalPage.state = "";
                        Hsclient.drvJalousie(jalNr, "AUF");
                    }
                }
                StartButton {
                    color: Qt.lighter("#E3905C", 1.2)
                    border.color: Qt.lighter("#E3905C", 1.5)
                    border.width: 2
                    width: parent.width; height: parent.width
                    source: "../images/Stop.png"
                    onButtonClicked: {
                        rootJalPage.state = "";
                        Hsclient.drvJalousie(jalNr, "STP");
                    }
                }
                StartButton {
                    color: Qt.lighter("#E3905C", 1.2)
                    border.color: Qt.lighter("#E3905C", 1.5)
                    border.width: 2
                    width: parent.width; height: parent.width
                    source: "../images/Ab.png"
                    onButtonClicked: {
                        rootJalPage.state = "";
                        Hsclient.drvJalousie(jalNr, "AB");
                    }
                }
                StartButton {
                    color: Qt.lighter("#E3905C", 1.2)
                    border.color: Qt.lighter("#E3905C", 1.5)
                    border.width: 2
                    width: parent.width; height: parent.width
                    source: "../images/ImpAb.png"
                    onButtonClicked: {
                        rootJalPage.state = "";
                        Hsclient.drvJalousie(jalNr, "IMPAB");
                    }
                }

                Rectangle { height: 10; width: parent.width; color: "transparent" }

                StartButton {
                    color: Qt.lighter("#E3905C", 1.2)
                    border.color: Qt.lighter("#E3905C", 1.5)
                    border.width: 2
                    width: parent.width; height: parent.width
                    source: "../images/Luecke.png"
                    onButtonClicked: {
                        rootJalPage.state = "";
                        Hsclient.drvJalousie(jalNr, "SUN");
                    }
                }
            }
        }
    }
    DropShadow {
        id: shadowButtonLeiste
        anchors.fill: source
        horizontalOffset: -4
        verticalOffset: 0
        radius: 14
        samples: 24
        spread: 0.3
        visible: false
        color: "#80000000"
        source: buttonListe
    }

    states: State {
        name: "buttonVisible"
        AnchorChanges { target: buttonListe; anchors.right: rootJalPage.right }
        PropertyChanges { target: shadowButtonLeiste; visible: true }
    }
    transitions: Transition {
        AnchorAnimation { duration: 200 }
    }
}


