Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89F3FCD8CB9
	for <batman-adv@archiver.kernel.org>; Wed, 10 Jun 2026 12:57:12 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id CEFA383D1C
	for <batman-adv@archiver.kernel.org>; Wed, 10 Jun 2026 14:57:10 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1781096230;
 b=g13t+Lwzb3uKbeytX7JjZRpUU9ep/HrWLFbag7iCdJw8Fn7VtGBr92wHg164oajUQCojf
 yr4HtToHxLmXnmOidBQRa72uRqWhchWUm6vffuDgdQYWK9Kfmw7ikwFNviAeHDmVUt7q7+c
 7jMoMcTvclTsbzE/p8kXur9s1xsdcxo=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1781096230; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=fEGQUqIxQSkkXc0K6O0QAsqwICJox2DC/5C6qahz+1M=;
 b=rb3FjubMTwgLgzDctdTnFVOMdtuyCXJpJBaxrd6RM2b5VhGmEPJaaQqdQ4u/fkPjJv4hR
 oVawgm79WZDvyOIzcFn7x8vULy9QuEeEoj/YgIAT1e/EEZoK2p7p05gZjnrCNuBKaun/3sp
 ANoy86rlcdAhoR8UVUPNerFjUyNiPZk=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 8298883B11
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 10 Jun 2026 14:56:12 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1781096177;
	b=smFj2kiGkqhjmB+UtoKtI8AigbNdE5f5MjK76C7fcyDso+56ukjWVvG3wsT3SU/5OJjElQ
	N0Gt73etggOwLcbhZUU6dz/fgMi25mlhpb4fdmI7tar/UKe9i/8+gTVQGPgVEByZGrvKa0
	DeTQkwyxyi0LSchdbGgwQhrzy22m7G8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1781096177;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=fEGQUqIxQSkkXc0K6O0QAsqwICJox2DC/5C6qahz+1M=;
	b=uzD0KEBQv9OEF3XkZdfWAFBMQY8DZxvYMraawfGTOQIBz3/+SbfhUpAAsykYX+Q5cZTa4U
	lZEdNvZqP6lMXwbEJZkllWSE6RKHsOMibSx9CbAz9Q9Gg3ocxTKDl7vw0Fxm1fTKc22oAD
	jxYRVO8XWfqStK3IqrpnmWDFzCIoVzo=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=JUXp1Mzr;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org
Received: by dvalin.narfation.org (Postfix) id B6599201CF;
	Wed, 10 Jun 2026 12:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1781096171;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fEGQUqIxQSkkXc0K6O0QAsqwICJox2DC/5C6qahz+1M=;
	b=JUXp1MzrdnIOoz+9nUDIzIXi2/34uE/DJBTY48KM16yZ30VZiINTDSUBV2o0uHUs2dfYlu
	vyhuFreFYHIgUZggoOY8X330XNdE2BPXtqAQemmubWb1kK7/eA8VqzWNyqxGNnVagSguVT
	jGShxXG77kZ/ukbku7TorBdyDQFtqiA=
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 10 Jun 2026 14:56:04 +0200
Subject: [PATCH batadv 2/2] batman-adv: fix (m|b)cast csum after
 decrementing TTL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260610-ip_checksum-v1-2-0fd7f471dca3@narfation.org>
References: <20260610-ip_checksum-v1-0-0fd7f471dca3@narfation.org>
In-Reply-To: <20260610-ip_checksum-v1-0-0fd7f471dca3@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4522; i=sven@narfation.org;
 h=from:subject:message-id; bh=PD4OP2UsHtxVWHTxCwUMZw+4OlCMxqOvveS24pbK2EA=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFmacU/aFi6etVrx6I3LxTM9ZXu9ym7e+9Zw0e/siovv5
 t2cXHLoa0cpC4MYF4OsmCLLniv55zezv5X/PO3jUZg5rEwgQxi4OAVgImqMDP9M9lq/ty/8mt09
 z4ltU5zkHDbWzgfJq1J1V1s4XH65i4mH4X/OfxbXavbvk9dkH989Pbhiyb25ZrdluZsV7sR3/+W
 KW8QAAA==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: QICGCGZK4H4S2CCXKURKLAHKCQNUIAK7
X-Message-ID-Hash: QICGCGZK4H4S2CCXKURKLAHKCQNUIAK7
X-MailFrom: sven@narfation.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-3; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/QICGCGZK4H4S2CCXKURKLAHKCQNUIAK7/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

The broadcast and multicast packets can be received at the same time by the
local system and forwarded to other nodes. Both are simply decrementing the
TTL at the beginning of the receive path - independent of chosen paths
(receive/forward). But such a modification of the data conflicts with the
hw csum. This is not a problem when the packet is directly forwarded but
can cause errors in the local receive path.

Such a problem can then trigger a "hw csum failure". The receiver path must
therefore ensure that the csum is fixed for each modification of the
payload before batadv_interface_rx() is reached.

