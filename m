Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE169CD5BD1
	for <batman-adv@archiver.kernel.org>; Mon,  1 Jun 2026 04:55:40 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 4AADA841E3
	for <batman-adv@archiver.kernel.org>; Mon, 01 Jun 2026 06:55:39 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1780289739;
 b=GIefDe8yUhMULwshhmiYUfiaZstIcSNJC9UpJV42fqH7sZUlaFs1v5jb7JfShHdUBzTXx
 TwdbzTsAmKZSV3gfNOqiRNTYfkXiamZlSOsENZM27a9gl+je5nRgkTS0lH0RJ3NS9wd4yHU
 HszCHsrbgUxp+05CFByJLUzf4pVYfD4=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1780289739; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=9NP1Wtbh6WWJlAadv/8GX2qlLinuAxlul46x+KM9jOw=;
 b=tlByK3ryXfEPlt6oKowrdJNpBXKgj8awmEDPAyECgqtgjL6AfxVJyFYVRK7hXC0fJpvbs
 /s2u7NJYy3sYhKPB6UFnHWAYFR8Lnh8OkH8/EaFwMPCv2m3+B0817uY3Izmh1QT4Q0Tvex1
 uz5FaJyA+JsF4o5FzYi32cmZi3Ic0lw=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 04CFA82E04
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 01 Jun 2026 06:54:25 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1780289666;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=9NP1Wtbh6WWJlAadv/8GX2qlLinuAxlul46x+KM9jOw=;
	b=E5k6LfVj/3VSJmRVg0RdtN3Y15J5AY7dLoAf6n6193qgkIhhCyTZgbKoqhj9qw2ETKE3zx
	BMj1gUlxyNHn+ZBL+ecLf2sf2sk+Mq71Y0OjcAw8HavpkQrxx5bhJin/XrVEfMh5Hn9t+Q
	Z82wUIZgZlducfuzshBOFaxs0K0limE=
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1780289666;
	b=NhUfvBs4nOXTmt5VshMJKhVSbmuQZuscu6Neb9C3l8HsfRIvfJo7Mz+0a5I+5fHY7sOB8l
	tr0+AdLttRQKy3L69GWq0XR/x9P3K6L1+YE/1unp7E1HVfH05WBpDtco9B3dOwnvyKHKZ1
	14Hj1CoPrKV9zga3XgbMImVZT0WBcSo=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=oesOSN0K;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 9896B20268;
	Mon, 01 Jun 2026 04:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1780289665;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9NP1Wtbh6WWJlAadv/8GX2qlLinuAxlul46x+KM9jOw=;
	b=oesOSN0KlMF1wNw2vrqfByww3vZZqrWC6EUqM6W0oLcr+1UXL1ZrbXsK/aQt6Evc4bd8vb
	9vCWKF01DZkzB+jAgMYdVbm1A4p0oCkhxGxwyGDgMW5bxycJDdlwQ0Zyz+nEkgTkBPmVCF
	MSf9iuL+vOtVSZWl7Nml8RGxfvs9zHo=
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 01 Jun 2026 06:54:15 +0200
Subject: [PATCH batadv v5 1/7] batman-adv: tp_meter: keep unacked list in
 ascending ordered
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-tp-reason-missing-v5-1-78a5b8fe6e67@narfation.org>
References: <20260601-tp-reason-missing-v5-0-78a5b8fe6e67@narfation.org>
In-Reply-To: <20260601-tp-reason-missing-v5-0-78a5b8fe6e67@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1312; i=sven@narfation.org;
 h=from:subject:message-id; bh=FNBDbdS1MXMPx1UoVJ1QWcN9UpWNhV3MQtn6eQTKg8w=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFmyAlV31d9N/BLmeSzuZ72V86vkSTvthHnvntu/4pTux
 3/z33RM6ihlYRDjYpAVU2TZcyX//Gb2t/Kfp308CjOHlQlkCAMXpwBM5FUqI8OxTO+fp7ZJxmn8
 /uv6pPH27rKifsFTzJPec+an75+9/44MI8P9AOtMh7IGftkpCjsnNtxSnsx68eLhBdXdgfVcR48
 3JTMAAA==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: 2NWP5OML6FQQ6MCBDOIYFDSVY6OQVAIA
X-Message-ID-Hash: 2NWP5OML6FQQ6MCBDOIYFDSVY6OQVAIA
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/2NWP5OML6FQQ6MCBDOIYFDSVY6OQVAIA/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

When batadv_tp_handle_out_of_order inserts a new entry in the list of
unacked (out of order) packets, it searches from the entry with the newest
sequence number towards oldest sequence number. If an entry is found which
is older than the newly entry, the new entry has to be added after the
found one to keep the ascending order.

But for this operation list_add_tail() was used. But this function adds an
entry _before_ another one. As result, the list would contain a lot of
swapped sequence numbers. The consumer of this list
(batadv_tp_ack_unordered()) would then fail to correctly ack packets.

Fixes: 98d7a766b645 ("batman-adv: throughput meter implementation")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/tp_meter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/tp_meter.c b/net/batman-adv/tp_meter.c
index 0fc4ca78..e8941f75 100644
--- a/net/batman-adv/tp_meter.c
+++ b/net/batman-adv/tp_meter.c
@@ -1325,7 +1325,7 @@ static bool batadv_tp_handle_out_of_order(struct batadv_tp_vars *tp_vars,
 		 * one is attached _after_ it. In this way the list is kept in
 		 * ascending order
 		 */
-		list_add_tail(&new->list, &un->list);
+		list_add(&new->list, &un->list);
 		added = true;
 		break;
 	}

-- 
2.47.3

