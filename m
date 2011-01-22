Return-Path: <linus.luessing@web.de>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@saxnet.de>
Date: Sat, 22 Jan 2011 02:21:36 +0100
Message-Id: <1295659302-7171-14-git-send-email-linus.luessing@saxnet.de>
In-Reply-To: <1295659302-7171-1-git-send-email-linus.luessing@saxnet.de>
References: <1295659302-7171-1-git-send-email-linus.luessing@saxnet.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linus.luessing@web.de
Subject: [B.A.T.M.A.N.] [PATCH 13/19] batman-adv: Send own BAT_MCAST packets
	in proact_tracking multicast mode
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
Cc: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@saxnet.de>

This patch adds the capability to encapsulate and send a node's own
multicast data packets. Based on the previously established multicast
forwarding table, the sender can decide wheather it actually has to send
the multicast data to one or more of its interfaces or not.

Furthermore, the sending procedure also decides whether to broadcast or
unicast a multicast data packet to its next-hops, depending on the
configured mcast_fanout (default: < 3 next hops on an interface, send
seperate unicast packets).

Signed-off-by: Linus Lüssing <linus.luessing@saxnet.de>
---
 multicast.c      |  163 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 multicast.h      |    1 +
 soft-interface.c |   27 ++++++++-
 types.h          |    1 +
 4 files changed, 188 insertions(+), 4 deletions(-)

diff --git a/batman-adv/multicast.c b/batman-adv/multicast.c
index e47cc56..a8613ef 100644
--- a/batman-adv/multicast.c
+++ b/batman-adv/multicast.c
@@ -23,6 +23,8 @@
 #include "multicast.h"
 #include "hash.h"
 #include "send.h"
