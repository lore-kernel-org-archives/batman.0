Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8511DCD3424
	for <batman@archiver.kernel.org>; Sun,  3 May 2026 12:25:05 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id EAF7C858CF
	for <batman@archiver.kernel.org>; Sun, 03 May 2026 14:25:03 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1777811103;
 b=Mu2U9jIRNMRKMf6/da4mUjo+48XR1MsBV/m2BhWIo7YSc6HnG7AJ1GEIlKy/gT348zoVi
 abyatcRwIeYUCyNQI47FUTcrBXCeUpL09hjlq06H5b5MGBAufnVZGhEGmMbt+owHszqGP9w
 bjC51YvBU4TEUqGVn4yXi3O/Nxo6lnw=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1777811103; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=y82pMc95b72vf7aTpAvphzIev+8YN2RLW8o9k4UIYKs=;
 b=FYbeO87epMslmoELMd8OZf1+WWh0Crsga/UJEAtlGy3NaILOvwKPUjKJkPD3HkTI9SteW
 gr25AbF8BPIHUMuH69JtFoxAPTe4GBSdA2acKxzJr0hKYHFd5U+xdwYnm17Wy/OvCBR+FHc
 nKaE+AzXGfD/vikNDhiVtzOL+XZS+Q8=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id C958184746
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 03 May 2026 14:23:15 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1777810995;
	b=4JhkXbDrVGLQI47XNEifcAp+u/iD8SER2OESt45fYtdCSNLA7NoL0L0X2Zm7pBPCojPgLz
	A9vA1SMUJbBxE4VLiNDcMjddk94tkmS2kI+yo9FwM+Xbs2Ra+u7NFY6KVu5rtRpRyt9Ung
	FWIG1EQfjQScf07z8L7Pmba/9oXo5mw=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=DXqGjAM8;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1777810995;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=y82pMc95b72vf7aTpAvphzIev+8YN2RLW8o9k4UIYKs=;
	b=MqfP3uqwlO3rgZ6D91bJPnQKQBOKZ1UU2ITGlyh9XhRYVWpc4N+aSkogmiqCviGHOm/GYc
	r5q8B5PUe0pQ+nqzRE9pCxPHpGThtq30vgAjtC/wg3VkTqlrFky22VeV8dQcX5VetFpKw+
	xejJRHJmWXZ8+tAY3A9wq0Mt7Vm56gY=
Received: by dvalin.narfation.org (Postfix) id CC9761FF1D;
	Sun, 03 May 2026 12:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1777810993;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y82pMc95b72vf7aTpAvphzIev+8YN2RLW8o9k4UIYKs=;
	b=DXqGjAM8z0h1bwQnGQNcCLZ33/eaku8CFDYL5nKpyxxqbYiOhJMtLb8/jV1cVMXfTteORj
	aCezlvA8//kf5td9UG1bUzNzLop+4eGv97twkIt4XYGIF85yXowQe5wPpxBSc54GOAE3JY
	H7hl2D70DYyMXlRJuIRKxTTYqVSjdgI=
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 03 May 2026 14:22:34 +0200
Subject: [PATCH batadv 1/8] batman-adv: tp_meter: fix tp_num leak on
 kmalloc failure
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260503-fixes-followup-v1-1-4313278918d3@narfation.org>
References: <20260503-fixes-followup-v1-0-4313278918d3@narfation.org>
In-Reply-To: <20260503-fixes-followup-v1-0-4313278918d3@narfation.org>
To: Marek Lindner <marek.lindner@mailbox.org>,
 Simon Wunderlich <sw@simonwunderlich.de>,
 Antonio Quartulli <antonio@mandelbit.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Ao Zhou <n05ec@lzu.edu.cn>,
 Haoze Xie <royenheart@gmail.com>, Jiexun Wang <wangjiexun2025@gmail.com>,
 Juefei Pu <tomapufckgml@gmail.com>, Luxing Yin <tr0jan@lzu.edu.cn>,
 Ren Wei <n05ec@lzu.edu.cn>, Ruide Cao <caoruide123@gmail.com>,
 Xin Liu <bird@lzu.edu.cn>, Yifan Wu <yifanwucs@gmail.com>,
 Yuan Tan <yuantan098@gmail.com>, Sven Eckelmann <sven@narfation.org>,
 stable@kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1709; i=sven@narfation.org;
 h=from:subject:message-id; bh=y3CLfUvdtFr/SVbGgj6OpkFHV0+uLxKRC+dYOR1+iy8=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDJnf7WTW/rpkaPqv78Teg5Feqkn5LVoTC4xLlc2/3lRN5
 0tQadXqKGVhEONikBVTZNlzJf/8Zva38p+nfTwKM4eVCWQIAxenAEwk5zsjQ/eeRYJz5zack/Xs
 dfm4X/RPtPQvI7anXAEHJq9v6llSKcrI8KPzZMPGCN6TpnVazT4y+VECTGECp3f79+eJfBO83/i
 CFwA=
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
X-MailFrom: sven@narfation.org
X-Mailman-Rule-Hits: max-recipients
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-3; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-size;
 news-moderation; no-subject; digests; suspicious-header
Message-ID-Hash: 5QPRCX5QZUYT2XJ4KHNWG3A3OKOGZDS5
X-Message-ID-Hash: 5QPRCX5QZUYT2XJ4KHNWG3A3OKOGZDS5
X-Mailman-Approved-At: Sun, 03 May 2026 14:24:15 +0200
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/5QPRCX5QZUYT2XJ4KHNWG3A3OKOGZDS5/>
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

Cc: stable@kernel.org
Fixes: 33a3bb4a3345 ("batman-adv: throughput meter implementation")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/tp_meter.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/batman-adv/tp_meter.c b/net/batman-adv/tp_meter.c
index 58ca59a2799e..066c76113fc4 100644
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

