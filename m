Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Mon, 15 Mar 2010 09:03:06 +0800
Message-Id: <1268614986-17280-3-git-send-email-lindner_marek@yahoo.de>
In-Reply-To: <201003150902.33262.lindner_marek@yahoo.de>
References: <201003150902.33262.lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCH 3/3] batctl: update man page
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.net
Cc: Marek Lindner <lindner_marek@yahoo.de>

Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
---
 batctl/man/batctl.8 |  138 ++++++++++++++++++++++++++++----------------------
 1 files changed, 77 insertions(+), 61 deletions(-)

diff --git a/batctl/man/batctl.8 b/batctl/man/batctl.8
index 43fce87..43af853 100644
--- a/batctl/man/batctl.8
+++ b/batctl/man/batctl.8
@@ -53,53 +53,78 @@ protocol.
 .br
 .TP
 .I \fBcommands:
-.IP "\fBinterface\fP|\fBif\fP   [\fBnone\fP|\fIinterface\fP]"
+.IP "\fBinterface\fP|\fBif\fP     [\fBnone\fP|\fBinterface\fP]"
 If no parameter is given the current interface settings are displayed
 otherwise the parameter(s) are added as new interfaces. Use the "none"
 keyword to deactivate all interfaces.
 .br
-.IP "\fBoriginators\fP|\fBo\fP   [\fB\-b\fP][\fB\-n\fP]"
-Display the originator table. Once started batctl will refresh the
-displayed originator table every second. The "\-b" option causes the
-table to be displayed only once (useful for scripts). If "\-n" is
-given batctl will not replace the MAC addresses with bat\-host names
-in the output.
-.br
-.IP "\fBinterval\fP|\fBit\fP    [\fIorig_interval\fP]"
-If no parameter is given the current originator interval setting is
-displayed otherwise the parameter is used to set the originator
-interval. The interval is in units of milliseconds.
-.br
-.IP "\fBloglevel\fP|\fBll\fP    [\fIlevel\fP]"
-If no parameter is given the current log level settings are displayed
-otherwise the parameter is used to set the log level. Level 0 disables
-all logging. Level 1 enables messages related to routing / flooding /
-broadcasting. Level 2 enables messages related to route or hna added /
-changed / deleted. Level 3 enables all messages. The messages are sent
-to the kernel log. Use \fBdmesg\fP(1) to see them.
-.br
-.IP "\fBlog\fP|\fBl\fP           [\fIlogfile\fP][\fB\-b\fP][\fB\-n\fP]\fP"
-batctl will read the file logfile, or stdin if the logfile parameter
-is not given, applying filtering so only the B.A.T.M.A.N. Advanced
-messages are displayed. Whenever there are new log messages appended
-to the file batctl will display them. The option "\-b" causes batctl
-to exit once the end of the file has been reached. If "\-n" is given
-batctl will not replace the MAC addresses with bat\-host names in the
-output.
-.br
-.IP "\fBtranslocal\fP|\fBtl\fP   [\fB\-b\fP][\fB\-n\fP]"
-Display the local translation table. batctl will refresh the
-displayed table every second. The "\-b" option causes the table to be
-displayed only once (useful for scripts). If "\-n" is given batctl
-will not replace the MAC addresses with bat\-host names in the output.
-.br
-.IP "\fBtransglobal\fP|\fBtg\fP  [\fB\-b\fP][\fB\-n\fP]"
-Display the global translation table. batctl will refresh the
-displayed table every second. The "\-b" option causes the table to be
-displayed only once (useful for scripts). If "\-n" is given batctl
-will not replace the MAC addresses with bat\-host names in the output.
-.br
-.IP "\fBvis dot\fP         [\fB\-n\fP|\fB\-\-numbers\fP][\fB\-H\fP|\fB\-\-no-HNA\fP][\fB\-2\fP|\fB\-\-no-2nd\fP]"
+.IP "\fBoriginators\fP|\fBo\fP    [\fB\-b\fP][\fB\-n\fP]"
+Once started batctl will display the list of announced gateways in the network. Use the "\-w" option to let batctl refresh the list every second. If "\-n" is given batctl will not replace the MAC addresses with bat\-host names in the output.
+.br
+.IP "\fBinterval\fP|\fBit\fP      [\fBorig_interval\fP]"
+If no parameter is given the current originator interval setting is displayed otherwise the parameter is used to set the originator interval. The interval is in units of milliseconds.
+.br
+.IP "\fBloglevel\fP|\fBll\fP      [\fBlevel\fP]"
+If no parameter is given the current log level settings are displayed otherwise the parameter is used to set the log level. Level 0 disables all logging. Level 1 enables messages related to routing / flooding / broadcasting. Level 2 enables messages related to route or hna added / changed / deleted. Level 3 enables all messages. The messages are sent to the kernel log. Use \fBdmesg\fP(1) to see them. Make sure to have debugging output enabled when compiling the module otherwise the output as well as the loglevel options won't be available.
+.br
+.IP "\fBlog\fP|\fBl\fP            [\fBlogfile\fP][\fB\-b\fP][\fB\-n\fP]\fP"
+batctl will read the file logfile, or stdin if the logfile parameter is not given, applying filtering so only the B.A.T.M.A.N. Advanced messages are displayed. Once the end of the file has been reached batctl will exit unless the option "\-w" was specified which causes batctl to continue reading the file and print log output whenever new log data has been appended to the file.
+.br
+.IP "\fBgw_mode|gw\fP       [\fBoff\fP|\fBclient\fP|\fBserver\fP] [\fBgw_class\fP]\fP"
+If no parameter is given the current gateway mode is displayed otherwise the parameter is used to set the gateway mode. The second (optional) argument specifies the gateway class. Its function depends on whether the node is a server or a client. If the node is a server this parameter is used to inform other nodes in the network about this node's internet connection bandwidth. Just enter any number (optionally followed by "kbit" or "mbit") and the batman-adv module will guess your appropriate gateway class. Use "/" to separate the down\(hy and upload rates. You can omit the upload rate and the module will assume an upload of download / 5.
+.RS 17
+default: 2000 \-> gateway class 20
+.RE
+.RS 16
+examples: 5000 \-> gateway class 49
+.RE
+.RS 25
+ 5000kbit
+ 5mbit
+ 5mbit/1024
+ 5mbit/1024kbit
+ 5mbit/1mbit
+.RE
+.RS 7
+If the node is a gateway client the parameter will decide which criterias to consider when the batman-adv module has to choose between different internet connections announced by the aforementioned servers.
+.RE
+.RS 17
+default: 20 \-> late switch (TQ 20)
+.RE
+.RS 16
+examples:  1 -> fast connection
+.RS 16
+consider the gateway's advertised throughput as well as the link quality towards the gateway
+.RE
+.RE
+.RS 25
+ 2  \-> stable connection
+.RS 7
+chooses the gateway with the best link quality and stick with it (ignore the advertised throughput)
+.RE
+ 3  \-> fast switch connection
+.RS 7
+chooses the gateway with the best link quality but switches to another gateway as soon as a better one is found
+.RE
+ XX \-> late switch connection
+.RS 7
+chooses the gateway with the best link quality but switches to another gateway as soon as a better one is found which is at least XX TQ better than the currently selected gateway (XX has to be a number between 3 and 256).
+.RE
+.RE
+.br
+.IP "\fBgateways|gwl\fP     [\fB\-w\fP][\fB\-n\fP]"
+Once started batctl will display the list of announced gateways in the network. Use the "\-w" option to let batctl refresh the list every second. If "\-n" was given batctl will not replace the mac addresses with bat\-host names in the output.
+.br
+.IP "\fBtranslocal\fP|\fBtl\fP    [\fB\-w\fP][\fB\-n\fP]"
+Display the local translation table. batctl will refresh the displayed table every second if the "\-w" option was given. Use "\-n" to let batctl not replace the MAC addresses with bat\-host names in the output.
+.br
+.IP "\fBtransglobal\fP|\fBtg\fP   [\fB\-w\fP][\fB\-n\fP]"
+Display the global translation table. batctl will refresh the displayed table every second if the "\-w" option was given. Use "\-n" to let batctl not replace the MAC addresses with bat\-host names in the output.
+.br
+.IP "\fBvis_mode|vm\fP	  [\fBmode\fP]\fP"
+If no parameter is given the current vis mode is displayed otherwise the parameter is used to set the vis mode.
+.br
+.IP "\fBvis_data|vd dot\fP  [\fB\-n\fP|\fB\-\-numbers\fP][\fB\-H\fP|\fB\-\-no-HNA\fP][\fB\-2\fP|\fB\-\-no-2nd\fP]"
 Display the visualisation data in graphviz \fBdot\fP(1) format. If
 "\-\-numbers" or "\-n" is given batctl will not replace the MAC
 addresses with bat-host names in the output. With "\-\-no-HNA" or
