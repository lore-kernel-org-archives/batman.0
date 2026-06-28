Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1A5DC43458
	for <batman-adv@archiver.kernel.org>; Sun, 28 Jun 2026 07:27:37 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 5396183FD9
	for <batman-adv@archiver.kernel.org>; Sun, 28 Jun 2026 09:27:36 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1782631656;
 b=jzRiIDSBS4R+AjY40MtiP9W3Ct+MOm6snnCh7wIvGzXVmArpVAqRtewWkOzuRGcr1IFj7
 cwydbgJ/PTXHWP8A/A9nkS6NfiqVa8VToQqaMZoDT2wrX3MGrdtnQzV/rY8c0p4wuu/o4Ts
 OXaN2BhYOyHShZrxv+sSGW10MNhuJq8=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1782631656; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=Zj+e2BxKoIpnIchJrWjBzT91RPGTRHNj4+moT7BZi3I=;
 b=LmyXYsG1lInekT6wJSh/nkGgvE+inwGwSw4zwcWJ3qVVCwGsoGx5QeCvxAFIju64/N6+j
 fxk+bX15KDRhVEzEGe74iC0MyGiqN23NerkmWoUbCu6rGwRiVnG7baHY4hflZdh7ftQdTfT
 FQqpkIKTOtIa9QLPo1K76QSXbzE/FKc=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id D3F1C807CF
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 28 Jun 2026 09:25:45 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1782631550;
	b=l2aDyUHt0G9QfS4/UKGZ7J7cLOx2OBltFzwf7R8/PXFIAbyz0cOb3TMcqhs/an3v9lpsKa
	gxhbbQp9YutGCeUnbnKAKupSoSlrzYZQcQ2peOhJGIMQjyw+jZ4xp6NZjj5UiaYRLn/Vtd
	IouP7nkElfMhMrWbhFA2SHjkDhhPLSI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1782631550;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=Zj+e2BxKoIpnIchJrWjBzT91RPGTRHNj4+moT7BZi3I=;
	b=YgWu7H5xcBOGf1CjGQhmCTCj3Qw1o65r0COtqQn8E6xtJHjSqX/k30SvW0Mot+Pc+tAChm
	/gTlxG09+4xOchn+O057FB9FibiLAtR4lJ2L2bjG0cboJDmJBrIRUEJRhHt+hLsxrGhPh/
	BPkQRf6azX9mWwGPYKL/jnWprQJmhR0=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=oUXsoGnV;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id AB82220560;
	Sun, 28 Jun 2026 07:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1782631543;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zj+e2BxKoIpnIchJrWjBzT91RPGTRHNj4+moT7BZi3I=;
	b=oUXsoGnV4ik3v2mYyLh15Xh1NddwW5vJyDhUsYP4AVNrmX5SzevbRPKMtjAmXvqMEMAgcw
	FDwFepTuO6UAEzhxigXVymWfTsImB+zv6GrJb6QkGeHxqW3b+3uDMk2pS8pmj1YCAj/nLm
	Etymp5YDp3KmtJF938IG9beaQBrLbh0=
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 28 Jun 2026 09:25:34 +0200
Subject: [PATCH batadv v2 1/5] batman-adv: access unicast_ttvn skb->data
 only after skb realloc
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260628-skb-post-realloc-v2-1-59a58f5a471b@narfation.org>
References: <20260628-skb-post-realloc-v2-0-59a58f5a471b@narfation.org>
In-Reply-To: <20260628-skb-post-realloc-v2-0-59a58f5a471b@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>, Sashiko <sashiko-bot@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1175; i=sven@narfation.org;
 h=from:subject:message-id; bh=Ppw3QRr780Y5ZasVr7qIHGsMOJ+qS6b6KoYeDcVvXFs=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFkOZwrE1NxXfs4PyI+9+uG9lJHjf7vH/xfGu/vbJbAfZ
 Ur+LNzdUcrCIMbFICumyLLnSv75zexv5T9P+3gUZg4rE8gQBi5OAZjIUT9Ghkemhz5te768ZPN9
 oSuny/aqMN5xeLC36r/g7ZxfOzeeOWDF8E+Hx4C9rSjNaKN3jtmL2bvzrZ3+Tbr6Q2rHfMMr0yb
 HlnEAAA==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: ANZ42OBF4NU6CXCEXKRS3A5W3TGOBJE6
X-Message-ID-Hash: ANZ42OBF4NU6CXCEXKRS3A5W3TGOBJE6
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/ANZ42OBF4NU6CXCEXKRS3A5W3TGOBJE6/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

The pskb_may_pull() called by batadv_get_vid() could reallocate the buffer
behind the skb. Variables which were pointing to the old buffer need to be
reassigned to avoid an use-after-free.

This was done correctly for the ethernet header but missed for the
unicast_packet pointer.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Fixes: 580d7919f19e ("batman-adv: add the VLAN ID attribute to the TT entry")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/routing.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/routing.c b/net/batman-adv/routing.c
index 208c5d4d..10168d23 100644
--- a/net/batman-adv/routing.c
+++ b/net/batman-adv/routing.c
@@ -894,8 +894,8 @@ static bool batadv_check_unicast_ttvn(struct batadv_priv *bat_priv,
 	if (skb_cow(skb, sizeof(*unicast_packet)) < 0)
 		return false;
 
-	unicast_packet = (struct batadv_unicast_packet *)skb->data;
 	vid = batadv_get_vid(skb, hdr_len);
+	unicast_packet = (struct batadv_unicast_packet *)skb->data;
 	ethhdr = (struct ethhdr *)(skb->data + hdr_len);
 
 	/* do not reroute multicast frames in a unicast header */

-- 
2.47.3

