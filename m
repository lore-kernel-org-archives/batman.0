Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 3/9] batctl: man: Convert lists to indented paragraph
Date: Sat, 17 Jul 2021 13:01:23 +0200
Message-Id: <20210717110129.25539-4-sven@narfation.org>
In-Reply-To: <20210717110129.25539-1-sven@narfation.org>
References: <20210717110129.25539-1-sven@narfation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>

The lists macro was misused to manually implement indented paragraphs with
a label. But groff already provides the .TP macro to support this directly.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 man/batctl.8 | 132 +++++++++++++++++++++++++--------------------------
 1 file changed, 66 insertions(+), 66 deletions(-)

diff --git a/man/batctl.8 b/man/batctl.8
index 58656eb..39fac88 100644
--- a/man/batctl.8
+++ b/man/batctl.8
@@ -51,83 +51,86 @@ performances, is also included.
 
 .SH COMMANDS
 
-.IP "[\fBmeshif <netdev>\fP] \fBinterface\fP|\fBif\fP [\fB-M\fP] [\fBadd\fP|\fBdel iface(s)\fP]"
+.TP
+[\fBmeshif <netdev>\fP] \fBinterface\fP|\fBif\fP [\fB-M\fP] [\fBadd\fP|\fBdel iface(s)\fP]
 If no parameter is given or the first parameter is neither "add" nor "del" the current interface settings are displayed.
 In order to add or delete interfaces specify "add" or "del" as first argument and append the interface names you wish to
 add or delete. Multiple interfaces can be specified.
 The "\-M" option tells batctl to not automatically create the batman-adv interface on "add". It can also be used to
 suppress the warning about the manual destruction when "del" removed all interfaces which belonged to it.
-.IP "[\fBmeshif <netdev>\fP] \fBinterface\fP|\fBif\fP \fBcreate\fP [\fBrouting_algo|ra RA_NAME\fP]"
+.TP
+[\fBmeshif <netdev>\fP] \fBinterface\fP|\fBif\fP \fBcreate\fP [\fBrouting_algo|ra RA_NAME\fP]
 A batman-adv interface without attached interfaces can be created using "create". The parameter routing_algo
 can be used to overwrite the (default) routing algorithm.
-.IP "[\fBmeshif <netdev>\fP] \fBinterface\fP|\fBif\fP \fBdestroy\fP"
+.TP
+[\fBmeshif <netdev>\fP] \fBinterface\fP|\fBif\fP \fBdestroy\fP
 Remove all attached interfaces and destroy the batman-adv interface.
-.br
-.IP "[\fBmeshif <netdev>\fP] \fBorig_interval\fP|\fBit\fP [\fBinterval\fP]"
+.TP
+[\fBmeshif <netdev>\fP] \fBorig_interval\fP|\fBit\fP [\fBinterval\fP]
 If no parameter is given the current originator interval setting is displayed otherwise the parameter is used to set the
 originator interval. The interval is in units of milliseconds.
-.br
-.IP "[\fBmeshif <netdev>\fP] \fBap_isolation\fP|\fBap\fP [\fB0\fP|\fB1\fP]"
+.TP
+[\fBmeshif <netdev>\fP] \fBap_isolation\fP|\fBap\fP [\fB0\fP|\fB1\fP]
 If no parameter is given the current ap isolation setting is displayed. Otherwise the parameter is used to enable or
 disable ap isolation.
-.br
-.IP "<\fBvlan <vdev>\fP|[\fBmeshif <netdev>\fP] \fBvid <vid>\fP> \fBap_isolation\fP|\fBap\fP [\fB0\fP|\fB1\fP]"
+.TP
+<\fBvlan <vdev>\fP|[\fBmeshif <netdev>\fP] \fBvid <vid>\fP> \fBap_isolation\fP|\fBap\fP [\fB0\fP|\fB1\fP]
 If no parameter is given the current ap isolation setting for the specified VLAN is displayed. Otherwise the parameter is used to enable or
 disable ap isolation for the specified VLAN.
