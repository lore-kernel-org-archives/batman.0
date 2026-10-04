Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0771ACA5FEC
	for <batman@archiver.kernel.org>; Sun,  4 Oct 2026 10:11:54 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 9C57784625
	for <batman@archiver.kernel.org>; Sun, 04 Oct 2026 12:11:52 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1791108712;
 b=oAzwVvpdQx47eTRkcDX1q7rnflGoQY7P9xh/iFiR46i/CgempXzfws4tPv4RRX8YBgcu1
 d6OdTzk3L3Zhi/Xf48U/o5/++XYjhZdXkWndYFjBTXkcn3f7U2EDiwyFnr/MU4+jTApFI2Z
 9NlmtiPT1HbnVWkiwMxuJTxOI97+taQ=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1791108712; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=vzY6ymHge9Fc/E2Rf5lp2JKlms5E6xa3Wcj+XqGq2rQ=;
 b=eRh7609CIXZM7klK083ULeWJbKfVNwmfYT+BHu52KqhLk0dSKux6y1ISiHYTpN4tGl+og
 zp3fAnBMG+9BzyO4YR+cRn1zZ8DlhQh8qZTTJoC1G0uqGLYYjT2KwB4ovupJuv/F1Rs0tkW
 rwCCpKwFRzSiG941lPAjfhaeVEf7c18=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 80DD184270
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 04 Oct 2026 12:09:06 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1791108556;
	b=qphDUNVYSuROQPGsfkkxSAujihart+d2qmWK+VfTgPLNjCo/NyoPyfxP85rLw4hCwPMZB4
	SLC1AuhBVz7djYsBfaKzTgCbyZM2yclD9x0tY3y/7sEdXd3y25w/pZbG1AsmD6iUcMXN4z
	RL4BmKYgzYIFgacq2WH4Idmo66/yKcI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1791108556;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=vzY6ymHge9Fc/E2Rf5lp2JKlms5E6xa3Wcj+XqGq2rQ=;
	b=2Qg3MJCDDCvtG6Id/Sfx1lfM7wop0hRL3a9vQRwuxMfY2LoVifWG4H6v1bI3jPXlS4/vx1
	ZW3fr00WbedkbQi7f0BRsJHHLLHmgtnd2z1Ml7Isi0YdQexheotN6Njc5oExAMRpVw749p
	JxvsUqyW7VpwgZt4cZpb23nL9u6Qgdk=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=OaQT9AnL;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 45E10204B3;
	Sun, 04 Oct 2026 10:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1791108545;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vzY6ymHge9Fc/E2Rf5lp2JKlms5E6xa3Wcj+XqGq2rQ=;
	b=OaQT9AnLi9E11hFgsJVkaLcubzpk6YmFwroF16+volU456JUTVCCXpjkoONonzLmVcwMAq
	yw7u16fDOgKnwmAdeBdwwNpT2ziex7xBOnkeYLWJowISOtkOzs6dsjovEOW0SWidOtcHLz
	392caelq+7aaTBCM+IuNpxKpEg7pPkA=
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 04 Oct 2026 12:08:37 +0200
Subject: [PATCH batadv v2 2/9] batman-adv: bat_v: annotate last_unicast_tx
 with READ/WRITE_ONCE
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261004-dat-last_update-once-v2-2-ab012a4b18ed@narfation.org>
References: <20261004-dat-last_update-once-v2-0-ab012a4b18ed@narfation.org>
In-Reply-To: <20261004-dat-last_update-once-v2-0-ab012a4b18ed@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2110; i=sven@narfation.org;
 h=from:subject:message-id; bh=QIbsGGQmfAR3CuMWr8JzV7YKZInaYp6iMOKn0bgjQ8I=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFmHVLdEX05jKE3Sfp17b1cad6Lzwh65ShvBzsQFG7R6k
 rctF5XvKGVhEONikBVTZNlzJf/8Zva38p+nfTwKM4eVCWQIAxenAEzk5lRGhp1z37Bs0Jx1xHhL
 ml+0q0PxtrRPezZOWrnMSHTOws4vH1cy/OFa6L/w0XyeoPuJnHcVgx4ELO/6eO1ATF7Ch+3czid
 TfdgB
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: MXCH4W4H7ECGJGSNBBHHXSIT6TW7TAET
X-Message-ID-Hash: MXCH4W4H7ECGJGSNBBHHXSIT6TW7TAET
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/MXCH4W4H7ECGJGSNBBHHXSIT6TW7TAET/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

The bat_v.last_unicast_tx field for batadv_hardif_neigh_node tracks the
jiffies value of the most recent activity and is used to detect timeouts.
These accesses are not consistently protected by a lock, so
READ_ONCE/WRITE_ONCE must be used to prevent data races caused by compiler
optimizations.

To avoid an underflow due to an non-strict order read of jffies vs
last_unicast_tx, use jiffies_delta_to_msecs instead of jiffies_to_msecs to
evaluate the delta.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/bat_v_elp.c | 4 +++-
 net/batman-adv/send.c      | 2 +-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/bat_v_elp.c b/net/batman-adv/bat_v_elp.c
index 6ad6042a..a56b2fb6 100644
--- a/net/batman-adv/bat_v_elp.c
+++ b/net/batman-adv/bat_v_elp.c
@@ -230,6 +230,7 @@ static bool
 batadv_v_elp_wifi_neigh_probe(struct batadv_hardif_neigh_node *neigh)
 {
 	struct batadv_hard_iface *hard_iface = neigh->if_incoming;
+	unsigned long last_unicast_tx;
 	struct batadv_priv *bat_priv;
 	unsigned long last_tx_diff;
 	struct sk_buff *skb;
@@ -250,7 +251,8 @@ batadv_v_elp_wifi_neigh_probe(struct batadv_hardif_neigh_node *neigh)
 	 * generate 2 probe packets and push the RC algorithm to perform
 	 * the sampling
 	 */
-	last_tx_diff = jiffies_to_msecs(jiffies - neigh->bat_v.last_unicast_tx);
+	last_unicast_tx = READ_ONCE(neigh->bat_v.last_unicast_tx);
+	last_tx_diff = jiffies_delta_to_msecs(jiffies - last_unicast_tx);
 	if (last_tx_diff <= BATADV_ELP_PROBE_MAX_TX_DIFF)
 		return true;
 
diff --git a/net/batman-adv/send.c b/net/batman-adv/send.c
index 929b6dd3..cc673b94 100644
--- a/net/batman-adv/send.c
+++ b/net/batman-adv/send.c
@@ -144,7 +144,7 @@ int batadv_send_unicast_skb(struct sk_buff *skb,
 	hardif_neigh = batadv_hardif_neigh_get(neigh->if_incoming, neigh->addr);
 
 	if (hardif_neigh && ret != NET_XMIT_DROP)
-		hardif_neigh->bat_v.last_unicast_tx = jiffies;
+		WRITE_ONCE(hardif_neigh->bat_v.last_unicast_tx, jiffies);
 
 	batadv_hardif_neigh_put(hardif_neigh);
 #endif

-- 
2.47.3

