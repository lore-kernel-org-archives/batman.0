Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75F5AC43458
	for <batman-adv@archiver.kernel.org>; Fri,  3 Jul 2026 19:04:54 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id D74BC84052
	for <batman-adv@archiver.kernel.org>; Fri, 03 Jul 2026 21:04:52 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1783105492;
 b=uqo2/4FKbJNEr5abXSpzFlhelep0cNgc/b1ArJBqL6CYTynWetgIykaeaQPmOaTGdg7/m
 oHsaURa8Av1vy84uZte3Zn6Ws9wR2F+D9hGgShKZUrl2EGqvH0VEpJ+td5W1sd2yjhGO03l
 xHReYJEaQiV+Mhr3ghhsnhGtOsKW3u0=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1783105492; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=3B9PzGIOyOhWn4nnKtriRJTrxBEiNVwayk+InVbRlDQ=;
 b=KfKKRWNfWEGDTj5z7DDjejBiIpm9GAOvg4V+39cWGC8nkoxNnnLPOBwArSq3wwmGm1m56
 zmkwEXhhAVtq/zHOesLGdxt2Dop+TD+kT0y8Rri5pYwtp/7BbjX+KLP2dxFWSxLMLzd8BCo
 SAzryaEgTcvR0rXl1o21RxWoCN9WpHM=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id AC79180BB6
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 03 Jul 2026 21:04:21 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1783105471;
	b=MP16C5vclUNl5LAYFRiYDwmPEhPpYs/fZ39QTz6AYCcjTQkjYev+fw94DizdX+Nw89TPC6
	U6+z406Nhk/5qvA3R7Pza+KhMxhIwmCoxQ2sT3tuhgvedBEpYDAJVzc0+jdU9Lb7gZa4XP
	JGKsDUb1goRbtSWaWoT61k3DmIdTy+g=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1783105471;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=3B9PzGIOyOhWn4nnKtriRJTrxBEiNVwayk+InVbRlDQ=;
	b=sFEZXbg3fdx4gaMiz4wVcexOXojSCBCXgagTQPjRYX3j2PQXGvkcxtTWYm/JAZyKM2J+qf
	oEXZqE3bqQ8pQmGi68p6/LJaw/9p9UgemLx6DV8c+OGFUxA9E9W4V9OQCSeht+ROxKCvJJ
	9cUfm43tVWhUVl2IBpw+KYwd9vlFc9A=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=m3nY6u3M;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id DB8FC20477;
	Fri, 03 Jul 2026 19:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1783105461;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=3B9PzGIOyOhWn4nnKtriRJTrxBEiNVwayk+InVbRlDQ=;
	b=m3nY6u3MadLEJVtlXSIQVSQUAAjFcAgC4lDVkx8ZkqodzoRuMrGUDp3Ce543qE9WXSZ9kj
	3W+v+IdO2aZnMB0xQxoyyesilAiBwwC4GdTYghNLYPeomfHfZZZl3fgqdX6tCZVTql+Q/y
	btjtVs/R+RJYspF8NPSHwLaLdkoPJRM=
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 03 Jul 2026 21:04:03 +0200
Subject: [PATCH batadv] batman-adv: frag: fix primary_if leak on failed
 linearization
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-frag-tx-primary-leak-v1-1-7dfaedb5aeb9@narfation.org>
X-B4-Tracking: v=1; b=H4sIAKIHSGoC/yWMyw6CMBAAf4Xs2U1qIYD+ivGwtFtYH0i2lWAI/
 26V40wys0JkFY5wLlZQniXKa8xwPBTgBhp7RvGZwRpbm8aUGJR6TAtOKk/SDz6Y7lg7S/4U2qq
 iEnI6KQdZ/tsLdJTIz3DdfXx3N3bp94Rt+wLjYjmtgAAAAA==
X-Change-ID: 20260703-frag-tx-primary-leak-6c2ad9f844a3
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sashiko <sashiko-bot@kernel.org>, Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1119; i=sven@narfation.org;
 h=from:subject:message-id; bh=Mw+zcg0UtSsskeciFvtiFOiPwm8eclPuTqoGwsd5cv4=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFke7Kti630+2jLPLTSev3lBe1Go+tncZ9utdOJMH4vs8
 NJiSFjbUcrCIMbFICumyLLnSv75zexv5T9P+3gUZg4rE8gQBi5OAZhIZyAjw5UkWYMolyppN3WN
 4F3RXO93ZW7qeG639Ij5DxnL3sbjuxn+O/+MP7n4SY/28+DErvzntXb9navuWhy+vnVX3OsvVic
 1WQE=
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: XLJS2ZW3I2O4Q3LOHD3WG6NG47QN6CXZ
X-Message-ID-Hash: XLJS2ZW3I2O4Q3LOHD3WG6NG47QN6CXZ
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/XLJS2ZW3I2O4Q3LOHD3WG6NG47QN6CXZ/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

If the skb has a frag_list, it must be linearized before it can be split
using skb_split(). But when this step failed, it must not only free the skb
but also take care of the reference to the already found primary_if.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Fixes: d467720acaf1 ("batman-adv: Don't skb_split skbuffs with frag_list")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/fragmentation.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/fragmentation.c b/net/batman-adv/fragmentation.c
index e2c74ae6..5606e284 100644
--- a/net/batman-adv/fragmentation.c
+++ b/net/batman-adv/fragmentation.c
@@ -551,7 +551,7 @@ int batadv_frag_send_packet(struct sk_buff *skb,
 	 */
 	if (skb_has_frag_list(skb) && __skb_linearize(skb)) {
 		ret = -ENOMEM;
-		goto free_skb;
+		goto put_primary_if;
 	}
 
 	/* Create one header to be copied to all fragments */

---
base-commit: 22b12d005035f37f898e5bf80480719fe1ef4fba
change-id: 20260703-frag-tx-primary-leak-6c2ad9f844a3

Best regards,
--  
Sven Eckelmann <sven@narfation.org>

