Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sun, 26 Jul 2015 04:59:15 +0800
Message-Id: <1437857955-28800-1-git-send-email-mareklindner@neomailbox.ch>
Subject: [B.A.T.M.A.N.] [PATCHv2] batman-adv: rearrange
	batadv_neigh_node_new() arguments to follow convention
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
Cc: Marek Lindner <mareklindner@neomailbox.ch>

Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
---
v2: Fixing subject line.

 net/batman-adv/bat_iv_ogm.c | 2 +-
 net/batman-adv/originator.c | 7 ++++---
 net/batman-adv/originator.h | 5 +++--
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index b18184e..60ca3dc 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -299,7 +299,7 @@ batadv_iv_ogm_neigh_new(struct batadv_hard_iface *hard_iface,
 	struct batadv_priv *bat_priv = netdev_priv(hard_iface->soft_iface);
 	struct batadv_neigh_node *neigh_node, *tmp_neigh_node;
 
-	neigh_node = batadv_neigh_node_new(hard_iface, neigh_addr, orig_node);
+	neigh_node = batadv_neigh_node_new(orig_node, hard_iface, neigh_addr);
 	if (!neigh_node)
 		goto out;
 
diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
index f8317c1..67d3d8e 100644
--- a/net/batman-adv/originator.c
+++ b/net/batman-adv/originator.c
@@ -444,16 +444,17 @@ out:
 
 /**
  * batadv_neigh_node_new - create and init a new neigh_node object
+ * @orig_node: originator object representing the neighbour
  * @hard_iface: the interface where the neighbour is connected to
  * @neigh_addr: the mac address of the neighbour interface
- * @orig_node: originator object representing the neighbour
  *
  * Allocates a new neigh_node object and initialises all the generic fields.
  * Returns the new object or NULL on failure.
  */
 struct batadv_neigh_node *
-batadv_neigh_node_new(struct batadv_hard_iface *hard_iface,
-		      const u8 *neigh_addr, struct batadv_orig_node *orig_node)
+batadv_neigh_node_new(struct batadv_orig_node *orig_node,
+		      struct batadv_hard_iface *hard_iface,
+		      const u8 *neigh_addr)
 {
 	struct batadv_neigh_node *neigh_node;
 
diff --git a/net/batman-adv/originator.h b/net/batman-adv/originator.h
index 3fc76f6..fde3438 100644
--- a/net/batman-adv/originator.h
+++ b/net/batman-adv/originator.h
@@ -46,8 +46,9 @@ batadv_neigh_node_get(const struct batadv_orig_node *orig_node,
 		      const struct batadv_hard_iface *hard_iface,
 		      const u8 *addr);
 struct batadv_neigh_node *
-batadv_neigh_node_new(struct batadv_hard_iface *hard_iface,
-		      const u8 *neigh_addr, struct batadv_orig_node *orig_node);
+batadv_neigh_node_new(struct batadv_orig_node *orig_node,
+		      struct batadv_hard_iface *hard_iface,
+		      const u8 *neigh_addr);
 void batadv_neigh_node_free_ref(struct batadv_neigh_node *neigh_node);
 struct batadv_neigh_node *
 batadv_orig_router_get(struct batadv_orig_node *orig_node,
-- 
2.1.4

