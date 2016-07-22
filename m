Return-Path: <linus.luessing@c0d3.blue>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Date: Fri, 22 Jul 2016 13:38:02 +0200
Message-Id: <1469187482-29894-2-git-send-email-linus.luessing@c0d3.blue>
In-Reply-To: <1469187482-29894-1-git-send-email-linus.luessing@c0d3.blue>
References: <1469187482-29894-1-git-send-email-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 2/2] batman-adv: Simple (re)broadcast
	avoidance
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

With this patch, (re)broadcasting on a specific interfaces is avoided:

* No neighbor: There is no need to broadcast on an interface if there
  is no node behind it.

* Single neighbor is source: If there is just one neighbor on an
  interface and if this neighbor is the one we actually got this
  broadcast packet from, then we do not need to echo it back.

* Single neighbor is originator: If there is just one neighbor on
  an interface and if this neighbor is the originator of this
  broadcast packet, then we do not need to echo it back.

=== Goodies for BATMAN V ===

("Upgrade your BATMAN IV network to V now to get these for free!")

Thanks to the split of OGMv1 into two packet types, OGMv2 and ELP
that is, we can now apply the same opitimizations stated above to OGMv2
packets, too.

Furthermore, with BATMAN V, rebroadcasts can be reduced in certain
multi interface cases, too, where BATMAN IV cannot. This is thanks to
the removal of the "secondary interface originator" concept in BATMAN V.

Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
---
 net/batman-adv/bat_v_ogm.c      | 44 ++++++++++++++++++++++++++++++++++
 net/batman-adv/hard-interface.c | 53 +++++++++++++++++++++++++++++++++++++++++
 net/batman-adv/hard-interface.h | 17 +++++++++++++
 net/batman-adv/originator.c     | 13 ++++++----
 net/batman-adv/routing.c        |  1 +
 net/batman-adv/send.c           | 47 ++++++++++++++++++++++++++++++++++++
 net/batman-adv/soft-interface.c |  2 ++
 net/batman-adv/types.h          |  1 +
 8 files changed, 174 insertions(+), 4 deletions(-)

diff --git a/net/batman-adv/bat_v_ogm.c b/net/batman-adv/bat_v_ogm.c
index 1aeeadc..884fe0d 100644
--- a/net/batman-adv/bat_v_ogm.c
+++ b/net/batman-adv/bat_v_ogm.c
@@ -140,6 +140,7 @@ static void batadv_v_ogm_send(struct work_struct *work)
 	unsigned char *ogm_buff, *pkt_buff;
 	int ogm_buff_len;
 	u16 tvlv_len = 0;
+	int ret;
 
 	bat_v = container_of(work, struct batadv_priv_bat_v, ogm_wq.work);
 	bat_priv = container_of(bat_v, struct batadv_priv, bat_v);
@@ -182,6 +183,25 @@ static void batadv_v_ogm_send(struct work_struct *work)
 		if (!kref_get_unless_zero(&hard_iface->refcount))
 			continue;
 
+		ret = batadv_hardif_no_broadcast(hard_iface, NULL, NULL);
+		if (ret) {
+			char *type = "unknown";
+
+			if (ret == BATADV_HARDIF_BCAST_NORECIPIENT)
+				type = "no neighbor";
+
+			if (ret == BATADV_HARDIF_BCAST_DUPFWD)
+				type = "single neighbor is source";
+
+			if (ret == BATADV_HARDIF_BCAST_DUPORIG)
+				type = "single neighbor is originator";
+
+			batadv_dbg(BATADV_DBG_BATMAN, bat_priv, "OGM2 from ourselve on %s surpressed: %s\n",
+				   hard_iface->net_dev->name, type);
+
+			continue;
+		}
+
 		batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
 			   "Sending own OGM2 packet (originator %pM, seqno %u, throughput %u, TTL %d) on interface %s [%pM]\n",
 			   ogm_packet->orig, ntohl(ogm_packet->seqno),
