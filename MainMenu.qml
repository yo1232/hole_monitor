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
                        text: "groups"
                        onClicked: root.stack.push("Groups.qml")
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
            function onPopulateDomainGraphReady(data){
                graphs2.updateGraph2(data)
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
                    piholeApi.populateDomainGraph()
                    piholeApi.fetchLists()
                    piholeApi.fetchGroups()
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
                    color: "#2a2a2a"
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
                            labelsAngle: -45
                        }

                        ValueAxis {
                            id: barAxisY
                            min: 0
                            gridVisible: false
                        }
                    }
                    Text {
                        id: graphTitle
                        z: 1
                        text: "Client Activity"
                        color: "white"
                        anchors.top: parent.top
                        anchors.horizontalCenter: parent.horizontalCenter
                        topPadding: 4
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
            RowLayout {
                Rectangle{
                    id: graphs2
                    Layout.fillWidth: true
                    Layout.preferredHeight: 200
                    color: "#2a2a2a"
                    border.color: "#444444"
                    border.width: 1
                    radius: 4

                    GraphsView {
                        id: chart2
                        anchors.fill: parent
                        axisX: barAxisX2
                        axisY: barAxisY2

                        BarSeries {
                            id: barSeries2
                            barsType: BarSeries.BarsType.Stacked
                            axisX: barAxisX2
                            axisY: barAxisY2
                        }

                        BarCategoryAxis {
                            id: barAxisX2
                            gridVisible: false
                            labelsAngle: -45
                        }

                        ValueAxis {
                            id: barAxisY2
                            min: 0
                            gridVisible: false
                        }
                    }
                    Text {
                        id: graph2Title
                        z: 1
                        text: "Total Queries"
                        color: "white"
                        anchors.top: parent.top
                        anchors.horizontalCenter: parent.horizontalCenter
                        topPadding: 4
                    }
                    function updateGraph2(data) {
                        barSeries2.clear()

                        var history = data["history"]
                        var categories = []
                        var domainValues = {}
                        var maxY2 = 0

                        for (var i = 0; i < history.length; i++) {
                            var domainData = history[i]
                            for (var domain in domainData) {
                                if (!domainValues[domain] && domain !== "timestamp" && domain !== "total") {
                                    domainValues[domain] = []
                                }
                            }
                        }

                        for (var i = 0; i < history.length; i++) {
                            var domainData = history[i]
                            var d = new Date(domainData["timestamp"] * 1000)
                            var prevD = i > 0 ? new Date(history[i-1]["timestamp"] * 1000) : null

                            if (prevD === null || d.getHours() !== prevD.getHours()) {
                                categories.push(d.toLocaleTimeString(Qt.locale(), "hh:mm"))
                            } else {
                                categories.push("")
                            }
                            var total = 0
                            for (var domain in domainValues) {
                                var val = domainData[domain] || 0
                                domainValues[domain].push(val)
                                total += val
                            }
                            if (total > maxY2) maxY2 = total
                        }

                        for (var domain in domainValues) {
                            var barSet = Qt.createQmlObject('import QtGraphs; BarSet { label: "' + domain + '" }', chart2)
                            barSet.values = domainValues[domain]
                            barSeries2.append(barSet)
                        }
                        barAxisX2.categories = categories
                        barAxisY2.max = maxY2 + 100
                    }
                }
            }

            Item {
                Layout.fillHeight: true
            }
        }
    }
}
