import QtQuick 2.2
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.2
import QtGraphicalEffects 1.0
import "../javascript/hsClient.js" as Hsclient
import "../javascript/global.js" as Global


Rectangle {
    id: rootLichtPage
    width: parent.width
    height: parent.height
    z: -1

    property int selectedIndex: -1
    readonly property string name: "Licht"

    function isVisibleDialog() {
        return false
    }

    MouseArea {
        anchors.fill: parent
        onClicked: Global.mainobj.state = "nothingVisible";
    }

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
    Item {
        id: buttonListe
        height: parent.height
        width: 190
        x: parent.width
        Rectangle {
            height: parent.height
            anchors.right: parent.right
            width: 160
            color: "#eeeeee"
            Column {
                width: parent.width
                anchors.verticalCenter: parent.verticalCenter
                spacing: 2
                StartButton {
                    color: pressed ? "#E3905C" : Qt.lighter("#E3905C", 1.2)
                    border.color: Qt.lighter("#E3905C", 1.5)
                    border.width: 2
                    width: parent.width; height: parent.width
                    source: "../images/Auf.png"
                    text: "Heller"
                    textcolor: "black"
                    onButtonPressed: {
                        Hsclient.setDimm(lichtModel.get(selectedIndex).id, Global.DIMM_UP_START);
                    }
                    onButtonReleased: {
                        Hsclient.setDimm(lichtModel.get(selectedIndex).id, Global.DIMM_UP_STOP);
                    }
                }
                StartButton {
                    color: pressed ? "#E3905C" : Qt.lighter("#E3905C", 1.2)
                    border.color: Qt.lighter("#E3905C", 1.5)
                    border.width: 2
                    width: parent.width; height: parent.width
                    source: "../images/Licht_An.png"
                    text: "Ein"
                    textcolor: "black"
                    onButtonClicked: {
                        Hsclient.setLicht(lichtModel.get(selectedIndex).id, Global.FS20_AN);
                    }
                }

                Rectangle { height: 10; width: parent.width; color: "transparent" }

                StartButton {
                    color: pressed ? "#E3905C" : Qt.lighter("#E3905C", 1.2)
                    border.color: Qt.lighter("#E3905C", 1.5)
                    border.width: 2
                    width: parent.width; height: parent.width
                    source: "../images/Licht_Aus.png"
                    text: "Aus"
                    textcolor: "black"
                    onButtonClicked: {
                        Hsclient.setLicht(lichtModel.get(selectedIndex).id, Global.FS20_AUS)
                    }
                }
                StartButton {
                    color: pressed ? "#E3905C" : Qt.lighter("#E3905C", 1.2)
                    border.color: Qt.lighter("#E3905C", 1.5)
                    border.width: 2
                    width: parent.width; height: parent.width
                    source: "../images/Ab.png"
                    text: "Dunkler"
                    textcolor: "black"
                    onButtonPressed: {
                        Hsclient.setDimm(lichtModel.get(selectedIndex).id, Global.DIMM_DOWN_START);
                    }
                    onButtonReleased: {
                        Hsclient.setDimm(lichtModel.get(selectedIndex).id, Global.DIMM_DOWN_STOP);
                    }
                }
            }
        }
    }

    DropShadow {
        id: shadowButtonleiste
        anchors.fill: source
        horizontalOffset: -4
        verticalOffset: 0
        radius: 14
        samples: 24
        spread: 0.3
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
