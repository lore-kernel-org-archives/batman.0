Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33C7AC55ABA
	for <batman-adv@archiver.kernel.org>; Wed,  5 Aug 2026 14:37:26 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 9C4D984261
	for <batman-adv@archiver.kernel.org>; Wed, 05 Aug 2026 16:37:24 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1785940644;
 b=tA9YBCzkLtwYG55u9Ljr/G0hFLRF6hOGX/ef2RIcb7kzUlkXkmQDzMfvo/lqnTTuN4+bh
 na7WjYMsSyjSs8wuNAy9f6SmfHit7LSdMh0Cm58qf3EgaRdXErVAEEOMBBT95ksO7Rkr6KY
 V9pBoFdQviT7uV7t1cZbBTTeQ3Cy/jk=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1785940644; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=CPzmQVht5KvQLJQDX2WIhvwIyHqu8oIsuXYqtJQeYJY=;
 b=wlbfWf8hea5J0+FY3h00Mm9QVHNGx3K1qoxId0oUxr9lUEsYaqyb1Kp0SKd4Gt0Q/pkSK
 pFm9Wj0w9gJI4ySfIzmHs3CmGOY2zdANSGD1oqc/jkyxSUDs59zCQxmruDoKIjrCGafMOpZ
 SRlCrd1nCA07zNuphB5vy/R/8/f07Fo=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 14F318421C
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 05 Aug 2026 16:32:07 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1785940332;
	b=s/cQP+LO8cNllBoTlhO5pBui8Y6jXjDeTWf1gOZjf/tjiW2zvosii1gLoXHLrtjHyLA4Yt
	shaerLR6paTg33hrkV8HE50q/9NfzdQGR4IrBhCp6Yi8jMeWYSEX3x5ka/ukhHvH/vNZNh
	SxcuAvKZs95Wb1mJ9R/2uoxNpgXqrcs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1785940332;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=CPzmQVht5KvQLJQDX2WIhvwIyHqu8oIsuXYqtJQeYJY=;
	b=OKs/M7QeDFOKDyfD6/Cm3y97Lmtof7ONy9zmsoBtT6eVpofR/30szLL+FN855IfeXkrMUy
	14vFTzHz6ha7KBsCfOQorXMHlO1B34gzHAVaDS2So5MXgJFjCkb5vWEe8vEgzZAVJJOUcF
	xR1Ngjy2qFJ0Xa11NdKzFmB+rjzN/SI=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=Hzuik7D0;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 23.88.38.48 as permitted sender) smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
Received: from kero.packetmixer.de
 (p200300c5970b56d88Eebac4310d100Aa.dip0.t-ipconnect.de
 [IPv6:2003:c5:970b:56d8:8eeb:ac43:10d1:aa])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id C57E2FA1C6;
	Wed, 05 Aug 2026 16:32:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1785940325;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CPzmQVht5KvQLJQDX2WIhvwIyHqu8oIsuXYqtJQeYJY=;
	b=Hzuik7D0kFc/xKwTtddnmDsOKDeIlvbtPOfgUUr3zvwhEG6n8IAkbnc0eDxs6RUCvLpkCh
	Ydt2yhXOICnykGASnrnF0AhKHucW/xUW22J2H1FVCAuiCbEyM0OiTjf5FSAzv3XzozDoWf
	Q4B5G8eQ5p2UjBJ4Bt2ONCzRV25/euA41Gk5m9sGBIreI9OjCX1pxzoll3lcWoAAzw/QsQ
	D+mATtfmuZuj5VnSe0jbzi5rQoYTUTY+IhXh8vNV8k+Sz7GkIunS/GQwIqKiTEdIBerz2O
	vF79A7atMzJvFjj1y4UHGQg5K0oVaw4wG2NSJiYdWJgDcPqCSYSvEWDXEopjHA==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Sven Eckelmann <sven@narfation.org>,
	Antonio Quartulli <antonio@mandelbit.com>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net-next 01/10] batman-adv: dat: drop non-4addr backwards
 compatibility
Date: Wed,  5 Aug 2026 16:27:15 +0200
Message-ID: <20260805143200.722098-2-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260805143200.722098-1-sw@simonwunderlich.de>
References: <20260805143200.722098-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: 2JUDMR3374NULR56ENMB5F5H33TXTZXJ
X-Message-ID-Hash: 2JUDMR3374NULR56ENMB5F5H33TXTZXJ
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/2JUDMR3374NULR56ENMB5F5H33TXTZXJ/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Sven Eckelmann <sven@narfation.org>

The 4addr unicast packet support is mandatory in compat version 15. No
older compat version is supported and the kernel doesn't need to keep code
to talk to nodes which cannot be in the same mesh.

Acked-by: Antonio Quartulli <antonio@mandelbit.com>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/distributed-arp-table.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/net/batman-adv/distributed-arp-table.c b/net/batman-adv/distributed-arp-table.c
index a6fe4820f65b9..c5fca53f3074c 100644
--- a/net/batman-adv/distributed-arp-table.c
+++ b/net/batman-adv/distributed-arp-table.c
@@ -1277,17 +1277,9 @@ bool batadv_dat_snoop_incoming_arp_request(struct batadv_priv *bat_priv,
 	if (!skb_new)
 		goto out;
 
-	/* To preserve backwards compatibility, the node has choose the outgoing
-	 * format based on the incoming request packet type. The assumption is
-	 * that a node not using the 4addr packet format doesn't support it.
-	 */
-	if (hdr_size == sizeof(struct batadv_unicast_4addr_packet))
-		err = batadv_send_skb_via_tt_4addr(bat_priv, skb_new,
-						   BATADV_P_DAT_CACHE_REPLY,
-						   NULL, vid);
-	else
-		err = batadv_send_skb_via_tt(bat_priv, skb_new, NULL, vid);
-
+	err = batadv_send_skb_via_tt_4addr(bat_priv, skb_new,
+					   BATADV_P_DAT_CACHE_REPLY,
+					   NULL, vid);
 	if (err != NET_XMIT_DROP) {
 		batadv_inc_counter(bat_priv, BATADV_CNT_DAT_CACHED_REPLY_TX);
 		ret = true;
-- 
2.47.3

