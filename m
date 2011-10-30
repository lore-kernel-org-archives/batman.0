Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Sun, 30 Oct 2011 23:51:12 +0100
Message-Id: <1320015072-10313-12-git-send-email-siwu@hrz.tu-chemnitz.de>
In-Reply-To: <1320015072-10313-1-git-send-email-siwu@hrz.tu-chemnitz.de>
References: <1320015072-10313-1-git-send-email-siwu@hrz.tu-chemnitz.de>
Subject: [B.A.T.M.A.N.] [RFC 11/11] [RFC] batman-adv: get primaries address
	through bat_priv->own_orig
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>

Instead of acquiring the first interfaces originator through
hard interface (including referencing/dereferencing), we can use the
cached value in bat_priv->own_orig.

There might be some cases where this function was implicitly used to
check whether there is a hard interface configured at all (i.e. if
batman is active), therfore this is patch is an RFC.

Signed-off-by: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
---
 icmp_socket.c       |   12 +-----------
 routing.c           |   25 +++----------------------
 translation-table.c |   16 ++--------------
 unicast.c           |    9 +--------
 vis.c               |   20 ++------------------
 5 files changed, 9 insertions(+), 73 deletions(-)

diff --git a/icmp_socket.c b/icmp_socket.c
index ac3520e..86dcffd 100644
--- a/icmp_socket.c
+++ b/icmp_socket.c
@@ -153,7 +153,6 @@ static ssize_t bat_socket_write(struct file *file, const char __user *buff,
 {
 	struct socket_client *socket_client = file->private_data;
 	struct bat_priv *bat_priv = socket_client->bat_priv;
-	struct hard_iface *primary_if = NULL;
 	struct sk_buff *skb;
 	struct icmp_packet_rr *icmp_packet;
 
@@ -168,13 +167,6 @@ static ssize_t bat_socket_write(struct file *file, const char __user *buff,
 		return -EINVAL;
 	}
 
-	primary_if = primary_if_get_selected(bat_priv);
-
-	if (!primary_if) {
-		len = -EFAULT;
-		goto out;
-	}
-
 	if (len >= sizeof(struct icmp_packet_rr))
 		packet_len = sizeof(struct icmp_packet_rr);
 
@@ -240,7 +232,7 @@ static ssize_t bat_socket_write(struct file *file, const char __user *buff,
 		goto dst_unreach;
 
 	memcpy(icmp_packet->orig,
-	       primary_if->net_dev->dev_addr, ETH_ALEN);
+	       bat_priv->own_orig, ETH_ALEN);
 
 	if (packet_len == sizeof(struct icmp_packet_rr))
 		memcpy(icmp_packet->rr,
@@ -255,8 +247,6 @@ dst_unreach:
 free_skb:
 	kfree_skb(skb);
 out:
-	if (primary_if)
-		hardif_free_ref(primary_if);
 	if (neigh_node)
 		neigh_node_free_ref(neigh_node);
 	if (orig_node)
diff --git a/routing.c b/routing.c
index 00e5339..5ef6f75 100644
--- a/routing.c
+++ b/routing.c
@@ -284,7 +284,6 @@ int recv_bat_ogm_packet(struct sk_buff *skb, struct hard_iface *hard_iface)
 static int recv_my_icmp_packet(struct bat_priv *bat_priv,
 			       struct sk_buff *skb, size_t icmp_len)
 {
-	struct hard_iface *primary_if = NULL;
 	struct orig_node *orig_node = NULL;
 	struct neigh_node *router = NULL;
 	struct icmp_packet_rr *icmp_packet;
@@ -298,10 +297,6 @@ static int recv_my_icmp_packet(struct bat_priv *bat_priv,
 		goto out;
 	}
 
-	primary_if = primary_if_get_selected(bat_priv);
-	if (!primary_if)
-		goto out;
-
 	/* answer echo request (ping) */
 	/* get routing information */
 	orig_node = orig_hash_find(bat_priv, icmp_packet->orig);
@@ -319,7 +314,7 @@ static int recv_my_icmp_packet(struct bat_priv *bat_priv,
 	icmp_packet = (struct icmp_packet_rr *)skb->data;
 
 	memcpy(icmp_packet->dst, icmp_packet->orig, ETH_ALEN);
-	memcpy(icmp_packet->orig, primary_if->net_dev->dev_addr, ETH_ALEN);
+	memcpy(icmp_packet->orig, bat_priv->own_orig, ETH_ALEN);
 	icmp_packet->msg_type = ECHO_REPLY;
 	icmp_packet->ttl = TTL;
 
@@ -327,8 +322,6 @@ static int recv_my_icmp_packet(struct bat_priv *bat_priv,
 	ret = NET_RX_SUCCESS;
 
 out:
-	if (primary_if)
-		hardif_free_ref(primary_if);
 	if (router)
 		neigh_node_free_ref(router);
 	if (orig_node)
@@ -339,7 +332,6 @@ out:
 static int recv_icmp_ttl_exceeded(struct bat_priv *bat_priv,
 				  struct sk_buff *skb)
 {
-	struct hard_iface *primary_if = NULL;
 	struct orig_node *orig_node = NULL;
 	struct neigh_node *router = NULL;
 	struct icmp_packet *icmp_packet;
@@ -355,10 +347,6 @@ static int recv_icmp_ttl_exceeded(struct bat_priv *bat_priv,
 		goto out;
 	}
 
-	primary_if = primary_if_get_selected(bat_priv);
-	if (!primary_if)
-		goto out;
-
 	/* get routing information */
 	orig_node = orig_hash_find(bat_priv, icmp_packet->orig);
 	if (!orig_node)
@@ -375,7 +363,7 @@ static int recv_icmp_ttl_exceeded(struct bat_priv *bat_priv,
 	icmp_packet = (struct icmp_packet *)skb->data;
 
 	memcpy(icmp_packet->dst, icmp_packet->orig, ETH_ALEN);
-	memcpy(icmp_packet->orig, primary_if->net_dev->dev_addr, ETH_ALEN);
+	memcpy(icmp_packet->orig, bat_priv->own_orig, ETH_ALEN);
 	icmp_packet->msg_type = TTL_EXCEEDED;
 	icmp_packet->ttl = TTL;
 
@@ -383,8 +371,6 @@ static int recv_icmp_ttl_exceeded(struct bat_priv *bat_priv,
 	ret = NET_RX_SUCCESS;
 
 out:
-	if (primary_if)
-		hardif_free_ref(primary_if);
 	if (router)
 		neigh_node_free_ref(router);
 	if (orig_node)
@@ -894,7 +880,6 @@ static int check_unicast_ttvn(struct bat_priv *bat_priv,
 	uint8_t curr_ttvn;
 	struct orig_node *orig_node;
 	struct ethhdr *ethhdr;
-	struct hard_iface *primary_if;
 	struct unicast_packet *unicast_packet;
 	bool tt_poss_change;
 
@@ -931,12 +916,8 @@ static int check_unicast_ttvn(struct bat_priv *bat_priv,
 		if (!orig_node) {
 			if (!is_my_client(bat_priv, ethhdr->h_dest))
 				return 0;
-			primary_if = primary_if_get_selected(bat_priv);
-			if (!primary_if)
-				return 0;
 			memcpy(unicast_packet->dest,
-			       primary_if->net_dev->dev_addr, ETH_ALEN);
-			hardif_free_ref(primary_if);
+			       bat_priv->own_orig, ETH_ALEN);
 		} else {
 			memcpy(unicast_packet->dest, orig_node->orig,
 			       ETH_ALEN);
diff --git a/translation-table.c b/translation-table.c
index 06a51e5..486f464 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -1195,14 +1195,9 @@ static int send_tt_request(struct bat_priv *bat_priv,
 	struct sk_buff *skb = NULL;
 	struct tt_query_packet *tt_request;
 	struct neigh_node *neigh_node = NULL;
-	struct hard_iface *primary_if;
 	struct tt_req_node *tt_req_node = NULL;
 	int ret = 1;
 
-	primary_if = primary_if_get_selected(bat_priv);
-	if (!primary_if)
-		goto out;
-
 	/* The new tt_req will be issued only if I'm not waiting for a
 	 * reply from the same orig_node yet */
 	tt_req_node = new_tt_req_node(bat_priv, dst_orig_node);
@@ -1220,7 +1215,7 @@ static int send_tt_request(struct bat_priv *bat_priv,
 
 	tt_request->packet_type = BAT_TT_QUERY;
 	tt_request->version = COMPAT_VERSION;
-	memcpy(tt_request->src, primary_if->net_dev->dev_addr, ETH_ALEN);
+	memcpy(tt_request->src, bat_priv->own_orig, ETH_ALEN);
 	memcpy(tt_request->dst, dst_orig_node->orig, ETH_ALEN);
 	tt_request->ttl = TTL;
 	tt_request->ttvn = ttvn;
@@ -1244,8 +1239,6 @@ static int send_tt_request(struct bat_priv *bat_priv,
 out:
 	if (neigh_node)
 		neigh_node_free_ref(neigh_node);
-	if (primary_if)
-		hardif_free_ref(primary_if);
 	if (ret)
 		kfree_skb(skb);
 	if (ret && tt_req_node) {
@@ -1745,7 +1738,6 @@ void send_roam_adv(struct bat_priv *bat_priv, uint8_t *client,
 	struct sk_buff *skb = NULL;
 	struct roam_adv_packet *roam_adv_packet;
 	int ret = 1;
-	struct hard_iface *primary_if;
 
 	/* before going on we have to check whether the client has
 	 * already roamed to us too many times */
@@ -1764,11 +1756,7 @@ void send_roam_adv(struct bat_priv *bat_priv, uint8_t *client,
 	roam_adv_packet->packet_type = BAT_ROAM_ADV;
 	roam_adv_packet->version = COMPAT_VERSION;
 	roam_adv_packet->ttl = TTL;
-	primary_if = primary_if_get_selected(bat_priv);
-	if (!primary_if)
-		goto out;
-	memcpy(roam_adv_packet->src, primary_if->net_dev->dev_addr, ETH_ALEN);
-	hardif_free_ref(primary_if);
+	memcpy(roam_adv_packet->src, bat_priv->own_orig, ETH_ALEN);
 	memcpy(roam_adv_packet->dst, orig_node->orig, ETH_ALEN);
 	memcpy(roam_adv_packet->client, client, ETH_ALEN);
 
diff --git a/unicast.c b/unicast.c
index 07d1c1d..733da47 100644
--- a/unicast.c
+++ b/unicast.c
@@ -220,7 +220,6 @@ int frag_send_skb(struct sk_buff *skb, struct bat_priv *bat_priv,
 		  struct hard_iface *hard_iface, const uint8_t dstaddr[])
 {
 	struct unicast_packet tmp_uc, *unicast_packet;
-	struct hard_iface *primary_if;
 	struct sk_buff *frag_skb;
 	struct unicast_frag_packet *frag1, *frag2;
 	int uc_hdr_len = sizeof(*unicast_packet);
@@ -229,10 +228,6 @@ int frag_send_skb(struct sk_buff *skb, struct bat_priv *bat_priv,
 	int large_tail = 0, ret = NET_RX_DROP;
 	uint16_t seqno;
 
-	primary_if = primary_if_get_selected(bat_priv);
-	if (!primary_if)
-		goto dropped;
-
 	frag_skb = dev_alloc_skb(data_len - (data_len / 2) + ucf_hdr_len);
 	if (!frag_skb)
 		goto dropped;
@@ -255,7 +250,7 @@ int frag_send_skb(struct sk_buff *skb, struct bat_priv *bat_priv,
 	frag1->version = COMPAT_VERSION;
 	frag1->packet_type = BAT_UNICAST_FRAG;
 
-	memcpy(frag1->orig, primary_if->net_dev->dev_addr, ETH_ALEN);
+	memcpy(frag1->orig, bat_priv->own_orig, ETH_ALEN);
 	memcpy(frag2, frag1, sizeof(*frag2));
 
 	if (data_len & 1)
@@ -278,8 +273,6 @@ drop_frag:
 dropped:
 	kfree_skb(skb);
 out:
-	if (primary_if)
-		hardif_free_ref(primary_if);
 	return ret;
 }
 
diff --git a/vis.c b/vis.c
index 7445413..e08ecd7 100644
--- a/vis.c
+++ b/vis.c
@@ -190,7 +190,6 @@ static ssize_t vis_data_read_entry(char *buff,
 
 int vis_seq_print_text(struct seq_file *seq, void *offset)
 {
-	struct hard_iface *primary_if;
 	struct hlist_node *node;
 	struct hlist_head *head;
 	struct vis_info *info;
@@ -209,10 +208,6 @@ int vis_seq_print_text(struct seq_file *seq, void *offset)
 	char *buff;
 	int compare;
 
-	primary_if = primary_if_get_selected(bat_priv);
-	if (!primary_if)
-		goto out;
-
 	if (vis_server == VIS_TYPE_CLIENT_UPDATE)
 		goto out;
 
@@ -321,8 +316,6 @@ int vis_seq_print_text(struct seq_file *seq, void *offset)
 	kfree(buff);
 
 out:
-	if (primary_if)
-		hardif_free_ref(primary_if);
 	return ret;
 }
 
@@ -810,20 +803,15 @@ out:
 /* only send one vis packet. called from send_vis_packets() */
 static void send_vis_packet(struct bat_priv *bat_priv, struct vis_info *info)
 {
-	struct hard_iface *primary_if;
 	struct vis_packet *packet;
 
-	primary_if = primary_if_get_selected(bat_priv);
-	if (!primary_if)
-		goto out;
-
 	packet = (struct vis_packet *)info->skb_packet->data;
 	if (packet->ttl < 2) {
 		pr_debug("Error - can't send vis packet: ttl exceeded\n");
-		goto out;
+		return;
 	}
 
-	memcpy(packet->sender_orig, primary_if->net_dev->dev_addr, ETH_ALEN);
+	memcpy(packet->sender_orig, bat_priv->own_orig, ETH_ALEN);
 	packet->ttl--;
 
 	if (is_broadcast_ether_addr(packet->target_orig))
@@ -831,10 +819,6 @@ static void send_vis_packet(struct bat_priv *bat_priv, struct vis_info *info)
 	else
 		unicast_vis_packet(bat_priv, info);
 	packet->ttl++; /* restore TTL */
-
-out:
-	if (primary_if)
-		hardif_free_ref(primary_if);
 }
 
 /* called from timer; send (and maybe generate) vis packet. */
-- 
1.7.7.1

