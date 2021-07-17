Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 8/9] batctl: man: Reorder and restructure sections
Date: Sat, 17 Jul 2021 13:01:28 +0200
Message-Id: <20210717110129.25539-9-sven@narfation.org>
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

The number of subcommands in batctl increased dramatically in the recent
years. But the documentation to the various commands was just added to
random positions in the manpage. This made it harder than necessary to look
things up.

This can be improved by:

* split the subcommand types in different classes to keep similar
  functionality next to each other
* order subcommands alphabetically

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 man/batctl.8 | 441 ++++++++++++++++++++++++++-------------------------
 1 file changed, 221 insertions(+), 220 deletions(-)

diff --git a/man/batctl.8 b/man/batctl.8
index 4cc55f9..1470beb 100644
--- a/man/batctl.8
+++ b/man/batctl.8
@@ -55,6 +55,19 @@ print batctl version and batman-adv version (if the module is loaded)
 
 .SH COMMANDS
 
+.TP
+\fBbisect_iv\fP [\fB\-l MAC\fP][\fB\-t\fP \fIMAC\fP][\fB\-r\fP \fIMAC\fP][\fB\-s\fP \fImin\fP [\- \fImax\fP]][\fB\-o\fP \fIMAC\fP][\fB\-n\fP] \fIlogfile1\fP ...
+Analyses the B.A.T.M.A.N. IV logfiles to build a small internal database of all sent sequence numbers and routing table
+changes. This database can then be analyzed in a number of different ways. With "\-l" the database can be used to search
+for routing loops. Use "\-t" to trace OGMs of a host throughout the network. Use "\-r" to display routing tables of the
+nodes. The option "\-s" can be used to limit the output to a range of sequence numbers, between min and max, or to one
+specific sequence number, min. Furthermore using "\-o" you can filter the output to a specified originator. If "\-n" is
+given batctl will not replace the MAC addresses with bat\-host names in the output.
+.RE
+.TP
+\fBevent\fP|\fBe\fP [\fB\-t\fP|\fB\-r\fP]
+batctl will monitor for events from the netlink kernel interface of batman-adv. The local timestamp of the event will be printed
+when parameter \fB\-t\fP is specified. Parameter \fB\-r\fP will do the same but with relative timestamps.
 .TP
 [\fBmeshif\fP \fInetdev\fP] \fBinterface\fP|\fBif\fP
 .TQ
@@ -72,9 +85,112 @@ can be used to overwrite the (default) routing algorithm.
 [\fBmeshif\fP \fInetdev\fP] \fBinterface\fP|\fBif\fP \fBdestroy\fP
 Remove all attached interfaces and destroy the batman-adv interface.
 .TP
