Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun, 26 Sep 2010 20:57:56 +0200
Message-Id: <1285527477-10340-1-git-send-email-lindner_marek@yahoo.de>
In-Reply-To: <201009262057.36382.lindner_marek@yahoo.de>
References: <201009262057.36382.lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCH 1/2] batman-adv: softif lan loop avoidance
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
Cc: Marek Lindner <lindner_marek@yahoo.de>

By connecting multiple batman-adv mesh nodes to the same LAN network
an ethernet loop can be created when the soft-interface is bridged
with the LAN interface. A simple visualization of the loop:

node1  <-- LAN  -->  node2
   |                   |
 wifi  <-- mesh -->  wifi

This patch adds the functionality to detect other batman-adv nodes
connected to the LAN and select a 'gateway' to talk to the
non-batman-adv devices on this LAN. All traffic from and to the mesh
will be handled by this gateway to avoid the loop. OGMs received via
the soft-interface are interpreted as 'port announcements' to locate
potential batman-adv nodes. The patch can also deal with vlans on
top of batX and offers a list of LAN neighbors via debugfs.

Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
---
 batman-adv/bat_debugfs.c    |    9 ++
 batman-adv/main.c           |    2 +
 batman-adv/main.h           |    2 +
 batman-adv/originator.c     |    3 +
 batman-adv/routing.c        |   12 +-
 batman-adv/routing.h        |    2 +
 batman-adv/soft-interface.c |  302 +++++++++++++++++++++++++++++++++++++++++--
 batman-adv/soft-interface.h |    5 +-
 batman-adv/types.h          |   12 ++
 9 files changed, 332 insertions(+), 17 deletions(-)

diff --git a/batman-adv/bat_debugfs.c b/batman-adv/bat_debugfs.c
index bd4a12e..3fcb102 100644
--- a/batman-adv/bat_debugfs.c
+++ b/batman-adv/bat_debugfs.c
@@ -29,6 +29,7 @@
 #include "hard-interface.h"
 #include "gateway_common.h"
 #include "gateway_client.h"
+#include "soft-interface.h"
 #include "vis.h"
 #include "icmp_socket.h"
 #include "compat.h"
@@ -236,6 +237,12 @@ static int gateways_open(struct inode *inode, struct file *file)
 	return single_open(file, gw_client_seq_print_text, net_dev);
 }
 
