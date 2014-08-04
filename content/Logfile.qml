import QtQuick 2.2
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.2
import QtGraphicalEffects 1.0
import "../javascript/hsClient.js" as Hsclient

Rectangle {
    id: rootLogfilePage
    width: parent.width
    height: parent.height

    property bool init: true
    readonly property string name: "Logfile"

    Component.onCompleted: Hsclient.getLogfile()

    Text {
        id: logtext
        anchors.fill: parent
    }

}
