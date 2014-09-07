Return-Path: <linus.luessing@web.de>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@web.de>
Date: Sun,  7 Sep 2014 07:42:40 +0200
Message-Id: <1410068560-7829-5-git-send-email-linus.luessing@web.de>
In-Reply-To: <1410068560-7829-1-git-send-email-linus.luessing@web.de>
References: <1410068560-7829-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCHv9 4/4] batman-adv: Forward IGMP/MLD reports
	to selected querier (only)
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

With this patch IGMP or MLD reports are only forwarded to the selected
IGMP/MLD querier as RFC4541 suggests.

This is necessary to avoid multicast packet loss in bridged scenarios:
An IGMPv2/MLDv1 querier does not actively join the multicast group the
reports are sent to. Because of this, this leads to snooping
bridges/switches not being able to learn of multicast listeners in the
mesh and wrongly shutting down ports for multicast traffic to the mesh.

Signed-off-by: Linus Lüssing <linus.luessing@web.de>
---
 compat.h         |    7 +
 multicast.c      |  375 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
 multicast.h      |    8 ++
 soft-interface.c |   11 ++
 types.h          |    4 +
 5 files changed, 399 insertions(+), 6 deletions(-)

diff --git a/compat.h b/compat.h
index 9f997b3..f3e7032 100644
--- a/compat.h
+++ b/compat.h
@@ -255,6 +255,13 @@ static inline void skb_reset_mac_len(struct sk_buff *skb)
 
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
diff --git a/multicast.c b/multicast.c
index 09b3e6f..24cbf07 100644
--- a/multicast.c
+++ b/multicast.c
@@ -21,6 +21,9 @@
 #include "hard-interface.h"
 #include "translation-table.h"
 
