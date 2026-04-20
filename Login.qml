import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtNetwork

Item {
    Page {
        id: login_page
        title: "login"
        header: ToolBar {
            ColumnLayout {
                RowLayout {
                    Layout.fillWidth: true
                    Button {
                        text: "<"
                        onClicked: root.stack.pop()
                    }
                }
            }
        }
        ColumnLayout {
            RowLayout {
                TextField {
                    id: host
                    placeholderText: qsTr("pi-hole ip address or hostname")
                }
                Button {
                    text: "save host"
                    onClicked: piholeApi.baseUrl = host.text
                }

                TextField {
                    id: passwd
                    placeholderText: qsTr("pi-hole password")
                }
                Button {
                    text: "login"
                    onClicked: piholeApi.login(passwd.text)
                }
            }
        }
    }
}
