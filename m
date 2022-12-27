Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Subject: [PATCH v4 5/5] batman-adv: mcast: shrink tracker packet after
 scrubbing
Date: Tue, 27 Dec 2022 20:34:09 +0100
Message-Id: <20221227193409.13461-6-linus.luessing@c0d3.blue>
In-Reply-To: <20221227193409.13461-1-linus.luessing@c0d3.blue>
References: <20221227193409.13461-1-linus.luessing@c0d3.blue>
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

Remove all zero MAC address entries (00:00:00:00:00:00) from a multicast
packet's tracker TVLV before transmitting it and update all headers
accordingly. This way, instead of keeping the multicast packet at a
constant size throughout its journey through the mesh, it will become
more lightweight, smaller with every interested receiver on the way and
on each splitting intersection. Which can save some valuable bandwidth.

Signed-off-by: Linus L=C3=BCssing <linus.luessing@c0d3.blue>
---
 net/batman-adv/multicast_forw.c | 212 ++++++++++++++++++++++++++++++++
 1 file changed, 212 insertions(+)

diff --git a/net/batman-adv/multicast_forw.c b/net/batman-adv/multicast_f=
orw.c
index 8414bd13f6e9..1f9e645a069d 100644
--- a/net/batman-adv/multicast_forw.c
+++ b/net/batman-adv/multicast_forw.c
@@ -35,6 +35,9 @@
 #define batadv_mcast_forw_tracker_for_each_dest(dest, num_dests) \
 	for (; num_dests; num_dests--, (dest) +=3D ETH_ALEN)
