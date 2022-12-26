Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Subject: [PATCH 4/5] batman-adv: mcast: implement multicast packet generation
Date: Mon, 26 Dec 2022 17:02:32 +0100
Message-Id: <20221226160233.9521-5-linus.luessing@c0d3.blue>
In-Reply-To: <20221226160233.9521-1-linus.luessing@c0d3.blue>
References: <20221226160233.9521-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>

Implement the preparation of a batman-adv multicast packet and use this
under certain conditions.

For one thing this implements the capability to push a complete
batman-adv multicast packet header, including a tracker TVLV with all
originator destinations that have signaled interest in it, onto a given
ethernet frame with an IP multicast packet inside.

For another checks are implemented to determine if encapsulating a
multicast packet in this new batman-adv multicast packet type and using
it is feasible. Those checks are:

1) Have all nodes signaled that the are capable of handling the new
   batman-adv multicast packet type?
2) Do all active hard interfaces of all nodes, including us, have an MTU
   of at least 1280 bytes?
3) Does a complete multicast packet header with all its destination
   addresses fit onto the given multicast packet / ethernet frame and
   does not exceed 1280 bytes?

If all checks passed then the new batman-adv multicast packet type will
be used for transmission and distribution. Otherwise we fall back to one =
or
more batman-adv unicast packet transmissions, if possible. Or if not
possible we will fall back to classic flooding through a batman-adv
broadcast packet.

Signed-off-by: Linus L=C3=BCssing <linus.luessing@c0d3.blue>
---
 net/batman-adv/multicast.c      |  79 ++++-
 net/batman-adv/multicast.h      |  24 +-
 net/batman-adv/multicast_forw.c | 504 ++++++++++++++++++++++++++++++++
 net/batman-adv/soft-interface.c |   6 +-
 net/batman-adv/types.h          |   6 +
 5 files changed, 611 insertions(+), 8 deletions(-)

diff --git a/net/batman-adv/multicast.c b/net/batman-adv/multicast.c
index d674e8394439..fb548924be04 100644
--- a/net/batman-adv/multicast.c
+++ b/net/batman-adv/multicast.c
@@ -1178,17 +1178,62 @@ static int batadv_mcast_forw_rtr_count(struct bat=
adv_priv *bat_priv,
 	}
 }
