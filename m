Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat,  7 Jul 2018 22:01:20 +0200
Message-Id: <20180707200121.2684-3-sven@narfation.org>
In-Reply-To: <20180707200121.2684-1-sven@narfation.org>
References: <20180707200121.2684-1-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 2/3] batman-adv: Join batadv_purge_orig_ref
 and _batadv_purge_orig
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

The single line function batadv_purge_orig_ref has no function beside
providing the name used by other source files. This can also be done
simpler by just renaming _batadv_purge_orig to batadv_purge_orig_ref.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/originator.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
index 716e5b43..1d295da3 100644
--- a/net/batman-adv/originator.c
+++ b/net/batman-adv/originator.c
@@ -1339,7 +1339,11 @@ static bool batadv_purge_orig_node(struct batadv_priv *bat_priv,
 	return false;
 }
 
-static void _batadv_purge_orig(struct batadv_priv *bat_priv)
+/**
+ * batadv_purge_orig_ref() - Purge all outdated originators
+ * @bat_priv: the bat priv with all the soft interface information
+ */
+void batadv_purge_orig_ref(struct batadv_priv *bat_priv)
 {
 	struct batadv_hashtable *hash = bat_priv->orig_hash;
 	struct hlist_node *node_tmp;
@@ -1385,21 +1389,12 @@ static void batadv_purge_orig(struct work_struct *work)
 
 	delayed_work = to_delayed_work(work);
 	bat_priv = container_of(delayed_work, struct batadv_priv, orig_work);
-	_batadv_purge_orig(bat_priv);
+	batadv_purge_orig_ref(bat_priv);
 	queue_delayed_work(batadv_event_workqueue,
 			   &bat_priv->orig_work,
 			   msecs_to_jiffies(BATADV_ORIG_WORK_PERIOD));
 }
 
-/**
- * batadv_purge_orig_ref() - Purge all outdated originators
- * @bat_priv: the bat priv with all the soft interface information
- */
-void batadv_purge_orig_ref(struct batadv_priv *bat_priv)
-{
-	_batadv_purge_orig(bat_priv);
-}
-
 #ifdef CONFIG_BATMAN_ADV_DEBUGFS
 
 /**
-- 
2.18.0

