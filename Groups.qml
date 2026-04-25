import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Dialogs

Item {
    Page {
        id: groups_page
        anchors.fill: parent
        title: "Groups"
        header: ToolBar {
            Button {
                text: "<"
                onClicked: root.stack.pop()
            }
        }
        Component.onCompleted: {
            if (piholeApi && piholeApi.sid !== "") {
                piholeApi.fetchGroups()
            }
        }
        property var group: null

        Connections {
            target: piholeApi
            function onFetchGroupsReady(data) {
                groups_page.group = null
                groups_page.group = data
            }
            function onSidChanged() {
                piholeApi.fetchGroups()
            }
            function onGroupFailed2Add(error) {
                console.log(error)
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
                model: groups_page.group ? groups_page.group["groups"] : []
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
                                text: (modelData["name"] + " | enabled:")
                            }
                            Switch {
                                checked: modelData["enabled"]
                                onClicked: {
                                    piholeApi.updateGroup(modelData["name"], modelData["comment"], modelData["enabled"] = checked)
                                }
                            }
                            Text {
                                color: "white"
                                text: (" | comment: " + modelData["comment"])
                            }

                            Button {
                                text: "Delete"
                                onClicked: {
                                    if (modelData["name"] !== "Default"){
                                        deleteDialog.open()
                                    }
                                    else {
                                        cantDelete.open()
                                    }
                                }
                            }
                            Dialog {
                                id: cantDelete
                                title: "Can't delete!"
                                modal: true
                                standardButtons: Dialog.close | Dialog.close
                                Text {text: "You cannot delete the default group."; color: "white"}
                            }

                            Dialog {
                                id: deleteDialog
                                title: "Confirm Delete"
                                modal: true
                                standardButtons: Dialog.Ok | Dialog.Cancel

                                Text {
                                    text: "Are you sure you want to delete " + modelData["name"] + "?"
                                    color: "white"
                                }
                                onAccepted: {
                                    piholeApi.deleteGroup(modelData["name"])
                                }
                            }
                        }
                    }
                }
            }
            RowLayout {
                anchors.bottom: parent.bottom
                TextField {
                    id: name
                    placeholderText: qsTr("group name")
                }
                TextField {
                    id: comment
                    placeholderText: qsTr("Comment")
                }
                Button {
                    text: "Add group"
                    onClicked: {
                        piholeApi.addGroup(name.text, comment.text, true)
                        name.text = ""
                        comment.text = ""
                    }
                }
            }
        }
    }
}
