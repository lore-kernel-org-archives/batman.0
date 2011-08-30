Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 30 Aug 2011 13:32:33 +0200
Message-Id: <1314703953-20190-1-git-send-email-lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: readme update (mention ap
	isolation and new log level)
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
 README |   13 +++++++------
 1 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/README b/README
index a9ae038..7bcc9f4 100644
--- a/README
+++ b/README
@@ -83,9 +83,9 @@ All  mesh  wide  settings  can be found in batman's own interface
 folder:
 
 #  ls  /sys/class/net/bat0/mesh/
-#  aggregated_ogms  gw_bandwidth  hop_penalty
-#  bonding          gw_mode       orig_interval
-#  fragmentation    gw_sel_class  vis_mode
+#  aggregated_ogms  fragmentation    gw_sel_class     vis_mode
+#  ap_isolation     gw_bandwidth     hop_penalty
+#  bonding          gw_mode          orig_interval
 
 
 There is a special folder for debugging information:
@@ -219,15 +219,16 @@ abled  during run time. Following log_levels are defined:
 
 0 - All  debug  output  disabled
 1 - Enable messages related to routing / flooding / broadcasting
-2 - Enable route or tt entry added / changed / deleted
-3 - Enable all messages
+2 - Enable messages related to route added / changed / deleted
+4 - Enable messages related to translation table operations
+7 - Enable all messages
 
 The debug output can be changed at runtime  using  the  file
 /sys/class/net/bat0/mesh/log_level. e.g.
 
 # echo 2 > /sys/class/net/bat0/mesh/log_level
 
-will enable debug messages for when routes or TTs change.
+will enable debug messages for when routes change.
 
 
 BATCTL
-- 
1.7.5.3

