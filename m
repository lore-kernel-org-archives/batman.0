Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 448E5CD4F54
	for <batman-adv@archiver.kernel.org>; Tue, 19 May 2026 07:13:17 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id D195F807B0
	for <batman-adv@archiver.kernel.org>; Tue, 19 May 2026 09:13:15 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1779174795;
 b=0HuqYA4EcnGoF5DJEfNLFZZTLTCq80ZPMHer7uS441SWyjLGdf9kbUMcIFKWHJDXiEIm7
 /40FEqbw9sFnGXtuCW965L7iszIpYqgQykRYe3QRlUMgruMzuPzVdIKgcafk+3FzyMlJLzz
 ttvjzGaTBoCQTPCI06cj1KuXGrMVj50=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1779174795; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=0aVdgD8AWzUe/Fn3lEhMXjVpzRgEg7P1uPmihLhcDfA=;
 b=e/SFO8oLMEZRh6RQVIcIhF3P1S/B6KzgFv6/l2XwkdQAjiCdQ8y0UAhTW0nh9ejUHRRDf
 Fn7hDFTaAmWPUuS31PLP+Gi4mIX9T2OB5MXyrBEtt1XBK+pOUwH1F3YkdjTWTBBMA/i7cD9
 EBvJJ4mgL0xPapq0SESqLOzfz/YjDhw=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 0F04E80DE1
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 19 May 2026 09:04:54 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1779174294;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=0aVdgD8AWzUe/Fn3lEhMXjVpzRgEg7P1uPmihLhcDfA=;
	b=pt1PBDJcAAz0ivCxyJD/IxI9kO7XvFVtz4ahq+ccgSxflv0XvPKk4SAhAviWFxuCCo8R6o
	WzTLFF7OCqRm5bVXnoJCvLghFFiBz66BW0tfzIN003ZA64ZauQ8u9/ShVbSgrTmZJHHcSa
	P55VfmTNogdlXv4Kiargv9PbDhoJoB0=
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1779174294;
	b=A3F+CvclWOYp5ELePV8LdoonuMNfALFcyJHnr/PU1qtbEv2o3F7neRjmmxy3qMyvQSqgXy
	MbHAhz4xJ7QSo9fMBAULlfQd9qIuk+JU5H6UsbJ/8ItgshxMCiqw7TnFGoTkDCVebH717j
	765P5uOgs1hblnUFob1/85cE+j7lhBQ=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=0dBymKfw;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id AA0591FD9C;
	Tue, 19 May 2026 07:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1779174293;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0aVdgD8AWzUe/Fn3lEhMXjVpzRgEg7P1uPmihLhcDfA=;
	b=0dBymKfwEJncX0d2WuVxQi+1gyg/Wtn3+98AcOgkQOqtGmv1vPl/MO4cfNswBERhk+KICL
	G5AJKiF0PBYT91h1XpPqP1JhpxpLwnjT9IVXpA0x/ldT4WhAucOkiNGakAhhFgfrrxyX6Y
	2ErVlBxDrbUPARGIFmmFYSbn9y3IaSE=
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 19 May 2026 09:04:40 +0200
Subject: [PATCH batadv v2 5/7] batman-adv: replace non-atomic
 packet_size_max with (READ|WRITE)_ONCE
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-atomic-to-write-once-v2-5-1b643e847a56@narfation.org>
References: <20260519-atomic-to-write-once-v2-0-1b643e847a56@narfation.org>
In-Reply-To: <20260519-atomic-to-write-once-v2-0-1b643e847a56@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4177; i=sven@narfation.org;
 h=from:subject:message-id; bh=Qmp22g3bHUhfFNWImnExumUzWLyQTWdNgk/b5XF81XY=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFk83G33fivtrm2QnLJBhP98rXpoCePB/zlTws1P8N1Sc
 A1o6BDtKGVhEONikBVTZNlzJf/8Zva38p+nfTwKM4eVCWQIAxenAExkxiSG/4E+zB9EJ8wNYMpN
 m/rpjOvzRRf5dm/f3XHiyq/Ki7lWXC8ZGabOufpm8qk/jWW6p+aoL2cv+8DnP1Glzm2OJdMcm4w
 LS9gA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: JEBJE5KMSRJ76O4M7KOIJTXFPFNIDQCN
X-Message-ID-Hash: JEBJE5KMSRJ76O4M7KOIJTXFPFNIDQCN
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/JEBJE5KMSRJ76O4M7KOIJTXFPFNIDQCN/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

