Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDBF4CD3439
	for <batman-adv@archiver.kernel.org>; Wed,  6 May 2026 20:24:56 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 4CBA884489
	for <batman-adv@archiver.kernel.org>; Wed, 06 May 2026 22:24:55 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1778099095;
 b=WSNZii7R1CRRaCkzK1Kvqyvf9f2MfT8cIaWY7xMdM7ZyB0tm24s9qlnINj4UwnnRp3H8G
 FVu/xyDlYZJJjj0BCuZsOpPht6WUgr74xm+qdeqv5VKz1tCrrUjmM6gE6Hl785UxiTcIeJ2
 PU1EJqvEcCQpZCqdfykup31Yb1O0F0U=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1778099095; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=fViRYA3vqCdIdBLTqLAoJ1EfUReki3G6wMAy+WH+MZw=;
 b=PSkDTFgdqaNAm5D7kJIT3NAKzvqo/yGkLjcf94RXNMzuSxoZ0Kj9/6hy84JO7eqDBPfSZ
 CTqIZhnOf2rUmrqzju11EcezBCV1K+9HM9pvpOw/OM2wDIgy6M+N5zFQGZiN2JvVPFlLNOA
 siGkmxCwMfkdVLtHk1iMsSPqG3XukeU=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id A18AE844D9
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 06 May 2026 22:22:14 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1778098934;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=fViRYA3vqCdIdBLTqLAoJ1EfUReki3G6wMAy+WH+MZw=;
	b=i3IIB/lco+RILSnLeLD66zWN9+2OG58QOTA54j04/+z9F3uk6R9LahLNULu+G0ntLbFY8F
	ZkE5LoVqbaEE9EDgGmjFJUCaFqQ8Bxs4gAjXzpBAjRK3CHnT8IRQdgi7gh1+k2R8CjPzyS
	HQNmAhqgX0w/FgTe7dWp50qwgYmvutM=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=bApNPEAg;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1778098934;
	b=1Q+dJK8jpPvMGE6oDfcOca/VIvoIjtpuIiaMyGWxyMNRKJdkI7NLh9MtDIUTpWF9SFbYvW
	0VX5NPV9Do0U/JrO1l8m6U/560Tyqald+CX0os0aFF5YDuxRxWJ7C2IGrh2XwQjTpE7IKN
	S45U57dhaX7TqTbE7lpnhfpC2lS6txE=
Received: by dvalin.narfation.org (Postfix) id 608CE2170A;
	Wed, 06 May 2026 20:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1778098934;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fViRYA3vqCdIdBLTqLAoJ1EfUReki3G6wMAy+WH+MZw=;
	b=bApNPEAgTsqAPtMPShw4xGWshJkvlezYqnBWcWbZTt1b1a9+PkOzSNM4UvgJ6YQBbsSoaT
	VmrEzciq3Nw0X7ARlJaMRzNNl8I6hD2wUkP2UjFVACSY+LFLAu/MmmqJExDe0tJfK1HDha
	jCy55EBNJi9q0qT73l0hQ6WyuxqMVeA=
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 06 May 2026 22:20:51 +0200
Subject: [PATCH batadv v2 04/11] batman-adv: bla: only purge non-released
 claims
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260506-fixes-followup-v2-4-ce32a2d8d4da@narfation.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1868; i=sven@narfation.org;
 h=from:subject:message-id; bh=JWvaEfidmsriEfirxepF9Fk1Xa0aZCjroyap9WoBSuM=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDJm/Fx0QWxDxluuR+exFlb8mzqux8wid0a9RIJ0/5bTsp
 5i7+9wvdJSyMIhxMciKKbLsuZJ/fjP7W/nP0z4ehZnDygQyhIGLUwAmUpnEyHBw9YSNGU2eoW65
 03iOBq7KK+fZfKU/laORPUnz6yrpx9wM/5N+KsTtTSqt+J9/uyjzyeMurmUz3kR8XX7699XTXw1
 stVkA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: 3QVKXT7ZOGWR6PYZP5GUGO72MZIPDGI2
X-Message-ID-Hash: 3QVKXT7ZOGWR6PYZP5GUGO72MZIPDGI2
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/3QVKXT7ZOGWR6PYZP5GUGO72MZIPDGI2/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

When batadv_bla_purge_claims() goes through the list of claims, it is only
traversing the hash list with an rcu_read_lock(). Due to a potential
parallel batadv_claim_put(), it can happen that it encounters a claim which
was actually in the process of being released+freed by
batadv_claim_release(). In this case, backbone_gw is set to NULL before the
delayed RCU kfree is started. Calling batadv_bla_claim_get_backbone_gw() is
then no longer allowed because it would cause a NULL-ptr derefence.

To avoid this, only claims with a valid reference counter must be purged.
All others are already taken care of.

Fixes: a9ce0dc43e2c ("batman-adv: add basic bridge loop avoidance code")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/bridge_loop_avoidance.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
index 8b77dd2e..879ab043 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -1288,6 +1288,13 @@ static void batadv_bla_purge_claims(struct batadv_priv *bat_priv,
 
 		rcu_read_lock();
 		hlist_for_each_entry_rcu(claim, head, hash_entry) {
+			/* only purge claims not currently in the process of being released.
+			 * Such claims could otherwise have a NULL-ptr backbone_gw set because
+			 * they already went through batadv_claim_release()
+			 */
+			if (!kref_get_unless_zero(&claim->refcount))
+				continue;
+
 			backbone_gw = batadv_bla_claim_get_backbone_gw(claim);
 			if (now)
 				goto purge_now;
@@ -1313,6 +1320,7 @@ static void batadv_bla_purge_claims(struct batadv_priv *bat_priv,
 					      claim->addr, claim->vid);
 skip:
 			batadv_backbone_gw_put(backbone_gw);
+			batadv_claim_put(claim);
 		}
 		rcu_read_unlock();
 	}

-- 
2.47.3

