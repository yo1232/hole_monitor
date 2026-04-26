import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Dialogs

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
            function onDeletedList() {
                piholeApi.fetchLists()
            }
            function onListAdded() {
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
                        border.color: "#444444"
                        border.width: 1
                        radius: 4
                        RowLayout {
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.horizontalCenter: parent.horizontalCenter
                            Text {
                                color: "white"
                                text: (modelData["address"] + " | type:  " + modelData["type"] + " | comment: " + modelData["comment"] + " | enabled: ")
                            }
                            Switch {
                                checked: modelData["enabled"]
                                onClicked: {
                                    piholeApi.updateList(modelData["address"], modelData["comment"], modelData["group"], modelData["type"], modelData["enabled"] = checked)
                                }
                            }
                            Button {
                                text: "Delete"
                                onClicked: deleteDialog.open()
                            }
                            Dialog {
                                id: deleteDialog
                                title: "Confirm Delete"
                                modal: true
                                standardButtons: Dialog.Ok | Dialog.Cancel

                                Text {
                                    text: "Are you sure you want to delete " + modelData["address"] + "?"
                                    color: "white"
                                }
                                onAccepted: {
                                    piholeApi.deleteList(modelData["address"], modelData["type"])
                                }
                            }
                        }
                    }
                }
            }
            RowLayout {
                id:addlist
                anchors.bottom: parent.bottom
                TextField {
                    id: url
                    placeholderText: qsTr("list Url")
                }
                TextField {
                    id: comment
                    placeholderText: qsTr("Comment")
                }
                property bool enabled: true
                Switch {
                    id: enable_switch
                    checked: addlist.enabled
                    onClicked: addlist.enabled = checked
                }
                Button {
                    text: "Add blocklist"
                    onClicked: {
                        piholeApi.addList(url.text, comment.text, "[0]", "block", addlist.enabled)
                        url.text = ""
                        comment.text = ""
                    }
                }
                Button {
                    text: "Add allowlist"
                    onClicked: {
                        piholeApi.addList(url.text, comment.text, "[0]", "allow", addlist.enabled)
                        url.text = ""
                        comment.text = ""
                    }
                }
            }
        }
    }
}
