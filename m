Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0AB0CD98CE
	for <batman-adv@archiver.kernel.org>; Thu, 11 Jun 2026 17:28:24 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 5AAE2842EB
	for <batman-adv@archiver.kernel.org>; Thu, 11 Jun 2026 19:28:23 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1781198903;
 b=WMHzGaFbDTTGCQsMX7kfUPf50q7Sw/sR27FJM1E0SO8rJFVD+9cVmwcYkC8efBcaQWrj6
 tvPxqMG6gjpocEBKgcigYsEq1APtjnmUWcgEISsCJXq+BwMWtEeGSQqbsK2+803MIoqafmd
 0AKjviQyUfmCtxAiWNfxVvA1FW+Dylw=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1781198903; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=r8qaTB7a0Pocjd91E9coVkVuhnESQJ1hjFsKnGTpRQQ=;
 b=XV4Hdy+g/1c83xuSYCKST2e/ZKy9g64Ez6gY4YpIUVrZJTCvHhHey1iemqftN5/m7qXN1
 a13Ipt4enbBBs9sJfZbHmWZaSWHT+3nXL4P4kzIqT91nJecsEW0ejQRykDw8eV2SPB7c4M0
 8+CKtMXE1RNVt0h5Sm+S8RypCdEfTE8=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id EE89383FE6
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 11 Jun 2026 19:24:43 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1781198684;
	b=GVXk4qx/Qs/nNae13Nvue4FWvpdy0iSWY7DDyRPMTpzSBZ5ufOfzOtcEdFyysHq4jfuYrI
	fuKZZOsXPX6fclzUAf5+P8XriFKJIN9e/JwQxwMkFoWtV2d6+T9RZ05DR49hQpFihINU1A
	RlOeBZxqCuYxX03NbSB1Oi8BqXrAee8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1781198684;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=r8qaTB7a0Pocjd91E9coVkVuhnESQJ1hjFsKnGTpRQQ=;
	b=wYcWgptbFkNu6wVxTV87u35NswpPlS7Ur/TAqV+BryLFTdnFoDZrSyV8NQRQyvi4PufWmv
	N626oG7MHBd3VKkwOSUP8Tpt8ixrs9oeVhbu+5IBfwaIrLAFj/SAsSsiV/+cANz8K8N4en
	0PipFBzRZxnF10b4ZcjRLr/+e2wHXX8=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b="TJQS4h/P";
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org
Received: by dvalin.narfation.org (Postfix) id 5B6761FD51;
	Thu, 11 Jun 2026 17:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1781198683;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r8qaTB7a0Pocjd91E9coVkVuhnESQJ1hjFsKnGTpRQQ=;
	b=TJQS4h/P4LWoVNj65aiJvYzogged4bjSqfizeiX16nvrbbQ1m5kNG5laOI75YGDMQ2NJDB
	ckW4IzBFBdZbfNm5fhyF/7HWfCshyr64GLbqZWoLM3U0Lnt1t2f7HhEvJuhqE+FcUn/fi6
	mL2qtAhUvUWNsFp+v8+kFswNZxRKC9k=
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 11 Jun 2026 19:24:10 +0200
Subject: [PATCH batadv v2 5/9] batman-adv: tp_meter: simplify unordered ack
 calculation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260611-tp-unacked-list-v2-5-47389466c5c1@narfation.org>
References: <20260611-tp-unacked-list-v2-0-47389466c5c1@narfation.org>
In-Reply-To: <20260611-tp-unacked-list-v2-0-47389466c5c1@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1189; i=sven@narfation.org;
 h=from:subject:message-id; bh=pMDlXrKT63vey6EWtGpToPp/PTy7s9Po3KI+QTJYhhw=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFla7606lpTyPT8pMy3tyK2yRlvXw926c0NmNR5++azqp
 8ec68GRHaUsDGJcDLJiiix7ruSf38z+Vv7ztI9HYeawMoEMYeDiFICJLDnJyDBTZOv/SRduP33K
 2vBWrfHbYsX9dVF6Kbt/tMzLc5q0dFcywx9+pv9V+1fZmxVznT0W+ef6guPP1cwP3FcwK2vf/aW
 0L4sPAA==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: B3PETJXJHES7CWA6O74KCLEPBRWNX4XV
X-Message-ID-Hash: B3PETJXJHES7CWA6O74KCLEPBRWNX4XV
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/B3PETJXJHES7CWA6O74KCLEPBRWNX4XV/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

When batadv_tp_ack_unordered() goes through the list of unacked sequence
numbers and checks for now closed gaps, it is first calculating a delta of
the sequence numbers which could be acked. Just to revert this calculation
in the next steps to the sequence number which would be ackable.

Skip the delta step and directly work with the sequence numbers.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/tp_meter.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/batman-adv/tp_meter.c b/net/batman-adv/tp_meter.c
index c2eea7db..b7fee6e5 100644
--- a/net/batman-adv/tp_meter.c
+++ b/net/batman-adv/tp_meter.c
@@ -1493,10 +1493,10 @@ static void batadv_tp_ack_unordered(struct batadv_tp_receiver *tp_vars)
 		if (batadv_seq_before(tp_vars->last_recv, un->seqno))
 			break;
 
-		to_ack = un->seqno + un->len - tp_vars->last_recv;
+		to_ack = un->seqno + un->len;
 
-		if (batadv_seq_before(tp_vars->last_recv, un->seqno + un->len))
-			tp_vars->last_recv += to_ack;
+		if (batadv_seq_before(tp_vars->last_recv, to_ack))
+			tp_vars->last_recv = to_ack;
 
 		list_del(&un->list);
 		kfree(un);

-- 
2.47.3

