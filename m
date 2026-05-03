Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09BD9CD3426
	for <batman@archiver.kernel.org>; Sun,  3 May 2026 12:26:35 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 9222E858D1
	for <batman@archiver.kernel.org>; Sun, 03 May 2026 14:26:33 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1777811193;
 b=t4IfJDlqfbGaS5KgPqyGzqbdAUUcIYE6oRr7kD47S9F5jd2RZJ1vbC0RJUgve0/qaD1/H
 MLVO+ssxwzgnvXAXTbcJvkoqR6hmYe/i49dmSvsFRhCe52r8XBhel2UUs4mJ0ki+W/rFz7E
 7Cx085eXc6rDXNWOfr/n1UYyqJ5e/JE=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1777811193; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=AZMsjjixoBsE2+ugudq2Uz5c0QObLk7hKXWMZ1j7bG0=;
 b=Z3v75rxEKZ+yDIb+0nVwDfgaYYAkfspOr+MrS7yVouQig1a6X+OFlJgXgJ4bMEEScxunS
 C65z7tFTUOA3tACqD9zxbT/1L7lNH6pMXosI7t+FKDAz6R/RsGqbWRh/7LgtCt+Q+hz16wi
 OQXuijLZDuW3Vt2PRjbDdzRfAnug1C8=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 5289585341
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 03 May 2026 14:23:20 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1777811000;
	b=H1oeLTgtf09Oxdj/LYuJEsFQjfB057VFIKU9yNgafTLlMyaMbxrqalGySxY4r22e1f5ute
	IAGXvgfP3ppV5/mP9OVwIlc9DN8YrtAHaGAUpqk2UvY8o31qXZSblMclODcVYgNtulz0oP
	H78W7j8UfeeSkwiiwveuScAnpI3wqCU=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b="annmE/JN";
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1777811000;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=AZMsjjixoBsE2+ugudq2Uz5c0QObLk7hKXWMZ1j7bG0=;
	b=pAho776vfhSadOUUu1hCv/QnfU6m/5PQiYLncw0FxGf4k8/inUot7FraplYDlw1m4PkXYX
	bxBO8O+4IOz+mNUeO5RK3ozNdz9hnQM0bFGNh3xCtebT0Gx/Azh5YAk6JutuBFYXwyQXGq
	Bd3Zi+YHJmqZhU51nr20YDjb3MEfCLM=
Received: by dvalin.narfation.org (Postfix) id DE3C5218AF;
	Sun, 03 May 2026 12:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1777811000;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AZMsjjixoBsE2+ugudq2Uz5c0QObLk7hKXWMZ1j7bG0=;
	b=annmE/JN1gSr0LcIWCVd72EKrO3mhWspBzsWeq8fEoAkUxKEUNYC6HbyKm3BTBNASbVvnp
	bUy/jDsDogRFZHFOmwd9aRW/YqKU2YXE1sSKOxafOKJQ3lDq+mkbG1dffytbE3b2fHaVMN
	fS4XNk4kIw00maLf5QX6CMg/oE0lAtA=
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 03 May 2026 14:22:36 +0200
Subject: [PATCH batadv 3/8] batman-adv: bla: only purge non-released claims
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260503-fixes-followup-v1-3-4313278918d3@narfation.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1901; i=sven@narfation.org;
 h=from:subject:message-id; bh=SaBIHQebZmPSOsHqoC9WHlKONhBUR74hrhjtN1QSiSA=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDJnf7WTvJMe73+q9vDu5eP2c/x/nr+D5tFPbZ8EeoTvqv
 5pCS8PlO0pZGMS4GGTFFFn2XMk/v5n9rfznaR+PwsxhZQIZwsDFKQATObSV4b9L1FbJaWHCGxrz
 okSSd+8XnuR/8JK90XTmrrehOzVNTy9kZJhS/9JlnpXOpOrWTQ9Wn+5XuR+0evX8cGGetBkWT+Z
 NimIAAA==
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
Message-ID-Hash: XAYNCDKVAKCDUY4AKKD3YWZBL7Q6JHGH
X-Message-ID-Hash: XAYNCDKVAKCDUY4AKKD3YWZBL7Q6JHGH
X-Mailman-Approved-At: Sun, 03 May 2026 14:24:15 +0200
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/XAYNCDKVAKCDUY4AKKD3YWZBL7Q6JHGH/>
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

Cc: stable@kernel.org
Fixes: 23721387c409 ("batman-adv: add basic bridge loop avoidance code")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/bridge_loop_avoidance.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
index 8b77dd2ecfa4..9dbf945b4922 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -1288,6 +1288,13 @@ static void batadv_bla_purge_claims(struct batadv_priv *bat_priv,
 
 		rcu_read_lock();
 		hlist_for_each_entry_rcu(claim, head, hash_entry) {
+			/* only purge claims not currently in the process of being released.
+			 * Such claims could otherwise have a NULL-ptr* backbone_gw set because
+			 * they already went through batadv_handle_unclaim()
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

