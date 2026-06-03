Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3957CD6E4A
	for <batman-adv@archiver.kernel.org>; Wed,  3 Jun 2026 04:21:23 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 9337D807CF
	for <batman-adv@archiver.kernel.org>; Wed, 03 Jun 2026 06:21:22 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1780460482;
 b=MvWWVY204ShzRY1lordsKZne2kvTAcUNMo6GH4MozO9O7MR6XmMFOq39GfMVxN18vxWbC
 yZ7GLj4Vf/Gg4YXxQrZxl3Zo+omRTRqVxHn8KT1Ll46qgQu4u1+TbTPced2oWjLV4dSvu9G
 DRnJP+ti0ea7YcC2tcCqQcaMYsBENio=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1780460482; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=UqRk6I1ba2c1OIRWXR+SfgMgjHFdB4Cr/LGU0D9T67s=;
 b=xYyL9AEOGTHBm5XYQHFS+Wjlnl8dYRebKKTRA8mnsZIA5zLgHDD3Mt4Fm+xnkCXNqMu8X
 feU9uKmQqLGaM9nRqPrNMWmGf1MMGUD+boQMeAF2kLxzFr/p+L/EGtiD2K9n8Q8S2VEVLTI
 IX9NN7ISp4lZTXCFnEJKHOGWZBhtbCE=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id CC5CC81348
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 03 Jun 2026 06:17:54 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1780460274;
	b=HTMl7uMybB6P+cEswfWe3L9kSVNNRiTs4Zg32tBQM2dOxCky0ZVNeipZeGo4KaPBCWIeWe
	77NmrIXhHI3z2h6M94WTcH/wcZICmX4lUSJB7F4EHf9MIGWZpxXQo8629JvgZtbJZomWTE
	mVTA0j4nC3kCehXINEmSmfRUNzFhUCw=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=OPvbd9U+;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1780460274;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=UqRk6I1ba2c1OIRWXR+SfgMgjHFdB4Cr/LGU0D9T67s=;
	b=pVlkWZCnFMKndFTcCHUtihj0wGu5dn5oG+8vM+FomTP/duKUE8O7jFoaj2IU+gmP7EhjlK
	LDetWenAalAcaWgF0Kur2is0yRg887RCdcZpySt014CU0c7bGay6u+Td9n9Z0D87K16nrN
	dRaiPG6WUL9MoDL/JlFHzfC2r5SRcd4=
Received: by dvalin.narfation.org (Postfix) id 6E6D220131;
	Wed, 03 Jun 2026 04:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1780460274;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UqRk6I1ba2c1OIRWXR+SfgMgjHFdB4Cr/LGU0D9T67s=;
	b=OPvbd9U+rdLDHqnyimDXS1xHM+Srz9T5rktntjoDgWDlUlNjc1EbofocKylnHhkdCA0Oh0
	3/eCGSHSwfoTxNPVTZu6BrcQHSP4+y1DDvURMep2c5Cyvr+qiDUYpXYclsijQzI6nYLLmA
	HelDeRVwuc19VdU68Ve6tn6THBdGVJU=
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 03 Jun 2026 06:17:17 +0200
Subject: [PATCH batadv v6 05/11] batman-adv: tp_meter: avoid divide-by-zero
 for dec_cwnd
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260603-tp-reason-missing-v6-5-7011620f93a5@narfation.org>
References: <20260603-tp-reason-missing-v6-0-7011620f93a5@narfation.org>
In-Reply-To: <20260603-tp-reason-missing-v6-0-7011620f93a5@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1965; i=sven@narfation.org;
 h=from:subject:message-id; bh=pfuF5zOCUOgY/szeJ57JoGemkyb1CkXGQWBTBc1wvrY=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFnyq07ruixrPD5v9hbNoisuW+PXRF19dIf15sUV23+dt
 VTkKfMR7ChlYRDjYpAVU2TZcyX//Gb2t/Kfp308CjOHlQlkCAMXpwBMxCaT4X9leMaMt3X5Bg7T
 eRUKVnB/elD6v3DaNubX13oT/p33On+VkeHttuRmjYoliStm7/91dU6XS/H9RDOXn4u3sNxyXeU
 seYoRAA==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: RPVRIHRFEVNZ3KI7QW4BPFDZDNIQA6JQ
X-Message-ID-Hash: RPVRIHRFEVNZ3KI7QW4BPFDZDNIQA6JQ
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/RPVRIHRFEVNZ3KI7QW4BPFDZDNIQA6JQ/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

The cwnd is always MSS <= cwnd <= 0x20000000. But the calculation in
batadv_tp_update_cwnd() assumes unsigned 32 bit arithmetics.

    ((mss * 8) ** 2) / (cwnd * 8)

In case cwnd is actually 0x20000000, it will be shifted by 3 bit to the
left end up at 0x100000000 or U32_MAX + 1. It will therefore wrap around
and be 0 - resulting in:

    ((mss * 8) ** 2) / 0

This is of course invalid and cannot be calculated. The calculation should
must be simplified to avoid this overflow:

   (mss ** 2) * 8 / cwnd

It will keep the precision enhancement from the scaling (by 8) but avoid
the overflow in the divisor.

In theory, there could still be an overflow in the dividend. It is at the
moment fixed to BATADV_TP_PLEN in batadv_tp_recv_ack() - so it is not an
imminent problem. But allowing it to use the whole u32 bit range, would
mean that it can still use up to 67 bits. To keep this calculation safe for
32 bit arithmetic, mss must never use more than floor((32 - 3) / 2) bits -
or in other words: must never be larger than 16383.

Fixes: 98d7a766b645 ("batman-adv: throughput meter implementation")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/tp_meter.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/batman-adv/tp_meter.c b/net/batman-adv/tp_meter.c
index d0e9a53f..7760ace7 100644
--- a/net/batman-adv/tp_meter.c
+++ b/net/batman-adv/tp_meter.c
@@ -154,9 +154,12 @@ static void batadv_tp_update_cwnd(struct batadv_tp_vars *tp_vars, u32 mss)
 		return;
 	}
 
+	/* prevent overflow in (mss * mss) << 3 */
+	mss = min_t(u32, mss, (1U << 14) - 1);
+
 	/* increment CWND at least of 1 (section 3.1 of RFC5681) */
 	tp_vars->dec_cwnd += max_t(u32, 1U << 3,
-				   ((mss * mss) << 6) / (tp_vars->cwnd << 3));
+				   ((mss * mss) << 3) / tp_vars->cwnd);
 	if (tp_vars->dec_cwnd < (mss << 3)) {
 		spin_unlock_bh(&tp_vars->cwnd_lock);
 		return;

-- 
2.47.3

