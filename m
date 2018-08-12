Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 12 Aug 2018 21:04:41 +0200
Message-Id: <20180812190445.28013-2-sven@narfation.org>
In-Reply-To: <20180812190445.28013-1-sven@narfation.org>
References: <20180812190445.28013-1-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 1/5] batman-adv: Prevent duplicated
 gateway_node entry
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

The function batadv_gw_node_add is responsible for adding new gw_node to
the gateway_list. It is expecting that the caller already checked that
there is not already an entry with the same key or not.

But the lock for the list is only held when the list is really modified.
This could lead to duplicated entries because another context could create
an entry with the same key between the check and the list manipulation.

The check and the manipulation of the list must therefore be in the same
locked code section.

Fixes: bc3538cabac5 ("batman-adv: adding gateway functionality")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/gateway_client.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/gateway_client.c b/net/batman-adv/gateway_client.c
index 8b198ee7..0df4e87d 100644
--- a/net/batman-adv/gateway_client.c
+++ b/net/batman-adv/gateway_client.c
@@ -32,6 +32,7 @@
 #include <linux/kernel.h>
 #include <linux/kref.h>
 #include <linux/list.h>
+#include <linux/lockdep.h>
 #include <linux/netdevice.h>
 #include <linux/netlink.h>
 #include <linux/rculist.h>
@@ -355,6 +356,8 @@ static void batadv_gw_node_add(struct batadv_priv *bat_priv,
 {
 	struct batadv_gw_node *gw_node;
 
+	lockdep_assert_held(&bat_priv->gw.list_lock);
+
 	if (gateway->bandwidth_down == 0)
 		return;
 
@@ -369,10 +372,8 @@ static void batadv_gw_node_add(struct batadv_priv *bat_priv,
 	gw_node->bandwidth_down = ntohl(gateway->bandwidth_down);
 	gw_node->bandwidth_up = ntohl(gateway->bandwidth_up);
 
-	spin_lock_bh(&bat_priv->gw.list_lock);
 	kref_get(&gw_node->refcount);
 	hlist_add_head_rcu(&gw_node->list, &bat_priv->gw.gateway_list);
-	spin_unlock_bh(&bat_priv->gw.list_lock);
 
 	batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
 		   "Found new gateway %pM -> gw bandwidth: %u.%u/%u.%u MBit\n",
@@ -428,11 +429,14 @@ void batadv_gw_node_update(struct batadv_priv *bat_priv,
 {
 	struct batadv_gw_node *gw_node, *curr_gw = NULL;
 
+	spin_lock_bh(&bat_priv->gw.list_lock);
 	gw_node = batadv_gw_node_get(bat_priv, orig_node);
 	if (!gw_node) {
 		batadv_gw_node_add(bat_priv, orig_node, gateway);
+		spin_unlock_bh(&bat_priv->gw.list_lock);
 		goto out;
 	}
+	spin_unlock_bh(&bat_priv->gw.list_lock);
 
 	if (gw_node->bandwidth_down == ntohl(gateway->bandwidth_down) &&
 	    gw_node->bandwidth_up == ntohl(gateway->bandwidth_up))
-- 
2.18.0

