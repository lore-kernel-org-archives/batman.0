Return-Path: <linus.luessing@web.de>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@web.de>
Date: Thu,  4 Jul 2013 00:03:22 +0200
Message-Id: <1372889002-6767-5-git-send-email-linus.luessing@web.de>
In-Reply-To: <1372889002-6767-1-git-send-email-linus.luessing@web.de>
References: <1372889002-6767-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCHv7 4/4] batman-adv: Add IPv4
	link-local/IPv6-ll-all-nodes multicast support
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

With this patch a node may additionally perform the dropping or
unicasting behaviour for a link-local IPv4 and link-local-all-nodes
IPv6 multicast packet, too.

The extra counter and BATADV_MCAST_HAS_NO_BRIDGE flag is needed
because with a future bridge snooping support integration a node with a
bridge on top of its soft interface is not able to reliably detect its
multicast listeners for IPv4 link-local and the IPv6
link-local-all-nodes addresses anymore (see RFC4541, section 2.1.2.2
and section 3).

Even though this new flag and the BATADV_MCAST_LISTENER_ANNOUNCEMENT
flag are currently set and unset at the same time, so even though this
new flag does make "no difference" now, it'll ensure a seamless
integration of multicast bridge support without needing to break
compatibility later.

Also note, that even with multicast bridge support it will need only
one node with a bridge to disable optimizations for link-local IPv4
and IPv6-link-local-all-nodes multicast, resulting in flooding all
these packets again. So the 224.0.0.x address range and the ff02::1
address will never be a safe choice for multicast streaming etc. if
you do not control every node.

Signed-off-by: Linus Lüssing <linus.luessing@web.de>
---
 main.h           |    1 +
 multicast.c      |  170 ++++++++++++++++++++++++++++++++++++++++++++----------
 packet.h         |    1 +
 soft-interface.c |    1 +
 types.h          |    1 +
 5 files changed, 143 insertions(+), 31 deletions(-)

diff --git a/main.h b/main.h
index fe612d6..913bfd4 100644
--- a/net/batman-adv/main.h
+++ b/net/batman-adv/main.h
@@ -166,6 +166,7 @@ enum batadv_uev_type {
 #include <linux/slab.h>
 #include <net/sock.h>		/* struct sock */
 #include <net/addrconf.h>	/* ipv6 address stuff */
+#include <linux/ip.h>
 #include <net/rtnetlink.h>
 #include <linux/jiffies.h>
 #include <linux/seq_file.h>
diff --git a/multicast.c b/multicast.c
index dee86ab..27781cc 100644
--- a/net/batman-adv/multicast.c
+++ b/net/batman-adv/multicast.c
@@ -208,31 +208,61 @@ out:
 }
 
 /**
- * batadv_mcast_forw_mode - check on how to forward a multicast packet
- * @skb: The multicast packet to check
+ * batadv_mcast_forw_mode_check_ipv4 - check for optimized forwarding potential
+ * @skb: the IPv4 packet to check
  * @bat_priv: the bat priv with all the soft interface information
  *
- * Return the forwarding mode as enum batadv_forw_mode.
+ * Check whether the given IPv4 packet has the potential to
+ * be forwarded with a mode more optimal than classic flooding.
+ *
+ * If so then return 0. Otherwise -EINVAL is returned or -ENOMEM if we are
+ * out of memory.
+ */
+static int batadv_mcast_forw_mode_check_ipv4(struct sk_buff *skb,
+					     struct batadv_priv *bat_priv)
+{
+	struct iphdr *iphdr;
+
+	/* We might fail due to out-of-memory -> drop it */
+	if (!pskb_may_pull(skb, sizeof(struct ethhdr) + sizeof(*iphdr)))
+		return -ENOMEM;
+
+	iphdr = ip_hdr(skb);
+
+	/* TODO: Implement Multicast Router Discovery, then add
+	 * scope >= link local, too
+	 */
+	if (!ipv4_is_local_multicast(iphdr->daddr))
+		return -EINVAL;
+
+	/* With one bridge involved, we cannot be certain about
+	 * link-local multicast listener announcements anymore
+	 */
+	if (atomic_read(&bat_priv->mcast.num_has_bridge))
+		return -EINVAL;
+
+	return 0;
+}
+
+/**
+ * batadv_mcast_forw_mode_check_ipv6 - check for optimized forwarding potential
+ * @skb: the IPv6 packet to check
+ * @bat_priv: the bat priv with all the soft interface information
+ *
+ * Check whether the given IPv6 packet has the potential to
+ * be forwarded with a mode more optimal than classic flooding.
+ *
+ * If so then return 0. Otherwise -EINVAL is returned or -ENOMEM if we are
+ * out of memory.
  */
