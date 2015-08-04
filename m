Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Tue,  4 Aug 2015 21:09:56 +0800
Message-Id: <1438693798-21807-2-git-send-email-mareklindner@neomailbox.ch>
In-Reply-To: <1438693798-21807-1-git-send-email-mareklindner@neomailbox.ch>
References: <1438693798-21807-1-git-send-email-mareklindner@neomailbox.ch>
Subject: [B.A.T.M.A.N.] [PATCHv3 2/4] batman-adv: add bat_hardif_neigh_init
	algo ops call
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
Cc: Marek Lindner <mareklindner@neomailbox.ch>

Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
---
v3: no change
v2: no change

 net/batman-adv/originator.c | 4 ++++
 net/batman-adv/types.h      | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
index 4029bbe..db949b8 100644
--- a/net/batman-adv/originator.c
+++ b/net/batman-adv/originator.c
@@ -527,6 +527,9 @@ batadv_hardif_neigh_create(struct batadv_hard_iface *hard_iface,
 
 	atomic_set(&hardif_neigh->refcount, 1);
 
+	if (bat_priv->bat_algo_ops->bat_hardif_neigh_init)
+		bat_priv->bat_algo_ops->bat_hardif_neigh_init(hardif_neigh);
+
 	hlist_add_head(&hardif_neigh->list, &hard_iface->neigh_list);
 
 out:
@@ -547,6 +550,7 @@ batadv_hardif_neigh_get_or_create(struct batadv_hard_iface *hard_iface,
 				  const u8 *neigh_addr)
 {
 	struct batadv_hardif_neigh_node *hardif_neigh = NULL;
+	struct batadv_priv *bat_priv = netdev_priv(hard_iface->soft_iface);
 
 	/* first check without locking to avoid the overhead */
 	hardif_neigh = batadv_hardif_neigh_get(hard_iface, neigh_addr);
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 71c7d9f..838d55e 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -1153,6 +1153,7 @@ struct batadv_forw_packet {
  * @bat_primary_iface_set: called when primary interface is selected / changed
  * @bat_ogm_schedule: prepare a new outgoing OGM for the send queue
  * @bat_ogm_emit: send scheduled OGM
+ * @bat_hardif_neigh_init: called on creation of single hop entry
  * @bat_neigh_cmp: compare the metrics of two neighbors for their respective
  *  outgoing interfaces
  * @bat_neigh_is_equiv_or_better: check if neigh1 is equally good or better
@@ -1178,6 +1179,7 @@ struct batadv_algo_ops {
 	void (*bat_ogm_schedule)(struct batadv_hard_iface *hard_iface);
 	void (*bat_ogm_emit)(struct batadv_forw_packet *forw_packet);
 	/* neigh_node handling API */
+	void (*bat_hardif_neigh_init)(struct batadv_hardif_neigh_node *neigh);
 	int (*bat_neigh_cmp)(struct batadv_neigh_node *neigh1,
 			     struct batadv_hard_iface *if_outgoing1,
 			     struct batadv_neigh_node *neigh2,
-- 
2.5.0

