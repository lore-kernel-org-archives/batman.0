Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 29 Mar 2012 11:32:54 +0200
Message-Id: <1333013574-15044-1-git-send-email-sven@narfation.org>
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
 README |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/README b/README
index 01db663..88e8a1a 100644
--- a/README
+++ b/README
@@ -65,9 +65,9 @@ To deactivate an interface you have  to  write  "none"  into  its
 All  mesh  wide  settings  can be found in batman's own interface
 folder:
 
-#  ls  /sys/class/net/bat0/mesh/
-# aggregated_ogms   fragmentation gw_sel_class   vis_mode
-# ap_isolation      gw_bandwidth  hop_penalty
+# ls /sys/class/net/bat0/mesh/
+# aggregated_ogms   fragmentation gw_sel_class   routing_algo
+# ap_isolation      gw_bandwidth  hop_penalty    vis_mode
 # bonding           gw_mode       orig_interval
 
 
-- 
1.7.9.1

