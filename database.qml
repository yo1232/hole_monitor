import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtNetwork
// TODO: Add possibility to modify values
Item {
    Page {
        id: database_page
        title: "Database"
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
                piholeApi.fetchDatabaseConfig()
            }
        }
        property var config: null

        Connections {
            target: piholeApi
            function onFetchDatabaseConfigReady(data) {
                database_page.config= null
                database_page.config = data
            }
            function onSidChanged() {
                piholeApi.fetchDatabaseConfig()
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
                                text: "Database import: " + (database_page.config && database_page.config.config && database_page.config.config.database ? database_page.config.config.database.DBimport : "Please log in")
                            }
                            Text {
                                color: "white"
                                text: "Max database days: " + (database_page.config && database_page.config.config && database_page.config.config.database ? database_page.config.config.database.maxDBdays : "Please log in")
                            }
                            Text {
                                color: "white"
                                text: "Database interval: " + (database_page.config && database_page.config.config && database_page.config.config.database ? database_page.config.config.database.DBinterval : "Please log in")
                            }
                            Text {
                                color: "white"
                                text: "Use WAL: " + (database_page.config && database_page.config.config && database_page.config.config.database ? database_page.config.config.database.useWAL : "Please log in")
                            }
                            Text {
                                color: "white"
                                text: "Force disk: " + (database_page.config && database_page.config.config && database_page.config.config.database ? database_page.config.config.database.forceDisk : "Please log in")
                            }
                        }
                    }
                    Rectangle {
                        color: "#2a2a2a"
                        border.color: "#444444"
                        radius: 4
                        Layout.fillWidth: true
                        implicitHeight: network.implicitHeight + 20
                        Column {
                            id: network
                            spacing: 10
                            anchors.fill: parent
                            anchors.margins: 10
                            Text {
                                color: "lightgrey"
                                text: "Network"
                            }
                            Text {
                                color: "white"
                                text: "Parse ARP cache: " + (database_page.config && database_page.config.config && database_page.config.config.database && database_page.config.config.database.network ? database_page.config.config.database.network.parseARPcache : "Please log in")
                            }
                            Text {
                                color: "white"
                                text: "Expire: " + (database_page.config && database_page.config.config && database_page.config.config.database && database_page.config.config.database.network ? database_page.config.config.database.network.expire : "Please log in")
                            }
                        }
                    }
                }
            }
        }
    }
}