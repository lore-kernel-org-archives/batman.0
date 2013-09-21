Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 21 Sep 2013 16:31:16 +0200
Message-Id: <1379773877-6299-3-git-send-email-sven@narfation.org>
In-Reply-To: <1379773877-6299-1-git-send-email-sven@narfation.org>
References: <1379773877-6299-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 3/4] alfred: Rename vis to batadv-vis
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>

The name vis is to ambiguous and already taken by the batmand vis server.
Distributions like Gentoo or OpenWrt would have a conflict between these
packages just because they share a common name. This makes the situation
unnecessary complex.

A better name may also help an user to find this tool.

Reported-by: Braden Aran <bradenaran@gmail.com>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 README       | 27 ++++++++++++++-------------
 vis/Makefile |  6 +++---
 vis/vis.c    |  2 +-
 3 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/README b/README
index a9013f4..50c36ad 100644
--- a/README
+++ b/README
@@ -33,13 +33,13 @@ To compile alfred, simply type:
 
  $ make
 
-This will compile both alfred and vis. To install, use
+This will compile both alfred and batadv-vis. To install, use
 
  $ make install
 
 (with the right privileges).
 
-If you don't want to compile vis, add the directive CONFIG_ALFRED_VIS=n:
+If you don't want to compile batadv-vis, add the directive CONFIG_ALFRED_VIS=n:
 
  $ make CONFIG_ALFRED_VIS=n 
  $ make CONFIG_ALFRED_VIS=n install
@@ -113,22 +113,23 @@ machines (slaves send information to masters).
 Vis
 ---
 
-Vis can be used to visualize your batman-adv mesh network. It read the neighbor
-information and local client table and distributes this information via alfred
-in the network. By gathering this local information, any vis node can get the
-whole picture of the network.
+batadv-vis can be used to visualize your batman-adv mesh network. It read the
+neighbor information and local client table and distributes this information via
+alfred in the network. By gathering this local information, any vis node can get
+the whole picture of the network.
 
-Vis, similar to to alfred, combines server (daemon) and client functionality in
-the 'vis' binary. The vis server must be started to let vis work:
+batadv-vis, similar to to alfred, combines server (daemon) and client
+functionality in the 'batadv-vis' binary. The batadv-vis server must be started
+to let batadv-vis work:
 
- $ vis -i bat0 -s
+ $ batadv-vis -i bat0 -s
 
 This server will read the neighbor and client information from batman-adv every
 10 seconds and set it in alfred via unix socket. Obviously, the alfred server
 must run too to get this information set.
 
 To get a graphviz-compatible vis output, simply type:
- $ vis
+ $ batadv-vis
 digraph {
         subgraph "cluster_fe:f0:00:00:04:01" {
                 "fe:f0:00:00:04:01"
@@ -153,7 +154,7 @@ digraph {
 
 For a json formatted output, use:
 
- $ vis -f json
+ $ batadv-vis -f json
 { "primary" : "fe:f0:00:00:04:01" }
 { "router" : "fe:f0:00:00:04:01", "neighbor" : "fe:f0:00:00:05:01", "label" : "1.000" }
 { "router" : "fe:f0:00:00:04:01", "neighbor" : "fe:f0:00:00:03:01", "label" : "1.008" }
@@ -171,8 +172,8 @@ For a json formatted output, use:
 License
 -------
 
-alfred and vis are licensed under the terms of version 2 of the GNU General
-Public License (GPL). Please see the LICENSE file.
+alfred and batadv-vis are licensed under the terms of version 2 of the GNU
+General Public License (GPL). Please see the LICENSE file.
 
 The file "packet.h" is an exception and not licensed with the GPL. Instead,
 it is licensed using ISC license (see the head of this file). This allows
diff --git a/vis/Makefile b/vis/Makefile
index bd83877..4db27d9 100644
--- a/vis/Makefile
+++ b/vis/Makefile
@@ -18,11 +18,11 @@
 # 02110-1301, USA
 #
 
-# alfred build
-BINARY_NAME = vis
+# batadv-vis build
+BINARY_NAME = batadv-vis
 OBJ = vis.o debugfs.o
 
-# alfred flags and options
+# batadv-vis flags and options
 CFLAGS += -pedantic -Wall -W -std=gnu99 -fno-strict-aliasing -MD -MP
 LDLIBS += -lrt
 
diff --git a/vis/vis.c b/vis/vis.c
index 36ea7fe..ad7f530 100644
--- a/vis/vis.c
+++ b/vis/vis.c
@@ -608,7 +608,7 @@ static int vis_get_data(struct globals *globals)
 
 static void vis_usage(void)
 {
-	printf("Usage: vis [options]\n");
+	printf("Usage: batadv-vis [options]\n");
 	printf("  -i, --interface             specify the batman-adv interface configured on the system (default: bat0)\n");
 	printf("  -s, --server                start up in server mode, which regularly updates vis data from batman-adv\n");
 	printf("  -f, --format <format>       specify the output format for client mode (either \"json\" or \"dot\")\n");
-- 
1.8.4.rc3

