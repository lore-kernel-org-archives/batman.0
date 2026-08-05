Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD60EC55174
	for <batman-adv@archiver.kernel.org>; Wed,  5 Aug 2026 14:36:18 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 3644884208
	for <batman-adv@archiver.kernel.org>; Wed, 05 Aug 2026 16:36:17 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1785940577;
 b=uZV1tNjUgnsJGhlmQySC0+Itd+uUQLLuQkvJf7wpaN+mWbGVgWhySF6cT1mUw+mmDe6ZS
 4nkUrpjj3PASsMI5yhiXLZLHIf+7aW2ur8uykaTgaGqCIVOZfdZ/pwAjf1REf2IoQ7B+bQ3
 /1+dlD4tOOt8J05ty4Ob6DpXhoomNwI=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1785940577; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=IiVJdhIDEIkLfeAXrkfwyUM/mZiaFSdBYWa9q++T2OU=;
 b=x4gkzcZfESAFKp4cgRnjzQCzYXqJ9TFM/A4vpoMbuvdoVqTRSsbpkDgRDqKZwk+n6KAH+
 hL+J9BdYOZpbp/Gx2nL/X6y2GHHe82HimEWy9NwMZHxWAnrUT91hdBkdy6/S4LHoAWHm+/Z
 ay6U5qK1h8iSs0Gi4pLGYT+SQG4DvD0=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de
 [IPv6:2a01:4f8:c17:e8c0::1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 7E59F841BB
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 05 Aug 2026 16:32:11 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1785940331;
	b=C9R/d3X4gcXzvk0ArmaAQop+hT3d0ZFGPvCq6s0DNEScym8BznQRjFIAy8v66Zj00uWe/8
	mbiDtz5Z+NfZynclLNRRhQ8lQOjJ3Kze5TfmNTkbLPaz8vJwtRx3Xt/prikuKsY88qyrVB
	ZguFka0RQYwnJybanV9lVdzLaUya3pw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1785940331;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=IiVJdhIDEIkLfeAXrkfwyUM/mZiaFSdBYWa9q++T2OU=;
	b=UxmkJnJe17gPj6/YSmaJQd5qelrN2+4Df8/lHStJ1rzWj5Br7cwzcax0WMfrcWt0varAR2
	6aqw4TILqFuX7gzFceJY9r/+SOgESPl/lDt+sxgovb6FaEYwKdqgbSb3aEMu673lh2015E
	P2Dcjjzor0/BRsLcDy5XsDkc7nRqY7g=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=oYGVc2c9;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 2a01:4f8:c17:e8c0::1 as permitted sender)
 smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
Received: from kero.packetmixer.de
 (p200300c5970b56d88Eebac4310d100Aa.dip0.t-ipconnect.de
 [IPv6:2003:c5:970b:56d8:8eeb:ac43:10d1:aa])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id 3738EFA26D;
	Wed, 05 Aug 2026 16:32:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1785940331;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IiVJdhIDEIkLfeAXrkfwyUM/mZiaFSdBYWa9q++T2OU=;
	b=oYGVc2c9UfF2k9mMuPpD0enC45RJI9ukra8sOPSNGxCw8XfbhhNeNW6smg9EFNklxpvK0p
	tBIPz6LxBxrby2jKL+Tgifk6wgvutGIyZ5XnaqThSNcAcyStGzDhTiYqAXKykZkks3tWfx
	G5jULUH2b4njeQNlGsQwWGd5dA1MytfmDqSktbit/kbQJdGDvBzeUG8mocpHQ5TC1OrGzq
	pWEFuqkiXt+N0HqYlwpP29tnjybIEd/ytOjZf5paWmf6Hk6vDwKNlATn9E/EPivUVNonLb
	I/kk7FFZ1K2I/lA5Mh6g9bcr9mCJe3YMj+9K2T8NuilEtkPaNEUZVXAtuKRYVQ==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Sven Eckelmann <sven@narfation.org>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net-next 09/10] batman-adv: correct NET_RX_* NET_XMIT_*
 confusion
Date: Wed,  5 Aug 2026 16:27:23 +0200
Message-ID: <20260805143200.722098-10-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260805143200.722098-1-sw@simonwunderlich.de>
References: <20260805143200.722098-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: RTJBKTSIQMEQZ4LJVNPOPL6VRZIBGBIV
X-Message-ID-Hash: RTJBKTSIQMEQZ4LJVNPOPL6VRZIBGBIV
X-MailFrom: sw@simonwunderlich.de
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/RTJBKTSIQMEQZ4LJVNPOPL6VRZIBGBIV/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Sven Eckelmann <sven@narfation.org>

batadv_recv_icmp_ttl_exceeded() is a receive function. It must therefore
return NET_RX_* and not NET_XMIT_*. And batadv_send_skb_to_orig() is an
xmit function and is returning NET_XMIT_*.

This doesn't change the behavior because both NET_RX_SUCCESS and
NET_RX_SUCCESS are using the same underlying value (0).

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/routing.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/batman-adv/routing.c b/net/batman-adv/routing.c
index af0543a4d346c..6442f5d0cc937 100644
--- a/net/batman-adv/routing.c
+++ b/net/batman-adv/routing.c
@@ -341,7 +341,7 @@ static int batadv_recv_my_icmp_packet(struct batadv_priv *bat_priv,
  * For traceroute-style ICMP echo requests, send a TTL exceeded reply back to
  * the source. Other ICMP types are simply dropped.
  *
- * Return: NET_XMIT_SUCCESS if the reply was queued, NET_RX_DROP otherwise
+ * Return: NET_RX_SUCCESS if the reply was queued, NET_RX_DROP otherwise
  */
 static int batadv_recv_icmp_ttl_exceeded(struct batadv_priv *bat_priv,
 					 struct sk_buff *skb)
@@ -382,8 +382,8 @@ static int batadv_recv_icmp_ttl_exceeded(struct batadv_priv *bat_priv,
 	icmp_packet->ttl = BATADV_TTL;
 
 	res = batadv_send_skb_to_orig(skb, orig_node, NULL);
-	if (res == NET_RX_SUCCESS)
-		ret = NET_XMIT_SUCCESS;
+	if (res == NET_XMIT_SUCCESS)
+		ret = NET_RX_SUCCESS;
 
 	/* skb was consumed */
 	skb = NULL;
-- 
2.47.3

