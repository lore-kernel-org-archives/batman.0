Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Tue, 11 Feb 2014 13:48:19 +0100
Message-Id: <1392122903-805-20-git-send-email-antonio@meshcoding.com>
In-Reply-To: <1392122903-805-1-git-send-email-antonio@meshcoding.com>
References: <1392122903-805-1-git-send-email-antonio@meshcoding.com>
Subject: [B.A.T.M.A.N.] [RFC 19/23] batman-adv: add bat_neigh_free() API
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
Cc: Antonio Quartulli <antonio@open-mesh.com>

From: Antonio Quartulli <antonio@open-mesh.com>

This API has to be used to let any routing protocol free
neighbor specific allocated resources

Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
---
 originator.c | 6 ++++++
 types.h      | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/originator.c b/originator.c
index 447f417..5670df8 100644
--- a/originator.c
+++ b/originator.c
@@ -196,13 +196,19 @@ static void batadv_neigh_node_free_rcu(struct rcu_head *rcu)
 	struct hlist_node *node_tmp;
 	struct batadv_neigh_node *neigh_node;
 	struct batadv_neigh_ifinfo *neigh_ifinfo;
+	struct batadv_algo_ops *bao;
 
 	neigh_node = container_of(rcu, struct batadv_neigh_node, rcu);
+	bao = neigh_node->orig_node->bat_priv->bat_algo_ops;
 
 	hlist_for_each_entry_safe(neigh_ifinfo, node_tmp,
 				  &neigh_node->ifinfo_list, list) {
 		batadv_neigh_ifinfo_free_ref_now(neigh_ifinfo);
 	}
+
+	if (bao->bat_neigh_free)
+		bao->bat_neigh_free(neigh_node);
+
 	batadv_hardif_free_ref_now(neigh_node->if_incoming);
 
 	kfree(neigh_node);
diff --git a/types.h b/types.h
index a51921e..df1479e 100644
--- a/types.h
+++ b/types.h
@@ -1203,6 +1203,8 @@ struct batadv_algo_ops {
 			       int max_if_num);
 	int (*bat_orig_del_if)(struct batadv_orig_node *orig_node,
 			       int max_if_num, int del_if_num);
+	/* neigh_node handling API */
+	void (*bat_neigh_free)(struct batadv_neigh_node *neigh);
 };
 
 /**
-- 
1.8.5.3

