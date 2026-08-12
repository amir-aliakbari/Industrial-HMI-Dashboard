import QtQuick 2.0
import QtQuick.Controls 2.0

Button {
    id: root

    property color color: "#3366cc"

    implicitWidth: 100
    implicitHeight: 56
    font.pixelSize: 18
    font.family: "Courier"
    font.bold: true

    background: Rectangle {
        radius: 10
        color: root.enabled ? (parent.pressed ? Qt.lighter(root.color, 1.3) : root.color) : "#444444"
        border.color: "#000000"
        border.width: 1
    }

    contentItem: Text {
        text: root.text
        color: root.enabled ? "#ffffff" : "#888888"
        font.pixelSize: root.font.pixelSize
        font.family: root.font.family
        font.bold: root.font.bold
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }
}
