Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Mon, 4 Jan 2010 19:27:10 +0100
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20100104182710.GA24091@pandem0nium>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
Content-Disposition: inline
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Add bonding functionality
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.net

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
neighbors, if multiple interfaces are available. The neighbors should be
almost equally good to reach.

To avoid interferences (i.e. sending on the same channel), only neighbors 
with different mac addresses and interfaces are considered as candidates.

Bonding is deactivated by default, and can be activated by 

echo 1 > /proc/net/batman-adv/bonding

for each individual node.

Any suggestions or comments are welcome.

Signed-off-by: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
---

Index: a/batman-adv-kernelland/types.h
===================================================================
--- a/batman-adv-kernelland/types.h	(revision 1532)
+++ b/batman-adv-kernelland/types.h	(working copy)
@@ -48,6 +48,7 @@
 
 struct orig_node {               /* structure for orig_list maintaining nodes of mesh */
 	uint8_t orig[ETH_ALEN];
+	uint8_t primary_addr[ETH_ALEN];	/* hosts primary interface address */
 	struct neigh_node *router;
 	struct batman_if *batman_if;
 	TYPE_OF_WORD *bcast_own;
@@ -64,6 +65,10 @@
 	TYPE_OF_WORD bcast_bits[NUM_WORDS];
 	uint16_t last_bcast_seqno;  /* last broadcast sequence number received by this host */
 	struct list_head neigh_list;
+	struct {
+		uint8_t candidates;	/* how many candidates are available */
+		struct neigh_node *selected;	/* next bonding candidate */
+	} bond;
 };
 
 struct neigh_node {
@@ -74,6 +79,7 @@
 	uint8_t tq_index;
 	uint8_t tq_avg;
 	uint8_t last_ttl;
+	struct neigh_node *next_bond_candidate;
 	unsigned long last_valid;            /* when last packet via this neighbor was received */
 	TYPE_OF_WORD real_bits[NUM_WORDS];
 	struct orig_node *orig_node;
Index: a/batman-adv-kernelland/packet.h
===================================================================
--- a/batman-adv-kernelland/packet.h	(revision 1532)
+++ b/batman-adv-kernelland/packet.h	(working copy)
@@ -31,6 +31,7 @@
 #define COMPAT_VERSION 8
 #define DIRECTLINK 0x40
 #define VIS_SERVER 0x20
+#define PRIMARIES_FIRST_HOP 0x10
 
 /* ICMP message types */
 #define ECHO_REPLY 0
Index: a/batman-adv-kernelland/send.c
===================================================================
--- a/batman-adv-kernelland/send.c	(revision 1532)
+++ b/batman-adv-kernelland/send.c	(working copy)
@@ -275,9 +275,9 @@
 	batman_packet->seqno = htons((uint16_t)atomic_read(&batman_if->seqno));
 
 	if (is_vis_server())
-		batman_packet->flags = VIS_SERVER;
+		batman_packet->flags |= VIS_SERVER;
 	else
-		batman_packet->flags = 0;
+		batman_packet->flags &= ~VIS_SERVER;
 
 	/* could be read by receive_bat_packet() */
 	atomic_inc(&batman_if->seqno);
@@ -332,6 +332,8 @@
 
 	batman_packet->seqno = htons(batman_packet->seqno);
 
+	/* switch of primaries first hop flag when forwarding */
+	batman_packet->flags &= ~PRIMARIES_FIRST_HOP;
 	if (directlink)
 		batman_packet->flags |= DIRECTLINK;
 	else
Index: a/batman-adv-kernelland/proc.c
===================================================================
--- a/batman-adv-kernelland/proc.c	(revision 1532)
+++ b/batman-adv-kernelland/proc.c	(working copy)
@@ -35,6 +35,7 @@
 static struct proc_dir_entry *proc_transt_global_file;
 static struct proc_dir_entry *proc_vis_srv_file, *proc_vis_data_file;
 static struct proc_dir_entry *proc_aggr_file;
+static struct proc_dir_entry *proc_bond_file;
 
 static int proc_interfaces_read(struct seq_file *seq, void *offset)
 {
@@ -462,6 +463,53 @@
 	return single_open(file, proc_aggr_read, NULL);
 }
 
+static int proc_bond_read(struct seq_file *seq, void *offset)
+{
+	seq_printf(seq, "%i\n", atomic_read(&bonding_enabled));
+
+	return 0;
+}
+
+static ssize_t proc_bond_write(struct file *file, const char __user *buffer,
+			       size_t count, loff_t *ppos)
+{
+	char *bond_string;
+	int not_copied = 0;
+	unsigned long bonding_enabled_tmp;
+	int retval;
+
+	bond_string = kmalloc(count, GFP_KERNEL);
+
+	if (!bond_string)
+		return -ENOMEM;
+
+	not_copied = copy_from_user(bond_string, buffer, count);
+	bond_string[count - not_copied - 1] = 0;
+
+	retval = strict_strtoul(bond_string, 10, &bonding_enabled_tmp);
+
+	if (retval || bonding_enabled_tmp > 1) {
+		printk(KERN_ERR "batman-adv: Bonding can only be enabled (1) or disabled (0), given value: %li\n", bonding_enabled_tmp);
+	} else {
+		printk(KERN_INFO "batman-adv:Changing bonding from: %s (%i) to: %s (%li)\n",
+		       (atomic_read(&bonding_enabled) == 1 ?
+			"enabled" : "disabled"),
+		       atomic_read(&bonding_enabled),
+		       (bonding_enabled_tmp == 1 ? "enabled" : "disabled"),
+		       bonding_enabled_tmp);
+		atomic_set(&bonding_enabled,
+						(unsigned)bonding_enabled_tmp);
+	}
+
+	kfree(bond_string);
+	return count;
+}
+
+static int proc_bond_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, proc_bond_read, NULL);
+}
+
 /* satisfying different prototypes ... */
 static ssize_t proc_dummy_write(struct file *file, const char __user *buffer,
 				size_t count, loff_t *ppos)
