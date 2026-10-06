Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24192CA5FFC
	for <batman@archiver.kernel.org>; Tue,  6 Oct 2026 16:49:45 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id B57338409C
	for <batman@archiver.kernel.org>; Tue, 06 Oct 2026 18:49:43 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1791305383;
 b=pytgWL321WRbbigeXjDKuA0A4z1fomw4nLVvIw2SLH9NByVpxPqhXxFRixJKssNaJgAX4
 DfzF+DudoiXSlKFg8FP9ydbK9YTZN7HPYlJmjhcCdG5en73Un51dfWnSFcNdVvPCgQliSmt
 vA8SEVFvWa0yEqLxTK4edZ0/Tr7ff3M=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1791305383; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=VAVnKyJdpcFsMvidBaUe0DvETJX2RzAktU7qX9Er7ks=;
 b=rDC6qbghE93QJDPq6ChbcSCXsR/yPHUsWugKRj53CkISoa0ko+fSLKXK9rBCCRMMNRGnr
 NsT/0EMGb3+OgvcFyjtJcFetTkyHjaGaTI5AYVkgC294DGylRd67vXWGRiUKVAPWEQkyran
 7TJmcaj3aV6U2LwLA7jZ9eSm4UW67Fk=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 0A29A83BB4
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 06 Oct 2026 18:48:23 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1791305314;
	b=DFzISzUc6AIRLrqHR6+pKCypCd4gcYTXsC+3Qgn419TYZFqYk3n44EYUWV0PyAcp2xoWI5
	aifa2bmk/C+fah2cpn/xJYxNZYy9iGG0jp3hY38+xUOjFZnPOTAmTFHZuVKPKgk6lrSBkZ
	hQCjwJm190iUNXRszqVK25T6giuhjrI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1791305314;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=VAVnKyJdpcFsMvidBaUe0DvETJX2RzAktU7qX9Er7ks=;
	b=qwA6e0HMwm3p2DlyViz2JTx3dKW8ZZCTTuulaF9JO8oJu2rJ/2rLiNaUaCsl4oF99M5kJT
	o9fvwyCWlFz9vPBWbdXifa7e/xXrOpaMO7yENlKyb366515p1PVAxurY8E4/BApx8fXGcH
	b9ME4bPu0pddc5oQVsuOGGybrNUZUps=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=sR9+Dxd+;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 475F51FE24;
	Tue, 06 Oct 2026 16:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1791305303;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VAVnKyJdpcFsMvidBaUe0DvETJX2RzAktU7qX9Er7ks=;
	b=sR9+Dxd+6F2D0ZJRvSx3OcgM5+VjdCTvSvO86nZePJUFNhHSPNGgVucmRHndPlBB1CGZjJ
	YHNNy7A4wueaANh+mhlqPYkQN1ECvUzUa2m+oabpkQr3XIs8CjIPppWKAeXULJNmUIgnpE
	B0EDOXnyyBSQigSKkV9epDT8Oosu6t4=
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 06 Oct 2026 18:47:05 +0200
Subject: [PATCH batadv v3 3/9] batman-adv: bla: annotate lasttime with
 READ/WRITE_ONCE
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261006-dat-last_update-once-v3-3-316aefdd5f5f@narfation.org>
References: <20261006-dat-last_update-once-v3-0-316aefdd5f5f@narfation.org>
In-Reply-To: <20261006-dat-last_update-once-v3-0-316aefdd5f5f@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1544; i=sven@narfation.org;
 h=from:subject:message-id; bh=yVKoxy5R2+cuPDV2BjmrfJJKlWtum/4kTqOgnxqY3dI=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFlH1bhWioWa8b5fx8r4feraJrMeFb+X6me/dZ9covHzu
 3CZyw69jlIWBjEuBlkxRZY9V/LPb2Z/K/952sejMHNYmUCGMHBxCsBEXsQyMmwxazQXSCznvJZ5
 /MaN1kmPvPr27N0hd+mLalnMhVZO6fMM/8OZKpOn703sP1iyVt+sp0Q7ROij22S5i4KSdXdZ2GV
 leQE=
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: FLGPOZUMQ46O4YEVG3YCXKKPQ3KARWIW
X-Message-ID-Hash: FLGPOZUMQ46O4YEVG3YCXKKPQ3KARWIW
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/FLGPOZUMQ46O4YEVG3YCXKKPQ3KARWIW/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

The lasttime field for batadv_bla_backbone_gw tracks the jiffies value of
the most recent activity and is used to detect timeouts. These accesses are
not consistently protected by a lock, so READ_ONCE/WRITE_ONCE must be used
to prevent data races caused by compiler optimizations.

To avoid an underflow due to an non-strict order read of jffies vs
lasttime, use jiffies_delta_to_msecs instead of jiffies_to_msecs to
evaluate the delta.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/bridge_loop_avoidance.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
index a96f269d..0833f9f9 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -2363,6 +2363,7 @@ batadv_bla_backbone_dump_entry(struct sk_buff *msg, u32 portid,
 			       struct batadv_bla_backbone_gw *backbone_gw)
 {
 	const u8 *primary_addr = primary_if->net_dev->dev_addr;
+	unsigned long lasttime;
 	int ret = -EINVAL;
 	u16 backbone_crc;
 	bool is_own;
@@ -2385,7 +2386,8 @@ batadv_bla_backbone_dump_entry(struct sk_buff *msg, u32 portid,
 	backbone_crc = backbone_gw->crc;
 	spin_unlock_bh(&backbone_gw->crc_lock);
 
-	msecs = jiffies_to_msecs(jiffies - READ_ONCE(backbone_gw->lasttime));
+	lasttime = READ_ONCE(backbone_gw->lasttime);
+	msecs = jiffies_delta_to_msecs(jiffies - lasttime);
 
 	if (is_own)
 		if (nla_put_flag(msg, BATADV_ATTR_BLA_OWN)) {

-- 
2.47.3

