Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24BDB606A324
	for <batman@archiver.kernel.org>; Wed, 11 Nov 2026 10:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.a=rsa-sha256 header.s=09092022 header.b=odNvwpbf
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id BED6180840
	for <batman@archiver.kernel.org>; Wed, 11 Nov 2026 11:29:12 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1794392952;
 b=uYlzGCzIV4HN3MZwreoi9v3Sn5bOhBc3GBwraeMNU/owW5WqQAAGoXSwT8oK57yVeErea
 FcXlB8xPcKkQtgFzS27o7KVUl8Jndz9KP2iA2gq2gLFAZ8kcxFCvqWqyfYY9+ZvQLxqp8AO
 jcop68PKZTQBr0RAzbRfvorHByp8X9g=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1794392952; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=HM3rz76RGIKt8dMzknvwQnTdPjRPPY5nGGIXvenUr+Y=;
 b=1/YaX/rzlfOqzHmtAf3TBG1ECzVs+uotBBPdTlYB57tC+XKylEy2uE8ecjcTSBN85KZ7C
 Md6bgXRD49qyBUYlUNgqTgWlEPyFtPWmrPFZiQZ5Zece3JAlSySemz4/e3xyD3TmJKuqzqR
 6/nzR0l0fQAm4acVuRYS/qq5DQ61Q6M=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de
 [IPv6:2a01:4f8:c17:e8c0::1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id A0BA7820C4
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 11 Nov 2026 11:27:33 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1794392863;
	b=T5TOG6+wjunm8BliyWzq8QTMXI5v8xTBCc0n1YpWdfMZmEs28JreJbriwR86Y5J7SH/ZqA
	076ht4mo/oMxyTonpaTmDyoOF/BpPYHUUniWNXv5dyaKp/V+zCoMcgldC0AZzPy5T8+BYH
	UQ9NMrxP88qjunhK3GkPLlhca+ing9Q=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1794392863;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=HM3rz76RGIKt8dMzknvwQnTdPjRPPY5nGGIXvenUr+Y=;
	b=nHd77cUdSJpTDf5wd5BqbAG1C0uu0ONXfyhlnaM/XdMZjKGGlBQ2v6jUEyVCGQ7FXkKlNt
	+WWwhYb1KQhlibFUW0qwbTkdTiHSAwbfNtiGrcm+Z1LdnpaX74oB7xII3Xt0Oy30lLKZsV
	MKXswf8KxKJ7VP9eBPS14Qz7kS5osgk=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=odNvwpbf;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 2a01:4f8:c17:e8c0::1 as permitted sender)
 smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
Received: from kero.packetmixer.de
 (p200300c59740DeD843BE7E4A980e9C65.dip0.t-ipconnect.de
 [IPv6:2003:c5:9740:ded8:43be:7e4a:980e:9c65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with UTF8SMTPSA id C58C0FA0B3;
	Wed, 11 Nov 2026 11:27:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1794392851;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HM3rz76RGIKt8dMzknvwQnTdPjRPPY5nGGIXvenUr+Y=;
	b=odNvwpbfWjjW8NjEAySOT1IkfC44KxDd/wDrh241C00FVX05yjV5NwTtD4HzTW1Bf9cMEj
	LVCv/dLyv4+GlPWHm9xrNyN03ggjU19QB34Mrhw6cu2YQ4wHVelvqCZQ9xs5ZyXEJ9t09F
	dAe3n4121KpFDX7x+f+J6DhpKrdEi8HU9AkKfoIKTwZVN5MgHyV1cUjIS8YmZT8n99iYFx
	DsxPZXcK1eTpRqdplk+inGiv4RbTaeb47nW30WNZXpLJ6E7e6VhCaIREf3zBQlKYfyP3Le
	7pm9JQKN3Plswg2Ljx6KLJ5idLhbFZPaYcICJ95R/7lQbC7Z3VdtE9JdTJUruA==
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
	=?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net-next 01/15] batman-adv: mcast: explicitly initialize
 mcast.num_want_all_rtr{4,6)
Date: Wed, 11 Nov 2026 11:27:15 +0100
Message-ID: <20261111102729.2096241-2-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261111102729.2096241-1-sw@simonwunderlich.de>
References: <20261111102729.2096241-1-sw@simonwunderlich.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Message-ID-Hash: PVIMDKVYE3XWLWRPK75E5YYK4PHHAQF6
X-Message-ID-Hash: PVIMDKVYE3XWLWRPK75E5YYK4PHHAQF6
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/PVIMDKVYE3XWLWRPK75E5YYK4PHHAQF6/>
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

All mcast.num_want_all_* are initialized in batadv_mesh_init_late() - with
the exception of mcast.num_want_all_rtr4 + mcast.num_want_all_rtr6. At the
moment, it works because atomic_set just initializes it to 0 and the netdev
private data is already set to 0 before being passed to .ndo_init.

For consistency purposes, also initialize mcast.num_want_all_rtr4 +
mcast.num_want_all_rtr6 explicitly.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/bug/linux-9dbe5dec-31ae-49eb-838a-b4b92ced4ace
Acked-by: Linus Lüssing <linus.luessing@c0d3.blue>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/mesh-interface.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/batman-adv/mesh-interface.c b/net/batman-adv/mesh-interface.c
index 1ce707aaf48a0..6ffc505ce2aba 100644
--- a/net/batman-adv/mesh-interface.c
+++ b/net/batman-adv/mesh-interface.c
@@ -833,6 +833,8 @@ static int batadv_meshif_init_late(struct net_device *dev)
 	atomic_set(&bat_priv->mcast.num_want_all_unsnoopables, 0);
 	atomic_set(&bat_priv->mcast.num_want_all_ipv4, 0);
 	atomic_set(&bat_priv->mcast.num_want_all_ipv6, 0);
+	atomic_set(&bat_priv->mcast.num_want_all_rtr4, 0);
+	atomic_set(&bat_priv->mcast.num_want_all_rtr6, 0);
 	atomic_set(&bat_priv->mcast.num_no_mc_ptype_capa, 0);
 #endif
 	WRITE_ONCE(bat_priv->gw.mode, BATADV_GW_MODE_OFF);
-- 
2.47.3