=20
+/**
+ * batadv_mcast_forw_mode_by_count() - get forwarding mode by count
+ * @bat_priv: the bat priv with all the soft interface information
+ * @skb: the multicast packet to check
+ * @vid: the vlan identifier
+ * @is_routable: stores whether the destination is routable
+ * @count: the number of originators the multicast packet need to be sen=
t to
+ *
+ * For a multicast packet with multiple destination originators, checks =
which
+ * mode to use. For BATADV_FORW_MCAST it also encapsulates the packet wi=
th a
+ * complete batman-adv multicast header.
+ *
+ * Return:
+ *	BATADV_FORW_MCAST: If all nodes have multicast packet routing
+ *	capabilities and an MTU >=3D 1280 on all hard interfaces (including u=
s)
+ *	and the encapsulated multicast packet with all destination addresses
+ *	would still fit into an 1280 bytes batman-adv multicast packet
+ *	(excluding the outter ethernet frame) and we could successfully push
+ *	the full batman-adv multicast packet header.
+ *	BATADV_FORW_UCASTS: If the packet cannot be sent in a batman-adv
+ *	multicast packet and the amount of batman-adv unicast packets needed
+ *	is smaller or equal to the configured multicast fanout.
+ *	BATADV_FORW_BCAST: Otherwise.
+ */
+enum batadv_forw_mode
+batadv_mcast_forw_mode_by_count(struct batadv_priv *bat_priv,
+				struct sk_buff *skb, unsigned short vid,
+				int is_routable, int count)
+{
+	unsigned int mcast_hdrlen =3D batadv_mcast_forw_packet_hdrlen(count);
+	u8 own_tvlv_flags =3D bat_priv->mcast.mla_flags.tvlv_flags;
+
+	if (!atomic_read(&bat_priv->mcast.num_no_mc_ptype_capa) &&
+	    own_tvlv_flags & BATADV_MCAST_HAVE_MC_PTYPE_CAPA &&
+	    skb->len + mcast_hdrlen <=3D IPV6_MIN_MTU &&
+	    batadv_mcast_forw_push(bat_priv, skb, vid, is_routable))
+		return BATADV_FORW_MCAST;
+
+	if (count <=3D atomic_read(&bat_priv->multicast_fanout))
+		return BATADV_FORW_UCASTS;
+
+	return BATADV_FORW_BCAST;
+}
+
 /**
  * batadv_mcast_forw_mode() - check on how to forward a multicast packet
  * @bat_priv: the bat priv with all the soft interface information
  * @skb: the multicast packet to check
+ * @vid: the vlan identifier
  * @is_routable: stores whether the destination is routable
  *
  * Return: The forwarding mode as enum batadv_forw_mode.
  */
 enum batadv_forw_mode
 batadv_mcast_forw_mode(struct batadv_priv *bat_priv, struct sk_buff *skb=
,
-		       int *is_routable)
+		       unsigned short vid, int *is_routable)
 {
 	int ret, tt_count, ip_count, unsnoop_count, total_count;
 	bool is_unsnoopable =3D false;
@@ -1218,10 +1263,8 @@ batadv_mcast_forw_mode(struct batadv_priv *bat_pri=
v, struct sk_buff *skb,
 	else if (unsnoop_count)
 		return BATADV_FORW_BCAST;
=20
-	if (total_count <=3D atomic_read(&bat_priv->multicast_fanout))
-		return BATADV_FORW_UCASTS;
-
-	return BATADV_FORW_BCAST;
+	return batadv_mcast_forw_mode_by_count(bat_priv, skb, vid, *is_routable=
,
+					       total_count);
 }
=20
 /**
@@ -1781,6 +1824,31 @@ static void batadv_mcast_want_rtr6_update(struct b=
atadv_priv *bat_priv,
 	}
 }
=20
+/**
+ * batadv_mcast_have_mc_ptype_update() - update multicast packet type co=
unter
+ * @bat_priv: the bat priv with all the soft interface information
+ * @orig: the orig_node which multicast state might have changed of
+ * @mcast_flags: flags indicating the new multicast state
+ *
+ * If the BATADV_MCAST_HAVE_MC_PTYPE_CAPA flag of this originator, orig,=
 has
+ * toggled then this method updates the counter accordingly.
+ */
+static void batadv_mcast_have_mc_ptype_update(struct batadv_priv *bat_pr=
iv,
+					      struct batadv_orig_node *orig,
+					      u8 mcast_flags)
+{
+	lockdep_assert_held(&orig->mcast_handler_lock);
+
+	/* switched from flag set to unset */
+	if (!(mcast_flags & BATADV_MCAST_HAVE_MC_PTYPE_CAPA) &&
+	    orig->mcast_flags & BATADV_MCAST_HAVE_MC_PTYPE_CAPA)
+		atomic_inc(&bat_priv->mcast.num_no_mc_ptype_capa);
+	/* switched from flag unset to set */
+	else if (mcast_flags & BATADV_MCAST_HAVE_MC_PTYPE_CAPA &&
+		 !(orig->mcast_flags & BATADV_MCAST_HAVE_MC_PTYPE_CAPA))
+		atomic_dec(&bat_priv->mcast.num_no_mc_ptype_capa);
+}
+
 /**
  * batadv_mcast_tvlv_flags_get() - get multicast flags from an OGM TVLV
  * @enabled: whether the originator has multicast TVLV support enabled
@@ -1849,6 +1917,7 @@ static void batadv_mcast_tvlv_ogm_handler(struct ba=
tadv_priv *bat_priv,
 	batadv_mcast_want_ipv6_update(bat_priv, orig, mcast_flags);
 	batadv_mcast_want_rtr4_update(bat_priv, orig, mcast_flags);
 	batadv_mcast_want_rtr6_update(bat_priv, orig, mcast_flags);
+	batadv_mcast_have_mc_ptype_update(bat_priv, orig, mcast_flags);
=20
 	orig->mcast_flags =3D mcast_flags;
 	spin_unlock_bh(&orig->mcast_handler_lock);
diff --git a/net/batman-adv/multicast.h b/net/batman-adv/multicast.h
index a5c0f384bb9a..6746a919f4a0 100644
--- a/net/batman-adv/multicast.h
+++ b/net/batman-adv/multicast.h
@@ -28,6 +28,12 @@ enum batadv_forw_mode {
 	 */
 	BATADV_FORW_UCASTS,
=20
+	/**
+	 * @BATADV_FORW_MCAST: forward the packet to some nodes via a
+	 *  batman-adv multicast packet
+	 */
+	BATADV_FORW_MCAST,
+
 	/** @BATADV_FORW_NONE: don't forward, drop it */
 	BATADV_FORW_NONE,
 };
