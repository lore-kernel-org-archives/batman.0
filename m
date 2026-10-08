Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5004ACA600C
	for <batman@archiver.kernel.org>; Thu,  8 Oct 2026 15:55:20 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id AE7FA84517
	for <batman@archiver.kernel.org>; Thu, 08 Oct 2026 17:55:18 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1791474918;
 b=wmOi41AMrboJzPBME29YRduNYPj6FjdTWpzuIks3G+Hja0Fo0E9+rCFQXVDvMJQgjLJR2
 68F+uPWi/75t0LMEmPQ7sUpPJgEtTkh7h9oC1LUVMCJ7nSYaemrowcVhxTgWHZ2SC0BOxD4
 Tlq7OynfbFNNEO7uk8X8qOZv4A80Y/E=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1791474918; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=TaI6CV0OWqBNk0TR8Zp6dWEZg/l4xGHqCAAKt2jZL9c=;
 b=aDWM8hPZr/rFH0nnokGAoq1UxLEPNIXg/+QCjDbBdgOgxdPS4iNsikK8N15WyJNDzdi1x
 1/AtsK3vqXPhgnJBMOeo2NIMzYSk741HPoudMIKtfIn1KpgDMXVvOW7CxgX+iXOimNDLEUR
 1GSaBHYUmx//rUdxpDWsrRjA687CsZU=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 4DB4484341
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 08 Oct 2026 17:53:15 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1791474795;
	b=0BauB81NtFmHde1c2wR7zL7S1FN/nvbYH1Si25JvFrlhAQoJyJ0SKfTsUiEqIb8KyiNe3W
	cWlV+Z9cWEJJsFYef8ZkzpBEiMzGt8KHjR26iEbMmzl8/lCdauqwKjXSvQ0ETU5BOJa8VX
	IP/I9iUGkMCDSdzaEVbMRgQ4plDglqI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1791474795;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=TaI6CV0OWqBNk0TR8Zp6dWEZg/l4xGHqCAAKt2jZL9c=;
	b=qLN9MfWSDaGrKNtN/sqy5F8nsYj0G08F/U6gxsR3uDQpSQeXiUJxU+lKGiFAJN0Ej+R5iQ
	sIMKZShpQa5+vXP1Pm6Gp4XBluRQj3hgntqdHJVg3jxqNGzQiv0v2LB8hmCzd0Kl4KOhoc
	+u9J8M28amTCMXNOqPsH103j1mxf9co=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=xSaXlXMF;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 0EE0E1FEA4;
	Thu, 08 Oct 2026 15:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1791474795;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TaI6CV0OWqBNk0TR8Zp6dWEZg/l4xGHqCAAKt2jZL9c=;
	b=xSaXlXMFDAT2iaJAzu8Q9CxNkQFEoBOfCLu1xuN0cskVui0AFY/pCYlybTEvBrrn+iRdkb
	4LKXOSv9JlL4Xbx/8+dMvQoaklEeBfWsDZudgCB/VnUHr8OIdB2z1AWRpnTD1IzwGGfrO+
	JPiBKfi8ATNqilKK1qewwf/qNN0VKgo=
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 08 Oct 2026 17:53:02 +0200
Subject: [PATCH batadv v2 4/4] batman-adv: increase orig hash generation
 when purging originators
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261008-tt-hash-generatopn-v2-4-72b61e956a81@narfation.org>
References: <20261008-tt-hash-generatopn-v2-0-72b61e956a81@narfation.org>
In-Reply-To: <20261008-tt-hash-generatopn-v2-0-72b61e956a81@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>, Sashiko <sashiko-bot@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1281; i=sven@narfation.org;
 h=from:subject:message-id; bh=TJDLD/c5sWgwhqDxcIRm2OKEtd7gjyVUG6gmO2VBtRE=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFnH98TfONUSxOYgKCmicMg/lvWRf8KzstdbAialXIyfv
 0XR+itrRykLgxgXg6yYIsueK/nnN7O/lf887eNRmDmsTCBDGLg4BWAikwsYGY5PEmir/iAqW7V8
 +6yP+1M2qmhGP9qzR+SLhvjuwu4/pWaMDEcmHDirJ16sdrwholjJ46yfwJYHJ3nKFmyUdn3i5v7
 kBxMA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: I5GBGVAXBJDMG6FGEDVIHU36ZBYNPY73
X-Message-ID-Hash: I5GBGVAXBJDMG6FGEDVIHU36ZBYNPY73
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/I5GBGVAXBJDMG6FGEDVIHU36ZBYNPY73/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

If batadv_mcast_flags_dump() is preempted during a netlink dump and resumes
in the middle of a hash bucket while batadv_purge_orig_ref() concurrently
removes an originator, the dump offset will be shifted.

Without incrementing the hash generation counter, netlink won't set
NLM_F_DUMP_INTR and the userspace will not be informed about the
inconsistent dump.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/bug/linux-83da443f-ce69-4393-a29f-e02b70d1ec96
Fixes: 06c82b7b15b1 ("batman-adv: Add inconsistent multicast netlink dump detection")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/originator.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
index f06583ef..c617a648 100644
--- a/net/batman-adv/originator.c
+++ b/net/batman-adv/originator.c
@@ -1287,6 +1287,7 @@ void batadv_purge_orig_ref(struct batadv_priv *bat_priv)
 			if (batadv_purge_orig_node(bat_priv, orig_node)) {
 				batadv_gw_node_delete(bat_priv, orig_node);
 				hlist_del_rcu(&orig_node->hash_entry);
+				atomic_inc(&hash->generation);
 				batadv_tt_global_del_orig(orig_node->bat_priv,
 							  orig_node, -1,
 							  "originator timed out");

-- 
2.47.3

