Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06101EB64DA
	for <batman-adv@archiver.kernel.org>; Thu, 20 Jul 2023 04:38:37 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 81FD5825EC
	for <batman-adv@archiver.kernel.org>; Thu, 20 Jul 2023 06:38:35 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1689827915;
 b=nUYi8r4v2zBkFfkkA8cy5v/nHbfikfp9JqY26b6ETXlGS2P3k2bxFT0Aew3HD3qZXB2Cp
 a7BNnugOnxyffdqnPZ4dXk1xNdb00bX/Gp9WiPoq5kcE7dz/9tN2A835uTsxklKj8rDiIFU
 TwE93sbpyWJadFUatPQI/TCKM6LDw/I=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1689827915; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=2fzdfVeC6f0aTxfnObgR7XOgEsDlZZnAur8K00I/Mx8=;
 b=v2UYWcsR4D5Ue4S/AVkREbNYJXsjbNU002JK7q4R8LYYI0DFpUDfJKCGXZF/kIvbvVpAI
 ZcZBTSFf0R7AlUtZ3qLKddkdmdaRH0yQ8KFi3/w0j/KDf5QJrs+itt1Pji6hTeQwrIFbmUE
 Aub5LRGDe63fx0hqYGuI85LkhVRTI68=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=fail;
  arc=pass;
  dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass; dmarc=none
Received: from mail.aperture-lab.de (mail.aperture-lab.de
 [IPv6:2a01:4f8:c2c:665b::1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 231108216D
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 20 Jul 2023 06:36:05 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1689827765;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2fzdfVeC6f0aTxfnObgR7XOgEsDlZZnAur8K00I/Mx8=;
	b=J7JrVtjsRWF6SCiDQuEmq45z/NcFFtnnReX7glrxOlvilHrKgTlKiuXAJWwTGW/OCbJVco
	B6mzamKw86yFk0a0/c97Ba/Ws98gfkGqu2HAztpSO3sO7V7O0vbph/DcATUot7P6Ip7QB3
	byuPccWaK3h4IWekk3QR9r7nOV8Zp4Y=
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1689827765; a=rsa-sha256;
	cv=none;
	b=UFexDSkJq4TvpDrZLiPQlj2SduhJpD4o5U1z7vqXIGUUK2+7+WoXEsLW8SCQ3D0QII5ey8
	nLXKWq7wBgfR8QAc1ik6P+boqJQWDQ07/M0fHuJHjzigKh5QUVcGv8HL6LqmLFrRBjcH4X
	Z7tija7pB+XjxPkvKSwbe9MxxuDdprY=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	spf=none (diktynna.open-mesh.org: domain of linus.luessing@c0d3.blue has no
 SPF policy when checking 2a01:4f8:c2c:665b::1)
 smtp.mailfrom=linus.luessing@c0d3.blue;
	dmarc=none
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id B27F349B1E;
	Thu, 20 Jul 2023 06:36:04 +0200 (CEST)
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
To: b.a.t.m.a.n@lists.open-mesh.org
Subject: [PATCH v6 3/3] batman-adv: mcast: shrink tracker packet after
 scrubbing
Date: Thu, 20 Jul 2023 06:35:55 +0200
Message-Id: <20230720043556.12163-4-linus.luessing@c0d3.blue>
In-Reply-To: <20230720043556.12163-1-linus.luessing@c0d3.blue>
References: <20230720043556.12163-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
Message-ID-Hash: SAVQ4KQ6G26HM7SOD4GJD7JVLJTUVW2S
X-Message-ID-Hash: SAVQ4KQ6G26HM7SOD4GJD7JVLJTUVW2S
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/SAVQ4KQ6G26HM7SOD4GJD7JVLJTUVW2S/>
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
 net/batman-adv/multicast_forw.c | 195 ++++++++++++++++++++++++++++++++
 1 file changed, 195 insertions(+)

diff --git a/net/batman-adv/multicast_forw.c b/net/batman-adv/multicast_forw.c
index d0f75a63de2a..d7b1aabd4b72 100644
--- a/net/batman-adv/multicast_forw.c
+++ b/net/batman-adv/multicast_forw.c
@@ -712,6 +712,200 @@ batadv_mcast_forw_scrub_dests(struct batadv_priv *bat_priv,
 	}
 }
 
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
+	u16 num_dests_slot, num_dests_filler;
+	unsigned char *skb_net_hdr;
+	u8 *slot, *filler;
+
+	skb_net_hdr = skb_network_header(skb);
+	mcast_tracker = (struct batadv_tvlv_mcast_tracker *)skb_net_hdr;
+	num_dests_slot = ntohs(mcast_tracker->num_dests);
+
+	slot = (u8 *)mcast_tracker + sizeof(*mcast_tracker);
+
+	if (!num_dests_slot)
+		return 0;
+
+	num_dests_filler = num_dests_slot - 1;
+	filler = slot + ETH_ALEN;
+
+	batadv_mcast_forw_tracker_for_each_dest(slot, num_dests_slot) {
+		/* find an empty slot */
+		if (!is_zero_ether_addr(slot))
+			continue;
+
+		/* keep filler ahead of slot */
+		if (filler <= slot) {
+			num_dests_filler = num_dests_slot - 1;
+			filler = slot + ETH_ALEN;
+		}
+
+		/* find a candidate to fill the empty slot */
+		batadv_mcast_forw_tracker_for_each_dest(filler,
+							num_dests_filler) {
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
+	/* num_dests_slot is the amount of reduced destinations */
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
@@ -798,6 +992,7 @@ static int batadv_mcast_forw_packet(struct batadv_priv *bat_priv,
 
 		batadv_mcast_forw_scrub_dests(bat_priv, neigh_node, dest,
 					      next_dest, num_dests);
+		batadv_mcast_forw_shrink_tracker(nexthop_skb);
 
 		batadv_inc_counter(bat_priv, BATADV_CNT_MCAST_TX);
 		batadv_add_counter(bat_priv, BATADV_CNT_MCAST_TX_BYTES,
-- 
2.40.1

