import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0
import HmiDashboard 1.0

ApplicationWindow {
    id: root
    width: 480
    height: 640
    visible: true
    title: "Industrial HMI Dashboard"
    color: "#1a1a1a"

    HmiDashboard {
        id: hmi
        onSettingsRequested: settingsPopup.visible = true
    }

    Rectangle {
        id: settingsPopup
        anchors.fill: parent
        color: "#000000"
        opacity: 0.7
        visible: false
        z: 100

        MouseArea {
            anchors.fill: parent
            onClicked: settingsPopup.visible = false
        }

        Rectangle {
            width: 300
            height: 200
            anchors.centerIn: parent
            color: "#2a2a2a"
            radius: 16
            border.color: "#00d4ff"
            border.width: 2

            Column {
                anchors.centerIn: parent
                spacing: 16

                Text {
                    text: "SETTINGS"
                    color: "#00d4ff"
                    font.pixelSize: 18
                    font.bold: true
                    font.family: "Courier"
                }

                Text {
                    text: "Settings menu placeholder"
                    color: "#ffffff"
                    font.pixelSize: 14
                }

                HmiButton {
                    text: "CLOSE"
                    color: "#00d4ff"
                    onClicked: settingsPopup.visible = false
                }
            }
        }
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 24
        spacing: 16

        Text {
            text: "INDUSTRIAL HMI DASHBOARD"
            color: "#00d4ff"
            font.pixelSize: 20
            font.bold: true
            font.family: "Courier"
            Layout.alignment: Qt.AlignHCenter
            Layout.fillWidth: true
        }

        Rectangle {
            Layout.fillWidth: true
            Layout.fillHeight: true
            color: "#2a2a2a"
            radius: 16
            border.color: "#00d4ff"
            border.width: 2

            Column {
                anchors.centerIn: parent
                spacing: 24

                ValueDisplay {
                    label: "CURRENT"
                    value: hmi.current.toFixed(2)
                    unit: "A"
                    valueColor: "#00ff88"
                }

                ValueDisplay {
                    label: "VOLTAGE"
                    value: hmi.voltage.toFixed(2)
                    unit: "V"
                    valueColor: "#ffaa00"
                }

                ValueDisplay {
                    label: "TEMPERATURE"
                    value: hmi.temperature.toFixed(2)
                    unit: "°C"
                    valueColor: "#ff4444"
                }
            }
        }

        RowLayout {
            Layout.fillWidth: true
            Layout.preferredHeight: 56
            spacing: 16

            HmiButton {
                id: startBtn
                Layout.fillWidth: true
                text: "START"
                color: "#00aa44"
                enabled: !hmi.running
                onClicked: hmi.start()
            }

            HmiButton {
                id: stopBtn
                Layout.fillWidth: true
                text: "STOP"
                color: "#aa2200"
                enabled: hmi.running
                onClicked: hmi.stop()
            }

            HmiButton {
                id: resetBtn
                Layout.fillWidth: true
                text: "RESET"
                color: "#666666"
                onClicked: hmi.reset()
            }

            HmiButton {
                id: settingsBtn
                Layout.fillWidth: true
                text: "SETTINGS"
                color: "#3366cc"
                onClicked: hmi.settings()
            }
        }
    }
}
