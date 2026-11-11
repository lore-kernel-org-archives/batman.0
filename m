Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42C1606A887
	for <batman@archiver.kernel.org>; Wed, 11 Nov 2026 10:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.a=rsa-sha256 header.s=09092022 header.b=1LIt5/o7
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 6A34181271
	for <batman@archiver.kernel.org>; Wed, 11 Nov 2026 11:33:01 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1794393181;
 b=LqkXOGEcVZZiBmb88qeVcdonxYiRUFS2vhm7F/XDxutLaU5CITSnU5+X2NWH9stIItm/k
 TnFNTmFkYUEf9WAvysa5j8h2KXGHTx/zKUsID7QV3mxbqJ+XBk/65zf6AzFfrTMXcV1gwop
 n62Xc1nryLtVYWvOMbwdq2wd5XoPChY=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1794393181; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=GblHUlYfymPMnJg/hy5fnjUORn5qjLqynksLlfm220c=;
 b=vMwdigsra0CTC0Rvbg4BKoC6n/yVWW8Q5LhKR0KDsK8rhL2unoJAk31ytdzHYxTKMgSmT
 FmNMPldKb5dU7baS5k8AkO+KtGhJl+iXRVJach9v5cI88k4JepL0kk1SI9AtfYtYHZiRaOo
 twEHz4RiLHAIUDFnsuOzviiJ3p/Va1E=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de
 [IPv6:2a01:4f8:c17:e8c0::1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 006DC84611
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 11 Nov 2026 11:27:43 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1794392874;
	b=X6rQAhr+wgn37AcWKL0mtgrizcBgN2TWC8w5r64iUdRjdHfMa9wwKInmwBEkggrWIjUkd0
	M/z8oi4sw1nZI6Y9imZM82hgiD/yxkHqS4VUlo4oGYq5gAp/gORVBuAT0Outoa9lE9agLq
	ljDuHPB+tuLmdeT3jV0x/r6/2/8UoXo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1794392874;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=GblHUlYfymPMnJg/hy5fnjUORn5qjLqynksLlfm220c=;
	b=Yj8PXG5UNlsEnPk4pK3zW58nBKMYafVwm1Nww+E7nN6h+qrb/t3ilczfN7JqIYM1nnfqGg
	mYWY5Y5Q/t2dFZhPr2+WB92y1eQ6qKbP6jaTTgMmHihhG+I35DwcNlwdVWyrRyfBuFgHcM
	ZISLZb9rTMET65YR3D2I6MvfsSt0Ruo=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b="1LIt5/o7";
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 2a01:4f8:c17:e8c0::1 as permitted sender)
 smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
Received: from kero.packetmixer.de
 (p200300C59740dEd843bE7E4A980e9c65.dip0.t-ipconnect.de
 [IPv6:2003:c5:9740:ded8:43be:7e4a:980e:9c65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with UTF8SMTPSA id E3058FA1CC;
	Wed, 11 Nov 2026 11:27:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1794392857;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GblHUlYfymPMnJg/hy5fnjUORn5qjLqynksLlfm220c=;
	b=1LIt5/o7GK1sxkjC+uiGbZnwAGTl9bpdzeA03lIYW2d75UMfl31iBY60ri4B0dzYrWChg4
	ZgavBNs7ogPjk6djA+3vUqV5PrkehXu0gYutHChtW3bLyMncwlWYiHzl9OXKY99lGAVhgk
	Bb9ZC58fwh+M1qDy5GUW0qcsN6xw3lo6FkqKOcNM/2q2BmzFTt9aKQqZFZBi99VWtr22Wi
	ULJdoEdja/QfCd1cFQ5ywnzatDOToo9TnuIZCzGAKizHFLCL7IoGgOW1XDL5Asoxo42LoQ
	8/JLyHOIv69z+RtcpVIlDTT59ZQhYNTCXbxxFvLF/HmyK9SvZvyufj/4INR9Bw==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Sven Eckelmann <sven@narfation.org>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net-next 07/15] batman-adv: bla: avoid negative reported
 BATADV_ATTR_LAST_SEEN_MSECS
Date: Wed, 11 Nov 2026 11:27:21 +0100
Message-ID: <20261111102729.2096241-8-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261111102729.2096241-1-sw@simonwunderlich.de>
References: <20261111102729.2096241-1-sw@simonwunderlich.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: 6MHFAREMZUSHK4CJMIALH2SZS256ZSDP
X-Message-ID-Hash: 6MHFAREMZUSHK4CJMIALH2SZS256ZSDP
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/6MHFAREMZUSHK4CJMIALH2SZS256ZSDP/>
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

To avoid an underflow due to an non-strict order read of jiffies vs
lasttime, use jiffies_delta_to_msecs instead of jiffies_to_msecs to
evaluate the delta.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/bridge_loop_avoidance.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
index a96f269da8d37..0833f9f99e2a9 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -2363,6 +2363,7 @@ batadv_bla_backbone_dump_entry(struct sk_buff *msg, u32 portid,
 			       struct batadv_bla_backbone_gw *backbone_gw)
 {
 	const u8 *primary_addr = primary_if->net_dev->dev_addr;
+	unsigned long lasttime;
 	int ret = -EINVAL;
 	u16 backbone_crc;
 	bool is_own;
@@ -2385,7 +2386,8 @@ batadv_bla_backbone_dump_entry(struct sk_buff *msg, u32 portid,
 	backbone_crc = backbone_gw->crc;
 	spin_unlock_bh(&backbone_gw->crc_lock);
 
-	msecs = jiffies_to_msecs(jiffies - READ_ONCE(backbone_gw->lasttime));
+	lasttime = READ_ONCE(backbone_gw->lasttime);
+	msecs = jiffies_delta_to_msecs(jiffies - lasttime);
 
 	if (is_own)
 		if (nla_put_flag(msg, BATADV_ATTR_BLA_OWN)) {
-- 
2.47.3

