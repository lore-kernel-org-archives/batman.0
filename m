Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C17606A329
	for <batman@archiver.kernel.org>; Sat, 14 Nov 2026 09:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.a=rsa-sha256 header.s=09092022 header.b=W0oUDiZq
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 4950F85CE2
	for <batman@archiver.kernel.org>; Sat, 14 Nov 2026 10:24:10 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1794648250;
 b=PsJ2RDE3RG+Plv2TURIf59qFolMn/0RQ7v1cuYO+wm5CUnNteo7gYa4WrV+Vv3NnArSQY
 Ln5C7Gc2So4Zxk+hu2KCCfwkUmEqv+4/eR4qMJJsVjFpBslXl0A+uMH0Y4GL9tBd+uk2ySM
 AAqtiO9NUQEwDrSFngj1gClabt543KQ=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1794648250; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=WYWKSH+OcUm9juSk9Bmx7b1oIobikB6gENpthM5hQpM=;
 b=qQHjP2USnEjd3HZHlSLaqZTfOP7QdUodQmqWecB/JQSo9TdTPvjWCgqG5yylelKOOUhTr
 jcjO7F1vdExy1PF/TYfChUuTmPFp89NBVm7ZmTv1gGz2x1gMnA1BfdXnt62vTUd/G8kNHpS
 R+wv+frMXzLxPV7hSUtXFcs2sCFlI5Y=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de
 [IPv6:2a01:4f8:c17:e8c0::1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 3A4AD84762
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sat, 14 Nov 2026 10:16:12 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1794647782;
	b=k2tLYWCYnP3P/wLGQggRvVW9Zs+1MsHNpLqamfa/gdqwnK0Qg3KmCofOp5iNK3X4hT8L06
	dj5EWzU0Bzhcxb7JjAvKQu6NwcKH5wOR0Gs80J/6XGMPmJgnZ1U7eHQU8tBeUt7Nr/m3SS
	Msdp2lniOowhwaWN1Tqkz4MCg/+HSXw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1794647782;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=WYWKSH+OcUm9juSk9Bmx7b1oIobikB6gENpthM5hQpM=;
	b=ZZEcP12EoUBeog890qlZe0Pc1AxKRxuF+8S7IqHen3ydoC2Fs1dzn6xYO3ppHebQq716Kh
	FinLSsp79CGGbBUeW9hi2Itm+IUkyFffQR5SNnjj2ZbzP3sM+6M/FcuJC6nZH3BRVP7Nzy
	2exjE03RFkSBGm2PXzUoiisGwDGX5Qo=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=W0oUDiZq;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 2a01:4f8:c17:e8c0::1 as permitted sender)
 smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
Received: from kero.packetmixer.de (unknown
 [IPv6:2a02:3037:6ed:dd6c:838:344b:3152:2d5e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with UTF8SMTPSA id 710BEFA261;
	Sat, 14 Nov 2026 10:16:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1794647768;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WYWKSH+OcUm9juSk9Bmx7b1oIobikB6gENpthM5hQpM=;
	b=W0oUDiZqo6BEHLvYRUtshJWICsJ46J206CINn1TnYaRCplbUq9H65CNNoA/bsxTRNakZC7
	PK8ousgfFp6cTJPQ+3a9zG+HCX90WcpDoAmyCFdGsjwPClSFhoWEIpQ7YwfmNpjelZfQfT
	BEQKw8KpXzhH52AEPdnxwR5Avzv9tcJEpjF/tEv1LXITQduhhj+Pmqyjcu+iW4L1tPRSYJ
	mJH958CNCQk7W+IcS/w5B2fRlH6EdExmwpheQXrUzBzKKS+A3rHg/6eRCPaAH1pFeYNGPU
	s5WNwzz9G5tBThBgUPzwDDepT8jYZHwBYR8zNUFFNbfKI+jv1p5Hind4CwfXiA==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Sven Eckelmann <sven@narfation.org>,
	Sashiko <sashiko-bot@kernel.org>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net-next 11/15] batman-adv: tt: increase hash generation when
 purging clients
Date: Sat, 14 Nov 2026 10:15:52 +0100
Message-ID: <20261114091556.3336038-12-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261114091556.3336038-1-sw@simonwunderlich.de>
References: <20261114091556.3336038-1-sw@simonwunderlich.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: 35A7Z6H7GTQUQ5SMUVJ2ANJ6TDIRAKCW
X-Message-ID-Hash: 35A7Z6H7GTQUQ5SMUVJ2ANJ6TDIRAKCW
X-MailFrom: sw@simonwunderlich.de
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/35A7Z6H7GTQUQ5SMUVJ2ANJ6TDIRAKCW/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_NONE,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Sven Eckelmann <sven@narfation.org>

If batadv_tt_local_dump() is preempted during a netlink dump and resumes in
the middle of a hash bucket while batadv_tt_local_purge_pending_clients()
concurrently removes an entry, the dump offset will be shifted.

Without incrementing the hash generation counter, netlink won't set
NLM_F_DUMP_INTR and the userspace will not be informed by the inconsistent
dump..

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20261008-tt-avoid-unhashed-event-v2-0-7c4eed81606d@narfation.org?part=6
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/translation-table.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 926b4a3214196..3ce5569a8872f 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -4454,6 +4454,7 @@ static void batadv_tt_local_purge_pending_clients(struct batadv_priv *bat_priv)
 					   batadv_print_vid(tt_common->key.vid));
 
 				hlist_del_rcu(&tt_common->hash_entry);
+				atomic_inc(&hash->generation);
 
 				/* An entry which still carries BATADV_TT_CLIENT_NEW was
 				 * never counted and must not be uncounted here.
-- 
2.47.3