@@ -36,7 +42,7 @@ enum batadv_forw_mode {
=20
 enum batadv_forw_mode
 batadv_mcast_forw_mode(struct batadv_priv *bat_priv, struct sk_buff *skb=
,
-		       int *is_routable);
+		       unsigned short vid, int *is_routable);
=20
 int batadv_mcast_forw_send(struct batadv_priv *bat_priv, struct sk_buff =
*skb,
 			   unsigned short vid, int is_routable);
@@ -57,11 +63,18 @@ void batadv_mcast_purge_orig(struct batadv_orig_node =
*orig_node);
 int batadv_mcast_forw_tracker_tvlv_handler(struct batadv_priv *bat_priv,
 					   struct sk_buff *skb);
=20
+int batadv_mcast_forw_packet_hdrlen(unsigned int num_dests);
+
+int batadv_mcast_forw_push(struct batadv_priv *bat_priv, struct sk_buff =
*skb,
+			   unsigned short vid, int is_routable);
+
+int batadv_mcast_forw_mcsend(struct batadv_priv *bat_priv, struct sk_buf=
f *skb);
+
 #else
=20
 static inline enum batadv_forw_mode
 batadv_mcast_forw_mode(struct batadv_priv *bat_priv, struct sk_buff *skb=
,
-		       int *is_routable)
+		       unsigned short vid, int *is_routable)
 {
 	return BATADV_FORW_BCAST;
 }
@@ -99,6 +112,13 @@ static inline void batadv_mcast_purge_orig(struct bat=
adv_orig_node *orig_node)
 {
 }
=20
+static inline int batadv_mcast_forw_mcsend(struct batadv_priv *bat_priv,
+					   struct sk_buff *skb)
+{
+	kfree_skb(skb);
+	return NET_XMIT_DROP;
+}
+
 #endif /* CONFIG_BATMAN_ADV_MCAST */
=20
 #endif /* _NET_BATMAN_ADV_MULTICAST_H_ */
diff --git a/net/batman-adv/multicast_forw.c b/net/batman-adv/multicast_f=
orw.c
index d378e6f2de18..e2b0cd51cec4 100644
--- a/net/batman-adv/multicast_forw.c
+++ b/net/batman-adv/multicast_forw.c
@@ -8,17 +8,293 @@
=20
 #include <linux/etherdevice.h>
 #include <linux/if_ether.h>
+#include <linux/if_vlan.h>
+#include <linux/ipv6.h>
 #include <linux/netdevice.h>
 #include <linux/skbuff.h>
 #include <linux/types.h>
=20
+#include "bridge_loop_avoidance.h"
 #include "originator.h"
 #include "routing.h"
 #include "send.h"
+#include "soft-interface.h"
+#include "translation-table.h"
=20
 #define batadv_mcast_forw_tracker_for_each_dest(dest, num_dests) \
 	for (; num_dests; num_dests--, (dest) +=3D ETH_ALEN)
