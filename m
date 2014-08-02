Return-Path: <linus.luessing@web.de>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@web.de>
Date: Sat,  2 Aug 2014 21:18:50 +0200
Message-Id: <1407007130-23077-2-git-send-email-linus.luessing@web.de>
In-Reply-To: <1407007130-23077-1-git-send-email-linus.luessing@web.de>
References: <1407007130-23077-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH RFC] batman-adv: unicasting grat. ARP Reply /
	unsol. neigh. Advertisement
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

With this patch, gratouitous ARP Replies and unsolicited neighbor
advertisements are forwarded via unicast to the node the according host
roamed from. If this host did not roam before, then these packet are
simply dropped.

Roaming devices are causing an ugly amount of ICMPv6 unsolicited
neighbour advertisements: Everytime they reconnect they reassign the
same IPv6 address to their interface and flood the whole mesh network
with according unsolicited neighbour advertisements, telling everyone
who they are. Unfortunatly unsolicited neighbor advertisements are using
the all-nodes multicast address, "ff02::1", so their overhead cannot be
reduced with our previously introduced group-aware multicast
optimizations.

Unsolicited neighbor advertisements are being used for two things:

a) Hot-swapping devices / changing link-layer addresses (rare case)
b) Updating the mac table of switches in case of a roaming host,
   so that they are informed about the new port location of the
   roamed host, avoiding packet loss

For b) it is actually not necessary to inform all switches after
roaming: It's enough to inform the switches behind the node the host
roamed to and roamed from. For any other switch, the roamed host will
still appear behind bat0, somewhere in the mesh, still in the same
direction.

Not-yet-Signed-off-by: Linus Lüssing <linus.luessing@web.de>
---
 compat.h            |    7 ++++
 soft-interface.c    |  115 +++++++++++++++++++++++++++++++++++++++++++++++++++
 translation-table.c |   62 ++++++++++++++++++++++++++-
 translation-table.h |    3 ++
 types.h             |    1 +
 5 files changed, 187 insertions(+), 1 deletion(-)

diff --git a/compat.h b/compat.h
index ed5b815..b777a37 100644
--- a/compat.h
+++ b/compat.h
@@ -242,6 +242,13 @@ static inline void skb_reset_mac_len(struct sk_buff *skb)
 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(3, 3, 0)
 
+static inline int batadv_ipv6_skip_exthdr(const struct sk_buff *skb, int start,
+					  u8 *nexthdrp, __be16 *frag_offp)
+{
+	return ipv6_skip_exthdr(skb, start, nexthdrp);
+}
+#define ipv6_skip_exthdr batadv_ipv6_skip_exthdr
+
 #define batadv_interface_add_vid(x, y, z) \
 __batadv_interface_add_vid(struct net_device *dev, __be16 proto,\
                           unsigned short vid);\
diff --git a/soft-interface.c b/soft-interface.c
index 9bf382d..d3353a4 100644
--- a/soft-interface.c
+++ b/soft-interface.c
@@ -155,6 +155,113 @@ static void batadv_interface_set_rx_mode(struct net_device *dev)
 {
 }
 
