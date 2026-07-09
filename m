Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56FB4C43458
	for <batman-adv@archiver.kernel.org>; Thu,  9 Jul 2026 19:47:37 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id EF0BF817C4
	for <batman-adv@archiver.kernel.org>; Thu, 09 Jul 2026 21:47:35 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1783626455;
 b=rkhkmvbY8cVJYfrAs875HfH65k4wcgs0F1/bMJj5TMzcs4dykJGP29NwBs+mmi9JKSXJW
 XOMJBpZJnrQ7Ay7YqTljpv//8r5okFPN/EmZzTvTKCryQExf9XiL0LixovrsDSUAiJYpOBF
 L6PuEIMHVIa4BAwIl4v1Zdti6LZuEgk=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1783626455; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=YXIz1hYiz0lr/xtOufy8wl1ky0U0QAO9oX4d5+y4rqI=;
 b=hwomEp+ynMVJkjUbYGNk9Vb8xmXVLVNQAbToHoDs0bZH05ZfDMChZo9QR3B1TJmizQpLX
 rnO8VUZvSo80q4KN6/rvw4hEX/RAxsIktQGRo/qybEDuLvVyJzRfSBOA7eue/GF+xdclAe+
 +5XWcAvcTWB6qoo3y+7eQHa9N2mqFiw=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 45C1E80454
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 09 Jul 2026 21:46:24 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1783626384;
	b=P6sfWYVMmHgLnFbrx9ACS8Jk9t2VUdBeCfPGN/rY3FgGgZSgdzWWZrLvxJF6/q2WzPl6zz
	3x3IuMFS+C79ASF2gVT5H8bCgCVbNZJZ0eNlhjZMW9uIrVQOt/CH8yof98SqxPXOKGEBKh
	7OlV+Bw9dnMryVPwk9+SPQzEyXu+wHo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1783626384;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=YXIz1hYiz0lr/xtOufy8wl1ky0U0QAO9oX4d5+y4rqI=;
	b=WUVG8CSE/adAoodgqPkx/WLUAhV2qLiv0j/KWODhSBsT/7fqIqk0E0onwHXCL/0lU4HByG
	qYlFdaV9IazsDY2UIrwPIj2zbaZvDccNx3FENLFFFXBVNXjCfKSknxAITZaE2+0oQdCuI5
	yM3HQLuTg3ymnGkLNkaExwhfwoHNpds=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b="tCt/Lz6Z";
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 461502055F;
	Thu, 09 Jul 2026 19:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1783626383;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YXIz1hYiz0lr/xtOufy8wl1ky0U0QAO9oX4d5+y4rqI=;
	b=tCt/Lz6Zn1JXuQOOilVnX0kQoy/1SnYIN1zsm2vpKjyeuQ67axpwKcdH2r60ud0Ss0H5mU
	oPI60pFgKtRyKqi7NVb2wKHAZl9Z7Wq4tKnbNZZm//MQHXkxjN0P0b7jQWfLfCf3OC4Ui5
	qxNCi2YzKMK24bfdRiqLcsd//RNKAa0=
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 09 Jul 2026 21:45:57 +0200
Subject: [PATCH batadv 3/3] batman-adv: mcast: linearize skbuff for packet
 generation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: 
 <20260709-mcast-header-generation-bugs-v1-3-c7c111fa45b6@narfation.org>
References: 
 <20260709-mcast-header-generation-bugs-v1-0-c7c111fa45b6@narfation.org>
In-Reply-To: 
 <20260709-mcast-header-generation-bugs-v1-0-c7c111fa45b6@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>, Sashiko <sashiko-bot@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1307; i=sven@narfation.org;
 h=from:subject:message-id; bh=GJ06g5NQW3AZJoDt5PX9eJ0DGsP3S2GySD5ccxiCA2c=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFn+v8q4fE9eupxysMxjxtWq5d//Mk0OEdWJ3mLb0rU4s
 ljV8PHWjlIWBjEuBlkxRZY9V/LPb2Z/K/952sejMHNYmUCGMHBxCsBEInYw/JWIlOwP26Jo/u/4
 7X9zBB8/uVi0aKtm9d15GQl3Xp5pDC5mZOgX0eicfcc47dJj48NSy7Q5tf7+i3Zb02W3flWdY4d
 JAj8A
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: DYJLSLR5FTWIWJDW22XAWBCTWBODDCUP
X-Message-ID-Hash: DYJLSLR5FTWIWJDW22XAWBCTWBODDCUP
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/DYJLSLR5FTWIWJDW22XAWBCTWBODDCUP/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

batadv_mcast_forw_packet() is not only called by the unsharing+linearizing
batadv_recv_mcast_packet() handler. When it is called by
batadv_mcast_forw_mcsend() then it will be unshared but not linearized. The
SKB_LINEAR_ASSERT() can therefore cause a fatal BUG().

The batadv_mcast_forw_packet() must handle the linearization itself.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Fixes: 8ed36122d709 ("batman-adv: mcast: implement multicast packet reception and forwarding")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/multicast_forw.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/multicast_forw.c b/net/batman-adv/multicast_forw.c
index c5b8e2e3..9fbd2876 100644
--- a/net/batman-adv/multicast_forw.c
+++ b/net/batman-adv/multicast_forw.c
@@ -937,8 +937,10 @@ static int batadv_mcast_forw_packet(struct batadv_priv *bat_priv,
 	u8 *dest;
 	int ret;
 
-	/* (at least) TVLV part needs to be linearized */
-	SKB_LINEAR_ASSERT(skb);
+	/* packet needs to be linearized to access the tvlv content */
+	ret = skb_linearize(skb);
+	if (ret < 0)
+		return -ENOMEM;
 
 	/* check if batadv_tvlv_mcast_tracker header is within skb length */
 	if (sizeof(*mcast_tracker) > skb_network_header_len(skb))

-- 
2.47.3

