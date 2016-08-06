Return-Path: <linus.luessing@c0d3.blue>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Date: Sat,  6 Aug 2016 23:46:13 +0200
Message-Id: <1470519973-22972-2-git-send-email-linus.luessing@c0d3.blue>
In-Reply-To: <1470519973-22972-1-git-send-email-linus.luessing@c0d3.blue>
References: <1470519973-22972-1-git-send-email-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH v4 2/2] batman-adv: Simple (re)broadcast
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

Goodies for BATMAN V:

("Upgrade your BATMAN IV network to V now to get these for free!")

Thanks to the split of OGMv1 into two packet types, OGMv2 and ELP
that is, we can now apply the same opitimizations stated above to OGMv2
packets, too.

Furthermore, with BATMAN V, rebroadcasts can be reduced in certain
multi interface cases, too, where BATMAN IV cannot. This is thanks to
the removal of the "secondary interface originator" concept in BATMAN V.

Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
---

Changes in v4:
* added @if_outgoing kerneldoc
* removed "NULL if we originated" note for @orig_addr in kerneldoc again
* added two @orig_node kerneldoc instances
* substituted fancy skb_inner_mac_header stuff with boring forw_packet->own :)

Changes in v3:
* Replaced the new hardif_neigh_node's orig_node reference with a simple
  copy of the originator's MAC address
  -> avoids a potential dependancy cycle / memory leak (thanks Sven!)
* style:
  * Swapped order of arguments orig_addr/orig_neigh of new
    batadv_hardif_no_broadcast()
  * Added an else to avoid unnecessary, maybe confusing reassignments
    in batadv_hardif_no_broadcast()

