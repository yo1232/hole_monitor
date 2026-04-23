import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Item {
    // TODO: Get settings from pi-hole api
    Page {
        anchors.fill: parent
        id: page4
        title: "Settings"
        header: ToolBar {
            ColumnLayout{
                RowLayout{
                    Layout.fillWidth: true
                    Button {
                        text: "<"
                        onClicked: root.stack.pop()
                    }
                    Button {
                        text: "login"
                        onClicked: root.stack.push("Login.qml")
                    }
                }
            }
        }
    }
}
