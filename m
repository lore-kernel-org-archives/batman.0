Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5C9ACD3439
	for <batman-adv@archiver.kernel.org>; Wed,  6 May 2026 20:23:26 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 42072845D7
	for <batman-adv@archiver.kernel.org>; Wed, 06 May 2026 22:23:25 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1778099005;
 b=p8FUZSP8/39wIQpDIjif0uVEmQ1B2daPMJbZtj4HtN9vsh4jasOjQzHWRk0GUVvb3SWuh
 GosVH7yssMAqpk8BOfZ6oFVxxL75gv8+krjE1pYG69i7q9Eb2G2NnE1IIN0suZb9BHHYya3
 XFc1ymr8oBtwwrZ99eesrRb5OiROidw=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1778099005; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=7D6/i4aMQ2pRib0Wn/zk1Znhy3s4ZVlSbebFYQi9AYg=;
 b=1KbTBJaeUmExL5jXOtdLtrqggT4YDcay7tmFI43iGJrbd1U5F8P7W1J4OIrnwJR7g8hm9
 jUy6orCql/HCmxEHEno+F0IlWgFPeCfhkzXGT5BIbs733qm6TJDOe/ybGqd3IvglhmHY7ts
 OyTr+nsbqg74KeqctgiocTS+6xpBNhY=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 2F342844A4
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 06 May 2026 22:22:09 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1778098929;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=7D6/i4aMQ2pRib0Wn/zk1Znhy3s4ZVlSbebFYQi9AYg=;
	b=pCHUmB6aOZxgAUoZB3Jhlj602hVBleZnNHY1SHSfsMQCJ25Y0nnqwHOqGWvr/PU1+HNkx+
	kEoM2uGKGHXOlYX7cvU70dnXE1Ei970UQmWdpS6v6aq3fmT9j2pA9PUU02AUf0qwcykd0J
	e4rMNaRmT6VEjd6aQU8bcvvJZBY/A9Y=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=pM1SVJmb;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1778098929;
	b=QFezAU6XWrTaJnyotaGEyiVnEXbVNTUWEA9xSW6O7OCrvFIQMK43kK3TMN8PCeQFtQdqeR
	CFsQ/mUkSLZWSGC+Z8Q8TdzZ5RsnB8Zf+queehzmqfAK6MMObFsaxFj9t2Ilu3GovgVGyv
	R5FsF2qwW0g19K5Pmfb0+LobdRhstoY=
Received: by dvalin.narfation.org (Postfix) id E11292170A;
	Wed, 06 May 2026 20:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1778098929;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7D6/i4aMQ2pRib0Wn/zk1Znhy3s4ZVlSbebFYQi9AYg=;
	b=pM1SVJmbK7UohbGmeNw80wL0aQ/8WeiVZ2dyJDwhZ+R3DmSpbIBbGW7HhuAxBltr9wCDdD
	udKK7JSpRAbq3KLrMhRBIGYxzVP0UBow30fpvvz1hR8wG0QItc6yPnamsonLlEBXcMyr8j
	KlUX9J1wT5eKwmoViQxmI9ITVHUtJDc=
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 06 May 2026 22:20:49 +0200
Subject: [PATCH batadv v2 02/11] batman-adv: tp_meter: fix tp_num leak on
 kmalloc failure
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260506-fixes-followup-v2-2-ce32a2d8d4da@narfation.org>
References: <20260506-fixes-followup-v2-0-ce32a2d8d4da@narfation.org>
In-Reply-To: <20260506-fixes-followup-v2-0-ce32a2d8d4da@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Ao Zhou <n05ec@lzu.edu.cn>, Haoze Xie <royenheart@gmail.com>,
 Jiexun Wang <wangjiexun2025@gmail.com>, Juefei Pu <tomapufckgml@gmail.com>,
 Luxing Yin <tr0jan@lzu.edu.cn>, Ren Wei <n05ec@lzu.edu.cn>,
 Ruide Cao <caoruide123@gmail.com>, Xin Liu <bird@lzu.edu.cn>,
 Yifan Wu <yifanwucs@gmail.com>, Yuan Tan <yuantan098@gmail.com>,
 Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1678; i=sven@narfation.org;
 h=from:subject:message-id; bh=5D4W95GlwU3V6sFQrFi1Lk9vHKGjMwiSdaF4YOn8CHs=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDJm/Fx0wPvlMVibTS/3Rmx2r/vT21JSc5Uw7brft34HHi
 wzs9WdldZSyMIhxMciKKbLsuZJ/fjP7W/nP0z4ehZnDygQyhIGLUwAm8vM2I8MzqdiVXCKrvzd0
 Xptve/20unrECuULlSs+GDDwfHhXf6mQ4X/qEc39PQxztb8b+P+uapTdxiE74UKRisj92c9C35m
 UJPECAA==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: VSOUHP352W4J6EKJLKNOY2LIADXWJEOY
X-Message-ID-Hash: VSOUHP352W4J6EKJLKNOY2LIADXWJEOY
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/VSOUHP352W4J6EKJLKNOY2LIADXWJEOY/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

When batadv_tp_start() or batadv_tp_init_recv() fail to allocate a new
tp_vars object, the previously incremented bat_priv->tp_num counter is
never decremented. This causes tp_num to drift upward on each allocation
failure. Since only BATADV_TP_MAX_NUM sessions can be started and the count
is never reduced for these failed allocations, it causes to an exhaustion
of throughput meter sessions. In worst case, no new throughput meter
session can be started until the mesh interface is removed.

The error handling must decrement tp_num releasing the lock and aborting
the creation of an throughput meter session

Fixes: 98d7a766b645 ("batman-adv: throughput meter implementation")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/tp_meter.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/batman-adv/tp_meter.c b/net/batman-adv/tp_meter.c
index 58ca59a2..066c7611 100644
--- a/net/batman-adv/tp_meter.c
+++ b/net/batman-adv/tp_meter.c
@@ -994,6 +994,7 @@ void batadv_tp_start(struct batadv_priv *bat_priv, const u8 *dst,
 
 	tp_vars = kmalloc_obj(*tp_vars, GFP_ATOMIC);
 	if (!tp_vars) {
+		atomic_dec(&bat_priv->tp_num);
 		spin_unlock_bh(&bat_priv->tp_list_lock);
 		batadv_dbg(BATADV_DBG_TP_METER, bat_priv,
 			   "Meter: %s cannot allocate list elements\n",
@@ -1366,8 +1367,10 @@ batadv_tp_init_recv(struct batadv_priv *bat_priv,
 	}
 
 	tp_vars = kmalloc_obj(*tp_vars, GFP_ATOMIC);
-	if (!tp_vars)
+	if (!tp_vars) {
+		atomic_dec(&bat_priv->tp_num);
 		goto out_unlock;
+	}
 
 	ether_addr_copy(tp_vars->other_end, icmp->orig);
 	tp_vars->role = BATADV_TP_RECEIVER;

-- 
2.47.3

