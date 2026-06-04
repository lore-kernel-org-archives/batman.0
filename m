Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4F7ACD6E6E
	for <batman-adv@archiver.kernel.org>; Thu,  4 Jun 2026 20:10:33 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 8730F853BF
	for <batman-adv@archiver.kernel.org>; Thu, 04 Jun 2026 22:10:32 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1780603832;
 b=PnojjvrSz8J+f92DeSqnrehegddBTtyaV/gYQ82kTAFaA/thMxIb0cu/eU4rn9tnh4Ls9
 a9lyxREeVVlK2nXGkqv9czwbv0Bu3H0gm5CBetKOvXY5ytItXDnVj58ACVDzpBdXr0bbW03
 0Gl8oEKo78csEGbGBcWKT4uxZolAMRU=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1780603832; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=nywLAPtb3eun7P/IaDFOJG4fw54dMDnyPr0b+FinR6I=;
 b=c3JnBqAjA77e9osrmMryiR2zdHJ+FoURcrJa0WKOIQR1B74+FCKlCA4mc6THvbSZFidH7
 EPpz9zUadyevre8Psso3Y4SyNy+WDw6c0fRrqFdeAFBn098avNJpnz+lAKnwDPbc9VLJ0Mh
 QYJTGWtSM/gaaxO+taIFAgt6ioTRDp8=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 3796A84622
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 04 Jun 2026 22:08:56 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1780603736;
	b=U+gz5hYvMk6jdYpz2Z4mBF0O6gMo2kws4/RqyXpGZ65evv69LirnEZ3/JSJjdn3/E469RD
	lTLj8wLvd5Bukby1h3lMfq+WBqYFnD+ESIfgURDmr7ePZPbKGMGWG2roTw1/dNqKiyEaH0
	l2LlSmv2C/tSVLmNsc4A/b58QFN4Zi4=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=Z23jw9Do;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1780603736;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=nywLAPtb3eun7P/IaDFOJG4fw54dMDnyPr0b+FinR6I=;
	b=nU2wVwtMegEcycX2TsUoTiPHbEQq+P0QORO6vGKh6VXpe8vY/HecnFTqPQt7fzaZwHwItd
	ao4R+kPrnZ2a2oek8Ei6CB+E5VKC6LxQnig2mC9r+eCVzH0g+ljZfAKzZRjkK8CllJh7Kw
	GdowU3STaf1WnOJ30180LN7TODxX8pM=
Received: by dvalin.narfation.org (Postfix) id E7D2420268;
	Thu, 04 Jun 2026 20:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1780603736;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nywLAPtb3eun7P/IaDFOJG4fw54dMDnyPr0b+FinR6I=;
	b=Z23jw9Do7PfdCbUz5/173zXaY4QVJbKiuw9CnU3Nb7Q9lVFY6kV78p6YL9UmoWoAWVrvCx
	GuZmb3zulg8tW5GaJ9jOX8f4tiwaoNgruOjLRUI/X2v0Ymj5q1hEmMyclmGBjiHt0A+2Jo
	0utfzd8FYwmyKLlMR6vpalA8ENSxB0o=
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 04 Jun 2026 22:08:46 +0200
Subject: [PATCH batadv 4/5] batman-adv: fix batadv_v_ogm_packet_recv error
 handling kernel-doc
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260604-kernel-doc-cleanup-v1-4-c4c4d4a77c31@narfation.org>
References: <20260604-kernel-doc-cleanup-v1-0-c4c4d4a77c31@narfation.org>
In-Reply-To: <20260604-kernel-doc-cleanup-v1-0-c4c4d4a77c31@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=978; i=sven@narfation.org;
 h=from:subject:message-id; bh=gNLT3/3o/CthwITihq7xKPLFPzPK+pG3Fcx7QA2Vwcw=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFmKt33k3q3xz2sULir8fWFP9vIrj5afLbdqXC3d27/ny
 bn7V7cf7ChlYRDjYpAVU2TZcyX//Gb2t/Kfp308CjOHlQlkCAMXpwBMxL+CkWF9o9ALlrwHPT/y
 M6cteGw++28e47XGxhVH3ZMtWk9uvfWRkeGJv/9/pryPFUGTFKa9f/J5lVpc6vnY1eeP5PUcTTR
 U6+YAAA==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: VOKPLT2CFCWYO3IUZ6OHLYVXHQ6WLJW3
X-Message-ID-Hash: VOKPLT2CFCWYO3IUZ6OHLYVXHQ6WLJW3
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/VOKPLT2CFCWYO3IUZ6OHLYVXHQ6WLJW3/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

All receive handlers in batman-adv are consuming the skbuff independent of
the result of the handler. The "(without freeing the skb) on failure" is
therefore not corrrect anymore for the current implementation.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/bat_v_ogm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/bat_v_ogm.c b/net/batman-adv/bat_v_ogm.c
index 5936d004..b3f246f6 100644
--- a/net/batman-adv/bat_v_ogm.c
+++ b/net/batman-adv/bat_v_ogm.c
@@ -982,7 +982,7 @@ static void batadv_v_ogm_process(const struct sk_buff *skb, int ogm_offset,
  * @if_incoming: the interface where this OGM has been received
  *
  * Return: NET_RX_SUCCESS and consume the skb on success or returns NET_RX_DROP
- * (without freeing the skb) on failure
+ * (freeing the skb) on failure
  */
 int batadv_v_ogm_packet_recv(struct sk_buff *skb,
 			     struct batadv_hard_iface *if_incoming)

-- 
2.47.3