+static bool
+batadv_is_ipv4_grat_reply(struct batadv_priv *bat_priv,
+			  struct sk_buff *skb)
+{
+	struct arphdr *arphdr;
+	__be32 ip_dst;
+	uint8_t *hw_dst;
+	int hdr_size = 0;
+
+	/* pull the ARP payload */
+	if (unlikely(!pskb_may_pull(skb, hdr_size + ETH_HLEN +
+				    arp_hdr_len(skb->dev))))
+		return false;
+
+	arphdr = (struct arphdr *)(skb->data + hdr_size + ETH_HLEN);
+
+	/* check whether the ARP packet carries a valid IP information */
+	if (arphdr->ar_hrd != htons(ARPHRD_ETHER) ||
+	    arphdr->ar_pro != htons(ETH_P_IP) ||
+	    arphdr->ar_hln != ETH_ALEN ||
+	    arphdr->ar_pln != 4)
+		return false;
+
+	hw_dst = (uint8_t *)arphdr + sizeof(*arphdr) + ETH_ALEN + 4;
+	ip_dst = *((__be32 *)(hw_dst + ETH_ALEN));
+
+	/* gratouitous ARP reply */
+	if (arphdr->ar_op != htons(ARPOP_REPLY) ||
+	    !is_broadcast_ether_addr(hw_dst) ||
+	    !ipv4_is_lbcast(ip_dst))
+		return false;
+
+	return true;
+}
+
+static bool
+batadv_is_ipv6_unsol_neighadv(struct batadv_priv *bat_priv,
+			      struct sk_buff *skb)
+{
+	const struct ipv6hdr *ip6h;
+	struct nd_msg *ndm;
+	__be16 frag_off;
+	u8 nexthdr;
+	unsigned int len = sizeof(struct ethhdr) + sizeof(*ip6h);
+
+	if (!pskb_may_pull(skb, len))
+		return false;
+
+	ip6h = ipv6_hdr(skb);
+
+	if (ip6h->version != 6 || ip6h->payload_len == 0 ||
+	    !ipv6_addr_is_ll_all_nodes(&ip6h->daddr))
+		return false;
+
+	if (skb->len < len + ntohs(ip6h->payload_len))
+		return false;
+
+	nexthdr = ip6h->nexthdr;
+	len = ipv6_skip_exthdr(skb, len, &nexthdr, &frag_off);
+
+	/* TODO: validate checksum */
+
+	if (len < 0 || nexthdr != IPPROTO_ICMPV6)
+		return false;
+
+	if (!pskb_may_pull(skb, len + sizeof(*ndm)))
+		return false;
+
+	ndm = (struct nd_msg *)icmp6_hdr(skb);
+
+	if (ndm->icmph.icmp6_type != NDISC_NEIGHBOUR_ADVERTISEMENT ||
+	    ndm->icmph.icmp6_solicited)
+		return false;
+
+	return true;
+}
+
+static bool
+batadv_is_ip_neigh_bcast(struct batadv_priv *bat_priv,
+			 struct sk_buff *skb,
+			 struct batadv_orig_node **mcast_single_orig,
+			 unsigned short vid)
+{
+	struct ethhdr *ethhdr = eth_hdr(skb);
+	int ret;
+
+	switch (ntohs(ethhdr->h_proto)) {
+	case ETH_P_ARP:
+		ret = batadv_is_ipv4_grat_reply(bat_priv, skb);
+		break;
+	case ETH_P_IPV6:
+		ret = batadv_is_ipv6_unsol_neighadv(bat_priv, skb);
+		break;
+	default:
+		ret = false;
+	}
+
+	if (!ret)
+		goto out;
+
+	ethhdr = eth_hdr(skb);
+	*mcast_single_orig = batadv_tt_get_prev_orig(bat_priv, ethhdr->h_source,
+						     vid);
+out:
+	return ret;
+}
+
 static int batadv_interface_tx(struct sk_buff *skb,
 			       struct net_device *soft_iface)
 {
@@ -267,6 +374,14 @@ send:
 			if (forw_mode == BATADV_FORW_SINGLE)
 				do_bcast = false;
 		}
+
+		if (do_bcast &&
+		    batadv_is_ip_neigh_bcast(bat_priv, skb,
+					     &mcast_single_orig, vid))
+			if (!mcast_single_orig)
+				goto dropped;
+
+			do_bcast = false;
 	}
 
 	batadv_skb_set_priority(skb, 0);
