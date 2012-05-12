Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 12 May 2012 02:09:38 +0200
Message-Id: <1336781383-15649-18-git-send-email-sven@narfation.org>
In-Reply-To: <1336781383-15649-1-git-send-email-sven@narfation.org>
References: <1336781383-15649-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCHv3 18/23] batman-adv: Prefix soft-interface
	non-static functions with batadv_
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

batman-adv can be compiled as part of the kernel instead of an module. In that
case the linker will see all non-static symbols of batman-adv and all other
non-static symbols of the kernel. This could lead to symbol collisions. A
prefix for the batman-adv symbols that defines their private namespace avoids
such a problem.

Reported-by: David Miller <davem@davemloft.net>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 hard-interface.c |    8 ++++----
 routing.c        |    9 +++++----
 send.c           |    2 +-
 soft-interface.c |   16 ++++++++--------
 soft-interface.h |   13 ++++++-------
 unicast.c        |    6 +++---
 6 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/hard-interface.c b/hard-interface.c
index ce75b12..3845d32 100644
--- a/hard-interface.c
+++ b/hard-interface.c
@@ -72,7 +72,7 @@ static int is_valid_iface(const struct net_device *net_dev)
 		return 0;
 
 	/* no batman over batman */
-	if (softif_is_valid(net_dev))
+	if (batadv_softif_is_valid(net_dev))
 		return 0;
 
 	/* Device is being bridged */
