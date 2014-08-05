import QtQuick 2.2
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.2
import QtGraphicalEffects 1.0
import "../javascript/hsClient.js" as Hsclient

Rectangle {
    id: rootLogfilePage
    width: parent.width
    height: parent.height
    z: -1

    property bool init: true
    readonly property string name: "Logfile"

    Component.onCompleted: Hsclient.getLogfile()

    Flickable {
        anchors.fill: parent
        contentWidth: logtext.width
        contentHeight: logtext.height
        flickableDirection: Flickable.VerticalFlick
        clip: true

        Text {
            id: logtext
            anchors.left: parent.left
            anchors.leftMargin: 20
            font.pointSize: 10
        }
    }

}