-enum batadv_forw_mode
-batadv_mcast_forw_mode(struct sk_buff *skb, struct batadv_priv *bat_priv)
+static int batadv_mcast_forw_mode_check_ipv6(struct sk_buff *skb,
+					     struct batadv_priv *bat_priv)
 {
-	struct ethhdr *ethhdr = (struct ethhdr *)(skb->data);
 	struct ipv6hdr *ip6hdr;
-	int count;
-
-	if (!atomic_read(&bat_priv->multicast_mode))
-		return BATADV_FORW_ALL;
-
-	if (atomic_read(&bat_priv->mcast.num_no_mla))
-		return BATADV_FORW_ALL;
-
-	if (ntohs(ethhdr->h_proto) != ETH_P_IPV6)
-		return BATADV_FORW_ALL;
 
 	/* We might fail due to out-of-memory -> drop it */
-	if (!pskb_may_pull(skb, sizeof(*ethhdr) + sizeof(*ip6hdr)))
-		return BATADV_FORW_NONE;
+	if (!pskb_may_pull(skb, sizeof(struct ethhdr) + sizeof(*ip6hdr)))
+		return -ENOMEM;
 
 	ip6hdr = ipv6_hdr(skb);
 
@@ -241,18 +271,73 @@ batadv_mcast_forw_mode(struct sk_buff *skb, struct batadv_priv *bat_priv)
 	 */
 	if (IPV6_ADDR_MC_SCOPE(&ip6hdr->daddr) !=
 	    IPV6_ADDR_SCOPE_LINKLOCAL)
-		return BATADV_FORW_ALL;
+		return -EINVAL;
 
-	/* We cannot snoop and therefore cannot optimize the
-	 * all-nodes-multicast address
+	/* With one bridge involved, we cannot be certain about
+	 * link-local-all-nodes multicast listener announcements anymore
 	 */
-	if (ipv6_addr_is_ll_all_nodes(&ip6hdr->daddr))
+	if (ipv6_addr_is_ll_all_nodes(&ip6hdr->daddr) &&
+	    atomic_read(&bat_priv->mcast.num_has_bridge))
+		return -EINVAL;
+
+	return 0;
+}
+
+/**
+ * batadv_mcast_forw_mode_check - check for optimized forwarding potential
+ * @skb: the multicast frame to check
+ * @bat_priv: the bat priv with all the soft interface information
+ *
+ * Check whether the given multicast ethernet frame has the potential to
+ * be forwarded with a mode more optimal than classic flooding.
+ *
+ * If so then return 0. Otherwise -EINVAL is returned or -ENOMEM if we are
+ * out of memory.
+ */
+static int batadv_mcast_forw_mode_check(struct sk_buff *skb,
+					struct batadv_priv *bat_priv)
+{
+	struct ethhdr *ethhdr = (struct ethhdr *)(skb->data);
+
+	if (!atomic_read(&bat_priv->multicast_mode))
+		return -EINVAL;
+
+	if (atomic_read(&bat_priv->mcast.num_no_mla))
+		return -EINVAL;
+
+	switch (ntohs(ethhdr->h_proto)) {
+	case ETH_P_IP:
+		return batadv_mcast_forw_mode_check_ipv4(skb, bat_priv);
+	case ETH_P_IPV6:
+		return batadv_mcast_forw_mode_check_ipv6(skb, bat_priv);
+	default:
+		return -EINVAL;
+	}
+}
+
+/**
+ * batadv_mcast_forw_mode - check on how to forward a multicast packet
+ * @skb: The multicast packet to check
+ * @bat_priv: the bat priv with all the soft interface information
+ *
+ * Return the forwarding mode as enum batadv_forw_mode.
+ */
+enum batadv_forw_mode
+batadv_mcast_forw_mode(struct sk_buff *skb, struct batadv_priv *bat_priv)
+{
+	struct ethhdr *ethhdr = (struct ethhdr *)(skb->data);
+	int ret;
+
+	ret = batadv_mcast_forw_mode_check(skb, bat_priv);
+	if (ret == -ENOMEM)
+		return BATADV_FORW_NONE;
+	else if (ret == -EINVAL)
 		return BATADV_FORW_ALL;
 
-	count = batadv_tt_global_hash_count(bat_priv, ethhdr->h_dest,
+	ret = batadv_tt_global_hash_count(bat_priv, ethhdr->h_dest,
 					    BATADV_NO_FLAGS);
 
-	switch (count) {
+	switch (ret) {
 	case 0:
 		return BATADV_FORW_NONE;
 	case 1:
@@ -263,6 +348,28 @@ batadv_mcast_forw_mode(struct sk_buff *skb, struct batadv_priv *bat_priv)
 }
 
 /**
+ * batadv_mcast_tvlv_update_flag_counter - update the counter of a flag
+ * @flag: the flag we want to update counters for
+ * @flag_counter: the counter we might update
+ * @new_flags: the new capability bitset of a node
+ * @old_flags: the current, to be updated bitset of a node
+ *
+ * Update the given flag_counter with the help of the new flag information
+ * of a node to reflect how many nodes have the given flag unset.
+ */
+static void batadv_mcast_tvlv_update_flag_counter(uint8_t flag,
+						  atomic_t *flag_counter,
+						  uint8_t new_flags,
+						  int old_flags)
+{
+	if (!(new_flags & flag) &&
+	    (old_flags & flag || old_flags & BATADV_UNINIT_FLAGS))
+		atomic_inc(flag_counter);
+	else if (new_flags & flag && !(old_flags & flag))
+		atomic_dec(flag_counter);
+}
+
+/**
  * batadv_mcast_tvlv_ogm_handler_v1 - process incoming multicast tvlv container
  * @bat_priv: the bat priv with all the soft interface information
  * @orig: the orig_node of the ogm
@@ -285,13 +392,14 @@ static void batadv_mcast_tvlv_ogm_handler_v1(struct batadv_priv *bat_priv,
 	    (tvlv_value) && (tvlv_value_len == sizeof(mcast_flags)))
 		mcast_flags = *(uint8_t *)tvlv_value;
 
-	if (!(mcast_flags & BATADV_MCAST_LISTENER_ANNOUNCEMENT) &&
-	    (orig->mcast_flags & BATADV_MCAST_LISTENER_ANNOUNCEMENT ||
-	     orig->mcast_flags & BATADV_UNINIT_FLAGS))
-		atomic_inc(&bat_priv->mcast.num_no_mla);
-	else if (mcast_flags & BATADV_MCAST_LISTENER_ANNOUNCEMENT &&
-		   !(orig->mcast_flags & BATADV_MCAST_LISTENER_ANNOUNCEMENT))
-		atomic_dec(&bat_priv->mcast.num_no_mla);
+	batadv_mcast_tvlv_update_flag_counter(
+					BATADV_MCAST_LISTENER_ANNOUNCEMENT,
+					&bat_priv->mcast.num_no_mla,
+					mcast_flags, orig->mcast_flags);
+	batadv_mcast_tvlv_update_flag_counter(
+					BATADV_MCAST_HAS_NO_BRIDGE,
+					&bat_priv->mcast.num_has_bridge,
+					mcast_flags, orig->mcast_flags);
 
 	orig->mcast_flags = mcast_flags;
 }
diff --git a/packet.h b/packet.h
index 1090977..d10dc17 100644
--- a/net/batman-adv/packet.h
+++ b/net/batman-adv/packet.h
@@ -94,6 +94,7 @@ enum batadv_icmp_packettype {
 /* multicast capabilities */
 enum batadv_mcast_flags {
 	BATADV_MCAST_LISTENER_ANNOUNCEMENT = BIT(0),
+	BATADV_MCAST_HAS_NO_BRIDGE = BIT(1),
 };
 
 /* tt data subtypes */
diff --git a/soft-interface.c b/soft-interface.c
index 8fad00e..73c0de1 100644
--- a/net/batman-adv/soft-interface.c
+++ b/net/batman-adv/soft-interface.c
@@ -663,6 +663,7 @@ static int batadv_softif_init_late(struct net_device *dev)
 #ifdef CONFIG_BATMAN_ADV_MCAST
 	atomic_set(&bat_priv->multicast_mode, 1);
 	atomic_set(&bat_priv->mcast.num_no_mla, 0);
+	atomic_set(&bat_priv->mcast.num_has_bridge, 0);
 #endif
 	atomic_set(&bat_priv->gw_mode, BATADV_GW_MODE_OFF);
 	atomic_set(&bat_priv->gw_sel_class, 20);
diff --git a/types.h b/types.h
index 7535c69..4083746 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -508,6 +508,7 @@ struct batadv_priv_dat {
 struct batadv_priv_mcast {
 	struct hlist_head mla_list;
 	atomic_t num_no_mla;
+	atomic_t num_has_bridge;
 };
 #endif
 
-- 
1.7.10.4

