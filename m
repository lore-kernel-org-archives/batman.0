Return-Path: <linus.luessing@c0d3.blue>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Date: Thu,  6 Oct 2016 08:41:38 +0200
Message-Id: <20161006064142.20003-2-linus.luessing@c0d3.blue>
In-Reply-To: <20161006064142.20003-1-linus.luessing@c0d3.blue>
References: <20161006064142.20003-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH v2 1/4] batman-adv: Keep hard interface
	neighbor list sorted
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

The upcoming neighborhood hashing will compute a hash over the MAC
address of all neighbors on an interface, from the smallest to the
largest one.

This patch keeps the hard interface neighbor list in order to ease
the hash computation later.

Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>

---

Changes in v2:
* Moved sorted storing of hardif neighbors to this separate patch
* fix rcu bug: use hlist_add_{head,behind}_rcu() instead of their
  non-rcu variants (and rebase on top of Sven's maint patch for the
  original hlist_add_head() )
(thanks Sven!)
---
 net/batman-adv/originator.c | 48 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 46 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
index 8e1ea27..9aaebaf 100644
--- a/net/batman-adv/originator.c
+++ b/net/batman-adv/originator.c
@@ -509,6 +509,43 @@ batadv_neigh_node_get(const struct batadv_orig_node *orig_node,
 }
 
 /**
+ * batadv_hardif_neigh_get_pre - get the predecessor of a neighbor node
+ * @hard_iface: the interface this neighbour is connected to
+ * @neigh_addr: address of the neighbour to retrieve the predecessor for
+ *
+ * Tries to find the neighbor node which has an address closest to but
+ * smaller than the neigh_addr provided. In other words, tries to
+ * find a potential predecessor of a given MAC address.
+ *
+ * Return: The alphabetical predecessor of a neighbor node. Returns NULL
+ * if no such predecessor exists.
+ */
+static struct batadv_hardif_neigh_node *
+batadv_hardif_neigh_get_pre(struct batadv_hard_iface *hard_iface,
+			    const u8 *neigh_addr)
+{
+	struct batadv_hardif_neigh_node *tmp_hardif_neigh, *hardif_neigh = NULL;
+
+	rcu_read_lock();
+	hlist_for_each_entry_rcu(tmp_hardif_neigh, &hard_iface->neigh_list,
+				 list) {
+		if (memcmp(tmp_hardif_neigh->addr, neigh_addr, ETH_ALEN) >= 0)
+			break;
+
+		if (!kref_get_unless_zero(&tmp_hardif_neigh->refcount))
+			continue;
+
+		if (hardif_neigh)
+			batadv_hardif_neigh_put(hardif_neigh);
+
+		hardif_neigh = tmp_hardif_neigh;
+	}
+	rcu_read_unlock();
+
+	return hardif_neigh;
+}
+
+/**
  * batadv_hardif_neigh_create - create a hardif neighbour node
  * @hard_iface: the interface this neighbour is connected to
  * @neigh_addr: the interface address of the neighbour to retrieve
@@ -522,7 +559,7 @@ batadv_hardif_neigh_create(struct batadv_hard_iface *hard_iface,
 			   struct batadv_orig_node *orig_node)
 {
 	struct batadv_priv *bat_priv = netdev_priv(hard_iface->soft_iface);
-	struct batadv_hardif_neigh_node *hardif_neigh = NULL;
+	struct batadv_hardif_neigh_node *hardif_neigh = NULL, *pre_neigh;
 
 	spin_lock_bh(&hard_iface->neigh_list_lock);
 
@@ -547,7 +584,14 @@ batadv_hardif_neigh_create(struct batadv_hard_iface *hard_iface,
 	if (bat_priv->algo_ops->neigh.hardif_init)
 		bat_priv->algo_ops->neigh.hardif_init(hardif_neigh);
 
-	hlist_add_head_rcu(&hardif_neigh->list, &hard_iface->neigh_list);
+	pre_neigh = batadv_hardif_neigh_get_pre(hard_iface, neigh_addr);
+	if (!pre_neigh) {
+		hlist_add_head_rcu(&hardif_neigh->list,
+				   &hard_iface->neigh_list);
+	} else {
+		hlist_add_behind_rcu(&hardif_neigh->list, &pre_neigh->list);
+		batadv_hardif_neigh_put(pre_neigh);
+	}
 
 out:
 	spin_unlock_bh(&hard_iface->neigh_list_lock);
-- 
2.1.4

