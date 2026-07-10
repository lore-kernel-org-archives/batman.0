Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E9ECC43458
	for <batman-adv@archiver.kernel.org>; Fri, 10 Jul 2026 20:04:14 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 9D9F483F87
	for <batman-adv@archiver.kernel.org>; Fri, 10 Jul 2026 22:04:12 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1783713852;
 b=yXpiDE3Gxy1+vlPzlzvqgpUvjON4mYpkgQBcT7vB39HFszL2iDxtsY5dSeqUNJBNmB5Tw
 MVz+8cNYIx+Fnl2U7TUnfuNbubbGTevGHgytgP8G9n/L+886l13HhR067ZPlvXXCiz69zCn
 l3oORQQxNgKFBHfZBuDYiLfrvhl9RyA=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1783713852; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=+Pd7siZNQttYgtwNfylG/g6MOvey4Wt0dvkyGMo0LBI=;
 b=jKxzJPZ8qOkU85YmT6joHXfdvle7+cd5AkjPi+FsDrJUZU9VNjh6Qh76KvR55QlrtkqQM
 A0JHPxAVW4fzHAKxqo+5YHJDdr+tWuta2dxixJ7GC4eHpVyKLMkWymC1tXamOGPlBJ8Xd5m
 4VvnFybt+EjcGqErvFxti5gOIYr8S0w=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 5071A812E1
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 10 Jul 2026 22:01:26 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1783713691;
	b=ciy7r3N3NZQZbJQjn0umrglokd29EvFUvP46iPpXVDAK9Ett8HK0UVMcKdgrd4Gh7+WCgQ
	hgs1MO8kkGel7DmLVtBhmRTj1QLnFcH7D6hvsdgbYaNE+szVnqUOQ7qDdIMgDRlnVDmVhF
	L+r5V8ikeRUrWEqBMjVLK1wh+eLrlN4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1783713691;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=+Pd7siZNQttYgtwNfylG/g6MOvey4Wt0dvkyGMo0LBI=;
	b=MIvzPH4ysUQj5kG9CSUVFw2GM0QgbsLLT7eBzFMw91rhRcdTa4SS1qYfLnl2dbxmpLl60/
	4MWEor3C00V3NQpEPzSMXl6J+TcHo7oV/RSLHXodLH82GP9cJR0lHB/zQZ9CGeiQOcuCfD
	877Ry/RsUL5U6Da15mnA3ezEGJTLX/8=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b="uNo/7j2I";
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 552E620560;
	Fri, 10 Jul 2026 20:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1783713684;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+Pd7siZNQttYgtwNfylG/g6MOvey4Wt0dvkyGMo0LBI=;
	b=uNo/7j2IhnXLiZJUq1335haNd3Zj+vFRVn5ORe4ulnusMnYpQRXKrC9p1vKfuvyZwPpI4p
	kNhdI1iPqp2lshgHkU5v4xQQB0OWfGyZsS1iU+ZcfTgR0RviL1H7fj/k9zzEPwUQUVHcPn
	VKqyDptDde+bSOcepb9BERFlTxhQyEo=
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 10 Jul 2026 22:01:15 +0200
Subject: [PATCH batadv v2 1/3] batman-adv: fix TX priority extraction for
 BATADV_FORW_MCAST
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: 
 <20260710-mcast-header-generation-bugs-v2-1-06cd83c0f534@narfation.org>
References: 
 <20260710-mcast-header-generation-bugs-v2-0-06cd83c0f534@narfation.org>
In-Reply-To: 
 <20260710-mcast-header-generation-bugs-v2-0-06cd83c0f534@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1901; i=sven@narfation.org;
 h=from:subject:message-id; bh=2cUZAvVE4i4/sPDy3k4WENqil0KhFCKgAZXH4XOaXuQ=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFmB/n0GjMxbmXdf00mU39j4fMfs17tm5G/nnBc4V35j4
 t+1OpVRHaUsDGJcDLJiiix7ruSf38z+Vv7ztI9HYeawMoEMYeDiFICJuF1lZPh5RlNq42apP1ly
 GuzfDX5a8x3lfL/CrtXpu9uGE1aX7v5hZJjvU7V7zw+jymrJj4qb/bISZ/7fYvlU2aZIyzIubIX
 efFYA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: FRDL3ITLFN6DI52Q5YUT7REFCXJJUEX6
X-Message-ID-Hash: FRDL3ITLFN6DI52Q5YUT7REFCXJJUEX6
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/FRDL3ITLFN6DI52Q5YUT7REFCXJJUEX6/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

batadv_mcast_forw_mode_by_count() pushs the skb->data for BATADV_FORW_MCAST
forwarding via batadv_mcast_forw_mcsend(). But the
batadv_skb_set_priority() expects the ethernet header directly before
(skb->data + offset). With the moved skb->data, just some random data would
be accessed to get the priority data.

Move the batadv_skb_set_priority() before the decision about the handling
multicast packets and potential header modifications.

Fixes: be9b0169c840 ("batman-adv: mcast: implement multicast packet generation")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/mesh-interface.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/mesh-interface.c b/net/batman-adv/mesh-interface.c
index b2c8febe..20582fe0 100644
--- a/net/batman-adv/mesh-interface.c
+++ b/net/batman-adv/mesh-interface.c
@@ -300,6 +300,8 @@ static netdev_tx_t batadv_interface_tx(struct sk_buff *skb,
 	if (batadv_compare_eth(ethhdr->h_dest, ectp_addr))
 		goto dropped;
 
+	batadv_skb_set_priority(skb, 0);
+
 	gw_mode = READ_ONCE(bat_priv->gw.mode);
 	if (is_multicast_ether_addr(ethhdr->h_dest)) {
 		/* if gw mode is off, broadcast every packet */
@@ -333,6 +335,9 @@ static netdev_tx_t batadv_interface_tx(struct sk_buff *skb,
 
 send:
 		if (do_bcast && !is_broadcast_ether_addr(ethhdr->h_dest)) {
+			/* WARNING batadv_mcast_forw_mode might add more headers
+			 * in front of the skb. and might even reallocate the skb
+			 */
 			forw_mode = batadv_mcast_forw_mode(bat_priv, skb, vid,
 							   &mcast_is_routable);
 			switch (forw_mode) {
@@ -350,8 +355,6 @@ static netdev_tx_t batadv_interface_tx(struct sk_buff *skb,
 		}
 	}
 
-	batadv_skb_set_priority(skb, 0);
-
 	/* ethernet packet should be broadcasted */
 	if (do_bcast) {
 		primary_if = batadv_primary_if_get_selected(bat_priv);

-- 
2.47.3

