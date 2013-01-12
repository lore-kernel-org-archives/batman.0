Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sat, 12 Jan 2013 19:19:06 +0800
Message-Id: <1357989546-12762-1-git-send-email-lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: replace redudant primary_if_get
	calls
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
Cc: Marek Lindner <lindner_marek@yahoo.de>

The batadv_priv struct carries a pointer to its own interface
struct. Therefore, it is not necessary to retrieve the soft_iface
via the primary interface.

Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
---
 distributed-arp-table.c |   22 ++++------------------
 sysfs.c                 |   10 +---------
 translation-table.c     |   25 ++++++-------------------
 3 files changed, 11 insertions(+), 46 deletions(-)

diff --git a/distributed-arp-table.c b/distributed-arp-table.c
index 7485a78..71c4f53 100644
--- a/distributed-arp-table.c
+++ b/distributed-arp-table.c
@@ -804,7 +804,6 @@ bool batadv_dat_snoop_outgoing_arp_request(struct batadv_priv *bat_priv,
 	bool ret = false;
 	struct batadv_dat_entry *dat_entry = NULL;
 	struct sk_buff *skb_new;
-	struct batadv_hard_iface *primary_if = NULL;
 
 	if (!atomic_read(&bat_priv->distributed_arp_table))
 		goto out;
@@ -826,22 +825,18 @@ bool batadv_dat_snoop_outgoing_arp_request(struct batadv_priv *bat_priv,
 
 	dat_entry = batadv_dat_entry_hash_find(bat_priv, ip_dst);
 	if (dat_entry) {
-		primary_if = batadv_primary_if_get_selected(bat_priv);
-		if (!primary_if)
-			goto out;
-
 		skb_new = arp_create(ARPOP_REPLY, ETH_P_ARP, ip_src,
-				     primary_if->soft_iface, ip_dst, hw_src,
+				     bat_priv->soft_iface, ip_dst, hw_src,
 				     dat_entry->mac_addr, hw_src);
 		if (!skb_new)
 			goto out;
 
 		skb_reset_mac_header(skb_new);
 		skb_new->protocol = eth_type_trans(skb_new,
-						   primary_if->soft_iface);
+						   bat_priv->soft_iface);
 		bat_priv->stats.rx_packets++;
 		bat_priv->stats.rx_bytes += skb->len + ETH_HLEN;
-		primary_if->soft_iface->last_rx = jiffies;
+		bat_priv->soft_iface->last_rx = jiffies;
 
 		netif_rx(skb_new);
 		batadv_dbg(BATADV_DBG_DAT, bat_priv, "ARP request replied locally\n");
@@ -854,8 +849,6 @@ bool batadv_dat_snoop_outgoing_arp_request(struct batadv_priv *bat_priv,
 out:
 	if (dat_entry)
 		batadv_dat_entry_free_ref(dat_entry);
-	if (primary_if)
-		batadv_hardif_free_ref(primary_if);
 	return ret;
 }
 
@@ -875,7 +868,6 @@ bool batadv_dat_snoop_incoming_arp_request(struct batadv_priv *bat_priv,
 	__be32 ip_src, ip_dst;
 	uint8_t *hw_src;
 	struct sk_buff *skb_new;
-	struct batadv_hard_iface *primary_if = NULL;
 	struct batadv_dat_entry *dat_entry = NULL;
 	bool ret = false;
 	int err;
@@ -900,12 +892,8 @@ bool batadv_dat_snoop_incoming_arp_request(struct batadv_priv *bat_priv,
 	if (!dat_entry)
 		goto out;
 
-	primary_if = batadv_primary_if_get_selected(bat_priv);
-	if (!primary_if)
-		goto out;
-
 	skb_new = arp_create(ARPOP_REPLY, ETH_P_ARP, ip_src,
-			     primary_if->soft_iface, ip_dst, hw_src,
+			     bat_priv->soft_iface, ip_dst, hw_src,
 			     dat_entry->mac_addr, hw_src);
 
 	if (!skb_new)
@@ -929,8 +917,6 @@ bool batadv_dat_snoop_incoming_arp_request(struct batadv_priv *bat_priv,
 out:
 	if (dat_entry)
 		batadv_dat_entry_free_ref(dat_entry);
-	if (primary_if)
-		batadv_hardif_free_ref(primary_if);
 	if (ret)
 		kfree_skb(skb);
 	return ret;
diff --git a/sysfs.c b/sysfs.c
index afbba31..6a44fed 100644
--- a/sysfs.c
+++ b/sysfs.c
@@ -688,15 +688,10 @@ int batadv_throw_uevent(struct batadv_priv *bat_priv, enum batadv_uev_type type,
 			enum batadv_uev_action action, const char *data)
 {
 	int ret = -ENOMEM;
-	struct batadv_hard_iface *primary_if;
 	struct kobject *bat_kobj;
 	char *uevent_env[4] = { NULL, NULL, NULL, NULL };
 
-	primary_if = batadv_primary_if_get_selected(bat_priv);
-	if (!primary_if)
-		goto out;
-
-	bat_kobj = &primary_if->soft_iface->dev.kobj;
+	bat_kobj = &bat_priv->soft_iface->dev.kobj;
 
 	uevent_env[0] = kmalloc(strlen(BATADV_UEV_TYPE_VAR) +
 				strlen(batadv_uev_type_str[type]) + 1,
@@ -732,9 +727,6 @@ out:
 	kfree(uevent_env[1]);
 	kfree(uevent_env[2]);
 
-	if (primary_if)
-		batadv_hardif_free_ref(primary_if);
-
 	if (ret)
 		batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
 			   "Impossible to send uevent for (%s,%s,%s) event (err: %d)\n",
diff --git a/translation-table.c b/translation-table.c
index fb15b4c..607fd3c 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -387,25 +387,19 @@ static void batadv_tt_prepare_packet_buff(struct batadv_priv *bat_priv,
 					  int *packet_buff_len,
 					  int min_packet_len)
 {
-	struct batadv_hard_iface *primary_if;
 	int req_len;
 
-	primary_if = batadv_primary_if_get_selected(bat_priv);
-
 	req_len = min_packet_len;
 	req_len += batadv_tt_len(atomic_read(&bat_priv->tt.local_changes));
 
 	/* if we have too many changes for one packet don't send any
 	 * and wait for the tt table request which will be fragmented
 	 */
-	if ((!primary_if) || (req_len > primary_if->soft_iface->mtu))
+	if (req_len > bat_priv->soft_iface->mtu)
 		req_len = min_packet_len;
 
 	batadv_tt_realloc_packet_buff(packet_buff, packet_buff_len,
 				      min_packet_len, req_len);
-
-	if (primary_if)
-		batadv_hardif_free_ref(primary_if);
 }
 
 static int batadv_tt_changes_fill_buff(struct batadv_priv *bat_priv,
@@ -1590,7 +1584,7 @@ static int batadv_tt_global_valid(const void *entry_ptr,
 static struct sk_buff *
 batadv_tt_response_fill_table(uint16_t tt_len, uint8_t ttvn,
 			      struct batadv_hashtable *hash,
-			      struct batadv_hard_iface *primary_if,
+			      struct batadv_priv *bat_priv,
 			      int (*valid_cb)(const void *, const void *),
 			      void *cb_data)
 {
@@ -1605,8 +1599,8 @@ batadv_tt_response_fill_table(uint16_t tt_len, uint8_t ttvn,
 	uint32_t i;
 	size_t len;
 
-	if (tt_query_size + tt_len > primary_if->soft_iface->mtu) {
-		tt_len = primary_if->soft_iface->mtu - tt_query_size;
+	if (tt_query_size + tt_len > bat_priv->soft_iface->mtu) {
+		tt_len = bat_priv->soft_iface->mtu - tt_query_size;
 		tt_len -= tt_len % sizeof(struct batadv_tt_change);
 	}
 	tt_tot = tt_len / sizeof(struct batadv_tt_change);
@@ -1726,7 +1720,6 @@ batadv_send_other_tt_response(struct batadv_priv *bat_priv,
 {
 	struct batadv_orig_node *req_dst_orig_node;
 	struct batadv_orig_node *res_dst_orig_node = NULL;
-	struct batadv_hard_iface *primary_if = NULL;
 	uint8_t orig_ttvn, req_ttvn, ttvn;
 	int ret = false;
 	unsigned char *tt_buff;
@@ -1751,10 +1744,6 @@ batadv_send_other_tt_response(struct batadv_priv *bat_priv,
 	if (!res_dst_orig_node)
 		goto out;
 
-	primary_if = batadv_primary_if_get_selected(bat_priv);
-	if (!primary_if)
-		goto out;
-
 	orig_ttvn = (uint8_t)atomic_read(&req_dst_orig_node->last_ttvn);
 	req_ttvn = tt_request->ttvn;
 
@@ -1802,7 +1791,7 @@ batadv_send_other_tt_response(struct batadv_priv *bat_priv,
 
 		skb = batadv_tt_response_fill_table(tt_len, ttvn,
 						    bat_priv->tt.global_hash,
-						    primary_if,
+						    bat_priv,
 						    batadv_tt_global_valid,
 						    req_dst_orig_node);
 		if (!skb)
@@ -1839,8 +1828,6 @@ out:
 		batadv_orig_node_free_ref(res_dst_orig_node);
 	if (req_dst_orig_node)
 		batadv_orig_node_free_ref(req_dst_orig_node);
-	if (primary_if)
-		batadv_hardif_free_ref(primary_if);
 	if (!ret)
 		kfree_skb(skb);
 	return ret;
@@ -1918,7 +1905,7 @@ batadv_send_my_tt_response(struct batadv_priv *bat_priv,
 
 		skb = batadv_tt_response_fill_table(tt_len, ttvn,
 						    bat_priv->tt.local_hash,
-						    primary_if,
+						    bat_priv,
 						    batadv_tt_local_valid_entry,
 						    NULL);
 		if (!skb)
-- 
1.7.10.4