+static int softif_neigh_open(struct inode *inode, struct file *file)
+{
+	struct net_device *net_dev = (struct net_device *)inode->i_private;
+	return single_open(file, softif_neigh_seq_print_text, net_dev);
+}
+
 static int transtable_global_open(struct inode *inode, struct file *file)
 {
 	struct net_device *net_dev = (struct net_device *)inode->i_private;
@@ -273,6 +280,7 @@ struct bat_debuginfo bat_debuginfo_##_name = {	\
 
 static BAT_DEBUGINFO(originators, S_IRUGO, originators_open);
 static BAT_DEBUGINFO(gateways, S_IRUGO, gateways_open);
+static BAT_DEBUGINFO(softif_neigh, S_IRUGO, softif_neigh_open);
 static BAT_DEBUGINFO(transtable_global, S_IRUGO, transtable_global_open);
 static BAT_DEBUGINFO(transtable_local, S_IRUGO, transtable_local_open);
 static BAT_DEBUGINFO(vis_data, S_IRUGO, vis_data_open);
@@ -280,6 +288,7 @@ static BAT_DEBUGINFO(vis_data, S_IRUGO, vis_data_open);
 static struct bat_debuginfo *mesh_debuginfos[] = {
 	&bat_debuginfo_originators,
 	&bat_debuginfo_gateways,
+	&bat_debuginfo_softif_neigh,
 	&bat_debuginfo_transtable_global,
 	&bat_debuginfo_transtable_local,
 	&bat_debuginfo_vis_data,
diff --git a/batman-adv/main.c b/batman-adv/main.c
index a067f75..0afa508 100644
--- a/batman-adv/main.c
+++ b/batman-adv/main.c
@@ -89,10 +89,12 @@ int mesh_init(struct net_device *soft_iface)
 	spin_lock_init(&bat_priv->gw_list_lock);
 	spin_lock_init(&bat_priv->vis_hash_lock);
 	spin_lock_init(&bat_priv->vis_list_lock);
+	spin_lock_init(&bat_priv->softif_neigh_lock);
 
 	INIT_HLIST_HEAD(&bat_priv->forw_bat_list);
 	INIT_HLIST_HEAD(&bat_priv->forw_bcast_list);
 	INIT_HLIST_HEAD(&bat_priv->gw_list);
+	INIT_HLIST_HEAD(&bat_priv->softif_neigh_list);
 
 	if (originator_init(bat_priv) < 1)
 		goto err;
diff --git a/batman-adv/main.h b/batman-adv/main.h
index 1528f7a..cc42eb4 100644
--- a/batman-adv/main.h
+++ b/batman-adv/main.h
@@ -72,6 +72,8 @@
 				   * forw_packet->direct_link_flags */
 #define MAX_AGGREGATION_MS 100
 
+#define SOFTIF_NEIGH_TIMEOUT 180000 /* 3 minutes */
+
 #define RESET_PROTECTION_MS 30000
 #define EXPECTED_SEQNO_RANGE	65536
 /* don't reset again within 30 seconds */
diff --git a/batman-adv/originator.c b/batman-adv/originator.c
index 3424ac2..a7b74f0 100644
--- a/batman-adv/originator.c
+++ b/batman-adv/originator.c
@@ -30,6 +30,7 @@
 #include "gateway_client.h"
 #include "hard-interface.h"
 #include "unicast.h"
+#include "soft-interface.h"
 
 static void purge_orig(struct work_struct *work);
 
@@ -292,6 +293,8 @@ static void _purge_orig(struct bat_priv *bat_priv)
 
 	gw_node_purge_deleted(bat_priv);
 	gw_election(bat_priv);
+
+	softif_neigh_purge(bat_priv);
 }
 
 static void purge_orig(struct work_struct *work)
diff --git a/batman-adv/routing.c b/batman-adv/routing.c
index 37ad3c4..1377f01 100644
--- a/batman-adv/routing.c
+++ b/batman-adv/routing.c
@@ -1133,8 +1133,8 @@ static int check_unicast_packet(struct sk_buff *skb, int hdr_size)
 	return 0;
 }
 
-static int route_unicast_packet(struct sk_buff *skb,
-				struct batman_if *recv_if, int hdr_size)
+int route_unicast_packet(struct sk_buff *skb, struct batman_if *recv_if,
+			 int hdr_size)
 {
 	struct bat_priv *bat_priv = netdev_priv(recv_if->soft_iface);
 	struct orig_node *orig_node;
@@ -1202,7 +1202,7 @@ static int route_unicast_packet(struct sk_buff *skb,
 			return NET_RX_SUCCESS;
 
 		skb = new_skb;
-		unicast_packet = (struct unicast_packet *) skb->data;
+		unicast_packet = (struct unicast_packet *)skb->data;
 	}
 
 	/* decrement ttl */
@@ -1226,7 +1226,7 @@ int recv_unicast_packet(struct sk_buff *skb, struct batman_if *recv_if)
 
 	/* packet for me */
 	if (is_my_mac(unicast_packet->dest)) {
-		interface_rx(recv_if->soft_iface, skb, hdr_size);
+		interface_rx(recv_if->soft_iface, skb, recv_if, hdr_size);
 		return NET_RX_SUCCESS;
 	}
 
@@ -1258,7 +1258,7 @@ int recv_ucast_frag_packet(struct sk_buff *skb, struct batman_if *recv_if)
 		if (!new_skb)
 			return NET_RX_SUCCESS;
 
-		interface_rx(recv_if->soft_iface, new_skb,
+		interface_rx(recv_if->soft_iface, new_skb, recv_if,
 			     sizeof(struct unicast_packet));
 		return NET_RX_SUCCESS;
 	}
@@ -1340,7 +1340,7 @@ int recv_bcast_packet(struct sk_buff *skb, struct batman_if *recv_if)
 	add_bcast_packet_to_list(bat_priv, skb);
 
 	/* broadcast for me */
-	interface_rx(recv_if->soft_iface, skb, hdr_size);
+	interface_rx(recv_if->soft_iface, skb, recv_if, hdr_size);
 
 	return NET_RX_SUCCESS;
 }
