Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Mon, 22 Aug 2016 15:56:12 +0200
Message-Id: <20160822135620.15337-13-sw@simonwunderlich.de>
In-Reply-To: <20160822135620.15337-1-sw@simonwunderlich.de>
References: <20160822135620.15337-1-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH 12/20] batman-adv: Place kref_get for gw_node
	near use
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
 net/batman-adv/gateway_client.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/batman-adv/gateway_client.c b/net/batman-adv/gateway_client.c
index b889e1f..4b51b1c 100644
--- a/net/batman-adv/gateway_client.c
+++ b/net/batman-adv/gateway_client.c
@@ -339,14 +339,15 @@ static void batadv_gw_node_add(struct batadv_priv *bat_priv,
 	if (!gw_node)
 		return;
 
+	kref_init(&gw_node->refcount);
 	INIT_HLIST_NODE(&gw_node->list);
 	kref_get(&orig_node->refcount);
 	gw_node->orig_node = orig_node;
 	gw_node->bandwidth_down = ntohl(gateway->bandwidth_down);
 	gw_node->bandwidth_up = ntohl(gateway->bandwidth_up);
-	kref_init(&gw_node->refcount);
 
 	spin_lock_bh(&bat_priv->gw.list_lock);
+	kref_get(&gw_node->refcount);
 	hlist_add_head_rcu(&gw_node->list, &bat_priv->gw.list);
 	spin_unlock_bh(&bat_priv->gw.list_lock);
 
@@ -357,6 +358,9 @@ static void batadv_gw_node_add(struct batadv_priv *bat_priv,
 		   ntohl(gateway->bandwidth_down) % 10,
 		   ntohl(gateway->bandwidth_up) / 10,
 		   ntohl(gateway->bandwidth_up) % 10);
+
+	/* don't return reference to new gw_node */
+	batadv_gw_node_put(gw_node);
 }
 
 /**
-- 
2.9.3