Changes in v2:
* Changed some "if"s to "switch"es (thanks Sven!)
* Moved kref_get() closer to assignment in neigh_node_create() (thanks Sven!)
* Added missing hardif_put() calls (urgh... thanks Sven!)
* Added kerneldoc for new hardif_neigh_node->orig_node in types.h
* Removed "###" in this commit message (seems like patchwork didn't like it)

 net/batman-adv/bat_v_ogm.c      | 56 +++++++++++++++++++++++++++++++++++++++++
 net/batman-adv/hard-interface.c | 52 ++++++++++++++++++++++++++++++++++++++
 net/batman-adv/hard-interface.h | 16 ++++++++++++
 net/batman-adv/originator.c     | 13 +++++++---
 net/batman-adv/routing.c        |  2 +-
 net/batman-adv/send.c           | 55 +++++++++++++++++++++++++++++++++++++++-
 net/batman-adv/send.h           |  3 ++-
 net/batman-adv/soft-interface.c |  4 ++-
 net/batman-adv/types.h          |  2 ++
 9 files changed, 195 insertions(+), 8 deletions(-)

diff --git a/net/batman-adv/bat_v_ogm.c b/net/batman-adv/bat_v_ogm.c
index 1aeeadc..eaa2e2d 100644
--- a/net/batman-adv/bat_v_ogm.c
+++ b/net/batman-adv/bat_v_ogm.c
@@ -140,6 +140,7 @@ static void batadv_v_ogm_send(struct work_struct *work)
 	unsigned char *ogm_buff, *pkt_buff;
 	int ogm_buff_len;
 	u16 tvlv_len = 0;
+	int ret;
 
 	bat_v = container_of(work, struct batadv_priv_bat_v, ogm_wq.work);
 	bat_priv = container_of(bat_v, struct batadv_priv, bat_v);
@@ -182,6 +183,31 @@ static void batadv_v_ogm_send(struct work_struct *work)
 		if (!kref_get_unless_zero(&hard_iface->refcount))
 			continue;
 
+		ret = batadv_hardif_no_broadcast(hard_iface, NULL, NULL);
+		if (ret) {
+			char *type;
+
+			switch (ret) {
+			case BATADV_HARDIF_BCAST_NORECIPIENT:
+				type = "no neighbor";
+				break;
+			case BATADV_HARDIF_BCAST_DUPFWD:
+				type = "single neighbor is source";
+				break;
+			case BATADV_HARDIF_BCAST_DUPORIG:
+				type = "single neighbor is originator";
+				break;
+			default:
+				type = "unknown";
+			}
+
+			batadv_dbg(BATADV_DBG_BATMAN, bat_priv, "OGM2 from ourselve on %s surpressed: %s\n",
+				   hard_iface->net_dev->name, type);
+
+			batadv_hardif_put(hard_iface);
+			continue;
+		}
+
 		batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
 			   "Sending own OGM2 packet (originator %pM, seqno %u, throughput %u, TTL %d) on interface %s [%pM]\n",
 			   ogm_packet->orig, ntohl(ogm_packet->seqno),
@@ -651,6 +677,7 @@ static void batadv_v_ogm_process(const struct sk_buff *skb, int ogm_offset,
 	struct batadv_hard_iface *hard_iface;
 	struct batadv_ogm2_packet *ogm_packet;
 	u32 ogm_throughput, link_throughput, path_throughput;
+	int ret;
 
 	ethhdr = eth_hdr(skb);
 	ogm_packet = (struct batadv_ogm2_packet *)(skb->data + ogm_offset);
@@ -716,6 +743,35 @@ static void batadv_v_ogm_process(const struct sk_buff *skb, int ogm_offset,
 		if (!kref_get_unless_zero(&hard_iface->refcount))
 			continue;
 
+		ret = batadv_hardif_no_broadcast(hard_iface,
+						 ogm_packet->orig,
+						 hardif_neigh->orig);
+
+		if (ret) {
+			char *type;
+
+			switch (ret) {
+			case BATADV_HARDIF_BCAST_NORECIPIENT:
+				type = "no neighbor";
+				break;
+			case BATADV_HARDIF_BCAST_DUPFWD:
+				type = "single neighbor is source";
+				break;
+			case BATADV_HARDIF_BCAST_DUPORIG:
+				type = "single neighbor is originator";
+				break;
+			default:
+				type = "unknown";
+			}
+
+			batadv_dbg(BATADV_DBG_BATMAN, bat_priv, "OGM2 packet from %pM on %s surpressed: %s\n",
+				   ogm_packet->orig, hard_iface->net_dev->name,
+				   type);
+
+			batadv_hardif_put(hard_iface);
+			continue;
+		}
+
 		batadv_v_ogm_process_per_outif(bat_priv, ethhdr, ogm_packet,
 					       orig_node, neigh_node,
 					       if_incoming, hard_iface);
diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index 08ce361..a7a462e 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -228,6 +228,58 @@ bool batadv_is_wifi_netdev(struct net_device *net_device)
 	return false;
 }
 
+/**
+ * batadv_hardif_no_broadcast - check whether (re)broadcast is necessary
+ * @if_outgoing: the outgoing interface checked and considered for (re)broadcast
+ * @orig_addr: the originator of this packet
+ * @orig_neigh: originator address of the forwarder we just got the packet from
+ *  (NULL if we originated)
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
+			       u8 *orig_addr, u8 *orig_neigh)
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
+	/* 1 neighbor, is the originator -> no rebroadcast */
+	if (orig_addr && batadv_compare_eth(hardif_neigh->orig, orig_addr)) {
+		ret = BATADV_HARDIF_BCAST_DUPORIG;
+	/* 1 neighbor, is the one we received from -> no rebroadcast */
+	} else if (orig_neigh &&
+		   batadv_compare_eth(hardif_neigh->orig, orig_neigh)) {
+		ret = BATADV_HARDIF_BCAST_DUPFWD;
+	}
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
index a76724d..a043182 100644
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
@@ -63,6 +77,8 @@ void batadv_hardif_remove_interfaces(void);
 int batadv_hardif_min_mtu(struct net_device *soft_iface);
 void batadv_update_min_mtu(struct net_device *soft_iface);
 void batadv_hardif_release(struct kref *ref);
+int batadv_hardif_no_broadcast(struct batadv_hard_iface *if_outgoing,
+			       u8 *orig_addr, u8 *orig_neigh);
 
 /**
  * batadv_hardif_put - decrement the hard interface refcounter and possibly
diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
index 5f3bfc4..3f1c286 100644
--- a/net/batman-adv/originator.c
+++ b/net/batman-adv/originator.c
@@ -512,12 +512,14 @@ batadv_neigh_node_get(const struct batadv_orig_node *orig_node,
  * batadv_hardif_neigh_create - create a hardif neighbour node
  * @hard_iface: the interface this neighbour is connected to
  * @neigh_addr: the interface address of the neighbour to retrieve
+ * @orig_node: originator object representing the neighbour
  *
  * Return: the hardif neighbour node if found or created or NULL otherwise.
  */
 static struct batadv_hardif_neigh_node *
 batadv_hardif_neigh_create(struct batadv_hard_iface *hard_iface,
-			   const u8 *neigh_addr)
+			   const u8 *neigh_addr,
+			   struct batadv_orig_node *orig_node)
 {
 	struct batadv_priv *bat_priv = netdev_priv(hard_iface->soft_iface);
 	struct batadv_hardif_neigh_node *hardif_neigh = NULL;
@@ -536,6 +538,7 @@ batadv_hardif_neigh_create(struct batadv_hard_iface *hard_iface,
 	kref_get(&hard_iface->refcount);
 	INIT_HLIST_NODE(&hardif_neigh->list);
 	ether_addr_copy(hardif_neigh->addr, neigh_addr);
+	ether_addr_copy(hardif_neigh->orig, orig_node->orig);
 	hardif_neigh->if_incoming = hard_iface;
 	hardif_neigh->last_seen = jiffies;
 
@@ -556,12 +559,14 @@ out:
  *  node
  * @hard_iface: the interface this neighbour is connected to
  * @neigh_addr: the interface address of the neighbour to retrieve
+ * @orig_node: originator object representing the neighbour
  *
  * Return: the hardif neighbour node if found or created or NULL otherwise.
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
index 610f2c4..344c61b 100644
--- a/net/batman-adv/routing.c
+++ b/net/batman-adv/routing.c
@@ -1144,7 +1144,7 @@ int batadv_recv_bcast_packet(struct sk_buff *skb,
 	batadv_skb_set_priority(skb, sizeof(struct batadv_bcast_packet));
 
 	/* rebroadcast packet */
-	batadv_add_bcast_packet_to_list(bat_priv, skb, 1);
+	batadv_add_bcast_packet_to_list(bat_priv, skb, 1, false);
 
 	/* don't hand the broadcast up if it is from an originator
 	 * from the same backbone.
diff --git a/net/batman-adv/send.c b/net/batman-adv/send.c
index 97bdb0c..63ee0f5 100644
--- a/net/batman-adv/send.c
+++ b/net/batman-adv/send.c
@@ -549,6 +549,7 @@ _batadv_add_bcast_packet_to_list(struct batadv_priv *bat_priv,
  * @bat_priv: the bat priv with all the soft interface information
  * @skb: broadcast packet to add
  * @delay: number of jiffies to wait before sending
+ * @own_packet: true if it is a self-generated broadcast packet
  *
  * add a broadcast packet to the queue and setup timers. broadcast packets
  * are sent multiple times to increase probability for being received.
@@ -560,7 +561,8 @@ _batadv_add_bcast_packet_to_list(struct batadv_priv *bat_priv,
  */
 int batadv_add_bcast_packet_to_list(struct batadv_priv *bat_priv,
 				    const struct sk_buff *skb,
-				    unsigned long delay)
+				    unsigned long delay,
+				    bool own_packet)
 {
 	struct batadv_hard_iface *primary_if = NULL;
 	struct batadv_forw_packet *forw_packet;
@@ -587,6 +589,7 @@ int batadv_add_bcast_packet_to_list(struct batadv_priv *bat_priv,
 	bcast_packet->ttl--;
 
 	forw_packet->skb = newskb;
+	forw_packet->own = own_packet;
 
 	INIT_DELAYED_WORK(&forw_packet->delayed_work,
 			  batadv_send_outstanding_bcast_packet);
@@ -603,11 +606,16 @@ err:
 static void batadv_send_outstanding_bcast_packet(struct work_struct *work)
 {
 	struct batadv_hard_iface *hard_iface;
+	struct batadv_hardif_neigh_node *neigh_node;
 	struct delayed_work *delayed_work;
 	struct batadv_forw_packet *forw_packet;
+	struct batadv_bcast_packet *bcast_packet;
 	struct sk_buff *skb1;
 	struct net_device *soft_iface;
 	struct batadv_priv *bat_priv;
+	u8 *neigh_addr;
+	u8 *orig_neigh;
+	int ret = 0;
 
 	delayed_work = to_delayed_work(work);
 	forw_packet = container_of(delayed_work, struct batadv_forw_packet,
@@ -625,6 +633,8 @@ static void batadv_send_outstanding_bcast_packet(struct work_struct *work)
 	if (batadv_dat_drop_broadcast_packet(bat_priv, forw_packet))
 		goto out;
 
+	bcast_packet = (struct batadv_bcast_packet *)forw_packet->skb->data;
+
 	/* rebroadcast packet */
 	rcu_read_lock();
 	list_for_each_entry_rcu(hard_iface, &batadv_hardif_list, list) {
@@ -634,6 +644,49 @@ static void batadv_send_outstanding_bcast_packet(struct work_struct *work)
 		if (forw_packet->num_packets >= hard_iface->num_bcasts)
 			continue;
 
+		if (forw_packet->own) {
+			neigh_node = NULL;
+		} else {
+			neigh_addr = eth_hdr(forw_packet->skb)->h_source;
+			neigh_node = batadv_hardif_neigh_get(hard_iface,
+							     neigh_addr);
+		}
+
+		orig_neigh = neigh_node ? neigh_node->orig : NULL;
+
+		ret = batadv_hardif_no_broadcast(hard_iface, bcast_packet->orig,
+						 orig_neigh);
+
+		if (ret) {
+			char *type;
+
+			switch (ret) {
+			case BATADV_HARDIF_BCAST_NORECIPIENT:
+				type = "no neighbor";
+				break;
+			case BATADV_HARDIF_BCAST_DUPFWD:
+				type = "single neighbor is source";
+				break;
+			case BATADV_HARDIF_BCAST_DUPORIG:
+				type = "single neighbor is originator";
+				break;
+			default:
+				type = "unknown";
+			}
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
 
diff --git a/net/batman-adv/send.h b/net/batman-adv/send.h
index 999f786..86009b5 100644
--- a/net/batman-adv/send.h
+++ b/net/batman-adv/send.h
@@ -46,7 +46,8 @@ int batadv_send_unicast_skb(struct sk_buff *skb,
 			    struct batadv_neigh_node *neigh_node);
 int batadv_add_bcast_packet_to_list(struct batadv_priv *bat_priv,
 				    const struct sk_buff *skb,
-				    unsigned long delay);
+				    unsigned long delay,
+				    bool own_packet);
 void
 batadv_purge_outstanding_packets(struct batadv_priv *bat_priv,
 				 const struct batadv_hard_iface *hard_iface);
diff --git a/net/batman-adv/soft-interface.c b/net/batman-adv/soft-interface.c
index 49e16b6..2512584 100644
--- a/net/batman-adv/soft-interface.c
+++ b/net/batman-adv/soft-interface.c
@@ -315,6 +315,8 @@ send:
 		if (batadv_dat_snoop_outgoing_arp_request(bat_priv, skb))
 			brd_delay = msecs_to_jiffies(ARP_REQ_DELAY);
 
+		skb_reset_inner_mac_header(skb);
+
 		if (batadv_skb_head_push(skb, sizeof(*bcast_packet)) < 0)
 			goto dropped;
 
@@ -336,7 +338,7 @@ send:
 		seqno = atomic_inc_return(&bat_priv->bcast_seqno);
 		bcast_packet->seqno = htonl(seqno);
 
-		batadv_add_bcast_packet_to_list(bat_priv, skb, brd_delay);
+		batadv_add_bcast_packet_to_list(bat_priv, skb, brd_delay, true);
 
 		/* a copy is stored in the bcast list, therefore removing
 		 * the original skb.
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index b3dd1a3..7fc36e9 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -408,6 +408,7 @@ struct batadv_hardif_neigh_node_bat_v {
  * struct batadv_hardif_neigh_node - unique neighbor per hard-interface
  * @list: list node for batadv_hard_iface::neigh_list
  * @addr: the MAC address of the neighboring interface
+ * @orig: the address of the originator this neighbor node belongs to
  * @if_incoming: pointer to incoming hard-interface
  * @last_seen: when last packet via this neighbor was received
  * @bat_v: B.A.T.M.A.N. V private data
@@ -417,6 +418,7 @@ struct batadv_hardif_neigh_node_bat_v {
 struct batadv_hardif_neigh_node {
 	struct hlist_node list;
 	u8 addr[ETH_ALEN];
+	u8 orig[ETH_ALEN];
 	struct batadv_hard_iface *if_incoming;
 	unsigned long last_seen;
 #ifdef CONFIG_BATMAN_ADV_BATMAN_V
-- 
2.1.4

