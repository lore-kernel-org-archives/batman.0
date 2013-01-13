Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Mon, 14 Jan 2013 09:41:16 +1000
Message-Id: <1358120480-25960-12-git-send-email-ordex@autistici.org>
In-Reply-To: <1358120480-25960-1-git-send-email-ordex@autistici.org>
References: <1358120480-25960-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH 11/15] batman-adv: don't compile the BLA
	switch if not requested
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
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <lindner_marek@yahoo.de>

When the Bridge Loop Avoidance component is not compiled-in, its boolean switch
should be not compiled as well. This patch surrounds the switch with a proper
ifdef.

This behaviour was introduced by 9fd6b0615b5499b270d39a92b8790e206cf75833
("batman-adv: add bridge loop avoidance compile option")

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
Acked-by: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
---
 net/batman-adv/soft-interface.c | 2 ++
 net/batman-adv/types.h          | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/net/batman-adv/soft-interface.c b/net/batman-adv/soft-interface.c
index f8cc142..57714f8 100644
--- a/net/batman-adv/soft-interface.c
+++ b/net/batman-adv/soft-interface.c
@@ -480,7 +480,9 @@ struct net_device *batadv_softif_create(const char *name)
 
 	atomic_set(&bat_priv->aggregated_ogms, 1);
 	atomic_set(&bat_priv->bonding, 0);
+#ifdef CONFIG_BATMAN_ADV_BLA
 	atomic_set(&bat_priv->bridge_loop_avoidance, 0);
+#endif
 #ifdef CONFIG_BATMAN_ADV_DAT
 	atomic_set(&bat_priv->distributed_arp_table, 1);
 #endif
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index ae9ac9a..030ce41 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -273,7 +273,9 @@ struct batadv_priv {
 	atomic_t bonding;		/* boolean */
 	atomic_t fragmentation;		/* boolean */
 	atomic_t ap_isolation;		/* boolean */
+#ifdef CONFIG_BATMAN_ADV_BLA
 	atomic_t bridge_loop_avoidance;	/* boolean */
+#endif
 #ifdef CONFIG_BATMAN_ADV_DAT
 	atomic_t distributed_arp_table;	/* boolean */
 #endif
-- 
1.8.0.2