-[\fBmeshif\fP \fInetdev\fP] \fBorig_interval\fP|\fBit\fP [\fIinterval\fP]
-If no parameter is given the current originator interval setting is displayed otherwise the parameter is used to set the
-originator interval. The interval is in units of milliseconds.
+[\fBmeshif\fP \fInetdev\fP] \fBping\fP|\fBp\fP [\fB\-c\fP \fIcount\fP][\fB\-i\fP \fIinterval\fP][\fB\-t\fP \fItime\fP][\fB\-R\fP][\fB\-T\fP] \fIMAC_address\fP|\fIbat\-host_name\fP|\fIhost_name\fP|\fIIP_address\fP
+Layer 2 ping of a MAC address or bat\-host name.  batctl will try to find the bat\-host name if the given parameter was
+not a MAC address. It can also try to guess the MAC address using an IPv4/IPv6 address or a hostname when
+the IPv4/IPv6 address was configured on top of the batman-adv interface of the destination device and both source and
+destination devices are in the same IP subnet.
+The "\-c" option tells batctl how man pings should be sent before the program exits. Without the "\-c"
+option batctl will continue pinging without end. Use CTRL + C to stop it.  With "\-i" and "\-t" you can set the default
+interval between pings and the timeout time for replies, both in seconds. When run with "\-R", the route taken by the ping
+messages will be recorded. With "\-T" you can disable the automatic translation of a client MAC address to the originator
+address which is responsible for this client.
+.TP
+\fBrouting_algo\fP|\fBra\fP [\fIalgorithm\fP]
+If no parameter is given the current routing algorithm configuration as well as
+supported routing algorithms are displayed.
+Otherwise the parameter is used to select the routing algorithm for the following
+batX interface to be created.
+.TP
+[\fBmeshif\fP \fInetdev\fP] \fBstatistics\fP|\fBs\fP
+Retrieve traffic counters from batman-adv kernel module. The output may vary depending on which features have been compiled
+into the kernel module.
+.br
+Each module subsystem has its own counters which are indicated by their prefixes:
+.TS
+tab (@);
+r lx.
+mgmt@T{
+mesh protocol counters
+T}
+tt@T{
+translation table counters
+T}
+.TE
+All counters without a prefix concern payload (pure user data) traffic.
+.TP
+\fBtcpdump\fP|\fBtd\fP [\fB\-c\fP][\fB\-n\fP][\fB\-p\fP \fIfilter\fP][\fB\-x\fP \fIfilter\fP] \fBinterface ...\fP
+batctl will display all packets that are seen on the given interface(s). A variety of options to filter the output
+are available: To only print packets that match the compatibility number of batctl specify the "\-c" (compat filter)
+option. If "\-n" is given batctl will not replace the MAC addresses with bat\-host names in the output. To filter
+the shown packet types you can either use "\-p" (dump only specified packet types) or "\-x" (dump all packet types
+except specified). The following packet types are available:
+
+.TS
+tab (@);
+r lx.
+1@T{
+batman ogm packets
+T}
+2@T{
+batman icmp packets
+T}
+4@T{
+batman unicast packets
+T}
+8@T{
+batman broadcast packets
+T}
+16@T{
+batman unicast tvlv packets
+T}
+32@T{
+batman fragmented packets
+T}
+64@T{
+batman tt / roaming packets
+T}
+128@T{
+non batman packets
+T}
+.TE
+Example: batctl td <interface> \-p 129 \-> only display batman ogm packets and non batman packets
+.TP
+[\fBmeshif\fP \fInetdev\fP] \fBthroughputmeter\fP|\fBtp\fP \fIMAC\fP
+This command starts a throughput test entirely controlled by batman module in
+kernel space: the computational resources needed to align memory and copy data
+between user and kernel space that are required by other user space tools may
+represent a bottleneck on some low profile device.
+
+The test consist of the transfer of 14 MB of data between the two nodes. The
+protocol used to transfer the data is somehow similar to TCP, but simpler: some
+TCP features are still missing, thus protocol performances could be worst. Since
+a fixed amount of data is transferred the experiment duration depends on the
+network conditions. The experiment can be interrupted with CTRL + C. At the end
+of a successful experiment the throughput in KBytes per second is returned,
+together with the experiment duration in millisecond and the amount of bytes
+transferred. If too many packets are lost or the specified MAC address is not
+reachable, a message notifying the error is returned instead of the result.
+.TP
+[\fBmeshif\fP \fInetdev\fP] \fBtraceroute\fP|\fBtr\fP [\fB\-n\fP][\fB\-T\fP] \fIMAC_address\fP|\fIbat\-host_name\fP|\fIhost_name\fP|\fIIP_address\fP
+Layer 2 traceroute to a MAC address or bat\-host name. batctl will try to find the bat\-host name if the given parameter
+was not a MAC address. It can also try to guess the MAC address using an IPv4/IPv6 address or a hostname when
+the IPv4/IPv6 address was configured on top of the batman-adv interface of the destination device and both source and
+destination devices are in the same IP subnet.
+batctl will send 3 packets to each host and display the response time. If "\-n" is given batctl will
+not replace the MAC addresses with bat\-host names in the output. With "\-T" you can disable the automatic translation
+of a client MAC address to the originator address which is responsible for this client.
+.TP
+[\fBmeshif\fP \fInetdev\fP] \fBtranslate\fP|\fBt\fP \fIMAC_address\fP|\fIbat\-host_name\fP|\fIhost_name\fP|\fIIP_address\fP
+Translates a destination (hostname, IP, MAC, bat_host-name) to the originator
+mac address responsible for it.
+
+.SH SETTINGS
+
+.TP
+[\fBmeshif\fP \fInetdev\fP] \fBaggregation\fP|\fBag\fP [\fI0\fP|\fI1\fP]
+If no parameter is given the current aggregation setting is displayed. Otherwise the parameter is used to enable or disable
+OGM packet aggregation.
 .TP
 [\fBmeshif\fP \fInetdev\fP] \fBap_isolation\fP|\fBap\fP [\fI0\fP|\fI1\fP]
 If no parameter is given the current ap isolation setting is displayed. Otherwise the parameter is used to enable or