Since all batman-adv packet types with a ttl have it as u8 at offset 2, a
helper can be used for all of them. But it is only used at the moment for
batadv_bcast_packet and batadv_mcast_packet because they are the only ones
which deliver the packet locally but unconditionally modify the TTL.

Fixes: 5e399a8a6b09 ("batman-adv: bcast: queue per interface, if needed")
Fixes: 8ed36122d709 ("batman-adv: mcast: implement multicast packet reception and forwarding")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/routing.c | 58 ++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 56 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/routing.c b/net/batman-adv/routing.c
index 7b4acd1a..8786b66c 100644
--- a/net/batman-adv/routing.c
+++ b/net/batman-adv/routing.c
@@ -8,6 +8,7 @@
 #include "main.h"
 
 #include <linux/atomic.h>
+#include <linux/build_bug.h>
 #include <linux/byteorder/generic.h>
 #include <linux/compiler.h>
 #include <linux/errno.h>
@@ -204,6 +205,59 @@ bool batadv_check_management_packet(struct sk_buff *skb,
 	return true;
 }
 
+/**
+ * batadv_skb_decrement_ttl() - decrement ttl in a batman-adv header, csum-safe
+ * @skb: the received packet with @skb->data pointing to the batman-adv header
+ *
+ * Supports the following packet types, all of which carry the TTL at offset 2:
+ *
+ * - batadv_ogm_packet
+ * - batadv_ogm2_packet
+ * - batadv_icmp_header
+ * - batadv_icmp_packet
+ * - batadv_icmp_tp_packet
+ * - batadv_icmp_packet_rr
+ * - batadv_unicast_packet
+ * - batadv_frag_packet
+ * - batadv_bcast_packet
+ * - batadv_mcast_packet
+ * - batadv_coded_packet
+ * - batadv_unicast_tvlv_packet
+ *
+ * Return: true if the packet may be forwarded (ttl decremented),
+ *  false if it must be dropped (ttl would expire)
+ */
+static bool batadv_skb_decrement_ttl(struct sk_buff *skb)
+{
+	static const size_t ttl_offset = 2;
+	u8 *ttl_pos;
+
+	BUILD_BUG_ON(offsetof(struct batadv_ogm_packet, ttl) != ttl_offset);
+	BUILD_BUG_ON(offsetof(struct batadv_ogm2_packet, ttl) != ttl_offset);
+	BUILD_BUG_ON(offsetof(struct batadv_icmp_header, ttl) != ttl_offset);
+	BUILD_BUG_ON(offsetof(struct batadv_icmp_packet, ttl) != ttl_offset);
+	BUILD_BUG_ON(offsetof(struct batadv_icmp_tp_packet, ttl) != ttl_offset);
+	BUILD_BUG_ON(offsetof(struct batadv_icmp_packet_rr, ttl) != ttl_offset);
+	BUILD_BUG_ON(offsetof(struct batadv_unicast_packet, ttl) != ttl_offset);
+	BUILD_BUG_ON(offsetof(struct batadv_frag_packet, ttl) != ttl_offset);
+	BUILD_BUG_ON(offsetof(struct batadv_bcast_packet, ttl) != ttl_offset);
+	BUILD_BUG_ON(offsetof(struct batadv_mcast_packet, ttl) != ttl_offset);
+	BUILD_BUG_ON(offsetof(struct batadv_coded_packet, ttl) != ttl_offset);
+	BUILD_BUG_ON(offsetof(struct batadv_unicast_tvlv_packet, ttl) != ttl_offset);
+
+	ttl_pos = skb->data + ttl_offset;
+
+	/* would expire on this hop -> drop, leave header + csum untouched */
+	if (*ttl_pos < 2)
+		return false;
+
+	skb_postpull_rcsum(skb, ttl_pos, 1);
+	(*ttl_pos)--;
+	skb_postpush_rcsum(skb, ttl_pos, 1);
+
+	return true;
+}
+
 /**
  * batadv_recv_my_icmp_packet() - receive an icmp packet locally
  * @bat_priv: the bat priv with all the mesh interface information
@@ -1197,7 +1251,7 @@ int batadv_recv_bcast_packet(struct sk_buff *skb,
 
 	bcast_packet = (struct batadv_bcast_packet *)skb->data;
 
-	if (bcast_packet->ttl-- < 2)
+	if (!batadv_skb_decrement_ttl(skb))
 		goto free_skb;
 
 	orig_node = batadv_orig_hash_find(bat_priv, bcast_packet->orig);
@@ -1304,7 +1358,7 @@ int batadv_recv_mcast_packet(struct sk_buff *skb,
 		goto free_skb;
 
 	mcast_packet = (struct batadv_mcast_packet *)skb->data;
-	if (mcast_packet->ttl-- < 2)
+	if (!batadv_skb_decrement_ttl(skb))
 		goto free_skb;
 
 	tvlv_buff = (unsigned char *)(skb->data + hdr_size);

-- 
2.47.3

