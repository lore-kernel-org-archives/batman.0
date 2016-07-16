Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 16 Jul 2016 21:30:22 +0200
Message-Id: <1468697424-10701-3-git-send-email-sven@narfation.org>
In-Reply-To: <1468697424-10701-1-git-send-email-sven@narfation.org>
References: <1468697424-10701-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 3/5] batman-adv: Add network_coding and mcast
	syfs files to README
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

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 Documentation/networking/batman-adv.txt | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/Documentation/networking/batman-adv.txt b/Documentation/networking/batman-adv.txt
index d414e60..8afa991 100644
--- a/Documentation/networking/batman-adv.txt
+++ b/Documentation/networking/batman-adv.txt
@@ -71,10 +71,11 @@ All  mesh  wide  settings  can be found in batman's own interface
 folder:
 
 # ls /sys/class/net/bat0/mesh/
-#aggregated_ogms        distributed_arp_table  gw_sel_class    orig_interval
-#ap_isolation           fragmentation          hop_penalty     routing_algo
-#bonding                gw_bandwidth           isolation_mark  vlan0
-#bridge_loop_avoidance  gw_mode                log_level
+# aggregated_ogms        fragmentation  isolation_mark  routing_algo
+# ap_isolation           gw_bandwidth   log_level       vlan0
+# bonding                gw_mode        multicast_mode
+# bridge_loop_avoidance  gw_sel_class   network_coding
+# distributed_arp_table  hop_penalty    orig_interval
 
 There is a special folder for debugging information:
 
-- 
2.8.1

