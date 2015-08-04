Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Tue,  4 Aug 2015 18:35:32 +0200
Message-Id: <1438706134-3492-13-git-send-email-antonio@meshcoding.com>
In-Reply-To: <1438706134-3492-1-git-send-email-antonio@meshcoding.com>
References: <1438706134-3492-1-git-send-email-antonio@meshcoding.com>
Subject: [B.A.T.M.A.N.] [PATCH 12/14] batman-adv: initialize up/down values
	when adding a gateway
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
Cc: netdev@vger.kernel.org, Simon Wunderlich <simon@open-mesh.com>, b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <mareklindner@neomailbox.ch>, Antonio Quartulli <antonio@meshcoding.com>

From: Simon Wunderlich <simon@open-mesh.com>

Without this initialization, gateways which actually announce up/down
bandwidth of 0/0 could be added. If these nodes get purged via
_batadv_purge_orig() later, the gw_node structure does not get removed
since batadv_gw_node_delete() updates the gw_node with up/down
bandwidth of 0/0, and the updating function then discards the change
and does not free gw_node.

This results in leaking the gw_node structures, which references other
structures: gw_node -> orig_node -> orig_node_ifinfo -> hardif. When
removing the interface later, the open reference on the hardif may cause
hangs with the infamous "unregister_netdevice: waiting for mesh1 to
become free. Usage count = 1" message.

Signed-off-by: Simon Wunderlich <simon@open-mesh.com>
Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
---
 net/batman-adv/gateway_client.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/batman-adv/gateway_client.c b/net/batman-adv/gateway_client.c
index 4ac24d8..6012e2b 100644
--- a/net/batman-adv/gateway_client.c
+++ b/net/batman-adv/gateway_client.c
@@ -435,6 +435,8 @@ static void batadv_gw_node_add(struct batadv_priv *bat_priv,
 
 	INIT_HLIST_NODE(&gw_node->list);
 	gw_node->orig_node = orig_node;
+	gw_node->bandwidth_down = ntohl(gateway->bandwidth_down);
+	gw_node->bandwidth_up = ntohl(gateway->bandwidth_up);
 	atomic_set(&gw_node->refcount, 1);
 
 	spin_lock_bh(&bat_priv->gw.list_lock);
-- 
2.5.0

