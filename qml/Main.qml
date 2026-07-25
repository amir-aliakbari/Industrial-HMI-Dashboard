import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0
import Calculator 1.0

ApplicationWindow {
    id: root
    width: 340
    height: 520
    visible: true
    title: "Calculator"
    color: "#1e1e1e"

    Calculator {
        id: calc
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 12
        spacing: 8

        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 140
            color: "#262626"
            radius: 12

            Column {
                anchors.fill: parent
                anchors.margins: 16
                spacing: 4

                Text {
                    id: exprText
                    width: parent.width
                    text: calc.expression
                    color: "#9e9e9e"
                    font.pixelSize: 18
                    horizontalAlignment: Text.AlignRight
                    elide: Text.ElideLeft
                }

                Text {
                    id: dispText
                    width: parent.width
                    text: calc.display
                    color: "#ffffff"
                    font.pixelSize: 48
                    font.weight: Font.Light
                    horizontalAlignment: Text.AlignRight
                    elide: Text.ElideLeft
                }
            }
        }

        RowLayout {
            Layout.fillWidth: true
            spacing: 8

            Repeater {
                model: [
                    { label: "C",  type: "fn",  action: "clear" },
                    { label: "±",  type: "fn",  action: "sign" },
                    { label: "%",  type: "fn",  action: "percent" },
                    { label: "√",  type: "fn",  action: "sqrt" },
                    { label: "⌫", type: "fn",  action: "backspace" }
                ]

                Button {
                    text: modelData.label
                    Layout.fillWidth: true
                    Layout.preferredHeight: 50
                    font.pixelSize: 22

                    property color baseColor: modelData.type === "fn" ? "#a5a5a5" : "#ff9f0a"
                    property color textColor: modelData.type === "fn" ? "#000000" : "#ffffff"

                    background: Rectangle {
                        radius: 25
                        color: parent.pressed ? Qt.lighter(parent.baseColor, 1.3) : parent.baseColor
                    }

                    contentItem: Text {
                        text: parent.text
                        color: parent.textColor
                        font.pixelSize: parent.font.pixelSize
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }

                    onClicked: {
                        switch (modelData.action) {
                        case "clear": calc.clearPressed(); break;
                        case "sign": calc.signPressed(); break;
                        case "percent": calc.percentPressed(); break;
                        case "sqrt": calc.squareRootPressed(); break;
                        case "backspace": calc.backspacePressed(); break;
                        }
                    }
                }
            }

            Item {
                Layout.preferredWidth: 0
                Layout.fillHeight: true
            }
        }

        RowLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true
            spacing: 8

            GridLayout {
                Layout.fillWidth: true
                Layout.fillHeight: true
                columns: 4
                rowSpacing: 8
                columnSpacing: 8

                Repeater {
                    model: [
                        { label: "7",  type: "num", action: "7" },
                        { label: "8",  type: "num", action: "8" },
                        { label: "9",  type: "num", action: "9" },
                        { label: "4",  type: "num", action: "4" },
                        { label: "5",  type: "num", action: "5" },
                        { label: "6",  type: "num", action: "6" },
                        { label: "1",  type: "num", action: "1" },
                        { label: "2",  type: "num", action: "2" },
                        { label: "3",  type: "num", action: "3" },
                        { label: "0",  type: "num", action: "0", wide: true },
                        { label: ".",  type: "num", action: "." },
                        { label: "=",  type: "eq",  action: "equals" }
                    ]

                    Button {
                        text: modelData.label
                        Layout.fillWidth: true
                        Layout.preferredHeight: 60
                        font.pixelSize: 26

                        property color baseColor: modelData.type === "eq" ? "#ff9f0a"
                                            : modelData.type === "num" ? "#333333" : "#ff9f0a"
                        property color textColor: "#ffffff"

                        background: Rectangle {
                            radius: 30
                            color: parent.pressed ? Qt.lighter(parent.baseColor, 1.3) : parent.baseColor
                        }

                        contentItem: Text {
                            text: parent.text
                            color: parent.textColor
                            font.pixelSize: parent.font.pixelSize
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }

                        Layout.columnSpan: modelData.wide ? 2 : 1

                        onClicked: {
                            switch (modelData.action) {
                            case "equals": calc.equalsPressed(); break;
                            case ".": calc.decimalPressed(); break;
                            default: calc.digitPressed(modelData.action); break;
                            }
                        }
                    }
                }
            }

            ColumnLayout {
                spacing: 8
                Layout.preferredWidth: 60
                Layout.fillHeight: true

                Repeater {
                    model: [
                        { label: "÷", type: "op", action: "/" },
                        { label: "×", type: "op", action: "*" },
                        { label: "−", type: "op", action: "-" },
                        { label: "+", type: "op", action: "+" }
                    ]

                    Button {
                        text: modelData.label
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        font.pixelSize: 26

                        property color baseColor: "#ff9f0a"
                        property color textColor: "#ffffff"

                        background: Rectangle {
                            radius: 30
                            color: parent.pressed ? Qt.lighter(parent.baseColor, 1.3) : parent.baseColor
                        }

                        contentItem: Text {
                            text: parent.text
                            color: parent.textColor
                            font.pixelSize: parent.font.pixelSize
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }

                        onClicked: {
                            calc.operatorPressed(modelData.action)
                        }
                    }
                }
            }
        }
    }
}
