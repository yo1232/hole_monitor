import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtNetwork

Item {
    Page {
        id: login_page
        title: "login"
        anchors.fill: parent
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
        property string loggedin: ""
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
            RowLayout {
                Connections {
                    target: piholeApi
                    function onSidChanged() {
                        if (piholeApi.baseUrl !== "") {
                            login_page.loggedin = piholeApi.baseUrl
                        }
                        else {
                            login_page.loggedin = "You are not logged in!"
                        }
                    }
                    Component.onCompleted: {
                        if (piholeApi.baseUrl !== "") {
                            login_page.loggedin = piholeApi.baseUrl
                        }
                        else {
                            login_page.loggedin = "You are not logged in!"
                        }
                    }
                }
                Text {text: "Current host: " + login_page.loggedin; color: "white"}


            }
            RowLayout {
                Button {
                    text: "logout"
                    onClicked: piholeApi.logout()
                }
            }
        }
    }
}
