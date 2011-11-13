Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Mon, 14 Nov 2011 00:20:36 +0800
Message-Id: <1321201236-14446-1-git-send-email-lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCH] batctl: update the tcpdump section in the
	README
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
 README |   23 ++++++++++++++---------
 1 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/README b/README
index 442f8b6..cdeb2ed 100644
--- a/README
+++ b/README
@@ -84,21 +84,26 @@ traceroute to fe:fe:00:00:09:01 (fe:fe:00:00:09:01), 50 hops max, 19 byte packet
 batctl tcpdump
 ===============
 
-tcpdump layer 2 traffic on the given interface
+tcpdump layer 2 and/or layer 3 traffic on the given interface
 
 Usage: batctl tcpdump [options] interface [interface]
 options:
          -h print this help
          -n don't convert addresses to bat-host names
          -p dump specific packet type
-                1 - batman ogm packets
-                2 - batman icmp packets
-                4 - batman unicast packets
-                8 - batman broadcast packets
-                16 - batman vis packets
-                32 - batman fragmented packets
-                64 - non batman packets
-                65 - batman ogm & non batman packets
+         -x dump all packet types except specified
+packet types:
+                  1 - batman ogm packets
+                  2 - batman icmp packets
+                  4 - batman unicast packets
+                  8 - batman broadcast packets
+                 16 - batman vis packets
+                 32 - batman fragmented packets
+                 64 - batman tt / roaming packets
+                128 - non batman packets
+                129 - batman ogm & non batman packets
+
+tcpdump supports standard interfaces as well as raw wifi interfaces running in monitor mode.
 
 Example output for tcpdump:
 
-- 
1.7.5.4

