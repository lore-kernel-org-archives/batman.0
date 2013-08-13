Return-Path: <linus.luessing@web.de>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@web.de>
Date: Tue, 13 Aug 2013 10:23:59 +0200
Message-Id: <1376382240-30664-5-git-send-email-linus.luessing@web.de>
In-Reply-To: <1376382240-30664-1-git-send-email-linus.luessing@web.de>
References: <1376382240-30664-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCHv8 4/5] batman-adv: Add IPv4
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

The extra counter and BATADV_MCAST_WANT_ALL_UNSNOOPABLES flag is needed
because with a future bridge snooping support integration a node with a
bridge on top of its soft interface is not able to reliably detect its
multicast listeners for IPv4 link-local and the IPv6
link-local-all-nodes addresses anymore (see RFC4541, section 2.1.2.2
and section 3).

Even though this new flag does make "no difference" now, it'll ensure
a seamless integration of multicast bridge support without needing to
break compatibility later.

Also note, that even with multicast bridge support it will need only
one node with a bridge to disable optimizations for link-local IPv4
and IPv6-link-local-all-nodes multicast, resulting in flooding all
these packets again. So the 224.0.0.x address range and the ff02::1
address will never be a safe choice for multicast streaming etc. if
you do not control every node.

Signed-off-by: Linus Lüssing <linus.luessing@web.de>
---
 main.h           |    1 +
 multicast.c      |   49 ++++++++++++++++++++++++++++++++++++++++++++++++-
 packet.h         |    9 +++++++++
 soft-interface.c |    1 +
 types.h          |    2 ++
 5 files changed, 61 insertions(+), 1 deletion(-)

diff --git a/main.h b/main.h
index 7225f63..0640dce 100644
--- a/main.h
+++ b/main.h
@@ -166,6 +166,7 @@ enum batadv_uev_type {
 #include <linux/slab.h>
 #include <net/sock.h>		/* struct sock */
 #include <net/addrconf.h>	/* ipv6 address stuff */
+#include <linux/ip.h>
 #include <net/rtnetlink.h>
 #include <linux/jiffies.h>
 #include <linux/seq_file.h>
diff --git a/multicast.c b/multicast.c
index 29cb929..ae7992a 100644
--- a/multicast.c
+++ b/multicast.c
@@ -266,6 +266,44 @@ out:
 }
 
 /**
+ * batadv_mcast_forw_mode_check_ipv4 - check for optimized forwarding potential
+ * @skb: the IPv4 packet to check
+ * @bat_priv: the bat priv with all the soft interface information
+ *
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
+	/* TODO: Implement Multicast Router Discovery (RFC4286),
+	 * then allow scope > link local, too
+	 */
+	if (!ipv4_is_local_multicast(iphdr->daddr))
+		return -EINVAL;
+
+	/* With one bridge involved, we cannot be certain about
+	 * link-local multicast listener announcements anymore
+	 * (see RFC4541, section 2.1.2.2)
+	 */
+	if (atomic_read(&bat_priv->mcast.num_want_all_unsnoopables))
+		return -EINVAL;
+
+	return 0;
+}
+
+/**
  * batadv_mcast_forw_mode_check_ipv6 - check for optimized forwarding potential
  * @skb: the IPv6 packet to check
  * @bat_priv: the bat priv with all the soft interface information
@@ -298,7 +336,8 @@ static int batadv_mcast_forw_mode_check_ipv6(struct sk_buff *skb,
 	 * link-local-all-nodes multicast listener announcements anymore
 	 * (see RFC4541, section 3, paragraph 3)
 	 */
-	if (ipv6_addr_is_ll_all_nodes(&ip6hdr->daddr))
+	if (ipv6_addr_is_ll_all_nodes(&ip6hdr->daddr) &&
+	    atomic_read(&bat_priv->mcast.num_want_all_unsnoopables))
 		return -EINVAL;
 
 	return 0;
