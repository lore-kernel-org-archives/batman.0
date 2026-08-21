Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D895C5DF7D
	for <batman-adv@archiver.kernel.org>; Fri, 21 Aug 2026 09:51:32 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id ECEC7812A1
	for <batman-adv@archiver.kernel.org>; Fri, 21 Aug 2026 11:51:30 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1787305890;
 b=HnOqp752j7tmGyyizZgWAjCtSDr27SPB/0NeJp0uHhwElsnMpD81Z0PpMy57T+nZBgOfr
 bFIbU4oQv13OU+pceT0YBpWJJ9nz/WzkUMICJJFc7/zbWUlQbJcIrB7IURjGlllD1oGNuBa
 DvNhSp8UreX8j6/aDht3ffavQsVljIA=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1787305890; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=fG78UxU6xTQ7UwE1I43P2EtSWWeuhI9N9UOuRX8oqeA=;
 b=vEElhKoByFwDpgG1NvhkixG8Fm0xN12H77IfNYyihQk58Et1/BRfF/XZtSuZafvlOfyYf
 Jv9sERFBGDCranavK3zypTUgFL5UGggV/OnhCE7MZx5mDQP9MFtFdvxB8Zcm3iyyFikA2As
 ECN4xIqu/bncn9K9H3OU1yq16AM8o1A=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id D556A8125E
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 21 Aug 2026 11:48:21 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1787305701;
	b=yqGe4SFxKrJmlD5UXtFo0lj1gN5LBUVI9i7MPfBbAVooRORTLPjQ7NkeoWwmP4pFJKmhWy
	Y43EQrFaoPQPFas1zkflBYnTO9TEv1rCuo/YV63EMYBXabr4ZHejrs9XihyAQsRv4J2GBd
	U3araG+GgymAvla0oYlgPVTd86OeCLI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1787305701;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=fG78UxU6xTQ7UwE1I43P2EtSWWeuhI9N9UOuRX8oqeA=;
	b=RzJXPfQx+E/IfKPZGqGmJheOJU0BIyU62OapHZmhVnuzK66OWWLH/meuIBEcKRvq6I35UB
	oG6Rw6MzKC9a84TsK9jJu+OGCnoXM9jFHH19WjT5B6DcQSSkEAx38i5DoxDeIS5BE63mU4
	MrU6GGpGCWDw6yCH3QI9Fwy3jqClK/w=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=mDalJkDI;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 23.88.38.48 as permitted sender) smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
Received: from kero.packetmixer.de
 (p200300c59714fCD8ec8C87C354003FEd.dip0.t-ipconnect.de
 [IPv6:2003:c5:9714:fcd8:ec8c:87c3:5400:3fed])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with UTF8SMTPSA id 90A87FA12A;
	Fri, 21 Aug 2026 11:48:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1787305701;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fG78UxU6xTQ7UwE1I43P2EtSWWeuhI9N9UOuRX8oqeA=;
	b=mDalJkDIUKyYN62BOeZ3cKQYabkLSqRpxO0Hoxcvhe2j/PhEPhzMzFA+MFDvRxWRxvldWb
	IzDBHMguJBe75FvbjIQ4pD3vwpm885jwvpUpnc8Jy2UHtwKqBf0HRBvXERqiIV7Dod5m2U
	KNtIgE926/QGSpvfpKByzFHEoxc67y+liAUiDaLTbSdinX2qPkVwXCzXSUTERPgaU/JEV9
	Zm6/HHQryz3Zl+dwyp5uEA2JVCQB12rBVp/WJbOijyCIBdnjjrvzAGrPRmOgCOkexlkTGf
	E1P6P35yltPY+8TDKyWDLzj8UV/cRYoLc6Wmlwt+NaTQYpy/rNGf2Pbc0xRcDQ==
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
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net 6/9] batman-adv: fix TX priority extraction for
 BATADV_FORW_MCAST
Date: Fri, 21 Aug 2026 11:48:10 +0200
Message-ID: <20260821094813.201800-7-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260821094813.201800-1-sw@simonwunderlich.de>
References: <20260821094813.201800-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: XWCFYETJWCIHVFCSLZE5PRZELLKJCY4C
X-Message-ID-Hash: XWCFYETJWCIHVFCSLZE5PRZELLKJCY4C
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/XWCFYETJWCIHVFCSLZE5PRZELLKJCY4C/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Sven Eckelmann <sven@narfation.org>

batadv_mcast_forw_mode_by_count() pushs the skb->data for BATADV_FORW_MCAST
forwarding via batadv_mcast_forw_mcsend(). But the
batadv_skb_set_priority() expects the ethernet header directly before
(skb->data + offset). With the moved skb->data, just some random data would
be accessed to get the priority data.

Move the batadv_skb_set_priority() before the decision about the handling
multicast packets and potential header modifications.

Cc: stable@vger.kernel.org
Fixes: 90039133221e ("batman-adv: mcast: implement multicast packet generation")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/mesh-interface.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/mesh-interface.c b/net/batman-adv/mesh-interface.c
index 8e55b61dd2a64..e202088cf1fd4 100644
--- a/net/batman-adv/mesh-interface.c
+++ b/net/batman-adv/mesh-interface.c
@@ -305,6 +305,8 @@ static netdev_tx_t batadv_interface_tx(struct sk_buff *skb,
 	if (batadv_compare_eth(ethhdr->h_dest, ectp_addr))
 		goto dropped;
 
+	batadv_skb_set_priority(skb, 0);
+
 	gw_mode = READ_ONCE(bat_priv->gw.mode);
 	if (is_multicast_ether_addr(ethhdr->h_dest)) {
 		/* if gw mode is off, broadcast every packet */
@@ -338,6 +340,9 @@ static netdev_tx_t batadv_interface_tx(struct sk_buff *skb,
 
 send:
 		if (do_bcast && !is_broadcast_ether_addr(ethhdr->h_dest)) {
+			/* WARNING batadv_mcast_forw_mode might add more headers
+			 * in front of the skb. and might even reallocate the skb
+			 */
 			forw_mode = batadv_mcast_forw_mode(bat_priv, skb, vid,
 							   &mcast_is_routable);
 			switch (forw_mode) {
@@ -355,8 +360,6 @@ static netdev_tx_t batadv_interface_tx(struct sk_buff *skb,
 		}
 	}
 
-	batadv_skb_set_priority(skb, 0);
-
 	/* ethernet packet should be broadcasted */
 	if (do_bcast) {
 		primary_if = batadv_primary_if_get_selected(bat_priv);
-- 
2.47.3