-.br
-.IP "[\fBmeshif <netdev>\fP] \fBbridge_loop_avoidance\fP|\fBbl\fP [\fB0\fP|\fB1\fP]"
+.TP
+[\fBmeshif <netdev>\fP] \fBbridge_loop_avoidance\fP|\fBbl\fP [\fB0\fP|\fB1\fP]
 If no parameter is given the current bridge loop avoidance setting is displayed. Otherwise the parameter is used to enable
 or disable the bridge loop avoidance. Bridge loop avoidance support has to be enabled when compiling the module otherwise
 this option won't be available.
-.br
-.IP "[\fBmeshif <netdev>\fP] \fBdistributed_arp_table\fP|\fBdat\fP [\fB0\fP|\fB1\fP]"
+.TP
+[\fBmeshif <netdev>\fP] \fBdistributed_arp_table\fP|\fBdat\fP [\fB0\fP|\fB1\fP]
 If no parameter is given the current distributed arp table setting is displayed. Otherwise the parameter is used to
 enable or disable the distributed arp table.
-.br
-.IP "[\fBmeshif <netdev>\fP] \fBaggregation\fP|\fBag\fP [\fB0\fP|\fB1\fP]"
+.TP
+[\fBmeshif <netdev>\fP] \fBaggregation\fP|\fBag\fP [\fB0\fP|\fB1\fP]
 If no parameter is given the current aggregation setting is displayed. Otherwise the parameter is used to enable or disable
 OGM packet aggregation.
-.br
-.IP "[\fBmeshif <netdev>\fP] \fBbonding\fP|\fBb\fP [\fB0\fP|\fB1\fP]"
+.TP
+[\fBmeshif <netdev>\fP] \fBbonding\fP|\fBb\fP [\fB0\fP|\fB1\fP]
 If no parameter is given the current bonding mode setting is displayed. Otherwise the parameter is used to enable or disable
 the bonding mode.
-.br
-.IP "\fBevent\fP|\fBe\fP [\fB\-t\fP|\fB\-r\fP]"
+.TP
+\fBevent\fP|\fBe\fP [\fB\-t\fP|\fB\-r\fP]
 batctl will monitor for events from the netlink kernel interface of batman-adv. The local timestamp of the event will be printed
 when parameter \fB\-t\fP is specified. Parameter \fB\-r\fP will do the same but with relative timestamps.
-.br
-.IP "\fBhardif <hardif>\fP \fBelp_interval\fP|\fBet\fP [\fBinterval\fP]"
+.TP
+\fBhardif <hardif>\fP \fBelp_interval\fP|\fBet\fP [\fBinterval\fP]
 If no parameter is given the current ELP interval setting of the hard interface is displayed otherwise the parameter is used to set the
 ELP interval. The interval is in units of milliseconds.
-.br
-.IP "[\fBmeshif <netdev>\fP] \fBfragmentation\fP|\fBf\fP [\fB0\fP|\fB1\fP]"
+.TP
+[\fBmeshif <netdev>\fP] \fBfragmentation\fP|\fBf\fP [\fB0\fP|\fB1\fP]
 If no parameter is given the current fragmentation mode setting is displayed. Otherwise the parameter is used to enable or
 disable fragmentation.
