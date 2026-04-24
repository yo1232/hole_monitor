import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Item {
    // TODO: Get logs from pi-hole api
    Page {
        id: page3
        title: "logs"
        anchors.fill: parent
        Text {
            id: text3
            text: qsTr("logs")
        }
        property bool live: false
        header: ToolBar {
            RowLayout {
                Button {
                    text: "<"
                    onClicked: root.stack.pop()
                }
                Switch {
                    text: "Live view"
                    checked: page3.live
                    onClicked: page3.live = checked
                }
            }
        }
        property var logs: null
        Connections {
            target: piholeApi

            Component.onCompleted: {
                piholeApi.fetchLogs()
            }

            function onLogsReady(data) {
                page3.logs = data
            }
            function onSidChanged() {
                piholeApi.fetchLogs()
            }
        }
        Timer {
            interval: 2000
            running: piholeApi && piholeApi.sid !== "" && page3.live === true
            repeat: true
            onTriggered: {
                piholeApi.fetchLogs()
            }
        }

        ListView {
            anchors.fill: parent
            clip: true
            Rectangle {
                anchors.fill: parent
                color: "#2a2a2a"
                border.color: "#444444"
                border.width: 1
                radius: 4
                z: -1
            }
            model: page3.logs ? page3.logs["queries"] : []
            delegate: Item {
                width: ListView.view.width
                height: 40
                Rectangle {
                    anchors.fill: parent
                    color: "#2a2a2a"
                    border.color: "#444444"
                    border.width: 1
                    radius: 4
                    Text{
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.horizontalCenter: parent.horizontalCenter
                        color: "white"
                        text: modelData["client"]["ip"] + ": " + modelData["domain"] + " | " + modelData["type"] + " | " + modelData["status"] + " | " + new Date(modelData["time"] * 1000).toLocaleTimeString(Qt.locale(), "hh:mm:ss")
                    }
                }
            }
        }
    }
}
