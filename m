Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DA65C53219
	for <batman@archiver.kernel.org>; Tue, 28 Jul 2026 21:02:38 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 6AA9E80CBC
	for <batman@archiver.kernel.org>; Tue, 28 Jul 2026 23:02:32 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1785272552;
 b=ljikxjiDpsziJE/+ave4myJWp++yoAXJpMkQPFaFM4Go0U2ziHtdRrCFyoqLcKhSMsbi/
 iSHK7ZWF4MVNUhWifFbvBh6EV/ttxbpzRHmEjWi5tVLH/6D05AtUmW/M8z9W5PI8g0UKcgz
 WWFdLa51KIqcxTv9kNjrSla4CA6NIL8=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1785272552; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=hnNvMfxYloXS2ONuzZKwSIhQKRqydxbgUtu1nAQWIAY=;
 b=1bSMNbSMVFEMWvIRHOU4P6Z/AnauIpWuSxpJe4mghNlnoQ3Tsl/tJD3P7aKjlThm5u1gi
 jK0J9kED2OZpcA1hF9r1l1u+PzuC6fe3XBch+tfgGf4cRg+lfMQbYNv6pvWCKJ7AyQ5yuMr
 xtSgdDTmYDKOCxJB/8ULU70UOdfrWvA=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 53FFD84121
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 28 Jul 2026 18:56:31 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1785257791;
	b=Pl41ctqo2UCHBOtLvhY/TYNfqiXxzc5yZf+gPWElaAbfNZ06j14kQE/3GCAGrHNbtJp+U3
	PSylOSlCydu/gr72fS/f0Kp/zwpnaZpyJ5kRALQ4fnsTFpBhOcpTNB4gHSdmknjJ8esZ9D
	rebmEMgvCdBMG+4RWBvxCjiJFia+uis=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1785257791;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=hnNvMfxYloXS2ONuzZKwSIhQKRqydxbgUtu1nAQWIAY=;
	b=GOI6qDrGiq7Oez9pnP5D5Z+J9bH1JirlBgdbSxL3ARktGgU6Fpvc1RcqoUt2tgnS7MXDmj
	tLpkRv0Xf72Eo0Ckl1EIdvxMpxn3YxbEFCZVfJThRV8xSTBBfLBHCEJw7FcT8aEsQgtHwA
	RKw1u7beZLMwHhMGP+tkA5GZaJeRHss=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=AYhTEGKg;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 8548B1FF0E;
	Tue, 28 Jul 2026 16:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1785257786;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=hnNvMfxYloXS2ONuzZKwSIhQKRqydxbgUtu1nAQWIAY=;
	b=AYhTEGKguk9JXdiDNzNksXD74fGWg46KI5SbROHYJz8x9cjMW/o2SddiD99ErQRK3IitST
	G5HV7GUy/qm8nRYDykfCSnX8qNBssTl47Ub3qxN9tuTZVhjVtV6ipTz+tPvHSpbQO4/Cuy
	vBarFNe9PfA0gMqEWzvQE7SFDis3vYM=
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 28 Jul 2026 18:56:01 +0200
Subject: [PATCH] alfred: seed the random() generator for transaction IDs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260728-bugfixes-random-v1-1-9a34cfb4e492@narfation.org>
X-B4-Tracking: v=1; b=H4sIACDfaGoC/yXM0QpAMBTG8VfRubaaJZZXkYvZzjjKaAcpeXfD5
 a+v/3cBYyRkaLILIh7EtISEIs/AjiYMKMglg5KqkrXSot8HTyeyiCa4ZRZOoy116WXlDaRqjfj
 tKWq737z3E9rtvYH7fgAYWKOmcwAAAA==
X-Change-ID: 20260728-bugfixes-random-d8ec484f06fa
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=966; i=sven@narfation.org;
 h=from:subject:message-id; bh=iEPyjNm5776+KIhEvA5lN9hOUkQuMHLjspUHR2++XNI=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFkZ93XOndDVe23++4C7lZWNk+LB0PpvTSUfJee/efB3+
 kYbdhHujlIWBjEuBlkxRZY9V/LPb2Z/K/952sejMHNYmUCGMHBxCsBEfFIYGfaYx/dcNnlbrX5F
 98WWYNkJt6Wtgsrzju47cGrX0yrPnJeMDA1hG9LCT3BxswvWTD0tt+3D0iV7Zufb9248nLw7v0x
 EmxMA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: 7IZNIQ47FA37GR2CVTD773YI2KLLUKIO
X-Message-ID-Hash: 7IZNIQ47FA37GR2CVTD773YI2KLLUKIO
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/7IZNIQ47FA37GR2CVTD773YI2KLLUKIO/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

time_random_seed() initialized the PRNG with srand(), but the only
consumer, get_random_id(), draws its values from random(). srand()/rand()
and srandom()/random() are two independent generators which can have
separate state; seeding one does not affect the other.

Seed random() with srandom() so the generator that is actually used gets
the computed seed.

Fixes: fcfe26c690ce ("alfred: Add transaction management block to push_data")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 util.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/util.c b/util.c
index b00b953..171adb4 100644
--- a/util.c
+++ b/util.c
@@ -47,7 +47,7 @@ void time_random_seed(void)
 		s += c[i];
 	}
 
-	srand(s);
+	srandom(s);
 }
 
 uint16_t get_random_id(void)

---
base-commit: 462a0cf40615f62e0912c36d72a75accbb26f5ee
change-id: 20260728-bugfixes-random-d8ec484f06fa

Best regards,
--  
Sven Eckelmann <sven@narfation.org>

