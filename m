Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B5F2CA5FC1
	for <batman-adv@archiver.kernel.org>; Wed, 30 Sep 2026 09:46:13 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id C339A83B19
	for <batman-adv@archiver.kernel.org>; Wed, 30 Sep 2026 11:46:11 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1790761571;
 b=CKEwMZFmyCwiQoF1wUNrHsKi+4OaPH/LLuRTrVgytPN4/vsXjC7L1eYIihYbqhHcz20a0
 WrfrunoebIpzNHpGmyb2G1ZPoePI0OOoQFMA5dr39yNgDWlR9wcmBEDNCycW3cjesCqwyhb
 aQxmVQGBZE7CLiI5CqIeuv7b6M0TDXc=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1790761571; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=X7FvKmxdngUtp9PuXFaNx+zdH0flyh6Lqbv9pg5G+UE=;
 b=fy88EYsot9AU9QaguS+f7Il9SJjhxt+wtNWjvxINI2KNB6V5C5WdRntz+1YEpC30ko1zj
 TGaQgPY5x8CRlGscPi36sf/Jl6RnxapiJ62uOCVkpeKMBvXlzIZ2swUQafjo794JSnwmB0T
 LmXwkxvfVJW6UbENs1ow7YMpsKSv3Tc=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 4C58E822C0
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 30 Sep 2026 11:46:02 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1790761562;
	b=LQUTsspa1JKoL6fd7XcBxkV31EWUHlgduUntDTqFD/Dm1B7S2s0LR3UuhoUPeXAi+G+bKQ
	vTQT14u6P3rAn1ur129QdJUXdER7nLFu+7BiaUq68C5iuOWYWybipEjmQkyf0LiaPxwtB2
	LcnIOUivCujRz5GTjPiZC7GeRmlcazA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1790761562;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=X7FvKmxdngUtp9PuXFaNx+zdH0flyh6Lqbv9pg5G+UE=;
	b=AlGO2SwsyEXuyFf4vmB4WyPrj2NFV8YQgV9EfbXVKxjmASDAkiaDkXnniZl0D7APmFpJqd
	ubZQn3vY7smXOqgiEJrASdVRDSvk/KGBjrVTSARgXWyVn/1k3tVlDHQcas+aUTokHk7NT0
	ucvSDOoYgjFVdxx43ctIgIejMWc7pDY=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=sh0rFtDv;
	dmarc=pass (policy=none) header.from=simonwunderlich.de;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 23.88.38.48 as permitted sender) smtp.mailfrom=sw@simonwunderlich.de
Received: from kero.packetmixer.de
 (p200300C5970e81d8Cf20E45A7328d917.dip0.t-ipconnect.de
 [IPv6:2003:c5:970e:81d8:cf20:e45a:7328:d917])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with UTF8SMTPSA id 5903EFA039;
	Wed, 30 Sep 2026 11:46:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1790761561;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X7FvKmxdngUtp9PuXFaNx+zdH0flyh6Lqbv9pg5G+UE=;
	b=sh0rFtDvw4P8IU0NAyTjrkpfv3RXbEcG3pPbapFZrvX92I87skcT2McHsuiAI4scKtBd11
	4ESuRZFvP1CKIyIGug8+2WmAbjrmDD31P/4756Bggqdy/nTFbyWvu9X3PEzf4MdMma3oJD
	mAwqHT3//mPCQhwXuh8Us568ylmIS6mOkrOUsojZP9friUXCQnvdT3FpQBxPrvq6w8BgLR
	2l0c/QPc6VQaIA/NHQDYk2kA/oB3rEkxoiZgTAXGDdvcu/9ZY9kzo9Y6DrwSjG7RPyb6CS
	YZv7UuGZEY2uvyfmmvheiUkfi+cAYk+UtQxGxxjYE8a+uPDJA+wT48Wh2zaGmw==
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
Subject: [PATCH net-next 2/9] batman-adv: tt: clarify kernel-doc for
 batadv_tt_global_purge_local
Date: Wed, 30 Sep 2026 11:45:51 +0200
Message-ID: <20260930094558.3723766-3-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260930094558.3723766-1-sw@simonwunderlich.de>
References: <20260930094558.3723766-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: FATXMKAKMBUZEH6VGXG5HF5AFOKIQCBI
X-Message-ID-Hash: FATXMKAKMBUZEH6VGXG5HF5AFOKIQCBI
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/FATXMKAKMBUZEH6VGXG5HF5AFOKIQCBI/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Sven Eckelmann <sven@narfation.org>

The new kernel-doc didn't mention the "non-multicast clients" limitation.
It was also not clear that the roaming flag gets cleared when the
announcement didn't contain the roaming flag.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260907081824.2474040-1-sw%40simonwunderlich.de?part=9
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/translation-table.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 12ea557cb8033..6d8fa6d28fee8 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -1870,9 +1870,10 @@ batadv_tt_global_orig_entry_add(struct batadv_tt_global_entry *tt_global,
  * @tt_global_entry: the global TT entry of the announced client
  * @flags: TT flags announced for this non-mesh client
  *
- * A client which is announced by another originator is no longer a local
- * client. Remove it from the local table and take over the WIFI flag it was
- * tracked with.
+ * A non-multicast client which is announced by another originator is no longer
+ * a local client. Remove it from the local table and (for the global entry)
+ * take over the WIFI flag it was tracked with. Reset the roaming flag in case
+ * the announcement didn't contain the roaming flag.
  */
 static void
 batadv_tt_global_purge_local(struct batadv_priv *bat_priv,
-- 
2.47.3

