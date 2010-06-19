Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Sat, 19 Jun 2010 02:51:51 +0200
Message-Id: <1276908713-28365-7-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <1276908713-28365-1-git-send-email-sven.eckelmann@gmx.de>
References: <1276908713-28365-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH 6/8] Staging: batman-adv: Add bonding
	functionality
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
To: Greg KH <greg@kroah.com>
Cc: b.a.t.m.a.n@lists.open-mesh.net, Simon Wunderlich <siwu@hrz.tu-chemnitz.de>

From: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>

This patch introduces bonding functionality to batman-advanced, targeted
for the 0.3 release. As we are able to route the payload traffic as we
want, we may use multiple interfaces on multihomed hosts to transfer data
to achieve higher bandwidth. This can be considered as "light Multi Path
Routing" for single hop connections.

To detect which interfaces of a peer node belong to the same host, a
new flag PRIMARIES_FIRST_HOP is introduced. This flag is set on the first hop
of OGMs of the primary (first) interface, which is broadcasted on all
interfaces. When receiving such an OGM, we can learn which interfaces
belong to the same host (by assigning them to the primary originator).

Bonding works by sending packets in a round-robin fashion to the available
interfaces of a neighbor host, if multiple interfaces are available. The
neighbor interfaces should be almost equally good to reach.

To avoid interferences (i.e. sending on the same channel), only neighbor
interfaces with different mac addresses and different outgoing interfaces
are considered as candidates.

Bonding is deactivated by default, and can be activated by

echo 1 > /sys/class/net/bat0/mesh/bonding

for each individual node.

Signed-off-by: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
[sven.eckelmann@gmx.de: Rework on top of current version]
Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 drivers/staging/batman-adv/bat_sysfs.c      |   52 ++++++
 drivers/staging/batman-adv/hard-interface.c |    2 +-
 drivers/staging/batman-adv/main.h           |    5 +
 drivers/staging/batman-adv/originator.c     |    8 +-
 drivers/staging/batman-adv/packet.h         |    1 +
 drivers/staging/batman-adv/routing.c        |  242 +++++++++++++++++++++++---
 drivers/staging/batman-adv/routing.h        |    3 +
 drivers/staging/batman-adv/send.c           |    4 +-
 drivers/staging/batman-adv/soft-interface.c |   60 ++++----
 drivers/staging/batman-adv/types.h          |   11 ++
 10 files changed, 327 insertions(+), 61 deletions(-)

diff --git a/drivers/staging/batman-adv/bat_sysfs.c b/drivers/staging/batman-adv/bat_sysfs.c
index b8ccb75..4e9c71d 100644
--- a/drivers/staging/batman-adv/bat_sysfs.c
+++ b/drivers/staging/batman-adv/bat_sysfs.c
@@ -84,6 +84,55 @@ static ssize_t store_aggr_ogms(struct kobject *kobj, struct attribute *attr,
 	return count;
 }
 
