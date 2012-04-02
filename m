Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon,  2 Apr 2012 19:31:26 +0200
Message-Id: <1333387886-17562-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Add routing_algo to README
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

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
Please apply directly to next and merge into master. Thx

 README |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/README b/README
index 4ee2f54..82c075f 100644
--- a/README
+++ b/README
@@ -66,10 +66,11 @@ All  mesh  wide  settings  can be found in batman's own interface
 folder:
 
 # ls /sys/class/net/bat0/mesh/
-# aggregated_ogms        fragmentation          hop_penalty
-# ap_isolation           gw_bandwidth           log_level
-# bonding                gw_mode                orig_interval
-# bridge_loop_avoidance  gw_sel_class           vis_mode
+# aggregated_ogms        gw_bandwidth           log_level
+# ap_isolation           gw_mode                orig_interval
+# bonding                gw_sel_class           routing_algo
+# bridge_loop_avoidance  hop_penalty            vis_mode
+# fragmentation
 
 
 There is a special folder for debugging information:
-- 
1.7.9.1

