Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BAD7CD4F21
	for <batman@archiver.kernel.org>; Tue, 12 May 2026 19:57:50 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id B7D4C85D42
	for <batman@archiver.kernel.org>; Tue, 12 May 2026 21:57:48 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1778615868;
 b=w8Fa+kswGnwyE23lyqNnxdtwAhw6psOXT8613Cp21yaPJx3kPr2OHrBUrdj5dPzDjSu0V
 uMu8nUjGDeCjYguSrgJvhga4VQWUOEgcBm2GzP7UIyf5nfi1Kc2NcOlxg3Ei+WHc5vvGpbC
 xC20Rwhe80GyZdCxhM0fKmhqR/2bOBo=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1778615868; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=cV16BmC3byqe2opi823nDWCJOs77mYQLBSDmwbK+iaw=;
 b=Cp624HcAQKzfFCS9kjK3Mv2dpCfq7aheiOv1Of8H8IIACqtgdwOimEz4sncHO669mnerY
 ZwF0jR9H71tf9BRIfcLFlj/XNz2iv1AJl5a3+4ZUgAGlwgTe2ZD0bCSi65ICi8iHQYCFRlb
 cl/59zEgOwumPQSMJEYcsJ2gKSkTUuY=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id AB79A85661
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 12 May 2026 21:53:41 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1778615621;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=cV16BmC3byqe2opi823nDWCJOs77mYQLBSDmwbK+iaw=;
	b=EX71OWwHjFSBsFYfbkFmStEWlsWAJjS59EYNz2b7yEfd6vpvFI9t/SXQ5z9kAw/8SGUBRi
	mSa8H1pY/kaneE0ifH7iao6OuLXHQucrYD15PGXWYA50zoNPdMybsQpSR1ZC56SLwVwmON
	ocECyBdlRvXmFQ6dCtI1qzFuwLp+1eo=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=i9P5LIsj;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1778615621;
	b=Y55Y/vGix/1ec1ryGcZyDjIbSm2rM7Vy37pDeVuVJjVjXsXCDBzB2vn+2H8SMAFBkGuMlm
	gDoczL01S4bks8X6hj/Eety962s7ty2/JsG2juYRv85V3JXp1H6P55A3o0vRUBdjMnq0ar
	Min3M+gC0lWq/lVkUvYPphsLcknOdYM=
Received: by dvalin.narfation.org (Postfix) id 397F81FD98;
	Tue, 12 May 2026 19:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1778615621;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cV16BmC3byqe2opi823nDWCJOs77mYQLBSDmwbK+iaw=;
	b=i9P5LIsjCsYJ5uNVnycAOvJkds9eXzIY3nRB6XK0/213hadHWEyeFJ4ByY155eOShCU57F
	VW2NGcChVHHhlxlWCQsV1ySEQ+Z3YLdm/xk5HP3VUNaNK+0sBPJWJV6CZknx3CBobO6UmM
	vwZEB8g9D5z1tuvUWd4akm/e/k9BiP0=
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 12 May 2026 21:53:10 +0200
Subject: [PATCH batadv 5/7] batman-adv: replace non-atomic packet_size_max
 with (READ|WRITE)_ONCE
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-atomic-to-write-once-v1-5-76a4272fac0d@narfation.org>
References: <20260512-atomic-to-write-once-v1-0-76a4272fac0d@narfation.org>
In-Reply-To: <20260512-atomic-to-write-once-v1-0-76a4272fac0d@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4168; i=sven@narfation.org;
 h=from:subject:message-id; bh=I8ewlfwM1Ps5QLYi/HpAqDB1aJWSyjsmFFxAJ7JJkQk=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFnMrSpnFP4/urHblm/dUwar6JwJpxZevh1yNHTjC+N/T
 8UiTu0o6ihlYRDjYpAVU2TZcyX//Gb2t/Kfp308CjOHlQlkCAMXpwBM5P5URobvFu9OurBwZs09
 WLeoQJTbYVYF84YPr57ZNLxRZKmxbfjPyPDO7vwspn1Fzte2vPwm3/VM712ZmYG+W5yu5p9SbeX
 kTE4A
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: UG6WYADQ4CIUFXWMGAAKKZ7P6JEROBFA
X-Message-ID-Hash: UG6WYADQ4CIUFXWMGAAKKZ7P6JEROBFA
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/UG6WYADQ4CIUFXWMGAAKKZ7P6JEROBFA/>
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
index fb90779d..6a2366b7 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -7,7 +7,6 @@
 #include "hard-interface.h"
 #include "main.h"
 
-#include <linux/atomic.h>
 #include <linux/bug.h>
 #include <linux/byteorder/generic.h>
 #include <linux/compiler.h>
@@ -612,7 +611,7 @@ int batadv_hardif_min_mtu(struct net_device *mesh_iface)
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
index 7df5490d..e5bf5a43 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -689,7 +689,7 @@ bool batadv_tt_local_add(struct net_device *mesh_iface, const u8 *addr,
 	/* Ignore the client if we cannot send it in a full table response. */
 	table_size = batadv_tt_local_table_transmit_size(bat_priv);
 	table_size += batadv_tt_len(1);
-	packet_size_max = atomic_read(&bat_priv->packet_size_max);
+	packet_size_max = READ_ONCE(bat_priv->packet_size_max);
 	if (table_size > packet_size_max) {
 		net_ratelimited_function(batadv_info, mesh_iface,
 					 "Local translation table size (%i) exceeds maximum packet size (%i); Ignoring new local tt entry: %pM\n",
@@ -3106,7 +3106,7 @@ static bool batadv_send_other_tt_response(struct batadv_priv *bat_priv,
 
 	/* Don't send the response, if larger than fragmented packet. */
 	tt_len = sizeof(struct batadv_unicast_tvlv_packet) + tvlv_len;
-	if (tt_len > atomic_read(&bat_priv->packet_size_max)) {
+	if (tt_len > READ_ONCE(bat_priv->packet_size_max)) {
 		net_ratelimited_function(batadv_info, bat_priv->mesh_iface,
 					 "Ignoring TT_REQUEST from %pM; Response size exceeds max packet size.\n",
 					 res_dst_orig_node->orig);
@@ -3969,7 +3969,7 @@ bool batadv_tt_add_temporary_global_entry(struct batadv_priv *bat_priv,
 void batadv_tt_local_resize_to_mtu(struct net_device *mesh_iface)
 {
 	struct batadv_priv *bat_priv = netdev_priv(mesh_iface);
-	int packet_size_max = atomic_read(&bat_priv->packet_size_max);
+	int packet_size_max = READ_ONCE(bat_priv->packet_size_max);
 	int table_size, timeout = BATADV_TT_LOCAL_TIMEOUT / 2;
 	bool reduced = false;
 
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index fcf879ce..913273ce 100644
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