@@ -327,6 +366,8 @@ static int batadv_mcast_forw_mode_check(struct sk_buff *skb,
 		return -EINVAL;
 
 	switch (ntohs(ethhdr->h_proto)) {
+	case ETH_P_IP:
+		return batadv_mcast_forw_mode_check_ipv4(skb, bat_priv);
 	case ETH_P_IPV6:
 		return batadv_mcast_forw_mode_check_ipv6(skb, bat_priv);
 	default:
@@ -418,6 +459,9 @@ static void batadv_mcast_tvlv_ogm_handler_v1(struct batadv_priv *bat_priv,
 	batadv_mcast_counter_update(BATADV_ORIG_CAPA_HAS_MCAST,
 				    &bat_priv->mcast.num_disabled,
 				    ~orig->capabilities, ~old_capabilities);
+	batadv_mcast_counter_update(BATADV_MCAST_WANT_ALL_UNSNOOPABLES,
+				    &bat_priv->mcast.num_want_all_unsnoopables,
+				    mcast_flags, orig->mcast_flags);
 
 	orig->mcast_flags = mcast_flags;
 }
@@ -457,4 +501,7 @@ void batadv_mcast_purge_orig(struct batadv_orig_node *orig)
 	batadv_mcast_counter_update(BATADV_ORIG_CAPA_HAS_MCAST,
 				    &bat_priv->mcast.num_disabled,
 				    ~BATADV_NO_FLAGS, ~orig->capabilities);
+	batadv_mcast_counter_update(BATADV_MCAST_WANT_ALL_UNSNOOPABLES,
+				    &bat_priv->mcast.num_want_all_unsnoopables,
+				    BATADV_NO_FLAGS, orig->mcast_flags);
 }
diff --git a/packet.h b/packet.h
index c8cc1b2..5fc795f 100644
--- a/packet.h
+++ b/packet.h
@@ -91,6 +91,15 @@ enum batadv_icmp_packettype {
 	BATADV_PARAMETER_PROBLEM       = 12,
 };
 
+/**
+ * enum batadv_mcast_flags - flags for multicast capabilities and settings
+ * @BATADV_MCAST_WANT_ALL_UNSNOOPABLES: we want all packets destined for
+ *  224.0.0.0/24 or ff02::1
+ */
+enum batadv_mcast_flags {
+	BATADV_MCAST_WANT_ALL_UNSNOOPABLES = BIT(0),
+};
+
 /* tt data subtypes */
 #define BATADV_TT_DATA_TYPE_MASK 0x0F
 
diff --git a/soft-interface.c b/soft-interface.c
index 2ecf9a5..2967a43 100644
--- a/soft-interface.c
+++ b/soft-interface.c
@@ -677,6 +677,7 @@ static int batadv_softif_init_late(struct net_device *dev)
 	bat_priv->mcast.flags = BATADV_UNINIT_FLAGS;
 	atomic_set(&bat_priv->multicast_mode, 1);
 	atomic_set(&bat_priv->mcast.num_disabled, 0);
+	atomic_set(&bat_priv->mcast.num_want_all_unsnoopables, 0);
 #endif
 	atomic_set(&bat_priv->gw_mode, BATADV_GW_MODE_OFF);
 	atomic_set(&bat_priv->gw_sel_class, 20);
diff --git a/types.h b/types.h
index aa17d09..1ce1793 100644
--- a/types.h
+++ b/types.h
@@ -550,11 +550,13 @@ struct batadv_priv_dat {
  * @mla_list: list of multicast addresses we are currently announcing via TT
  * @flags: the flags we have last sent in our mcast tvlv
  * @num_disabled: number of nodes that have no mcast tvlv
+ * @num_want_all_unsnoopables: number of nodes wanting unsnoopable IP traffic
  */
 struct batadv_priv_mcast {
 	struct hlist_head mla_list;
 	int flags;
 	atomic_t num_disabled;
+	atomic_t num_want_all_unsnoopables;
 };
 #endif
 
-- 
1.7.10.4