@@ -88,6 +204,10 @@ disable ap isolation.
 If no parameter is given the current ap isolation setting for the specified VLAN is displayed. Otherwise the parameter is used to enable or
 disable ap isolation for the specified VLAN.
 .TP
+[\fBmeshif\fP \fInetdev\fP] \fBbonding\fP|\fBb\fP [\fI0\fP|\fI1\fP]
+If no parameter is given the current bonding mode setting is displayed. Otherwise the parameter is used to enable or disable
+the bonding mode.
+.TP
 [\fBmeshif\fP \fInetdev\fP] \fBbridge_loop_avoidance\fP|\fBbl\fP [\fI0\fP|\fI1\fP]
 If no parameter is given the current bridge loop avoidance setting is displayed. Otherwise the parameter is used to enable
 or disable the bridge loop avoidance. Bridge loop avoidance support has to be enabled when compiling the module otherwise
@@ -97,18 +217,6 @@ this option won't be available.
 If no parameter is given the current distributed arp table setting is displayed. Otherwise the parameter is used to
 enable or disable the distributed arp table.
 .TP
-[\fBmeshif\fP \fInetdev\fP] \fBaggregation\fP|\fBag\fP [\fI0\fP|\fI1\fP]
-If no parameter is given the current aggregation setting is displayed. Otherwise the parameter is used to enable or disable
-OGM packet aggregation.
-.TP
-[\fBmeshif\fP \fInetdev\fP] \fBbonding\fP|\fBb\fP [\fI0\fP|\fI1\fP]
-If no parameter is given the current bonding mode setting is displayed. Otherwise the parameter is used to enable or disable
-the bonding mode.
-.TP
-\fBevent\fP|\fBe\fP [\fB\-t\fP|\fB\-r\fP]
-batctl will monitor for events from the netlink kernel interface of batman-adv. The local timestamp of the event will be printed
-when parameter \fB\-t\fP is specified. Parameter \fB\-r\fP will do the same but with relative timestamps.
-.TP
 \fBhardif\fP \fIhardif\fP \fBelp_interval\fP|\fBet\fP [\fIinterval\fP]
 If no parameter is given the current ELP interval setting of the hard interface is displayed otherwise the parameter is used to set the
 ELP interval. The interval is in units of milliseconds.
@@ -117,39 +225,6 @@ ELP interval. The interval is in units of milliseconds.
 If no parameter is given the current fragmentation mode setting is displayed. Otherwise the parameter is used to enable or
 disable fragmentation.
 .TP
