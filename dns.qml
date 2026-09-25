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
            RowLayout {
                width: parent.width
                height: parent.height
                spacing: 15
                ColumnLayout {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
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
                        text: "revServers: " + (dns_page.config && dns_page.config.config && dns_page.config.config.dns ? dns_page.config.config.dns.revServers : "Please log in")
                    }
                    Text {
                        color: "white"
                        text: "reply: " + (dns_page.config && dns_page.config.config && dns_page.config.config.dns ? dns_page.config.config.dns.reply : "Please log in")
                    }
                }
                ColumnLayout {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    spacing: 15
                    Rectangle {
                        color: "#2c3e50"
                        radius: 4
                        Layout.fillWidth: true
                        implicitHeight: domain.implicitHeight + 20
                        Column {
                            id: domain
                            spacing: 10
                            anchors.fill: parent
                            anchors.margins: 10
                            Text {
                                color: "white"
                                text: "----Domain----"
                            }
                            Text {
                                color: "white"
                                text: "domain: " + (dns_page.config && dns_page.config.config && dns_page.config.config.dns && dns_page.config.config.dns.domain ? dns_page.config.config.dns.domain.name : "Please log in")
                            }
                            Text {
                                color: "white"
                                text: "local: " + (dns_page.config && dns_page.config.config && dns_page.config.config.dns && dns_page.config.config.dns.domain ? dns_page.config.config.dns.domain.local : "Please log in")
                            }
                        }
                    }
                    Rectangle {
                        color: "#2c3e50"
                        radius: 4
                        Layout.fillWidth: true
                        implicitHeight: cache.implicitHeight + 20
                        Column {
                            id: cache
                            spacing: 10
                            anchors.fill: parent
                            anchors.margins: 10
                            Text {
                                color: "lightgrey"
                                text: "----Cache----"
                            }
                            Text {
                                color: "white"
                                text: "cache size: " + (dns_page.config && dns_page.config.config && dns_page.config.config.dns && dns_page.config.config.dns.cache ? dns_page.config.config.dns.cache.size : "Please log in")
                            }
                            Text {
                                color: "white"
                                text: "cache optimizer: " + (dns_page.config && dns_page.config.config && dns_page.config.config.dns && dns_page.config.config.dns.cache ? dns_page.config.config.dns.cache.optimizer : "Please log in")
                            }
                            Text {
                                color: "white"
                                text: "upstreamBlockedTTL: " + (dns_page.config && dns_page.config.config && dns_page.config.config.dns && dns_page.config.config.dns.cache ? dns_page.config.config.dns.cache.upstreamBlockedTTL : "Please log in")
                            }
                            Text {
                                color: "white"
                                text: "rrtype: " + (dns_page.config && dns_page.config.config && dns_page.config.config.dns && dns_page.config.config.dns.cache ? dns_page.config.config.dns.cache.rrtype : "Please log in")
                            }
                        }
                    }
                    Rectangle {
                        color: "#2c3e50"
                        radius: 4
                        Layout.fillWidth: true
                        implicitHeight: blocking.implicitHeight + 20
                        Column {
                            id: blocking
                            spacing: 10
                            anchors.fill: parent
                            anchors.margins: 10
                            Text {
                                color: "lightgrey"
                                text: "----Blocking----"
                            }
                            Text {
                                color: "white"
                                text: "active: " + (dns_page.config && dns_page.config.config && dns_page.config.config.dns && dns_page.config.config.dns.blocking ? dns_page.config.config.dns.blocking.active : "Please log in")
                            }
                            Text {
                                color: "white"
                                text: "mode: " + (dns_page.config && dns_page.config.config && dns_page.config.config.dns && dns_page.config.config.dns.blocking ? dns_page.config.config.dns.blocking.mode : "Please log in")
                            }
                            Text {
                                color: "white"
                                text: "edns: " + (dns_page.config && dns_page.config.config && dns_page.config.config.dns && dns_page.config.config.dns.blocking ? dns_page.config.config.dns.blocking.edns : "Please log in")
                            }
                        }
                    }
                    Rectangle {
                        color: "#2c3e50"
                        radius: 4
                        Layout.fillWidth: true
                        implicitHeight: speciald.implicitHeight + 20
                        Column {
                            id: speciald
                            spacing: 10
                            anchors.fill: parent
                            anchors.margins: 10
                            Text {
                                color: "lightgrey"
                                text: "----Special Domains----"
                            }
                            Text {
                                color: "white"
                                text: "mozilla canary: " + (dns_page.config && dns_page.config.config && dns_page.config.config.dns.specialDomains ? dns_page.config.config.dns.specialDomains.mozillaCanary : "Please log in")
                            }
                            Text {
                                color: "white"
                                text: "icloud private relay: " + (dns_page.config && dns_page.config.config && dns_page.config.config.dns.specialDomains ? dns_page.config.config.dns.specialDomains.iCloudPrivateRelay : "Please log in")
                            }
                            Text {
                                color: "white"
                                text: "designated resolver: " + (dns_page.config && dns_page.config.config && dns_page.config.config.dns.specialDomains ? dns_page.config.config.dns.specialDomains.designatedResolver : "Please log in")
                            }
                        }
                    }
                    Rectangle {
                        color: "#2c3e50"
                        radius: 4
                        Layout.fillWidth: true
                        implicitHeight: reply.implicitHeight + 20
                        Column {
                            id: reply
                            spacing: 10
                            anchors.fill: parent
                            anchors.margins: 10
                            Text {
                                color: "lightgrey"
                                text: "----Reply----"
                            }
                            Text {
                                color: "lightgrey"
                                text: "--Host--"
                            }
                            Text {
                                color: "white"
                                text: "force ipv4: " + (dns_page.config && dns_page.config.config && dns_page.config.config.dns.reply && dns_page.config.config.dns.reply.host ? dns_page.config.config.dns.reply.host.force4 : "Please log in")
                            }
                            Text {
                                color: "white"
                                text: "force ipv6: " + (dns_page.config && dns_page.config.config && dns_page.config.config.dns.reply && dns_page.config.config.dns.reply.host ? dns_page.config.config.dns.reply.host.force6 : "Please log in")
                            }
                            Text {
                                color: "white"
                                text: "IPv4: " + (dns_page.config && dns_page.config.config && dns_page.config.config.dns.reply && dns_page.config.config.dns.reply.host ? dns_page.config.config.dns.reply.host.IPv4 : "Please log in")
                            }
                            Text {
                                color: "white"
                                text: "IPv6: " + (dns_page.config && dns_page.config.config && dns_page.config.config.dns.reply && dns_page.config.config.dns.reply.host ? dns_page.config.config.dns.reply.host.IPv6 : "Please log in")
                            }
                            Text {
                                color: "lightgrey"
                                text: "--Blocking--"
                            }
                            Text {
                                color: "white"
                                text: "force ipv4: " + (dns_page.config && dns_page.config.config && dns_page.config.config.dns.reply && dns_page.config.config.dns.reply.blocking ? dns_page.config.config.dns.reply.blocking.force4 : "Please log in")
                            }
                            Text {
                                color: "white"
                                text: "force ipv6: " + (dns_page.config && dns_page.config.config && dns_page.config.config.dns.reply && dns_page.config.config.dns.reply.blocking ? dns_page.config.config.dns.reply.blocking.force6 : "Please log in")
                            }
                            Text {
                                color: "white"
                                text: "IPv4: " + (dns_page.config && dns_page.config.config && dns_page.config.config.dns.reply && dns_page.config.config.dns.reply.blocking ? dns_page.config.config.dns.reply.blocking.IPv4 : "Please log in")
                            }
                            Text {
                                color: "white"
                                text: "IPv6: " + (dns_page.config && dns_page.config.config && dns_page.config.config.dns.reply && dns_page.config.config.dns.reply.blocking ? dns_page.config.config.dns.reply.blocking.IPv6 : "Please log in")
                            }
                        }
                    }
                    Rectangle {
                        color: "#2c3e50"
                        radius: 4
                        Layout.fillWidth: true
                        implicitHeight: rate.implicitHeight + 20
                        Column {
                            id: rate
                            spacing: 10
                            anchors.fill: parent
                            anchors.margins: 10
                            Text {
                                color: "lightgrey"
                                text: "----Rate Limit----"
                            }
                            Text {
                                color: "white"
                                text: "count: " + (dns_page.config && dns_page.config.config && dns_page.config.config.dns.rateLimit ? dns_page.config.config.dns.rateLimit.count : "Please log in")
                            }
                            Text {
                                color: "white"
                                text: "interval: " + (dns_page.config && dns_page.config.config && dns_page.config.config.dns.rateLimit ? dns_page.config.config.dns.rateLimit.interval : "Please log in")
                            }
                        }
                    }
                }
            }
        }
    }
}
