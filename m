Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA006C5DF87
	for <batman-adv@archiver.kernel.org>; Fri, 21 Aug 2026 09:52:02 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 332B38113E
	for <batman-adv@archiver.kernel.org>; Fri, 21 Aug 2026 11:52:01 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1787305921;
 b=NN91Bprzy8dkgPoMcSrEXogUd2qtO0nx/lki2VDAPjUe5h9XwAdOa2f6K7nnw+tZuJ3mq
 7bv/fh6hDSKiGiE0cDdI/G+vekB9wJNz3VAZRnfLMX1vKFjJs8Lkp3Ba4f0thR+MnerJY4i
 I4zLAe9A/A45wZ6wbLK6bHzUnxnDklw=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1787305921; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=cJU+08rDDPXtarsKtPKGdOhWgwl9lWau1A8lhrBxiOM=;
 b=boOpv5REI6o/Q94Zar1tPXktOoMxPXZSTWlkhiOlLaMLP+dF6kSWH8eGT7tLoQx5OoLsm
 dNWyX+21vuWWJ5qYe1OlculosXoEutO/ZsCQ///6V5Ba09ROfSufSNvVlwyoUO+ZLIU+loR
 SitniHgtmbRixo4RCgdFFVkKSDFd8zc=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de
 [IPv6:2a01:4f8:c17:e8c0::1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 95BE680A7D
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 21 Aug 2026 11:48:22 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1787305702;
	b=nCCc7Uy6inQmaKgUsQ4ezOZBT6aDljh1poNfzH4ESaR3MD02Tzcy95ESxKqpnos/wXSL2k
	ssomZKdsOrzHzsUoORr5JYIl+N2Uc08V2nrGVv5BTGpzXH2pSy4m2YGkgLK7/GkXU0/Bqr
	ujFvaXFjiz63EDiNQ+edQ6MQm2d/ty0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1787305702;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=cJU+08rDDPXtarsKtPKGdOhWgwl9lWau1A8lhrBxiOM=;
	b=H5LNcGs6E8j/KIVoxwjE4/0aZtFZ1F5e3U3Tt3pPfVYfgk4O+Dh5XJDo0ykzcAzTm9Ay32
	9I42w71e0hRjfIsfvORKCu+rMDkCXBmhzDgl/Rr6a2BiLde6tM1gCxKH4/Gd7v96G1y8LL
	Lh434aWumaBWxZjOHzKZTpQ6+0K2TJs=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=NZxP1Dmy;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 2a01:4f8:c17:e8c0::1 as permitted sender)
 smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
Received: from kero.packetmixer.de
 (p200300c59714FcD8EC8C87C354003fed.dip0.t-ipconnect.de
 [IPv6:2003:c5:9714:fcd8:ec8c:87c3:5400:3fed])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with UTF8SMTPSA id 2C00DFA13B;
	Fri, 21 Aug 2026 11:48:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1787305702;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cJU+08rDDPXtarsKtPKGdOhWgwl9lWau1A8lhrBxiOM=;
	b=NZxP1Dmyr7ema6sj1yTef1bFHcaonieAJ7dwPBlAjmTYBTLhkm6QGxtolyIJTC4oCgFJgE
	V7jwfa+lTtkIKPI9zGg1hxkvSND4s8IAzHeM808JeE2FWLXjjyR+QI1a1ocjdnNNZMbAWW
	FIJ42IcLuUR6Ih99QotLQufOP5OgwORGeG8uQdqwuwBeNCYz54zHiqSur8fxQggn1xI/5J
	kfkf9hJ81ct4/HKhL23n3kODZ/0jGS0xxLP7mk7NYdlnmsWNUZ3b2Rk4DNUsnf1yUFluiF
	sJhHTUl5ljcUAR1vzAzkjyQn9e2KDM/wo63dlAacpq8UIsyfRBJ6SSsZ4JyFQQ==
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
Subject: [PATCH net 7/9] batman-adv: mcast: ensure unshared skb for multicast
 packets
Date: Fri, 21 Aug 2026 11:48:11 +0200
Message-ID: <20260821094813.201800-8-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260821094813.201800-1-sw@simonwunderlich.de>
References: <20260821094813.201800-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: KJI6X2QNA3MR76MGKQW4MFY4IVHKLRFS
X-Message-ID-Hash: KJI6X2QNA3MR76MGKQW4MFY4IVHKLRFS
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/KJI6X2QNA3MR76MGKQW4MFY4IVHKLRFS/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Sven Eckelmann <sven@narfation.org>

When a packet is transmitted via a batman-adv interface and has already
enough room for the header then nothing will make sure that the skbuff is
unshared. But it is not allowed to modify a currently shared skbuff.

Always make sure that the pskb_expand_head() is not only called for a too
small header but also for shared skbuffs.

Cc: stable@vger.kernel.org
Fixes: 90039133221e ("batman-adv: mcast: implement multicast packet generation")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/multicast_forw.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/batman-adv/multicast_forw.c b/net/batman-adv/multicast_forw.c
index bae2a81109767..3927d28dcbb89 100644
--- a/net/batman-adv/multicast_forw.c
+++ b/net/batman-adv/multicast_forw.c
@@ -1105,8 +1105,7 @@ static int batadv_mcast_forw_expand_head(struct batadv_priv *bat_priv,
 		return -EINVAL;
 	}
 
-	if (skb_headroom(skb) < hdr_size &&
-	    pskb_expand_head(skb, hdr_size, 0, GFP_ATOMIC) < 0)
+	if (skb_cow(skb, hdr_size) < 0)
 		return -ENOMEM;
 
 	return 0;
-- 
2.47.3