The maximum packet size of an meshif is only accessed as plain loads/stores
and does not require full atomic_t semantics. Convert to an native integer
and replace its users with READ_ONCE()/WRITE_ONCE() to avoid load/store
tearing.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/hard-interface.c    | 3 +--
 net/batman-adv/mesh-interface.c    | 2 +-
 net/batman-adv/translation-table.c | 6 +++---
 net/batman-adv/types.h             | 2 +-
 4 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index 8c64f06e..d9c85bc9 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -7,7 +7,6 @@
 #include "hard-interface.h"
 #include "main.h"
 
-#include <linux/atomic.h>
 #include <linux/byteorder/generic.h>
 #include <linux/compiler.h>
 #include <linux/container_of.h>
@@ -611,7 +610,7 @@ int batadv_hardif_min_mtu(struct net_device *mesh_iface)
 	 * overhead). For example, this value is used by TT to compute the
 	 * maximum local table size
 	 */
-	atomic_set(&bat_priv->packet_size_max, min_mtu);
+	WRITE_ONCE(bat_priv->packet_size_max, min_mtu);
 
 	/* the real mesh-interface MTU is computed by removing the payload
 	 * overhead from the maximum amount of bytes that was just computed.
diff --git a/net/batman-adv/mesh-interface.c b/net/batman-adv/mesh-interface.c
index 9c53552a..232c7b2c 100644
--- a/net/batman-adv/mesh-interface.c
+++ b/net/batman-adv/mesh-interface.c
@@ -777,7 +777,7 @@ static int batadv_meshif_init_late(struct net_device *dev)
 	WRITE_ONCE(bat_priv->log_level, 0);
 #endif
 	WRITE_ONCE(bat_priv->fragmentation, 1);
-	atomic_set(&bat_priv->packet_size_max, BATADV_MAX_MTU);
+	WRITE_ONCE(bat_priv->packet_size_max, BATADV_MAX_MTU);
 	atomic_set(&bat_priv->bcast_queue_left, BATADV_BCAST_QUEUE_LEN);
 	atomic_set(&bat_priv->batman_queue_left, BATADV_BATMAN_QUEUE_LEN);
 
diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index bfd0e720..382a5826 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -688,7 +688,7 @@ bool batadv_tt_local_add(struct net_device *mesh_iface, const u8 *addr,
 	/* Ignore the client if we cannot send it in a full table response. */
 	table_size = batadv_tt_local_table_transmit_size(bat_priv);
 	table_size += batadv_tt_len(1);
-	packet_size_max = atomic_read(&bat_priv->packet_size_max);
+	packet_size_max = READ_ONCE(bat_priv->packet_size_max);
 	if (table_size > packet_size_max) {
 		net_ratelimited_function(batadv_info, mesh_iface,
 					 "Local translation table size (%i) exceeds maximum packet size (%i); Ignoring new local tt entry: %pM\n",
@@ -3108,7 +3108,7 @@ static bool batadv_send_other_tt_response(struct batadv_priv *bat_priv,
 
 	/* Don't send the response, if larger than fragmented packet. */
 	tt_len = sizeof(struct batadv_unicast_tvlv_packet) + tvlv_len;
-	if (tt_len > atomic_read(&bat_priv->packet_size_max)) {
+	if (tt_len > READ_ONCE(bat_priv->packet_size_max)) {
 		net_ratelimited_function(batadv_info, bat_priv->mesh_iface,
 					 "Ignoring TT_REQUEST from %pM; Response size exceeds max packet size.\n",
 					 res_dst_orig_node->orig);
@@ -3971,7 +3971,7 @@ bool batadv_tt_add_temporary_global_entry(struct batadv_priv *bat_priv,
 void batadv_tt_local_resize_to_mtu(struct net_device *mesh_iface)
 {
 	struct batadv_priv *bat_priv = netdev_priv(mesh_iface);
-	int packet_size_max = atomic_read(&bat_priv->packet_size_max);
+	int packet_size_max = READ_ONCE(bat_priv->packet_size_max);
 	int table_size, timeout = BATADV_TT_LOCAL_TIMEOUT / 2;
 	bool reduced = false;
 
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index d2dea899..d483abb8 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -1543,7 +1543,7 @@ struct batadv_priv {
 	 *  multiple fragmented skbs or a single frame if fragmentation is
 	 *  disabled
 	 */
-	atomic_t packet_size_max;
+	u32 packet_size_max;
 
 	/**
 	 * @frag_seqno: incremental counter to identify chains of egress

-- 
2.47.3

