Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAFFDCA5FED
	for <batman@archiver.kernel.org>; Tue,  6 Oct 2026 17:20:59 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 03E248402F
	for <batman@archiver.kernel.org>; Tue, 06 Oct 2026 19:20:58 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1791307258;
 b=UpxsY++Zz9w8ghOUi2pjK+L9tAejmFVz8YSEBDQWKynvB/23Oip/12+pHqlc9S7eWoWW9
 506nKYJT6n49Rn5ibV6rAJ53ze1pdYWg78KMvq5qD87xbS+G5eBUmmBeuR3VjMO1lEL8VjR
 1osUo51dzOdLF3aE0AogcUeDxXXIj48=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1791307258; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=yCkWYhjbGOtOtElqSEd/EfCemS/v2I9AJtfyS1kEuZc=;
 b=c8rCphwg41AfEIq136/FWDchoBESrc+yajWGfnxnO+G87Jh3lEl7Hdj/7PY4g7APpbs94
 lkpnzxqvAyoOdCqZRqX3SL6mDDcbKa9tTrh9KdgQM3wrajkyDv5NMVoE3Z+4X5ka8cDT7oc
 LZT1jjRyaCtq8TR23WlK7QPHkOjP6Ro=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id DDEEF815D7
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 06 Oct 2026 19:20:37 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1791307247;
	b=ehu+4mfIZIK+hvP2gsaWu0Z9KqR+GeocEzca6IOCwmb1NDoyRMyvbxWrkG0rijJdxRSP1p
	t87r0AjYMwWNT+Y3P48KskiO5f37doIZ5WLvlZPZeX4ba44sDF8wPDMpLj8gzCz+7HCaoC
	J/SbnmsJHthVgZrE++RZ0dZ0M5/93/E=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1791307247;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=yCkWYhjbGOtOtElqSEd/EfCemS/v2I9AJtfyS1kEuZc=;
	b=lJFiaW9gEIBs7gagkboyL6lWvWRXtN/Z/beFrnJ/NYotjVcSvWddtLXGBAN0pwHNKjl5xP
	e/gZgwhS5ekvXshEQLzB8nCfV1Ednv/KnXXRlXVObptLMHn7umum8AQxgHBajv5pEkRbWj
	6ptkQvgzlAly7jNeoaW5i4AVDyRvLKw=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b="N/xIVhrF";
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 071E61FFBB;
	Tue, 06 Oct 2026 17:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1791307237;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=yCkWYhjbGOtOtElqSEd/EfCemS/v2I9AJtfyS1kEuZc=;
	b=N/xIVhrFaR/BycNfA0r5Vaa388wroii1L0UXPd1ZMjSHxrqKIwfD6H+lvUjFq8uXLC5TTD
	SUR727MIVRO69q0Uz60tVPV4PSQXMIPE33kVTxKKhLx7lrPZTw0OGPCdHZSKtVz9a/5fAv
	BSxeJo+TW6AAGjHlSyztmqfOXK8sVFE=
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 06 Oct 2026 19:20:21 +0200
Subject: [PATCH batadv] batman-adv: bat_v: fix probing in first 5 minutes
 after boot
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261006-bat_v-early-start-probe-v1-1-4206a407c062@narfation.org>
X-B4-Tracking: v=1; b=H4sIANQtxWoC/yWM0QrCMAwAf2Xk2UBbYWP+ioika6YR2UbSFWXs3
 636eAd3GxirsMGp2UC5iMk8VfCHBoY7TTdGSZUhuNB651qMlK8FmfT5RsukGRedI+OYOtcfkw9
 9F6DWi/Ior9/5DDWiVODy97bGBw/5u4V9/wBSWIGegwAAAA==
X-Change-ID: 20261006-bat_v-early-start-probe-fd7093d12972
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1244; i=sven@narfation.org;
 h=from:subject:message-id; bh=AwSMS6xw1xDy3ziQwKLW6B7v3F/9RIqSMG8AcV6hQHU=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFlHde9MDeRjYW61nP/eqLtVudLVOKRv92792xuuvWcKc
 3XVTg/sKGVhEONikBVTZNlzJf/8Zva38p+nfTwKM4eVCWQIAxenAEzEKIPhn/IByQqRA5tWPBT/
 lvH90TGlfu3ypE7hiPcPfs7f8Xmu1zpGhi8HnSR3ch7U6+Jc1/DN6o/rnU8ysekzbv4XaguL9D/
 rzgEA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: 4R3UIQYFUHFINCXXXEVKBB265WNDVGRB
X-Message-ID-Hash: 4R3UIQYFUHFINCXXXEVKBB265WNDVGRB
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/4R3UIQYFUHFINCXXXEVKBB265WNDVGRB/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

hardif_neigh->bat_v.last_unicast_tx is initialized to 0. And jiffies is
initialized on boot to -5 minutes (INITIAL_JIFFIES).
batadv_v_elp_wifi_neigh_probe() will therefore always reject the probe in
the first 5 minutes.

To get it started earlier after the first detection of a neighbor, it is
necessary to initialize the last_unicast_tx when a new hardif_neighbor is
detected.

Fixes: cdc4545350d1 ("batman-adv: keep track of when unicast packets are sent")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/bat_v.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/batman-adv/bat_v.c b/net/batman-adv/bat_v.c
index 596889b3..4a25e513 100644
--- a/net/batman-adv/bat_v.c
+++ b/net/batman-adv/bat_v.c
@@ -143,6 +143,7 @@ static void batadv_v_iface_update_mac(struct batadv_hard_iface *hard_iface)
 static void
 batadv_v_hardif_neigh_init(struct batadv_hardif_neigh_node *hardif_neigh)
 {
+	WRITE_ONCE(hardif_neigh->bat_v.last_unicast_tx, jiffies);
 	ewma_throughput_init(&hardif_neigh->bat_v.throughput);
 }
 

---
base-commit: 0eaac0f4187bc9b69b41d90998fd7b93ab07e53e
change-id: 20261006-bat_v-early-start-probe-fd7093d12972

Best regards,
--  
Sven Eckelmann <sven@narfation.org>