+#include <linux/igmp.h>
+#include <net/mld.h>
+
 /**
  * batadv_mcast_get_bridge - get the bridge on top of the softif if it exists
  * @soft_iface: netdev struct of the mesh interface
@@ -512,10 +515,247 @@ out:
 }
 
 /**
+ * batadv_mcast_is_valid_igmp - check for an IGMP packet
+ * @skb: the IPv4 packet to check
+ *
+ * Checks whether a given IPv4 packet is a valid IGMP packet and if so
+ * sets the skb transport header accordingly.
+ *
+ * The caller needs to ensure the correct setup of the skb network header.
+ * This call might reallocate skb data.
+ */
+static bool batadv_mcast_is_valid_igmp(struct sk_buff *skb)
+{
+	struct iphdr *iphdr;
+	unsigned int len = skb_network_offset(skb) + sizeof(*iphdr);
+
+	if (!pskb_may_pull(skb, len))
+		return false;
+
+	iphdr = ip_hdr(skb);
+
+	if (iphdr->ihl < 5 || iphdr->version != 4)
+		return false;
+
+	if (ntohs(iphdr->tot_len) < ip_hdrlen(skb))
+		return false;
+
+	len += ip_hdrlen(skb) - sizeof(*iphdr);
+	skb_set_transport_header(skb, len);
+
+	if (iphdr->protocol != IPPROTO_IGMP)
+		return false;
+
+	/* TODO: verify checksums */
+
+	if (!pskb_may_pull(skb, len + sizeof(struct igmphdr)))
+		return false;
+
+	/* RFC2236+RFC3376 (IGMPv2+IGMPv3) require the multicast link layer
+	 * all-systems destination addresses (224.0.0.1) for general queries
+	 */
+	if (igmp_hdr(skb)->type == IGMP_HOST_MEMBERSHIP_QUERY &&
+	    !igmp_hdr(skb)->group &&
+	    ip_hdr(skb)->daddr != htonl(INADDR_ALLHOSTS_GROUP))
+		return false;
+
+	return true;
+}
+
+/**
+ * batadv_mcast_is_report_ipv4 - check for IGMP reports (and queries)
+ * @bat_priv: the bat priv with all the soft interface information
+ * @skb: the ethernet frame destined for the mesh
+ * @orig: if IGMP report: to be set to the querier to forward the skb to
+ *
+ * Checks whether the given frame is an IGMP report and if so sets the
+ * orig pointer to the originator of the selected IGMP querier if one exists
+ * and returns true. Otherwise returns false.
+ *
+ * If the packet is a general IGMP query instead then we delete the memorized,
+ * foreign IGMP querier (if one exists): We became the selected querier and
+ * therefore do not need to forward reports into the mesh.
+ *
+ * This call might reallocate skb data.
+ */
+static bool batadv_mcast_is_report_ipv4(struct batadv_priv *bat_priv,
+					struct sk_buff *skb,
+					struct batadv_orig_node **orig)
+{
+	struct batadv_mcast_querier_state *querier;
+	struct batadv_orig_node *orig_node;
+
+	if (!batadv_mcast_is_valid_igmp(skb))
+		return false;
+
+	querier = &bat_priv->mcast.querier_ipv4;
+
+	switch (igmp_hdr(skb)->type) {
+	case IGMP_HOST_MEMBERSHIP_REPORT:
+	case IGMPV2_HOST_MEMBERSHIP_REPORT:
+	case IGMPV3_HOST_MEMBERSHIP_REPORT:
+		rcu_read_lock();
+		orig_node = rcu_dereference(querier->orig);
+		if (orig_node && atomic_inc_not_zero(&orig_node->refcount)) {
+			/* TODO: include multicast routers via MRD (RFC4286) */
+			batadv_dbg(BATADV_DBG_MCAST, bat_priv,
+				   "Redirecting IGMP Report to %pM\n",
+				   orig_node->orig);
+			*orig = orig_node;
+		}
+		rcu_read_unlock();
+
+		return true;
+	case IGMP_HOST_MEMBERSHIP_QUERY:
+		/* RFC4541, section 2.1.1.1.b) says:
+		 * ignore general queries from 0.0.0.0
+		 */
+		if (!ip_hdr(skb)->saddr || igmp_hdr(skb)->group)
+			break;
+
+		spin_lock_bh(&querier->orig_lock);
+		orig_node = rcu_dereference(querier->orig);
+		if (orig_node)
+			rcu_assign_pointer(querier->orig, NULL);
+		spin_unlock_bh(&querier->orig_lock);
+
+		batadv_dbg(BATADV_DBG_MCAST, bat_priv,
+			   "Snooped own IGMP Query\n");
+		break;
+	}
+
+	return false;
+}
+
+/**
+ * batadv_mcast_is_valid_mld - check for an MLD packet
+ * @skb: the IPv6 packet to check
+ *
+ * Checks whether a given IPv6 packet is a valid MLD packet and if so
+ * sets the skb transport header accordingly.
+ *
+ * The caller needs to ensure the correct setup of the skb network header.
+ * This call might reallocate skb data.
+ */
+static bool batadv_mcast_is_valid_mld(struct sk_buff *skb)
+{
+	const struct ipv6hdr *ip6hdr;
+	struct mld_msg *mld;
+	__be16 frag_off;
+	u8 nexthdr;
+	unsigned int len = skb_network_offset(skb) + sizeof(*ip6hdr);
+
+	if (!pskb_may_pull(skb, len))
+		return false;
+
+	ip6hdr = ipv6_hdr(skb);
+
+	if (ip6hdr->version != 6 || ip6hdr->payload_len == 0)
+		return false;
+
+	if (skb->len < len + ntohs(ip6hdr->payload_len))
+		return false;
+
+	nexthdr = ip6hdr->nexthdr;
+	len = ipv6_skip_exthdr(skb, len, &nexthdr, &frag_off);
+
+	if (len < 0)
+		return false;
+
+	skb_set_transport_header(skb, len);
+
+	/* TODO: verify checksums */
+
+	if (nexthdr != IPPROTO_ICMPV6)
+		return false;
+
+	if (!pskb_may_pull(skb, len + sizeof(*mld)))
+		return false;
+
+	mld = (struct mld_msg *)icmp6_hdr(skb);
+
+	if (mld->mld_type == ICMPV6_MGM_QUERY) {
+		/* RFC2710+RFC3810 (MLDv1+MLDv2): link-local source addresses */
+		if (!(ipv6_addr_type(&ip6hdr->saddr) & IPV6_ADDR_LINKLOCAL))
+			return false;
+
+		/* RFC2710+RFC3810 (MLDv1+MLDv2): multicast link layer all-nodes
+		 * destination address (ff02::1) for general queries
+		 */
+		if (ipv6_addr_any(&mld->mld_mca) &&
+		    !ipv6_addr_is_ll_all_nodes(&ip6hdr->daddr))
+			return false;
+	}
+
+	return true;
+}
+
+/**
+ * batadv_mcast_is_report_ipv6 - check for MLD reports (and queries)
+ * @bat_priv: the bat priv with all the soft interface information
+ * @skb: the ethernet frame destined for the mesh
+ * @orig: if MLD report: to be set to the querier to forward the skb to
+ *
+ * Checks whether the given frame is an MLD report and if so sets the
+ * orig pointer to the originator of the selected MLD querier if one exists
+ * and returns true. Otherwise returns false.
+ *
+ * If the packet is a general MLD query instead then we delete the memorized,
+ * foreign MLD querier (if one exists): We became the selected querier and
+ * therefore do not need to forward reports into the mesh.
+ *
+ * This call might reallocate skb data.
+ */
+static bool batadv_mcast_is_report_ipv6(struct batadv_priv *bat_priv,
+					struct sk_buff *skb,
+					struct batadv_orig_node **orig)
+{
+	struct mld_msg *mld;
+	struct batadv_mcast_querier_state *querier;
+	struct batadv_orig_node *orig_node;
+
+	if (!batadv_mcast_is_valid_mld(skb))
+		return false;
+
+	querier = &bat_priv->mcast.querier_ipv6;
+	mld = (struct mld_msg *)icmp6_hdr(skb);
+
+	switch (mld->mld_type) {
+	case ICMPV6_MGM_REPORT:
+	case ICMPV6_MLD2_REPORT:
+		rcu_read_lock();
+		orig_node = rcu_dereference(querier->orig);
+		if (orig_node && atomic_inc_not_zero(&orig_node->refcount)) {
+			/* TODO: include multicast routers via MRD (RFC4286) */
+			batadv_dbg(BATADV_DBG_MCAST, bat_priv,
+				   "Redirecting MLD Report to %pM\n",
+				   orig_node->orig);
+			*orig = orig_node;
+		}
+		rcu_read_unlock();
+
+		return true;
+	case ICMPV6_MGM_QUERY:
+		spin_lock_bh(&querier->orig_lock);
+		orig_node = rcu_dereference(querier->orig);
+		if (orig_node)
+			rcu_assign_pointer(querier->orig, NULL);
+		spin_unlock_bh(&querier->orig_lock);
+
+		batadv_dbg(BATADV_DBG_MCAST, bat_priv,
+			   "Snooped own MLD Query\n");
+		break;
+	}
+
+	return false;
+}
+
+/**
  * batadv_mcast_forw_mode_check_ipv4 - check for optimized forwarding potential
  * @bat_priv: the bat priv with all the soft interface information
  * @skb: the IPv4 packet to check
  * @is_unsnoopable: stores whether the destination is snoopable
+ * @orig: for IGMP reports: to be set to the querier to forward the skb to
  *
  * Checks whether the given IPv4 packet has the potential to be forwarded with a
  * mode more optimal than classic flooding.
@@ -525,7 +765,8 @@ out:
  */
 static int batadv_mcast_forw_mode_check_ipv4(struct batadv_priv *bat_priv,
 					     struct sk_buff *skb,
-					     bool *is_unsnoopable)
+					     bool *is_unsnoopable,
+					     struct batadv_orig_node **orig)
 {
 	struct iphdr *iphdr;
 
@@ -533,6 +774,9 @@ static int batadv_mcast_forw_mode_check_ipv4(struct batadv_priv *bat_priv,
 	if (!pskb_may_pull(skb, sizeof(struct ethhdr) + sizeof(*iphdr)))
 		return -ENOMEM;
 
+	if (batadv_mcast_is_report_ipv4(bat_priv, skb, orig))
+		return 0;
+
 	iphdr = ip_hdr(skb);
 
 	/* TODO: Implement Multicast Router Discovery (RFC4286),
@@ -554,6 +798,7 @@ static int batadv_mcast_forw_mode_check_ipv4(struct batadv_priv *bat_priv,
  * @bat_priv: the bat priv with all the soft interface information
  * @skb: the IPv6 packet to check
  * @is_unsnoopable: stores whether the destination is snoopable
+ * @orig: for MLD reports: to be set to the querier to forward the skb to
  *
  * Checks whether the given IPv6 packet has the potential to be forwarded with a
  * mode more optimal than classic flooding.
@@ -563,7 +808,8 @@ static int batadv_mcast_forw_mode_check_ipv4(struct batadv_priv *bat_priv,
  */
 static int batadv_mcast_forw_mode_check_ipv6(struct batadv_priv *bat_priv,
 					     struct sk_buff *skb,
-					     bool *is_unsnoopable)
+					     bool *is_unsnoopable,
+					     struct batadv_orig_node **orig)
 {
 	struct ipv6hdr *ip6hdr;
 
@@ -571,6 +817,9 @@ static int batadv_mcast_forw_mode_check_ipv6(struct batadv_priv *bat_priv,
 	if (!pskb_may_pull(skb, sizeof(struct ethhdr) + sizeof(*ip6hdr)))
 		return -ENOMEM;
 
+	if (batadv_mcast_is_report_ipv6(bat_priv, skb, orig))
+		return 0;
+
 	ip6hdr = ipv6_hdr(skb);
 
 	/* TODO: Implement Multicast Router Discovery (RFC4286),
@@ -593,6 +842,7 @@ static int batadv_mcast_forw_mode_check_ipv6(struct batadv_priv *bat_priv,
  * @bat_priv: the bat priv with all the soft interface information
  * @skb: the multicast frame to check
  * @is_unsnoopable: stores whether the destination is snoopable
+ * @orig: for IGMP/MLD reports: to be set to the querier to forward the skb to
  *
  * Checks whether the given multicast ethernet frame has the potential to be
  * forwarded with a mode more optimal than classic flooding.
@@ -602,7 +852,8 @@ static int batadv_mcast_forw_mode_check_ipv6(struct batadv_priv *bat_priv,
  */
 static int batadv_mcast_forw_mode_check(struct batadv_priv *bat_priv,
 					struct sk_buff *skb,
-					bool *is_unsnoopable)
+					bool *is_unsnoopable,
+					struct batadv_orig_node **orig)
 {
 	struct ethhdr *ethhdr = eth_hdr(skb);
 
@@ -615,10 +866,10 @@ static int batadv_mcast_forw_mode_check(struct batadv_priv *bat_priv,
 	switch (ntohs(ethhdr->h_proto)) {
 	case ETH_P_IP:
 		return batadv_mcast_forw_mode_check_ipv4(bat_priv, skb,
-							 is_unsnoopable);
+							 is_unsnoopable, orig);
 	case ETH_P_IPV6:
 		return batadv_mcast_forw_mode_check_ipv6(bat_priv, skb,
-							 is_unsnoopable);
+							 is_unsnoopable, orig);
 	default:
 		return -EINVAL;
 	}
@@ -786,12 +1037,16 @@ batadv_mcast_forw_mode(struct batadv_priv *bat_priv, struct sk_buff *skb,
 	bool is_unsnoopable = false;
 	struct ethhdr *ethhdr;
 
-	ret = batadv_mcast_forw_mode_check(bat_priv, skb, &is_unsnoopable);
+	ret = batadv_mcast_forw_mode_check(bat_priv, skb, &is_unsnoopable,
+					   orig);
 	if (ret == -ENOMEM)
 		return BATADV_FORW_NONE;
 	else if (ret < 0)
 		return BATADV_FORW_ALL;
 
+	if (*orig)
+		return BATADV_FORW_SINGLE;
+
 	ethhdr = eth_hdr(skb);
 
 	tt_count = batadv_tt_global_hash_count(bat_priv, ethhdr->h_dest,
@@ -823,6 +1078,101 @@ batadv_mcast_forw_mode(struct batadv_priv *bat_priv, struct sk_buff *skb,
 }
 
 /**
+ * batadv_mcast_snoop_query_ipv4 - snoop for the selected MLD querier
+ * @skb: the unencapsulated ethernet frame coming from the mesh
+ * @orig_node: the originator this frame came from
+ *
+ * Checks whether the given frame is a general IGMP query from the selected
+ * querier and if so memorizes the originator this frame came from.
+ */
+static void batadv_mcast_snoop_query_ipv4(struct sk_buff *skb,
+					  struct batadv_orig_node *orig_node)
+{
+	struct batadv_mcast_querier_state *querier;
+
+	if (!batadv_mcast_is_valid_igmp(skb))
+		return;
+
+	/* we are only interested in general queries (group == 0.0.0.0) */
+	if (igmp_hdr(skb)->type != IGMP_HOST_MEMBERSHIP_QUERY ||
+	    igmp_hdr(skb)->group)
+		return;
+
+	/* RFC4541, section 2.1.1.1.b) says: ignore queries from 0.0.0.0 */
+	if (!ip_hdr(skb)->saddr)
+		return;
+
+	querier = &orig_node->bat_priv->mcast.querier_ipv4;
+
+	spin_lock_bh(&querier->orig_lock);
+	rcu_assign_pointer(querier->orig, orig_node);
+	spin_unlock_bh(&querier->orig_lock);
+
+	batadv_dbg(BATADV_DBG_MCAST, orig_node->bat_priv,
+		   "Snooped IGMP Query from originator %pM\n", orig_node->orig);
+}
+
+/**
+ * batadv_mcast_snoop_query_ipv6 - snoop for the selected MLD querier
+ * @skb: the unencapsulated ethernet frame coming from the mesh
+ * @orig_node: the originator this frame came from
+ *
+ * Checks whether the given frame is a general MLD query from the selected
+ * querier and if so memorizes the originator this frame came from.
+ */
+static void batadv_mcast_snoop_query_ipv6(struct sk_buff *skb,
+					  struct batadv_orig_node *orig_node)
+{
+	struct mld_msg *mld;
+	struct batadv_mcast_querier_state *querier;
+
+	if (!batadv_mcast_is_valid_mld(skb))
+		return;
+
+	mld = (struct mld_msg *)icmp6_hdr(skb);
+
+	/* we are only interested in general queries (mca == ::) */
+	if (mld->mld_type != ICMPV6_MGM_QUERY ||
+	    !ipv6_addr_any(&mld->mld_mca))
+		return;
+
+	querier = &orig_node->bat_priv->mcast.querier_ipv6;
+
+	spin_lock_bh(&querier->orig_lock);
+	rcu_assign_pointer(querier->orig, orig_node);
+	spin_unlock_bh(&querier->orig_lock);
+
+	batadv_dbg(BATADV_DBG_MCAST, orig_node->bat_priv,
+		   "Snooped MLD Query from originator %pM\n", orig_node->orig);
+}
+
+/**
+ * batadv_mcast_snoop_query - snoop the selected IGMP/MLD querier
+ * @skb: the unencapsulated ethernet frame coming from the mesh
+ * @orig_node: the originator this frame came from
+ *
+ * Checks whether the given frame is a general IGMP or MLD query
+ * from the selected querier and if so memorizes the originator
+ * this frame came from.
+ *
+ * This call might reallocate skb data.
+ */
+void batadv_mcast_snoop_query(struct sk_buff *skb,
+			      struct batadv_orig_node *orig_node)
+{
+	struct ethhdr *ethhdr = eth_hdr(skb);
+
+	switch (ntohs(ethhdr->h_proto)) {
+	case ETH_P_IP:
+		batadv_mcast_snoop_query_ipv4(skb, orig_node);
+		break;
+	case ETH_P_IPV6:
+		batadv_mcast_snoop_query_ipv6(skb, orig_node);
+		break;
+	}
+}
+
+/**
  * batadv_mcast_want_unsnoop_update - update unsnoop counter and list
  * @bat_priv: the bat priv with all the soft interface information
  * @orig: the orig_node which multicast state might have changed of
@@ -1101,6 +1451,7 @@ void batadv_mcast_free(struct batadv_priv *bat_priv)
 void batadv_mcast_purge_orig(struct batadv_orig_node *orig)
 {
 	struct batadv_priv *bat_priv = orig->bat_priv;
+	struct batadv_mcast_querier_state *querier;
 
 	if (!(orig->capabilities & BATADV_ORIG_CAPA_HAS_MCAST))
 		atomic_dec(&bat_priv->mcast.num_disabled);
@@ -1108,4 +1459,16 @@ void batadv_mcast_purge_orig(struct batadv_orig_node *orig)
 	batadv_mcast_want_unsnoop_update(bat_priv, orig, BATADV_NO_FLAGS);
 	batadv_mcast_want_ipv4_update(bat_priv, orig, BATADV_NO_FLAGS);
 	batadv_mcast_want_ipv6_update(bat_priv, orig, BATADV_NO_FLAGS);
+
+	querier = &bat_priv->mcast.querier_ipv4;
+	spin_lock_bh(&querier->orig_lock);
+	if (rcu_dereference(querier->orig) == orig)
+		rcu_assign_pointer(querier->orig, NULL);
+	spin_unlock_bh(&querier->orig_lock);
+
+	querier = &bat_priv->mcast.querier_ipv6;
+	spin_lock_bh(&querier->orig_lock);
+	if (rcu_dereference(querier->orig) == orig)
+		rcu_assign_pointer(querier->orig, NULL);
+	spin_unlock_bh(&querier->orig_lock);
 }
diff --git a/multicast.h b/multicast.h
index e7bc9bf..fa8e7be 100644
--- a/multicast.h
+++ b/multicast.h
@@ -40,6 +40,9 @@ enum batadv_forw_mode
 batadv_mcast_forw_mode(struct batadv_priv *bat_priv, struct sk_buff *skb,
 		       struct batadv_orig_node **mcast_single_orig);
 
+void batadv_mcast_snoop_query(struct sk_buff *skb,
+			      struct batadv_orig_node *orig_node);
+
 void batadv_mcast_init(struct batadv_priv *bat_priv);
 
 int batadv_mcast_flags_seq_print_text(struct seq_file *seq, void *offset);
@@ -61,6 +64,11 @@ batadv_mcast_forw_mode(struct batadv_priv *bat_priv, struct sk_buff *skb,
 	return BATADV_FORW_ALL;
 }
 
+static inline void batadv_mcast_snoop_query(struct sk_buff *skb,
+					    struct batadv_orig_node *orig_node)
+{
+}
+
 static inline int batadv_mcast_init(struct batadv_priv *bat_priv)
 {
 	return 0;
diff --git a/soft-interface.c b/soft-interface.c
index d4d892c..0f5fb30 100644
--- a/soft-interface.c
+++ b/soft-interface.c
@@ -183,6 +183,7 @@ static int batadv_interface_tx(struct sk_buff *skb,
 	if (atomic_read(&bat_priv->mesh_state) != BATADV_MESH_ACTIVE)
 		goto dropped;
 
+	skb_set_network_header(skb, ETH_HLEN);
 	soft_iface->trans_start = jiffies;
 	vid = batadv_get_vid(skb, 0);
 	ethhdr = eth_hdr(skb);
@@ -397,7 +398,9 @@ void batadv_interface_rx(struct net_device *soft_iface,
 	/* skb->dev & skb->pkt_type are set here */
 	if (unlikely(!pskb_may_pull(skb, ETH_HLEN)))
 		goto dropped;
+
 	skb->protocol = eth_type_trans(skb, soft_iface);
+	skb_reset_network_header(skb);
 
 	/* should not be necessary anymore as we use skb_pull_rcsum()
 	 * TODO: please verify this and remove this TODO
@@ -435,6 +438,9 @@ void batadv_interface_rx(struct net_device *soft_iface,
 			skb->mark &= ~bat_priv->isolation_mark_mask;
 			skb->mark |= bat_priv->isolation_mark;
 		}
+
+		if (orig_node)
+			batadv_mcast_snoop_query(skb, orig_node);
 	} else if (batadv_is_ap_isolated(bat_priv, ethhdr->h_source,
 					 ethhdr->h_dest, vid)) {
 		goto dropped;
@@ -747,8 +753,13 @@ static int batadv_softif_init_late(struct net_device *dev)
 #ifdef CONFIG_BATMAN_ADV_MCAST
 	bat_priv->mcast.querier_ipv4.exists = false;
 	bat_priv->mcast.querier_ipv4.shadowing = false;
+	rcu_assign_pointer(bat_priv->mcast.querier_ipv4.orig, NULL);
+	spin_lock_init(&bat_priv->mcast.querier_ipv4.orig_lock);
 	bat_priv->mcast.querier_ipv6.exists = false;
 	bat_priv->mcast.querier_ipv6.shadowing = false;
+	rcu_assign_pointer(bat_priv->mcast.querier_ipv6.orig, NULL);
+	spin_lock_init(&bat_priv->mcast.querier_ipv6.orig_lock);
+
 	bat_priv->mcast.flags = BATADV_NO_FLAGS;
 	bat_priv->mcast.bridged = false;
 	atomic_set(&bat_priv->multicast_mode, 1);
diff --git a/types.h b/types.h
index bd56fc1..0a26fe9 100644
--- a/types.h
+++ b/types.h
@@ -627,10 +627,14 @@ struct batadv_priv_dat {
  * @exists: whether a querier exists in the mesh
  * @shadowing: if a querier exists, whether it is potentially shadowing
  *  multicast listeners (i.e. querier is behind our own bridge segment)
+ * @orig: node on which the selected querier resides
+ * @orig_lock: protects updates of the selected querier in 'orig'
  */
 struct batadv_mcast_querier_state {
 	bool exists;
 	bool shadowing;
+	struct batadv_orig_node __rcu *orig; /* rcu protected pointer */
+	spinlock_t orig_lock; /* protects updates of orig */
 };
 
 /**
-- 
1.7.10.4

