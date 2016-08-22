Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Mon, 22 Aug 2016 15:56:06 +0200
Message-Id: <20160822135620.15337-7-sw@simonwunderlich.de>
In-Reply-To: <20160822135620.15337-1-sw@simonwunderlich.de>
References: <20160822135620.15337-1-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH 06/20] batman-adv: Place kref_get for
	orig_node near use
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
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <mareklindner@neomailbox.ch>

From: Sven Eckelmann <sven@narfation.org>

It is hard to understand why the refcnt is increased when it isn't done
near the actual place the new reference is used. So using kref_get right
before the place which requires the reference and in the same function
helps to avoid accidental problems caused by incorrect reference counting.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/bat_iv_ogm.c     | 7 ++++---
 net/batman-adv/bat_v_ogm.c      | 5 ++---
 net/batman-adv/gateway_client.c | 2 +-
 net/batman-adv/network-coding.c | 7 +++----
 net/batman-adv/originator.c     | 1 -
 5 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index 9ed4f1f..3c7900d 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -324,17 +324,18 @@ batadv_iv_ogm_orig_get(struct batadv_priv *bat_priv, const u8 *addr)
 	if (!orig_node->bat_iv.bcast_own_sum)
 		goto free_orig_node;
 
+	kref_get(&orig_node->refcount);
 	hash_added = batadv_hash_add(bat_priv->orig_hash, batadv_compare_orig,
 				     batadv_choose_orig, orig_node,
 				     &orig_node->hash_entry);
 	if (hash_added != 0)
-		goto free_orig_node;
+		goto free_orig_node_hash;
 
 	return orig_node;
 
-free_orig_node:
-	/* free twice, as batadv_orig_node_new sets refcount to 2 */
+free_orig_node_hash:
 	batadv_orig_node_put(orig_node);
+free_orig_node:
 	batadv_orig_node_put(orig_node);
 
 	return NULL;
diff --git a/net/batman-adv/bat_v_ogm.c b/net/batman-adv/bat_v_ogm.c
index 6fbba4e..1aeeadc 100644
--- a/net/batman-adv/bat_v_ogm.c
+++ b/net/batman-adv/bat_v_ogm.c
@@ -73,13 +73,12 @@ struct batadv_orig_node *batadv_v_ogm_orig_get(struct batadv_priv *bat_priv,
 	if (!orig_node)
 		return NULL;
 
+	kref_get(&orig_node->refcount);
 	hash_added = batadv_hash_add(bat_priv->orig_hash, batadv_compare_orig,
 				     batadv_choose_orig, orig_node,
 				     &orig_node->hash_entry);
 	if (hash_added != 0) {
-		/* orig_node->refcounter is initialised to 2 by
-		 * batadv_orig_node_new()
-		 */
+		/* remove refcnt for newly created orig_node and hash entry */
 		batadv_orig_node_put(orig_node);
 		batadv_orig_node_put(orig_node);
 		orig_node = NULL;
diff --git a/net/batman-adv/gateway_client.c b/net/batman-adv/gateway_client.c
index c2928c2..b889e1f 100644
--- a/net/batman-adv/gateway_client.c
+++ b/net/batman-adv/gateway_client.c
@@ -339,8 +339,8 @@ static void batadv_gw_node_add(struct batadv_priv *bat_priv,
 	if (!gw_node)
 		return;
 
-	kref_get(&orig_node->refcount);
 	INIT_HLIST_NODE(&gw_node->list);
+	kref_get(&orig_node->refcount);
 	gw_node->orig_node = orig_node;
 	gw_node->bandwidth_down = ntohl(gateway->bandwidth_down);
 	gw_node->bandwidth_up = ntohl(gateway->bandwidth_up);
diff --git a/net/batman-adv/network-coding.c b/net/batman-adv/network-coding.c
index 293ef4f..3814cfb 100644
--- a/net/batman-adv/network-coding.c
+++ b/net/batman-adv/network-coding.c
@@ -856,14 +856,13 @@ batadv_nc_get_nc_node(struct batadv_priv *bat_priv,
 	if (!nc_node)
 		return NULL;
 
-	kref_get(&orig_neigh_node->refcount);
-
 	/* Initialize nc_node */
 	INIT_LIST_HEAD(&nc_node->list);
-	ether_addr_copy(nc_node->addr, orig_node->orig);
-	nc_node->orig_node = orig_neigh_node;
 	kref_init(&nc_node->refcount);
 	kref_get(&nc_node->refcount);
+	ether_addr_copy(nc_node->addr, orig_node->orig);
+	kref_get(&orig_neigh_node->refcount);
+	nc_node->orig_node = orig_neigh_node;
 
 	/* Select ingoing or outgoing coding node */
 	if (in_coding) {
diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
index 0792de8..0b7d57a 100644
--- a/net/batman-adv/originator.c
+++ b/net/batman-adv/originator.c
@@ -989,7 +989,6 @@ struct batadv_orig_node *batadv_orig_node_new(struct batadv_priv *bat_priv,
 
 	/* extra reference for return */
 	kref_init(&orig_node->refcount);
-	kref_get(&orig_node->refcount);
 
 	orig_node->bat_priv = bat_priv;
 	ether_addr_copy(orig_node->orig, addr);
-- 
2.9.3

