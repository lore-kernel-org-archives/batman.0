Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2DA7C53219
	for <batman@archiver.kernel.org>; Tue, 28 Jul 2026 13:44:39 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 2E0E78418E
	for <batman@archiver.kernel.org>; Tue, 28 Jul 2026 15:44:38 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1785246278;
 b=2KQNr2bkWid3M/eP/RqucCHzhegsX1UPK0IGWg/0M1OhVocjTgaLsdLD22eya2Kse4N0D
 RCiljGuViQS+NGN+I0p0pFNxRbC/FGBxqPFtR7hjU6o0hELfkvfhHdc147Lk9vaAloSLtyA
 v0L2zgutVgrYU/7c5hqWR75G2e+m7hM=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1785246278; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=SMHpUeEpOQHgX43yYtxGHEC46IOieRNzzQbS8u0iOlk=;
 b=ceKBL6/PQdVhHjHCKLWBUXDb77AbBC/DnGccvk1OHS8gBAhYk9IiZYXlL05Rpu3z3618l
 PGVpDqe3utPEitauo89KTk/wbP8qBcUBYlgtLWi6zw92UbW7O715nQ2Kun/3iwwc1xVMCKI
 4KCh7TKT9wnofABjqet/m7ZqPaI8cNM=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de
 [IPv6:2a01:4f8:c17:e8c0::1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 0F2F984683
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 28 Jul 2026 15:39:25 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1785245965;
	b=MX8bSVxsl92BTU5fX8llYw2bSaUCOpr840jCUgHxUiXKWmPYgC1f8FVl1mJ0y3dRL0g6yQ
	mktjqxR8jqk0GGDZznrdx4uEFXwrQ3cPnlg3FtH+vr5fo8G29kMAuP9L381TiF1mdST2yo
	CanThU/4QZDF2l6Y+zYQdRG+yBMB3cc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1785245965;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=SMHpUeEpOQHgX43yYtxGHEC46IOieRNzzQbS8u0iOlk=;
	b=DSyIbENPn41b1ZGHZP8abXBMUsWlHo6Yeg5vDf34vyoWf1T1PBYUSHuMsiQTuPBKVVtmCw
	mVGatRGoX9+pZM48oH9UQDGETom1bhC/KTsDz465fiXOZUBTribg08mJ+acpFjkLiEBKSb
	Th1pIWqejY3smuAj3uhxaDjLE+A10qU=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=GRoo2jn7;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 2a01:4f8:c17:e8c0::1 as permitted sender)
 smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
Received: from kero.packetmixer.de
 (p200300C59717EAd808F168c97E5563A8.dip0.t-ipconnect.de
 [IPv6:2003:c5:9717:ead8:8f1:68c9:7e55:63a8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id B2D32FA129;
	Tue, 28 Jul 2026 15:39:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1785245964;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SMHpUeEpOQHgX43yYtxGHEC46IOieRNzzQbS8u0iOlk=;
	b=GRoo2jn7JLs0g33QjIk5i2gjtt+h2rJwlG35BUNI9USJx6GhBZqGe4OChaykObc6lYP892
	+U45rRGRvIxmZl92xAFpC3nC1aUi7wGc/QInTBfaD1mSq3AvHQdrDWdNICdYPkF5nEqO4k
	RoAgII+gDqxU/nyawAPegj3k6Rc1ztqGi9r5vkBoEAflmRuB5dGxdksqojimhcxG/6qOcU
	N+f9ucYFVDWQMbLHLg8i64RJx1c4Elw4vLyLaq7l+/oAzzcsnRoM+loWWrK1lqNFlXsU8p
	9JXk5ojJFZN2VQ187KjyAlM3gbQivqmFwbfQ0FSR+BkczoxI4f6oYAGA1SgTzQ==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Sven Eckelmann <sven@narfation.org>,
	stable@vger.kernel.org,
	Sashiko <sashiko-bot@kernel.org>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net-next 07/15] batman-adv: mcast: linearize skbuff for packet
 generation
Date: Tue, 28 Jul 2026 15:39:10 +0200
Message-ID: <20260728133918.643267-8-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260728133918.643267-1-sw@simonwunderlich.de>
References: <20260728133918.643267-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: BAX6UMS2TTIWZDTZUG3LR7CJAOCWHCO5
X-Message-ID-Hash: BAX6UMS2TTIWZDTZUG3LR7CJAOCWHCO5
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/BAX6UMS2TTIWZDTZUG3LR7CJAOCWHCO5/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Sven Eckelmann <sven@narfation.org>

batadv_mcast_forw_packet() and batadv_mcast_forw_packet() is not only
called by the unsharing+linearizing batadv_recv_mcast_packet() handler.
When it is called by batadv_mcast_forw_mcsend() then it will be unshared
but not linearized. The SKB_LINEAR_ASSERT() can therefore cause a fatal
BUG().

The linearization should happen during the expansion of the head because
the call chain because the scrape function can be hit already during the
initial batadv_mcast_forw_mode() selection code:

* batadv_interface_tx
* batadv_mcast_forw_mode
* batadv_mcast_forw_mode_by_count()
* batadv_mcast_forw_push()
  -> calls batadv_mcast_forw_expand_head() before everything else
* batadv_mcast_forw_push_tvlvs()
* batadv_mcast_forw_push_dests()
* batadv_mcast_forw_push_adjust_padding()
* batadv_mcast_forw_scrape()

Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-bot@kernel.org>
Fixes: 07afe1ba288c ("batman-adv: mcast: implement multicast packet reception and forwarding")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/multicast_forw.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/batman-adv/multicast_forw.c b/net/batman-adv/multicast_forw.c
index 240ed7380cb0f..c99579dc1ca98 100644
--- a/net/batman-adv/multicast_forw.c
+++ b/net/batman-adv/multicast_forw.c
@@ -1103,6 +1103,10 @@ static int batadv_mcast_forw_expand_head(struct batadv_priv *bat_priv,
 	if (skb_cow(skb, hdr_size) < 0)
 		return -ENOMEM;
 
+	/* batadv_mcast_forw_scrape() + batadv_mcast_forw_packet() require linearized skb */
+	if (skb_linearize(skb) < 0)
+		return -ENOMEM;
+
 	return 0;
 }
 
-- 
2.47.3

