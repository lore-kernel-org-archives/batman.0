Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1CC4EE14A9
	for <batman@archiver.kernel.org>; Thu,  7 Sep 2023 01:11:59 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 66B64800F0
	for <batman@archiver.kernel.org>; Thu,  7 Sep 2023 03:11:58 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1694049118;
 b=HEe8e5GJCykwudSm2oRuZjzRmYbQx3aaVt1MUuUtLgXu9c+MMigD/OsnIMMnx9gI5U+XN
 pCkiU+4IinbqY/RgFU3U9g09/8NsVjBfVoyCinU3Qwsn8Al4vNB3uHbDeaNgXPNa0/8jLSq
 wrgwK2tDhbu7rq07dLDk3x/poRimRNk=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1694049118; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=6ydtTFxt9lB0Yz23+AxT2Dfm0tRL7qeum9o1q7hg8+w=;
 b=OnHJcJcj6Kq/XYYbKG8Tvtry6vTrwF+UKYQx/+ZwO52z3a7f4KAUU/AuxPRjd8JF5gA/A
 2aRC44zxnnrglUu/ySGzdi/sMrQlQe9G6hMfSPGOD8wjFp9EyyA/LKih9IuTwxm+cL4rYA4
 dMX+2mnIBO3Mm/GFN9u4aZQAxnpRBhg=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=fail;
  arc=pass;
  dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass; dmarc=none
Received: from mail.aperture-lab.de (mail.aperture-lab.de [116.203.183.178])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id E561583199
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu,  7 Sep 2023 03:09:23 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1694048963;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6ydtTFxt9lB0Yz23+AxT2Dfm0tRL7qeum9o1q7hg8+w=;
	b=q8Vo5WRJKi7u17J2QYs/B0nORDdcyNO+gqy3yqdK+mvpMGz1O9KGEYGYfvKTL84FT8QLUi
	tg+5cNXVbGTIAfJvAzCYIkOTzvqvhdth46ZXZEQwPmtUH5ck+eUDdAr3ZG3zlPeyRmlslg
	6j9gD8lX9AmwLrMtzcDv+Nnx6I2zMJo=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	spf=none (diktynna.open-mesh.org: domain of linus.luessing@c0d3.blue has no
 SPF policy when checking 116.203.183.178)
 smtp.mailfrom=linus.luessing@c0d3.blue;
	dmarc=none
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1694048963; a=rsa-sha256;
	cv=none;
	b=PrsJ29pfRwMDWuH5NJYGB8Sz/6H4i2PcI/VS9qPwrYaHYjrumo8WnBTTO5hmQoMu8i6X7U
	Ue5iMaZI5nXYPgk8rpi10FBjrSBKRzrSFnGHcww6erdyiNqY09e8B2qKT6yQsXT2xg0hJj
	G3g5JXCagajiJCxCJptA+I4gbvpgJzc=
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 6FC8640C8E;
	Thu,  7 Sep 2023 03:09:23 +0200 (CEST)
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
To: b.a.t.m.a.n@lists.open-mesh.org
Subject: [PATCH v7 3/3] batman-adv: mcast: shrink tracker packet after
 scrubbing
Date: Thu,  7 Sep 2023 03:09:10 +0200
Message-Id: <20230907010910.22427-4-linus.luessing@c0d3.blue>
In-Reply-To: <20230907010910.22427-1-linus.luessing@c0d3.blue>
References: <20230907010910.22427-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
Message-ID-Hash: TMEPCNLULBJ7QX3EXBXPNQIPTW4H6CDV
X-Message-ID-Hash: TMEPCNLULBJ7QX3EXBXPNQIPTW4H6CDV
X-MailFrom: linus.luessing@c0d3.blue
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/TMEPCNLULBJ7QX3EXBXPNQIPTW4H6CDV/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Remove all zero MAC address entries (00:00:00:00:00:00) from a multicast
packet's tracker TVLV before transmitting it and update all headers
accordingly. This way, instead of keeping the multicast packet at a
constant size throughout its journey through the mesh, it will become
more lightweight, smaller with every interested receiver on the way and
on each splitting intersection. Which can save some valuable bandwidth.

Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
---
 net/batman-adv/multicast_forw.c | 207 ++++++++++++++++++++++++++++++++
 1 file changed, 207 insertions(+)

