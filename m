Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31B3DC43602
	for <batman-adv@archiver.kernel.org>; Wed,  8 Jul 2026 09:21:22 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 8C70E80921
	for <batman-adv@archiver.kernel.org>; Wed, 08 Jul 2026 11:21:20 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1783502480;
 b=N1paVdiFebHCJuWqH1HWHSleNOv9TxhWqlZhJH/xwaOT0RDRg7BdjH48mpz4vwMc2UklF
 6vmk2ehlz5mu5aQR49Y6naWF3dcffZ0xVKoD99imQIzCYQVTfx1snNaHPfm2Ta73MXEUdT9
 Y6G2Ln4LbmnyhyrkkYZqOVDyIHnM8EI=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1783502480; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=XoHitXwXZodRmHC2FnwvG2SXUd+kAGWLzeuLItlrFgE=;
 b=QJZ8kKt+KhCaTWQdUlQC/7ldWDKkhYAjR+aOPJqasHYNQCDikJH+FS08Va7w8cRP7wMoI
 mAU80aL5QBqtRq00GsBvn8FGeX40HkeCf3gmsHqYREiIuLFZUO/sLUzyNrzR5nK1BW9pmKC
 ymgU8je6QJ9T8e2ju2o1jTo5hZrblVQ=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 94A2783443
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 08 Jul 2026 11:18:44 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1783502324;
	b=XYd3Tk+wsC6zExTfEfQjghmHVyz4LnEEr0+e+hxJ0+bPV8bVzx/sxwXIAXFMrO4aKVkogT
	ZG7ZumHIKoel9vIYqBYV0osqVn16iuxZf0gqzaa0rJftiCrHRWT7IzKSK6NZX4WVw8ZUz0
	Y/g0kLzgAMHgP9JOaGbTvX0j7qwlWE4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1783502324;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=XoHitXwXZodRmHC2FnwvG2SXUd+kAGWLzeuLItlrFgE=;
	b=JJ70sO2R4XkCYH9nYt72TQURGVH16MiaQXgfo1fooXOvAGBHkxDcdOs0K0Gs6NVAK4e9s0
	+dsHOpz+ysm1hygC2skYPSQb/bY/MeLAveMUodKOC2ygy4dp1Au0Z0hP2Rb9Ii4nsDTOhG
	vNTeYr8mJG1apy1QrvZHkxRnTMQXJZA=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=AGBDHvgk;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 23.88.38.48 as permitted sender) smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1783502323;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XoHitXwXZodRmHC2FnwvG2SXUd+kAGWLzeuLItlrFgE=;
	b=AGBDHvgkTOUH5WKelMcNP+01Dx9OGyFk+Z/Rvq4jQVEd2zvAPfEhjD/dAi6jlDAq5dWpnR
	KFDsB3IxDzm4j1QdJVBuKEdn9v4up6mM0mg0cpjPeULywOSz48bX58h/R1g+DcQelB3Qi1
	w7dvLNuIHVc3S5OAX0iPSmKxCdFCXIZT2/L1Zh1hn/ig0RoqrDVcremTjX3Ged9GSu+M/A
	dNHLpyIPkveySCs5kbZaatBYm+K4x3TzxLUC9mbsuTifpyaVQW8ccB3YL2p3053uvZS8U9
	NUr8cpSNiGltfqziUDuj4aLn11feyblxUfSJv0KU6NGCOCo1+nRx6OtKxfKg6A==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Sven Eckelmann <sven@narfation.org>,
	stable@vger.kernel.org,
	Sashiko <sashiko-bot@kernel.org>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net 7/9] batman-adv: frag: fix primary_if leak on failed
 linearization
Date: Wed,  8 Jul 2026 11:18:19 +0200
Message-ID: <20260708091821.314516-8-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260708091821.314516-1-sw@simonwunderlich.de>
References: <20260708091821.314516-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: SXR5PEM4V5KAYOAT7Z45ABOH6ZTS434Q
X-Message-ID-Hash: SXR5PEM4V5KAYOAT7Z45ABOH6ZTS434Q
X-MailFrom: sw@simonwunderlich.de
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/SXR5PEM4V5KAYOAT7Z45ABOH6ZTS434Q/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Sven Eckelmann <sven@narfation.org>

If the skb has a frag_list, it must be linearized before it can be split
using skb_split(). But when this step failed, it must not only free the skb
but also take care of the reference to the already found primary_if.

Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-bot@kernel.org>
Fixes: a063f2fba3fa ("batman-adv: Don't skb_split skbuffs with frag_list")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/fragmentation.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/fragmentation.c b/net/batman-adv/fragmentation.c
index 13d4689d332dc..2e20a2cb64cbf 100644
--- a/net/batman-adv/fragmentation.c
+++ b/net/batman-adv/fragmentation.c
@@ -547,7 +547,7 @@ int batadv_frag_send_packet(struct sk_buff *skb,
 	 */
 	if (skb_has_frag_list(skb) && __skb_linearize(skb)) {
 		ret = -ENOMEM;
-		goto free_skb;
+		goto put_primary_if;
 	}
 
 	/* Create one header to be copied to all fragments */
-- 
2.47.3