@@ -478,6 +526,15 @@
 	.release	= single_release,
 };
 
+static const struct file_operations proc_bond_fops = {
+	.owner		= THIS_MODULE,
+	.open		= proc_bond_open,
+	.read		= seq_read,
+	.write		= proc_bond_write,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
 static const struct file_operations proc_vis_srv_fops = {
 	.owner		= THIS_MODULE,
 	.open		= proc_vis_srv_open,
@@ -567,6 +624,10 @@
 	if (proc_aggr_file)
 		remove_proc_entry(PROC_FILE_AGGR, proc_batman_dir);
 
+	if (proc_bond_file)
+		remove_proc_entry(PROC_FILE_BOND, proc_batman_dir);
+
+
 	if (proc_batman_dir)
 #ifdef __NET_NET_NAMESPACE_H
 		remove_proc_entry(PROC_ROOT_DIR, init_net.proc_net);
@@ -671,5 +732,15 @@
 		return -EFAULT;
 	}
 
+	proc_bond_file = create_proc_entry(PROC_FILE_BOND, S_IWUSR | S_IRUGO,
+					   proc_batman_dir);
+	if (proc_bond_file) {
+		proc_bond_file->proc_fops = &proc_bond_fops;
+	} else {
+		printk(KERN_ERR "batman-adv: Registering the '/proc/net/%s/%s' file failed\n", PROC_ROOT_DIR, PROC_FILE_BOND);
+		cleanup_procfs();
+		return -EFAULT;
+	}
+
 	return 0;
 }
Index: a/batman-adv-kernelland/proc.h
===================================================================
--- a/batman-adv-kernelland/proc.h	(revision 1532)
+++ b/batman-adv-kernelland/proc.h	(working copy)
@@ -34,6 +34,7 @@
 #define PROC_FILE_VIS_SRV "vis_server"
 #define PROC_FILE_VIS_DATA "vis_data"
 #define PROC_FILE_AGGR "aggregate_ogm"
