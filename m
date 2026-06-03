Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE28CCD6E4A
	for <batman-adv@archiver.kernel.org>; Wed,  3 Jun 2026 04:19:50 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 3BF8A80B53
	for <batman-adv@archiver.kernel.org>; Wed, 03 Jun 2026 06:19:49 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1780460389;
 b=EaeRSc3i2eeW17irHE7v4A9DqyN5IJbSn3KAldh14NGWnQpb82SohRNVx3npF6tcQQJaT
 42jnSIyI3KzX6ruHr5y5IzU0UVEVOt6sXZOcFBv4Ui8Mq34Ay+K3IboVniFxpqOGzkw9FYb
 meEYu+vmzWQ8e7WUVfiRQEaD4ZD/VuI=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1780460389; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=CQHlWXPuMFe/uJJXgbD4unHgicnv2sBtv5FK8i86O9k=;
 b=gVL38t6kUpGkO+nEgN6xwDXeX5bE8eR3Rtymv0Mnmld2jTYjbgfK9oVFHKD9H6kIncmGF
 6JYWoxWeX3p1XKjZ+T4G0AFeNKs0jvCunauZ+WV+r5O6zzlq4y3B15YVmAr/94mP72AWGS1
 p9VNZrArHVC/8Xci3KKxqcCZYzmwhmo=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 4F02F83E33
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 03 Jun 2026 06:17:28 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1780460253;
	b=dMZ0ptSA8Wj1sCFRAP2AI+y3OUTTdwJ1KjwOhDHcVKXoUjPzpPUFIZhbSgoodJYKO2HRcZ
	/jCSNNVd1jzYulV1I7krvYlV7THQ0L+04S6bX7mHUqeM3TFarbYu/lMNAkOcm7bC2iiKcz
	8B+I5lYBG+O0Y6NqUgzwBQ2/HTXHtvM=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=uYsu2xqq;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1780460253;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=CQHlWXPuMFe/uJJXgbD4unHgicnv2sBtv5FK8i86O9k=;
	b=Uq3VjuTEMM9nJZgD1Ipygq916Bm+RYS4bvht/TKoIZ+fFHhutfBFXQauNRV6BmjJxEWtOe
	JNr0O+9I4hTaT+aPq90XNdiUzI4XJwbC0fVimDLhYekAYSLMSAyFf2FymvccZcPPYUgfNo
	PwwUtLjXuthMfVFcIWHmMoOInSm8Nf0=
Received: by dvalin.narfation.org (Postfix) id ED3A92023F;
	Wed, 03 Jun 2026 04:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1780460248;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CQHlWXPuMFe/uJJXgbD4unHgicnv2sBtv5FK8i86O9k=;
	b=uYsu2xqqBEoaH9WBgwDd2BO5P/jg1fgY5fvu/Y3eWfUHTISHdmlINX5NvClF/J4fmF/dXC
	XLDpEh2kfE4uNEyWj2e7JO9rtP4PMWtBNUk7B2vaUEbwHe3OzvyWOW7pdHkh+h16frkJcV
	SyZ4yEHKApX0MRkoTqcvqvGEosgnQg0=
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 03 Jun 2026 06:17:14 +0200
Subject: [PATCH batadv v6 02/11] batman-adv: tp_meter: initialize dup_acks
 explicitly
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260603-tp-reason-missing-v6-2-7011620f93a5@narfation.org>
References: <20260603-tp-reason-missing-v6-0-7011620f93a5@narfation.org>
In-Reply-To: <20260603-tp-reason-missing-v6-0-7011620f93a5@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1258; i=sven@narfation.org;
 h=from:subject:message-id; bh=4r+Fkxu1tk1k5xc3ZbiOu6/RTf+uzisDxdTuW5zmD0A=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFnyq04/Wrr9/+mwGs6z/w++cy36u9SnZz3LPtbpDa2Jf
 sFy6RoCHaUsDGJcDLJiiix7ruSf38z+Vv7ztI9HYeawMoEMYeDiFICJXMxi+F/Z/Ejlutu7KxtE
 Hvbmrft1mstx3uI6B967t25eWnezhP8Dwz/tPG/Rc4fzeJ8rN1xYtDDpPK/xmo89oibXEs6XZ+y
 Sy2ACAA==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: X7GA6TQEJ4UIIAV2VIKUYWWDURCTXX2Q
X-Message-ID-Hash: X7GA6TQEJ4UIIAV2VIKUYWWDURCTXX2Q
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/X7GA6TQEJ4UIIAV2VIKUYWWDURCTXX2Q/>
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
index 0e39ea33..8d730832 100644
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

