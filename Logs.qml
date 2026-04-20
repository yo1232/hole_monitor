import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Item {
    // TODO: Get logs from pi-hole api
    Page {
        id: page3
        title: "logs"
        Text {
            id: text3
            text: qsTr("logs")
        }
        header: ToolBar {
            Button {
                text: "<"
                onClicked: root.stack.pop()
            }
        }
    }
}
