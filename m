Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BFBBCD6E55
	for <batman-adv@archiver.kernel.org>; Wed,  3 Jun 2026 04:18:25 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id C40438142D
	for <batman-adv@archiver.kernel.org>; Wed, 03 Jun 2026 06:18:23 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1780460303;
 b=r0IM43w9h9cxUAJGpi7AO4Oe05Pjml6LFiaIsecXeuBVdXN94AV8xe6x6AUX5cQBfeKyu
 kV8VGtE8D0Ei2Fe7y2W1Y6Ng0K7SZYWV0tB+ADtKTbFJHJQu0RRju4OyOGsr+RtN9qm9NS3
 M+ZugUrRVN6ZxLLeZUBVGNYHfCAK4us=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1780460303; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=DcKqDiuvxXYVxN/5Geq2+aPy7Lks2HfDHkJeTa3WCiM=;
 b=IpYMfEU3+9tRWK2z4YX17hsPUAHCBDxhaMqRz4ksKCVBRTahz78HPvieukdibeYPFaI/K
 ZJotHA0YuP52WOMerQi0NX7yBQFPyknvyxub8S81iCVxo6XJeJjf9YEauSFrWZmBeXFfDhL
 hkehareuvFTp5d7nBPkiuakguEk/b5k=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 3A2AF81EDB
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 03 Jun 2026 06:17:26 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1780460251;
	b=fh4MyHPRXA9nCWjt+tQsntqYAWsovT5XzrgY/pE8WrUiPkr4t+kMDZZM/wGMcp8ErS83C7
	toFQTF12gVWaTZvpOFz/XjJwyCEZClc0l8Kz4FlPEIiZYZ4cgXi26oM1/dTk9RzvKaKcAG
	eMPiQZ2wQsBzRAVl6WXbdMHDu4i0dm0=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=jnJlGg3T;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1780460251;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=DcKqDiuvxXYVxN/5Geq2+aPy7Lks2HfDHkJeTa3WCiM=;
	b=kkanrlC8VEsMG89wfdmFqNyAN3p9XK0h5iFXoiRDWGwKGtkxn3tvecsZMRiHpRt9mleCHg
	cr//PNIjVivWVkR8JeCtBhsLU0gcUJ9WsHP0fF1pzb49BJZLdHv/+1WqHI3x7JcKW9BXG5
	lc5AC2aW12pesWf33UTHYPksRyG/v+s=
Received: by dvalin.narfation.org (Postfix) id CE6EE201A1;
	Wed, 03 Jun 2026 04:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1780460245;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DcKqDiuvxXYVxN/5Geq2+aPy7Lks2HfDHkJeTa3WCiM=;
	b=jnJlGg3T+lQ3UqE9WDCl2VwXy8LxHaQK2TG7KbgqNrkgC0F65yijLrSvGWWzzPk4DWKY4J
	IqpNVlzuacJJiMZuUVrMRxbcCJDW9uL0x9VNZONGkNfnYMSwZGtBJ5Jhenqc7cn1jrlAdj
	KxL1H5zrQmaV1yJw7kiAdbwW3vfjOpc=
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 03 Jun 2026 06:17:13 +0200
Subject: [PATCH batadv v6 01/11] batman-adv: tp_meter: keep unacked list in
 ascending ordered
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260603-tp-reason-missing-v6-1-7011620f93a5@narfation.org>
References: <20260603-tp-reason-missing-v6-0-7011620f93a5@narfation.org>
In-Reply-To: <20260603-tp-reason-missing-v6-0-7011620f93a5@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1312; i=sven@narfation.org;
 h=from:subject:message-id; bh=UIcR5xq/hnw3fxAoxyQ/aS2BgiWPSni46VlWd+rucGw=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFnyq06zy6nd+sVo+27K/HUL/nh4LFnwM7Jj2v/iv80lQ
 d9eLN+/r6OUhUGMi0FWTJFlz5X885vZ38p/nvbxKMwcViaQIQxcnAIwkbrDjAwTuuTMEvcrRf1a
 6shvYjvpbfWCo3+Pvm1clZxYN2Xx92l/GP57bZ+65Fi22ozwnMCT1yZbWFywzfv/kFnRbeUjlu1
 PTc6zAwA=
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: 3INW4X4LCBYKU4SLBDFUOV2TYDUQ4COD
X-Message-ID-Hash: 3INW4X4LCBYKU4SLBDFUOV2TYDUQ4COD
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/3INW4X4LCBYKU4SLBDFUOV2TYDUQ4COD/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

When batadv_tp_handle_out_of_order inserts a new entry in the list of
unacked (out of order) packets, it searches from the entry with the newest
sequence number towards oldest sequence number. If an entry is found which
is older than the newly entry, the new entry has to be added after the
found one to keep the ascending order.

But for this operation list_add_tail() was used. But this function adds an
entry _before_ another one. As result, the list would contain a lot of
swapped sequence numbers. The consumer of this list
(batadv_tp_ack_unordered()) would then fail to correctly ack packets.

Fixes: 98d7a766b645 ("batman-adv: throughput meter implementation")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/tp_meter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/tp_meter.c b/net/batman-adv/tp_meter.c
index aefe7572..0e39ea33 100644
--- a/net/batman-adv/tp_meter.c
+++ b/net/batman-adv/tp_meter.c
@@ -1325,7 +1325,7 @@ static bool batadv_tp_handle_out_of_order(struct batadv_tp_vars *tp_vars,
 		 * one is attached _after_ it. In this way the list is kept in
 		 * ascending order
 		 */
-		list_add_tail(&new->list, &un->list);
+		list_add(&new->list, &un->list);
 		added = true;
 		break;
 	}

-- 
2.47.3

