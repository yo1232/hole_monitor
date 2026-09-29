import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtNetwork
// TODO: Add possibility to modify values
Item {
    Page {
        id: resolver_page
        title: "Resolver"
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
                piholeApi.fetchResolverConfig()
            }
        }
        property var config: null

        Connections {
            target: piholeApi
            function onFetchResolverConfigReady(data) {
                resolver_page.config= null
                resolver_page.config = data
            }
            function onSidChanged() {
                piholeApi.fetchResolverConfig()
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
                    Rectangle {
                        color: "#2a2a2a"
                        border.color: "#444444"
                        radius: 4
                        Layout.fillWidth: true
                        implicitHeight: general.implicitHeight + 20
                        Column {
                            id: general
                            spacing: 10
                            anchors.fill: parent
                            anchors.margins: 10
                            Text {
                                color: "white"
                                text: "Resolve IPv4: " + (resolver_page.config && resolver_page.config.config && resolver_page.config.config.resolver ? resolver_page.config.config.resolver.resolveIPv4 : "Please log in")
                            }
                            Text {
                                color: "white"
                                text: "Resolve IPv6: " + (resolver_page.config && resolver_page.config.config && resolver_page.config.config.resolver ? resolver_page.config.config.resolver.resolveIPv6 : "Please log in")
                            }
                            Text {
                                color: "white"
                                text: "MAC names: " + (resolver_page.config && resolver_page.config.config && resolver_page.config.config.resolver ? resolver_page.config.config.resolver.macNames : "Please log in")
                            }
                            Text {
                                color: "white"
                                text: "Network names: " + (resolver_page.config && resolver_page.config.config && resolver_page.config.config.resolver ? resolver_page.config.config.resolver.networkNames : "Please log in")
                            }
                            Text {
                                color: "white"
                                text: "Refresh names: " + (resolver_page.config && resolver_page.config.config && resolver_page.config.config.resolver ? resolver_page.config.config.resolver.refreshNames : "Please log in")
                            }
                        }
                    }
                }
            }
        }
    }
}