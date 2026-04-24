import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Qt.labs.platform

Window {
    id: root
    property alias stack: stackView
    property string host: ""
    minimumWidth: 640
    minimumHeight: 480
    visible: true
    title: qsTr("Hole-Monitor")
    color:"#1f1f1f"
    onClosing: function(close) { // onClosing does in fact exist, if you see and error here ignore please it.
            root.hide()
        }
    StackView {
        id: stackView
        anchors.fill: parent
        initialItem: MainMenu {}
    }
    Connections {
        target: piholeApi
        function onSidChanged() {
            if (piholeApi.baseUrl !== "") {
                root.host = piholeApi.baseUrl
            }
            else {
                root.host = "You are not logged in!"
            }
        }
        Component.onCompleted: {
            if (piholeApi.baseUrl !== "") {
                root.host = piholeApi.baseUrl
            }
            else {
                root.host = "You are not logged in!"
            }
        }
    }

    SystemTrayIcon {
        visible: true
        icon.source: "qrc:images/tray-icon.png"
        onActivated: function(reason) {
            if (reason === SystemTrayIcon.Trigger) {
                root.show()
                root.raise()
                root.requestActivate()
            }
        }


        menu: Menu {
            MenuItem {
                text: root.host
            }

            MenuItem {
                text: "Main Menu"
                onTriggered: {
                    root.show()
                    root.raise()
                    root.requestActivate()
                }
            }

            MenuItem {
                text: qsTr("Quit")
                onTriggered: Qt.quit()
            }
        }
    }
}