@@ -107,7 +132,7 @@ addresses with bat-host names in the output. With "\-\-no-HNA" or
 be seen. With "\-\-no-2nd" or "\-2" a dot cluster is not formed around
 primary and secondary addresses from the same device.
 .br
-.IP "\fBvis json\fP        [\fB\-n\fP|\fB\-\-numbers\fP][\fB\-H\fP|\fB\-\-no-HNA\fP][\fB\-2\fP|\fB\-\-no-2nd\fP]"
+.IP "\fBvis_data|vd json\fP [\fB\-n\fP|\fB\-\-numbers\fP][\fB\-H\fP|\fB\-\-no-HNA\fP][\fB\-2\fP|\fB\-\-no-2nd\fP]"
 Display the visualisation data in JSON format. If "\-\-numbers" or
 "\-n" is given batctl will not replace the MAC addresses with bat-host
 names in the output. With "\-\-no-HNA" or "\-H" the HNA entries are
@@ -115,22 +140,13 @@ not displayed, so the pure mesh topology can be seen. With
 "\-\-no-2nd" or "\-2" a dot cluster is not formed around primary and
 secondary addresses from the same device.
 .br
-.IP "\fBgw_mode|gw	[off|client|server]\fP"
-If no parameter is given the current gateway mode is displayed otherwise the parameter is used to set the gateway mode.
+.IP "\fBaggregation\fP|\fBag\fP   [\fB1\fP|\fB0\fP]"
+If no parameter is given the current aggregation setting is displayed. Otherwise the parameter is used to enable or disable packet aggregation.
 .br
