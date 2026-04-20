import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Item {
    // TODO: Get white and blocklists from pi-hole api
    Page {
        id: page3
        title: "Lists"
        Text {
            id: text3
            text: qsTr("Lists")
        }
        header: ToolBar {
            Button {
                text: "<"
                onClicked: root.stack.pop()
            }
        }
    }
}
