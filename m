Return-Path: <joe@perches.com>
Message-ID: <1424136699.8287.10.camel@perches.com>
From: Joe Perches <joe@perches.com>
Date: Mon, 16 Feb 2015 17:31:39 -0800
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Remove uses of return value of
	seq_printf
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
To: Marek Lindner <mareklindner@neomailbox.ch>, Antonio Quartulli <antonio@meshcoding.com>
Cc: netdev <netdev@vger.kernel.org>, "b.a.t.m.a.n" <b.a.t.m.a.n@lists.open-mesh.org>, LKML <linux-kernel@vger.kernel.org>

This function is soon going to return void so remove the
return value use.

Convert the return value to test seq_has_overflowed() instead.

Signed-off-by: Joe Perches <joe@perches.com>
---
 net/batman-adv/gateway_client.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/net/batman-adv/gateway_client.c b/net/batman-adv/gateway_client.c
index 27649e8..a0876ea 100644
--- a/net/batman-adv/gateway_client.c
+++ b/net/batman-adv/gateway_client.c
@@ -592,15 +592,16 @@ static int batadv_write_buffer_text(struct batadv_priv *bat_priv,
 
 	curr_gw = batadv_gw_get_selected_gw_node(bat_priv);
 
-	ret = seq_printf(seq, "%s %pM (%3i) %pM [%10s]: %u.%u/%u.%u MBit\n",
-			 (curr_gw == gw_node ? "=>" : "  "),
-			 gw_node->orig_node->orig,
-			 router_ifinfo->bat_iv.tq_avg, router->addr,
-			 router->if_incoming->net_dev->name,
-			 gw_node->bandwidth_down / 10,
-			 gw_node->bandwidth_down % 10,
-			 gw_node->bandwidth_up / 10,
-			 gw_node->bandwidth_up % 10);
+	seq_printf(seq, "%s %pM (%3i) %pM [%10s]: %u.%u/%u.%u MBit\n",
+		   (curr_gw == gw_node ? "=>" : "  "),
+		   gw_node->orig_node->orig,
+		   router_ifinfo->bat_iv.tq_avg, router->addr,
+		   router->if_incoming->net_dev->name,
+		   gw_node->bandwidth_down / 10,
+		   gw_node->bandwidth_down % 10,
+		   gw_node->bandwidth_up / 10,
+		   gw_node->bandwidth_up % 10);
+	ret = seq_has_overflowed(seq);
 
 	if (curr_gw)
 		batadv_gw_node_free_ref(curr_gw);


