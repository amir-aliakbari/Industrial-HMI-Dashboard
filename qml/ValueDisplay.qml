import QtQuick 2.0

Rectangle {
    id: root

    property string label: ""
    property string value: "0.00"
    property string unit: ""
    property color valueColor: "#00ff88"

    width: 280
    height: 80
    color: "#1f1f1f"
    radius: 12
    border.color: "#333333"
    border.width: 1

    Row {
        anchors.fill: parent
        anchors.margins: 16
        spacing: 12

        Rectangle {
            width: 4
            height: parent.height
            color: root.valueColor
            radius: 2
        }

        Column {
            anchors.verticalCenter: parent.verticalCenter
            spacing: 2

            Text {
                text: root.label
                color: "#9e9e9e"
                font.pixelSize: 14
                font.family: "Courier"
                font.bold: true
                opacity: 0.9
            }

            Text {
                text: root.value + " " + root.unit
                color: root.valueColor
                font.pixelSize: 32
                font.family: "Courier"
                font.bold: true
            }
        }
    }
}
