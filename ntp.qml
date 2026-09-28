import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtNetwork

Item {
    Page {
        id: ntp_page
        title: "NTP"
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
                piholeApi.fetchNTPConfig()
            }
        }
        property var config: null

        Connections {
            target: piholeApi
            function onFetchNTPConfigReady(data) {
                ntp_page.config= null
                ntp_page.config = data
            }
            function onSidChanged() {
                piholeApi.fetchNTPConfig()
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
                        color: "#2c3e50"
                        radius: 4
                        Layout.fillWidth: true
                        implicitHeight: ipv4.implicitHeight + 20
                        Column {
                            id: ipv4
                            spacing: 10
                            anchors.fill: parent
                            anchors.margins: 10
                            Text {
                                color: "lightgrey"
                                text: "IPv4"
                            }
                            Text {
                                color: "white"
                                text: "Active: " + (ntp_page.config && ntp_page.config.config && ntp_page.config.config.ntp && ntp_page.config.config.ntp.ipv4 ? ntp_page.config.config.ntp.ipv4.active : "Please log in")
                            }
                            Text {
                                color: "white"
                                text: "Address: " + (ntp_page.config && ntp_page.config.config && ntp_page.config.config.ntp && ntp_page.config.config.ntp.ipv4 ? ntp_page.config.config.ntp.ipv4.address : "Please log in")
                            }
                        }
                    }
                    Rectangle {
                        color: "#2c3e50"
                        radius: 4
                        Layout.fillWidth: true
                        implicitHeight: ipv6.implicitHeight + 20
                        Column {
                            id: ipv6
                            spacing: 10
                            anchors.fill: parent
                            anchors.margins: 10
                            Text {
                                color: "lightgrey"
                                text: "IPv6"
                            }
                            Text {
                                color: "white"
                                text: "Active: " + (ntp_page.config && ntp_page.config.config && ntp_page.config.config.ntp && ntp_page.config.config.ntp.ipv6 ? ntp_page.config.config.ntp.ipv6.active : "Please log in")
                            }
                            Text {
                                color: "white"
                                text: "Address: " + (ntp_page.config && ntp_page.config.config && ntp_page.config.config.ntp && ntp_page.config.config.ntp.ipv6 ? ntp_page.config.config.ntp.ipv6.address : "Please log in")
                            }
                        }
                    }
                    Rectangle {
                        color: "#2c3e50"
                        radius: 4
                        Layout.fillWidth: true
                        implicitHeight: sync.implicitHeight + 20
                        Column {
                            id: sync
                            spacing: 10
                            anchors.fill: parent
                            anchors.margins: 10
                            Text {
                                color: "lightgrey"
                                text: "Sync"
                            }
                            Text {
                                color: "white"
                                text: "Active: " + (ntp_page.config && ntp_page.config.config && ntp_page.config.config.ntp && ntp_page.config.config.ntp.sync ? ntp_page.config.config.ntp.sync.active : "Please log in")
                            }
                            Text {
                                color: "white"
                                text: "Server: " + (ntp_page.config && ntp_page.config.config && ntp_page.config.config.ntp && ntp_page.config.config.ntp.sync ? ntp_page.config.config.ntp.sync.server : "Please log in")
                            }
                            Text {
                                color: "white"
                                text: "Interval: " + (ntp_page.config && ntp_page.config.config && ntp_page.config.config.ntp && ntp_page.config.config.ntp.sync ? ntp_page.config.config.ntp.sync.interval : "Please log in")
                            }
                            Text {
                                color: "white"
                                text: "Count: " + (ntp_page.config && ntp_page.config.config && ntp_page.config.config.ntp && ntp_page.config.config.ntp.sync ? ntp_page.config.config.ntp.sync.count : "Please log in")
                            }
                            Text {
                                color: "grey"
                                text: "RTC"
                            }
                            Text {
                                color: "white"
                                text: "Set: " + (ntp_page.config && ntp_page.config.config && ntp_page.config.config.ntp && ntp_page.config.config.ntp.sync && ntp_page.config.config.ntp.sync.rtc ? ntp_page.config.config.ntp.sync.rtc.set : "Please log in")
                            }
                            Text {
                                color: "white"
                                text: "Device: " + (ntp_page.config && ntp_page.config.config && ntp_page.config.config.ntp && ntp_page.config.config.ntp.sync && ntp_page.config.config.ntp.sync.rtc ? ntp_page.config.config.ntp.sync.rtc.device : "Please log in")
                            }
                            Text {
                                color: "white"
                                text: "UTC: " + (ntp_page.config && ntp_page.config.config && ntp_page.config.config.ntp && ntp_page.config.config.ntp.sync && ntp_page.config.config.ntp.sync.rtc ? ntp_page.config.config.ntp.sync.rtc.utc : "Please log in")
                            }
                        }
                    }
                }
            }
        }
    }
}