diff --git a/net/batman-adv/multicast_forw.c b/net/batman-adv/multicast_forw.c
index 1102090ae518..23aae4f60daa 100644
--- a/net/batman-adv/multicast_forw.c
+++ b/net/batman-adv/multicast_forw.c
@@ -698,6 +698,212 @@ batadv_mcast_forw_scrub_dests(struct batadv_priv *bat_priv,
 	}
 }
 
+/**
+ * batadv_mcast_forw_shrink_fill() - swap slot with next non-zero destination
+ * @slot: the to be filled zero-MAC destination entry in a tracker TVLV
+ * @num_dests_slot: remaining entries in tracker TVLV from/including slot
+ *
+ * Searches for the next non-zero-MAC destination entry in a tracker TVLV after
+ * the given slot pointer. And if found, swaps it with the zero-MAC destination
+ * entry which the slot points to.
+ *
+ * Return: true if slot was swapped/filled successfully, false otherwise.
+ */
+static bool batadv_mcast_forw_shrink_fill(u8 *slot, u16 num_dests_slot)
+{
+	u16 num_dests_filler;
+	u8 *filler;
+
+	/* sanity check, should not happen */
+	if (!num_dests_slot)
+		return false;
+
+	num_dests_filler = num_dests_slot - 1;
+	filler = slot + ETH_ALEN;
+
+	/* find a candidate to fill the empty slot */
+	batadv_mcast_forw_tracker_for_each_dest(filler, num_dests_filler) {
+		if (is_zero_ether_addr(filler))
+			continue;
+
+		ether_addr_copy(slot, filler);
+		eth_zero_addr(filler);
+		return true;
+	}
+
+	return false;
+}
+
+/**
+ * batadv_mcast_forw_shrink_pack_dests() - pack destinations of a tracker TVLV
+ * @skb: the batman-adv multicast packet to compact destinations in
+ *
+ * Compacts the originator destination MAC addresses in the multicast tracker
+ * TVLV of the given multicast packet. This is done by moving all non-zero
+ * MAC addresses in direction of the skb head and all zero MAC addresses in skb
+ * tail direction, within the multicast tracker TVLV.
+ *
+ * Return: The number of consecutive zero MAC address destinations which are
+ * now at the end of the multicast tracker TVLV.
+ */
+static int batadv_mcast_forw_shrink_pack_dests(struct sk_buff *skb)
+{
+	struct batadv_tvlv_mcast_tracker *mcast_tracker;
+	unsigned char *skb_net_hdr;
+	u16 num_dests_slot;
+	u8 *slot;
+
+	skb_net_hdr = skb_network_header(skb);
+	mcast_tracker = (struct batadv_tvlv_mcast_tracker *)skb_net_hdr;
+	num_dests_slot = ntohs(mcast_tracker->num_dests);
+
+	slot = (u8 *)mcast_tracker + sizeof(*mcast_tracker);
+
+	batadv_mcast_forw_tracker_for_each_dest(slot, num_dests_slot) {
+		/* find an empty slot */
+		if (!is_zero_ether_addr(slot))
+			continue;
+
+		if (!batadv_mcast_forw_shrink_fill(slot, num_dests_slot))
+			/* could not find a filler, so we successfully packed
+			 * and can stop - and must not reduce num_dests_slot!
+			 */
+			break;
+	}
+
+	/* num_dests_slot is now the amount of reduced, zeroed
+	 * destinations at the end of the tracker TVLV
+	 */
+	return num_dests_slot;
+}
+
+/**
+ * batadv_mcast_forw_shrink_align_offset() - get new alignment offset
+ * @num_dests_old: the old, to be updated amount of destination nodes
+ * @num_dests_reduce: the number of destinations that were removed
+ *
+ * Calculates the amount of potential extra alignment offset that is needed to
+ * adjust the TVLV padding after the change in destination nodes.
+ *
+ * Return:
+ *	0: If no change to padding is needed.
+ *	2: If padding needs to be removed.
+ *	-2: If padding needs to be added.
+ */
+static short
+batadv_mcast_forw_shrink_align_offset(unsigned int num_dests_old,
+				      unsigned int num_dests_reduce)
+{
+	/* even amount of removed destinations -> no alignment change */
+	if (!(num_dests_reduce % 2))
+		return 0;
+
+	/* even to odd amount of destinations -> remove padding */
+	if (!(num_dests_old % 2))
+		return 2;
+
+	/* odd to even amount of destinations -> add padding */
+	return -2;
+}
+
+/**
+ * batadv_mcast_forw_shrink_update_headers() - update shrunk mc packet headers
+ * @skb: the batman-adv multicast packet to update headers of
+ * @num_dests_reduce: the number of destinations that were removed
+ *
+ * This updates any fields of a batman-adv multicast packet that are affected
+ * by the reduced number of destinations in the multicast tracket TVLV. In
+ * particular this updates:
+ *
+ * The num_dest field of the multicast tracker TVLV.
+ * The TVLV length field of the according generic TVLV header.
+ * The batman-adv multicast packet's total TVLV length field.
+ *
+ * Return: The offset in skb's tail direction at which the new batman-adv
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
+	short align_offset;
+	u16 num_dests;
+
+	skb_net_hdr = skb_network_header(skb);
+	mcast_tracker = (struct batadv_tvlv_mcast_tracker *)skb_net_hdr;
+	num_dests = ntohs(mcast_tracker->num_dests);
+
+	align_offset = batadv_mcast_forw_shrink_align_offset(num_dests,
+							     num_dests_reduce);
+	offset = ETH_ALEN * num_dests_reduce + align_offset;
+	num_dests -= num_dests_reduce;
+
+	/* update tracker header */
+	mcast_tracker->num_dests = htons(num_dests);
+
+	/* update tracker's tvlv header's length field */
+	tvlv_hdr = (struct batadv_tvlv_hdr *)(skb_network_header(skb) -
+					      sizeof(*tvlv_hdr));
+	tvlv_hdr->len = htons(ntohs(tvlv_hdr->len) - offset);
+
+	/* update multicast packet header's tvlv length field */
+	mcast_packet = (struct batadv_mcast_packet *)skb->data;
+	mcast_packet->tvlv_len = htons(ntohs(mcast_packet->tvlv_len) - offset);
+
+	return offset;
+}
+
+/**
+ * batadv_mcast_forw_shrink_move_headers() - move multicast headers by offset
+ * @skb: the batman-adv multicast packet to move headers for
+ * @offset: a non-negative offset to move headers by, towards the skb tail
+ *
+ * Moves the batman-adv multicast packet header, its multicast tracker TVLV and
+ * any TVLVs in between by the given offset in direction towards the tail.
+ */
+static void
+batadv_mcast_forw_shrink_move_headers(struct sk_buff *skb, unsigned int offset)
+{
+	struct batadv_tvlv_mcast_tracker *mcast_tracker;
+	unsigned char *skb_net_hdr;
+	unsigned int len;
+	u16 num_dests;
+
+	skb_net_hdr = skb_network_header(skb);
+	mcast_tracker = (struct batadv_tvlv_mcast_tracker *)skb_net_hdr;
+	num_dests = ntohs(mcast_tracker->num_dests);
+	len = skb_network_offset(skb) + sizeof(*mcast_tracker);
+	len += num_dests * ETH_ALEN;
+
+	batadv_mcast_forw_scrape(skb, len, offset);
+}
+
+/**
+ * batadv_mcast_forw_shrink_tracker() - remove zero addresses in a tracker tvlv
+ * @skb: the batman-adv multicast packet to (potentially) shrink
+ *
+ * Removes all destinations with a zero MAC addresses (00:00:00:00:00:00) from
+ * the given batman-adv multicast packet's tracker TVLV and updates headers
+ * accordingly to maintain a valid batman-adv multicast packet.
+ */
+static void batadv_mcast_forw_shrink_tracker(struct sk_buff *skb)
+{
+	unsigned int offset;
+	u16 dests_reduced;
+
+	dests_reduced = batadv_mcast_forw_shrink_pack_dests(skb);
+	if (!dests_reduced)
+		return;
+
+	offset = batadv_mcast_forw_shrink_update_headers(skb, dests_reduced);
+	batadv_mcast_forw_shrink_move_headers(skb, offset);
+}
+
 /**
  * batadv_mcast_forw_packet() - forward a batman-adv multicast packet
  * @bat_priv: the bat priv with all the soft interface information
@@ -787,6 +993,7 @@ static int batadv_mcast_forw_packet(struct batadv_priv *bat_priv,
 
 		batadv_mcast_forw_scrub_dests(bat_priv, neigh_node, dest,
 					      next_dest, num_dests);
+		batadv_mcast_forw_shrink_tracker(nexthop_skb);
 
 		batadv_inc_counter(bat_priv, BATADV_CNT_MCAST_TX);
 		batadv_add_counter(bat_priv, BATADV_CNT_MCAST_TX_BYTES,
-- 
2.40.1