=20
+#define batadv_mcast_forw_tracker_for_each_dest_rev(dest, num_dests) \
+	for (; num_dests; num_dests--, (dest) -=3D ETH_ALEN)
+
 /**
  * batadv_mcast_forw_orig_entry() - get orig_node from an hlist node
  * @node: the hlist node to get the orig_node from
@@ -531,6 +534,214 @@ batadv_mcast_forw_scrub_dests(struct batadv_priv *b=
at_priv,
 	}
 }
=20
+/**
+ * batadv_mcast_forw_shrink_align_offset() - calculate alignment offset
+ * @num_dests_old: the number of destinations the tracker TVLV had origi=
nally
+ * @num_dests_reduce: the number of destinations that are going to be re=
moved
+ *
+ * The multicast tracker TVLV has 2 alignment bytes if the number of des=
tination
+ * entries are even, to make this TVLV 4 byte aligned to make the encaps=
ulated
+ * IP packet 4 byte aligned. And no alignment bytes in the tracker TVLV =
if the
+ * number of destinations is odd.
+ *
+ * This calculates if the 2 alignment bytes in the multicast tracker TVL=
V need
+ * to be added, removed or left unchanged.
+ *
+ * Return: The number of extra offset in skb tail direction to compensat=
e for
+ * alignment. Will be -2, 0 or +2.
+ */
+static int batadv_mcast_forw_shrink_align_offset(unsigned int num_dests_=
old,
+						 unsigned int num_dests_reduce)
+{
+	int ret =3D sizeof_field(struct batadv_tvlv_mcast_tracker, align);
+
+	/* no change in padding */
+	if (!(num_dests_reduce % 2))
+		return 0;
+
+	/* even had padding, remove it, increase the offset */
+	if (!(num_dests_old % 2))
+		return ret;
+	/* odd had no padding, add it, decrease the offset */
+	else
+		return -ret;
+}
+
+/**
+ * batadv_mcast_forw_shrink_pack_dests() - pack destinations of a tracke=
r TVLV
+ * @skb: the batman-adv multicast packet to compact destinations in
+ *
+ * Compacts the originator destination MAC addresses in the multicast tr=
acker
+ * TVLV of the given multicast packet. This is done by moving all non-ze=
ro
+ * MAC addresses in direction of the skb tail and all zero MAC addresses=
 in skb
+ * head direction, within the multicast tracker TVLV.
+ *
+ * Return: The number of consecutive zero MAC address destinations which=
 are
+ * now at the front within the multicast tracker TVLV.
+ */
+static int batadv_mcast_forw_shrink_pack_dests(struct sk_buff *skb)
+{
+	struct batadv_tvlv_mcast_tracker *mcast_tracker;
+	u16 num_dests_slot, num_dests_filler;
+	unsigned int tracker_hdrlen;
+	unsigned char *skb_net_hdr;
+	u8 *slot, *filler;
+
+	skb_net_hdr =3D skb_network_header(skb);
+	mcast_tracker =3D (struct batadv_tvlv_mcast_tracker *)skb_net_hdr;
+	num_dests_slot =3D ntohs(mcast_tracker->num_dests);
+
+	tracker_hdrlen =3D batadv_mcast_forw_tracker_hdrlen(num_dests_slot);
+	slot =3D (u8 *)mcast_tracker + tracker_hdrlen;
+	slot +=3D ETH_ALEN * (num_dests_slot - 1);
+
+	if (!num_dests_slot)
+		return 0;
+
+	num_dests_filler =3D num_dests_slot - 1;
+	filler =3D slot - ETH_ALEN;
+
+	batadv_mcast_forw_tracker_for_each_dest_rev(slot, num_dests_slot) {
+		/* find an empty slot */
+		if (!is_zero_ether_addr(slot))
+			continue;
+
+		/* keep filler ahead of slot */
+		if (filler >=3D slot) {
+			num_dests_filler =3D num_dests_slot - 1;
+			filler =3D slot - ETH_ALEN;
+		}
+
+		/* find a candidate to fill the empty slot */
+		batadv_mcast_forw_tracker_for_each_dest_rev(filler,
+							    num_dests_filler) {
+			if (is_zero_ether_addr(filler))
+				continue;
+
+			ether_addr_copy(slot, filler);
+			eth_zero_addr(filler);
+			goto cont_next_slot;
+		}
+
+		/* could not find a filler, we can stop
+		 * - and must not advance the slot pointer!
+		 */
+		if (!num_dests_filler)
+			break;
+
+cont_next_slot:
+		continue;
+	}
+
+	 /* num_dests_slot is the amount of reduced destinations */
+	return num_dests_slot;
+}
+
+/**
+ * batadv_mcast_forw_shrink_update_headers() - update shrunk mc packet h=
eaders
+ * @skb: the batman-adv multicast packet to update headers of
+ * @num_dests_reduce: the number of destinations that were removed
+ *
+ * This updates any fields of a batman-adv multicast packet that are aff=
ected
+ * by the reduced number of destinations in the multicast tracket TVLV. =
In
+ * particular this updates:
+ *
+ * The num_dest field of the multicast tracker TVLV.
+ * The TVLV length field of the according generic TVLV header.
+ * The batman-adv multicast packet's total TVLV length field.
+ *
+ * Return: The offset in skb's tail direction at which the new batman-ad=
v
+ * multicast packet header needs to start.
+ */
+static unsigned int
+batadv_mcast_forw_shrink_update_headers(struct sk_buff *skb,
+					unsigned int num_dests_reduce)
+{
+	struct batadv_tvlv_mcast_tracker *mcast_tracker;
+	struct batadv_mcast_packet *mcast_packet;
+	struct batadv_tvlv_hdr *tvlv_hdr;
+	unsigned char *skb_net_hdr;
+	unsigned int offset;
+	int align_offset;
+	u16 num_dests;
+
+	skb_net_hdr =3D skb_network_header(skb);
+	mcast_tracker =3D (struct batadv_tvlv_mcast_tracker *)skb_net_hdr;
+	num_dests =3D ntohs(mcast_tracker->num_dests);
+
+	align_offset =3D batadv_mcast_forw_shrink_align_offset(num_dests,
+							     num_dests_reduce);
+	num_dests -=3D num_dests_reduce;
+	offset =3D ETH_ALEN * num_dests_reduce + align_offset;
+
+	/* update tracker header */
+	mcast_tracker->num_dests =3D htons(num_dests);
+	/* align field is already zero'd due to previous eth_zero_addr() call *=
/
+
+	/* update tracker's tvlv header's length field */
+	tvlv_hdr =3D (struct batadv_tvlv_hdr *)(skb_network_header(skb) -
+					      sizeof(*tvlv_hdr));
+	tvlv_hdr->len =3D htons(ntohs(tvlv_hdr->len) - offset);
+
+	/* update multicast packet header's tvlv length field */
+	mcast_packet =3D (struct batadv_mcast_packet *)skb->data;
+	mcast_packet->tvlv_len =3D htons(ntohs(mcast_packet->tvlv_len) - offset=
);
+
+	return offset;
+}
+
+/**
+ * batadv_mcast_forw_shrink_move_headers() - move multicast headers by o=
ffset
+ * @skb: the batman-adv multicast packet to move headers for
+ * @offset: a non-negative offset to move headers by, towards the skb ta=
il
+ *
+ * Moves the batman-adv multicast packet header, its multicast tracker T=
VLV and
+ * any TVLVs in between by the given offset in direction towards the tai=
l.
+ *
+ * It also invalidates the skb checksum.
+ */
+static void
+batadv_mcast_forw_shrink_move_headers(struct sk_buff *skb, unsigned int =
offset)
+{
+	struct batadv_tvlv_mcast_tracker *mcast_tracker;
+	unsigned int tracker_hdrlen, len;
+	unsigned char *skb_net_hdr;
+	u16 num_dests;
+
+	skb_net_hdr =3D skb_network_header(skb);
+	mcast_tracker =3D (struct batadv_tvlv_mcast_tracker *)skb_net_hdr;
+	num_dests =3D ntohs(mcast_tracker->num_dests);
+	tracker_hdrlen =3D batadv_mcast_forw_tracker_hdrlen(num_dests);
+	len =3D skb_network_offset(skb) + tracker_hdrlen;
+
+	memmove(skb->data + offset, skb->data, len);
+	skb_pull(skb, offset);
+
+	/* invalidate checksum: */
+	skb->ip_summed =3D CHECKSUM_NONE;
+}
+
+/**
+ * batadv_mcast_forw_shrink_tracker() - remove zero addresses in a track=
er tvlv
+ * @skb: the batman-adv multicast packet to (potentially) shrink
+ *
+ * Removes all destinations with a zero MAC addresses (00:00:00:00:00:00=
) from
+ * the given batman-adv multicast packet's tracker TVLV and updates head=
ers
+ * accordingly to maintain a valid batman-adv multicast packet.
+ */
+static void batadv_mcast_forw_shrink_tracker(struct sk_buff *skb)
+{
+	u16 dests_reduced;
+	unsigned int offset;
+
+	dests_reduced =3D batadv_mcast_forw_shrink_pack_dests(skb);
+	if (!dests_reduced)
+		return;
+
+	offset =3D batadv_mcast_forw_shrink_update_headers(skb, dests_reduced);
+	batadv_mcast_forw_shrink_move_headers(skb, offset);
+}
+
 /**
  * batadv_mcast_forw_packet() - forward a batman-adv multicast packet
  * @bat_priv: the bat priv with all the soft interface information
@@ -615,6 +826,7 @@ static int batadv_mcast_forw_packet(struct batadv_pri=
v *bat_priv,
=20
 		batadv_mcast_forw_scrub_dests(bat_priv, neigh_node, dest,
 					      next_dest, num_dests);
+		batadv_mcast_forw_shrink_tracker(nexthop_skb);
=20
 		batadv_inc_counter(bat_priv, BATADV_CNT_MCAST_TX);
 		batadv_add_counter(bat_priv, BATADV_CNT_MCAST_TX_BYTES,
--=20
2.39.0