-.IP "\fBgw_srv_list|gwl\fP"
-Once started batctl will refresh the displayed gateway server list every second. Use the "\-b" option to let batctl display the list only once (useful for scripts). If "\-n" was given batctl will not replace the mac addresses with bat\-host names in the output.
+.IP "\fBbonding\fP|\fBb\fP        [\fB1\fP|\fB0\fP]"
+If no parameter is given the current bonding mode setting is displayed. Otherwise the parameter is used to enable or disable the bonding mode.
 .br
-.IP "\fBaggregation\fP|\fBag\fP [\fB1\fP|\fB0\fP]"
-If no parameter is given the current aggregation setting is displayed.
-Otherwise the parameter is used to enable or disable packet
-aggregation.
-.br
-.IP "\fBbonding\fP|\fBb\fP [\fB1\fP|\fB0\fP]"
-If no parameter is given the current bonding mode setting is displayed.
-Otherwise the parameter is used to enable or disable the bonding mode.
-.br
-.IP "\fBping\fP|\fBp\fP [\fB\-c \fP\fIcount\fP][\fB\-i \fP\fIinterval\fP][\fB\-t \fP\fItime\fP][\fB\-R\fP] \fIMAC_address\fP|\fIbat\-host_name\fP"
+.IP "\fBping\fP|\fBp\fP           [\fB\-c count\fP][\fB\-i interval\fP][\fB\-t time\fP][\fB\-R\fP] \fBMAC_address\fP|\fBbat\-host_name\fP"
 Layer 2 ping of a MAC address or bat\-host name.  batctl will try to
 find the bat\-host name if the given parameter was not a MAC
 address. The "\-c" option tells batctl how man pings should be sent
@@ -140,14 +156,14 @@ you can set the default interval between pings and the timeout time
 for replies, both in seconds. When run with "\-R", the route taken by
 the ping messages will be recorded.
 .br
-.IP "\fBtraceroute\fP|\fBtr\fP  [\fB\-n\fP] \fIMAC_address\fP|\fIbat\-host_name\fP"
+.IP "\fBtraceroute\fP|\fBtr\fP    [\fB\-n\fP] \fBMAC_address\fP|\fBbat\-host_name\fP"
 Layer 2 traceroute to a MAC address or bat\-host name. batctl will try
 to find the bat\-host name if the given parameter was not a MAC
 address. batctl will send 3 packets to each host and display the
 response time. If "\-n" is given batctl will not replace the MAC
 addresses with bat\-host names in the output.
 .br
-.IP "\fBtcpdump\fP|\fBtd\fP     [\fB\-p \fP\fIfilter\fP][\fB\-n\fP] \fIinterface ...\fP"
+.IP "\fBtcpdump\fP|\fBtd\fP       [\fB\-p filter\fP][\fB\-n\fP] \fBinterface ...\fP"
 batctl will display all packets that are seen on the given
 interface(s). The "\-p" options allows the filtering of certain packet
 types: 1 - batman ogm packets, 2 - batman icmp packets, 4 - unicast
@@ -157,7 +173,7 @@ type, e.g. use "\-p 3" to display batman ogm packets and batman icmp
 packets only. If "\-n" is given batctl will not replace the MAC
 addresses with bat\-host names in the output.
 .br
-.IP "\fBbisect\fP               [\fB\-l \fP\fIMAC\fP][\fB\-t \fP\fIMAC\fP][\fB\-r \fP\fIMAC\fP][\fB\-s \fP\fImin\fP [\fB\- \fP\fImax\fP]][\fB\-o \fP\fIMAC\fP][\fB\-n\fP] \fIlogfile1\fP [\fIlogfile2\fP ... \fIlogfileN\fP]"
+.IP "\fBbisect\fP           [\fB\-l MAC\fP][\fB\-t MAC\fP][\fB\-r MAC\fP][\fB\-s min\fP [\fB\- max\fP]][\fB\-o MAC\fP][\fB\-n\fP] \fBlogfile1\fP [\fBlogfile2\fP ... \fBlogfileN\fP]"
 Analyses the logfiles to build a small internal database of all sent
 sequence numbers and routing table changes. This database can then be
 analyzed in a number of different ways. With "\-l" the database can be
-- 
1.7.0

