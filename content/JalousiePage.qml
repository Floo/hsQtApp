import QtQuick 2.2
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.1
import "../content"

//ScrollView {
Item {
    id: rootJalPage
    width: parent.width
    height: parent.height
    Rectangle {
        id: singleHeadline
        height: 80
        width: parent.width
        color: "#E3905C"

        Text {
            anchors.centerIn: parent
            color: "#000000"
            font.family: "Abel"
            font.pointSize: 15
            text: "Einzeln:"
        }
    }
    ListView {
        id: listSingle
        anchors.fill: parent
        anchors.top: parent.top
        anchors.topMargin: 80
        model: SingleJalModel {}
        delegate: SingleJalDelegate {
            text: name
            subtext: "Undefiniert/Stop"
            onClicked: { rootJalPage.state = "buttonVisible" }
        }
    }
    Rectangle {
        id: groupHeadline
        anchors.top: parent.top
        anchors.topMargin: 432
        height: 80
        width: parent.width
        color: "#E3905C"
        Text {
            anchors.centerIn: parent
            color: "#000000"
            font.family: "Abel"
            font.pointSize: 15
            text: "Gruppe:"
        }
    }
    ListView {
        id: listGroup
        anchors.fill: parent
        anchors.top: parent.top
        anchors.topMargin: 512
        model: GroupJalModel {}
        delegate: SingleJalDelegate {
            onClicked: { rootJalPage.state = "buttonVisible" }
            text: name
        }
    }
    Rectangle {
        id: buttonListe
        height: parent.height
        anchors.top: parent.top
        width: 120
        color: "#eeeeee"
//        x: {
//            var x = parent.width
//            console.debug(x)
//            return x - width
//        }
        x : parent.width - 10
        Column {
            width: parent.width
            spacing: 2
            StartButton {
                width: parent.width; height: parent.width
                source: "../images/ImpAuf.png"
                onButtonClicked: { rootJalPage.state = "" }
            }
            StartButton {
                width: parent.width; height: parent.width
                source: "../images/Auf.png"
                onButtonClicked: { rootJalPage.state = "" }
            }
            StartButton {
                width: parent.width; height: parent.width
                source: "../images/Stop.png"
                onButtonClicked: { rootJalPage.state = "" }
            }
            StartButton {
                width: parent.width; height: parent.width
                source: "../images/Ab.png"
                onButtonClicked: { rootJalPage.state = "" }
            }
            StartButton {
                width: parent.width; height: parent.width
                source: "../images/ImpAb.png"
                onButtonClicked: { rootJalPage.state = "" }
            }
            Rectangle { height: 10; width: parent.width; color: buttonListe.color }
            StartButton {
                width: parent.width; height: parent.width
                source: "../images/Sonne.png"
                onButtonClicked: { rootJalPage.state = "" }
            }
        }

    }
    states: State {
        name: "buttonVisible"
        AnchorChanges { target: buttonListe; anchors.right: rootJalPage.right}
    }
    transitions: Transition {
        AnchorAnimation { duration: 200 }
    }
}


