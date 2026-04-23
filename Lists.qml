import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Item {
    Page {
        anchors.fill: parent
        id: page3
        title: "Lists"
        header: ToolBar {
            Button {
                text: "<"
                onClicked: root.stack.pop()
            }
        }
        Component.onCompleted: {
            if (piholeApi && piholeApi.sid !== "") {
                piholeApi.fetchLists()
            }
        }
        property var list: null

        Connections {
            target: piholeApi
            function onFetchListsReady(data) {
                page3.list = null
                page3.list = data
            }
            function onSidChanged() {
                piholeApi.fetchLists()
            }
        }
        Rectangle {
            anchors.fill: parent
            color: "#2a2a2a"
            border.color: "#444444"
            border.width: 1
            radius: 4
            z: -1

            ListView {
                anchors.fill: parent
                clip: true
                model: page3.list ? page3.list["lists"] : []
                delegate: Item {
                    width: ListView.view.width
                    height: 40
                    Rectangle {
                        anchors.fill: parent
                        color: "#2a2a2a"
                        border.color: "#adacac"
                        border.width: 1
                        radius: 4
                        Text {
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.horizontalCenter: parent.horizontalCenter
                            color: "white"
                            text: (modelData["address"] + " | type:  " + modelData["type"] + " | comment: " + modelData["comment"] + " | enabled: " + modelData["enabled"])
                        }
                    }
                }
            }
        }
    }
}
