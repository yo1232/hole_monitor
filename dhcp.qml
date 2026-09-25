import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtNetwork

Item {
    Page {
        id: dhcp_page
        title: "DHCP"
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
        Component.onCompleted: {
            if (piholeApi && piholeApi.sid !== "") {
                piholeApi.fetchDHCPConfig()
            }
        }
        property var config: null

        Connections {
            target: piholeApi
            function onFetchDHCPConfigReady(data) {
                dhcp_page.config= null
                dhcp_page.config = data
            }
            function onSidChanged() {
                piholeApi.fetchDHCPConfig()
            }
        }
        ScrollView {
            anchors.fill: parent
            clip: true
            RowLayout {
                width: parent.width
                height: parent.height
                spacing: 15
                ColumnLayout {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    spacing: 10
                    Text {
                        color: "white"
                        text: "active: " + (dhcp_page.config && dhcp_page.config.config && dhcp_page.config.config.dhcp ? dhcp_page.config.config.dhcp.active : "Please log in")
                    }
                    Text {
                        color: "white"
                        text: "start: " + (dhcp_page.config && dhcp_page.config.config && dhcp_page.config.config.dhcp ? dhcp_page.config.config.dhcp.start : "Please log in")
                    }
                    Text {
                        color: "white"
                        text: "end: " + (dhcp_page.config && dhcp_page.config.config && dhcp_page.config.config.dhcp ? dhcp_page.config.config.dhcp.end : "Please log in")
                    }
                    Text {
                        color: "white"
                        text: "router: " + (dhcp_page.config && dhcp_page.config.config && dhcp_page.config.config.dhcp ? dhcp_page.config.config.dhcp.router : "Please log in")
                    }
                    Text {
                        color: "white"
                        text: "netmask: " + (dhcp_page.config && dhcp_page.config.config && dhcp_page.config.config.dhcp ? dhcp_page.config.config.dhcp.netmask : "Please log in")
                    }
                    Text {
                        color: "white"
                        text: "lease time: " + (dhcp_page.config && dhcp_page.config.config && dhcp_page.config.config.dhcp ? dhcp_page.config.config.dhcp.leaseTime : "Please log in")
                    }
                    Text {
                        color: "white"
                        text: "IPv6: " + (dhcp_page.config && dhcp_page.config.config && dhcp_page.config.config.dhcp ? dhcp_page.config.config.dhcp.ipv6 : "Please log in")
                    }
                    Text {
                        color: "white"
                        text: "rapidCommit: " + (dhcp_page.config && dhcp_page.config.config && dhcp_page.config.config.dhcp ? dhcp_page.config.config.dhcp.rapidCommit : "Please log in")
                    }
                    Text {
                        color: "white"
                        text: "multiDNS: " + (dhcp_page.config && dhcp_page.config.config && dhcp_page.config.config.dhcp ? dhcp_page.config.config.dhcp.multiDNS : "Please log in")
                    }
                    Text {
                        color: "white"
                        text: "logging: " + (dhcp_page.config && dhcp_page.config.config && dhcp_page.config.config.dhcp ? dhcp_page.config.config.dhcp.logging : "Please log in")
                    }
                    Text {
                        color: "white"
                        text: "ignoreUnknownClients: " + (dhcp_page.config && dhcp_page.config.config && dhcp_page.config.config.dhcp ? dhcp_page.config.config.dhcp.ignoreUnknownClients : "Please log in")
                    }
                    Text {
                        color: "white"
                        text: "hosts: " + (dhcp_page.config && dhcp_page.config.config && dhcp_page.config.config.dhcp ? dhcp_page.config.config.dhcp.hosts : "Please log in")
                    }
                }
            }
        }
    }
}