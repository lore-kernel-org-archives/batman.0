Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5BC8C79F89
	for <batman-adv@archiver.kernel.org>; Mon,  7 Sep 2026 08:24:08 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 51CBF85466
	for <batman-adv@archiver.kernel.org>; Mon, 07 Sep 2026 10:24:07 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1788769447;
 b=sIUfKeV2hxadoz47wIcB+aNoNPYNH4Ch3J/VKlinb4bGGCBdrWLEmS/tFRT/GugrXVeEU
 og6JhDbnaQ5RFDy9PptOs+l+aSplyCz6QbpdA5hH8DaJ/DaDZnVG4f/7FShAhdBD3YDI4lg
 LMsnTU5EQIVNjUbjoRl7+3b4cR+GVTY=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1788769447; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=tPBQnSTr3ybdpUxRTeJH+n9deVsj7/2bOs4cDMU5/88=;
 b=hVlgWeiam/++Bcz1Qrn1czS3obZFAj93cygtpSp8TGtS99N211QGeYQaw6krjzhXqukwd
 KrE8SNO3/HufIka9q01HDY1MSBM1ZD+g2dZTzGf5xhCIFDrC8NQVFOHqQeQptgvhcUJFCvL
 koV4++dCZ9j1syhUvL22sJRgFiwfK7U=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 74E4980888
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 07 Sep 2026 10:18:38 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1788769118;
	b=169qBaXm5M7MKML801ZSgkTp8pcj8VfjVtJVQgAC0YOyLoVqhRGsL2x+9+g7hwBLvpSg5U
	NMwKfU2ipETNW6XRb17bIbvx0324BxyBrrTc8PvqC4/Y/oEy0NA96aL6jDZP8R13bwuk6I
	+5hEJYNle/CxctFQViEf0serZ1a0gF4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1788769118;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=tPBQnSTr3ybdpUxRTeJH+n9deVsj7/2bOs4cDMU5/88=;
	b=qa3lcqNtoTWakafEh67vcnYafeB7mZkgnlYas547/FvMxF28lwk+adEUpoIo3LvDOdi8qx
	+Llu5xQoc4U7e796nXaWK17tb8gDXmfjsYvjNTi/haSl2yRjHsW4oSMY5QVJO9rwrZ7I8n
	BBPz2H26RX5/nNCJ6Gizn1yXe2B1K2s=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=GkvY26hH;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 23.88.38.48 as permitted sender) smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
Received: from kero.packetmixer.de
 (p200300C59748d0d8c3747188e6dfE6C0.dip0.t-ipconnect.de
 [IPv6:2003:c5:9748:d0d8:c374:7188:e6df:e6c0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with UTF8SMTPSA id E0962FA2C3;
	Mon, 07 Sep 2026 10:18:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1788769116;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tPBQnSTr3ybdpUxRTeJH+n9deVsj7/2bOs4cDMU5/88=;
	b=GkvY26hHpwu5PRnxOhvZFkEbFDQzT0FhN+MyR80xl9wXnytw5lP0XgNiE8WT287TnwlLs3
	OMxcO5mmr8urxuvz3HbeSGcZ/ufqWg90RY44vgvsDFt7dwonDNDjjqOeZ1kYRM0DoiENvC
	Em+vaifnZys7nvnUpueF0HXPd+Bc3llCObjG0mLE6o7kNxOQoNZSJrXglJ4N3mzvlPE8+p
	L6wrLymKKqVXU54oolFaPVKb4rv3dqiJ8FzaXtdQ67UY2rI5DjrGPfXtBsPIYHpcjbfQjf
	UwSgdMn0A0d7gK+V9XqYn4PAgNs7oKCyKMXvUO53CZN1/kSjJIRCLYF7e7byxw==
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
Subject: [PATCH net-next 14/15] batman-adv: bat_iv: fix ogm_neigh_is_sob
 parameters references
Date: Mon,  7 Sep 2026 10:18:23 +0200
Message-ID: <20260907081824.2474040-15-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260907081824.2474040-1-sw@simonwunderlich.de>
References: <20260907081824.2474040-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: AGC6GPS4PONUK6YGY5SPLBNULJF6QXXA
X-Message-ID-Hash: AGC6GPS4PONUK6YGY5SPLBNULJF6QXXA
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/AGC6GPS4PONUK6YGY5SPLBNULJF6QXXA/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Sven Eckelmann <sven@narfation.org>

The batadv_iv_ogm_neigh_is_sob() kernel-doc summary line is still
referencing the old parameter names "neigh1" and "neigh2". But these are
now called "candidate" and "reference".

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260831135117.574836-1-sw%40simonwunderlich.de?part=5
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/bat_iv_ogm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index 3fe09b4c30463..89b499f7a37dd 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -2422,8 +2422,8 @@ static int batadv_iv_ogm_neigh_cmp(struct batadv_neigh_node *neigh1,
 }
 
 /**
- * batadv_iv_ogm_neigh_is_sob() - check if neigh1 is similarly good or better
- *  than neigh2 from the metric prospective
+ * batadv_iv_ogm_neigh_is_sob() - check if @candidate is similarly good or
+ *  better than @reference from the metric prospective
  * @candidate: the first neighbor object of the comparison
  * @if_outgoing_cand: outgoing interface for the @candidate neighbor
  * @reference: the second neighbor object of the comparison
-- 
2.47.3

