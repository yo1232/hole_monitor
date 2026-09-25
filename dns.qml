import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtNetwork

Item {
    Page {
        id: dns_page
        title: "DNS"
        anchors.fill: parent
        header: ToolBar {
            ColumnLayout {
                RowLayout {
                    Layout.fillWidth: true
                    Button {
                        text: "<"
                        onClicked: root.stack.pop()
                    }
                }
            }
        }
        Component.onCompleted: {
            if (piholeApi && piholeApi.sid !== "") {
                piholeApi.fetchDNSConfig()
            }
        }
        property var config: null

        Connections {
            target: piholeApi
            function onFetchDNSConfigReady(data) {
                dns_page.config= null
                dns_page.config = data
            }
            function onSidChanged() {
                piholeApi.fetchDNSConfig()
            }
        }
        ScrollView {
            anchors.fill: parent
            clip: true
            ColumnLayout {
                width: parent.width
                spacing: 10
                Text {
                    color: "white"
                    text: "Upstreams: " + (dns_page.config && dns_page.config.config && dns_page.config.config.dns ? dns_page.config.config.dns.upstreams : "Please log in")
                }
                Text {
                    color: "white"
                    text: "CNAMEdeepInspect: " + (dns_page.config && dns_page.config.config && dns_page.config.config.dns ? dns_page.config.config.dns.CNAMEdeepInspect : "Please log in")
                }
                Text {
                    color: "white"
                    text: "blockESNI: " + (dns_page.config && dns_page.config.config && dns_page.config.config.dns ? dns_page.config.config.dns.blockESNI : "Please log in")
                }
                Text {
                    color: "white"
                    text: "EDNS0ECS: " + (dns_page.config && dns_page.config.config && dns_page.config.config.dns ? dns_page.config.config.dns.EDNS0ECS : "Please log in")
                }
                Text {
                    color: "white"
                    text: "ignoreLocalhost: " + (dns_page.config && dns_page.config.config && dns_page.config.config.dns ? dns_page.config.config.dns.ignoreLocalhost : "Please log in")
                }
                Text {
                    color: "white"
                    text: "showDNSSEC: " + (dns_page.config && dns_page.config.config && dns_page.config.config.dns ? dns_page.config.config.dns.showDNSSEC : "Please log in")
                }
                Text {
                    color: "white"
                    text: "analyzeOnlyAandAAAA: " + (dns_page.config && dns_page.config.config && dns_page.config.config.dns ? dns_page.config.config.dns.analyzeOnlyAandAAAA : "Please log in")
                }
                Text {
                    color: "white"
                    text: "piholePTR: " + (dns_page.config && dns_page.config.config && dns_page.config.config.dns ? dns_page.config.config.dns.piholePTR : "Please log in")
                }
                Text {
                    color: "white"
                    text: "replyWhenBusy: " + (dns_page.config && dns_page.config.config && dns_page.config.config.dns ? dns_page.config.config.dns.replyWhenBusy : "Please log in")
                }
                Text {
                    color: "white"
                    text: "blockTTL: " + (dns_page.config && dns_page.config.config && dns_page.config.config.dns ? dns_page.config.config.dns.blockTTL : "Please log in")
                }
                Text {
                    color: "white"
                    text: "hosts: " + (dns_page.config && dns_page.config.config && dns_page.config.config.dns ? dns_page.config.config.dns.hosts : "Please log in")
                }
                Text {
                    color: "white"
                    text: "domainNeeded: " + (dns_page.config && dns_page.config.config && dns_page.config.config.dns ? dns_page.config.config.dns.domainNeeded : "Please log in")
                }
                Text {
                    color: "white"
                    text: "expandHosts: " + (dns_page.config && dns_page.config.config && dns_page.config.config.dns ? dns_page.config.config.dns.expandHosts : "Please log in")
                }
                Text {
                    color: "white"
                    text: "domain: " + (dns_page.config && dns_page.config.config && dns_page.config.config.dns ? dns_page.config.config.dns.domain : "Please log in")
                }
                Text {
                    color: "white"
                    text: "bogusPriv: " + (dns_page.config && dns_page.config.config && dns_page.config.config.dns ? dns_page.config.config.dns.bogusPriv : "Please log in")
                }
                Text {
                    color: "white"
                    text: "dnssec: " + (dns_page.config && dns_page.config.config && dns_page.config.config.dns ? dns_page.config.config.dns.dnssec : "Please log in")
                }
                Text {
                    color: "white"
                    text: "interface: " + (dns_page.config && dns_page.config.config && dns_page.config.config.dns ? dns_page.config.config.dns.interface : "Please log in")
                }
                Text {
                    color: "white"
                    text: "hostRecord: " + (dns_page.config && dns_page.config.config && dns_page.config.config.dns ? dns_page.config.config.dns.hostRecord : "Please log in")
                }
                Text {
                    color: "white"
                    text: "listeningMode: " + (dns_page.config && dns_page.config.config && dns_page.config.config.dns ? dns_page.config.config.dns.listeningMode : "Please log in")
                }
                Text {
                    color: "white"
                    text: "queryLogging: " + (dns_page.config && dns_page.config.config && dns_page.config.config.dns ? dns_page.config.config.dns.queryLogging : "Please log in")
                }
                Text {
                    color: "white"
                    text: "cnameRecords: " + (dns_page.config && dns_page.config.config && dns_page.config.config.dns ? dns_page.config.config.dns.cnameRecords : "Please log in")
                }
                Text {
                    color: "white"
                    text: "port: " + (dns_page.config && dns_page.config.config && dns_page.config.config.dns ? dns_page.config.config.dns.port : "Please log in")
                }
                Text {
                    color: "white"
                    text: "localise: " + (dns_page.config && dns_page.config.config && dns_page.config.config.dns ? dns_page.config.config.dns.localise : "Please log in")
                }
                Text {
                    color: "white"
                    text: "cache: " + (dns_page.config && dns_page.config.config && dns_page.config.config.dns ? dns_page.config.config.dns.cache : "Please log in")
                }
                Text {
                    color: "white"
                    text: "revServers: " + (dns_page.config && dns_page.config.config && dns_page.config.config.dns ? dns_page.config.config.dns.revServers : "Please log in")
                }
                Text {
                    color: "white"
                    text: "specialDomains: " + (dns_page.config && dns_page.config.config && dns_page.config.config.dns ? dns_page.config.config.dns.specialDomains : "Please log in")
                }
                Text {
                    color: "white"
                    text: "reply: " + (dns_page.config && dns_page.config.config && dns_page.config.config.dns ? dns_page.config.config.dns.reply : "Please log in")
                }
                Text {
                    color: "white"
                    text: "rateLimit: " + (dns_page.config && dns_page.config.config && dns_page.config.config.dns ? dns_page.config.config.dns.rateLimit : "Please log in")
                }
            }
        }
    }
}
