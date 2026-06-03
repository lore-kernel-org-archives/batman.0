Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B6B0CD6E4A
	for <batman-adv@archiver.kernel.org>; Wed,  3 Jun 2026 04:19:08 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 7F8E083ED1
	for <batman-adv@archiver.kernel.org>; Wed, 03 Jun 2026 06:19:06 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1780460346;
 b=kN8PXvDjDwvZoC+Z2/51s4G//fNle9xXaGwggHDmdENalOya+OwAGljFYIE7ZMnhzos8s
 zzQuKj43UZqCK14sIVrLGfZDjDh6lgl+MDJ55DSOj1pYD1s4j/YDCYytSa53SpxDBumB/nz
 xcyyKNzRmNllbN2b5Yy7y5Fqt/vbUe0=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1780460346; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=OPQgXeutFk0UfIx7fdZY00PcaFLzNv1JZhdZBzqRF5g=;
 b=SCOs6JasThTFwEDGnWFzmDxRnJIDJ/L6f9fhhd1XJROzIioAYgjrdVXo949Nk6OdczRV1
 iE5JcL3p91av91VIffSFnjVzQfWGtS6oCz5rG42miIvbJzwWKbx8dHBni7T4Y8R3bCo1F1D
 DBtCudfdMviK62VnRjonG+jgBBFAFx4=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id B6E9680686
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 03 Jun 2026 06:17:32 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1780460252;
	b=TWoPNULqUJ5pj7QcNGDh5D9tMdFfqdWdnNU7keWcMu8Hqv8sHxXjqpPTz97JUCTvQxDayc
	4Q1xY+ny1w3J2fhYOvmOBJKAvZaGFxzeyllMsEv/au5oLvLS0hrSB3jBoUPfndM1mhLIpj
	OxkDYhFAlUwf43lRvwZXtmoem/iKKXA=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=gxxhtLui;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1780460252;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=OPQgXeutFk0UfIx7fdZY00PcaFLzNv1JZhdZBzqRF5g=;
	b=OAsXOmNOhpZ3LGQTZlvXRU9RG//x2AbKTygaDzQyGKw2MDTE3pnu8R/XUoLvvzoozdAMtR
	TnlCT6Hn8MSFcnpn2n2hq9oYhyEcI4d2qISawUkyGBe17dOAqTC5C1VpUoccoeNPbQ9tmt
	p/GEgYvx4umcKrnlzUmoxMaG0suqGAA=
Received: by dvalin.narfation.org (Postfix) id 72F5A201A1;
	Wed, 03 Jun 2026 04:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1780460252;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OPQgXeutFk0UfIx7fdZY00PcaFLzNv1JZhdZBzqRF5g=;
	b=gxxhtLuigb6KeVEK8bGTBJFjKo119wstGak158ijza5ol0BHN11aGY4DqCM6QksF/fErxx
	rVzXVZ1Q7rJgklJWItuJhxy0Bbsz6cMeBTW0B9TQIXC3mRdjFr0LJn4a+27AqkZhqgW+eu
	r9/Mu7R4dRgYffSkfHDbRrTOUPNteQU=
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 03 Jun 2026 06:17:16 +0200
Subject: [PATCH batadv v6 04/11] batman-adv: tp_meter: avoid window
 underflow
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260603-tp-reason-missing-v6-4-7011620f93a5@narfation.org>
References: <20260603-tp-reason-missing-v6-0-7011620f93a5@narfation.org>
In-Reply-To: <20260603-tp-reason-missing-v6-0-7011620f93a5@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1713; i=sven@narfation.org;
 h=from:subject:message-id; bh=mgCtEoYVOwUXlAmoW+5OBkeJj8x17lmOiKzH8brDKiA=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFnyq047Bx9M6Qw69djCYu88u+rHIg9Z2RQudZktEvfff
 a9E9Vp2RykLgxgXg6yYIsueK/nnN7O/lf887eNRmDmsTCBDGLg4BWAijq8YGR7G5EpWSXyLdN3h
 fPde82IzFaNcb4VrzdMtfq37uL/KypWR4eB8jpg5T25I+fpkHmTuKkxXP+55P1pN6D/zT+vXy+z
 mcQMA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: Q74QMWVPQVXZRTDL6RJ7WR5G6HVREVY7
X-Message-ID-Hash: Q74QMWVPQVXZRTDL6RJ7WR5G6HVREVY7
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/Q74QMWVPQVXZRTDL6RJ7WR5G6HVREVY7/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

In batadv_tp_avail(), win_left is calculated with 32-bit unsigned
arithmetic: win_left = win_limit - tp_vars->last_sent;

During Fast Recovery, cwnd is inflated and last_sent advances rapidly. When
Fast Recovery ends, cwnd drops abruptly back to ss_threshold. If the newly
shrunk win_limit is less than last_sent, the unsigned subtraction will
underflow, wrapping to a massive positive value. Instead of returning that
the window is full (unavailable), it returns that the sender can continue
sending.

To handle this situation, it must be checked whether the windows end
sequence number (win_limit) has to be compared with the last sent sequence
number. If it would be before the last sent sequence number, then more acks
are needed before the transmission can be started again.

Fixes: 98d7a766b645 ("batman-adv: throughput meter implementation")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/tp_meter.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/batman-adv/tp_meter.c b/net/batman-adv/tp_meter.c
index beabc264..d0e9a53f 100644
--- a/net/batman-adv/tp_meter.c
+++ b/net/batman-adv/tp_meter.c
@@ -817,10 +817,15 @@ static void batadv_tp_recv_ack(struct batadv_priv *bat_priv,
 static bool batadv_tp_avail(struct batadv_tp_vars *tp_vars,
 			    size_t payload_len)
 {
+	u32 last_sent = tp_vars->last_sent;
 	u32 win_left, win_limit;
 
 	win_limit = atomic_read(&tp_vars->last_acked) + tp_vars->cwnd;
-	win_left = win_limit - tp_vars->last_sent;
+
+	if (batadv_seq_before(last_sent, win_limit))
+		win_left = win_limit - last_sent;
+	else
+		win_left = 0;
 
 	return win_left >= payload_len;
 }

-- 
2.47.3

