import QtQuick 2.2
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.2
import QtGraphicalEffects 1.0
import "../javascript/hsClient.js" as Hsclient


Rectangle {
    id: rootLichtPage
    width: parent.width
    height: parent.height

    property int selectedIndex: -1

    Component.onCompleted: { Hsclient.getLicht() }

    ListModel {
        id: lichtModel
    }

    ListView {
        id: lichtListView
        anchors.fill: parent

        model: lichtModel
        delegate: ListViewDelegate {
            bezeichner: name
            selected: checked
            onClicked: {
                for (var i = 0; i < lichtListView.model.count; i++) lichtListView.model.setProperty(i, "checked", false);
                lichtListView.model.setProperty(index, "checked", true);
                rootLichtPage.state = "buttonVisible";
                selectedIndex = index;
            }
        }
    }
    Rectangle {
        id: buttonListe
        height: parent.height
        anchors.top: parent.top
        width: 120
        color: "#eeeeee"
        x : parent.width
        Column {
            width: parent.width
            anchors.verticalCenter: parent.verticalCenter
            spacing: 2
            StartButton {
                color: Qt.lighter("#E3905C", 1.2)
                border.color: Qt.lighter("#E3905C", 1.5)
                border.width: 2
                width: parent.width; height: parent.width
                source: "../images/Auf.png"
                text: "Heller"
                onButtonClicked: {
                    rootLichtPage.state = "";
                    Hsclient.setLicht(lichtModel.get(selectedIndex).id, Hsclient.FS20_DIMM_UP)
                }
            }
            StartButton {
                color: Qt.lighter("#E3905C", 1.2)
                border.color: Qt.lighter("#E3905C", 1.5)
                border.width: 2
                width: parent.width; height: parent.width
                source: "../images/Licht_An.png"
                text: "Einschalten"
                onButtonClicked: {
                    rootLichtPage.state = "";
                    Hsclient.setLicht(lichtModel.get(selectedIndex).id, Hsclient.FS20_AN);
                }
            }

            Rectangle { height: 10; width: parent.width; color: buttonListe.color }

            StartButton {
                color: Qt.lighter("#E3905C", 1.2)
                border.color: Qt.lighter("#E3905C", 1.5)
                border.width: 2
                width: parent.width; height: parent.width
                source: "../images/Licht_Aus.png"
                text: "Ausschalten"
                onButtonClicked: {
                    rootLichtPage.state = "";
                    Hsclient.setLicht(lichtModel.get(selectedIndex).id, Hsclient.FS20_AUS)
                }
            }
            StartButton {
                color: Qt.lighter("#E3905C", 1.2)
                border.color: Qt.lighter("#E3905C", 1.5)
                border.width: 2
                width: parent.width; height: parent.width
                source: "../images/Ab.png"
                text: "Dunkler"
                onButtonClicked: {
                    rootLichtPage.state = "";
                    Hsclient.setLicht(lichtModel.get(selectedIndex).id, Hsclient.FS20_DIMM_DOWN)
                }
            }
        }
    }

    DropShadow {
        id: shadowButtonleiste
        anchors.fill: buttonListe
        horizontalOffset: -5
        verticalOffset: 0
        radius: 12
        samples: 24
        spread: 1.0
        color: "#80000000"
        visible: false
        source: buttonListe
    }

    states: State {
        name: "buttonVisible"
        AnchorChanges { target: buttonListe; anchors.right: rootLichtPage.right}
        PropertyChanges { target: shadowButtonleiste; visible: true}
    }

    transitions: Transition {
        AnchorAnimation { duration: 200 }
    }

}