+#define PROC_FILE_BOND "bonding"
 
 void cleanup_procfs(void);
 int setup_procfs(void);
Index: a/batman-adv-kernelland/soft-interface.c
===================================================================
--- a/batman-adv-kernelland/soft-interface.c	(revision 1532)
+++ b/batman-adv-kernelland/soft-interface.c	(working copy)
@@ -22,6 +22,7 @@
 #include "main.h"
 #include "soft-interface.h"
 #include "hard-interface.h"
+#include "routing.h"
 #include "send.h"
 #include "translation-table.h"
 #include "types.h"
@@ -170,11 +171,14 @@
 	return 0;
 }
 
+
+
 int interface_tx(struct sk_buff *skb, struct net_device *dev)
 {
 	struct unicast_packet *unicast_packet;
 	struct bcast_packet *bcast_packet;
 	struct orig_node *orig_node;
+	struct neigh_node *router;
 	struct ethhdr *ethhdr = (struct ethhdr *)skb->data;
 	struct bat_priv *priv = netdev_priv(dev);
 	struct batman_if *batman_if;
@@ -227,37 +231,36 @@
 		if (!orig_node)
 			orig_node = transtable_search(ethhdr->h_dest);
 
-		if ((orig_node) &&
-		    (orig_node->batman_if) &&
-		    (orig_node->router)) {
-			if (my_skb_push(skb, sizeof(struct unicast_packet)) < 0)
-				goto unlock;
+		router = find_router(orig_node);
 
-			unicast_packet = (struct unicast_packet *)skb->data;
+		if (!router)
+			goto unlock;
 
-			unicast_packet->version = COMPAT_VERSION;
-			/* batman packet type: unicast */
-			unicast_packet->packet_type = BAT_UNICAST;
-			/* set unicast ttl */
-			unicast_packet->ttl = TTL;
-			/* copy the destination for faster routing */
-			memcpy(unicast_packet->dest, orig_node->orig, ETH_ALEN);
+		/* don't lock while sending the packets ... we therefore
+		 * copy the required data before sending */
 
-			/* net_dev won't be available when not active */
-			if (orig_node->batman_if->if_active != IF_ACTIVE)
-				goto unlock;
+		batman_if = router->if_incoming;
+		memcpy(dstaddr, router->addr, ETH_ALEN);
 
-			/* don't lock while sending the packets ... we therefore
-			 * copy the required data before sending */
+		spin_unlock_irqrestore(&orig_hash_lock, flags);
 
-			batman_if = orig_node->batman_if;
-			memcpy(dstaddr, orig_node->router->addr, ETH_ALEN);
-			spin_unlock_irqrestore(&orig_hash_lock, flags);
+		if (batman_if->if_active != IF_ACTIVE)
+			goto dropped;
 
-			send_skb_packet(skb, batman_if, dstaddr);
-		} else {
-			goto unlock;
-		}
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
Index: a/batman-adv-kernelland/hard-interface.c
===================================================================
--- a/batman-adv-kernelland/hard-interface.c	(revision 1532)
+++ b/batman-adv-kernelland/hard-interface.c	(working copy)
@@ -312,9 +312,9 @@
 	batman_packet = (struct batman_packet *)(batman_if->packet_buff);
 	batman_packet->packet_type = BAT_PACKET;
 	batman_packet->version = COMPAT_VERSION;
-	batman_packet->flags = 0x00;
-	batman_packet->ttl = (batman_if->if_num > 0 ? 2 : TTL);
-	batman_packet->flags = 0;
+	batman_packet->flags = batman_if->if_num > 0 ?
+			0x00 : PRIMARIES_FIRST_HOP;
+	batman_packet->ttl = batman_if->if_num > 0 ? 2 : TTL;
 	batman_packet->tq = TQ_MAX_VALUE;
 	batman_packet->num_hna = 0;
 
Index: a/batman-adv-kernelland/originator.c
===================================================================
--- a/batman-adv-kernelland/originator.c	(revision 1532)
+++ b/batman-adv-kernelland/originator.c	(working copy)
@@ -221,10 +221,15 @@
 			orig_node->orig, (orig_node->last_valid / HZ));
 		return true;
 	} else {
-		if (purge_orig_neighbors(orig_node, &best_neigh_node))
+		if (purge_orig_neighbors(orig_node, &best_neigh_node)) {
 			update_routes(orig_node, best_neigh_node,
 				      orig_node->hna_buff,
 				      orig_node->hna_buff_len);
+			/* set bonding candidates to zero. Will be updated
+			 * at the next incoming packet for this originator. */
+
+			orig_node->bond.candidates = 0;
+		}
 	}
 	return false;
 }
