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
                    Button {
                        text: "DNS"
                        onClicked: root.stack.push("dns.qml")
                    }
                    Button {
                        text: "DHCP"
                        onClicked: root.stack.push("dhcp.qml")
                    }
                    Button {
                        text: "NTP"
                        onClicked: root.stack.push("ntp.qml")
                    }
                    Button {
                        text: "Resolver"
                        onClicked: root.stack.push("resolver.qml")
                    }
                    Button {
                        text: "Database"
                        onClicked: root.stack.push("database.qml")
                    }
                    Button {
                        text: "Webserver"
                        onClicked: root.stack.push("webserver.qml")
                    }
                    Button {
                        text: "Files"
                        onClicked: root.stack.push("files.qml")
                    }
                    Button {
                        text: "Misc"
                        onClicked: root.stack.push("misc.qml")
                    }
                    Button {
                        text: "Debug"
                        onClicked: root.stack.push("debug.qml")
                    }
                }
            }
        }
    }
}
