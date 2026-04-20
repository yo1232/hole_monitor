import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Item {
    Page {
        anchors.fill: parent
        id: page2
        title: "statistics"
        header: ToolBar {
            Button {
                text: "<"
                onClicked: root.stack.pop()
            }
        }
        Component.onCompleted: {
            if (piholeApi && piholeApi.sid !== "") {
                piholeApi.fetchTopClients()
                piholeApi.fetchTopClientsBlocked()
                piholeApi.fetchTopDomains()
                piholeApi.fetchTopDomainsBlocked()
            }
        }

        // Api data variables
        property var topClients: null
        property var topDomains: null
        property var topClientsBlocked: null
        property var topDomainsBlocked: null


        Connections {
            target: piholeApi
            // Get clients data (request count)
            function onTopClientsReady(data) {
                if (data && data["clients"]) {
                    let sorted = data["clients"].slice().sort((a, b) => b["count"] - a["count"])
                    data["clients"] = sorted
                }
                page2.topClients = null
                page2.topClients = data
            }
            function onTopClientsBlockedReady(data) {
                if (data && data["clients"]) {
                    let sorted = data["clients"].slice().sort((a, b) => b["count"] - a["count"])
                    data["clients"] = sorted
                }
                page2.topClientsBlocked = null
                page2.topClientsBlocked = data
            }

            // Get domains data (request count)
            function onTopDomainsReady(data) {
                if (data && data["domains"]) {
                    let sorted = data["domains"].slice().sort((a, b) => b["count"] - a["count"])
                    data["domains"] = sorted
                }
                page2.topDomains = null
                page2.topDomains = data
            }
            function onTopDomainsBlockedReady(data) {
                if (data && data["domains"]) {
                    let sorted = data["domains"].slice().sort((a, b) => b["count"] - a["count"])
                    data["domains"] = sorted
                }
                page2.topDomainsBlocked = null
                page2.topDomainsBlocked = data
            }
            function onSidChanged(){
                piholeApi.fetchTopClients()
                piholeApi.fetchTopClientsBlocked()
                piholeApi.fetchTopDomains()
                piholeApi.fetchTopDomainsBlocked()
            }
        }

        // View management
        ColumnLayout{
            anchors.fill: parent
            spacing: 8
            RowLayout{
                Layout.fillWidth: true
                Layout.fillHeight: true
                anchors.leftMargin: 10
                ListView {
                    header:
                        Text {
                            text: "Top Clients (Total)"
                            color: "white"
                            padding: 4
                        }
                    Rectangle {
                            anchors.fill: parent
                            color: "#2a2a2a"
                            border.color: "#444444"
                            border.width: 1
                            radius: 4
                            z: -1
                        }
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    clip: true
                    model: page2.topClients ? page2.topClients["clients"] : []
                    delegate: Item {
                        width: ListView.view.width
                        height: 40
                        Text{
                            anchors.verticalCenter: parent.verticalCenter
                            color: "white"
                            text: (modelData["name"] !== "" ? modelData["name"] : modelData["ip"]) +
                                  " - " + modelData["count"] + " queries"
                        }
                    }
                }
                ListView {
                    header:
                        Text {
                            text: "Top Domains (Allowed)"
                            color: "white"
                            padding: 4
                        }
                    Rectangle {
                            anchors.fill: parent
                            color: "#2a2a2a"
                            border.color: "#444444"
                            border.width: 1
                            radius: 4
                            z: -1
                        }
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    clip: true
                    model: page2.topDomains ? page2.topDomains["domains"] : []
                    delegate: Item {
                        width: ListView.view.width
                        height: 40
                        Text{
                            anchors.verticalCenter: parent.verticalCenter
                            color: "white"
                            text: modelData["domain"] + " - " + modelData["count"] + " queries"
                        }
                    }
                }
            }
            RowLayout {
                Layout.fillWidth: true
                Layout.fillHeight: true
                anchors.leftMargin: 10
                ListView {
                    header:
                        Text {
                            text: "Top Clients (Blocked)"
                            color: "white"
                            padding: 4
                        }
                    Rectangle {
                            anchors.fill: parent
                            color: "#2a2a2a"
                            border.color: "#444444"
                            border.width: 1
                            radius: 4
                            z: -1
                        }
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    clip: true
                    model: page2.topClientsBlocked ? page2.topClientsBlocked["clients"] : []
                    delegate: Item {
                        width: ListView.view.width
                        height: 40
                        Text{
                            anchors.verticalCenter: parent.verticalCenter
                            color: "white"
                            text: (modelData["name"] !== "" ? modelData["name"] : modelData["ip"]) +
                                  " - " + modelData["count"] + " queries"
                        }
                    }
                }
                ListView {
                    header:
                        Text {
                            text: "Top Domains (Blocked)"
                            color: "white"
                            padding: 4
                        }
                    Rectangle {
                            anchors.fill: parent
                            color: "#2a2a2a"
                            border.color: "#444444"
                            border.width: 1
                            radius: 4
                            z: -1
                        }
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    clip: true
                    model: page2.topDomainsBlocked ? page2.topDomainsBlocked["domains"] : []
                    delegate: Item {
                        width: ListView.view.width
                        height: 40
                        Text{
                            anchors.verticalCenter: parent.verticalCenter
                            color: "white"
                            text: modelData["domain"] + " - " + modelData["count"] + " queries"
                        }
                    }
                }
            }
        }
    }
}