=20
+/**
+ * batadv_mcast_forw_orig_entry() - get orig_node from an hlist node
+ * @node: the hlist node to get the orig_node from
+ * @entry_offset: the offset of the hlist node within the orig_node stru=
ct
+ *
+ * Return: The orig_node containing the hlist node on success, NULL on e=
rror.
+ */
+static struct batadv_orig_node *
+batadv_mcast_forw_orig_entry(struct hlist_node *node,
+			     size_t entry_offset)
+{
+	/* sanity check */
+	switch (entry_offset) {
+	case offsetof(struct batadv_orig_node, mcast_want_all_ipv4_node):
+	case offsetof(struct batadv_orig_node, mcast_want_all_ipv6_node):
+	case offsetof(struct batadv_orig_node, mcast_want_all_rtr4_node):
+	case offsetof(struct batadv_orig_node, mcast_want_all_rtr6_node):
+		break;
+	default:
+		WARN_ON(1);
+		return NULL;
+	}
+
+	return (struct batadv_orig_node *)((void *)node - entry_offset);
+}
+
+/**
+ * batadv_mcast_forw_push_dest() - push an originator MAC address onto a=
n skb
+ * @skb: the skb to push the destination address onto
+ * @vid: the vlan identifier
+ * @orig_node: the originator node to get the MAC address from
+ * @num_dests: a pointer to store the number of pushed addresses in
+ *
+ * If the orig_node is a BLA backbone gateway, if there is not enough sk=
b
+ * headroom available or if num_dests is already at its maximum (65535) =
then
+ * neither the skb nor num_dests is changed. Otherwise the originator's =
MAC
+ * address is pushed onto the given skb and num_dests incremented by one=
.
+ *
+ * Return: true if the orig_node is a backbone gateway or if an orig add=
ress
+ *  was pushed successfully.
+ */
+static bool batadv_mcast_forw_push_dest(struct batadv_priv *bat_priv,
+					struct sk_buff *skb, unsigned short vid,
+					struct batadv_orig_node *orig_node,
+					unsigned short *num_dests)
+{
+	BUILD_BUG_ON(sizeof(((struct batadv_tvlv_mcast_tracker *)0)->num_dests)
+		     !=3D sizeof(__be16));
+
+	/* Avoid sending to other BLA gateways - they already got the frame fro=
m
+	 * the LAN side we share with them.
+	 * TODO: Refactor to take BLA into account earlier in mode check.
+	 */
+	if (batadv_bla_is_backbone_gw_orig(bat_priv, orig_node->orig, vid))
+		return true;
+
+	if (skb_headroom(skb) < ETH_ALEN || *num_dests =3D=3D U16_MAX)
+		return false;
+
+	skb_push(skb, ETH_ALEN);
+	ether_addr_copy(skb->data, orig_node->orig);
+	(*num_dests)++;
+
+	return true;
+}
+
+/**
+ * batadv_mcast_forw_push_dests_list() - push originators from list onto=
 an skb
+ * @bat_priv: the bat priv with all the soft interface information
+ * @skb: the skb to push the destination addresses onto
+ * @vid: the vlan identifier
+ * @head: the list to gather originators from
+ * @entry_offset: offset of an hlist node in an orig_node structure
+ * @num_dests: a pointer to store the number of pushed addresses in
+ *
+ * Push the MAC addresses of all originators in the given list onto the =
given
+ * skb.
+ *
+ * Return: true on success, false otherwise.
+ */
+static int batadv_mcast_forw_push_dests_list(struct batadv_priv *bat_pri=
v,
+					     struct sk_buff *skb,
+					     unsigned short vid,
+					     struct hlist_head *head,
+					     size_t entry_offset,
+					     unsigned short *num_dests)
+{
+	struct hlist_node *node;
+	struct batadv_orig_node *orig_node;
+
+	rcu_read_lock();
+	__hlist_for_each_rcu(node, head) {
+		orig_node =3D batadv_mcast_forw_orig_entry(node, entry_offset);
+		if (!orig_node ||
+		    !batadv_mcast_forw_push_dest(bat_priv, skb, vid, orig_node,
+						 num_dests))
+			return false;
+	}
+	rcu_read_unlock();
+
+	return true;
+}
+
+/**
+ * batadv_mcast_forw_push_tt() - push originators with interest through =
TT
+ * @bat_priv: the bat priv with all the soft interface information
+ * @skb: the skb to push the destination addresses onto
+ * @vid: the vlan identifier
+ * @num_dests: a pointer to store the number of pushed addresses in
+ *
+ * Push the MAC addresses of all originators which have indicated intere=
st in
+ * this multicast packet through the translation table onto the given sk=
b.
+ *
+ * Return: true on success, false otherwise.
+ */
+static bool
+batadv_mcast_forw_push_tt(struct batadv_priv *bat_priv, struct sk_buff *=
skb,
+			  unsigned short vid, unsigned short *num_dests)
+{
+	struct batadv_tt_orig_list_entry *orig_entry;
+
+	struct batadv_tt_global_entry *tt_global;
+	const u8 *addr =3D eth_hdr(skb)->h_dest;
+
+	/* ok */
+	int ret =3D true;
+
+	tt_global =3D batadv_tt_global_hash_find(bat_priv, addr, vid);
+	if (!tt_global)
+		goto out;
+
+	rcu_read_lock();
+	hlist_for_each_entry_rcu(orig_entry, &tt_global->orig_list, list) {
+		if (!batadv_mcast_forw_push_dest(bat_priv, skb, vid,
+						 orig_entry->orig_node,
+						 num_dests)) {
+			ret =3D false;
+			break;
+		}
+	}
+	rcu_read_unlock();
+
+	batadv_tt_global_entry_put(tt_global);
+
+out:
+	return ret;
+}
+
+/**
+ * batadv_mcast_forw_push_want_all() - push originators with want-all fl=
ag
+ * @bat_priv: the bat priv with all the soft interface information
+ * @skb: the skb to push the destination addresses onto
+ * @vid: the vlan identifier
+ * @num_dests: a pointer to store the number of pushed addresses in
+ *
+ * Push the MAC addresses of all originators which have indicated intere=
st in
+ * this multicast packet through the want-all flag onto the given skb.
+ *
+ * Return: true on success, false otherwise.
+ */
+static bool batadv_mcast_forw_push_want_all(struct batadv_priv *bat_priv=
,
+					    struct sk_buff *skb,
+					    unsigned short vid,
+					    unsigned short *num_dests)
+{
+	struct hlist_head *head =3D NULL;
+	size_t offset;
+	int ret;
+
+	switch (eth_hdr(skb)->h_proto) {
+	case htons(ETH_P_IP):
+		head =3D &bat_priv->mcast.want_all_ipv4_list;
+		offset =3D offsetof(struct batadv_orig_node,
+				  mcast_want_all_ipv4_node);
+		break;
+	case htons(ETH_P_IPV6):
+		head =3D &bat_priv->mcast.want_all_ipv6_list;
+		offset =3D offsetof(struct batadv_orig_node,
+				  mcast_want_all_ipv6_node);
+		break;
+	default:
+		return false;
+	}
+
+	ret =3D batadv_mcast_forw_push_dests_list(bat_priv, skb, vid, head,
+						offset, num_dests);
+	if (!ret)
+		return false;
+
+	return true;
+}
+
+/**
+ * batadv_mcast_forw_push_want_rtr() - push originators with want-router=
 flag
+ * @bat_priv: the bat priv with all the soft interface information
+ * @skb: the skb to push the destination addresses onto
+ * @vid: the vlan identifier
+ * @num_dests: a pointer to store the number of pushed addresses in
+ *
+ * Push the MAC addresses of all originators which have indicated intere=
st in
+ * this multicast packet through the want-all-rtr flag onto the given sk=
b.
+ *
+ * Return: true on success, false otherwise.
+ */
+static bool batadv_mcast_forw_push_want_rtr(struct batadv_priv *bat_priv=
,
+					    struct sk_buff *skb,
+					    unsigned short vid,
+					    unsigned short *num_dests)
+{
+	struct hlist_head *head =3D NULL;
+	size_t offset;
+	int ret;
+
+	switch (eth_hdr(skb)->h_proto) {
+	case htons(ETH_P_IP):
+		head =3D &bat_priv->mcast.want_all_rtr4_list;
+		offset =3D offsetof(struct batadv_orig_node,
+				  mcast_want_all_rtr4_node);
+		break;
+	case htons(ETH_P_IPV6):
+		head =3D &bat_priv->mcast.want_all_rtr6_list;
+		offset =3D offsetof(struct batadv_orig_node,
+				  mcast_want_all_rtr6_node);
+		break;
+	default:
+		return false;
+	}
+
+	ret =3D batadv_mcast_forw_push_dests_list(bat_priv, skb, vid, head,
+						offset, num_dests);
+	if (!ret)
+		return false;
+
+	return true;
+}
+
+/**
+ * batadv_mcast_forw_push_dests() - push originator addresses onto an sk=
b
+ * @bat_priv: the bat priv with all the soft interface information
+ * @skb: the skb to push the destination addresses onto
+ * @vid: the vlan identifier
+ * @is_routable: indicates whether the destination is routable
+ *
+ * Push the MAC addresses of all originators which have indicated intere=
st in
+ * this multicast packet onto the given skb.
+ *
+ * Return: The number of destination originator MAC addresses that were =
pushed
+ * onto the given skb.
+ */
+static int
+batadv_mcast_forw_push_dests(struct batadv_priv *bat_priv, struct sk_buf=
f *skb,
+			     unsigned short vid, int is_routable)
+{
+	unsigned short num_dests =3D 0;
+
+	if (!batadv_mcast_forw_push_tt(bat_priv, skb, vid, &num_dests))
+		goto err;
+
+	if (!batadv_mcast_forw_push_want_all(bat_priv, skb, vid, &num_dests))
+		goto err;
+
+	if (is_routable &&
+	    !batadv_mcast_forw_push_want_rtr(bat_priv, skb, vid, &num_dests))
+		goto err;
+
+	return num_dests;
+err:
+	skb_pull(skb, num_dests * ETH_ALEN);
+	return -ENOMEM;
+}
+
 /**
  * batadv_mcast_forw_tracker_hdrlen() - calculate tracker TVLV header le=
ngth
  * @num_dests: the number of destination addresses to taken into account
@@ -39,6 +315,120 @@ static int batadv_mcast_forw_tracker_hdrlen(unsigned=
 int num_dests)
 		return len - sizeof(mcast_tracker->align);
 }
=20
+/**
+ * batadv_mcast_forw_push_tracker() - push a multicast tracker TVLV head=
er
+ * @skb: the skb to push the tracker TVLV onto
+ * @num_dests: the number of destination addresses to set in the header
+ *
+ * Pushes a multicast tracker TVLV header onto the given skb, including =
the
+ * generic TVLV header but excluding the destination MAC addresses.
+ *
+ * The provided num_dests value is taken into consideration to set the
+ * num_dests field in the tracker header and to set the appropriate TVLV=
 length
+ * value fields. But also to decide whether to add or omit the 2 alignme=
nt bytes
+ * in the multicast tracker TVLV header, to make the tracker TVLV 4 byte=
 aligned
+ * to make the encapsulated IP packet 4 byte aligned.
+ *
+ * Return: -ENOMEM if there is not enough skb headroom available. Otherw=
ise, on
+ * success the number of bytes that were pushed, the total TVLV length v=
alue.
+ */
+static int batadv_mcast_forw_push_tracker(struct sk_buff *skb, int num_d=
ests)
+{
+	struct batadv_tvlv_mcast_tracker *mcast_tracker;
+	unsigned int tvlv_value_len, tracker_hdrlen;
+	struct batadv_tvlv_hdr *tvlv_hdr;
+
+	/* odd #dests: no 2 byte padding to TVLV */
+	tracker_hdrlen =3D batadv_mcast_forw_tracker_hdrlen(num_dests);
+
+	if (skb_headroom(skb) < tracker_hdrlen + sizeof(*tvlv_hdr))
+		return -ENOMEM;
+
+	tvlv_value_len =3D tracker_hdrlen + ETH_ALEN * num_dests;
+	if (tvlv_value_len + sizeof(*tvlv_hdr) > U16_MAX)
+		return -ENOMEM;
+
+	skb_push(skb, tracker_hdrlen);
+	mcast_tracker =3D (struct batadv_tvlv_mcast_tracker *)skb->data;
+	mcast_tracker->num_dests =3D htons(num_dests);
+
+	/* even #dests: with 2 byte padding to TVLV */
+	if (!(num_dests % 2))
+		memset(mcast_tracker->align, 0, sizeof(mcast_tracker->align));
+
+	skb_reset_network_header(skb);
+
+	skb_push(skb, sizeof(*tvlv_hdr));
+	tvlv_hdr =3D (struct batadv_tvlv_hdr *)skb->data;
+	tvlv_hdr->type =3D BATADV_TVLV_MCAST_TRACKER;
+	tvlv_hdr->version =3D 1;
+	tvlv_hdr->len =3D htons(tvlv_value_len);
+
+	return tvlv_value_len + sizeof(*tvlv_hdr);
+}
+
+/**
+ * batadv_mcast_forw_push_tvlvs() - push a multicast tracker TVLV onto a=
n skb
+ * @skb: the skb to push the tracker TVLV onto
+ * @vid: the vlan identifier
+ * @is_routable: indicates whether the destination is routable
+ *
+ * Pushes a multicast tracker TVLV onto the given skb, including the col=
lected
+ * destination MAC addresses and the generic TVLV header.
+ *
+ * Return: -ENOMEM if there is not enough skb headroom available. Otherw=
ise, on
+ * success the number of bytes that were pushed, the total TVLV length v=
alue.
+ */
+static int
+batadv_mcast_forw_push_tvlvs(struct batadv_priv *bat_priv, struct sk_buf=
f *skb,
+			     unsigned short vid, int is_routable)
+{
+	int num_dests, tvlv_len;
+
+	num_dests =3D batadv_mcast_forw_push_dests(bat_priv, skb, vid,
+						 is_routable);
+	if (num_dests <	0)
+		return num_dests;
+
+	tvlv_len =3D batadv_mcast_forw_push_tracker(skb, num_dests);
+	if (tvlv_len < 0)
+		skb_pull(skb, num_dests * ETH_ALEN);
+
+	return tvlv_len;
+}
+
+/**
+ * batadv_mcast_forw_push_hdr() - push a multicast packet header onto an=
 skb
+ * @skb: the skb to push the header onto
+ * @tvlv_len: the total TVLV length value to set in the header
+ *
+ * Pushes a batman-adv multicast packet header onto the given skb and se=
ts
+ * the provided total TVLV length value in it.
+ *
+ * Caller needs to ensure enough skb headroom is available.
+ *
+ * Return: -ENOMEM if there is not enough skb headroom available. Otherw=
ise, on
+ * success 0.
+ */
+static int batadv_mcast_forw_push_hdr(struct sk_buff *skb, int tvlv_len)
+{
+	struct batadv_mcast_packet *mcast_packet;
+
+	if (skb_headroom(skb) < sizeof(*mcast_packet))
+		return -ENOMEM;
+
+	skb_push(skb, sizeof(*mcast_packet));
+
+	mcast_packet =3D (struct batadv_mcast_packet *)skb->data;
+	mcast_packet->version =3D BATADV_COMPAT_VERSION;
+	mcast_packet->ttl =3D BATADV_TTL;
+	mcast_packet->packet_type =3D BATADV_MCAST;
+	mcast_packet->reserved =3D 0;
+	mcast_packet->tvlv_len =3D htons(tvlv_len);
+
+	return 0;
+}
+
 /**
  * batadv_mcast_forw_orig_to_neigh() - get next hop neighbor to an orig =
address
  * @bat_priv: the bat priv with all the soft interface information
@@ -266,3 +656,117 @@ int batadv_mcast_forw_tracker_tvlv_handler(struct b=
atadv_priv *bat_priv,
 {
 	return batadv_mcast_forw_packet(bat_priv, skb, false);
 }
+
+/**
+ * batadv_mcast_forw_packet_hdrlen() - multicast packet header length
+ * @num_dests: number of destination nodes
+ *
+ * Calculates the total batman-adv multicast packet header length for a =
given
+ * number of destination nodes (excluding the outter ethernet frame).
+ *
+ * Return: The calculated total batman-adv multicast packet header lengt=
h.
+ */
+unsigned int batadv_mcast_forw_packet_hdrlen(unsigned int num_dests)
+{
+	return num_dests * ETH_ALEN +
+	       batadv_mcast_forw_tracker_hdrlen(num_dests) +
+	       sizeof(struct batadv_tvlv_hdr) +
+	       sizeof(struct batadv_mcast_packet);
+}
+
+/**
+ * batadv_mcast_forw_expand_head() - expand headroom for an mcast packet
+ * @bat_priv: the bat priv with all the soft interface information
+ * @skb: the multicast packet to send
+ *
+ * Tries to expand an skb's headroom so that its head to tail is 1298
+ * bytes (minimum IPv6 MTU + vlan ethernet header size) large.
+ *
+ * Return: -EINVAL if the given skb's length is too large or -ENOMEM on =
memory
+ * allocation failure. Otherwise, on success, zero is returned.
+ */
+static int batadv_mcast_forw_expand_head(struct batadv_priv *bat_priv,
+					 struct sk_buff *skb)
+{
+	int hdr_size =3D VLAN_ETH_HLEN + IPV6_MIN_MTU - skb->len;
+
+	 /* TODO: Could be tightened to actual number of destination nodes?
+	  * But it's tricky, number of destinations might have increased since
+	  * we last checked.
+	  */
+	if (hdr_size < 0) {
+		/* batadv_mcast_forw_mode_check_count() should ensure we do not
+		 * end up here
+		 */
+		WARN_ON(1);
+		return -EINVAL;
+	}
+
+	if (skb_headroom(skb) < hdr_size &&
+	    pskb_expand_head(skb, hdr_size, 0, GFP_ATOMIC) < 0)
+		return -ENOMEM;
+
+	return 0;
+}
+
+/**
+ * batadv_mcast_forw_push() - encapsulate skb in a batman-adv multicast =
packet
+ * @bat_priv: the bat priv with all the soft interface information
+ * @skb: the multicast packet to encapsulate and send
+ * @vid: the vlan identifier
+ * @is_routable: indicates whether the destination is routable
+ *
+ * Encapsulates the given multicast packet in a batman-adv multicast pac=
ket.
+ * A multicast tracker TVLV with destination originator addresses for an=
y node
+ * that signaled interest in it, that is either via the translation tabl=
e or the
+ * according want-all flags, is attached accordingly.
+ *
+ * Return: true on success, false otherwise.
+ */
+bool batadv_mcast_forw_push(struct batadv_priv *bat_priv, struct sk_buff=
 *skb,
+			    unsigned short vid, int is_routable)
+{
+	int tvlv_len;
+
+	if (batadv_mcast_forw_expand_head(bat_priv, skb) < 0)
+		return false;
+
+	skb_reset_transport_header(skb);
+
+	tvlv_len =3D batadv_mcast_forw_push_tvlvs(bat_priv, skb, vid,
+						is_routable);
+	if (tvlv_len < 0)
+		return false;
+
+	if (batadv_mcast_forw_push_hdr(skb, tvlv_len) < 0) {
+		skb_pull(skb, tvlv_len);
+		return false;
+	}
+
+	return true;
+}
+
+/**
+ * batadv_mcast_forw_mcsend() - send a self prepared batman-adv multicas=
t packet
+ * @bat_priv: the bat priv with all the soft interface information
+ * @skb: the multicast packet to encapsulate and send
+ *
+ * Transmits a batman-adv multicast packet that was locally prepared and
+ * consumes/frees it.
+ *
+ * Return: NET_XMIT_DROP on memory allocation failure. NET_XMIT_SUCCESS
+ * otherwise.
+ */
+int batadv_mcast_forw_mcsend(struct batadv_priv *bat_priv,
+			     struct sk_buff *skb)
+{
+	int ret =3D batadv_mcast_forw_packet(bat_priv, skb, true);
+
+	if (ret < 0) {
+		kfree_skb(skb);
+		return NET_XMIT_DROP;
+	}
+
+	consume_skb(skb);
+	return NET_XMIT_SUCCESS;
+}
diff --git a/net/batman-adv/soft-interface.c b/net/batman-adv/soft-interf=
ace.c
index d30598eb557c..2a80fa3dd3b1 100644
--- a/net/batman-adv/soft-interface.c
+++ b/net/batman-adv/soft-interface.c
@@ -299,12 +299,13 @@ static netdev_tx_t batadv_interface_tx(struct sk_bu=
ff *skb,
=20
 send:
 		if (do_bcast && !is_broadcast_ether_addr(ethhdr->h_dest)) {
-			forw_mode =3D batadv_mcast_forw_mode(bat_priv, skb,
+			forw_mode =3D batadv_mcast_forw_mode(bat_priv, skb, vid,
 							   &mcast_is_routable);
 			switch (forw_mode) {
 			case BATADV_FORW_BCAST:
 				break;
 			case BATADV_FORW_UCASTS:
+			case BATADV_FORW_MCAST:
 				do_bcast =3D false;
 				break;
 			case BATADV_FORW_NONE:
@@ -363,6 +364,8 @@ static netdev_tx_t batadv_interface_tx(struct sk_buff=
 *skb,
 		} else if (forw_mode =3D=3D BATADV_FORW_UCASTS) {
 			ret =3D batadv_mcast_forw_send(bat_priv, skb, vid,
 						     mcast_is_routable);
+		} else if (forw_mode =3D=3D BATADV_FORW_MCAST) {
+			ret =3D batadv_mcast_forw_mcsend(bat_priv, skb);
 		} else {
 			if (batadv_dat_snoop_outgoing_arp_request(bat_priv,
 								  skb))
@@ -760,6 +763,7 @@ static int batadv_softif_init_late(struct net_device =
*dev)
 	atomic_set(&bat_priv->mcast.num_want_all_unsnoopables, 0);
 	atomic_set(&bat_priv->mcast.num_want_all_ipv4, 0);
 	atomic_set(&bat_priv->mcast.num_want_all_ipv6, 0);
+	atomic_set(&bat_priv->mcast.num_no_mc_ptype_capa, 0);
 #endif
 	atomic_set(&bat_priv->gw.mode, BATADV_GW_MODE_OFF);
 	atomic_set(&bat_priv->gw.bandwidth_down, 100);
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index a2fee3325b29..4008ae1d6c15 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -1342,6 +1342,12 @@ struct batadv_priv_mcast {
 	/** @num_want_all_rtr6: counter for items in want_all_rtr6_list */
 	atomic_t num_want_all_rtr6;
=20
+	/**
+	 * @num_no_mc_ptype_capa: counter for number of nodes without the
+	 *  BATADV_MCAST_HAVE_MC_PTYPE_CAPA flag
+	 */
+	atomic_t num_no_mc_ptype_capa;
+
 	/**
 	 * @want_lists_lock: lock for protecting modifications to mcasts
 	 *  want_all_{unsnoopables,ipv4,ipv6}_list (traversals are rcu-locked)
--=20
2.39.0