diff --git a/batman-adv/routing.h b/batman-adv/routing.h
index 06ea99d..8f7db1c 100644
--- a/batman-adv/routing.h
+++ b/batman-adv/routing.h
@@ -32,6 +32,8 @@ void receive_bat_packet(struct ethhdr *ethhdr,
 void update_routes(struct bat_priv *bat_priv, struct orig_node *orig_node,
 		   struct neigh_node *neigh_node, unsigned char *hna_buff,
 		   int hna_buff_len);
+int route_unicast_packet(struct sk_buff *skb, struct batman_if *recv_if,
+			 int hdr_size);
 int recv_icmp_packet(struct sk_buff *skb, struct batman_if *recv_if);
 int recv_unicast_packet(struct sk_buff *skb, struct batman_if *recv_if);
 int recv_ucast_frag_packet(struct sk_buff *skb, struct batman_if *recv_if);
diff --git a/batman-adv/soft-interface.c b/batman-adv/soft-interface.c
index 2a84d3b..779da31 100644
--- a/batman-adv/soft-interface.c
+++ b/batman-adv/soft-interface.c
@@ -35,8 +35,10 @@
 #include <linux/slab.h>
 #include <linux/ethtool.h>
 #include <linux/etherdevice.h>
+#include <linux/if_vlan.h>
 #include "compat.h"
 #include "unicast.h"
+#include "routing.h"
 
 
 static int bat_get_settings(struct net_device *dev, struct ethtool_cmd *cmd);
@@ -78,6 +80,214 @@ int my_skb_head_push(struct sk_buff *skb, unsigned int len)
 	return 0;
 }
 
