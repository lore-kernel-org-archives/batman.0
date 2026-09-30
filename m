Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E0EACA5FB1
	for <batman-adv@archiver.kernel.org>; Wed, 30 Sep 2026 09:48:48 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id D076783AB1
	for <batman-adv@archiver.kernel.org>; Wed, 30 Sep 2026 11:48:46 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1790761726;
 b=o/sG2FD08w1F5z4213H/1AXyanjsI7fWJ4QMfJrmEQkKrKIxsvZrToLHVDRAhc1+hsBDp
 wCyaoY5BLcRswdNh/z3BNXXsA+EkqtWzxvphwm9PsUOkG6XgMF4uuSZbOntHp7RzdNeO4aw
 V4ZVvVzsObCf2wAdjQGX/h5YjWBGOiY=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1790761726; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=PQ5QnYvBUumJeGg47RpMHA7VjJ81SfVOD5rbWWyI2XI=;
 b=pLJ3acvlESNeuKU9JxTMR36pffrrHpT1w9tukcLZJQBx5GGybUSkwZVDU5j/Wz/yKKbmp
 uVYzZjPcXCWUAlrDoEx4wH05YZVOBQ+n076xWCcNHe62CTFv5HpEjFPJ/2xZGoHjQXTQOsZ
 bSkspnKUqhzTxdsDFV1fkTxBIY5L4Lo=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de
 [IPv6:2a01:4f8:c17:e8c0::1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 0C30E81CD4
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 30 Sep 2026 11:46:05 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1790761565;
	b=OrNCo3LTSKfzH+FmedSE//uhtuIEelT8iC9Jh7dnH3gVGuCobXONTeBDVQWYWRivht/CZv
	movQQ0p6S/APGbY1IG+pMWm/n82skyxMcN89tmluAJnuH1+K4E6Pf95bCqLxFsqiIwH0gw
	EBwCZF7O4tNofkR0RRL82/ggtZ0pFcA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1790761565;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=PQ5QnYvBUumJeGg47RpMHA7VjJ81SfVOD5rbWWyI2XI=;
	b=lqTb484J2Yye0vWbMzrhmo/G3wiG00yjWQRsUa1CED+M93xqsMj3/AYcC6w9AdkJxrPmah
	2hF00wHlznqHAr5XzE5JIs1mv2aAuIu4BAZXb+h5vpYq1Vzz92jFZhuOaAe5WfEF36uSjA
	gCaF0C+fGue0VsxBu3c1YbN19xH/Ueo=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=tVKBNLIr;
	dmarc=pass (policy=none) header.from=simonwunderlich.de;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 2a01:4f8:c17:e8c0::1 as permitted sender) smtp.mailfrom=sw@simonwunderlich.de
Received: from kero.packetmixer.de
 (p200300C5970E81D8cF20E45a7328D917.dip0.t-ipconnect.de
 [IPv6:2003:c5:970e:81d8:cf20:e45a:7328:d917])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with UTF8SMTPSA id 49F88FA1B2;
	Wed, 30 Sep 2026 11:46:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1790761564;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PQ5QnYvBUumJeGg47RpMHA7VjJ81SfVOD5rbWWyI2XI=;
	b=tVKBNLIrhMoJednZQeRfCIZrdcFXxKgB9BOlmyu32dP2XMnqIalovt51lMdFG5dyMJ8CGi
	uBhVGPTyjEUQC32pKpDTE6PG8gh/QGe5FkGiYYqntlDQgXZwvUgmlgL1KUakQiJnkDoJeW
	3phlc7fXEmuQBhaxziTJ9mBLqg8dUNxrnZSO2j0b2VTLlNQS/7082P13MKe/3UrTWnLqK+
	DYrcLs5MwCxe3gFllYV2ESqIdm8wrRzAM08Rkl1jX64Dt+3qXKjtNXS9fdPv7UYrU7XRtG
	fds0Tpj8ER/Omg+KUEmb7y2NB9aHk8QWqChIawRinzNDx8O0GgZUGoYeVrnCiQ==
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
Subject: [PATCH net-next 5/9] batman-adv: tt: only queue local del event after
 successful unlink
Date: Wed, 30 Sep 2026 11:45:54 +0200
Message-ID: <20260930094558.3723766-6-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260930094558.3723766-1-sw@simonwunderlich.de>
References: <20260930094558.3723766-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: KYPCFDHRQDYVSOCFPBJNJD7G5BFCUU3M
X-Message-ID-Hash: KYPCFDHRQDYVSOCFPBJNJD7G5BFCUU3M
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/KYPCFDHRQDYVSOCFPBJNJD7G5BFCUU3M/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Sven Eckelmann <sven@narfation.org>

When batadv_tt_local_remove_now() finds another local TT entry with the
same MAC + VLAN, it will not try to remove it. A delete event must not be
queued because it would otherwise cause the queued ADD event for the other
TT entry to be dropped.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260831135117.574836-1-sw%40simonwunderlich.de?part=8
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/translation-table.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 354d9416c1b75..c904d67791f8f 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -1496,8 +1496,6 @@ batadv_tt_local_remove_now(struct batadv_priv *bat_priv,
 	struct batadv_tt_common_entry *common = &tt_local_entry->common;
 	struct hlist_node *tt_removed_node;
 
-	batadv_tt_local_event(bat_priv, tt_local_entry, BATADV_TT_CLIENT_DEL);
-
 	/* remove exactly this object when still present in hash */
 	tt_removed_node = batadv_hash_remove(bat_priv->tt.local_hash,
 					     batadv_compare_tt_entry,
@@ -1505,6 +1503,8 @@ batadv_tt_local_remove_now(struct batadv_priv *bat_priv,
 	if (!tt_removed_node)
 		return;
 
+	batadv_tt_local_event(bat_priv, tt_local_entry, BATADV_TT_CLIENT_DEL);
+
 	/* batadv_tt_local_transition_new() may have committed the entry and
 	 * thus counted it in the local table size since the
 	 * BATADV_TT_CLIENT_NEW check in batadv_tt_local_mark_removed().
-- 
2.47.3

