From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Fri, 24 Apr 2009 23:41:58 +0200
Message-Id: <1240609318-18133-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH] Differentiate between hyphen and minus in
	manpage
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: b.a.t.m.a.n@open-mesh.net

groff differentiate between minus signs and hyphens. The default option
is to interpret '-' as hyphens (U+2010) and makes it hard to use copy
and paste for options in UTF-8 environments.
See http://lists.debian.org/debian-devel/2003/03/msg01481.html for more
informations.

Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 batman/man/batmand.8 |   62 +++++++++++++++++++++++++-------------------------
 1 files changed, 31 insertions(+), 31 deletions(-)

diff --git a/batman/man/batmand.8 b/batman/man/batmand.8
index 263b4c3..ce5f743 100644
--- a/batman/man/batmand.8
+++ b/batman/man/batmand.8
@@ -17,28 +17,28 @@
 .\" for manpage-specific macros, see man(7)
 .TH "batmand" 8
 .SH NAME
-batmand \- better approach to mobile ad-hoc networking
+batmand \- better approach to mobile ad\(hyhoc networking
 .SH SYNOPSIS
 .B batmand
 .RI [ options ] interface [ interface ... ]
 .br
 .SH DESCRIPTION
 .B B.A.T.M.A.N
-means better approach to mobile ad-hoc networking, this is a new routing protocol for multi-hop ad-hoc mesh networks. Go to http://www.open-mesh.net/ to get more information.
+means better approach to mobile ad\(hyhoc networking, this is a new routing protocol for multi\(hyhop ad\(hyhoc mesh networks. Go to http://www.open\-mesh.net/ to get more information.
 .PP
 The following document will explain how to use the \fBbatman daemon\fP.
 .PP
-The batmand binary can be run in 2 different ways. First you need to start the daemon with "batmand [options] interface" (daemon mode) and then you can connect to that daemon to issue further commands with "batmand -c [options]" (client mode). Some of the options below are always available, some are not. See the example section to get an idea.
+The batmand binary can be run in 2 different ways. First you need to start the daemon with "batmand [options] interface" (daemon mode) and then you can connect to that daemon to issue further commands with "batmand \-c [options]" (client mode). Some of the options below are always available, some are not. See the example section to get an idea.
 .SH OPTIONS
 .TP
 .B \-a add announced network(s)
-Add networks to the daemons list of available connections to another network(s). This option can be used multiple times and can be used to add networks dynamically while the daemon is running. The parameter has to be in the form of ip-address/netmask.
+Add networks to the daemons list of available connections to another network(s). This option can be used multiple times and can be used to add networks dynamically while the daemon is running. The parameter has to be in the form of ip\(hyaddress/netmask.
 .TP
 .B \-A delete announced network(s)
-Delete networks to the daemons list of available connections to another network(s). This option can be used multiple times and can only be used while the daemon is running. The parameter has to be in the form of ip-address/netmask.
+Delete networks to the daemons list of available connections to another network(s). This option can be used multiple times and can only be used while the daemon is running. The parameter has to be in the form of ip\(hyaddress/netmask.
 .TP
 .B \-b run debug connection in batch mode
-The debug information are updated after a period of time by default, so if you use "-b" it will execute once and then stop. This option is useful for script integration of the debug output and is only available in client mode together with "-d 1" or "-d 2".
+The debug information are updated after a period of time by default, so if you use "\-b" it will execute once and then stop. This option is useful for script integration of the debug output and is only available in client mode together with "\-d 1" or "\-d 2".
 .TP
 .B \-c connect via unix socket
 Use this option to switch to client mode. Deploy it without any arguments to get the current configuration even if changed at runtime.
@@ -46,25 +46,25 @@ Use this option to switch to client mode. Deploy it without any arguments to get
 .B \-d debug level
 The debug level can be set to five values.
 .RS 17
-default: 0 -> debug disabled
+default: 0 \-> debug disabled
 .RE
 .RS 10
-allowed values: 1 -> list neighbors
+allowed values: 1 \-> list neighbors
 .RE
 .RS 25
- 2 -> list gateways
- 3 -> observe batman
- 4 -> observe batman (verbose)
- 5 -> memory debug / cpu usage
+ 2 \-> list gateways
+ 3 \-> observe batman
+ 4 \-> observe batman (verbose)
+ 5 \-> memory debug / cpu usage
 .RE
 .RS 7
 Note that debug level 5 can be disabled at compile time.
 .RE
 .TP
 .B \-g gateway class
-The gateway class is used to tell other nodes in the network your available internet bandwidth. Just enter any number (optionally followed by "kbit" or "mbit") and the daemon will guess your appropriate gateway class. Use "/" to seperate the down- and upload rates. You can omit the upload rate and batmand will assume an upload of download / 5.
+The gateway class is used to tell other nodes in the network your available internet bandwidth. Just enter any number (optionally followed by "kbit" or "mbit") and the daemon will guess your appropriate gateway class. Use "/" to seperate the down\(hy and upload rates. You can omit the upload rate and batmand will assume an upload of download / 5.
 .RS 17
-default: 0 -> gateway disabled
+default: 0 \-> gateway disabled
 .RE
 .RS 10
 allowed values: 5000
@@ -89,20 +89,20 @@ In a static network, you can save bandwidth by using a higher value.
 This option is only available in daemon mode.
 .TP
 .B \-p preferred gateway
-Set the internet gateway by yourself. Note: This automatically switches your daemon to "internet search modus" with "-r 1" unless "-r" is given. If the preferred gateway is not found the gateway selection will use the current routing class to choose a gateway.
+Set the internet gateway by yourself. Note: This automatically switches your daemon to "internet search modus" with "\-r 1" unless "\-r" is given. If the preferred gateway is not found the gateway selection will use the current routing class to choose a gateway.
 .TP
 .B \-r routing class
-The routing class can be set to four values - it enables "internet search modus". The deamon will choose an internet gateway based on certain criteria (unless "-p" is specified):
+The routing class can be set to four values \(hy it enables "internet search modus". The deamon will choose an internet gateway based on certain criteria (unless "\-p" is specified):
 .RS 17
-default: 0 -> set no default route
+default: 0 \-> set no default route
 .RE
 .RS 10
-allowed values: 1  -> use fast connection
+allowed values: 1 \-> use fast connection
 .RE
 .RS 25
- 2  -> use stable connection
- 3  -> use fast-switch connection
- XX -> use late-switch connection
+ 2  \-> use stable connection
+ 3  \-> use fast\(hyswitch connection
+ XX \-> use late\(hyswitch connection
 .RE
 .RS 7
 In level 1, B.A.T.M.A.N tries to find the best available connection by watching the uplinks throughput and the link quality.
@@ -112,34 +112,34 @@ In level XX (number between 3 and 256) B.A.T.M.A.N compares the link quality of
 .RE
 .TP
 .B \-s visualization server
-Since no topology database is computed by the protocol an additional solution to create topology graphs has been implemented, the vis server. Batman daemons may send their local view about their single-hop neighbors to the vis server. It collects the information and provides data in a format similar to OLSR's topology information output. Therefore existing solutions to draw topology graphs developed for OLSR can be used to visualize mesh-clouds using B.A.T.M.A.N.
+Since no topology database is computed by the protocol an additional solution to create topology graphs has been implemented, the vis server. Batman daemons may send their local view about their single\(hyhop neighbors to the vis server. It collects the information and provides data in a format similar to OLSR's topology information output. Therefore existing solutions to draw topology graphs developed for OLSR can be used to visualize mesh\(hyclouds using B.A.T.M.A.N.
 .TP
 .B \-v print version
 .TP
-.B \-\-disable-client-nat
-Since version 0.3.2 batmand uses iptables to set the NAT rules on the gateX interface of the batman client (-r XX). That option disables this feature of batmand and switches the internet tunnel mode to "half tunnels" (the packets towards the gateway are tunneled but not the packets that are coming back) unless NAT was enabled manually. Be sure to know what you are doing! Without NAT the gateway needs to have a route to the client or the packets will be dropped silently.
+.B \-\-disable\-client\-nat
+Since version 0.3.2 batmand uses iptables to set the NAT rules on the gateX interface of the batman client (\-r XX). That option disables this feature of batmand and switches the internet tunnel mode to "half tunnels" (the packets towards the gateway are tunneled but not the packets that are coming back) unless NAT was enabled manually. Be sure to know what you are doing! Without NAT the gateway needs to have a route to the client or the packets will be dropped silently.
 .TP
-.B \-\-policy-routing-script
-This option disables the policy routing feature of batmand - all routing changes are send to the script which can make use of this information or not. Firmware and package maintainers can use this option to tightly integrate batmand into their own routing policies. This option is only available in daemon mode.
+.B \-\-policy\-routing\-script
+This option disables the policy routing feature of batmand \(hy all routing changes are send to the script which can make use of this information or not. Firmware and package maintainers can use this option to tightly integrate batmand into their own routing policies. This option is only available in daemon mode.
 .SH EXAMPLES
 .TP
 .B batmand eth1 wlan0:test
 Start batman daemon on interface "eth1" and on alias interface "wlan0:test"
 .TP
-.B batmand -o 2000 -a 192.168.100.1/32 -a 10.0.0.0/24 eth1
+.B batmand \-o 2000 \-a 192.168.100.1/32 \-a 10.0.0.0/24 eth1
 Start batman daemon on interface "eth1" with originator interval of 2000 ms while announcing 192.168.100.1 and 10.0.0.0/24.
 .TP
-.B batmand -s 192.168.1.1 -d 1 eth1
+.B batmand \-s 192.168.1.1 \-d 1 eth1
 Start batman daemon on interface "eth1", sending topology information to 192.168.1.1 and with debug level 1 (does not fork into the background).
 .TP
-.B batmand eth1 && batmand -c -d 1 -b
+.B batmand eth1 && batmand \-c \-d 1 \-b
 Start batman daemon on interface "eth1". Connect in client mode to get the debug level 1 output once (batch mode).
 .TP
-.B batmand -g 2000kbit/500kbit eth1 && batmand -c -r 1
+.B batmand \-g 2000kbit/500kbit eth1 && batmand \-c \-r 1
 Start batman daemon on interface "eth1" as internet gateway. Connect in client mode to disable the internet gateway and enable internet search mode.
 .br
 .SH AUTHOR
-batmand was written by Marek Lindner <lindner_marek-at-yahoo.de>, Axel Neumann <axel-at-open-mesh.net>, Stefan Sperling <stsp-at-stsp.in-berlin.de>, Corinna 'Elektra' Aichele <onelektra-at-gmx.net>, Thomas Lopatic  <thomas-at-lopatic.de>, Felix Fietkau <nbd-at-nbd.name>, Ludger Schmudde <lui-at-schmudde.com>, Simon Wunderlich <siwu-at-hrz.tu-chemnitz.de>, Andreas Langer <a.langer-at-q-dsl.de>.
+batmand was written by Marek Lindner <lindner_marek\-at\-yahoo.de>, Axel Neumann <axel\-at\-open\-mesh.net>, Stefan Sperling <stsp\-at\-stsp.in\-berlin.de>, Corinna 'Elektra' Aichele <onelektra\-at\-gmx.net>, Thomas Lopatic  <thomas\-at\-lopatic.de>, Felix Fietkau <nbd\-at\-nbd.name>, Ludger Schmudde <lui\-at\-schmudde.com>, Simon Wunderlich <siwu\-at\-hrz.tu\-chemnitz.de>, Andreas Langer <a.langer\-at\-q\-dsl.de>.
 .PP
 This manual page was written by Wesley Tsai <wesleyboy42@gmail.com>,
 for the Debian GNU/Linux system.
-- 
1.6.2.4