-[\fBmeshif\fP \fInetdev\fP] \fBhop_penalty\fP|\fBhp\fP [\fIpenalty\fP]
-If no parameter is given the current hop penalty setting is displayed. Otherwise the parameter is used to set the
-hop penalty. The penalty is can be 0-255 (255 sets originator message's TQ to zero when forwarded by this hop).
-.TP
-[\fBhardif\fP \fIhardif\fP] \fBhop_penalty\fP|\fBhp\fP [\fIpenalty\fP]
-If no parameter is given the current hop penalty setting of the hard interface is displayed. Otherwise the parameter is used to set the
-hop penalty. The penalty can be 0-255 (255 sets originator message's TQ to zero when forwarded over this interface).
-.TP
-[\fBmeshif\fP \fInetdev\fP] \fBnetwork_coding\fP|\fBnc\fP [\fI0\fP|\fI1\fP]
-If no parameter is given the current network coding mode setting is displayed. Otherwise the parameter is used to enable or
-disable network coding.
-.TP
-[\fBmeshif\fP \fInetdev\fP] \fBmulticast_forceflood\fP|\fBmff\fP [\fI0\fP|\fI1\fP]
-If no parameter is given the current multicast forceflood setting is displayed. Otherwise the parameter is used to enable or
-disable multicast forceflood. This setting defines whether multicast optimizations should be replaced by simple broadcast-like
-flooding of multicast packets. If set to non-zero then all nodes in the mesh are going to use classic flooding for any
-multicast packet with no optimizations.
-.TP
-[\fBmeshif\fP \fInetdev\fP] \fBmulticast_fanout\fP|\fBmo\fP [\fIfanout\fP]
-If no parameter is given the current multicast fanout setting is displayed. Otherwise the parameter is used to set
-the multicast fanout. The multicast fanout defines the maximum number of packet copies that may be generated for a
-multicast-to-unicast conversion. Once this limit is exceeded distribution will fall back to broadcast.
-.TP
-[\fBmeshif\fP \fInetdev\fP] \fBloglevel\fP|\fBll\fP [\fIlevel\fP ...]
-If no parameter is given the current log level settings are displayed otherwise the parameter(s) is/are used to set the log
-level. Level 'none' disables all verbose logging. Level 'batman' enables messages related to routing / flooding / broadcasting.
-Level 'routes' enables messages related to routes being added / changed / deleted. Level 'tt' enables messages related to
-translation table operations. Level 'bla' enables messages related to the bridge loop avoidance. Level 'dat' enables
-messages related to ARP snooping and the Distributed Arp Table. Level 'nc' enables messages related to network coding.
-Level 'mcast' enables messages related to multicast optimizations. Level 'tp' enables messages related to throughput meter.
-Level 'all' enables all messages. The messages are sent to the kernels trace buffers. Use \fBtrace-cmd stream -e batadv:batadv_dbg\fP
-to receive the system wide log messages.
-.TP
 [\fBmeshif\fP \fInetdev\fP] \fBgw_mode|gw\fP [\fBoff\fP|\fBclient\fP|\fBserver\fP] [\fIsel_class\fP|\fIbandwidth\fP]
 If no parameter is given the current gateway mode is displayed otherwise the parameter is used to set the gateway mode. The
 second (optional) argument specifies the selection class (if 'client' was the first argument) or the gateway bandwidth (if 'server'
@@ -217,17 +292,13 @@ gateway or the maximum bandwidth across the entire path.
 .RE
 .br
 .TP
-\fBrouting_algo\fP|\fBra\fP [\fIalgorithm\fP]
-If no parameter is given the current routing algorithm configuration as well as
-supported routing algorithms are displayed.
-Otherwise the parameter is used to select the routing algorithm for the following
-batX interface to be created.
+[\fBmeshif\fP \fInetdev\fP] \fBhop_penalty\fP|\fBhp\fP [\fIpenalty\fP]
+If no parameter is given the current hop penalty setting is displayed. Otherwise the parameter is used to set the
+hop penalty. The penalty is can be 0-255 (255 sets originator message's TQ to zero when forwarded by this hop).
 .TP
-\fBhardif\fP \fIhardif\fP \fBthroughput_override|to\fP [\fIbandwidth\fP]
-If no parameter is given the current througput override is displayed otherwise
-the parameter is used to set the throughput override for the specified hard
-interface.
-Just enter any number (optionally followed by "kbit" or "mbit").
+[\fBhardif\fP \fIhardif\fP] \fBhop_penalty\fP|\fBhp\fP [\fIpenalty\fP]
+If no parameter is given the current hop penalty setting of the hard interface is displayed. Otherwise the parameter is used to set the
+hop penalty. The penalty can be 0-255 (255 sets originator message's TQ to zero when forwarded over this interface).
 .TP
 [\fBmeshif\fP \fInetdev\fP] \fBisolation_mark\fP|\fBmark\fP [\fIvalue\fP[/\fImask\fP]]
 If no parameter is given the current isolation mark value is displayed.
@@ -249,22 +320,58 @@ Example 2: 0x00040000/0xffff0000
 Example 3: 16 or 0x0F
 .br
 .TP
-\fBdebug tables:\fP
+[\fBmeshif\fP \fInetdev\fP] \fBloglevel\fP|\fBll\fP [\fIlevel\fP ...]
+If no parameter is given the current log level settings are displayed otherwise the parameter(s) is/are used to set the log
+level. Level 'none' disables all verbose logging. Level 'batman' enables messages related to routing / flooding / broadcasting.
+Level 'routes' enables messages related to routes being added / changed / deleted. Level 'tt' enables messages related to
+translation table operations. Level 'bla' enables messages related to the bridge loop avoidance. Level 'dat' enables
+messages related to ARP snooping and the Distributed Arp Table. Level 'nc' enables messages related to network coding.
+Level 'mcast' enables messages related to multicast optimizations. Level 'tp' enables messages related to throughput meter.
+Level 'all' enables all messages. The messages are sent to the kernels trace buffers. Use \fBtrace-cmd stream -e batadv:batadv_dbg\fP
+to receive the system wide log messages.
+.TP
+[\fBmeshif\fP \fInetdev\fP] \fBmulticast_fanout\fP|\fBmo\fP [\fIfanout\fP]
+If no parameter is given the current multicast fanout setting is displayed. Otherwise the parameter is used to set
+the multicast fanout. The multicast fanout defines the maximum number of packet copies that may be generated for a
+multicast-to-unicast conversion. Once this limit is exceeded distribution will fall back to broadcast.
+.TP
+[\fBmeshif\fP \fInetdev\fP] \fBmulticast_forceflood\fP|\fBmff\fP [\fI0\fP|\fI1\fP]
+If no parameter is given the current multicast forceflood setting is displayed. Otherwise the parameter is used to enable or
+disable multicast forceflood. This setting defines whether multicast optimizations should be replaced by simple broadcast-like
+flooding of multicast packets. If set to non-zero then all nodes in the mesh are going to use classic flooding for any
+multicast packet with no optimizations.
+.TP
+[\fBmeshif\fP \fInetdev\fP] \fBnetwork_coding\fP|\fBnc\fP [\fI0\fP|\fI1\fP]
+If no parameter is given the current network coding mode setting is displayed. Otherwise the parameter is used to enable or
+disable network coding.
+.TP
+[\fBmeshif\fP \fInetdev\fP] \fBorig_interval\fP|\fBit\fP [\fIinterval\fP]
+If no parameter is given the current originator interval setting is displayed otherwise the parameter is used to set the
+originator interval. The interval is in units of milliseconds.
+.TP
+\fBhardif\fP \fIhardif\fP \fBthroughput_override|to\fP [\fIbandwidth\fP]
+If no parameter is given the current througput override is displayed otherwise
+the parameter is used to set the throughput override for the specified hard
+interface.
+Just enter any number (optionally followed by "kbit" or "mbit").
+
+.SH DEBUG TABLES
+
 The batman-adv kernel module comes with a variety of debug tables containing various information about the state of the mesh
 seen by each individual node.
 
 All of the debug tables support the following options:
-.RS 10
-\-w     refresh the list every second or add a number to let it refresh at a custom interval in seconds (with optional decimal places)
-.RE
-.RS 10
-\-n     do not replace the MAC addresses with bat\-host names in the output
-.RE
-.RS 10
-\-H     do not show the header of the debug table
-.RE
+.TP
+\fB-w\fP
+refresh the list every second or add a number to let it refresh at a custom interval in seconds (with optional decimal places)
+.TP
+\fB-n\fP
+do not replace the MAC addresses with bat\-host names in the output
+.TP
+\fB-H\fP
+do not show the header of the debug table
 
-.RS 7
+.PP
 The originator table also supports the "\-t" filter option to remove all originators from the output that have not been seen
 for the specified amount of seconds (with optional decimal places). It furthermore supports the "\-i" parameter to specify an
 interface for which the originator table should be printed. If this parameter is not supplied, the default originator table
@@ -272,170 +379,64 @@ is printed.
 
 The local and global translation tables also support the "\-u" and "\-m" option to only display unicast or multicast translation table announcements respectively.
 
-List of debug tables:
-.IP \(bu 2
-neighbors|n
-.IP \(bu 2
-originators|o
-.IP \(bu 2
-gateways|gwl
-.IP \(bu 2
-translocal|tl
-.IP \(bu 2
-transglobal|tg
-.IP \(bu 2
-claimtable|cl (compile time option)
-.IP \(bu 2
-backbonetable|bbt (compile time option)
-.IP \(bu 2
-dat_cache|dc (compile time option)
-.IP \(bu 2
-mcast_flags|mf (compile time option)
-.RE
-.br
-.br
 .TP
-\fBJSON queries:\fP
+[\fBmeshif\fP \fInetdev\fP] \fBbackbonetable\fP|\fBbbt\fP [\fB-n\fP] [\fB-H\fP] [\fB-w\fP \fIinterval\fP]
+(compile time option)
+.TP
+[\fBmeshif\fP \fInetdev\fP] \fBclaimtable\fP|\fBcl\fP [\fB-n\fP] [\fB-H\fP] [\fB-w\fP \fIinterval\fP]
+.TP
+[\fBmeshif\fP \fInetdev\fP] \fBdat_cache\fP|\fBdc\fP [\fB-n\fP] [\fB-H\fP] [\fB-w\fP \fIinterval\fP]
+(compile time option)
+.TP
+[\fBmeshif\fP \fInetdev\fP] \fBgateways\fP|\fBgwl\fP [\fB-n\fP] [\fB-H\fP] [\fB-w\fP \fIinterval\fP]
+.TP
+[\fBmeshif\fP \fInetdev\fP] \fBmcast_flags\fP|\fBmf\fP [\fB-n\fP] [\fB-H\fP] [\fB-w\fP \fIinterval\fP]
+(compile time option)
+.TP
+[\fBmeshif\fP \fInetdev\fP] \fBneighbors\fP|\fBn\fP [\fB-n\fP] [\fB-H\fP] [\fB-w\fP \fIinterval\fP]
+.TP
+[\fBmeshif\fP \fInetdev\fP] \fBoriginators\fP|\fBo\fP [\fB-n\fP] [\fB-H\fP] [\fB-w\fP \fIinterval\fP] [\fB-t\fP \fItimeout_interval\fP] [\fB-i\fP \fIinterface\fP]
+.TP
+[\fBmeshif\fP \fInetdev\fP] \fBtransglobal\fP|\fBtg\fP [\fB-n\fP] [\fB-H\fP] [\fB-w\fP \fIinterval\fP] [\fB-u\fP] [\fB-m\fP]
+(compile time option)
+.TP
+[\fBmeshif\fP \fInetdev\fP] \fBtranslocal\fP|\fBtl\fP [\fB-n\fP] [\fB-H\fP] [\fB-w\fP \fIinterval\fP] [\fB-u\fP] [\fB-m\fP]
+
+.SH JSON QUERIES
+
 The generic netlink family provided by the batman-adv kernel module can be
 queried (read-only) by batctl and automatically translated to JSON. This
 can be used to monitor the state of the system without the need of parsing
 the freeform debug tables or the native netlink messages.
 
-
-.RS 7
-List of available JSON queries:
-.IP \(bu 2
-bla_backbone_json|bbj
-.IP \(bu 2
-bla_claim_json|clj
-.IP \(bu 2
-dat_cache_json|dcj
-.IP \(bu 2
-gateways_json|gwj
-.IP \(bu 2
-hardif_json|hj
-.IP \(bu 2
-hardifs_json|hj
-.IP \(bu 2
-mcast_flags_json|mfj
-.IP \(bu 2
-mesh_json|mj
-.IP \(bu 2
-neighbors_json|nj
-.IP \(bu 2
-originators_json|oj
-.IP \(bu 2
-transtable_global_json|tgj
-.IP \(bu 2
-transtable_local_json|tlj
-.IP \(bu 2
-vlan_json|vj
-.RE
 .TP
-[\fBmeshif\fP \fInetdev\fP] \fBtranslate\fP|\fBt\fP \fIMAC_address\fP|\fIbat\-host_name\fP|\fIhost_name\fP|\fIIP_address\fP
-
-Translates a destination (hostname, IP, MAC, bat_host-name) to the originator
-mac address responsible for it.
+[\fBmeshif\fP \fInetdev\fP] \fBbla_backbone_json\fP|\fBbbj\fP
 .TP
-[\fBmeshif\fP \fInetdev\fP] \fBstatistics\fP|\fBs\fP
-Retrieve traffic counters from batman-adv kernel module. The output may vary depending on which features have been compiled
-into the kernel module.
-.br
-Each module subsystem has its own counters which are indicated by their prefixes:
-.TS
-tab (@);
-r lx.
-mgmt@T{
-mesh protocol counters
-T}
-tt@T{
-translation table counters
-T}
-.TE
-All counters without a prefix concern payload (pure user data) traffic.
+[\fBmeshif\fP \fInetdev\fP] \fBbla_claim_json\fP|\fBclj\fP
 .TP
-[\fBmeshif\fP \fInetdev\fP] \fBping\fP|\fBp\fP [\fB\-c\fP \fIcount\fP][\fB\-i\fP \fIinterval\fP][\fB\-t\fP \fItime\fP][\fB\-R\fP][\fB\-T\fP] \fIMAC_address\fP|\fIbat\-host_name\fP|\fIhost_name\fP|\fIIP_address\fP
-Layer 2 ping of a MAC address or bat\-host name.  batctl will try to find the bat\-host name if the given parameter was
-not a MAC address. It can also try to guess the MAC address using an IPv4/IPv6 address or a hostname when
-the IPv4/IPv6 address was configured on top of the batman-adv interface of the destination device and both source and
-destination devices are in the same IP subnet.
-The "\-c" option tells batctl how man pings should be sent before the program exits. Without the "\-c"
-option batctl will continue pinging without end. Use CTRL + C to stop it.  With "\-i" and "\-t" you can set the default
-interval between pings and the timeout time for replies, both in seconds. When run with "\-R", the route taken by the ping
-messages will be recorded. With "\-T" you can disable the automatic translation of a client MAC address to the originator
-address which is responsible for this client.
+[\fBmeshif\fP \fInetdev\fP] \fBdat_cache_json\fP|\fBdcj\fP
 .TP
-[\fBmeshif\fP \fInetdev\fP] \fBtraceroute\fP|\fBtr\fP [\fB\-n\fP][\fB\-T\fP] \fIMAC_address\fP|\fIbat\-host_name\fP|\fIhost_name\fP|\fIIP_address\fP
-Layer 2 traceroute to a MAC address or bat\-host name. batctl will try to find the bat\-host name if the given parameter
-was not a MAC address. It can also try to guess the MAC address using an IPv4/IPv6 address or a hostname when
-the IPv4/IPv6 address was configured on top of the batman-adv interface of the destination device and both source and
-destination devices are in the same IP subnet.
-batctl will send 3 packets to each host and display the response time. If "\-n" is given batctl will
-not replace the MAC addresses with bat\-host names in the output. With "\-T" you can disable the automatic translation
-of a client MAC address to the originator address which is responsible for this client.
+[\fBmeshif\fP \fInetdev\fP] \fBgateways_json\fP|\fBgwj\fP
 .TP
-\fBtcpdump\fP|\fBtd\fP [\fB\-c\fP][\fB\-n\fP][\fB\-p\fP \fIfilter\fP][\fB\-x\fP \fIfilter\fP] \fBinterface ...\fP
-batctl will display all packets that are seen on the given interface(s). A variety of options to filter the output
-are available: To only print packets that match the compatibility number of batctl specify the "\-c" (compat filter)
-option. If "\-n" is given batctl will not replace the MAC addresses with bat\-host names in the output. To filter
-the shown packet types you can either use "\-p" (dump only specified packet types) or "\-x" (dump all packet types
-except specified). The following packet types are available:
-
-.TS
-tab (@);
-r lx.
-1@T{
-batman ogm packets
-T}
-2@T{
-batman icmp packets
-T}
-4@T{
-batman unicast packets
-T}
-8@T{
-batman broadcast packets
-T}
-16@T{
-batman unicast tvlv packets
-T}
-32@T{
-batman fragmented packets
-T}
-64@T{
-batman tt / roaming packets
-T}
-128@T{
-non batman packets
-T}
-.TE
-Example: batctl td <interface> \-p 129 \-> only display batman ogm packets and non batman packets
-
+\fBhardif\fP \fIhardif\fP \fBhardif_json\fP|\fBhj\fP
 .TP
-\fBbisect_iv\fP [\fB\-l MAC\fP][\fB\-t\fP \fIMAC\fP][\fB\-r\fP \fIMAC\fP][\fB\-s\fP \fImin\fP [\- \fImax\fP]][\fB\-o\fP \fIMAC\fP][\fB\-n\fP] \fIlogfile1\fP ...
-Analyses the B.A.T.M.A.N. IV logfiles to build a small internal database of all sent sequence numbers and routing table
-changes. This database can then be analyzed in a number of different ways. With "\-l" the database can be used to search
-for routing loops. Use "\-t" to trace OGMs of a host throughout the network. Use "\-r" to display routing tables of the
-nodes. The option "\-s" can be used to limit the output to a range of sequence numbers, between min and max, or to one
-specific sequence number, min. Furthermore using "\-o" you can filter the output to a specified originator. If "\-n" is
-given batctl will not replace the MAC addresses with bat\-host names in the output.
-.RE
+[\fBmeshif\fP \fInetdev\fP] \fBhardifs_json\fP|\fBhj\fP
 .TP
-[\fBmeshif\fP \fInetdev\fP] \fBthroughputmeter\fP|\fBtp\fP \fIMAC\fP
-This command starts a throughput test entirely controlled by batman module in
-kernel space: the computational resources needed to align memory and copy data
-between user and kernel space that are required by other user space tools may
-represent a bottleneck on some low profile device.
-
-The test consist of the transfer of 14 MB of data between the two nodes. The
-protocol used to transfer the data is somehow similar to TCP, but simpler: some
-TCP features are still missing, thus protocol performances could be worst. Since
-a fixed amount of data is transferred the experiment duration depends on the
-network conditions. The experiment can be interrupted with CTRL + C. At the end
-of a successful experiment the throughput in KBytes per second is returned,
-together with the experiment duration in millisecond and the amount of bytes
-transferred. If too many packets are lost or the specified MAC address is not
-reachable, a message notifying the error is returned instead of the result.
+[\fBmeshif\fP \fInetdev\fP] \fBmcast_flags_json\fP|\fBmfj\fP
+.TP
+[\fBmeshif\fP \fInetdev\fP] \fBmesh_json\fP|\fBmj\fP
+.TP
+[\fBmeshif\fP \fInetdev\fP] \fBneighbors_json\fP|\fBnj\fP
+.TP
+[\fBmeshif\fP \fInetdev\fP] \fBoriginators_json\fP|\fBoj\fP
+.TP
+[\fBmeshif\fP \fInetdev\fP] \fBtranstable_global_json\fP|\fBtgj\fP
+.TP
+[\fBmeshif\fP \fInetdev\fP] \fBtranstable_local_json\fP|\fBtlj\fP
+.TP
+[\fBmeshif\fP \fInetdev\fP] \fBvid <vid>\fP \fBvlan_json\fP|\fBvj\fP
+.TQ
+\fBvlan\fP \fIvdev\fP \fBvlan_json\fP|\fBvj\fP
 
 .SH EXAMPLES
 The setup of a batadv interface usually consists of creation of the the main
-- 
2.30.2

