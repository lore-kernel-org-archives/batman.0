Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun,  4 Nov 2012 15:19:55 +0100
Message-Id: <1352038798-29658-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [RFC 1/4] batman-adv: Align skb for better alignment
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

The ethernet header is 14 bytes long. Therefore, the data after it is not 4
byte aligned and may cause problems on systems without unaligned data access.
Reserving NET_IP_ALIGN more bytes can fix the misalignment of the ethernet
header.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 bat_iv_ogm.c        |    2 +-
 icmp_socket.c       |    2 +-
 translation-table.c |   10 +++++-----
 vis.c               |    4 ++--
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/bat_iv_ogm.c b/bat_iv_ogm.c
index 75403a4..5be9a3e 100644
--- a/bat_iv_ogm.c
+++ b/bat_iv_ogm.c
@@ -422,7 +422,7 @@ static void batadv_iv_ogm_aggregate_new(const unsigned char *packet_buff,
 		kfree(forw_packet_aggr);
 		goto out;
 	}
-	skb_reserve(forw_packet_aggr->skb, ETH_HLEN);
+	skb_reserve(forw_packet_aggr->skb, ETH_HLEN + NET_IP_ALIGN);
 
 	INIT_HLIST_NODE(&forw_packet_aggr->list);
 
diff --git a/icmp_socket.c b/icmp_socket.c
index 5874c0e..f64e9c8 100644
--- a/icmp_socket.c
+++ b/icmp_socket.c
@@ -183,7 +183,7 @@ static ssize_t batadv_socket_write(struct file *file, const char __user *buff,
 		goto out;
 	}
 
-	skb_reserve(skb, ETH_HLEN);
+	skb_reserve(skb, ETH_HLEN + NET_IP_ALIGN);
 	icmp_packet = (struct batadv_icmp_packet_rr *)skb_put(skb, packet_len);
 
 	if (copy_from_user(icmp_packet, buff, packet_len)) {
diff --git a/translation-table.c b/translation-table.c
index 6fecb94..bb3941c 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -1598,7 +1598,7 @@ batadv_tt_response_fill_table(uint16_t tt_len, uint8_t ttvn,
 	if (!skb)
 		goto out;
 
-	skb_reserve(skb, ETH_HLEN);
+	skb_reserve(skb, ETH_HLEN + NET_IP_ALIGN);
 	tt_response = (struct batadv_tt_query_packet *)skb_put(skb, len);
 	tt_response->ttvn = ttvn;
 
@@ -1663,7 +1663,7 @@ static int batadv_send_tt_request(struct batadv_priv *bat_priv,
 	if (!skb)
 		goto out;
 
-	skb_reserve(skb, ETH_HLEN);
+	skb_reserve(skb, ETH_HLEN + NET_IP_ALIGN);
 
 	tt_req_len = sizeof(*tt_request);
 	tt_request = (struct batadv_tt_query_packet *)skb_put(skb, tt_req_len);
@@ -1765,7 +1765,7 @@ batadv_send_other_tt_response(struct batadv_priv *bat_priv,
 		if (!skb)
 			goto unlock;
 
-		skb_reserve(skb, ETH_HLEN);
+		skb_reserve(skb, ETH_HLEN + NET_IP_ALIGN);
 		packet_pos = skb_put(skb, len);
 		tt_response = (struct batadv_tt_query_packet *)packet_pos;
 		tt_response->ttvn = req_ttvn;
@@ -1884,7 +1884,7 @@ batadv_send_my_tt_response(struct batadv_priv *bat_priv,
 		if (!skb)
 			goto unlock;
 
-		skb_reserve(skb, ETH_HLEN);
+		skb_reserve(skb, ETH_HLEN + NET_IP_ALIGN);
 		packet_pos = skb_put(skb, len);
 		tt_response = (struct batadv_tt_query_packet *)packet_pos;
 		tt_response->ttvn = req_ttvn;
@@ -2215,7 +2215,7 @@ static void batadv_send_roam_adv(struct batadv_priv *bat_priv, uint8_t *client,
 	if (!skb)
 		goto out;
 
-	skb_reserve(skb, ETH_HLEN);
+	skb_reserve(skb, ETH_HLEN + NET_IP_ALIGN);
 
 	roam_adv_packet = (struct batadv_roam_adv_packet *)skb_put(skb, len);
 
diff --git a/vis.c b/vis.c
index 79589a3..b004560 100644
--- a/vis.c
+++ b/vis.c
@@ -401,7 +401,7 @@ batadv_add_packet(struct batadv_priv *bat_priv,
 		kfree(info);
 		return NULL;
 	}
-	skb_reserve(info->skb_packet, ETH_HLEN);
+	skb_reserve(info->skb_packet, ETH_HLEN + NET_IP_ALIGN);
 	packet = (struct batadv_vis_packet *)skb_put(info->skb_packet, len);
 
 	kref_init(&info->refcount);
@@ -861,7 +861,7 @@ int batadv_vis_init(struct batadv_priv *bat_priv)
 	if (!bat_priv->vis.my_info->skb_packet)
 		goto free_info;
 
-	skb_reserve(bat_priv->vis.my_info->skb_packet, ETH_HLEN);
+	skb_reserve(bat_priv->vis.my_info->skb_packet, ETH_HLEN + NET_IP_ALIGN);
 	tmp_skb = bat_priv->vis.my_info->skb_packet;
 	packet = (struct batadv_vis_packet *)skb_put(tmp_skb, sizeof(*packet));
 
-- 
1.7.10.4

