Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 649B4C77B7A
	for <batman-adv@archiver.kernel.org>; Fri, 26 May 2023 16:24:36 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 481EE81EC7
	for <batman-adv@archiver.kernel.org>; Fri, 26 May 2023 18:24:34 +0200 (CEST)
ARC-Seal: i=2; cv=fail; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1685118273;
 b=ma7vjrbOEYKvE95GcUUfk8xMJLBUmm0fcrF7qDpvvRS5+4ZSBYgWf0QvCPhg1PadRhiap
 JN4bTxJ+aEfZbJI5PJK3FCdIT5ib2mLr6SrE9TIPXwZV9Z7qSd23YfbONh8fAb7EkucK5Df
 WUcuxZiuLmwiu59TNN/Liigt8RxfXZ4=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1685118273; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=EFpz1yN/LYkwuhtg+M8Cs3tl9VhaECPxGvDOfosFdm8=;
 b=09zHwscucrb5kyMAbwkvTV2MEFslZ8ipaX2jsyoSVbojbbMXBF4o13pdG4c0hcZX7vpHZ
 bxdJuTiyvfQCin2Sl1ZMTaNNmi1PeHO3jOSES8mw+JVZDZb+JZvzjHzjqPOm1OHCxLzV1Dc
 lyffZVHMUgcVTRPgpz9/KYwozs/KpK4=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=fail header.d=ispras.ru;
  arc=fail;
  dmarc=fail (Used From Domain Record) header.from=ispras.ru policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=fail header.d=ispras.ru; arc=fail; dmarc=fail (Used From Domain Record) header.from=ispras.ru policy.dmarc=none
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 96632804B9
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 26 May 2023 18:17:28 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1685117848;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=aqS+SmgTj1O1ACMyKobn1Ejjd1RSyeh/KMYxC+E+Wpw=;
	b=C1K68NnROCmDJ5nogieMZFLAk503I7fxAmecqeuIed+sQbrozp7cvvL6OriMyGetk19Nv0
	T32WR57AtuXAf+o7bk/Glgg+ktA13PuVNhToMLBANlSirXuNWEtydZm289jybwfvw5giIP
	2uLzext8c6Jivr7qQ4NLYE0gLYKOu0A=
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1685117848; a=rsa-sha256;
	cv=none;
	b=1XVTay4OyDzs2Nt4tY5ePLgylimPgaBHbYyVFwX0nb2rvtn8FZ7FTpB1by1+PfzvpTe6ZJ
	r/uroZVrNcz2BgKSi56iS5gi1MBuATm/0cEXRAerU0X/EOM7+IKeC2sDjps5Ta+ZGOU82r
	Ut3Qd61Or4YhxCj1b0ZvaImaHFrFvB0=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=ispras.ru header.s=default header.b=WWuzkfee;
	spf=pass (diktynna.open-mesh.org: domain of VEfanov@ispras.ru designates 83.149.199.84 as permitted sender) smtp.mailfrom=VEfanov@ispras.ru;
	dmarc=pass (policy=none) header.from=ispras.ru
Received: from vefanov-Precision-3650-Tower.intra.ispras.ru (unknown [10.10.2.69])
	by mail.ispras.ru (Postfix) with ESMTPSA id 878B644C100F;
	Fri, 26 May 2023 16:17:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 878B644C100F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1685117843;
	bh=aqS+SmgTj1O1ACMyKobn1Ejjd1RSyeh/KMYxC+E+Wpw=;
	h=From:To:Cc:Subject:Date:From;
	b=WWuzkfeeBYGRMal7EvzSPJ1GwuO9j5aqUIvjRD/XGiesQHPXHBQL4RuXh1Ed4gZfg
	 deRtyLECp5+T7H6Wyse4v5qDYMKCBT0wkBc1y0dCyY6AvrK7HuR9daK5FjFGmpG8yR
	 T57ZgSiCU27zWgZp6IXoHAuFKLuNIOAzmzY/nT8k=
From: Vladislav Efanov <VEfanov@ispras.ru>
To: Marek Lindner <mareklindner@neomailbox.ch>
Subject: [PATCH] batman-adv: Broken sync while rescheduling delayed work
Date: Fri, 26 May 2023 19:16:32 +0300
Message-Id: <20230526161632.1460753-1-VEfanov@ispras.ru>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-MailFrom: VEfanov@ispras.ru
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-b.a.t.m.a.n.lists.open-mesh.org-0; header-match-b.a.t.m.a.n.lists.open-mesh.org-1
Message-ID-Hash: LMGQIV5YEO3OBQHTKLQO442SY2NY7FI7
X-Message-ID-Hash: LMGQIV5YEO3OBQHTKLQO442SY2NY7FI7
X-Mailman-Approved-At: Fri, 26 May 2023 18:24:33 +0200
CC: Vladislav Efanov <VEfanov@ispras.ru>, Antonio Quartulli <a@unstable.cc>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
X-Mailman-Version: 3.3.3
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/LMGQIV5YEO3OBQHTKLQO442SY2NY7FI7/>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

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

Fixes: 2f1dfbe18507 ("batman-adv: Distributed ARP Table - implement local=
 storage")
Signed-off-by: Vladislav Efanov <VEfanov@ispras.ru>
---
 net/batman-adv/distributed-arp-table.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/distributed-arp-table.c b/net/batman-adv/dist=
ributed-arp-table.c
index 6968e55eb971..28a939d56090 100644
--- a/net/batman-adv/distributed-arp-table.c
+++ b/net/batman-adv/distributed-arp-table.c
@@ -101,7 +101,6 @@ static void batadv_dat_purge(struct work_struct *work=
);
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
=20
+	INIT_DELAYED_WORK(&bat_priv->dat.work, batadv_dat_purge);
 	batadv_dat_start_timer(bat_priv);
=20
 	batadv_tvlv_handler_register(bat_priv, batadv_dat_tvlv_ogm_handler_v1,
--=20
2.34.1