+#include "soft-interface.h"
+#include "hard-interface.h"
 #include "compat.h"
 
 /* If auto mode for tracker timeout has been selected,
@@ -1154,6 +1156,167 @@ int mcast_forw_table_seq_print_text(struct seq_file *seq, void *offset)
 	return 0;
 }
 
+static inline void nexthops_from_if_list(struct list_head *mcast_if_list,
+					 struct list_head *nexthop_list,
+					 struct bat_priv *bat_priv)
+{
+	struct batman_if *batman_if;
+	struct mcast_forw_if_entry *if_entry;
+	struct mcast_forw_nexthop_entry *nexthop_entry;
+	struct dest_entries_list *dest_entry;
+	int mcast_fanout = atomic_read(&bat_priv->mcast_fanout);
+
+	list_for_each_entry(if_entry, mcast_if_list, list) {
+		rcu_read_lock();
+		batman_if = if_num_to_batman_if(if_entry->if_num);
+		if (!batman_if) {
+			rcu_read_unlock();
+			continue;
+		}
+
+		kref_get(&batman_if->refcount);
+		rcu_read_unlock();
+
+
+		/* send via broadcast */
+		if (if_entry->num_nexthops > mcast_fanout) {
+			dest_entry = kmalloc(sizeof(struct dest_entries_list),
+					     GFP_ATOMIC);
+			memcpy(dest_entry->dest, broadcast_addr, ETH_ALEN);
+			dest_entry->batman_if = batman_if;
+			list_add(&dest_entry->list, nexthop_list);
+			continue;
+		}
+
+		/* send separate unicast packets */
+		list_for_each_entry(nexthop_entry,
+				    &if_entry->mcast_nexthop_list, list) {
+			if (!get_remaining_timeout(nexthop_entry, bat_priv))
+				continue;
+
+			dest_entry = kmalloc(sizeof(struct dest_entries_list),
+					     GFP_ATOMIC);
+			memcpy(dest_entry->dest, nexthop_entry->neigh_addr,
+			       ETH_ALEN);
+
+			kref_get(&batman_if->refcount);
+			dest_entry->batman_if = batman_if;
+			list_add(&dest_entry->list, nexthop_list);
+		}
+		kref_put(&batman_if->refcount, hardif_free_ref);
+	}
+}
+
+static inline void nexthops_from_orig_list(uint8_t *orig,
+					   struct list_head *mcast_orig_list,
+					   struct list_head *nexthop_list,
+					   struct bat_priv *bat_priv)
+{
+	struct mcast_forw_orig_entry *orig_entry;
+
+	list_for_each_entry(orig_entry, mcast_orig_list, list) {
+		if (memcmp(orig, orig_entry->orig, ETH_ALEN))
+			continue;
+
+		nexthops_from_if_list(&orig_entry->mcast_if_list, nexthop_list,
+				      bat_priv);
+		break;
+	}
+}
+
+static inline void nexthops_from_table(uint8_t *dest, uint8_t *orig,
+				       struct list_head *mcast_forw_table,
+				       struct list_head *nexthop_list,
+				       struct bat_priv *bat_priv)
+{
+	struct mcast_forw_table_entry *table_entry;
+
+	list_for_each_entry(table_entry, mcast_forw_table, list) {
+		if (memcmp(dest, table_entry->mcast_addr, ETH_ALEN))
+			continue;
+
+		nexthops_from_orig_list(orig, &table_entry->mcast_orig_list,
+					nexthop_list, bat_priv);
+		break;
+	}
+}
+
+static void route_mcast_packet(struct sk_buff *skb, struct bat_priv *bat_priv)
+{
+	struct sk_buff *skb1;
+	struct mcast_packet *mcast_packet;
+	struct ethhdr *ethhdr;
+	int num_bcasts = 3, i;
+	struct list_head nexthop_list;
+	struct dest_entries_list *dest_entry, *tmp;
+
+	mcast_packet = (struct mcast_packet *)skb->data;
+	ethhdr = (struct ethhdr *)(mcast_packet + 1);
+
+	INIT_LIST_HEAD(&nexthop_list);
+
+	mcast_packet->ttl--;
+
+	spin_lock_bh(&bat_priv->mcast_forw_table_lock);
+	nexthops_from_table(ethhdr->h_dest, mcast_packet->orig,
+			    &bat_priv->mcast_forw_table, &nexthop_list,
+			    bat_priv);
+	spin_unlock_bh(&bat_priv->mcast_forw_table_lock);
+
+	list_for_each_entry_safe(dest_entry, tmp, &nexthop_list, list) {
+		if (is_broadcast_ether_addr(dest_entry->dest)) {
+			for (i = 0; i < num_bcasts; i++) {
+				skb1 = skb_clone(skb, GFP_ATOMIC);
+				send_skb_packet(skb1, dest_entry->batman_if,
+						dest_entry->dest);
+			}
+		} else {
+			skb1 = skb_clone(skb, GFP_ATOMIC);
+			send_skb_packet(skb1, dest_entry->batman_if,
+					dest_entry->dest);
+		}
+		kref_put(&dest_entry->batman_if->refcount, hardif_free_ref);
+		list_del(&dest_entry->list);
+		kfree(dest_entry);
+	}
+}
+
+int mcast_send_skb(struct sk_buff *skb, struct bat_priv *bat_priv)
+{
+	struct mcast_packet *mcast_packet;
+
+	if (!bat_priv->primary_if)
+		goto dropped;
+
+	if (my_skb_head_push(skb, sizeof(struct mcast_packet)) < 0)
+		goto dropped;
+
+	mcast_packet = (struct mcast_packet *)skb->data;
+	mcast_packet->version = COMPAT_VERSION;
+	mcast_packet->ttl = TTL;
+
+	/* batman packet type: broadcast */
+	mcast_packet->packet_type = BAT_MCAST;
+
+	/* hw address of first interface is the orig mac because only
+	 * this mac is known throughout the mesh */
+	memcpy(mcast_packet->orig,
+	       bat_priv->primary_if->net_dev->dev_addr, ETH_ALEN);
+
+	/* set broadcast sequence number */
+	mcast_packet->seqno =
+		htonl(atomic_inc_return(&bat_priv->mcast_seqno));
+
+	route_mcast_packet(skb, bat_priv);
+
+	kfree_skb(skb);
+	return 0;
+
+dropped:
+	kfree_skb(skb);
+	return 1;
+}
+
 int mcast_init(struct bat_priv *bat_priv)
 {
 	INIT_DELAYED_WORK(&bat_priv->mcast_tracker_work, mcast_tracker_timer);
diff --git a/batman-adv/multicast.h b/batman-adv/multicast.h
index 7312afa..06dd398 100644
--- a/batman-adv/multicast.h
+++ b/batman-adv/multicast.h
@@ -32,6 +32,7 @@ void route_mcast_tracker_packet(
 			int tracker_packet_len, struct bat_priv *bat_priv);
 void purge_mcast_forw_table(struct bat_priv *bat_priv);
 int mcast_forw_table_seq_print_text(struct seq_file *seq, void *offset);
+int mcast_send_skb(struct sk_buff *skb, struct bat_priv *bat_priv);
 int mcast_init(struct bat_priv *bat_priv);
 void mcast_free(struct bat_priv *bat_priv);
 
diff --git a/batman-adv/soft-interface.c b/batman-adv/soft-interface.c
index 7cea678..2f327c4 100644
--- a/batman-adv/soft-interface.c
+++ b/batman-adv/soft-interface.c
@@ -38,6 +38,7 @@
 #include <linux/if_vlan.h>
 #include "unicast.h"
 #include "routing.h"
+#include "multicast.h"
 
 
 static int bat_get_settings(struct net_device *dev, struct ethtool_cmd *cmd);
@@ -347,7 +348,7 @@ int interface_tx(struct sk_buff *skb, struct net_device *soft_iface)
 	struct vlan_ethhdr *vhdr;
 	int data_len = skb->len, ret;
 	short vid = -1;
-	bool do_bcast = false;
+	bool bcast_dst = false, mcast_dst = false;
 
 	if (atomic_read(&bat_priv->mesh_state) != MESH_ACTIVE)
 		goto dropped;
@@ -384,12 +385,22 @@ int interface_tx(struct sk_buff *skb, struct net_device *soft_iface)
 		if (ret < 0)
 			goto dropped;
 
-		if (ret == 0)
-			do_bcast = true;
+		/* dhcp request, which should be sent to the gateway
+		 * directly? */
+		if (ret)
+			goto unicast;
+
+		if (is_broadcast_ether_addr(ethhdr->h_dest))
+			bcast_dst = true;
+		else if (atomic_read(&bat_priv->mcast_mode) ==
+			 MCAST_MODE_PROACT_TRACKING)
+			mcast_dst = true;
+		else
+			bcast_dst = true;
 	}
 
 	/* ethernet packet should be broadcasted */
