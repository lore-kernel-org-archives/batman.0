Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D86A2CC6B34
	for <batman@archiver.kernel.org>; Thu, 15 Oct 2026 06:32:44 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 430E68462F
	for <batman@archiver.kernel.org>; Thu, 15 Oct 2026 08:32:43 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1792045963;
 b=GEilUBAdG94JU1+stx3lwEcFAbdSndhNgyUhDevIsYlX9RjmuBYAcixSGp65ssAgvvOMn
 gEZOoeuEN9t01MgTEXvM7OA++LFZ+0chjl1ekDN9/qvWs1CsriGlhSCExyC2k0Guf+kYuxM
 VPb8cd2l7eWPfzJARinRFKRcKAqLv/8=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1792045963; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=8lcm2dpGT6oVtVd8VDPobmuDADlvmU1E0BOQCnE71Gc=;
 b=cWLhzqMZHXBaqsbu6TciOEWbKqP258oF+uzMYxsRHDJVypTSEBP67JYDHnhDsfsfSoESL
 OWaoGCqls22GrLxvhaau7OHQjnpIpRJv6MZbgkXz1O5LJQi1wpOJ9npCq9d4dps8eupSbC6
 aGA2KEQ/zPyLHV7uIxFNsc5tNsPJVa8=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 8686F81E9F
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 15 Oct 2026 08:31:26 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1792045896;
	b=ey91h1YiA+VyY+Ikgn/L0K+NKyb5IeizcEdlM5RF7Cgjaxx0T8zFgnzt8azUS8qlYorzcG
	E96jXtqBss7+j4d7boVFuh0BqdPMJnS++eQICVhxfQ1510nEcvt+CIu8PZaOLHPBkM+JzK
	U89LFuQEhSvwJR0h7j9fcCASJlsKtjQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1792045896;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=8lcm2dpGT6oVtVd8VDPobmuDADlvmU1E0BOQCnE71Gc=;
	b=YBzKIzoaGUvmthAl4phBy2euflGSYkHKqPMdzIbq0YHpKpHEGL2C/AgpEE4UyAx4/iKVdK
	Ndt3jF8xqmiE8B6Q2QcU8j0wpmQWwtyHXzN/O/w/JXub4wf3iU6g9LXjRvTXHiaFp2NSMy
	GfRGJsaWy+DemEgGj01RjhjfzIZCNbM=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=o0nNOWp5;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 2D19720EF2;
	Thu, 15 Oct 2026 06:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1792045886;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8lcm2dpGT6oVtVd8VDPobmuDADlvmU1E0BOQCnE71Gc=;
	b=o0nNOWp5RU9ft4Xu1bCW/NrikfN/S90JsBlaJDC1XOX7+BKBKMDaLRbVICSJX79/w1qG/9
	8CkSAyzu5TzMdE6HtGBQWZo7K3X7cv7sAuL2ql5657Obwp0k0I13uv61WHHtccPWcdKg24
	GM4lXeie7LfTT++DaOaWn/JXSCgwE5Y=
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 15 Oct 2026 08:31:02 +0200
Subject: [PATCH RESEND batadv 2/4] batman-adv: always consume skb in
 batadv_forw_packet_alloc()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-skb-ownership-v1-2-8bb03bba6701@narfation.org>
References: <20261015-skb-ownership-v1-0-8bb03bba6701@narfation.org>
In-Reply-To: <20261015-skb-ownership-v1-0-8bb03bba6701@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3023; i=sven@narfation.org;
 h=from:subject:message-id; bh=EHtDBdZurigikShfFjrl0+nCP2Vr6Hb8wRpPja076fc=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFkXinXCfxgEcX78f16iU1LbMXF35wTbf4nxqgdzRfmb3
 n1bY6DYUcrCIMbFICumyLLnSv75zexv5T9P+3gUZg4rE8gQBi5OAZhI0XeG/7GluyWmCm6Zw/tA
 2njrsbBpJiET3Ve+Y128Skw03fvbKRuG/2F+B+23cr2dP8v/bmaDwPYC4zl6TnPahOfu9r5ZfXF
 iLgsA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: G5T5C7P7WJOIX3GUP2API25IQX4SXFOW
X-Message-ID-Hash: G5T5C7P7WJOIX3GUP2API25IQX4SXFOW
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/G5T5C7P7WJOIX3GUP2API25IQX4SXFOW/>
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

