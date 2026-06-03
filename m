Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61E5BCD6E55
	for <batman-adv@archiver.kernel.org>; Wed,  3 Jun 2026 04:17:42 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id C11E184194
	for <batman-adv@archiver.kernel.org>; Wed, 03 Jun 2026 06:17:40 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1780460260;
 b=mbRnhFuABc3X410PTRGM66KkpB+Ba/DCeGhTqoTRQqTqnZRdYdek93v4U0V7n8lAVtFFm
 QJX1FYwE/M4yDTRBrXaQYLX/IMzud1AVX605ky2O/8Inzc0t3OlnOoTNlC693zT4ijRZoF1
 kWrtlKKjF+Yr1QD9iI2Ho1S3wTv//Mc=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1780460260; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=azEO77GZZbWKc+ygoKlVm4i8PA9OMAzAzZAR5MmbClM=;
 b=i0HRrmiygz5icYhyd3Y2vheRTMbHyAmx8Ucdg+6WKJDmC2NVIeA/uKXPTpVim6sEYoYbN
 Ddm2JFzb02iELR3YIPx6SQr9LtZBOrlK5Td5Fk9KaHjBFYfzUKzGex5z6CV/barOkBH054k
 LjFkagkUCIcZrNhY+t0fcphocDm6LWw=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id EA81783E9B
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 03 Jun 2026 06:17:30 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1780460251;
	b=zEJwS19rlhZj06vOvhG/8We4iXiExfmNBtWQcuTbeW6qCJRg62PZ1TOS3vP9O2V0SvEJyC
	BnY07wP2SOT7RxJXA3k9W0GGlq25l+2aIQP5bBg3M0WnRPmWNwnTZxKbsww4L+ymXSH/aA
	H8vZitgTdcTrJ3h4bPgw/y39AgrKeks=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=loeMxCe1;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1780460251;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=azEO77GZZbWKc+ygoKlVm4i8PA9OMAzAzZAR5MmbClM=;
	b=H9eqOYF+o4I/f+FhdfkIyAVzjVFbn0FeO5o+JsKCZMKj8r/FUNzhMZUeZqD9oL9guxbKw2
	210bW/ZaGUf2LUDBhMmI1kOhAyojAirDPm8GMwbm3bnq9jdI+ratEBmWO73OD4KOHF7+1u
	vPXxTfiawQyWAb9Xze1ETLeXgR/9zek=
Received: by dvalin.narfation.org (Postfix) id 0F12320268;
	Wed, 03 Jun 2026 04:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1780460250;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=azEO77GZZbWKc+ygoKlVm4i8PA9OMAzAzZAR5MmbClM=;
	b=loeMxCe1OQ3CiBwwKsVdfzTupyCzWubp4b9Ej8Sw7grzmH3BTIBED9wSq2wrbmtg+Q5Sfs
	Us2/ek/1XJvdIns+Fwke2+4mEQFhHV7gC3QOpKZmbMtGGhjs246a7zWy2JP4KAYxg9GWb5
	cUQHB2lIfy278MPU4en6VlrVgQt4q6o=
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 03 Jun 2026 06:17:15 +0200
Subject: [PATCH batadv v6 03/11] batman-adv: tp_meter: initialize dec_cwnd
 explicitly
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260603-tp-reason-missing-v6-3-7011620f93a5@narfation.org>
References: <20260603-tp-reason-missing-v6-0-7011620f93a5@narfation.org>
In-Reply-To: <20260603-tp-reason-missing-v6-0-7011620f93a5@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=990; i=sven@narfation.org;
 h=from:subject:message-id; bh=EIAOnvkJx0eeU0qgUDtq3uFHtvciDb7/x7xgWN0HMSs=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFnyq04brZhoszu1rK1V8E3Q9yV7F7t5uqa81pO7t195o
 VTH2i0LO0pZGMS4GGTFFFn2XMk/v5n9rfznaR+PwsxhZQIZwsDFKQAT2f2dkaHn+jSWso4lh5cu
 cDGsnZb64EnowVfn7t/N6ygRWeORrpfF8M808mzfn2dsTf+MJ/own2uy35nBVPn4rucv9kcaxrN
 1IlgB
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: BTN24FFQSP7SVSKKC6GHIPPISAGWQFRW
X-Message-ID-Hash: BTN24FFQSP7SVSKKC6GHIPPISAGWQFRW
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/BTN24FFQSP7SVSKKC6GHIPPISAGWQFRW/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

When batadv_tp_update_cwnd() is called, dec_cwnd is increased. But dec_cwnd
is only initialixed (to 0) when a duplicate Ack was received or when cwnd
is below the ss_threshold.

Just initialize the cwnd during the initialization to avoid any potential
access of uninitialized data.

Fixes: 98d7a766b645 ("batman-adv: throughput meter implementation")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/tp_meter.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/batman-adv/tp_meter.c b/net/batman-adv/tp_meter.c
index 8d730832..beabc264 100644
--- a/net/batman-adv/tp_meter.c
+++ b/net/batman-adv/tp_meter.c
@@ -1055,6 +1055,8 @@ void batadv_tp_start(struct batadv_priv *bat_priv, const u8 *dst,
 	 * mesh_interface, hence its MTU
 	 */
 	tp_vars->cwnd = BATADV_TP_PLEN * 3;
+	tp_vars->dec_cwnd = 0;
+
 	/* at the beginning initialise the SS threshold to the biggest possible
 	 * window size, hence the AWND size
 	 */

-- 
2.47.3