+static ssize_t show_bond(struct kobject *kobj, struct attribute *attr,
+			     char *buff)
+{
+	struct device *dev = to_dev(kobj->parent);
+	struct bat_priv *bat_priv = netdev_priv(to_net_dev(dev));
+	int bond_status = atomic_read(&bat_priv->bonding_enabled);
+
+	return sprintf(buff, "%s\n",
+		       bond_status == 0 ? "disabled" : "enabled");
+}
+
+static ssize_t store_bond(struct kobject *kobj, struct attribute *attr,
+			  char *buff, size_t count)
+{
+	struct device *dev = to_dev(kobj->parent);
+	struct net_device *net_dev = to_net_dev(dev);
+	struct bat_priv *bat_priv = netdev_priv(net_dev);
+	int bonding_enabled_tmp = -1;
+
+	if (((count == 2) && (buff[0] == '1')) ||
+	    (strncmp(buff, "enable", 6) == 0))
+		bonding_enabled_tmp = 1;
+
+	if (((count == 2) && (buff[0] == '0')) ||
+	    (strncmp(buff, "disable", 7) == 0))
+		bonding_enabled_tmp = 0;
+
+	if (bonding_enabled_tmp < 0) {
+		if (buff[count - 1] == '\n')
+			buff[count - 1] = '\0';
+
+		printk(KERN_ERR "batman-adv:Invalid parameter for 'bonding' setting on mesh %s received: %s\n",
+		       net_dev->name, buff);
+		return -EINVAL;
+	}
+
+	if (atomic_read(&bat_priv->bonding_enabled) == bonding_enabled_tmp)
+		return count;
+
+	printk(KERN_INFO "batman-adv:Changing bonding from: %s to: %s on mesh: %s\n",
+	       atomic_read(&bat_priv->bonding_enabled) == 1 ?
+	       "enabled" : "disabled",
+	       bonding_enabled_tmp == 1 ? "enabled" : "disabled",
+	       net_dev->name);
+
+	atomic_set(&bat_priv->bonding_enabled, (unsigned)bonding_enabled_tmp);
+	return count;
+}
+
 static ssize_t show_vis_mode(struct kobject *kobj, struct attribute *attr,
 			     char *buff)
 {
@@ -182,12 +231,14 @@ static ssize_t store_orig_interval(struct kobject *kobj, struct attribute *attr,
 
 static BAT_ATTR(aggregated_ogms, S_IRUGO | S_IWUSR,
 		show_aggr_ogms, store_aggr_ogms);
+static BAT_ATTR(bonding, S_IRUGO | S_IWUSR, show_bond, store_bond);
 static BAT_ATTR(vis_mode, S_IRUGO | S_IWUSR, show_vis_mode, store_vis_mode);
 static BAT_ATTR(orig_interval, S_IRUGO | S_IWUSR,
 		show_orig_interval, store_orig_interval);
 
 static struct bat_attribute *mesh_attrs[] = {
 	&bat_attr_aggregated_ogms,
+	&bat_attr_bonding,
 	&bat_attr_vis_mode,
 	&bat_attr_orig_interval,
 	NULL,
@@ -203,6 +254,7 @@ int sysfs_add_meshif(struct net_device *dev)
 	/* FIXME: should be done in the general mesh setup
 		  routine as soon as we have it */
 	atomic_set(&bat_priv->aggregation_enabled, 1);
+	atomic_set(&bat_priv->bonding_enabled, 0);
 	atomic_set(&bat_priv->vis_mode, VIS_TYPE_CLIENT_UPDATE);
 	atomic_set(&bat_priv->orig_interval, 1000);
 	bat_priv->primary_if = NULL;
diff --git a/drivers/staging/batman-adv/hard-interface.c b/drivers/staging/batman-adv/hard-interface.c
index c7a1c31..028a7ea 100644
--- a/drivers/staging/batman-adv/hard-interface.c
+++ b/drivers/staging/batman-adv/hard-interface.c
@@ -109,7 +109,7 @@ static void set_primary_if(struct bat_priv *bat_priv,
 	set_main_if_addr(batman_if->net_dev->dev_addr);
 
 	batman_packet = (struct batman_packet *)(batman_if->packet_buff);
-	batman_packet->flags = 0;
+	batman_packet->flags = PRIMARIES_FIRST_HOP;
 	batman_packet->ttl = TTL;
 
 	/***
diff --git a/drivers/staging/batman-adv/main.h b/drivers/staging/batman-adv/main.h
index 145ac51..fe5ee51 100644
--- a/drivers/staging/batman-adv/main.h
+++ b/drivers/staging/batman-adv/main.h
@@ -59,6 +59,11 @@
 
 #define VIS_INTERVAL 5000	/* 5 seconds */
 
+/* how much worse secondary interfaces may be to
+ * to be considered as bonding candidates */
+
+#define BONDING_TQ_THRESHOLD	50
+
 #define MAX_AGGREGATION_BYTES 512 /* should not be bigger than 512 bytes or
 				   * change the size of
 				   * forw_packet->direct_link_flags */
diff --git a/drivers/staging/batman-adv/originator.c b/drivers/staging/batman-adv/originator.c
index 1f6cbe8..195c1ee 100644
--- a/drivers/staging/batman-adv/originator.c
+++ b/drivers/staging/batman-adv/originator.c
@@ -226,6 +226,8 @@ static bool purge_orig_neighbors(struct orig_node *orig_node,
 
 static bool purge_orig_node(struct orig_node *orig_node)
 {
+	/* FIXME: each batman_if will be attached to a softif */
+	struct bat_priv *bat_priv = netdev_priv(soft_device);
 	struct neigh_node *best_neigh_node;
 
 	if (time_after(jiffies,
@@ -237,10 +239,14 @@ static bool purge_orig_node(struct orig_node *orig_node)
 			orig_node->orig, (orig_node->last_valid / HZ));
 		return true;
 	} else {
-		if (purge_orig_neighbors(orig_node, &best_neigh_node))
+		if (purge_orig_neighbors(orig_node, &best_neigh_node)) {
 			update_routes(orig_node, best_neigh_node,
 				      orig_node->hna_buff,
 				      orig_node->hna_buff_len);
+			/* update bonding candidates, we could have lost
+			 * some candidates. */
+			update_bonding_candidates(bat_priv, orig_node);
+		}
 	}
 
 	return false;
diff --git a/drivers/staging/batman-adv/packet.h b/drivers/staging/batman-adv/packet.h
index f0387ba..d0d35ea 100644
--- a/drivers/staging/batman-adv/packet.h
+++ b/drivers/staging/batman-adv/packet.h
@@ -31,6 +31,7 @@
 #define COMPAT_VERSION 11
 #define DIRECTLINK 0x40
 #define VIS_SERVER 0x20
+#define PRIMARIES_FIRST_HOP 0x10
 
 /* ICMP message types */
 #define ECHO_REPLY 0
diff --git a/drivers/staging/batman-adv/routing.c b/drivers/staging/batman-adv/routing.c
index 9dbfabe..6a2c2d1 100644
--- a/drivers/staging/batman-adv/routing.c
+++ b/drivers/staging/batman-adv/routing.c
@@ -395,11 +395,132 @@ static char count_real_packets(struct ethhdr *ethhdr,
 	return is_duplicate;
 }
 
+/* copy primary address for bonding */
+static void mark_bonding_address(struct bat_priv *bat_priv,
+				 struct orig_node *orig_node,
+				 struct orig_node *orig_neigh_node,
+				 struct batman_packet *batman_packet)
+
+{
+	/* don't care if bonding is not enabled */
+	if (!atomic_read(&bat_priv->bonding_enabled)) {
+		orig_node->bond.candidates = 0;
+		return;
+	}
+
+	if (batman_packet->flags & PRIMARIES_FIRST_HOP)
+		memcpy(orig_neigh_node->primary_addr,
+		       orig_node->orig, ETH_ALEN);
+
+	return;
+}
+
+/* mark possible bond.candidates in the neighbor list */
+void update_bonding_candidates(struct bat_priv *bat_priv,
+			       struct orig_node *orig_node)
+{
+	int candidates;
+	int interference_candidate;
+	int best_tq;
+	struct neigh_node *tmp_neigh_node, *tmp_neigh_node2;
+	struct neigh_node *first_candidate, *last_candidate;
+
+	/* don't care if bonding is not enabled */
+	if (!atomic_read(&bat_priv->bonding_enabled)) {
+		orig_node->bond.candidates = 0;
+		return;
+	}
+
+	/* update the candidates for this originator */
+	if (!orig_node->router) {
+		orig_node->bond.candidates = 0;
+		return;
+	}
+
+	best_tq = orig_node->router->tq_avg;
+
+	/* update bond.candidates */
+
+	candidates = 0;
+
+	/* mark other nodes which also received "PRIMARIES FIRST HOP" packets
+	 * as "bonding partner" */
+
+	/* first, zero the list */
+	list_for_each_entry(tmp_neigh_node, &orig_node->neigh_list, list) {
+		tmp_neigh_node->next_bond_candidate = NULL;
+	}
+
+	first_candidate = NULL;
+	last_candidate = NULL;
+	list_for_each_entry(tmp_neigh_node, &orig_node->neigh_list, list) {
+
+		/* only consider if it has the same primary address ...  */
+		if (memcmp(orig_node->orig,
+				tmp_neigh_node->orig_node->primary_addr,
+				ETH_ALEN) != 0)
+			continue;
+
+		/* ... and is good enough to be considered */
+		if (tmp_neigh_node->tq_avg < best_tq - BONDING_TQ_THRESHOLD)
+			continue;
+
+		/* check if we have another candidate with the same
+		 * mac address or interface. If we do, we won't
+		 * select this candidate because of possible interference. */
+
+		interference_candidate = 0;
+		list_for_each_entry(tmp_neigh_node2,
+				&orig_node->neigh_list, list) {
+
+			if (tmp_neigh_node2 == tmp_neigh_node)
+				continue;
+
+			/* we only care if the other candidate is even
+			 * considered as candidate. */
+			if (tmp_neigh_node2->next_bond_candidate == NULL)
+				continue;
+
+
+			if ((tmp_neigh_node->if_incoming ==
+				tmp_neigh_node2->if_incoming)
+				|| (memcmp(tmp_neigh_node->addr,
+				tmp_neigh_node2->addr, ETH_ALEN) == 0)) {
+
+				interference_candidate = 1;
+				break;
+			}
+		}
+		/* don't care further if it is an interference candidate */
+		if (interference_candidate)
+			continue;
+
+		if (first_candidate == NULL) {
+			first_candidate = tmp_neigh_node;
+			tmp_neigh_node->next_bond_candidate = first_candidate;
+		} else
+			tmp_neigh_node->next_bond_candidate = last_candidate;
+
+		last_candidate = tmp_neigh_node;
+
+		candidates++;
+	}
+
+	if (candidates > 0) {
+		first_candidate->next_bond_candidate = last_candidate;
+		orig_node->bond.selected = first_candidate;
+	}
+
+	orig_node->bond.candidates = candidates;
+}
+
 void receive_bat_packet(struct ethhdr *ethhdr,
 				struct batman_packet *batman_packet,
 				unsigned char *hna_buff, int hna_buff_len,
 				struct batman_if *if_incoming)
 {
+	/* FIXME: each orig_node->batman_if will be attached to a softif */
+	struct bat_priv *bat_priv = netdev_priv(soft_device);
 	struct batman_if *batman_if;
 	struct orig_node *orig_neigh_node, *orig_node;
 	char has_directlink_flag;
@@ -577,6 +698,10 @@ void receive_bat_packet(struct ethhdr *ethhdr,
 		update_orig(orig_node, ethhdr, batman_packet,
 			    if_incoming, hna_buff, hna_buff_len, is_duplicate);
 
+	mark_bonding_address(bat_priv, orig_node,
+			     orig_neigh_node, batman_packet);
+	update_bonding_candidates(bat_priv, orig_node);
+
 	/* is single hop (direct) neighbor */
 	if (is_single_hop_neigh) {
 
@@ -859,16 +984,75 @@ int recv_icmp_packet(struct sk_buff *skb)
 	return ret;
 }
 
+/* find a suitable router for this originator, and use
+ * bonding if possible. */
+struct neigh_node *find_router(struct orig_node *orig_node)
+{
+	/* FIXME: each orig_node->batman_if will be attached to a softif */
+	struct bat_priv *bat_priv = netdev_priv(soft_device);
+	struct orig_node *primary_orig_node;
+	struct orig_node *router_orig;
+	struct neigh_node *router;
+	static uint8_t zero_mac[ETH_ALEN] = {0, 0, 0, 0, 0, 0};
+
+	if (!orig_node)
+		return NULL;
+
+	if (!orig_node->router)
+		return NULL;
+
+	/* don't care if bonding is not enabled */
+	if (!atomic_read(&bat_priv->bonding_enabled))
+		return orig_node->router;
+
+	router_orig = orig_node->router->orig_node;
+
+	/* if we have something in the primary_addr, we can search
+	 * for a potential bonding candidate. */
+	if (memcmp(router_orig->primary_addr, zero_mac, ETH_ALEN) == 0)
+		return orig_node->router;
+
+	/* find the orig_node which has the primary interface. might
+	 * even be the same as our router_orig in many cases */
+
+	if (memcmp(router_orig->primary_addr,
+				router_orig->orig, ETH_ALEN) == 0) {
+		primary_orig_node = router_orig;
+	} else {
+		primary_orig_node = hash_find(orig_hash,
+						router_orig->primary_addr);
+		if (!primary_orig_node)
+			return orig_node->router;
+	}
+
+	/* with less than 2 candidates, we can't do any
+	 * bonding and prefer the original router. */
+
+	if (primary_orig_node->bond.candidates < 2)
+		return orig_node->router;
+
+	router = primary_orig_node->bond.selected;
+
+	/* sanity check - this should never happen. */
+	if (!router)
+		return orig_node->router;
+
+	/* select the next bonding partner ... */
+	primary_orig_node->bond.selected = router->next_bond_candidate;
+
+	return router;
+}
+
 int recv_unicast_packet(struct sk_buff *skb)
 {
 	struct unicast_packet *unicast_packet;
 	struct orig_node *orig_node;
+	struct neigh_node *router;
 	struct ethhdr *ethhdr;
 	struct batman_if *batman_if;
 	struct sk_buff *skb_old;
 	uint8_t dstaddr[ETH_ALEN];
 	int hdr_size = sizeof(struct unicast_packet);
-	int ret;
 	unsigned long flags;
 
 	/* drop packet if it has not necessary minimum size */
@@ -906,42 +1090,44 @@ int recv_unicast_packet(struct sk_buff *skb)
 		return NET_RX_DROP;
 	}
 
-	ret = NET_RX_DROP;
 	/* get routing information */
 	spin_lock_irqsave(&orig_hash_lock, flags);
 	orig_node = ((struct orig_node *)
 		     hash_find(orig_hash, unicast_packet->dest));
 
-	if ((orig_node != NULL) &&
-	    (orig_node->router != NULL)) {
+	router = find_router(orig_node);
 
-		/* don't lock while sending the packets ... we therefore
-		 * copy the required data before sending */
-		batman_if = orig_node->router->if_incoming;
-		memcpy(dstaddr, orig_node->router->addr, ETH_ALEN);
+	if (!router) {
 		spin_unlock_irqrestore(&orig_hash_lock, flags);
+		return NET_RX_DROP;
+	}
 
-		/* create a copy of the skb, if needed, to modify it. */
-		if (!skb_clone_writable(skb, sizeof(struct unicast_packet))) {
-			skb_old = skb;
-			skb = skb_copy(skb, GFP_ATOMIC);
-			if (!skb)
-				return NET_RX_DROP;
-			unicast_packet = (struct unicast_packet *)skb->data;
-			ethhdr = (struct ethhdr *)skb_mac_header(skb);
-			kfree_skb(skb_old);
-		}
-		/* decrement ttl */
-		unicast_packet->ttl--;
-
-		/* route it */
-		send_skb_packet(skb, batman_if, dstaddr);
-		ret = NET_RX_SUCCESS;
-
-	} else
-		spin_unlock_irqrestore(&orig_hash_lock, flags);
+	/* don't lock while sending the packets ... we therefore
+	 * copy the required data before sending */
+
+	batman_if = router->if_incoming;
+	memcpy(dstaddr, router->addr, ETH_ALEN);
+
+	spin_unlock_irqrestore(&orig_hash_lock, flags);
+
+	/* create a copy of the skb, if needed, to modify it. */
+	if (!skb_clone_writable(skb, sizeof(struct unicast_packet))) {
+		skb_old = skb;
+		skb = skb_copy(skb, GFP_ATOMIC);
+		if (!skb)
+			return NET_RX_DROP;
+		unicast_packet = (struct unicast_packet *) skb->data;
+		ethhdr = (struct ethhdr *)skb_mac_header(skb);
+		kfree_skb(skb_old);
+	}
+
+	/* decrement ttl */
+	unicast_packet->ttl--;
+
+	/* route it */
+	send_skb_packet(skb, batman_if, dstaddr);
 
-	return ret;
+	return NET_RX_SUCCESS;
 }
 
 int recv_bcast_packet(struct sk_buff *skb)
diff --git a/drivers/staging/batman-adv/routing.h b/drivers/staging/batman-adv/routing.h
index c6850d2..0e33d22 100644
--- a/drivers/staging/batman-adv/routing.h
+++ b/drivers/staging/batman-adv/routing.h
@@ -35,3 +35,6 @@ int recv_bcast_packet(struct sk_buff *skb);
 int recv_vis_packet(struct sk_buff *skb);
 int recv_bat_packet(struct sk_buff *skb,
 				struct batman_if *batman_if);
+struct neigh_node *find_router(struct orig_node *orig_node);
+void update_bonding_candidates(struct bat_priv *bat_priv,
+			       struct orig_node *orig_node);
diff --git a/drivers/staging/batman-adv/send.c b/drivers/staging/batman-adv/send.c
index f2653dd..e61a62c 100644
--- a/drivers/staging/batman-adv/send.c
+++ b/drivers/staging/batman-adv/send.c
@@ -287,7 +287,7 @@ void schedule_own_packet(struct batman_if *batman_if)
 		htonl((uint32_t)atomic_read(&batman_if->seqno));
 
 	if (vis_server == VIS_TYPE_SERVER_SYNC)
-		batman_packet->flags = VIS_SERVER;
+		batman_packet->flags |= VIS_SERVER;
 	else
 		batman_packet->flags &= ~VIS_SERVER;
 
@@ -349,6 +349,8 @@ void schedule_forward_packet(struct orig_node *orig_node,
 
 	batman_packet->seqno = htonl(batman_packet->seqno);
 
+	/* switch of primaries first hop flag when forwarding */
+	batman_packet->flags &= ~PRIMARIES_FIRST_HOP;
 	if (directlink)
 		batman_packet->flags |= DIRECTLINK;
 	else
diff --git a/drivers/staging/batman-adv/soft-interface.c b/drivers/staging/batman-adv/soft-interface.c
index ce789a7..37fd565 100644
--- a/drivers/staging/batman-adv/soft-interface.c
+++ b/drivers/staging/batman-adv/soft-interface.c
@@ -22,6 +22,7 @@
 #include "main.h"
 #include "soft-interface.h"
 #include "hard-interface.h"
+#include "routing.h"
 #include "send.h"
 #include "translation-table.h"
 #include "types.h"
@@ -129,6 +130,7 @@ int interface_tx(struct sk_buff *skb, struct net_device *dev)
 	struct unicast_packet *unicast_packet;
 	struct bcast_packet *bcast_packet;
 	struct orig_node *orig_node;
+	struct neigh_node *router;
 	struct ethhdr *ethhdr = (struct ethhdr *)skb->data;
 	struct bat_priv *priv = netdev_priv(dev);
 	struct batman_if *batman_if;
@@ -186,38 +188,36 @@ int interface_tx(struct sk_buff *skb, struct net_device *dev)
 		if (!orig_node)
 			orig_node = transtable_search(ethhdr->h_dest);
 
-		if ((orig_node) &&
-		    (orig_node->router)) {
-			struct neigh_node *router = orig_node->router;
+		router = find_router(orig_node);
 
-			if (my_skb_push(skb, sizeof(struct unicast_packet)) < 0)
-				goto unlock;
-
-			unicast_packet = (struct unicast_packet *)skb->data;
-
-			unicast_packet->version = COMPAT_VERSION;
-			/* batman packet type: unicast */
-			unicast_packet->packet_type = BAT_UNICAST;
-			/* set unicast ttl */
-			unicast_packet->ttl = TTL;
-			/* copy the destination for faster routing */
-			memcpy(unicast_packet->dest, orig_node->orig, ETH_ALEN);
-
-			/* net_dev won't be available when not active */
-			if (router->if_incoming->if_status != IF_ACTIVE)
-				goto unlock;
-
-			/* don't lock while sending the packets ... we therefore
-			 * copy the required data before sending */
-
-			batman_if = router->if_incoming;
-			memcpy(dstaddr, router->addr, ETH_ALEN);
-			spin_unlock_irqrestore(&orig_hash_lock, flags);
-
-			send_skb_packet(skb, batman_if, dstaddr);
-		} else {
+		if (!router)
 			goto unlock;
-		}
+
+		/* don't lock while sending the packets ... we therefore
+		 * copy the required data before sending */
+
+		batman_if = router->if_incoming;
+		memcpy(dstaddr, router->addr, ETH_ALEN);
+
+		spin_unlock_irqrestore(&orig_hash_lock, flags);
+
+		if (batman_if->if_status != IF_ACTIVE)
+			goto dropped;
+
+		if (my_skb_push(skb, sizeof(struct unicast_packet)) < 0)
+			goto dropped;
+
+		unicast_packet = (struct unicast_packet *)skb->data;
+
+		unicast_packet->version = COMPAT_VERSION;
+		/* batman packet type: unicast */
+		unicast_packet->packet_type = BAT_UNICAST;
+		/* set unicast ttl */
+		unicast_packet->ttl = TTL;
+		/* copy the destination for faster routing */
+		memcpy(unicast_packet->dest, orig_node->orig, ETH_ALEN);
+
+		send_skb_packet(skb, batman_if, dstaddr);
 	}
 
 	priv->stats.tx_packets++;
diff --git a/drivers/staging/batman-adv/types.h b/drivers/staging/batman-adv/types.h
index d0af489..84c3f43 100644
--- a/drivers/staging/batman-adv/types.h
+++ b/drivers/staging/batman-adv/types.h
@@ -52,6 +52,7 @@ struct batman_if {
 
 /**
   *	orig_node - structure for orig_list maintaining nodes of mesh
+  *	@primary_addr: hosts primary interface address
   *	@last_valid: when last packet from this node was received
   *	@bcast_seqno_reset: time when the broadcast seqno window was reset
   *	@batman_seqno_reset: time when the batman seqno window was reset
@@ -59,9 +60,13 @@ struct batman_if {
   *	@last_real_seqno: last and best known squence number
   *	@last_ttl: ttl of last received packet
   *	@last_bcast_seqno: last broadcast sequence number received by this host
+  *
+  *	@candidates: how many candidates are available
+  *	@selected: next bonding candidate
  */
 struct orig_node {
 	uint8_t orig[ETH_ALEN];
+	uint8_t primary_addr[ETH_ALEN];
 	struct neigh_node *router;
 	TYPE_OF_WORD *bcast_own;
 	uint8_t *bcast_own_sum;
@@ -78,6 +83,10 @@ struct orig_node {
 	TYPE_OF_WORD bcast_bits[NUM_WORDS];
 	uint32_t last_bcast_seqno;
 	struct list_head neigh_list;
+	struct {
+		uint8_t candidates;
+		struct neigh_node *selected;
+	} bond;
 };
 
 /**
@@ -92,6 +101,7 @@ struct neigh_node {
 	uint8_t tq_index;
 	uint8_t tq_avg;
 	uint8_t last_ttl;
+	struct neigh_node *next_bond_candidate;
 	unsigned long last_valid;
 	TYPE_OF_WORD real_bits[NUM_WORDS];
 	struct orig_node *orig_node;
@@ -101,6 +111,7 @@ struct neigh_node {
 struct bat_priv {
 	struct net_device_stats stats;
 	atomic_t aggregation_enabled;
+	atomic_t bonding_enabled;
 	atomic_t vis_mode;
 	atomic_t orig_interval;
 	char num_ifaces;
-- 
1.7.1

