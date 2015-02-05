Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu,  5 Feb 2015 17:22:53 +0100
Message-Id: <1423153373-17033-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Use safer default config for
	optional features
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

The current default settings for optional features in batman-adv seems to be
based around the idea that the user only compiles what he requires. They will
automatically enabled when they are compiled in. For example the network coding
part of batman-adv is by default disabled in the out-of-tree module but will be
enabled when the code is compiled during the module build.

But distributions like Debian just enable all features of the batman-adv kernel
module and hope that more experimental features or features with possible
negative effects have to be enabled using some runtime configuration interface.

The network_coding feature can help in specific setups but also has drawbacks
and is not disabled by default in the out-of-tree module. Disabling by default
in the runtime config seems to be also quite sane.

The distributed_arp_table is in theory a good solution to reduce connection
problems in large networks caused by ARP packet loss. Unfortunatelly, it seems
to also break ARP resolution in simple mesh setups. The only solution which
seems to be used by AP firmwares seems to be the deactivation of this feature.
Disabling this feature by default until the problem was understood and fixed
may help new deployments to create a working mesh. Tuning of the mesh can still
be done by them in case DAT works in their setup.

The bridge_loop_avoidance is the only feature which is disabled by default but
may be necessary even in simple setups. Packet loops may even be created
during the initial node setup when this is not enabled. This is different than
STP on bridges because mesh is usually used on Adhoc WiFi. Having two nodes
(by accident) in the same LAN segment and in the same mesh network is rather
common in this situation.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
--
This patchset is based on my comments in
 https://lists.open-mesh.org/pipermail/b.a.t.m.a.n/2014-November/012543.html

The patch doesn't touch the multicast feature because I have no idea how well
it works and what the current multicast mode is actual doing.
---
 network-coding.c | 2 +-
 soft-interface.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/network-coding.c b/network-coding.c
index 127cc4d..be005b2 100644
--- a/network-coding.c
+++ b/network-coding.c
@@ -155,7 +155,7 @@ err:
  */
 void batadv_nc_init_bat_priv(struct batadv_priv *bat_priv)
 {
-	atomic_set(&bat_priv->network_coding, 1);
+	atomic_set(&bat_priv->network_coding, 0);
 	bat_priv->nc.min_tq = 200;
 	bat_priv->nc.max_fwd_delay = 10;
 	bat_priv->nc.max_buffer_time = 200;
diff --git a/soft-interface.c b/soft-interface.c
index 8748987..ae96cee 100644
--- a/soft-interface.c
+++ b/soft-interface.c
@@ -738,10 +738,10 @@ static int batadv_softif_init_late(struct net_device *dev)
 	atomic_set(&bat_priv->aggregated_ogms, 1);
 	atomic_set(&bat_priv->bonding, 0);
 #ifdef CONFIG_BATMAN_ADV_BLA
-	atomic_set(&bat_priv->bridge_loop_avoidance, 0);
+	atomic_set(&bat_priv->bridge_loop_avoidance, 1);
 #endif
 #ifdef CONFIG_BATMAN_ADV_DAT
-	atomic_set(&bat_priv->distributed_arp_table, 1);
+	atomic_set(&bat_priv->distributed_arp_table, 0);
 #endif
 #ifdef CONFIG_BATMAN_ADV_MCAST
 	bat_priv->mcast.flags = BATADV_NO_FLAGS;
-- 
2.1.4

