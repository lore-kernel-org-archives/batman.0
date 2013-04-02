Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Tue,  2 Apr 2013 22:28:44 +0200
Message-Id: <1364934524-11764-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: don't deal with NET_IP_ALIGN
	manually
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

Instead of dealing with NET_IP_ALIGN during allocation and
headroom reservation, it is possible to use
netdev_alloc_skb_ip_align() which transparently allocate
and reserve the correct amount of data

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---

compat stuff: compiled tested only on 2.6.32

 bat_iv_ogm.c        |  6 +++---
 compat.h            | 10 ++++++++++
 icmp_socket.c       |  4 ++--
 translation-table.c | 20 ++++++++++----------
 vis.c               | 12 ++++++------
 5 files changed, 31 insertions(+), 21 deletions(-)

diff --git a/bat_iv_ogm.c b/bat_iv_ogm.c
index 071f288..197b1b0 100644
--- a/bat_iv_ogm.c
+++ b/bat_iv_ogm.c
@@ -413,16 +413,16 @@ static void batadv_iv_ogm_aggregate_new(const unsigned char *packet_buff,
 	else
 		skb_size = packet_len;
 
-	skb_size += ETH_HLEN + NET_IP_ALIGN;
+	skb_size += ETH_HLEN;
 
-	forw_packet_aggr->skb = dev_alloc_skb(skb_size);
+	forw_packet_aggr->skb = netdev_alloc_skb_ip_align(NULL, skb_size);
 	if (!forw_packet_aggr->skb) {
 		if (!own_packet)
 			atomic_inc(&bat_priv->batman_queue_left);
 		kfree(forw_packet_aggr);
 		goto out;
 	}
-	skb_reserve(forw_packet_aggr->skb, ETH_HLEN + NET_IP_ALIGN);
+	skb_reserve(forw_packet_aggr->skb, ETH_HLEN);
 
 	INIT_HLIST_NODE(&forw_packet_aggr->list);
 
diff --git a/compat.h b/compat.h
index 0663df5..617ad71 100644
--- a/compat.h
+++ b/compat.h
@@ -74,6 +74,16 @@ static inline void batadv_this_cpu_add(uint64_t *count_ptr, size_t count)
 #define batadv_softif_destroy_netlink(dev, head) batadv_softif_destroy_netlink(dev)
 #define unregister_netdevice_queue(dev, head) unregister_netdevice(dev)
 
+static inline struct sk_buff *netdev_alloc_skb_ip_align(struct net_device *dev,
+							unsigned int length)
+{
+	struct sk_buff *skb = netdev_alloc_skb(dev, length + NET_IP_ALIGN);
+
+	if (NET_IP_ALIGN && skb)
+		skb_reserve(skb, NET_IP_ALIGN);
+	return skb;
+}
+
 #endif /* < KERNEL_VERSION(2, 6, 33) */
 
 
diff --git a/icmp_socket.c b/icmp_socket.c
index 0ba6c89..b27508b 100644
--- a/icmp_socket.c
+++ b/icmp_socket.c
@@ -177,13 +177,13 @@ static ssize_t batadv_socket_write(struct file *file, const char __user *buff,
 	if (len >= sizeof(struct batadv_icmp_packet_rr))
 		packet_len = sizeof(struct batadv_icmp_packet_rr);
 
-	skb = dev_alloc_skb(packet_len + ETH_HLEN + NET_IP_ALIGN);
+	skb = netdev_alloc_skb_ip_align(NULL, packet_len + ETH_HLEN);
 	if (!skb) {
 		len = -ENOMEM;
 		goto out;
 	}
 
-	skb_reserve(skb, ETH_HLEN + NET_IP_ALIGN);
+	skb_reserve(skb, ETH_HLEN);
 	icmp_packet = (struct batadv_icmp_packet_rr *)skb_put(skb, packet_len);
 
 	if (copy_from_user(icmp_packet, buff, packet_len)) {
diff --git a/translation-table.c b/translation-table.c
index 9322320..61e6ea8 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -1595,11 +1595,11 @@ batadv_tt_response_fill_table(uint16_t tt_len, uint8_t ttvn,
 	tt_tot = tt_len / sizeof(struct batadv_tt_change);
 
 	len = tt_query_size + tt_len;
-	skb = dev_alloc_skb(len + ETH_HLEN + NET_IP_ALIGN);
+	skb = netdev_alloc_skb_ip_align(NULL, len + ETH_HLEN);
 	if (!skb)
 		goto out;
 
-	skb_reserve(skb, ETH_HLEN + NET_IP_ALIGN);
+	skb_reserve(skb, ETH_HLEN);
 	tt_response = (struct batadv_tt_query_packet *)skb_put(skb, len);
 	tt_response->ttvn = ttvn;
 
@@ -1660,11 +1660,11 @@ static int batadv_send_tt_request(struct batadv_priv *bat_priv,
 	if (!tt_req_node)
 		goto out;
 
-	skb = dev_alloc_skb(sizeof(*tt_request) + ETH_HLEN + NET_IP_ALIGN);
+	skb = netdev_alloc_skb_ip_align(NULL, sizeof(*tt_request) + ETH_HLEN);
 	if (!skb)
 		goto out;
 
-	skb_reserve(skb, ETH_HLEN + NET_IP_ALIGN);
+	skb_reserve(skb, ETH_HLEN);
 
 	tt_req_len = sizeof(*tt_request);
 	tt_request = (struct batadv_tt_query_packet *)skb_put(skb, tt_req_len);
@@ -1757,11 +1757,11 @@ batadv_send_other_tt_response(struct batadv_priv *bat_priv,
 		tt_tot = tt_len / sizeof(struct batadv_tt_change);
 
 		len = sizeof(*tt_response) + tt_len;
-		skb = dev_alloc_skb(len + ETH_HLEN + NET_IP_ALIGN);
+		skb = netdev_alloc_skb_ip_align(NULL, len + ETH_HLEN);
 		if (!skb)
 			goto unlock;
 
-		skb_reserve(skb, ETH_HLEN + NET_IP_ALIGN);
+		skb_reserve(skb, ETH_HLEN);
 		packet_pos = skb_put(skb, len);
 		tt_response = (struct batadv_tt_query_packet *)packet_pos;
 		tt_response->ttvn = req_ttvn;
@@ -1873,11 +1873,11 @@ batadv_send_my_tt_response(struct batadv_priv *bat_priv,
 		tt_tot = tt_len / sizeof(struct batadv_tt_change);
 
 		len = sizeof(*tt_response) + tt_len;
-		skb = dev_alloc_skb(len + ETH_HLEN + NET_IP_ALIGN);
+		skb = netdev_alloc_skb_ip_align(NULL, len + ETH_HLEN);
 		if (!skb)
 			goto unlock;
 
-		skb_reserve(skb, ETH_HLEN + NET_IP_ALIGN);
+		skb_reserve(skb, ETH_HLEN);
 		packet_pos = skb_put(skb, len);
 		tt_response = (struct batadv_tt_query_packet *)packet_pos;
 		tt_response->ttvn = req_ttvn;
@@ -2207,11 +2207,11 @@ static void batadv_send_roam_adv(struct batadv_priv *bat_priv, uint8_t *client,
 	if (!batadv_tt_check_roam_count(bat_priv, client))
 		goto out;
 
-	skb = dev_alloc_skb(sizeof(*roam_adv_packet) + ETH_HLEN + NET_IP_ALIGN);
+	skb = netdev_alloc_skb_ip_align(NULL, len + ETH_HLEN);
 	if (!skb)
 		goto out;
 
-	skb_reserve(skb, ETH_HLEN + NET_IP_ALIGN);
+	skb_reserve(skb, ETH_HLEN);
 
 	roam_adv_packet = (struct batadv_roam_adv_packet *)skb_put(skb, len);
 
diff --git a/vis.c b/vis.c
index 962ccf3..2c60ecd 100644
--- a/vis.c
+++ b/vis.c
@@ -392,12 +392,12 @@ batadv_add_packet(struct batadv_priv *bat_priv,
 		return NULL;
 
 	len = sizeof(*packet) + vis_info_len;
-	info->skb_packet = dev_alloc_skb(len + ETH_HLEN + NET_IP_ALIGN);
+	info->skb_packet = netdev_alloc_skb_ip_align(NULL, len + ETH_HLEN);
 	if (!info->skb_packet) {
 		kfree(info);
 		return NULL;
 	}
-	skb_reserve(info->skb_packet, ETH_HLEN + NET_IP_ALIGN);
+	skb_reserve(info->skb_packet, ETH_HLEN);
 	packet = (struct batadv_vis_packet *)skb_put(info->skb_packet, len);
 
 	kref_init(&info->refcount);
@@ -854,13 +854,13 @@ int batadv_vis_init(struct batadv_priv *bat_priv)
 	if (!bat_priv->vis.my_info)
 		goto err;
 
-	len = sizeof(*packet) + BATADV_MAX_VIS_PACKET_SIZE;
-	len += ETH_HLEN + NET_IP_ALIGN;
-	bat_priv->vis.my_info->skb_packet = dev_alloc_skb(len);
+	len = sizeof(*packet) + BATADV_MAX_VIS_PACKET_SIZE + ETH_HLEN;
+	bat_priv->vis.my_info->skb_packet = netdev_alloc_skb_ip_align(NULL,
+								      len);
 	if (!bat_priv->vis.my_info->skb_packet)
 		goto free_info;
 
-	skb_reserve(bat_priv->vis.my_info->skb_packet, ETH_HLEN + NET_IP_ALIGN);
+	skb_reserve(bat_priv->vis.my_info->skb_packet, ETH_HLEN);
 	tmp_skb = bat_priv->vis.my_info->skb_packet;
 	packet = (struct batadv_vis_packet *)skb_put(tmp_skb, sizeof(*packet));
 
-- 
1.8.1.5

