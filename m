Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81A98CC6B1A
	for <batman@archiver.kernel.org>; Wed, 14 Oct 2026 08:56:09 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id EA1BF83AB1
	for <batman@archiver.kernel.org>; Wed, 14 Oct 2026 10:56:07 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1791968167;
 b=y4w2Cd7OXcj+1mgXWJsfgUts9ABfFOcuKx1i096KuNV65Ajx455ULBneaisyDK8NgR6ii
 vc2z2K6kObNJSf4nNFfx2gYYCQ111ISr50qr9NXRROCHwqxc6DveLxGVe6Pn8ER5BkAvzu2
 2K/fRwZOB5yJWFO3CdIc656Z2sLTwV0=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1791968167; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=8lcm2dpGT6oVtVd8VDPobmuDADlvmU1E0BOQCnE71Gc=;
 b=LBtpqM494AyeYRh+i2V5t8IyYMfKJI2VmJwMYUB3sblto8F9pjjHbkO7Dp8jGQjbUU5ad
 vHuZ//Ma81BpApdPsP/W20Cnm+5OQxHEYAVeIfu9gEybC5pHsdSsVi5MbRpSudrGT7NAqfk
 Ta6oLW72znLb6s3WGaqjYpVojV5eI9k=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id E256284257
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 14 Oct 2026 10:54:15 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1791968065;
	b=3FzvZoB3XsdiLZnjmT2j2xLFS9TFzmp08IYxz4yMGt5CyMZ9HsjwrmUj3B9W479h8dLrdf
	s9NdN1FgNhF20uJNfwcf8n8GNAzOyCKf7wlEvZLfXHw6LCCFBes8qDSIaRR0OCdjZucnkS
	hm/5sUf0Jau/COy4TCOarYybzheOOC4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1791968065;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=8lcm2dpGT6oVtVd8VDPobmuDADlvmU1E0BOQCnE71Gc=;
	b=LTYGevXY2xiwiz53hrs7Kgk/540Jw3BG15CXays3iWEEXAGvLjnEmClbtS0U+LzibKJZv2
	om5y76supqrzvP3V6ERJjihWdJECikfk/Y8Jk+BgtFLOGmvQ+6us/AvYCauQ7HXwoviEi1
	kKWt4DLak1fR58sV9BY/n/xjkw8Us9k=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=HaBDZkWZ;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 8842020C4F;
	Wed, 14 Oct 2026 08:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1791968055;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8lcm2dpGT6oVtVd8VDPobmuDADlvmU1E0BOQCnE71Gc=;
	b=HaBDZkWZCI9IBHOhKjQL0WTCWjciVxkS+/MU535nPs3TxVB5ykg0LiUX4ji7gSOdCf3EOw
	aZGqWMGLhSRltwLGzYElFwAZAEuJ7Zr+LK8bpAEncTV4hU/gocK8SzWyEMc+jzpu5Zi/CJ
	gC/36TsJr2Qf6r2KJXmsXjQq4lpSujY=
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 14 Oct 2026 10:54:03 +0200
Subject: [PATCH batadv 2/4] batman-adv: always consume skb in
 batadv_forw_packet_alloc()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-skb-ownership-v1-2-4b83b9206b65@narfation.org>
References: <20261014-skb-ownership-v1-0-4b83b9206b65@narfation.org>
In-Reply-To: <20261014-skb-ownership-v1-0-4b83b9206b65@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3023; i=sven@narfation.org;
 h=from:subject:message-id; bh=EHtDBdZurigikShfFjrl0+nCP2Vr6Hb8wRpPja076fc=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFnnnfWLw+cyrSpcmbRym1+Y0pOc7uU54uqqx5fev9Yqc
 /tNmujqjlIWBjEuBlkxRZY9V/LPb2Z/K/952sejMHNYmUCGMHBxCsBEzrUzMkw76tPa/110ytlr
 Cnbt9cG/H/EcKeLZFn3KKf5lRe/ZoF0M/9OlZu1rfPzfj+Wk/Ip0qRQFhbcHb5090SQUEau0O+u
 vLy8A
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: I6VCGP3KVWMSOPHOQWWA2QSNZNOYYPVN
X-Message-ID-Hash: I6VCGP3KVWMSOPHOQWWA2QSNZNOYYPVN
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/I6VCGP3KVWMSOPHOQWWA2QSNZNOYYPVN/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

