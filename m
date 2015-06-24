Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Wed, 24 Jun 2015 14:50:19 +0200
Message-Id: <1435150220-25157-1-git-send-email-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH maint 1/2] batman-adv: initialize up/down
	values when adding a gateway
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
Cc: Simon Wunderlich <simon@open-mesh.com>

From: Simon Wunderlich <simon@open-mesh.com>

Without this initialization, gateways which actually announce up/down
bandwidth of 0/0 could be added. If these nodes get purged later, the
gw_node structure does not get removed since batadv_gw_node_delete()
updates the gw_node with up/down bandwidth of 0/0, and the updating
function then discards the change and does not free gw_node.

This results in leaking the gw_node structures, which references other
structures: gw_node -> orig_node -> orig_node_ifinfo -> hardif. When
removing the interface later, the open reference on the hardif may cause
hangs with the infamous "unregister_netdevice: waiting for mesh1 to
become free. Usage count = 1" message.

Signed-off-by: Simon Wunderlich <simon@open-mesh.com>
---
 gateway_client.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/gateway_client.c b/gateway_client.c
index 3f32357..d8e3ead 100644
--- a/gateway_client.c
+++ b/gateway_client.c
@@ -419,6 +419,8 @@ static void batadv_gw_node_add(struct batadv_priv *bat_priv,
 
 	INIT_HLIST_NODE(&gw_node->list);
 	gw_node->orig_node = orig_node;
+	gw_node->bandwidth_down = ntohl(gateway->bandwidth_down);
+	gw_node->bandwidth_up = ntohl(gateway->bandwidth_up);
 	atomic_set(&gw_node->refcount, 1);
 
 	spin_lock_bh(&bat_priv->gw.list_lock);
-- 
2.1.4

