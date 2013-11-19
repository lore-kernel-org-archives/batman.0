Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Tue, 19 Nov 2013 08:36:29 +0100
Message-Id: <1384846589-3428-1-git-send-email-antonio@meshcoding.com>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: improve README
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
Cc: Antonio Quartulli <antonio@meshcoding.com>

Add missing sysfs attributes in the proper section of the README

Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
---
 README | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/README b/README
index 89490be..58e4904 100644
--- a/README
+++ b/README
@@ -66,11 +66,10 @@ All  mesh  wide  settings  can be found in batman's own interface
 folder:
 
 # ls /sys/class/net/bat0/mesh/
-# aggregated_ogms        gw_bandwidth           log_level
-# ap_isolation           gw_mode                orig_interval
-# bonding                gw_sel_class           routing_algo
-# bridge_loop_avoidance  hop_penalty            fragmentation
-
+#aggregated_ogms        distributed_arp_table  gw_sel_class    orig_interval
+#ap_isolation           fragmentation          hop_penalty     routing_algo
+#bonding                gw_bandwidth           isolation_mark  vlan0
+#bridge_loop_avoidance  gw_mode                log_level
 
 There is a special folder for debugging information:
 
-- 
1.8.4.3

