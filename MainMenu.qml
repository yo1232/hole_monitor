import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtGraphs

Item {
    Page {
        anchors.fill: parent
        id: page1
        title: "main menu"
        header: ToolBar {
            ColumnLayout {
                RowLayout {
                    Layout.fillWidth: true
                    Button {
                        text: "statistics"
                        onClicked: root.stack.push("Statistics.qml")
                    }
                    Button {
                        text: "logs"
                        onClicked: root.stack.push("Logs.qml")
                    }
                    Button {
                        text: "lists"
                        onClicked: root.stack.push("Lists.qml")
                    }
                    Button {
                        text: "settings"
                        onClicked: root.stack.push("Settings.qml")
                    }
                }
            }
        }
        property var stats: null
        Connections {
            target: piholeApi
            function onStatsReady(data) {
                page1.stats = data
            }
            function onSidChanged(){
                piholeApi.fetchStats()
            }
        }
        Timer {
            interval: 5000
            running: piholeApi && piholeApi.sid !== ""
            repeat: true
            onTriggered: {
                if (piholeApi && piholeApi.sid !== ""){
                    piholeApi.fetchStats()
                    piholeApi.fetchTopClients()
                    piholeApi.fetchTopDomains()
                }
            }
        }
        ColumnLayout {
            anchors.fill: parent
            RowLayout {
                Rectangle {
                    Layout.fillWidth: true
                    Layout.preferredHeight: 40
                    color: "blue"
                    border.color: "#444444"
                    border.width: 1
                    radius: 4

                    Text {
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        anchors.leftMargin: 8
                        color: "white"
                        text: "total queries (last 24h): \n" + (page1.stats ? page1.stats["queries"]["total"] : "log in to see the data")
                    }
                }
                Rectangle {
                    Layout.fillWidth: true
                    Layout.preferredHeight: 40
                    color: "red"
                    border.color: "#444444"
                    border.width: 1
                    radius: 4

                    Text {
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        anchors.leftMargin: 8
                        color: "white"
                        text: "queries blocked (last 24h): \n" + (page1.stats ? page1.stats["queries"]["blocked"] : "log in to see the data")
                    }
                }
                Rectangle {
                    Layout.fillWidth: true
                    Layout.preferredHeight: 40
                    color: "#b1720c"
                    border.color: "#444444"
                    border.width: 1
                    radius: 4

                    Text {
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        anchors.leftMargin: 8
                        color: "white"
                        text: "% blocked (last 24h): \n" + (page1.stats ? page1.stats["queries"]["percent_blocked"].toFixed(1) + "%" : "log in to see the data")
                    }
                }
                Rectangle {
                    Layout.fillWidth: true
                    Layout.preferredHeight: 40
                    color: "green"
                    border.color: "#444444"
                    border.width: 1
                    radius: 4

                    Text {
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        anchors.leftMargin: 8
                        color: "white"
                        text: "domains blocked: \n" + (page1.stats ? page1.stats["gravity"]["domains_being_blocked"] : "log in to see the data")
                    }
                }
            }
            Item {
                Layout.fillHeight: true
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
