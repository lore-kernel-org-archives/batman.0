Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E9DACA5FC1
	for <batman-adv@archiver.kernel.org>; Wed, 30 Sep 2026 09:51:04 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id B23BD841D6
	for <batman-adv@archiver.kernel.org>; Wed, 30 Sep 2026 11:51:02 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1790761862;
 b=YnqDA6HAF8LrdzooaEkwaJ3WY+m5+QAFqVpBbZqja/7HOP6VWrobA99tUThMp2oiXtdZa
 zJDq2c6VqpsT6BO20S01TAJR6fpO7/tr3pdIaiPceE6rd9m0mE7hA2+ZUaZIdMHZfVr+vSE
 U4srk/1P7OS4sI/nvs1klk1Fc1C1vV8=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1790761862; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=68IkPJweZg8/k7TcmtLrKImW+zdIpL2mCpk79RpO984=;
 b=w3Oyhxj6bu3fAyPOh0CHb4WEeFyh6m7gNjIbDrNKCABX0W9TROMvGKgqP31scY7ifKu6r
 JX2a1+uTbhOGzUhzExaqqNqjFKxYzaMqc5BLvruVv0rdriacbWBCtnm1XzY+9T7SeRE9eJM
 Ro2s/MuoWOvTLkCwxO8nMWKI1+JbrKE=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de
 [IPv6:2a01:4f8:c17:e8c0::1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 816588258E
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 30 Sep 2026 11:46:07 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1790761567;
	b=a3pr1kkQLaMnYPc+p02BmTOgsHl6h7ZGRPxy5jB232GV95HfPP6KbH6HcsrxNrBKb2FMMm
	Ktuysar87IntuRJnlg8sMmlEpWhihwSxIggTtAvBsxIf6s9bRi60gyNjWSi2bQlgfkuP2J
	mSqDYcJO+epSQJbaYrKbJaVzv7FARrM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1790761567;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=68IkPJweZg8/k7TcmtLrKImW+zdIpL2mCpk79RpO984=;
	b=n4ELUsThX80l3P8wKfQcLVGhdHDurSw2cBES04slyq11YNOhSKoaUOppCwW+8jSAiiZ5vA
	SXGMRxHjKJUJQNoXs1Evo3ebO2vu/O6AVQWRfSQQ/ttQDhONwR+GVxx4fMPIlCsa6TRp1C
	8sn75dpCS4C4i0OGMcy8e8ocGuUYS4M=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=SlwAloLJ;
	dmarc=pass (policy=none) header.from=simonwunderlich.de;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 2a01:4f8:c17:e8c0::1 as permitted sender) smtp.mailfrom=sw@simonwunderlich.de
Received: from kero.packetmixer.de
 (p200300C5970E81D8CF20e45A7328D917.dip0.t-ipconnect.de
 [IPv6:2003:c5:970e:81d8:cf20:e45a:7328:d917])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with UTF8SMTPSA id 23F6DFA25F;
	Wed, 30 Sep 2026 11:46:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1790761567;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=68IkPJweZg8/k7TcmtLrKImW+zdIpL2mCpk79RpO984=;
	b=SlwAloLJMbYNQ72Wisnmrqco7kUvvl0kKXBJ6ZZUjT3l0oGI/85X4YYrJFUtvTVvpHVDxm
	vPQlk0hHKNcq57joL6hOovC0PPYXLONo1MgZuQzl1UcvSaBK4aGwkPL7+YNN7f6UuU232l
	V55npDKVE9isY/aCei/q6o1w7m7dz0BXpRNme3HwHUPNkFCWoASIi/hW+wv7vR2w1J/OIo
	36QPDyeVOPWWXsFl2fIDGwzNFTTuDbSiJePo/8eSTgRad6YhFCkjv7zzzWTc1sv2s+yoA1
	GUdw7KZLt1FRpd6o2ty1MvSg/ATUDwwVKnvAx2XHapxve/QGTz9LdVcGvqJxwQ==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Peng Fan <peng.fan@nxp.com>,
	Sven Eckelmann <sven@narfation.org>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net-next 9/9] batman-adv: use assign_bit() where applicable
Date: Wed, 30 Sep 2026 11:45:58 +0200
Message-ID: <20260930094558.3723766-10-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260930094558.3723766-1-sw@simonwunderlich.de>
References: <20260930094558.3723766-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: 2PZ2HFMY7NKIOTWN442VHJWCP4VDMKCM
X-Message-ID-Hash: 2PZ2HFMY7NKIOTWN442VHJWCP4VDMKCM
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/2PZ2HFMY7NKIOTWN442VHJWCP4VDMKCM/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Peng Fan <peng.fan@nxp.com>

Convert open-coded if/else with set_bit/clear_bit the assign_bit API.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/distributed-arp-table.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/batman-adv/distributed-arp-table.c b/net/batman-adv/distributed-arp-table.c
index a4be5b2a87d7a..74050bffedbce 100644
--- a/net/batman-adv/distributed-arp-table.c
+++ b/net/batman-adv/distributed-arp-table.c
@@ -863,10 +863,8 @@ static void batadv_dat_tvlv_ogm_handler_v1(struct batadv_priv *bat_priv,
 					   u8 flags,
 					   void *tvlv_value, u16 tvlv_value_len)
 {
-	if (flags & BATADV_TVLV_HANDLER_OGM_CIFNOTFND)
-		clear_bit(BATADV_ORIG_CAPA_HAS_DAT, &orig->capabilities);
-	else
-		set_bit(BATADV_ORIG_CAPA_HAS_DAT, &orig->capabilities);
+	assign_bit(BATADV_ORIG_CAPA_HAS_DAT, &orig->capabilities,
+		   !(flags & BATADV_TVLV_HANDLER_OGM_CIFNOTFND));
 }
 
 /**
-- 
2.47.3

