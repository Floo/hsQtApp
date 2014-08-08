import QtQuick 2.2
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.2
import "../javascript/hsClient.js" as Hsclient
import "../javascript/global.js" as Global


Rectangle {
    width: parent.width
    height: parent.height
    z: -1

    readonly property string name: "Lichtszenen"
    function isVisibleDialog() {
        return false
    }

    MouseArea {
        anchors.fill: parent
        onClicked: Global.mainobj.state = "";
    }

    Component.onCompleted: { Hsclient.getSzene() }

    ListModel {
        id: szeneModel
    }

    ListView {
        anchors.fill: parent

        model: szeneModel
        delegate: ListViewDelegate {
            bezeichner: name
            hasIcon: false
            onClicked: { Hsclient.setSzene(szeneModel.get(index).name) }
        }
    }

}