On success, batadv_forw_packet_alloc() stores the skb in the new
forw_packet, and batadv_forw_packet_free() frees it later. On failure
(queue full or out of memory), the skb was left for the caller to free.
Whether the caller still owned the skb therefore depended on the return
value.

Free the skb inside batadv_forw_packet_alloc() on failure, so the skb is
always consumed, and drop the kfree_skb() calls from both callers.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/bat_iv_ogm.c |  4 +---
 net/batman-adv/send.c       | 14 +++++++-------
 2 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index 85e99506..466619fd 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -647,10 +647,8 @@ static bool batadv_iv_ogm_aggregate_new(const unsigned char *packet_buff,
 	queue_left = own_packet ? NULL : &bat_priv->batman_queue_left;
 	forw_packet_aggr = batadv_forw_packet_alloc(if_incoming, if_outgoing,
 						    queue_left, bat_priv, skb);
-	if (!forw_packet_aggr) {
-		kfree_skb(skb);
+	if (!forw_packet_aggr)
 		return false;
-	}
 
 	forw_packet_aggr->skb->priority = TC_PRIO_CONTROL;
 	skb_reserve(forw_packet_aggr->skb, ETH_HLEN);
diff --git a/net/batman-adv/send.c b/net/batman-adv/send.c
index 929b6dd3..6672f817 100644
--- a/net/batman-adv/send.c
+++ b/net/batman-adv/send.c
@@ -481,6 +481,9 @@ void batadv_forw_packet_free(struct batadv_forw_packet *forw_packet,
  * (optional) if_incoming, if_outgoing and queue_left. If queue_left
  * is NULL then bat_priv is optional, too.
  *
+ * The skb is always consumed: on success, it is owned by the returned
+ * forwarding packet, on failure it is freed.
+ *
  * Return: An allocated forwarding packet on success, NULL otherwise.
  */
 struct batadv_forw_packet *
@@ -505,6 +508,7 @@ batadv_forw_packet_alloc(struct batadv_hard_iface *if_incoming,
 		batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
 			   "%s queue is full\n", qname);
 
+		kfree_skb(skb);
 		return NULL;
 	}
 
@@ -532,6 +536,7 @@ batadv_forw_packet_alloc(struct batadv_hard_iface *if_incoming,
 	if (queue_left)
 		atomic_inc(queue_left);
 
+	kfree_skb(skb);
 	return NULL;
 }
 
@@ -753,13 +758,13 @@ static int batadv_forw_bcast_packet_to_list(struct batadv_priv *bat_priv,
 
 	newskb = skb_clone(skb, GFP_ATOMIC);
 	if (!newskb)
-		goto err;
+		return NETDEV_TX_BUSY;
 
 	forw_packet = batadv_forw_packet_alloc(if_in, if_out,
 					       &bat_priv->bcast_queue_left,
 					       bat_priv, newskb);
 	if (!forw_packet)
-		goto err_packet_free;
+		return NETDEV_TX_BUSY;
 
 	forw_packet->own = own_packet;
 
@@ -770,11 +775,6 @@ static int batadv_forw_bcast_packet_to_list(struct batadv_priv *bat_priv,
 
 	batadv_forw_packet_bcast_queue(bat_priv, forw_packet, send_time);
 	return NETDEV_TX_OK;
-
-err_packet_free:
-	kfree_skb(newskb);
-err:
-	return NETDEV_TX_BUSY;
 }
 
 /**

-- 
2.47.3

