Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F413CCA5FFC
	for <batman@archiver.kernel.org>; Tue,  6 Oct 2026 16:49:14 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 645A484434
	for <batman@archiver.kernel.org>; Tue, 06 Oct 2026 18:49:13 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1791305353;
 b=j4hE1br7ypuC4d9dTzPkr4Y92oAxo9qk9yf2+9qqqHl0ZSnQg36YZIO1nzi3d4TWX1ITx
 +1GEReFko2OsW7XCC3wxYP2OYNFLNPQ7aG15vzBE/4WU0P56Jwdf7kltlg5Gd98UMZxCiMD
 WYAfDIL+a32xiEJsyzFqWXil9uBQA8Y=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1791305353; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=vzY6ymHge9Fc/E2Rf5lp2JKlms5E6xa3Wcj+XqGq2rQ=;
 b=neABwDMr4Z6PSaHlso6/C8+8M6queM6NxrKaRtmo4s4bPZDh+3cf0QaXcomBVOPP90+7B
 G/eCK2UGXSlqQsu90ueBg97s8RuRHlgugKbClS/cT9FVL7Qwace7U/Kqkc/y0JsQ6dPMIQX
 EErSL++BJsrMoTJbFzz9gdBmWMKzweI=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id A72E183C27
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 06 Oct 2026 18:48:19 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1791305309;
	b=K/43CK9jbb2l97Wacy1L73OI9Gt2xwKLdjhLzpK0NfDZMvO7mJfBulNIKxZHHHdNFKh+zu
	M5K2ow0c9iIL9eYZd+9SE/y132Ip9x4cCS0blJis/ENIenc10dyEmVqmU3TIT7GVuUSlgf
	RMM4bgv/LiaTq2/on5/aRy803ddCtho=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1791305309;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=vzY6ymHge9Fc/E2Rf5lp2JKlms5E6xa3Wcj+XqGq2rQ=;
	b=pMofMSQzVU9rncvYI9RZpYUQjVRuhPEpVhTKHVE1lGoYkdfHXbJmfatweF0e+m2Hl86RgW
	Xw1upGipzdaLaYqdQlj9fz8dBKw+GEg/E+tvhoyjfhF+xukLFERR9gf47HuDJAgmi5H0F5
	PS6wETbvWlbKXmDgr9/0HqLEUcOxdGA=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=hcJM1Q9c;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 6545E1FFBB;
	Tue, 06 Oct 2026 16:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1791305299;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vzY6ymHge9Fc/E2Rf5lp2JKlms5E6xa3Wcj+XqGq2rQ=;
	b=hcJM1Q9cy8FuPxFuonwkrTMV67gnbgEoP/dnh/hHDBA5w+sx+paUn5P4gdaZPMsfatzECi
	6Ap403jQUO2UWMQ/hkVnhAyZcYHBsLTAS0VqXoCMXZHbZn6MYMal0hKkRcxCXc985QncxL
	uOGjPWFzt+XOeclg40t6QsLl9ZvXsPE=
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 06 Oct 2026 18:47:04 +0200
Subject: [PATCH batadv v3 2/9] batman-adv: bat_v: annotate last_unicast_tx
 with READ/WRITE_ONCE
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261006-dat-last_update-once-v3-2-316aefdd5f5f@narfation.org>
References: <20261006-dat-last_update-once-v3-0-316aefdd5f5f@narfation.org>
In-Reply-To: <20261006-dat-last_update-once-v3-0-316aefdd5f5f@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2110; i=sven@narfation.org;
 h=from:subject:message-id; bh=QIbsGGQmfAR3CuMWr8JzV7YKZInaYp6iMOKn0bgjQ8I=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFlH1bhs952qei/Al57P9fO4ku1P5d1BT1niVnDx3zjJy
 du8vJ2po5SFQYyLQVZMkWXPlfzzm9nfyn+e9vEozBxWJpAhDFycAjARkxiGfxbzHnZ23XKeb1QW
 tvPhRxkbIXPxT3sbWA9P6xEpTJHb/5ORYaXT7lWRGQoVD1rnc09vn1EmWPHfI0r5xlyR1Qnqf0N
 P8wMA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: 6UM4ALUKPPRYMJSW4LZ3NQFHDW2A7RTD
X-Message-ID-Hash: 6UM4ALUKPPRYMJSW4LZ3NQFHDW2A7RTD
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/6UM4ALUKPPRYMJSW4LZ3NQFHDW2A7RTD/>
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

