Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Sun, 30 Oct 2011 23:51:11 +0100
Message-Id: <1320015072-10313-11-git-send-email-siwu@hrz.tu-chemnitz.de>
In-Reply-To: <1320015072-10313-1-git-send-email-siwu@hrz.tu-chemnitz.de>
References: <1320015072-10313-1-git-send-email-siwu@hrz.tu-chemnitz.de>
Subject: [B.A.T.M.A.N.] [RFC 10/11] batman-adv: Update README and sysfs
	description
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
Cc: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>

Signed-off-by: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
---
 README               |   28 +++++++++++++++-------------
 sysfs-class-net-mesh |    9 +++++++++
 2 files changed, 24 insertions(+), 13 deletions(-)

diff --git a/README b/README
index 5ba56b5..44061af 100644
--- a/README
+++ b/README
@@ -1,4 +1,4 @@
-[state: 30-09-2011]
+[state: 27-10-2011]
 
 BATMAN-ADV
 ----------
@@ -82,17 +82,17 @@ To deactivate an interface you have  to  write  "none"  into  its
 All  mesh  wide  settings  can be found in batman's own interface
 folder:
 
-#  ls  /sys/class/net/bat0/mesh/
-# aggregated_ogms   fragmentation gw_sel_class   vis_mode
-# ap_isolation      gw_bandwidth  hop_penalty
-# bonding           gw_mode       orig_interval
+# ls /sys/class/net/bat0/mesh/
+# aggregated_ogms        fragmentation          hop_penalty
+# ap_isolation           gw_bandwidth           log_level
+# bonding                gw_mode                orig_interval
+# bridge_loop_avoidance  gw_sel_class           vis_mode
 
 There is a special folder for debugging information:
 
 #  ls /sys/kernel/debug/batman_adv/bat0/
-#  gateways     socket        transtable_global  vis_data
-#  originators  softif_neigh  transtable_local
-
+# bla_claim_table    log                socket             transtable_local
+# gateways           originators        transtable_global  vis_data
 
 Some of the files contain all sort of status information  regard-
 ing  the  mesh  network.  For  example, you can view the table of
@@ -216,15 +216,17 @@ file in debugfs
 The additional debug output is by default disabled. It can be en-
 abled  during run time. Following log_levels are defined:
 
-0 - All  debug  output  disabled
-1 - Enable messages related to routing / flooding / broadcasting
-2 - Enable route or tt entry added / changed / deleted
-3 - Enable all messages
+0 - all debug output disabled
+1 - messages related to routing / flooding / broadcasting
+2 - messages related to route added / changed / deleted
+4 - messages related to translation table operations
+8 - messages related to bridge loop avoidance
+15 - enable all messages
 
 The debug output can be changed at runtime  using  the  file
 /sys/class/net/bat0/mesh/log_level. e.g.
 
-# echo 2 > /sys/class/net/bat0/mesh/log_level
+# echo 6 > /sys/class/net/bat0/mesh/log_level
 
 will enable debug messages for when routes or TTs change.
 
diff --git a/sysfs-class-net-mesh b/sysfs-class-net-mesh
index b020014..1d39bc7 100644
--- a/sysfs-class-net-mesh
+++ b/sysfs-class-net-mesh
@@ -14,6 +14,15 @@ Description:
                 mesh will be sent using multiple interfaces at the
                 same time (if available).
 
+What:           /sys/class/net/<mesh_iface>/mesh/bridge_loop_avoidance
+Date:           November 2011
+Contact:        Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
+Description:
+                Indicates whether the bridge loop avoidance feature
+                is enabled. This feature detects and avoids loops
+                between the mesh and devices bridged with the soft
+                interface <mesh_iface>.
+
 What:           /sys/class/net/<mesh_iface>/mesh/fragmentation
 Date:           October 2010
 Contact:        Andreas Langer <an.langer@gmx.de>
-- 
1.7.7.1

