Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E1AACD3426
	for <batman@archiver.kernel.org>; Sun,  3 May 2026 12:25:50 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id C352D85B0D
	for <batman@archiver.kernel.org>; Sun, 03 May 2026 14:25:48 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1777811148;
 b=eyUf2Q3QX8plZR9XzjM7LZR92KQe8NAbGP3cmyJXDJjew5CU3132odV4tWBNsw9LRVvWt
 +Oy5mrLpVFGIUWWw5EQK5Ob7B5SvWP4yX3KDwZClpIPauHcBSLzSouj/Qd3ecWo9G7ydmvM
 b566DBDOzTGICMzvdPoZJty/YydCMiE=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1777811148; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=samGb3z6dCDDaDRS0M76gCcHmbiT9j+PlgK7fTp49Lc=;
 b=knGt5VIkY8VNG929vRRpv5h4r98byOvv7boJj97LLSBC1D4Jao96FqJTt9foaD4wXOum4
 YggAFcyoIgjGScC+5HRva/sGDeuEgn4geBJIhjtkYDy5QhRkLJNn2QW0wke/n2c9GlAz77h
 66bbVqNHmXE/t0r0We2XHSRWKzsOKPw=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 987F385341
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 03 May 2026 14:23:17 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1777810997;
	b=p32OGjSX8Fklzn0g2PhPREHpNkKApSAxYaTrapkDelYBZZokS3H15SsL1h2YauZCrjqHbk
	HSmK8tswhndFLvaZy/vJG+s1+Oq8KTUJtI5LoIOZoxA3a07rLn2I2I6jsj+B/EQO+ylQlA
	usBYkK/eTUqsy9wOZZvuE8s4KF3Tdg0=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b="ztr/6Xkz";
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1777810997;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=samGb3z6dCDDaDRS0M76gCcHmbiT9j+PlgK7fTp49Lc=;
	b=lwzzpRnwfX0V4lj01uccQshA66VG60yznNQ7vtAZ4L6Ww7MqoWJLLuc1U9kf6nSIfYIchl
	FcAKlNLAePNuK32egKxQeBvxiXaqH2IIsdtKqgeeey0EX1x1K6meAoSs14M24xlVxOp6Qp
	6tA/mirBSpXGC2puV0vrIELRdjJ9ZSc=
Received: by dvalin.narfation.org (Postfix) id 2785A20D39;
	Sun, 03 May 2026 12:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1777810997;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=samGb3z6dCDDaDRS0M76gCcHmbiT9j+PlgK7fTp49Lc=;
	b=ztr/6XkzVLBVj5yBpWQQWjYaRI64iCxnXJoVRbjTkBnBkbotlbxp99tDmugyDY/u1dXqyK
	slCNrT7Q9ER1fAFxGwNij3gFxwDEZ4NEjXURUS5LYoEKZgQ0M6bWVAHh3DytYRgNhTQKZs
	0bwqOHJREWdW5P8LVUFzcCWvZ5Em/14=
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 03 May 2026 14:22:35 +0200
Subject: [PATCH batadv 2/8] batman-adv: bla: prevent use-after-free when
 deleting claims
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260503-fixes-followup-v1-2-4313278918d3@narfation.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1274; i=sven@narfation.org;
 h=from:subject:message-id; bh=hj/nqN5j0xZ710VI2jMwCjeM18garF0jjKOPz1zQWLQ=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDJnf7WSLPHq/Tat9eD2/W3aaM+/0N6WuLBKFlwo64p4/v
 bzkUua1jlIWBjEuBlkxRZY9V/LPb2Z/K/952sejMHNYmUCGMHBxCsBELIUZ/tm9sOr5sXmq1r7b
 hpclrEtOTliwdHaMQu/7gif810qWOKszMqw2TPuzWb7woVrR4o1X11yU9D35MadDyWyf+J1OT02
 tV/wA
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
Message-ID-Hash: FM5WKNJA72NOSW2RUAAKWUORLDL66FHZ
X-Message-ID-Hash: FM5WKNJA72NOSW2RUAAKWUORLDL66FHZ
X-Mailman-Approved-At: Sun, 03 May 2026 14:24:15 +0200
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/FM5WKNJA72NOSW2RUAAKWUORLDL66FHZ/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

When batadv_bla_del_backbone_claims() removes all claims for a backbone, it
does this by dropping the link entry in the hash list. This list entry
itself was one of the references which need to be dropped at the same time
via batadv_claim_put().

But the batadv_claim_put() must not be done before the last access to the
claim object in this function. Otherwise the claim might be freed already
by the batadv_claim_release() function before the list entry was dropped.

Cc: stable@kernel.org
Fixes: 23721387c409 ("batman-adv: add basic bridge loop avoidance code")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/bridge_loop_avoidance.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
index 51fe028b9088..8b77dd2ecfa4 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -318,8 +318,8 @@ batadv_bla_del_backbone_claims(struct batadv_bla_backbone_gw *backbone_gw)
 			if (claim->backbone_gw != backbone_gw)
 				continue;
 
-			batadv_claim_put(claim);
 			hlist_del_rcu(&claim->hash_entry);
+			batadv_claim_put(claim);
 		}
 		spin_unlock_bh(list_lock);
 	}

-- 
2.47.3

