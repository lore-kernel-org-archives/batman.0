Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3821FCD37B6
	for <batman@archiver.kernel.org>; Wed, 13 May 2026 07:03:06 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 99B9F85A98
	for <batman@archiver.kernel.org>; Wed, 13 May 2026 09:03:04 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1778655784;
 b=IsX90TJ54JlJinMougrQ9hCvOQRkLaEg1LATS5vFezFrG1U9eyfwtBk2CZ266a2SM36Ed
 +xRD8pY0Oy5deercCisEhyUTMXBKGiK/vfT+/821FTkjSNhi4Zv+2mUnM2R7kK8/hqhewUG
 oALmtC8w6+uSGCikQC34739JWYN/9+E=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1778655784; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=FmR3v8EeN1uF1+ab08eOwN+ILbqX02a9NCRtKOl2gOg=;
 b=gCpSHGGW+wEXAzYzu3Z8q4BNrB6w48P5vgpFsIMBvb2XQll5AphOSFrmwFcDzC86zVeFI
 fc8zSdW7WHqmY/FkKWOL9xf4yCV2VSA4hJ1LFqVHcdRTy1tY+JcqohScl893HmtYfmr2kj/
 ziz1KcglQJl5FY7rsbDE6emlPzhl++s=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 8383E84889
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 13 May 2026 09:01:43 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1778655710;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=FmR3v8EeN1uF1+ab08eOwN+ILbqX02a9NCRtKOl2gOg=;
	b=nzResQs/f6woSRBczjuufyGNWTjBtekMAGtyklLTqO19O8IzjHz+f52ChMzSLwEJuF3MNL
	5OUckGSeH4P3vB4vAlrSrblaWV9PVCpqCbqht9zblhu27udlkKh8GTohvXAJfocm6FBOPA
	o32tWHGpo0/GGHfkHymTcn9/cLLVAI0=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=BTUj4VTT;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1778655710;
	b=TSNI1suQkLnyniX9+82GWKz8uBvAvdWrwz48t6eiz29roRVlzdjNhCnWXT7PeGWk4/cqVM
	Yn4LK1BDcIZp4bQmzGRVBGsKDgOwd6Ekh9RkEv+IcIBmI1HhdYAf3vM28O7OJgJtOKukVx
	2EOEQ5UYn7rUIu08R+fgb44VeRENEag=
Received: by dvalin.narfation.org (Postfix) id E6E3D217E2;
	Wed, 13 May 2026 07:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1778655703;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FmR3v8EeN1uF1+ab08eOwN+ILbqX02a9NCRtKOl2gOg=;
	b=BTUj4VTTsK7f4vDrTmNJwnsSH9nEW3XEsSwpJSEAtDSWCfzRX4xw1DSHa748tMQxfeWsa9
	liPYntShHBPvOqNlNekKmCTvzkzjhWveU4wezzMcCV37ow/0bUFWbXujdpUC1ViV2fuseL
	llWHd1+jgNpdkSmSzb6BxlkRoFzoBq4=
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 13 May 2026 09:01:34 +0200
Subject: [PATCH batadv v2 1/5] batman-adv: dat: handle forward allocation
 error
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260513-yuantan098-bugfixes-v2-1-863e9caa2a57@narfation.org>
References: <20260513-yuantan098-bugfixes-v2-0-863e9caa2a57@narfation.org>
In-Reply-To: <20260513-yuantan098-bugfixes-v2-0-863e9caa2a57@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Yuan Tan <yuantan098@gmail.com>, Sven Eckelmann <sven@narfation.org>,
 stable@kernel.org, Yifan Wu <yifanwucs@gmail.com>,
 Juefei Pu <tomapufckgml@gmail.com>, Xin Liu <bird@lzu.edu.cn>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1388; i=sven@narfation.org;
 h=from:subject:message-id; bh=58f2Z4y63ArOhS8V6snD3emYy/yeDBo/DhIxBWYYRnc=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFksiuevSq77XpotWhy+Z+HtvQtleA/ainc8lQh1YXO1v
 J5/7VBRRykLgxgXg6yYIsueK/nnN7O/lf887eNRmDmsTCBDGLg4BWAia4IZGVYXHF9kv+p3Id8b
 4wNRD+6q3b8eu86DvXZbs+2ChEZ7o38M/5Ql/3UmRn+IMz1Xf0ntb/XZYJsUlVVT3s1/zyhwwyU
 kmgMA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: JYAYYWJRVCAPASIF6N56AEFH4O6YDW36
X-Message-ID-Hash: JYAYYWJRVCAPASIF6N56AEFH4O6YDW36
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/JYAYYWJRVCAPASIF6N56AEFH4O6YDW36/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

batadv_dat_forward_data() calls pskb_copy_for_clone() to duplicate an skb
for each DHT candidate, but does not check the return value before passing
it to batadv_send_skb_prepare_unicast_4addr(). That function dereferences
the skb unconditionally, so a failed allocation triggers a NULL pointer
dereference.

Skip forwarding to the current DHT candidate on allocation failure.

Cc: stable@kernel.org
Fixes: 785ea1144182 ("batman-adv: Distributed ARP Table - create DHT helper functions")
Reported-by: Yuan Tan <yuantan098@gmail.com>
Reported-by: Yifan Wu <yifanwucs@gmail.com>
Reported-by: Juefei Pu <tomapufckgml@gmail.com>
Reported-by: Xin Liu <bird@lzu.edu.cn>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/distributed-arp-table.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/batman-adv/distributed-arp-table.c b/net/batman-adv/distributed-arp-table.c
index 3efc4cf5..0a8bd95e 100644
--- a/net/batman-adv/distributed-arp-table.c
+++ b/net/batman-adv/distributed-arp-table.c
@@ -696,6 +696,9 @@ static bool batadv_dat_forward_data(struct batadv_priv *bat_priv,
 			goto free_orig;
 
 		tmp_skb = pskb_copy_for_clone(skb, GFP_ATOMIC);
+		if (!tmp_skb)
+			goto free_neigh;
+
 		if (!batadv_send_skb_prepare_unicast_4addr(bat_priv, tmp_skb,
 							   cand[i].orig_node,
 							   packet_subtype)) {

-- 
2.47.3

