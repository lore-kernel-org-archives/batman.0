Return-Path: <a@unstable.cc>
From: Antonio Quartulli <a@unstable.cc>
Date: Tue, 10 May 2016 18:06:09 +0800
Message-Id: <1462874769-5077-5-git-send-email-a@unstable.cc>
In-Reply-To: <1462874769-5077-1-git-send-email-a@unstable.cc>
References: <1462874769-5077-1-git-send-email-a@unstable.cc>
Subject: [B.A.T.M.A.N.] [PATCH v2 5/5] batman-adv: B.A.T.M.A.N. V -
	implement GW selection logic
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
Cc: Antonio Quartulli <a@unstable.cc>

Since the GW selection logic has been made routing protocol specific
it is now possible for B.A.T.M.A.N V to have its own mechanism by
providing the API implementation.

Implement the GW specific API in the B.A.T.M.A.N. V protocol in
order to provide a working GW selection mechanism.

Signed-off-by: Antonio Quartulli <a@unstable.cc>
---

Changes from v1:
- add missing include
- declare batadv_gw_node_get() in gateway_client.h only if
  CONFIG_BATMAN_ADV_BATMAN_V was defined


 net/batman-adv/bat_v.c          | 193 +++++++++++++++++++++++++++++++++++++++-
 net/batman-adv/gateway_client.c |   5 +-
 net/batman-adv/gateway_client.h |   4 +
 3 files changed, 198 insertions(+), 4 deletions(-)

diff --git a/net/batman-adv/bat_v.c b/net/batman-adv/bat_v.c
index df21342..123c0d7 100644
--- a/net/batman-adv/bat_v.c
+++ b/net/batman-adv/bat_v.c
@@ -25,6 +25,7 @@
 #include <linux/init.h>
 #include <linux/jiffies.h>
 #include <linux/kernel.h>
+#include <linux/kref.h>
 #include <linux/netdevice.h>
 #include <linux/rculist.h>
 #include <linux/rcupdate.h>
@@ -354,6 +355,184 @@ static ssize_t batadv_v_show_sel_class(struct batadv_priv *bat_priv, char *buff)
 	return sprintf(buff, "%u.%u MBit\n", class / 10, class % 10);
 }
 
