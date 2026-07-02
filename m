Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31E81C43458
	for <batman-adv@archiver.kernel.org>; Thu,  2 Jul 2026 20:10:52 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 85DD5843CF
	for <batman-adv@archiver.kernel.org>; Thu, 02 Jul 2026 22:10:50 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1783023050;
 b=LAya8SVAM2Pz02bZN/6ar+DTgKAkr3rFBVX3zrg3JnQxpc17iYnuewiBJLzw0qB1JQ3xs
 n+svR171HnmUbc5f2GeJb1ZjrkoJVMsFBzxBSFcRYMPFIhKvn3DTpJUM7itdjRrxlAG+t6l
 TKhnUtr5yJNxWTJiYrfMWV1r4Xf5xNs=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1783023050; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=wGwCl5iVRSfEkkNxNnuYkz695IUlD3CjLzDZqDuU/9c=;
 b=CDuLWdeXxInObFdZXokhwcIProUAzVUK4eeFNW3KWSWrEBDtTj68l7oi4lHclEFA1v6CS
 S++68lpviZslifrMmnpAMq71FR4MWJe3nw7iqcMg99Dx3rMHVYnZN35M0NNnlDG5gKvVaL3
 0xAk1Xek2/Tr1xlhWHYPLdZ4ncoEpeM=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 31C67810BB
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 02 Jul 2026 22:10:18 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1783023029;
	b=r98C31aw1ZSAX5kfWOcdYN0yYUBwyCaLp+eGVR0lzQT0t475cHzHV8d3EAc0YPBFh1XPMg
	eb3FMVOuaYfWy3cD8a3OOUp9nkAZIKL7D83TFGYzP9r07gyI77k2ghZoh6xRzNLxK1ovUR
	EcmAMqFR32iSdnFYdlyZBctwsYnCdK4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1783023029;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=wGwCl5iVRSfEkkNxNnuYkz695IUlD3CjLzDZqDuU/9c=;
	b=rizh2GddPRPs6fWQp2RpXzGvCe6pDpC5M7fE57qETHAriLtLsbsL+NPGhEf+E/A96u3G5W
	kJE8CFrlZpjm6rbxAwob/2O8gF5/5QmBEEUF228EctKwYtK3WWygwlc9SQf9mDIdi5+Z0u
	NoeQF/cMh5Q5swKXPOXT0KwGhwfJEj8=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b="IXpgbyj/";
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 0FEB320378;
	Thu, 02 Jul 2026 20:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1783023017;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=wGwCl5iVRSfEkkNxNnuYkz695IUlD3CjLzDZqDuU/9c=;
	b=IXpgbyj/38dbskkRj56e7TOiWKvjdoTUwPBmm6kBDCVk6CehSTshJdFwIzlk/mijHanZ/U
	DhSPl3AB8qV8/7Yh+59HTmmlXkNFycoiMOLK44nJpf78uKkgT046/699D6js502Qd78L/m
	+aDtrU2E2+oyAlOjpqvWRzO6L8oBTqk=
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 02 Jul 2026 22:10:02 +0200
Subject: [PATCH batadv] batman-adv: dat: drop non-4addr backwards
 compatibility
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-dat-drop-non-4addr-v1-1-7a7d35ff38f3@narfation.org>
X-B4-Tracking: v=1; b=H4sIAJnFRmoC/yWMQQqDMBAAvyJ77kISpIZ+pfSwuqtuD4lsUimIf
 2/aHmdg5oAiplLg1h1gsmvRnBr4SwfTSmkRVG4MwYWrG1xApopsecOUE/bEbDhT9FGclz4O0ML
 NZNb3b3qHkSrxDo+/L6/xKVP9HuE8P/37B3l+AAAA
X-Change-ID: 20260702-dat-drop-non-4addr-fa818e01e487
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1611; i=sven@narfation.org;
 h=from:subject:message-id; bh=Tiqi2o0rp/9hEU3cDz8IFstpyOp8aPdKwxFT4gNcYWs=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFluRxdemhXz69gX3qyPp5lcfzc/maTk916dYdfdludba
 06F+d9J6ihlYRDjYpAVU2TZcyX//Gb2t/Kfp308CjOHlQlkCAMXpwBMZNcJRoanrxpWczoGVXg8
 9qnz/eXM+2/Ckj1ndmYY37z49LurZuxGRoabyZMnLqzLWbip/p6in3l95He914WLmKO9dh0492b
 55XxuAA==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: E5TZODW44V7IP67Z7RECAICCPCQU5GGM
X-Message-ID-Hash: E5TZODW44V7IP67Z7RECAICCPCQU5GGM
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/E5TZODW44V7IP67Z7RECAICCPCQU5GGM/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

The 4addr unicast packet support is mandatory in compat version 15. No
older compat version is supported and the kernel doesn't need to keep code
to talk to nodes which cannot be in the same mesh.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/distributed-arp-table.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/net/batman-adv/distributed-arp-table.c b/net/batman-adv/distributed-arp-table.c
index 25004ce3..a5c9b6d0 100644
--- a/net/batman-adv/distributed-arp-table.c
+++ b/net/batman-adv/distributed-arp-table.c
@@ -1372,17 +1372,9 @@ bool batadv_dat_snoop_incoming_arp_request(struct batadv_priv *bat_priv,
 	if (!skb_new)
 		goto out;
 
-	/* To preserve backwards compatibility, the node has choose the outgoing
-	 * format based on the incoming request packet type. The assumption is
-	 * that a node not using the 4addr packet format doesn't support it.
-	 */
-	if (hdr_size == sizeof(struct batadv_unicast_4addr_packet))
-		err = batadv_send_skb_via_tt_4addr(bat_priv, skb_new,
-						   BATADV_P_DAT_CACHE_REPLY,
-						   NULL, vid);
-	else
-		err = batadv_send_skb_via_tt(bat_priv, skb_new, NULL, vid);
-
+	err = batadv_send_skb_via_tt_4addr(bat_priv, skb_new,
+					   BATADV_P_DAT_CACHE_REPLY,
+					   NULL, vid);
 	if (err != NET_XMIT_DROP) {
 		batadv_inc_counter(bat_priv, BATADV_CNT_DAT_CACHED_REPLY_TX);
 		ret = true;

---
base-commit: 22b12d005035f37f898e5bf80480719fe1ef4fba
change-id: 20260702-dat-drop-non-4addr-fa818e01e487

Best regards,
--  
Sven Eckelmann <sven@narfation.org>

