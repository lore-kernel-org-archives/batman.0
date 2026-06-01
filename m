Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F93FCD6E4C
	for <batman-adv@archiver.kernel.org>; Mon,  1 Jun 2026 04:56:24 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id AFB89842EE
	for <batman-adv@archiver.kernel.org>; Mon, 01 Jun 2026 06:56:22 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1780289782;
 b=fLOvdGuE9xaLCfrqaGcb3/YXx1EovSXKXPE/KLacUY0V3iPeZRupcpmlXiWsQaBhqCd8Z
 wMcAox8CQaYgWaOXo75pKz5XiZTmM2PrxzRWRsXUuXV9Q0NeRh4L2jFIE17IrCgoKqSevo/
 lGBivYa6BR0ZF1mpSyrFsNFbH1ovDYg=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1780289782; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=PnYAMAKBoSADehNAcMCcp4UbxWywFNelduupz6rQ1A8=;
 b=yeBznfNZjYoIzQJceF4jPaQaxsQkA225MDfh5BiNC1Lcku0NyegtFgg6UYRVsfHWNXTq7
 c+wijQrEVap+3fs3vNoqWQ03IS0JNaSDF+BOccTwuKuRhyVURBguRJkol8HXqqRhKeJh8Dz
 X3mt4k2MD/AjgWhtqUPQA3Ky77EvWwM=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 04D3783DED
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 01 Jun 2026 06:54:28 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1780289668;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=PnYAMAKBoSADehNAcMCcp4UbxWywFNelduupz6rQ1A8=;
	b=vxvPqS58HI2G/R+QOi1iAs756JfDCR/kOGK0bQwSmzm2lDAxx5NrVxLAFNnDVwEXVqPlEk
	7gwDq+TFp1PlBkv6ApK5UlBbYBVb8/4XM/aZ4U1MRQYdpwRoNr6qBjO2fP0qhUii6zawBA
	aGCtaefA3wHZuh0jTAJfezXH5Rjprpk=
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1780289668;
	b=P6e+TpSZdAQievK7pH3u1qQ6AqncSWAEIHjCDkYTQ4tp641rgWaMLhex22yKLccC98Rr88
	Q6J9iCBmskwVGk9SeMdrdQ6KepiDHIs/VG+Lf9nmrkSr4PrYsZl/wgT0vVpEhOdf91XBB9
	TDrzConRscnakhGKTy/Cob5qUPIkYbg=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=LAH9yxkE;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id BB3001FEED;
	Mon, 01 Jun 2026 04:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1780289667;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PnYAMAKBoSADehNAcMCcp4UbxWywFNelduupz6rQ1A8=;
	b=LAH9yxkEJkvxT60TFMY+u1oSa4LKqXf0ToBUqts8SnKnE+4oFyHrCyv41e3A4oPSbWDmXM
	p1aSy+yriCE68Ko3MACCiXivzejuY4gOrA2KcQE/KKe5ws2RLF08+fwNHx+BDjRjhAliXU
	AQnEcO0YsWziKkMjF68DEd9X9A6shTA=
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 01 Jun 2026 06:54:16 +0200
Subject: [PATCH batadv v5 2/7] batman-adv: tp_meter: initialize dup_acks
 explicitly
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-tp-reason-missing-v5-2-78a5b8fe6e67@narfation.org>
References: <20260601-tp-reason-missing-v5-0-78a5b8fe6e67@narfation.org>
In-Reply-To: <20260601-tp-reason-missing-v5-0-78a5b8fe6e67@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1258; i=sven@narfation.org;
 h=from:subject:message-id; bh=Z/R7ID/wCk/c3RTeU7x0yDMm7oqCKAx+UL4+8W91cNQ=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFmyAtUHoyymT77J+0wh5VZvQfb/bl65ImXOffHcztIMS
 48xffTsKGVhEONikBVTZNlzJf/8Zva38p+nfTwKM4eVCWQIAxenAEzkqDTDP1tbM2HlfaaZh9Pv
 PHI5rePtovtD18ZuqfiSqZ+yjkYvWM7wP8OkmTPnRJcyb5l1GusTy0+FS8M9yjuqJ/H8YlW7lNP
 DBAA=
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: 4YPOVXRHZJ755SMN34EUVNIYWYO4YJIE
X-Message-ID-Hash: 4YPOVXRHZJ755SMN34EUVNIYWYO4YJIE
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/4YPOVXRHZJ755SMN34EUVNIYWYO4YJIE/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

When an ack with a sequence number equal to the last_acked is received, the
dup_acks counter is increased to decide whether fast retransmit should be
performed. Only when the sequence numbers are not equal, the dup_acks is
set to the initial value (0).

But if the initial packet would have the sequence number
BATADV_TP_FIRST_SEQ, dup_acks would not be initialized and atomic_inc would
operate on an undefined starting value. It is therefore required to have it
explicitly initialized during the start of the sender session.

Fixes: 98d7a766b645 ("batman-adv: throughput meter implementation")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/tp_meter.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/batman-adv/tp_meter.c b/net/batman-adv/tp_meter.c
index e8941f75..0325b951 100644
--- a/net/batman-adv/tp_meter.c
+++ b/net/batman-adv/tp_meter.c
@@ -1045,6 +1045,7 @@ void batadv_tp_start(struct batadv_priv *bat_priv, const u8 *dst,
 	tp_vars->icmp_uid = icmp_uid;
 
 	tp_vars->last_sent = BATADV_TP_FIRST_SEQ;
+	atomic_set(&tp_vars->dup_acks, 0);
 	atomic_set(&tp_vars->last_acked, BATADV_TP_FIRST_SEQ);
 	tp_vars->fast_recovery = false;
 	tp_vars->recover = BATADV_TP_FIRST_SEQ;

-- 
2.47.3

