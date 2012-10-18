Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 18 Oct 2012 10:48:32 +0200
Message-Id: <1350550112-5857-2-git-send-email-sven@narfation.org>
In-Reply-To: <1350550112-5857-1-git-send-email-sven@narfation.org>
References: <1350550112-5857-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 2/2] batman-adv: Fix build of batman-adv
	without BLA
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

4c1721b39c8a77c99e8f4de97b5d5d112006406c ("batman-adv: Fix potential broadcast
BLA-duplicate-check race condition") introduced a spinlock for bridge loop
avoidance which was initialized outside of bla. This causes an build error when
BLA is disabled. Instead the batadv_bla_init function should handle the
initialization.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
Please merge in next

 bridge_loop_avoidance.c |    2 ++
 main.c                  |    1 -
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/bridge_loop_avoidance.c b/bridge_loop_avoidance.c
index 776a73d..a05b1b4 100644
--- a/bridge_loop_avoidance.c
+++ b/bridge_loop_avoidance.c
@@ -1204,6 +1204,8 @@ int batadv_bla_init(struct batadv_priv *bat_priv)
 	uint16_t crc;
 	unsigned long entrytime;
 
+	spin_lock_init(&bat_priv->bla.bcast_duplist_lock);
+
 	batadv_dbg(BATADV_DBG_BLA, bat_priv, "bla hash registering\n");
 
 	/* setting claim destination address */
diff --git a/main.c b/main.c
index 76d653a..2b1123d 100644
--- a/main.c
+++ b/main.c
@@ -104,7 +104,6 @@ int batadv_mesh_init(struct net_device *soft_iface)
 	spin_lock_init(&bat_priv->gw.list_lock);
 	spin_lock_init(&bat_priv->vis.hash_lock);
 	spin_lock_init(&bat_priv->vis.list_lock);
-	spin_lock_init(&bat_priv->bla.bcast_duplist_lock);
 
 	INIT_HLIST_HEAD(&bat_priv->forw_bat_list);
 	INIT_HLIST_HEAD(&bat_priv->forw_bcast_list);
-- 
1.7.10.4