+static void softif_neigh_hold(struct softif_neigh *softif_neigh)
+{
+	if (!softif_neigh)
+		return;
+
+	atomic_inc(&softif_neigh->refcnt);
+}
+
+static void softif_neigh_put(struct softif_neigh *softif_neigh)
+{
+	if (!softif_neigh)
+		return;
+
+	if (atomic_dec_and_test(&softif_neigh->refcnt))
+		kfree(softif_neigh);
+}
+
+void softif_neigh_purge(struct bat_priv *bat_priv)
+{
+	struct softif_neigh *softif_neigh;
+	struct hlist_node *node, *node_tmp;
+
+	hlist_for_each_entry_safe(softif_neigh, node, node_tmp,
+				  &bat_priv->softif_neigh_list, list) {
+
+		if (!time_after(jiffies, softif_neigh->last_seen +
+				msecs_to_jiffies(SOFTIF_NEIGH_TIMEOUT)))
+			continue;
+
+		spin_lock(&bat_priv->softif_neigh_lock);
+		hlist_del_rcu(&softif_neigh->list);
+		spin_unlock(&bat_priv->softif_neigh_lock);
+
+		if (bat_priv->softif_neigh == softif_neigh) {
+			bat_priv->softif_neigh = NULL;
+			bat_dbg(DBG_ROUTES, bat_priv,
+				 "Current mesh exit point '%pM' vanished "
+				 "(vid: %d).\n",
+				 softif_neigh->addr, softif_neigh->vid);
+			softif_neigh_put(bat_priv->softif_neigh);
+		}
+
+		synchronize_rcu();
+		softif_neigh_put(softif_neigh);
+	}
+}
+
+static struct softif_neigh *softif_neigh_get(struct bat_priv *bat_priv,
+					     uint8_t *addr, short vid)
+{
+	struct softif_neigh *softif_neigh;
+	struct hlist_node *node;
+
+	rcu_read_lock();
+	hlist_for_each_entry_rcu(softif_neigh, node,
+				 &bat_priv->softif_neigh_list, list) {
+		if (memcmp(softif_neigh->addr, addr, ETH_ALEN) != 0)
+			continue;
+
+		if (softif_neigh->vid != vid)
+			continue;
+
+		softif_neigh->last_seen = jiffies;
+		goto found;
+	}
+
+	softif_neigh = kzalloc(sizeof(struct softif_neigh), GFP_ATOMIC);
+	if (!softif_neigh)
+		goto out;
+
+	memcpy(softif_neigh->addr, addr, ETH_ALEN);
+	softif_neigh->vid = vid;
+	softif_neigh->last_seen = jiffies;
+	atomic_set(&softif_neigh->refcnt, 0);
+	softif_neigh_hold(softif_neigh);
+
+	INIT_HLIST_NODE(&softif_neigh->list);
+	spin_lock(&bat_priv->softif_neigh_lock);
+	hlist_add_head_rcu(&softif_neigh->list, &bat_priv->softif_neigh_list);
+	spin_unlock(&bat_priv->softif_neigh_lock);
+
+found:
+	softif_neigh_hold(softif_neigh);
+out:
+	rcu_read_unlock();
+	return softif_neigh;
+}
+
+int softif_neigh_seq_print_text(struct seq_file *seq, void *offset)
+{
+	struct net_device *net_dev = (struct net_device *)seq->private;
+	struct bat_priv *bat_priv = netdev_priv(net_dev);
+	struct softif_neigh *softif_neigh;
+	struct hlist_node *node;
+	size_t buf_size, pos;
+	char *buff;
+
+	if (!bat_priv->primary_if) {
+		return seq_printf(seq, "BATMAN mesh %s disabled - "
+			       "please specify interfaces to enable it\n",
+			       net_dev->name);
+	}
+
+	seq_printf(seq, "Softif neighbor list (%s)\n", net_dev->name);
+
+	buf_size = 1;
+	/* Estimate length for: "   xx:xx:xx:xx:xx:xx\n" */
+	rcu_read_lock();
+	hlist_for_each_entry_rcu(softif_neigh, node,
+				 &bat_priv->softif_neigh_list, list)
+		buf_size += 30;
+	rcu_read_unlock();
+
+	buff = kmalloc(buf_size, GFP_ATOMIC);
+	if (!buff)
+		return -ENOMEM;
+
+	buff[0] = '\0';
+	pos = 0;
+
+	rcu_read_lock();
+	hlist_for_each_entry_rcu(softif_neigh, node,
+				 &bat_priv->softif_neigh_list, list) {
+		pos += snprintf(buff + pos, 31, "%s %pM (vid: %d)\n",
+				bat_priv->softif_neigh == softif_neigh
+				? "=>" : "  ", softif_neigh->addr,
+				softif_neigh->vid);
+	}
+	rcu_read_unlock();
+
+	seq_printf(seq, "%s", buff);
+	kfree(buff);
+	return 0;
+}
+
+void softif_batman_recv(struct sk_buff *skb, struct net_device *dev, short vid)
+{
+	struct bat_priv *bat_priv = netdev_priv(dev);
+	struct ethhdr *ethhdr = (struct ethhdr *)skb->data;
+	struct batman_packet *batman_packet;
+	struct softif_neigh *softif_neigh;
+
+	if (ntohs(ethhdr->h_proto) == ETH_P_8021Q)
+		batman_packet = (struct batman_packet *)
+					(skb->data + ETH_HLEN + VLAN_HLEN);
+	else
+		batman_packet = (struct batman_packet *)(skb->data + ETH_HLEN);
+
+	if (batman_packet->version != COMPAT_VERSION)
+		goto err;
+
+	if (batman_packet->packet_type != BAT_PACKET)
+		goto err;
+
+	if (!(batman_packet->flags & PRIMARIES_FIRST_HOP))
+		goto err;
+
+	if (is_my_mac(batman_packet->orig))
+		goto err;
+
+	softif_neigh = softif_neigh_get(bat_priv, batman_packet->orig, vid);
+
+	if (!softif_neigh)
+		goto err;
+
+	if (bat_priv->softif_neigh == softif_neigh)
+		goto out;
+
+	/* we got a neighbor but its mac is 'bigger' than ours  */
+	if (memcmp(bat_priv->primary_if->net_dev->dev_addr,
+		   softif_neigh->addr, ETH_ALEN) < 0)
+		goto out;
+
+	/* switch to new 'smallest neighbor' */
+	if ((bat_priv->softif_neigh) &&
+	    (memcmp(softif_neigh->addr, bat_priv->softif_neigh->addr,
+							ETH_ALEN) < 0)) {
+		bat_dbg(DBG_ROUTES, bat_priv,
+			"Changing mesh exit point from %pM (vid: %d) "
+			"to %pM (vid: %d).\n",
+			 bat_priv->softif_neigh->addr,
+			 bat_priv->softif_neigh->vid,
+			 softif_neigh->addr, softif_neigh->vid);
+		softif_neigh_put(bat_priv->softif_neigh);
+		bat_priv->softif_neigh = softif_neigh;
+		/* we need to hold the additional reference */
+		goto err;
+	}
+
+	/* close own batX device and use softif_neigh as exit node */
+	if ((!bat_priv->softif_neigh) &&
+	    (memcmp(softif_neigh->addr,
+		    bat_priv->primary_if->net_dev->dev_addr, ETH_ALEN) < 0)) {
+		bat_dbg(DBG_ROUTES, bat_priv,
+			"Setting mesh exit point to %pM (vid: %d).\n",
+			softif_neigh->addr, softif_neigh->vid);
+		bat_priv->softif_neigh = softif_neigh;
+		/* we need to hold the additional reference */
+		goto err;
+	}
+
+out:
+	softif_neigh_put(softif_neigh);
+err:
+	kfree_skb(skb);
+	return;
+}
+
 static int interface_open(struct net_device *dev)
 {
 	netif_start_queue(dev);
@@ -112,7 +322,6 @@ static int interface_set_mac_addr(struct net_device *dev, void *p)
 	}
 
 	memcpy(dev->dev_addr, addr->sa_data, ETH_ALEN);
