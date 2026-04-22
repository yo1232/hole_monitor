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
        property int until: Qt.formatDateTime(new Date())
        property int from: until-84600
        property var clientData: null

        Connections {
            target: piholeApi
            function onStatsReady(data) {
                page1.stats = data
            }
            function onSidChanged(){
                piholeApi.fetchStats(page1.until, page1.from)
            }
            function onPopulateClientGraphReady(data) {
                graphs.updateGraph(data)
            }
        }
        Timer {
            interval: 5000
            running: piholeApi && piholeApi.sid !== ""
            repeat: true
            onTriggered: {
                if (piholeApi && piholeApi.sid !== ""){
                    piholeApi.fetchStats(page1.until, page1.from)
                    piholeApi.fetchTopClients()
                    piholeApi.fetchTopDomains()
                    piholeApi.populateClientGraph()
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
            RowLayout {
                Rectangle{
                    id: graphs
                    Layout.fillWidth: true
                    Layout.preferredHeight: 200
                    color: "grey"
                    border.color: "#444444"
                    border.width: 1
                    radius: 4

                    GraphsView {
                        id: chart
                        anchors.fill: parent
                        axisX: barAxisX
                        axisY: barAxisY

                        BarSeries {
                            id: barSeries
                            barsType: BarSeries.BarsType.Stacked
                            axisX: barAxisX
                            axisY: barAxisY
                        }

                        BarCategoryAxis {
                            id: barAxisX
                            gridVisible: false
                        }

                        ValueAxis {
                            id: barAxisY
                            min: 0
                            gridVisible: false
                        }
                    }
                    function updateGraph(data) {
                        barSeries.clear()

                        var history = data["history"]
                        var categories = []
                        var clientValues = {}
                        var maxY = 0

                        for (var i = 0; i < history.length; i++) {
                            var clientData = history[i]["data"]
                            for (var client in clientData) {
                                if (!clientValues[client]) {
                                    clientValues[client] = []
                                }
                            }
                        }

                        for (var i = 0; i < history.length; i++) {
                            var entry = history[i]
                            var d = new Date(entry["timestamp"] * 1000)
                            var clientData = entry["data"]
                            var prevD = i > 0 ? new Date(history[i-1]["timestamp"] * 1000) : null

                            if (prevD === null || d.getHours() !== prevD.getHours()) {
                                categories.push(d.toLocaleTimeString(Qt.locale(), "hh:mm"))
                            } else {
                                categories.push("")
                            }
                            var total = 0
                            for (var client in clientValues) {
                                var val = clientData[client] || 0
                                clientValues[client].push(val)
                                total += val
                            }
                            if (total > maxY) maxY = total
                        }

                        for (var client in clientValues) {
                            var barSet = Qt.createQmlObject('import QtGraphs; BarSet { label: "' + client + '" }', chart)
                            barSet.values = clientValues[client]
                            barSeries.append(barSet)
                        }

                        barAxisX.categories = categories
                        barAxisY.max = maxY + 100
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
