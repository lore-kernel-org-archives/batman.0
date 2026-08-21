Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4A8BC5DF7D
	for <batman-adv@archiver.kernel.org>; Fri, 21 Aug 2026 09:49:00 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 022F58138C
	for <batman-adv@archiver.kernel.org>; Fri, 21 Aug 2026 11:48:59 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1787305738;
 b=jpp9Iu8QspAZlyollg94DftSe2TXwPvAjmxxx88XNcWtSHbXRZSk8y5111dp+RnLnc1dp
 chrytQmapUnWpfn5fIU8Q7w5Bkg28j5XUOSeXHna5CFgKt8op/cf937yP2g6787LjFa8LuW
 KAgPhK0zsGXohK6ne4Tkfis8mQe/Ofk=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1787305738; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=BXRPXTDY0Mj1vFXOcaR5PTLxstn0I5G0reky+aH7w0g=;
 b=tYTkCvf41qhyW5KTUq4jHSX0irCFO9h4G5zKK0EdQdNJFSTrRHRAg4szhEpZ1gDEiM1v0
 Lsed/VUb4enh1SAFjgZQuuGC+PfJMK3zVcqKqYjShV9uA8KtLCPVwtyPLnhz3WWptLRBmRg
 gOOBFdp1arqCVFJd2IGsTvICQ/556p0=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 6C82681258
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 21 Aug 2026 11:48:19 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1787305699;
	b=gpZf8tNtmeAnFH/oK45q38EPKXjJrxChRhQIyrGhPoS1xPdep7mmkokadsyuFAxkq2Ewi1
	m2Yk/vm4SybZPu66UcLSZ1v4jECKTsJ6HYO1rLYVIMqbpfyUFgZPCFNAF3cmq51oxCys2f
	hHR1SfiDHmctm2KAMasqcUCUF46sIyg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1787305699;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=BXRPXTDY0Mj1vFXOcaR5PTLxstn0I5G0reky+aH7w0g=;
	b=cT73WAKC4k4g98aqb2D5Q7ge5BNAL/bwtdYKTdn0vWS36in23jt6mq0b6c8JzvfrEErw1p
	E740Y5ajHyg7zSEv4D2WAJyUzsARiJiKrYYHuCZk/q6+qJPEaH2woPUz+1xcB2gclihU6n
	C9Po73mND4o2nAuvctwRcpKBlYm+RSI=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=d0WnhjeH;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 23.88.38.48 as permitted sender) smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
Received: from kero.packetmixer.de
 (p200300c59714FcD8EC8C87C354003fed.dip0.t-ipconnect.de
 [IPv6:2003:c5:9714:fcd8:ec8c:87c3:5400:3fed])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with UTF8SMTPSA id 70560FA039;
	Fri, 21 Aug 2026 11:48:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1787305698;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BXRPXTDY0Mj1vFXOcaR5PTLxstn0I5G0reky+aH7w0g=;
	b=d0WnhjeH1NJ4oLO7BjUnP7l5NvO7wofNl28sBxOM6jQHveRLbWGuGHC/XHUHDiCkiGWg0X
	9hfCuLCKPB+Y+/Ndh8VTzHkNg9a1xnDEDtPVkNrdFuaq1qB6ST46aTVy6aqv/t2YO+oEY6
	Xqlj7E/Y+K0ez8SNEllhAtBtUvR+HGnmMpm3b8FE+Iv8j5rr/JUT+cOW2OwvDDlC5KtUsw
	bf5y0wka3DSQsiL8DbIMIR3Un621NO3/0flsvVTN6WOj9gVa5ZxN5MNpQTPAkVEK764Av2
	j/PdEaNMSOl5nb9v3eIizeevBwtAyDsAeKyJLr6ccvzVHHMJgEa00ThPTxiNXg==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Zhiling Zou <zhilinz@nebusec.ai>,
	stable@vger.kernel.org,
	Vega <vega@nebusec.ai>,
	Sven Eckelmann <sven@narfation.org>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net 1/9] batman-adv: fix stale receive device on merged
 fragments
Date: Fri, 21 Aug 2026 11:48:05 +0200
Message-ID: <20260821094813.201800-2-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260821094813.201800-1-sw@simonwunderlich.de>
References: <20260821094813.201800-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: XWHUNN3GENZYNWMM2HTTM53SPLOAGEVN
X-Message-ID-Hash: XWHUNN3GENZYNWMM2HTTM53SPLOAGEVN
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/XWHUNN3GENZYNWMM2HTTM53SPLOAGEVN/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Zhiling Zou <zhilinz@nebusec.ai>

Fragment reassembly reuses the skb from the highest-numbered buffered
fragment as the merged packet. When that fragment was received on a hard
interface which is deleted before the chain completes, the merged skb can
re-enter the receive path with a stale skb->dev and skb_iif.

batadv_batman_skb_recv() passes such merged packets through the normal
receive handlers again. DAT and bridge loop avoidance both derive the ARP
header length from skb->dev, so they can dereference the freed net_device
before the packet reaches the local mesh interface.

Refresh the receive device metadata from the current receive device before
running the packet handlers. This keeps internally reinjected merged
fragments consistent with the normal receive path after hard interface
teardown.

Fixes: 610bfc6bc99b ("batman-adv: Receive fragmented packets and merge")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Signed-off-by: Zhiling Zou <zhilinz@nebusec.ai>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index 77597171d6376..d89d44706269b 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -492,6 +492,10 @@ int batadv_batman_skb_recv(struct sk_buff *skb, struct net_device *dev,
 	if (!skb)
 		goto err_put;
 
+	/* Merged fragments re-enter here with reused skb metadata. */
+	skb->dev = dev;
+	skb->skb_iif = dev->ifindex;
+
 	/* packet should hold at least type and version */
 	if (unlikely(!pskb_may_pull(skb, 2)))
 		goto err_free;
-- 
2.47.3