-
 	return 0;
 }
 
@@ -132,7 +341,9 @@ int interface_tx(struct sk_buff *skb, struct net_device *soft_iface)
 	struct ethhdr *ethhdr = (struct ethhdr *)skb->data;
 	struct bat_priv *bat_priv = netdev_priv(soft_iface);
 	struct bcast_packet *bcast_packet;
+	struct vlan_ethhdr *vhdr;
 	int data_len = skb->len, ret;
+	short vid = -1;
 	bool bcast_dst = false, do_bcast = true;
 
 	if (atomic_read(&bat_priv->mesh_state) != MESH_ACTIVE)
@@ -140,6 +351,27 @@ int interface_tx(struct sk_buff *skb, struct net_device *soft_iface)
 
 	soft_iface->trans_start = jiffies;
 
+	switch (ntohs(ethhdr->h_proto)) {
+	case ETH_P_8021Q:
+		vhdr = (struct vlan_ethhdr *)skb->data;
+		vid = ntohs(vhdr->h_vlan_TCI) & VLAN_VID_MASK;
+
+		if (ntohs(vhdr->h_vlan_encapsulated_proto) != ETH_P_BATMAN)
+			break;
+
+		/* fall through */
+	case ETH_P_BATMAN:
+		softif_batman_recv(skb, soft_iface, vid);
+		goto end;
+	}
+
+	/**
+	 * if we have a another chosen mesh exit node in range
+	 * it will transport the packets to the mesh
+	 */
+	if ((bat_priv->softif_neigh) && (bat_priv->softif_neigh->vid == vid))
+		goto dropped;
+
 	/* TODO: check this for locks */
 	hna_local_add(soft_iface, ethhdr->h_source);
 
