Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31F72CA600C
	for <batman@archiver.kernel.org>; Thu,  8 Oct 2026 15:53:50 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 8E5AC84295
	for <batman@archiver.kernel.org>; Thu, 08 Oct 2026 17:53:48 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1791474828;
 b=qYV1VnTcFo/H2HcKJmELso+dM7LhX/eQmwG3AVa3X6+dH7BxZ3ATk4787Maaj8QdTaHXQ
 68XrURUBmGOa/B4f87gY0ZzPCjwXCmYJ/mfRaGLplbrSGzpRyhDLP2ESAUlRPElIsyA8juS
 aWwiCR902HUk6WDSrh/hEqirxzTNPLU=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1791474828; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=8485vTNxLWDhIp8A6a2c89cDvvM9pEl7GZkctMV4yEE=;
 b=VZY4yztN7be69psuD2+1M0jF0O9BadnSX6kawF3UFIMZ8DlCMSr4lpsc4cWoTIjFORC6Z
 V5SvBMQC00HDnhcBAbiRZnJJtjGaugyeT2wZgJVczvc0rJFftjuGGyHQ10AjLQQsvzGpuQB
 I4ujfNX5gl28D5+gYegDRD9sqbTv93c=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id CEAF380DAE
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 08 Oct 2026 17:53:09 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1791474789;
	b=hRpOAgENoz9QhM4AvmhoNXsB5jdb/1vQ19Lo3c9laLQg/V25+Y+ZA7N3ZaVHzZgEJwux/H
	t5GvJcNdUpDSpRiYH+rVXQyMXFEhtjA0OY2Y9dB0VqLb9k6RYrp3DWsFqkt+YyVL6APp53
	iga0i+7Q3v2fN5sCHqn7+lnBhUwXefM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1791474789;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=8485vTNxLWDhIp8A6a2c89cDvvM9pEl7GZkctMV4yEE=;
	b=KhAUvGn5zraD+1q0kwYtleDWTxs86Q78gf9/QIZAeNZHTxt0WqTs9GqoBYh0UFxIqpl9b2
	huCFjEZiVaBcSidmd9V7ltP2r9LifzdClZu/inbmBK24RtzHUSGYswpODq8FIbG6fPsDuS
	evidneW0JhAxUoMB4QISGT5ocVW6pdA=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b="G/Yx5FK9";
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 5AE95204B3;
	Thu, 08 Oct 2026 15:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1791474789;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8485vTNxLWDhIp8A6a2c89cDvvM9pEl7GZkctMV4yEE=;
	b=G/Yx5FK91v8XbCAaGKi4nt7MuIlavuqWqpf2J/hT3hmseeMuadyCwO9Q8XV8xfqgH5xdhs
	UvTTWKTTDXyAlhUbMajFNJK1XqZcCs4nKnhW6A+TNFI/kNkCdCJI7Y/MS4kk+dlC9Ei7uv
	kp8kc+fbk8u/dVB86hDBDQqnLW0boho=
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 08 Oct 2026 17:52:59 +0200
Subject: [PATCH batadv v2 1/4] batman-adv: tt: increase hash generation
 when purging clients
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261008-tt-hash-generatopn-v2-1-72b61e956a81@narfation.org>
References: <20261008-tt-hash-generatopn-v2-0-72b61e956a81@narfation.org>
In-Reply-To: <20261008-tt-hash-generatopn-v2-0-72b61e956a81@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>, Sashiko <sashiko-bot@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1326; i=sven@narfation.org;
 h=from:subject:message-id; bh=b/NGkp/FkOOsLrWYIdDmu4Ao6M1d1E3vLKomKFxZWvw=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFnH98SXTPfqPFy160SB/IbVBsKsj4Ku6xWYlW1eud521
 7klaocedJSyMIhxMciKKbLsuZJ/fjP7W/nP0z4ehZnDygQyhIGLUwAmEufHyNDZe6Kl6HmIriST
 0AGXCgbJiToZz2pmXzh1fvZk1efXTh5i+J+1RfBJm3D8EreJV39u0lePC441/PLlXMGyr2x/8o6
 /fcAHAA==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: HEGBEARYB6KKYSL3BY4P5XFBZBUILO5S
X-Message-ID-Hash: HEGBEARYB6KKYSL3BY4P5XFBZBUILO5S
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/HEGBEARYB6KKYSL3BY4P5XFBZBUILO5S/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

If batadv_tt_local_dump() is preempted during a netlink dump and resumes in
the middle of a hash bucket while batadv_tt_local_purge_pending_clients()
concurrently removes an entry, the dump offset will be shifted.

Without incrementing the hash generation counter, netlink won't set
NLM_F_DUMP_INTR and the userspace will not be informed by the inconsistent
dump..

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20261008-tt-avoid-unhashed-event-v2-0-7c4eed81606d@narfation.org?part=6
Fixes: 45e3ad80fd80 ("batman-adv: Add inconsistent local TT netlink dump detection")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/translation-table.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index e46040fd..4806bd89 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -4435,6 +4435,7 @@ static void batadv_tt_local_purge_pending_clients(struct batadv_priv *bat_priv)
 					   batadv_print_vid(tt_common->vid));
 
 				hlist_del_rcu(&tt_common->hash_entry);
+				atomic_inc(&hash->generation);
 
 				/* An entry which still carries BATADV_TT_CLIENT_NEW was
 				 * never counted and must not be uncounted here.

-- 
2.47.3