-	if (do_bcast) {
+	if (bcast_dst) {
 		if (!bat_priv->primary_if)
 			goto dropped;
 
@@ -418,8 +429,15 @@ int interface_tx(struct sk_buff *skb, struct net_device *soft_iface)
 		 * the original skb. */
 		kfree_skb(skb);
 
+	/* multicast data with path optimization */
+	} else if (mcast_dst) {
+		ret = mcast_send_skb(skb, bat_priv);
+		if (ret != 0)
+			goto dropped_freed;
+
 	/* unicast packet */
 	} else {
+unicast:
 		ret = unicast_send_skb(skb, bat_priv);
 		if (ret != 0)
 			goto dropped_freed;
@@ -608,6 +626,7 @@ struct net_device *softif_create(char *name)
 
 	atomic_set(&bat_priv->mesh_state, MESH_INACTIVE);
 	atomic_set(&bat_priv->bcast_seqno, 1);
+	atomic_set(&bat_priv->mcast_seqno, 1);
 	atomic_set(&bat_priv->hna_local_changed, 0);
 
 	bat_priv->primary_if = NULL;
diff --git a/batman-adv/types.h b/batman-adv/types.h
index 75adec9..2857fba 100644
--- a/batman-adv/types.h
+++ b/batman-adv/types.h
@@ -145,6 +145,7 @@ struct bat_priv {
 	atomic_t mcast_fanout;		/* uint */
 	atomic_t log_level;		/* uint */
 	atomic_t bcast_seqno;
+	atomic_t mcast_seqno;
 	atomic_t bcast_queue_left;
 	atomic_t batman_queue_left;
 	char num_ifaces;
-- 
1.7.2.3