+static int batadv_v_gw_throughput_get(struct batadv_gw_node *gw_node, u32 *bw)
+{
+	struct batadv_neigh_ifinfo *router_ifinfo = NULL;
+	struct batadv_orig_node *orig_node;
+	struct batadv_neigh_node *router;
+	int ret = -1;
+
+	orig_node = gw_node->orig_node;
+	router = batadv_orig_router_get(orig_node, BATADV_IF_DEFAULT);
+	if (!router)
+		goto out;
+
+	router_ifinfo = batadv_neigh_ifinfo_get(router, BATADV_IF_DEFAULT);
+	if (!router_ifinfo)
+		goto out;
+
+	/* the GW metric is computed as the minimum between the path throughput
+	 * to reach the GW itself and the advertised bandwidth.
+	 * This gives us an approximation of the effective throughput that the
+	 * client can expect via this particular GW node
+	 */
+	*bw = router_ifinfo->bat_v.throughput;
+	*bw = min_t(u32, *bw, gw_node->bandwidth_down);
+
+	ret = 0;
+out:
+	if (router)
+		batadv_neigh_node_put(router);
+	if (router_ifinfo)
+		batadv_neigh_ifinfo_put(router_ifinfo);
+
+	return ret;
+}
+
+static struct batadv_gw_node *
+batadv_v_gw_get_best_gw_node(struct batadv_priv *bat_priv)
+{
+	struct batadv_gw_node *gw_node, *curr_gw = NULL;
+	u32 max_bw = 0, bw, threshold;
+
+	threshold = atomic_read(&bat_priv->gw.sel_class);
+
+	rcu_read_lock();
+	hlist_for_each_entry_rcu(gw_node, &bat_priv->gw.list, list) {
+		if (!kref_get_unless_zero(&gw_node->refcount))
+			continue;
+
+		if (batadv_v_gw_throughput_get(gw_node, &bw) < 0)
+			goto next;
+
+		if (curr_gw && (bw <= (max_bw + threshold)))
+			goto next;
+
+		if (curr_gw)
+			batadv_gw_node_put(curr_gw);
+
+		curr_gw = gw_node;
+		kref_get(&curr_gw->refcount);
+		max_bw = bw;
+
+next:
+		batadv_gw_node_put(gw_node);
+	}
+	rcu_read_unlock();
+
+	return curr_gw;
+}
+
+static bool batadv_v_gw_is_eligible(struct batadv_priv *bat_priv,
+				    struct batadv_orig_node *curr_gw_orig,
+				    struct batadv_orig_node *orig_node)
+{
+	struct batadv_gw_node *curr_gw = NULL, *orig_gw = NULL;
+	u32 gw_throughput, orig_throughput, threshold;
+	bool ret = false;
+
+	threshold = atomic_read(&bat_priv->gw.sel_class);
+
+	curr_gw = batadv_gw_node_get(bat_priv, curr_gw_orig);
+	if (!curr_gw) {
+		ret = true;
+		goto out;
+	}
+
+	if (batadv_v_gw_throughput_get(curr_gw, &gw_throughput) < 0) {
+		ret = true;
+		goto out;
+	}
+
+	orig_gw = batadv_gw_node_get(bat_priv, orig_node);
+	if (!orig_node)
+		goto out;
+
+	if (batadv_v_gw_throughput_get(orig_gw, &orig_throughput) < 0)
+		goto out;
+
+	if (orig_throughput < (gw_throughput + threshold))
+		goto out;
+
+	batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
+		   "Restarting gateway selection: better gateway found (throughput curr: %u, throughput new: %u)\n",
+		   gw_throughput, orig_throughput);
+
+	ret = true;
+out:
+	if (curr_gw)
+		batadv_gw_node_put(curr_gw);
+	if (orig_gw)
+		batadv_gw_node_put(orig_gw);
+
+	return ret;
+}
+
+/* fails if orig_node has no router */
+static int batadv_v_gw_write_buffer_text(struct batadv_priv *bat_priv,
+					 struct seq_file *seq,
+					 const struct batadv_gw_node *gw_node)
+{
+	struct batadv_gw_node *curr_gw;
+	struct batadv_neigh_node *router;
+	struct batadv_neigh_ifinfo *router_ifinfo = NULL;
+	int ret = -1;
+
+	router = batadv_orig_router_get(gw_node->orig_node, BATADV_IF_DEFAULT);
+	if (!router)
+		goto out;
+
+	router_ifinfo = batadv_neigh_ifinfo_get(router, BATADV_IF_DEFAULT);
+	if (!router_ifinfo)
+		goto out;
+
+	curr_gw = batadv_gw_get_selected_gw_node(bat_priv);
+
+	seq_printf(seq, "%s %pM (%9u.%1u) %pM [%10s]: %u.%u/%u.%u MBit\n",
+		   (curr_gw == gw_node ? "=>" : "  "),
+		   gw_node->orig_node->orig,
+		   router_ifinfo->bat_v.throughput / 10,
+		   router_ifinfo->bat_v.throughput % 10, router->addr,
+		   router->if_incoming->net_dev->name,
+		   gw_node->bandwidth_down / 10,
+		   gw_node->bandwidth_down % 10,
+		   gw_node->bandwidth_up / 10,
+		   gw_node->bandwidth_up % 10);
+	ret = seq_has_overflowed(seq) ? -1 : 0;
+
+	if (curr_gw)
+		batadv_gw_node_put(curr_gw);
+out:
+	if (router_ifinfo)
+		batadv_neigh_ifinfo_put(router_ifinfo);
+	if (router)
+		batadv_neigh_node_put(router);
+	return ret;
+}
+
+static void batadv_v_gw_print(struct batadv_priv *bat_priv,
+			      struct seq_file *seq)
+{
+	struct batadv_gw_node *gw_node;
+	int gw_count = 0;
+
+	seq_printf(seq,
+		   "      Gateway        ( throughput)           Nexthop [outgoingIF]: advertised uplink bandwidth\n");
+
+	rcu_read_lock();
+	hlist_for_each_entry_rcu(gw_node, &bat_priv->gw.list, list) {
+		/* fails if orig_node has no router */
+		if (batadv_v_gw_write_buffer_text(bat_priv, seq, gw_node) < 0)
+			continue;
+
+		gw_count++;
+	}
+	rcu_read_unlock();
+
+	if (gw_count == 0)
+		seq_puts(seq, "No gateways in range ...\n");
+}
+
 static struct batadv_algo_ops batadv_batman_v __read_mostly = {
 	.name = "BATMAN_V",
 	.iface = {
@@ -375,6 +554,9 @@ static struct batadv_algo_ops batadv_batman_v __read_mostly = {
 	.gw = {
 		.store_sel_class = batadv_v_store_sel_class,
 		.show_sel_class = batadv_v_show_sel_class,
+		.get_best_gw_node = batadv_v_gw_get_best_gw_node,
+		.is_eligible = batadv_v_gw_is_eligible,
+		.print = batadv_v_gw_print,
 	},
 };
 
@@ -387,7 +569,16 @@ static struct batadv_algo_ops batadv_batman_v __read_mostly = {
  */
 int batadv_v_mesh_init(struct batadv_priv *bat_priv)
 {
-	return batadv_v_ogm_init(bat_priv);
+	int ret = 0;
+
+	ret = batadv_v_ogm_init(bat_priv);
+	if (ret < 0)
+		return ret;
+
+	/* set default throughput difference threshold to 5Mbps */
+	atomic_set(&bat_priv->gw.sel_class, 50);
+
+	return 0;
 }
 
 /**
diff --git a/net/batman-adv/gateway_client.c b/net/batman-adv/gateway_client.c
index 5d3c1d2..cfa243d 100644
--- a/net/batman-adv/gateway_client.c
+++ b/net/batman-adv/gateway_client.c
@@ -352,9 +352,8 @@ static void batadv_gw_node_add(struct batadv_priv *bat_priv,
  *
  * Return: gateway node if found or NULL otherwise.
  */
-static struct batadv_gw_node *
-batadv_gw_node_get(struct batadv_priv *bat_priv,
-		   struct batadv_orig_node *orig_node)
+struct batadv_gw_node *batadv_gw_node_get(struct batadv_priv *bat_priv,
+					  struct batadv_orig_node *orig_node)
 {
 	struct batadv_gw_node *gw_node_tmp, *gw_node = NULL;
 
diff --git a/net/batman-adv/gateway_client.h b/net/batman-adv/gateway_client.h
index 4c9edde..00fa434 100644
--- a/net/batman-adv/gateway_client.h
+++ b/net/batman-adv/gateway_client.h
@@ -47,5 +47,9 @@ bool batadv_gw_out_of_range(struct batadv_priv *bat_priv, struct sk_buff *skb);
 enum batadv_dhcp_recipient
 batadv_gw_dhcp_recipient_get(struct sk_buff *skb, unsigned int *header_len,
 			     u8 *chaddr);
+#ifdef CONFIG_BATMAN_ADV_BATMAN_V
+struct batadv_gw_node *batadv_gw_node_get(struct batadv_priv *bat_priv,
+					  struct batadv_orig_node *orig_node);
+#endif /* CONFIG_BATMAN_ADV_BATMAN_V */
 
 #endif /* _NET_BATMAN_ADV_GATEWAY_CLIENT_H_ */
-- 
2.8.2

