Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 921EFCA5FED
	for <batman@archiver.kernel.org>; Tue,  6 Oct 2026 17:43:21 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id DD73C82684
	for <batman@archiver.kernel.org>; Tue, 06 Oct 2026 19:43:19 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1791308599;
 b=iaubQkD4rtHA61O9cWeeywUiA6FN6SJ4xYLLPka3Q3wMwyH45OrdlhzpiSqXdZxCeCs15
 dnEtQXLSSfyasT0l1Wx1eZ9Zv12sXUKmymKdAYBFmsBmSK4wkrS05psG7zEkONIIKZqFRYX
 /jepM/+ZWmGrogmHbutzz2amQc8ao/M=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1791308599; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=sLMsTFreGPGyXMpJjAoLN7fGXeOrOBgnDedsfzuvwR8=;
 b=lAv5VJHyfcALCoipNnQXHW79vuPs2DaZ36b4d/cX35FMLOxwWaQg+6urJ1D1Ut6K+ihB4
 h/jCccII5kxruBucPOHzq2gKpKfYUruxiHlissWC9yo6tBaVZPhjr5iJy6sjN95lGM9MjOd
 toDPa6mPXuHLSrkv81OxPWOfcAATazs=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 1F3BD801AE
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 06 Oct 2026 19:42:59 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1791308590;
	b=foJ7QxLd4Ud8HxHrk0YJGXWnN/Vmv/3fgnajB5eNDO9PuB8JXl1z/hCFEYuyMbYV8zQb6s
	wcB9MfwkfSuB1WPiuLT4Xzzbf8qBcZQVvPEd3FgDeOHjxw5SPNh7+S/4YMkrHC9MW+ff3P
	rkeC/P0/1bYtlnuC4lJal9L6m3ZoJlo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1791308590;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=sLMsTFreGPGyXMpJjAoLN7fGXeOrOBgnDedsfzuvwR8=;
	b=Etso8z1EwMeomYBMC0jQjk2B0ouImxARJ+hMZq7Vah9rjejKzy/gxEX3WGheZ4PTHiODzf
	S9d63N/mxzwVZrR7bv68Sjh40ywpbYHJnqiHrtkpJBA+AzPl4/HDbFnJkS1c4Wb2DcsWtG
	mb8nGEX6Y89APhMMSzISuONdAvIiUhk=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=zMaRonap;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 544B020515;
	Tue, 06 Oct 2026 17:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1791308579;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=sLMsTFreGPGyXMpJjAoLN7fGXeOrOBgnDedsfzuvwR8=;
	b=zMaRonapOc1mbt5sPxq0UTCjCoXcInQ52QMkm19UVrhHu892U3rPbkl1mkZNlhYS4QcMly
	TN0GsHhL2i+pBcg00d2PIrZA+x3xOv8aeF5F186bf6yyzEHJfRWsQ6HYX1Bf/v/Pe14i/C
	Jj6eCWOWHe5FB21mZXa/i4z0RDVyKOc=
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 06 Oct 2026 19:42:48 +0200
Subject: [PATCH batadv] batman-adv: tpmeter: fix u32 truncation of reported
 bytes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: 
 <20261006-tp-total-bytes-truncation-v1-1-54143d6fde9e@narfation.org>
X-B4-Tracking: v=1; b=H4sIABczxWoC/yWMQQrCMBAAv1L27EJabEj9injYTVaNSFqSbamU/
 r1RjzMws0GRHKXApdkgyxJLHFOF9tSAf1J6CMZQGTrT2dYYizqhjkpv5I9KQc1z8qS1wsGduQ/
 s7GAd1H7Kco/r730FJqWwwO3vy8wv8fodw74fnZtMqYUAAAA=
X-Change-ID: 20261006-tp-total-bytes-truncation-984b5db86968
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sashiko <sashiko-bot@kernel.org>, Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1217; i=sven@narfation.org;
 h=from:subject:message-id; bh=5QX/bbkwhGvvoTsNQavXzJvgsT0mGDLDZpdpQ06uBZ4=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFlHjRW0Uk3Z13NoLg6KednYsWmOasBqif8TtzzSF9jzd
 cGkzdKsHaUsDGJcDLJiiix7ruSf38z+Vv7ztI9HYeawMoEMYeDiFICJ+O5gZNj3W178d0X2OtF1
 9y4fSFkwm2cB7zIxOe/KoATL8+VbjFcz/GR0WThn468J+enRDwR1blldqz+/ZlL6tArZ3ZJJ+60
 yeVgB
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: VXVXBJDH6ZMFZTMC76CO7JRIUKFHMH7C
X-Message-ID-Hash: VXVXBJDH6ZMFZTMC76CO7JRIUKFHMH7C
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/VXVXBJDH6ZMFZTMC76CO7JRIUKFHMH7C/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

When more than 4 GB are transferred by the throughput meter,
batadv_tp_batctl_notify() will cut of the upper 32 bit of the u64 counter
and thus under-report the actual transferred bytes.

The data type of the temporary storage variable must therefore still
continue to use u64.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/bug/linux-08bb3be4-6c6a-452d-b4e4-606940c6cfa5
Fixes: 98d7a766b645 ("batman-adv: throughput meter implementation")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/tp_meter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/tp_meter.c b/net/batman-adv/tp_meter.c
index 022eb13e..56feb02d 100644
--- a/net/batman-adv/tp_meter.c
+++ b/net/batman-adv/tp_meter.c
@@ -221,7 +221,7 @@ static void batadv_tp_batctl_notify(enum batadv_tp_meter_reason reason,
 				    unsigned long start_time, u64 total_sent,
 				    u32 cookie)
 {
-	u32 total_bytes;
+	u64 total_bytes;
 	u32 test_time;
 	u8 result;
 

---
base-commit: aba49616932df5bb5c3f43e684248cb4bf72218e
change-id: 20261006-tp-total-bytes-truncation-984b5db86968

Best regards,
--  
Sven Eckelmann <sven@narfation.org>

