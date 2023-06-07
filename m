Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8382EC53219
	for <batman@archiver.kernel.org>; Tue, 28 Jul 2026 20:14:04 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 83B6F80782
	for <batman@archiver.kernel.org>; Tue, 28 Jul 2026 22:13:58 +0200 (CEST)
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=none (ARC-Seal[2] reported failure, the chain is terminated);
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de
 policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 6C10280519
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed,  7 Jun 2023 17:55:21 +0200 (CEST)
ARC-Seal: i=2; s=20121; d=open-mesh.org; t=1686153321; a=rsa-sha256;
	cv=fail;
	b=TApgFtgHH6qWQct/0yOYiYbPNm9PHaji9pITbVOlxlCOCSwScTkdQqgHCXSu6Hu5kBfJFE
	j1lA3JQvRJ5qhZYtTRiG9+tJDNI9Cl8Nataxw5NKP+siMJig9lmv3INOdcv/vG40eJgKWo
	FisjTzIUabZyjwo1arPapzUh5NUN8R4=
ARC-Authentication-Results: i=2;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=vELHkSEN;
	arc=reject ("seal check failed: fail,
 {[1] = sig:simonwunderlich.de:reject}");
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 23.88.38.48 as permitted sender) smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1686153321;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=EQFV2MSE8jduUj7jFRwaDjaz5N/1JgonUt3nWlq78Ds=;
	b=zo4hMiFccIItsKJoZe0smtWZBnSPEuj3BFoMFytKPUirEwo1Mb+ZvTKiL5SbkPpzTMOpA2
	CJ1OJw37kjDh8ru5q9s89W9aWLLCJn6Xd8eNLBBVjIGYBd8Sp9eoHWNNMjYOJe7UmS6NDX
	IJodrI2Y3S4oHMDfFJTXTRTyMg1ns3A=
Received: from kero.packetmixer.de
 (p200300C5970e9Fd858c5a4eEf27c1696.dip0.t-ipconnect.de
 [IPv6:2003:c5:970e:9fd8:58c5:a4ee:f27c:1696])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits)
 server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id 255CAFA18C;
	Wed,  7 Jun 2023 17:55:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1686153321;
 h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EQFV2MSE8jduUj7jFRwaDjaz5N/1JgonUt3nWlq78Ds=;
	b=vELHkSENMZxH6fZKHOCz5YZxfsTJ4/5mlHJ8nsaeEPl/owNiaZvHs+yUkieUPrF6uTSHak
	YAvq76CVKXH9RaGusXu2fWPT/Xc8iOfAOMJ8gCfcLx9PdRlZuG/XMmlHU8z+cVtvGOvoyW
	xYn7uWlhoQ53jsr3a0beT1Z8qVc3rZC4zmKe3d/ZJVHfqGEX2SyUL6oSokkhbjS0fuzRy1
	/8yx8y14BY0fa5t7l8JY57IrqbQwltMeF5RHi+YC0Y0zJMP3XpaLfyiiDF6U1tGgJN8QTy
	Rugwb55yMbAV0ZleA8Cjs4k0LF5LD3r/VRxf80cjhZ82MLp30PSs58D+iT+WQQ==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: netdev@vger.kernel.org,
	b.a.t.m.a.n@lists.open-mesh.org,
	Vladislav Efanov <VEfanov@ispras.ru>,
	stable@kernel.org,
	Sven Eckelmann <sven@narfation.org>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 1/1] batman-adv: Broken sync while rescheduling delayed work
Date: Wed,  7 Jun 2023 17:55:15 +0200
Message-Id: <20230607155515.548120-2-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230607155515.548120-1-sw@simonwunderlich.de>
References: <20230607155515.548120-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
	d=simonwunderlich.de; s=09092022; t=1686153321;
	h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EQFV2MSE8jduUj7jFRwaDjaz5N/1JgonUt3nWlq78Ds=;
	b=sy/9cgTHisJFnarzZaYm9CHi6EozDhmYa+768uNKTilBTX1Nbmlo/BlMzKo53QJIacJRqx
	FmmjA+KtdJZYwtW10PSqkXx2J5liwMohBBed76W7TwFiPf7g4OWdM10ITQzu30Nwn568Yh
	B4LClNXW85A/ReLMTgLmp9cb6A373KAxkjt+IvHvgIPU23ddFoX9Vq+2HKNaIIBDJBv0e/
	yXyAPt/ZJPJNO0ivBrY3ciU2qISBivk6pX/ltxi44XvCQxQY/YkSCeGDovTb8sEEMe6/1X
	kFZRcNHI0CaUfJ++MoI7/pJ/tSTrsbVrD4i5gGBh0E7NNzCPr/v+8dnaYVYkTw==