@@ -199,17 +431,60 @@ end:
 }
 
 void interface_rx(struct net_device *soft_iface,
-		  struct sk_buff *skb, int hdr_size)
+		  struct sk_buff *skb, struct batman_if *recv_if,
+		  int hdr_size)
 {
-	struct bat_priv *priv = netdev_priv(soft_iface);
+	struct bat_priv *bat_priv = netdev_priv(soft_iface);
+	struct unicast_packet *unicast_packet;
+	struct ethhdr *ethhdr;
+	struct vlan_ethhdr *vhdr;
+	short vid = -1;
+	int ret;
 
 	/* check if enough space is available for pulling, and pull */
-	if (!pskb_may_pull(skb, hdr_size)) {
-		kfree_skb(skb);
-		return;
-	}
+	if (!pskb_may_pull(skb, hdr_size))
+		goto dropped;
+
 	skb_pull_rcsum(skb, hdr_size);
-/*	skb_set_mac_header(skb, -sizeof(struct ethhdr));*/
+	skb_reset_mac_header(skb);
+
+	ethhdr = (struct ethhdr *)skb_mac_header(skb);
+
+	switch (ntohs(ethhdr->h_proto)) {
+	case ETH_P_8021Q:
+		vhdr = (struct vlan_ethhdr *)skb->data;
+		vid = ntohs(vhdr->h_vlan_TCI) & VLAN_VID_MASK;
+
+		if (ntohs(vhdr->h_vlan_encapsulated_proto) != ETH_P_BATMAN)
+			break;
+
+		/* fall through */
+	case ETH_P_BATMAN:
+		goto dropped;
+	}
+
+	/**
+	 * if we have a another chosen mesh exit node in range
+	 * it will transport the packets to the non-mesh network
+	 */
+	if ((bat_priv->softif_neigh) && (bat_priv->softif_neigh->vid == vid)) {
+		skb_push(skb, hdr_size);
+		unicast_packet = (struct unicast_packet *)skb->data;
+
+		if ((unicast_packet->packet_type != BAT_UNICAST) &&
+		    (unicast_packet->packet_type != BAT_UNICAST_FRAG))
+			goto dropped;
+
+		skb_reset_mac_header(skb);
+
+		memcpy(unicast_packet->dest,
+		       bat_priv->softif_neigh->addr, ETH_ALEN);
+		ret = route_unicast_packet(skb, recv_if, hdr_size);
+		if (ret == NET_RX_DROP)
+			goto dropped;
+
+		goto out;
+	}
 
 	/* skb->dev & skb->pkt_type are set here */
 	skb->protocol = eth_type_trans(skb, soft_iface);
@@ -220,12 +495,18 @@ void interface_rx(struct net_device *soft_iface,
 
 /*	skb->ip_summed = CHECKSUM_UNNECESSARY;*/
 
-	priv->stats.rx_packets++;
-	priv->stats.rx_bytes += skb->len + sizeof(struct ethhdr);
+	bat_priv->stats.rx_packets++;
+	bat_priv->stats.rx_bytes += skb->len + sizeof(struct ethhdr);
 
 	soft_iface->last_rx = jiffies;
 
 	netif_rx(skb);
+	return;
+
+dropped:
+	kfree_skb(skb);
+out:
+	return;
 }
 
 #ifdef HAVE_NET_DEVICE_OPS
@@ -316,6 +597,7 @@ struct net_device *softif_create(char *name)
 
 	bat_priv->primary_if = NULL;
 	bat_priv->num_ifaces = 0;
+	bat_priv->softif_neigh = NULL;
 
 	ret = sysfs_add_meshif(soft_iface);
 	if (ret < 0)
diff --git a/batman-adv/soft-interface.h b/batman-adv/soft-interface.h
index 843a7ec..02b7733 100644
--- a/batman-adv/soft-interface.h
+++ b/batman-adv/soft-interface.h
@@ -23,9 +23,12 @@
 #define _NET_BATMAN_ADV_SOFT_INTERFACE_H_
 
 int my_skb_head_push(struct sk_buff *skb, unsigned int len);
+int softif_neigh_seq_print_text(struct seq_file *seq, void *offset);
+void softif_neigh_purge(struct bat_priv *bat_priv);
 int interface_tx(struct sk_buff *skb, struct net_device *soft_iface);
 void interface_rx(struct net_device *soft_iface,
-		  struct sk_buff *skb, int hdr_size);
+		  struct sk_buff *skb, struct batman_if *recv_if,
+		  int hdr_size);
 struct net_device *softif_create(char *name);
 void softif_destroy(struct net_device *soft_iface);
 
diff --git a/batman-adv/types.h b/batman-adv/types.h
index a609100..dfa8784 100644
--- a/batman-adv/types.h
+++ b/batman-adv/types.h
@@ -134,6 +134,8 @@ struct bat_priv {
 	atomic_t bcast_queue_left;
 	atomic_t batman_queue_left;
 	char num_ifaces;
+	struct hlist_head softif_neigh_list;
+	struct softif_neigh *softif_neigh;
 	struct debug_log *debug_log;
 	struct batman_if *primary_if;
 	struct kobject *mesh_obj;
@@ -154,6 +156,7 @@ struct bat_priv {
 	spinlock_t gw_list_lock; /* protects gw_list */
 	spinlock_t vis_hash_lock; /* protects vis_hash */
 	spinlock_t vis_list_lock; /* protects vis_info::recv_list */
+	spinlock_t softif_neigh_lock; /* protects soft-interface neigh list */
 	int16_t num_local_hna;
 	atomic_t hna_local_changed;
 	struct delayed_work hna_work;
@@ -253,4 +256,13 @@ struct recvlist_node {
 	uint8_t mac[ETH_ALEN];
 };
 
+struct softif_neigh {
+	struct hlist_node list;
+	uint8_t addr[ETH_ALEN];
+	unsigned long last_seen;
+	short vid;
+	atomic_t refcnt;
+	struct rcu_head rcu;
+};
+
 #endif /* _NET_BATMAN_ADV_TYPES_H_ */
-- 
1.7.1