@@ -287,7 +287,7 @@ int batadv_hardif_enable_interface(struct hard_iface *hard_iface,
 	soft_iface = dev_get_by_name(&init_net, iface_name);
 
 	if (!soft_iface) {
-		soft_iface = softif_create(iface_name);
+		soft_iface = batadv_softif_create(iface_name);
 
 		if (!soft_iface) {
 			ret = -ENOMEM;
@@ -298,7 +298,7 @@ int batadv_hardif_enable_interface(struct hard_iface *hard_iface,
 		dev_hold(soft_iface);
 	}
 
-	if (!softif_is_valid(soft_iface)) {
+	if (!batadv_softif_is_valid(soft_iface)) {
 		pr_err("Can't create batman mesh interface %s: already exists as regular interface\n",
 		       soft_iface->name);
 		ret = -EINVAL;
@@ -399,7 +399,7 @@ void batadv_hardif_disable_interface(struct hard_iface *hard_iface)
 
 	/* nobody uses this interface anymore */
 	if (!bat_priv->num_ifaces)
-		softif_destroy(hard_iface->soft_iface);
+		batadv_softif_destroy(hard_iface->soft_iface);
 
 	hard_iface->soft_iface = NULL;
 	hardif_free_ref(hard_iface);
diff --git a/routing.c b/routing.c
index c004440..db74e38 100644
--- a/routing.c
+++ b/routing.c
@@ -982,7 +982,8 @@ int batadv_recv_unicast_packet(struct sk_buff *skb, struct hard_iface *recv_if)
 
 	/* packet for me */
 	if (is_my_mac(unicast_packet->dest)) {
-		interface_rx(recv_if->soft_iface, skb, recv_if, hdr_size);
+		batadv_interface_rx(recv_if->soft_iface, skb, recv_if,
+				    hdr_size);
 		return NET_RX_SUCCESS;
 	}
 
@@ -1018,8 +1019,8 @@ int batadv_recv_ucast_frag_packet(struct sk_buff *skb,
 		if (!new_skb)
 			return NET_RX_SUCCESS;
 
-		interface_rx(recv_if->soft_iface, new_skb, recv_if,
-			     sizeof(struct unicast_packet));
+		batadv_interface_rx(recv_if->soft_iface, new_skb, recv_if,
+				    sizeof(struct unicast_packet));
 		return NET_RX_SUCCESS;
 	}
 
@@ -1104,7 +1105,7 @@ int batadv_recv_bcast_packet(struct sk_buff *skb, struct hard_iface *recv_if)
 		goto out;
 
 	/* broadcast for me */
-	interface_rx(recv_if->soft_iface, skb, recv_if, hdr_size);
+	batadv_interface_rx(recv_if->soft_iface, skb, recv_if, hdr_size);
 	ret = NET_RX_SUCCESS;
 	goto out;
 
diff --git a/send.c b/send.c
index 57c8adb..a8af6e3 100644
--- a/send.c
+++ b/send.c
@@ -52,7 +52,7 @@ int batadv_send_skb_packet(struct sk_buff *skb, struct hard_iface *hard_iface,
 	}
 
 	/* push to the ethernet header. */
-	if (my_skb_head_push(skb, ETH_HLEN) < 0)
+	if (batadv_skb_head_push(skb, ETH_HLEN) < 0)
 		goto send_skb_err;
 
 	skb_reset_mac_header(skb);
diff --git a/soft-interface.c b/soft-interface.c
index ed9bdab..462c705 100644
--- a/soft-interface.c
+++ b/soft-interface.c
@@ -62,7 +62,7 @@ static const struct ethtool_ops bat_ethtool_ops = {
 	.get_sset_count = bat_get_sset_count,
 };
 
-int my_skb_head_push(struct sk_buff *skb, unsigned int len)
+int batadv_skb_head_push(struct sk_buff *skb, unsigned int len)
 {
 	int result;
 
@@ -209,7 +209,7 @@ static int interface_tx(struct sk_buff *skb, struct net_device *soft_iface)
 		if (batadv_dat_snoop_outgoing_arp_request(bat_priv, skb))
 			brd_delay = msecs_to_jiffies(ARP_REQ_DELAY);
 
-		if (my_skb_head_push(skb, sizeof(*bcast_packet)) < 0)
+		if (batadv_skb_head_push(skb, sizeof(*bcast_packet)) < 0)
 			goto dropped;
 
 		bcast_packet = (struct bcast_packet *)skb->data;
@@ -263,9 +263,9 @@ end:
 	return NETDEV_TX_OK;
 }
 
-void interface_rx(struct net_device *soft_iface,
-		  struct sk_buff *skb, struct hard_iface *recv_if,
-		  int hdr_size)
+void batadv_interface_rx(struct net_device *soft_iface,
+			 struct sk_buff *skb, struct hard_iface *recv_if,
+			 int hdr_size)
 {
 	struct bat_priv *bat_priv = netdev_priv(soft_iface);
 	struct ethhdr *ethhdr;
@@ -370,7 +370,7 @@ static void interface_setup(struct net_device *dev)
 	memset(priv, 0, sizeof(*priv));
 }
 
-struct net_device *softif_create(const char *name)
+struct net_device *batadv_softif_create(const char *name)
 {
 	struct net_device *soft_iface;
 	struct bat_priv *bat_priv;
@@ -460,7 +460,7 @@ out:
 	return NULL;
 }
 
-void softif_destroy(struct net_device *soft_iface)
+void batadv_softif_destroy(struct net_device *soft_iface)
 {
 	batadv_debugfs_del_meshif(soft_iface);
 	batadv_sysfs_del_meshif(soft_iface);
@@ -468,7 +468,7 @@ void softif_destroy(struct net_device *soft_iface)
 	unregister_netdevice(soft_iface);
 }
 
-int softif_is_valid(const struct net_device *net_dev)
+int batadv_softif_is_valid(const struct net_device *net_dev)
 {
 	if (net_dev->netdev_ops->ndo_start_xmit == interface_tx)
 		return 1;
diff --git a/soft-interface.h b/soft-interface.h
index 0203006..7e2bfaf 100644
--- a/soft-interface.h
+++ b/soft-interface.h
@@ -22,12 +22,11 @@
 #ifndef _NET_BATMAN_ADV_SOFT_INTERFACE_H_
 #define _NET_BATMAN_ADV_SOFT_INTERFACE_H_
 
-int my_skb_head_push(struct sk_buff *skb, unsigned int len);
-void interface_rx(struct net_device *soft_iface,
-		  struct sk_buff *skb, struct hard_iface *recv_if,
-		  int hdr_size);
-struct net_device *softif_create(const char *name);
-void softif_destroy(struct net_device *soft_iface);
-int softif_is_valid(const struct net_device *net_dev);
+int batadv_skb_head_push(struct sk_buff *skb, unsigned int len);
+void batadv_interface_rx(struct net_device *soft_iface, struct sk_buff *skb,
+			 struct hard_iface *recv_if, int hdr_size);
+struct net_device *batadv_softif_create(const char *name);
+void batadv_softif_destroy(struct net_device *soft_iface);
+int batadv_softif_is_valid(const struct net_device *net_dev);
 
 #endif /* _NET_BATMAN_ADV_SOFT_INTERFACE_H_ */
diff --git a/unicast.c b/unicast.c
index 62d2f47..0ac14ce 100644
--- a/unicast.c
+++ b/unicast.c
@@ -242,8 +242,8 @@ int frag_send_skb(struct sk_buff *skb, struct bat_priv *bat_priv,
 	memcpy(&tmp_uc, unicast_packet, uc_hdr_len);
 	skb_split(skb, frag_skb, data_len / 2 + uc_hdr_len);
 
-	if (my_skb_head_push(skb, ucf_hdr_len - uc_hdr_len) < 0 ||
-	    my_skb_head_push(frag_skb, ucf_hdr_len) < 0)
+	if (batadv_skb_head_push(skb, ucf_hdr_len - uc_hdr_len) < 0 ||
+	    batadv_skb_head_push(frag_skb, ucf_hdr_len) < 0)
 		goto drop_frag;
 
 	frag1 = (struct unicast_frag_packet *)skb->data;
@@ -288,7 +288,7 @@ static bool pull_and_fill_unicast(struct sk_buff *skb, int hdr_size,
 {
 	struct unicast_packet *unicast_packet;
 
-	if (my_skb_head_push(skb, hdr_size) < 0)
+	if (batadv_skb_head_push(skb, hdr_size) < 0)
 		return false;
 
 	unicast_packet = (struct unicast_packet *)skb->data;
-- 
1.7.10

