Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41926606A31E
	for <batman@archiver.kernel.org>; Wed, 25 Nov 2026 19:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.a=rsa-sha256 header.s=20121 header.b=rTa36zRC
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id C0B89825D3
	for <batman@archiver.kernel.org>; Wed, 25 Nov 2026 20:43:52 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1795635832;
 b=bRLy0/wq4EXFnQ7zCE/8WStop35apK/i4bRxfMpDnKJd88i+Gnh0pHErdtDI1lLdZvD8l
 mky/dWzDKI15OXul4I+Bcir4yDZh5OFLC7E1LgDvNzn3p3fw3c4AjFIRX8VXpzzST5Dqq1q
 tdufk2evQD/Jwd4McHwjt+V8N23jZM8=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1795635832; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=EM69ZkmDhb/MFB/UtIabIiNVpXu08bGHKV+Ov1MYFA8=;
 b=UQyM1HV4el8bsYGEFxsTG6phUTetMJoOb2m6aUoIovgBy5aJZaf1UiGMpKRdzSJVwk6iw
 l6RXLyk+QpxlVhbBN9HK1NNbvuFmd4CyxcP3t6jkl029qBVMiduboCwnfMhN7LN+DdntgnR
 IPigD9c2usQwIJXroGLVb8PgeuECg8Y=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 46F0782EB7
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 25 Nov 2026 20:42:06 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1795635736;
	b=h15y3OXC8+DbT099UBj64NJ8jefEILO6lKpYRFdaJPUtDQfpwlfrY1peDNLoR2gZKa/fwC
	MOh0Na0bHOU8+lza5vU8arMALWKWOQmFUJe/B7MZhzGG6hqLvo9h5BFfuz1vzYo1qTeG5Z
	r9WvNwj1tN/rrd6yF9ZMNUJnclC1m6g=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1795635736;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=EM69ZkmDhb/MFB/UtIabIiNVpXu08bGHKV+Ov1MYFA8=;
	b=pZ4BDgbuNeSd/3sbutOJCLMgYw++6Gj0SoQw7XeP2TbSUWlDUHhEgZ/LepN4dbML9Y9eiG
	/s58GCOX9551udJtdbR1Gv/FSwxsDkoF01TIIN/3Sb4iDO8OUe1Zzng0XqOrbmbpJOCbRF
	EldjK+pXdIkaCXMm7M8ntTMqFhpvYi0=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=rTa36zRC;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id AC0772006D;
	Wed, 25 Nov 2026 19:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1795635725;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EM69ZkmDhb/MFB/UtIabIiNVpXu08bGHKV+Ov1MYFA8=;
	b=rTa36zRCmy+TvuRAdEPLxcScSthv9aiffV5ENQ+1D3pFbGpcCuWk+fW2oYvBDaoi7O4pW9
	kD635yfQz9aFZrjshAQrLfftIP0/xdDHA7htFABupIIOxGbJSKJoc7S4IWT9Rib8ndwrCJ
	KX13TN+BOIFbFGiCs07gLodfOvr4GB0=
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 25 Nov 2026 20:41:57 +0100
Subject: [PATCH batadv v2 2/5] batman-adv: tt: clarify uncounted state of
 new local entries
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261125-sashiko-kdoc-2026-11-24-v2-2-d26231bfcbd3@narfation.org>
References: <20261125-sashiko-kdoc-2026-11-24-v2-0-d26231bfcbd3@narfation.org>
In-Reply-To: 
 <20261125-sashiko-kdoc-2026-11-24-v2-0-d26231bfcbd3@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>, Sashiko <sashiko-bot@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1394; i=sven@narfation.org;
 h=from:subject:message-id; bh=scnZ3jrC48aGoT8VfwLthKwYF7+AGrlE6YXGNdLMWB4=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDNnsVqyhWXlBjmyz+9ZPenT+p+GRq63TgtdVRa5KWmnjI
 HFPY0VkRykLgxgXg6yYIsueK/nnN7O/lf887eNRmDmsTCBDGLg4BWAi3t0M/5M8l9hsUnyT4m/9
 /Plcw31/Gf9GhGT+/PFzv+CSZKVTpzQZGfau2O3axm0dLrHsls/JJXO+KU4ty+n2aL/V+79k/fX
 QTVwA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: 5DYSQ3EHC542W7HU4V2QWBVEYM56QFAV
X-Message-ID-Hash: 5DYSQ3EHC542W7HU4V2QWBVEYM56QFAV
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/5DYSQ3EHC542W7HU4V2QWBVEYM56QFAV/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_NONE,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The comment in batadv_tt_local_unhash() states that an entry with
BATADV_TT_CLIENT_NEW was never counted. But batadv_tt_local_commit_change()
can bring an already counted entry back into the BATADV_TT_CLIENT_NEW state
and uncounts it. The flag only means that the entry is currently not
counted.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261123171827.3294525-2-sw%40simonwunderlich.de?part=13
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/translation-table.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 82eadd73..74ebf7af 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -1949,8 +1949,8 @@ static void batadv_tt_local_unhash(struct batadv_priv *bat_priv,
 	hlist_del_init_rcu(&tt_common->hash_entry);
 	atomic_inc(&hash->generation);
 
-	/* An entry which still carries BATADV_TT_CLIENT_NEW was never counted
-	 * and must not be uncounted here.
+	/* An entry which carries BATADV_TT_CLIENT_NEW is currently not counted
+	 * because its ADD was not committed yet. It must not be uncounted here.
 	 */
 	if (!(tt_common->flags & BATADV_TT_CLIENT_NEW))
 		batadv_tt_local_size_dec(bat_priv, tt_common->key.vid);

-- 
2.47.3