diff --git a/translation-table.c b/translation-table.c
index 5f59e7f..4cbe875 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -175,8 +175,23 @@ batadv_tt_global_hash_find(struct batadv_priv *bat_priv, const uint8_t *addr,
 static void
 batadv_tt_local_entry_free_ref(struct batadv_tt_local_entry *tt_local_entry)
 {
-	if (atomic_dec_and_test(&tt_local_entry->common.refcount))
+	struct batadv_orig_node *best_orig;
+
+	if (atomic_dec_and_test(&tt_local_entry->common.refcount)) {
+		rcu_read_lock();
+		best_orig = rcu_dereference(tt_local_entry->prev_orig);
+		rcu_read_unlock();
+
+		if (best_orig) {
+			spin_lock_bh(&best_orig->tt_lock);
+			rcu_assign_pointer(tt_local_entry->prev_orig, NULL);
+			spin_unlock_bh(&best_orig->tt_lock);
+
+			batadv_orig_node_free_ref(best_orig);
+		}
+
 		kfree_rcu(tt_local_entry, common.rcu);
+	}
 }
 
 /**
@@ -509,6 +524,7 @@ bool batadv_tt_local_add(struct net_device *soft_iface, const uint8_t *addr,
 			 unsigned short vid, int ifindex, uint32_t mark)
 {
 	struct batadv_priv *bat_priv = netdev_priv(soft_iface);
+	struct batadv_orig_node *best_orig;
 	struct batadv_tt_local_entry *tt_local;
 	struct batadv_tt_global_entry *tt_global = NULL;
 	struct batadv_softif_vlan *vlan;
@@ -594,6 +610,8 @@ bool batadv_tt_local_add(struct net_device *soft_iface, const uint8_t *addr,
 	tt_local->last_seen = jiffies;
 	tt_local->common.added_at = tt_local->last_seen;
 
+	rcu_assign_pointer(tt_local->prev_orig, NULL);
+
 	/* the batman interface mac and multicast addresses should never be
 	 * purged
 	 */
@@ -620,6 +638,25 @@ check_roaming:
 	 * process has already been handled
 	 */
 	if (tt_global && !(tt_global->common.flags & BATADV_TT_CLIENT_ROAM)) {
+		/* This isn't optimal: over time the best_orig towards a
+		 * bla-backbone might change; forwarding an unsol. Neighbor
+		 * Advertisement / grat. ARP reply later could result in a
+		 * temporary, quick route flap because of triggering a
+		 * bla-claim switch
+		 */
+		best_orig = batadv_transtable_search(bat_priv, NULL,
+						     tt_global->common.addr,
+						     tt_global->common.vid);
+		if (best_orig) {
+			/* TODO: is this a good lock to synchronize with?
+			 * i.e. check whether we will always get the same
+			 * best_orig->tt_lock for a tt_local->prev_orig assignment
+			 */
+			spin_lock_bh(&best_orig->tt_lock);
+			rcu_assign_pointer(tt_local->prev_orig, best_orig);
+			spin_unlock_bh(&best_orig->tt_lock);
+		}
+
 		/* These node are probably going to update their tt table */
 		head = &tt_global->orig_list;
 		rcu_read_lock();
@@ -3710,3 +3747,26 @@ bool batadv_tt_global_is_isolated(struct batadv_priv *bat_priv,
 
 	return ret;
 }
+
+struct batadv_orig_node *batadv_tt_get_prev_orig(struct batadv_priv *bat_priv,
+						 const uint8_t *addr,
+						 unsigned short vid)
+{
+	struct batadv_tt_local_entry *tt;
+	struct batadv_orig_node *orig;
+
+	tt = batadv_tt_local_hash_find(bat_priv, addr, vid);
+	if (!tt)
+		return NULL;
+
+	rcu_read_lock();
+
+	orig = rcu_dereference(tt->prev_orig);
+	if (!orig || !atomic_inc_not_zero(&orig->refcount))
+		orig = NULL;
+
+	rcu_read_unlock();
+
+	batadv_tt_local_entry_free_ref(tt);
+	return orig;
+}
diff --git a/translation-table.h b/translation-table.h
index ad84d7b..e71ca8e 100644
--- a/translation-table.h
+++ b/translation-table.h
@@ -52,5 +52,8 @@ bool batadv_tt_add_temporary_global_entry(struct batadv_priv *bat_priv,
 					  unsigned short vid);
 bool batadv_tt_global_is_isolated(struct batadv_priv *bat_priv,
 				  const uint8_t *addr, unsigned short vid);
+struct batadv_orig_node *batadv_tt_get_prev_orig(struct batadv_priv *bat_priv,
+						 const uint8_t *addr,
+						 unsigned short vid);
 
 #endif /* _NET_BATMAN_ADV_TRANSLATION_TABLE_H_ */
diff --git a/types.h b/types.h
index 8854c05..0c78994 100644
--- a/types.h
+++ b/types.h
@@ -934,6 +934,7 @@ struct batadv_tt_common_entry {
  */
 struct batadv_tt_local_entry {
 	struct batadv_tt_common_entry common;
+	struct batadv_orig_node __rcu *prev_orig; /* rcu protected pointer */
 	unsigned long last_seen;
 };
 
-- 
1.7.10.4

