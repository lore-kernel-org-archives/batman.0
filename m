Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu, 26 May 2011 14:32:25 +0200
Message-Id: <1306413145-7921-1-git-send-email-lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCH] batctl: update readme
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
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Marek Lindner <lindner_marek@yahoo.de>

Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
---
 README |   41 ++++++++++++++++++++---------------------
 1 files changed, 20 insertions(+), 21 deletions(-)

diff --git a/README b/README
index d11c6d3..442f8b6 100644
--- a/README
+++ b/README
@@ -18,8 +18,8 @@ settings.
 How does it work ?
 ==================
 
-batctl uses the /dev/batman-adv device provided by the B.A.T.M.A.N. advanced
-kernel module to inject custom icmp packets into the data flow. That's why
+batctl uses the debugfs/batman_adv/bat0/socket device provided by the B.A.T.M.A.N.
+advanced kernel module to inject custom icmp packets into the data flow. That's why
 ping and traceroute work almost like their IP based counterparts. Tcpdump was
 designed because B.A.T.M.A.N. advanced encapsulates all traffic within batman
 packets, so that the normal tcpdump would not recognize the packets.
@@ -30,8 +30,8 @@ The bat-hosts file
 
 This file is simliar to the /etc/hosts file. You can write one MAC address and
 one host name per line. batctl will analyze the file to find the matching MAC
-address to your provided host name. Host names are much easier to remember
-than MAC addresses.  ;)
+address to your provided host name. Host names are much easier to remember than
+MAC addresses.  ;)
 
 
 batctl ping
@@ -45,6 +45,7 @@ options:
          -h print this help
          -i interval in seconds
          -t timeout in seconds
+         -R record route
 
 Example:
 
@@ -95,8 +96,9 @@ options:
                 4 - batman unicast packets
                 8 - batman broadcast packets
                 16 - batman vis packets
-                32 - non batman packets
-                33 - batman ogm & non batman packets
+                32 - batman fragmented packets
+                64 - non batman packets
+                65 - batman ogm & non batman packets
 
 Example output for tcpdump:
 
@@ -241,12 +243,12 @@ batctl interface
 
 display or modify the interface settings
 
-Usage: batctl interface|if  [none|interface]
+Usage: batctl interface|if    [add|del iface(s)]
 
 Example:
 
 $  batctl interface
-[  active] eth0 fe:fe:00:00:01:01
+eth0: active
 
 batctl interval
 ===============
@@ -270,7 +272,6 @@ Usage: batctl log|l
 Example:
 
 $ batctl log
-r)
 [       400] Received BATMAN packet via NB: fe:fe:00:00:02:01 IF: eth0 [fe:fe:00:00:01:01] (from OG: fe:fe:00:00:01:01 via prev OG: fe:fe:00:00:01:01 seqno 670, tq 245, TTL 49, V 8, IDF 1)
 [       400] Drop packet: originator packet from myself (via neighbour)
 [       400] Received BATMAN packet via NB: fe:fe:00:00:02:01 IF: eth0 [fe:fe:00:00:01:01] (from OG: fe:fe:00:00:02:01 via prev OG: fe:fe:00:00:02:01 seqno 545, tq 255, TTL 50, V 8, IDF 0)
@@ -285,15 +286,14 @@ batctl loglevel
 
 display or modify the log level
 
-Usage: batctl |ll   [level]
+Usage: batctl loglevel|ll   [level]
 
 Example:
 $  batctl loglevel
-[x] critical (0)
-[x] warnings (1)
-[x] notices (2)
-[x] batman (4)
-[x] routes (8)
+[x] all debug output disabled (0)
+[ ] messages related to routing / flooding / broadcasting (1)
+[ ] messages related to route or hna added / changed / deleted (2)
+[ ] all debug messages (3)
 
 batctl aggregation
 ==================
@@ -334,18 +334,17 @@ Globally announced TT entries received via the mesh (translation table):
  * 86:4b:b2:d2:00:00 via fe:fe:00:00:07:01
  * ca:a1:5b:e5:00:00 via fe:fe:00:00:06:01
 
-batctl vis_server
+batctl vis_mode
 =================
 
 display or modify the status of the VIS server
 
-Usage: batctl vis_server|vs  [enabled|disabled]
+Usage: batctl vis_mode|vm     [mode]
 
 Example:
 
-$ batctl vis_server
-[x] client mode (server disabled)
-[ ] server mode (server enabled)
+$ batctl vis_mode
+client
 
 
 batctl vis_data
@@ -410,7 +409,7 @@ vis-dot to png
 --------------
 
 The vis dot output could then further be converted to an image of the topology
-graph, e.g. with the help of the graphviz-tools. The according commands could 
+graph, e.g. with the help of the graphviz-tools. The according commands could
 then look like this:
 
 $ batctl vis_data dot > /tmp/graph.dot
-- 
1.7.2.3

