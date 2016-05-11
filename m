Return-Path: <sven.eckelmann@open-mesh.com>
From: Sven Eckelmann <sven.eckelmann@open-mesh.com>
Date: Wed, 11 May 2016 09:36:40 +0200
Message-Id: <1462952200-6368-1-git-send-email-sven@open-mesh.com>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Only init ELP tweaking options
	when BATMAN_V is enabled
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
Cc: Sven Eckelmann <sven.eckelmann@open-mesh.com>

From: Sven Eckelmann <sven.eckelmann@open-mesh.com>

The build currently fails with CONFIG_BATMAN_ADV_BATMAN_V=n because
hard_iface->bat_v is only defined when CONFIG_BATMAN_ADV_BATMAN_V=y is set.
The initialization of bat_v.throughput_override/bat_v.elp_interval
must therefore only be compiled in when also BATMAN_V is enabled.

Fixes: 71e957cd30a0 ("batman-adv: init ELP tweaking options only once")
Signed-off-by: Sven Eckelmann <sven.eckelmann@open-mesh.com>
---
 net/batman-adv/hard-interface.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index dd6a5a2..a8cda76 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -683,12 +683,14 @@ batadv_hardif_add_interface(struct net_device *net_dev)
 	if (batadv_is_wifi_netdev(net_dev))
 		hard_iface->num_bcasts = BATADV_NUM_BCASTS_WIRELESS;
 
+#ifdef CONFIG_BATMAN_ADV_BATMAN_V
 	/* enable link throughput auto-detection by setting the throughput
 	 * override to zero
 	 */
 	atomic_set(&hard_iface->bat_v.throughput_override, 0);
 
 	atomic_set(&hard_iface->bat_v.elp_interval, 500);
+#endif
 
 	/* extra reference for return */
 	kref_init(&hard_iface->refcount);
-- 
2.8.1