ARC-Seal: i=1; s=09092022; d=simonwunderlich.de; t=1686153321; a=rsa-sha256;
	cv=none;
	b=WCd8lBGxr11aMmrE979F7pA0hHrMuyMgYjoq/3AhqC2KeMlYw94TWGdW42bqJUrJEe+6CMrpWMJZdVc223fvl1Ixngwrkmzgu9ZL5DCg4i1D/7A090ok+UVuKLNI07FKVxjZiEkZubzpbU3LfLB6iE8FkbZzHYTswmA2tSi/60/1vCilesPpz7SHeFETX8rsqAE6u8mmu8i2lT7DRcnGucudf50ixXRVebt0FNTEMMaZpPjIaRkRoGAw5M2nuH9BM4LZruWGpZPVSzllJkI8A9K2WCSRAMy0J3Sbwiy1VMFITowZswUIcNifRrA/vk3CHDNpxJkls8+n0QC70CiZiA==
ARC-Authentication-Results: i=1;
	mail.simonwunderlich.de;
	auth=pass smtp.auth=sw@simonwunderlich.de smtp.mailfrom=sw@simonwunderlich.de
Message-ID-Hash: 745OP6DQCES3DV2OY2QHTWXSIMZADP7N
X-Message-ID-Hash: 745OP6DQCES3DV2OY2QHTWXSIMZADP7N
X-MailFrom: sw@simonwunderlich.de
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/745OP6DQCES3DV2OY2QHTWXSIMZADP7N/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Vladislav Efanov <VEfanov@ispras.ru>

Syzkaller got a lot of crashes like:
KASAN: use-after-free Write in *_timers*

All of these crashes point to the same memory area:

The buggy address belongs to the object at ffff88801f870000
 which belongs to the cache kmalloc-8k of size 8192
The buggy address is located 5320 bytes inside of
 8192-byte region [ffff88801f870000, ffff88801f872000)

This area belongs to :
        batadv_priv->batadv_priv_dat->delayed_work->timer_list

The reason for these issues is the lack of synchronization. Delayed
work (batadv_dat_purge) schedules new timer/work while the device
is being deleted. As the result new timer/delayed work is set after
cancel_delayed_work_sync() was called. So after the device is freed
the timer list contains pointer to already freed memory.

Found by Linux Verification Center (linuxtesting.org) with syzkaller.

Cc: stable@kernel.org
Fixes: 2f1dfbe18507 ("batman-adv: Distributed ARP Table - implement local storage")
Signed-off-by: Vladislav Efanov <VEfanov@ispras.ru>
Acked-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/distributed-arp-table.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/distributed-arp-table.c b/net/batman-adv/distributed-arp-table.c
index 6968e55eb971..28a939d56090 100644
--- a/net/batman-adv/distributed-arp-table.c
+++ b/net/batman-adv/distributed-arp-table.c
@@ -101,7 +101,6 @@ static void batadv_dat_purge(struct work_struct *work);
  */
 static void batadv_dat_start_timer(struct batadv_priv *bat_priv)
 {
-	INIT_DELAYED_WORK(&bat_priv->dat.work, batadv_dat_purge);
 	queue_delayed_work(batadv_event_workqueue, &bat_priv->dat.work,
 			   msecs_to_jiffies(10000));
 }
@@ -819,6 +818,7 @@ int batadv_dat_init(struct batadv_priv *bat_priv)
 	if (!bat_priv->dat.hash)
 		return -ENOMEM;
 
+	INIT_DELAYED_WORK(&bat_priv->dat.work, batadv_dat_purge);
 	batadv_dat_start_timer(bat_priv);
 
 	batadv_tvlv_handler_register(bat_priv, batadv_dat_tvlv_ogm_handler_v1,
-- 
2.30.2