Index: a/batman-adv-kernelland/main.c
===================================================================
--- a/batman-adv-kernelland/main.c	(revision 1532)
+++ b/batman-adv-kernelland/main.c	(working copy)
@@ -45,6 +45,7 @@
 atomic_t originator_interval;
 atomic_t vis_interval;
 atomic_t aggregation_enabled;
+atomic_t bonding_enabled;
 int16_t num_hna;
 int16_t num_ifs;
 
@@ -85,6 +86,7 @@
 	atomic_set(&vis_interval, 1000);/* TODO: raise this later, this is only
 					 * for debugging now. */
 	atomic_set(&aggregation_enabled, 1);
+	atomic_set(&bonding_enabled, 0);
 
 	/* the name should not be longer than 10 chars - see
 	 * http://lwn.net/Articles/23634/ */
Index: a/batman-adv-kernelland/routing.c
===================================================================
--- a/batman-adv-kernelland/routing.c	(revision 1532)
+++ b/batman-adv-kernelland/routing.c	(working copy)
@@ -352,6 +352,106 @@
 	return is_duplicate;
 }
 
+/* mark possible bonding candidates in the neighbor list */
+static void update_bonding(struct orig_node *orig_node,
+				struct orig_node *orig_neigh_node,
+				struct batman_packet *batman_packet)
+{
+	int candidates;
+	int interference_candidate;
+	int best_tq;
+	struct neigh_node *tmp_neigh_node, *tmp_neigh_node2;
+    struct neigh_node *first_candidate, *last_candidate;
+
+	/* don't care if bonding is not enabled */
+	if (!atomic_read(&bonding_enabled)) {
+		orig_node->bond.candidates = 0;
+		return;
+	}
+
+	if (batman_packet->flags & PRIMARIES_FIRST_HOP)
+		memcpy(orig_neigh_node->primary_addr,
+						orig_node->orig, ETH_ALEN);
+	 else
+		return;
+
+	/* update the candidates for this originator */
+	if (!orig_node->router) {
+		orig_node->bond.candidates = 0;
+		return;
+	}
+
+	best_tq = orig_node->router->tq_avg;
+
+	/* update bonding candidates */
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
@@ -518,6 +618,8 @@
 		update_orig(orig_node, ethhdr, batman_packet,
 			    if_incoming, hna_buff, hna_buff_len, is_duplicate);
 
+	update_bonding(orig_node, orig_neigh_node, batman_packet);
+
 	/* is single hop (direct) neighbor */
 	if (is_single_hop_neigh) {
 
@@ -788,16 +890,67 @@
 	return ret;
 }
 
+/* find a suitable router for this originator, and use
+ * bonding if possible. */
+struct neigh_node *find_router(struct orig_node *orig_node)
+{
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
+	if (!atomic_read(&bonding_enabled))
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
+	 * even be the same as our orig_node in many cases */
+
+	primary_orig_node = hash_find(orig_hash, router_orig->primary_addr);
+	if (!primary_orig_node)
+		return orig_node->router;
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
@@ -832,42 +985,43 @@
 		return NET_RX_DROP;
 	}
 
-	ret = NET_RX_DROP;
 	/* get routing information */
 	spin_lock_irqsave(&orig_hash_lock, flags);
 	orig_node = ((struct orig_node *)
 		     hash_find(orig_hash, unicast_packet->dest));
 
-	if ((orig_node != NULL) &&
-	    (orig_node->batman_if != NULL) &&
-	    (orig_node->router != NULL)) {
+	router = find_router(orig_node);
 
-		/* don't lock while sending the packets ... we therefore
-		 * copy the required data before sending */
-		batman_if = orig_node->batman_if;
-		memcpy(dstaddr, orig_node->router->addr, ETH_ALEN);
-		spin_unlock_irqrestore(&orig_hash_lock, flags);
+	if (!router) {
+		spin_lock_irqsave(&orig_hash_lock, flags);
+		return NET_RX_DROP;
+	}
 
-		/* create a copy of the skb, if needed, to modify it. */
-		if (!skb_clone_writable(skb, sizeof(struct unicast_packet))) {
-			skb_old = skb;
-			skb = skb_copy(skb, GFP_ATOMIC);
-			if (!skb)
-				return NET_RX_DROP;
-			unicast_packet = (struct unicast_packet *) skb->data;
-			kfree_skb(skb_old);
-		}
-		/* decrement ttl */
-		unicast_packet->ttl--;
+	/* don't lock while sending the packets ... we therefore
+	 * copy the required data before sending */
 
-		/* route it */
-		send_skb_packet(skb, batman_if, dstaddr);
-		ret = NET_RX_SUCCESS;
+	batman_if = router->if_incoming;
+	memcpy(dstaddr, router->addr, ETH_ALEN);
 
-	} else
-		spin_unlock_irqrestore(&orig_hash_lock, flags);
+	spin_unlock_irqrestore(&orig_hash_lock, flags);
 
-	return ret;
+	/* create a copy of the skb, if needed, to modify it. */
+	if (!skb_clone_writable(skb, sizeof(struct unicast_packet))) {
+		skb_old = skb;
+		skb = skb_copy(skb, GFP_ATOMIC);
+		if (!skb)
+			return NET_RX_DROP;
+		unicast_packet = (struct unicast_packet *) skb->data;
+		kfree_skb(skb_old);
+	}
+
+	/* decrement ttl */
+	unicast_packet->ttl--;
+
+	/* route it */
+	send_skb_packet(skb, batman_if, dstaddr);
+
+	return NET_RX_SUCCESS;
 }
 
 
