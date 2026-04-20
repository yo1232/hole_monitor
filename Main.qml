import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Window {
    id: root
    property alias stack: stackView
    minimumWidth: 640
    minimumHeight: 480
    visible: true
    title: qsTr("Hole-Monitor")
    color:"#1f1f1f"
    StackView {
        id: stackView
        anchors.fill: parent
        initialItem: MainMenu {}
    }
}