@@ -651,6 +671,7 @@ static void batadv_v_ogm_process(const struct sk_buff *skb, int ogm_offset,
 	struct batadv_hard_iface *hard_iface;
 	struct batadv_ogm2_packet *ogm_packet;
 	u32 ogm_throughput, link_throughput, path_throughput;
+	int ret;
 
 	ethhdr = eth_hdr(skb);
 	ogm_packet = (struct batadv_ogm2_packet *)(skb->data + ogm_offset);
@@ -716,6 +737,29 @@ static void batadv_v_ogm_process(const struct sk_buff *skb, int ogm_offset,
 		if (!kref_get_unless_zero(&hard_iface->refcount))
 			continue;
 
+		ret = batadv_hardif_no_broadcast(hard_iface,
+						 hardif_neigh->orig_node,
+						 ogm_packet->orig);
+
+		if (ret) {
+			char *type = "unknown";
+
+			if (ret == BATADV_HARDIF_BCAST_NORECIPIENT)
+				type = "no neighbor";
+
+			if (ret == BATADV_HARDIF_BCAST_DUPFWD)
+				type = "single neighbor is source";
+
+			if (ret == BATADV_HARDIF_BCAST_DUPORIG)
+				type = "single neighbor is originator";
+
+			batadv_dbg(BATADV_DBG_BATMAN, bat_priv, "OGM2 packet from %pM on %s surpressed: %s\n",
+				   ogm_packet->orig, hard_iface->net_dev->name,
+				   type);
+
+			continue;
+		}
+
 		batadv_v_ogm_process_per_outif(bat_priv, ethhdr, ogm_packet,
 					       orig_node, neigh_node,
 					       if_incoming, hard_iface);
diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index 9284c73..8892cf9 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -228,6 +228,59 @@ bool batadv_is_wifi_netdev(struct net_device *net_device)
 	return false;
 }
 
+/**
+ * batadv_hardif_no_broadcast - check whether (re)broadcast is necessary
+ * @if_outgoing:
+ * @orig_neigh: orig node of the forwarder we just got the packet from
+ *  (NULL if we originated)
+ * @orig_addr: the originator of this packet
+ *
+ * Checks whether a packet needs to be (re)broadcasted on the given interface.
+ *
+ * Return:
+ *	BATADV_HARDIF_BCAST_NORECIPIENT: No neighbor on interface
+ *	BATADV_HARDIF_BCAST_DUPFWD: Just one neighbor, but it is the forwarder
+ *	BATADV_HARDIF_BCAST_DUPORIG: Just one neighbor, but it is the originator
+ *	BATADV_HARDIF_BCAST_OK: Several neighbors, must broadcast
+ */
+int batadv_hardif_no_broadcast(struct batadv_hard_iface *if_outgoing,
+			       struct batadv_orig_node *orig_neigh,
+			       u8 *orig_addr)
+{
+	struct batadv_hardif_neigh_node *hardif_neigh;
+	struct hlist_node *first;
+	int ret = BATADV_HARDIF_BCAST_OK;
+
+	rcu_read_lock();
+
+	/* 0 neighbors -> no (re)broadcast */
+	first = rcu_dereference(hlist_first_rcu(&if_outgoing->neigh_list));
+	if (!first) {
+		ret = BATADV_HARDIF_BCAST_NORECIPIENT;
+		goto out;
+	}
+
+	/* >1 neighbors -> (re)brodcast */
+	if (rcu_dereference(hlist_next_rcu(first)))
+		goto out;
+
+	hardif_neigh = hlist_entry(first, struct batadv_hardif_neigh_node,
+				   list);
+
+	/* 1 neighbor, is the one we received from -> no rebroadcast */
+	if (orig_neigh && hardif_neigh->orig_node == orig_neigh)
+		ret = BATADV_HARDIF_BCAST_DUPFWD;
+
+	/* 1 neighbor, is the originator -> no rebroadcast */
+	if (orig_neigh && orig_addr &&
+	    batadv_compare_eth(hardif_neigh->orig_node->orig, orig_addr))
+		ret = BATADV_HARDIF_BCAST_DUPORIG;
+
+out:
+	rcu_read_unlock();
+	return ret;
+}
+
 static struct batadv_hard_iface *
 batadv_hardif_get_active(const struct net_device *soft_iface)
 {
diff --git a/net/batman-adv/hard-interface.h b/net/batman-adv/hard-interface.h
index a76724d..1831bc9 100644
--- a/net/batman-adv/hard-interface.h
+++ b/net/batman-adv/hard-interface.h
@@ -40,6 +40,20 @@ enum batadv_hard_if_state {
 };
 
 /**
+ * enum batadv_hard_if_bcast - broadcast avoidance options
+ * @BATADV_HARDIF_BCAST_OK: Do broadcast on according hard interface
+ * @BATADV_HARDIF_BCAST_NORECIPIENT: Broadcast not needed, there is no recipient
+ * @BATADV_HARDIF_BCAST_DUPFWD: There is just the neighbor we got it from
+ * @BATADV_HARDIF_BCAST_DUPORIG: There is just the originator
+ */
+enum batadv_hard_if_bcast {
+	BATADV_HARDIF_BCAST_OK = 0,
+	BATADV_HARDIF_BCAST_NORECIPIENT,
+	BATADV_HARDIF_BCAST_DUPFWD,
+	BATADV_HARDIF_BCAST_DUPORIG,
+};
+
+/**
  * enum batadv_hard_if_cleanup - Cleanup modi for soft_iface after slave removal
  * @BATADV_IF_CLEANUP_KEEP: Don't automatically delete soft-interface
  * @BATADV_IF_CLEANUP_AUTO: Delete soft-interface after last slave was removed
@@ -63,6 +77,9 @@ void batadv_hardif_remove_interfaces(void);
 int batadv_hardif_min_mtu(struct net_device *soft_iface);
 void batadv_update_min_mtu(struct net_device *soft_iface);
 void batadv_hardif_release(struct kref *ref);
+int batadv_hardif_no_broadcast(struct batadv_hard_iface *if_outgoing,
+			       struct batadv_orig_node *orig_neigh,
+			       u8 *orig_addr);
 
 /**
  * batadv_hardif_put - decrement the hard interface refcounter and possibly
diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
index 0b7d57a..df70455 100644
--- a/net/batman-adv/originator.c
+++ b/net/batman-adv/originator.c
@@ -236,6 +236,7 @@ static void batadv_hardif_neigh_release(struct kref *ref)
 	spin_unlock_bh(&hardif_neigh->if_incoming->neigh_list_lock);
 
 	batadv_hardif_put(hardif_neigh->if_incoming);
+	batadv_orig_node_put(hardif_neigh->orig_node);
 	kfree_rcu(hardif_neigh, rcu);
 }
 
@@ -517,7 +518,8 @@ batadv_neigh_node_get(const struct batadv_orig_node *orig_node,
  */
 static struct batadv_hardif_neigh_node *
 batadv_hardif_neigh_create(struct batadv_hard_iface *hard_iface,
-			   const u8 *neigh_addr)
+			   const u8 *neigh_addr,
+			   struct batadv_orig_node *orig_node)
 {
 	struct batadv_priv *bat_priv = netdev_priv(hard_iface->soft_iface);
 	struct batadv_hardif_neigh_node *hardif_neigh = NULL;
@@ -534,10 +536,12 @@ batadv_hardif_neigh_create(struct batadv_hard_iface *hard_iface,
 		goto out;
 
 	kref_get(&hard_iface->refcount);
+	kref_get(&orig_node->refcount);
 	INIT_HLIST_NODE(&hardif_neigh->list);
 	ether_addr_copy(hardif_neigh->addr, neigh_addr);
 	hardif_neigh->if_incoming = hard_iface;
 	hardif_neigh->last_seen = jiffies;
+	hardif_neigh->orig_node = orig_node;
 
 	kref_init(&hardif_neigh->refcount);
 
@@ -561,7 +565,8 @@ out:
  */
 static struct batadv_hardif_neigh_node *
 batadv_hardif_neigh_get_or_create(struct batadv_hard_iface *hard_iface,
-				  const u8 *neigh_addr)
+				  const u8 *neigh_addr,
+				  struct batadv_orig_node *orig_node)
 {
 	struct batadv_hardif_neigh_node *hardif_neigh = NULL;
 
@@ -570,7 +575,7 @@ batadv_hardif_neigh_get_or_create(struct batadv_hard_iface *hard_iface,
 	if (hardif_neigh)
 		return hardif_neigh;
 
-	return batadv_hardif_neigh_create(hard_iface, neigh_addr);
+	return batadv_hardif_neigh_create(hard_iface, neigh_addr, orig_node);
 }
 
 /**
@@ -630,7 +635,7 @@ batadv_neigh_node_create(struct batadv_orig_node *orig_node,
 		goto out;
 
 	hardif_neigh = batadv_hardif_neigh_get_or_create(hard_iface,
-							 neigh_addr);
+							 neigh_addr, orig_node);
 	if (!hardif_neigh)
 		goto out;
 
diff --git a/net/batman-adv/routing.c b/net/batman-adv/routing.c
index 610f2c4..c1e5aa7 100644
--- a/net/batman-adv/routing.c
+++ b/net/batman-adv/routing.c
@@ -1142,6 +1142,7 @@ int batadv_recv_bcast_packet(struct sk_buff *skb,
 		goto out;
 
 	batadv_skb_set_priority(skb, sizeof(struct batadv_bcast_packet));
+	skb_set_inner_mac_header(skb, sizeof(struct batadv_bcast_packet));
 
 	/* rebroadcast packet */
 	batadv_add_bcast_packet_to_list(bat_priv, skb, 1);
diff --git a/net/batman-adv/send.c b/net/batman-adv/send.c
index 97bdb0c..ac826d0 100644
--- a/net/batman-adv/send.c
+++ b/net/batman-adv/send.c
@@ -603,11 +603,16 @@ err:
 static void batadv_send_outstanding_bcast_packet(struct work_struct *work)
 {
 	struct batadv_hard_iface *hard_iface;
+	struct batadv_hardif_neigh_node *neigh_node;
+	struct batadv_orig_node *orig_neigh;
 	struct delayed_work *delayed_work;
 	struct batadv_forw_packet *forw_packet;
+	struct batadv_bcast_packet *bcast_packet;
 	struct sk_buff *skb1;
 	struct net_device *soft_iface;
 	struct batadv_priv *bat_priv;
+	u8 *neigh_addr;
+	int ret = 0;
 
 	delayed_work = to_delayed_work(work);
 	forw_packet = container_of(delayed_work, struct batadv_forw_packet,
@@ -625,6 +630,8 @@ static void batadv_send_outstanding_bcast_packet(struct work_struct *work)
 	if (batadv_dat_drop_broadcast_packet(bat_priv, forw_packet))
 		goto out;
 
+	bcast_packet = (struct batadv_bcast_packet *)forw_packet->skb->data;
+
 	/* rebroadcast packet */
 	rcu_read_lock();
 	list_for_each_entry_rcu(hard_iface, &batadv_hardif_list, list) {
@@ -634,6 +641,46 @@ static void batadv_send_outstanding_bcast_packet(struct work_struct *work)
 		if (forw_packet->num_packets >= hard_iface->num_bcasts)
 			continue;
 
+		/* hint for own origin -> no neigh_node */
+		if (skb_mac_header(forw_packet->skb) ==
+		    skb_inner_mac_header(forw_packet->skb)) {
+			neigh_node = NULL;
+		} else {
+			neigh_addr = eth_hdr(forw_packet->skb)->h_source;
+			neigh_node = batadv_hardif_neigh_get(hard_iface,
+							     neigh_addr);
+		}
+
+		orig_neigh = neigh_node ? neigh_node->orig_node : NULL;
+
+		ret = batadv_hardif_no_broadcast(hard_iface, orig_neigh,
+						 bcast_packet->orig);
+
+		if (ret) {
+			char *type = "unknown";
+
+			if (ret == BATADV_HARDIF_BCAST_NORECIPIENT)
+				type = "no neighbor";
+
+			if (ret == BATADV_HARDIF_BCAST_DUPFWD)
+				type = "single neighbor is source";
+
+			if (ret == BATADV_HARDIF_BCAST_DUPORIG)
+				type = "single neighbor is originator";
+
+			batadv_dbg(BATADV_DBG_BATMAN, bat_priv, "BCAST packet from orig %pM on %s surpressed: %s\n",
+				   bcast_packet->orig,
+				   hard_iface->net_dev->name, type);
+
+			if (neigh_node)
+				batadv_hardif_neigh_put(neigh_node);
+
+			continue;
+		}
+
+		if (neigh_node)
+			batadv_hardif_neigh_put(neigh_node);
+
 		if (!kref_get_unless_zero(&hard_iface->refcount))
 			continue;
 
diff --git a/net/batman-adv/soft-interface.c b/net/batman-adv/soft-interface.c
index 49e16b6..483b93d 100644
--- a/net/batman-adv/soft-interface.c
+++ b/net/batman-adv/soft-interface.c
@@ -315,6 +315,8 @@ send:
 		if (batadv_dat_snoop_outgoing_arp_request(bat_priv, skb))
 			brd_delay = msecs_to_jiffies(ARP_REQ_DELAY);
 
+		skb_reset_inner_mac_header(skb);
+
 		if (batadv_skb_head_push(skb, sizeof(*bcast_packet)) < 0)
 			goto dropped;
 
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index b5f01a3..79bcce9 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -418,6 +418,7 @@ struct batadv_hardif_neigh_node {
 	struct hlist_node list;
 	u8 addr[ETH_ALEN];
 	struct batadv_hard_iface *if_incoming;
+	struct batadv_orig_node *orig_node;
 	unsigned long last_seen;
 #ifdef CONFIG_BATMAN_ADV_BATMAN_V
 	struct batadv_hardif_neigh_node_bat_v bat_v;
-- 
2.1.4