-.br
-.IP "[\fBmeshif <netdev>\fP] \fBhop_penalty\fP|\fBhp\fP [\fBpenalty\fP]"
+.TP
+[\fBmeshif <netdev>\fP] \fBhop_penalty\fP|\fBhp\fP [\fBpenalty\fP]
 If no parameter is given the current hop penalty setting is displayed. Otherwise the parameter is used to set the
 hop penalty. The penalty is can be 0-255 (255 sets originator message's TQ to zero when forwarded by this hop).
-.br
-.IP "[\fBhardif <hardif>\fP] \fBhop_penalty\fP|\fBhp\fP [\fBpenalty\fP]"
+.TP
+[\fBhardif <hardif>\fP] \fBhop_penalty\fP|\fBhp\fP [\fBpenalty\fP]
 If no parameter is given the current hop penalty setting of the hard interface is displayed. Otherwise the parameter is used to set the
 hop penalty. The penalty can be 0-255 (255 sets originator message's TQ to zero when forwarded over this interface).
-.br
-.IP "[\fBmeshif <netdev>\fP] \fBnetwork_coding\fP|\fBnc\fP [\fB0\fP|\fB1\fP]"
+.TP
+[\fBmeshif <netdev>\fP] \fBnetwork_coding\fP|\fBnc\fP [\fB0\fP|\fB1\fP]
 If no parameter is given the current network coding mode setting is displayed. Otherwise the parameter is used to enable or
 disable network coding.
-.br
-.IP "[\fBmeshif <netdev>\fP] \fBmulticast_forceflood\fP|\fBmff\fP [\fB0\fP|\fB1\fP]"
+.TP
+[\fBmeshif <netdev>\fP] \fBmulticast_forceflood\fP|\fBmff\fP [\fB0\fP|\fB1\fP]
 If no parameter is given the current multicast forceflood setting is displayed. Otherwise the parameter is used to enable or
 disable multicast forceflood. This setting defines whether multicast optimizations should be replaced by simple broadcast-like
 flooding of multicast packets. If set to non-zero then all nodes in the mesh are going to use classic flooding for any
 multicast packet with no optimizations.
-.br
-.IP "[\fBmeshif <netdev>\fP] \fBmulticast_fanout\fP|\fBmo\fP [\fBfanout\fP]"
+.TP
+[\fBmeshif <netdev>\fP] \fBmulticast_fanout\fP|\fBmo\fP [\fBfanout\fP]
 If no parameter is given the current multicast fanout setting is displayed. Otherwise the parameter is used to set
 the multicast fanout. The multicast fanout defines the maximum number of packet copies that may be generated for a
 multicast-to-unicast conversion. Once this limit is exceeded distribution will fall back to broadcast.
-.br
-.IP "[\fBmeshif <netdev>\fP] \fBloglevel\fP|\fBll\fP [\fBlevel\fP[ \fBlevel\fP[ \fBlevel\fP]] \fB...\fP]"
+.TP
+[\fBmeshif <netdev>\fP] \fBloglevel\fP|\fBll\fP [\fBlevel\fP[ \fBlevel\fP[ \fBlevel\fP]] \fB...\fP]
 If no parameter is given the current log level settings are displayed otherwise the parameter(s) is/are used to set the log
 level. Level 'none' disables all verbose logging. Level 'batman' enables messages related to routing / flooding / broadcasting.
 Level 'routes' enables messages related to routes being added / changed / deleted. Level 'tt' enables messages related to
@@ -136,8 +139,8 @@ messages related to ARP snooping and the Distributed Arp Table. Level 'nc' enabl
 Level 'mcast' enables messages related to multicast optimizations. Level 'tp' enables messages related to throughput meter.
 Level 'all' enables all messages. The messages are sent to the kernels trace buffers. Use \fBtrace-cmd stream -e batadv:batadv_dbg\fP
 to receive the system wide log messages.
-.br
-.IP "[\fBmeshif <netdev>\fP] \fBgw_mode|gw\fP [\fBoff\fP|\fBclient\fP|\fBserver\fP] [\fBsel_class|bandwidth\fP]\fP"
+.TP
+[\fBmeshif <netdev>\fP] \fBgw_mode|gw\fP [\fBoff\fP|\fBclient\fP|\fBserver\fP] [\fBsel_class|bandwidth\fP]\fP
 If no parameter is given the current gateway mode is displayed otherwise the parameter is used to set the gateway mode. The
 second (optional) argument specifies the selection class (if 'client' was the first argument) or the gateway bandwidth (if 'server'
 was the first argument). If the node is a server this parameter is used to inform other nodes in the network about
@@ -203,19 +206,20 @@ gateway or the maximum bandwidth across the entire path.
 .RE
 .RE
 .br
-.IP "\fBrouting_algo\fP|\fBra\fP [\fBalgorithm\fP]\fP"
+.TP
+\fBrouting_algo\fP|\fBra\fP [\fBalgorithm\fP]\fP
 If no parameter is given the current routing algorithm configuration as well as
 supported routing algorithms are displayed.
 Otherwise the parameter is used to select the routing algorithm for the following
 batX interface to be created.
-.br
-.IP "\fBhardif <hardif>\fP \fBthroughput_override|to\fP [\fBbandwidth\fP]\fP"
+.TP
+\fBhardif <hardif>\fP \fBthroughput_override|to\fP [\fBbandwidth\fP]\fP
 If no parameter is given the current througput override is displayed otherwise
 the parameter is used to set the throughput override for the specified hard
 interface.
 Just enter any number (optionally followed by "kbit" or "mbit").
-.br
-.IP "[\fBmeshif <netdev>\fP] \fBisolation_mark\fP|\fBmark\fP"
+.TP
+[\fBmeshif <netdev>\fP] \fBisolation_mark\fP|\fBmark\fP
 If no parameter is given the current isolation mark value is displayed.
 Otherwise the parameter is used to set or unset the isolation mark used by the
 Extended Isolation feature.
@@ -234,10 +238,8 @@ Example 2: 0x00040000/0xffff0000
 .br
 Example 3: 16 or 0x0F
 .br
-.br
-.PP
-.I \fBdebug tables:
-.IP
+.TP
+\fBdebug tables:\fP
 The batman-adv kernel module comes with a variety of debug tables containing various information about the state of the mesh
 seen by each individual node.
 
@@ -291,9 +293,8 @@ List of debug tables:
 .RE
 .br
 .br
-.PP
-.I \fBJSON queries:
-.IP
+.TP
+\fBJSON queries:\fP
 The generic netlink family provided by the batman-adv kernel module can be
 queried (read-only) by batctl and automatically translated to JSON. This
 can be used to monitor the state of the system without the need of parsing
@@ -342,13 +343,13 @@ List of available JSON queries:
 \- vlan_json|vj
 .RE
 .RE
-.br
-.IP "[\fBmeshif <netdev>\fP] \fBtranslate\fP|\fBt\fP \fBMAC_address\fP|\fBbat\-host_name\fP|\fBhost_name\fP|\fBIP_address\fP"
+.TP
+[\fBmeshif <netdev>\fP] \fBtranslate\fP|\fBt\fP \fBMAC_address\fP|\fBbat\-host_name\fP|\fBhost_name\fP|\fBIP_address\fP
 
 Translates a destination (hostname, IP, MAC, bat_host-name) to the originator
 mac address responsible for it.
-.br
-.IP "[\fBmeshif <netdev>\fP] \fBstatistics\fP|\fBs\fP"
+.TP
+[\fBmeshif <netdev>\fP] \fBstatistics\fP|\fBs\fP
 Retrieve traffic counters from batman-adv kernel module. The output may vary depending on which features have been compiled
 into the kernel module.
 .br
@@ -362,8 +363,8 @@ tt - translation table counters
 .RS 7
 All counters without a prefix concern payload (pure user data) traffic.
 .RE
-.br
-.IP "[\fBmeshif <netdev>\fP] \fBping\fP|\fBp\fP [\fB\-c count\fP][\fB\-i interval\fP][\fB\-t time\fP][\fB\-R\fP][\fB\-T\fP] \fBMAC_address\fP|\fBbat\-host_name\fP|\fBhost_name\fP|\fBIP_address\fP"
+.TP
+[\fBmeshif <netdev>\fP] \fBping\fP|\fBp\fP [\fB\-c count\fP][\fB\-i interval\fP][\fB\-t time\fP][\fB\-R\fP][\fB\-T\fP] \fBMAC_address\fP|\fBbat\-host_name\fP|\fBhost_name\fP|\fBIP_address\fP
 Layer 2 ping of a MAC address or bat\-host name.  batctl will try to find the bat\-host name if the given parameter was
 not a MAC address. It can also try to guess the MAC address using an IPv4/IPv6 address or a hostname when
 the IPv4/IPv6 address was configured on top of the batman-adv interface of the destination device and both source and
@@ -373,8 +374,8 @@ option batctl will continue pinging without end. Use CTRL + C to stop it.  With
 interval between pings and the timeout time for replies, both in seconds. When run with "\-R", the route taken by the ping
 messages will be recorded. With "\-T" you can disable the automatic translation of a client MAC address to the originator
 address which is responsible for this client.
-.br
-.IP "[\fBmeshif <netdev>\fP] \fBtraceroute\fP|\fBtr\fP [\fB\-n\fP][\fB\-T\fP] \fBMAC_address\fP|\fBbat\-host_name\fP|\fBhost_name\fP|\fBIP_address\fP"
+.TP
+[\fBmeshif <netdev>\fP] \fBtraceroute\fP|\fBtr\fP [\fB\-n\fP][\fB\-T\fP] \fBMAC_address\fP|\fBbat\-host_name\fP|\fBhost_name\fP|\fBIP_address\fP
 Layer 2 traceroute to a MAC address or bat\-host name. batctl will try to find the bat\-host name if the given parameter
 was not a MAC address. It can also try to guess the MAC address using an IPv4/IPv6 address or a hostname when
 the IPv4/IPv6 address was configured on top of the batman-adv interface of the destination device and both source and
@@ -382,8 +383,8 @@ destination devices are in the same IP subnet.
 batctl will send 3 packets to each host and display the response time. If "\-n" is given batctl will
 not replace the MAC addresses with bat\-host names in the output. With "\-T" you can disable the automatic translation
 of a client MAC address to the originator address which is responsible for this client.
-.br
-.IP "\fBtcpdump\fP|\fBtd\fP [\fB\-c\fP][\fB\-n\fP][\fB\-p filter\fP][\fB\-x filter\fP] \fBinterface ...\fP"
+.TP
+\fBtcpdump\fP|\fBtd\fP [\fB\-c\fP][\fB\-n\fP][\fB\-p filter\fP][\fB\-x filter\fP] \fBinterface ...\fP
 batctl will display all packets that are seen on the given interface(s). A variety of options to filter the output
 are available: To only print packets that match the compatibility number of batctl specify the "\-c" (compat filter)
 option. If "\-n" is given batctl will not replace the MAC addresses with bat\-host names in the output. To filter
@@ -416,8 +417,8 @@ except specified). The following packet types are available:
 .RS 7
 Example: batctl td <interface> \-p 129 \-> only display batman ogm packets and non batman packets
 .RE
-.br
-.IP "\fBbisect_iv\fP [\fB\-l MAC\fP][\fB\-t MAC\fP][\fB\-r MAC\fP][\fB\-s min\fP [\fB\- max\fP]][\fB\-o MAC\fP][\fB\-n\fP] \fBlogfile1\fP [\fBlogfile2\fP ... \fBlogfileN\fP]"
+.TP
+\fBbisect_iv\fP [\fB\-l MAC\fP][\fB\-t MAC\fP][\fB\-r MAC\fP][\fB\-s min\fP [\fB\- max\fP]][\fB\-o MAC\fP][\fB\-n\fP] \fBlogfile1\fP [\fBlogfile2\fP ... \fBlogfileN\fP]
 Analyses the B.A.T.M.A.N. IV logfiles to build a small internal database of all sent sequence numbers and routing table
 changes. This database can then be analyzed in a number of different ways. With "\-l" the database can be used to search
 for routing loops. Use "\-t" to trace OGMs of a host throughout the network. Use "\-r" to display routing tables of the
@@ -425,8 +426,8 @@ nodes. The option "\-s" can be used to limit the output to a range of sequence n
 specific sequence number, min. Furthermore using "\-o" you can filter the output to a specified originator. If "\-n" is
 given batctl will not replace the MAC addresses with bat\-host names in the output.
 .RE
-.br
-.IP "[\fBmeshif <netdev>\fP] \fBthroughputmeter\fP|\fBtp\fP \fBMAC\fP"
+.TP
+[\fBmeshif <netdev>\fP] \fBthroughputmeter\fP|\fBtp\fP \fBMAC\fP
 This command starts a throughput test entirely controlled by batman module in
 kernel space: the computational resources needed to align memory and copy data
 between user and kernel space that are required by other user space tools may
@@ -441,11 +442,10 @@ of a successful experiment the throughput in KBytes per second is returned,
 together with the experiment duration in millisecond and the amount of bytes
 transferred. If too many packets are lost or the specified MAC address is not
 reachable, a message notifying the error is returned instead of the result.
-.RE
-.br
+
 .SH FILES
 .TP
-.I "\fBbat-hosts\fP"
+\fBbat-hosts\fP
 This file is similar to the /etc/hosts file. You can write one MAC address and one host name per line. batctl will search
 for bat-hosts in /etc, your home directory and the current directory. The found data is used to match MAC address to your
 provided host name or replace MAC addresses in debug output and logs. Host names are much easier to remember than MAC
-- 
2.30.2