Index: a/batman-adv-kernelland/main.h
===================================================================
--- a/batman-adv-kernelland/main.h	(revision 1532)
+++ b/batman-adv-kernelland/main.h	(working copy)
@@ -58,6 +58,11 @@
 #define LOG_BUF_LEN 8192	  /* has to be a power of 2 */
 #define ETH_STR_LEN 20
 
+/* how much worse secondary interfaces may be to
+ * to be considered as bonding candidates */
+
+#define BONDING_TQ_THRESHOLD	50
+
 #define MAX_AGGREGATION_BYTES 512 /* should not be bigger than 512 bytes or
 				   * change the size of
 				   * forw_packet->direct_link_flags */
@@ -131,6 +136,7 @@
 extern atomic_t originator_interval;
 extern atomic_t vis_interval;
 extern atomic_t aggregation_enabled;
+extern atomic_t bonding_enabled;
 extern int16_t num_hna;
 extern int16_t num_ifs;
 
Index: a/batman-adv-kernelland/routing.h
===================================================================
--- a/batman-adv-kernelland/routing.h	(revision 1532)
+++ b/batman-adv-kernelland/routing.h	(working copy)
@@ -38,3 +38,4 @@
 int recv_vis_packet(struct sk_buff *skb);
 int recv_bat_packet(struct sk_buff *skb,
 				struct batman_if *batman_if);
+struct neigh_node *find_router(struct orig_node *orig_node);

