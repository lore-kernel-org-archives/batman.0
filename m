Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2D51CD6E4A
	for <batman-adv@archiver.kernel.org>; Wed,  3 Jun 2026 07:26:23 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 9727681117
	for <batman-adv@archiver.kernel.org>; Wed, 03 Jun 2026 09:26:22 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1780471582;
 b=IVBUCtMW4zJARF75qd96PWuIVjPvlIl0tVv2Pt0KUdGMGQS700L3fYxSVSygwcHIlWYSU
 mkw2R0NijK4tDp6xURahunt34mYquEaqeYc+nM508hriqskxh37kJcTn5VxYg+jeOZU9KFI
 YuDLFSyQtqLynSf+zZrkRb5nBmNj2d0=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1780471582; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=IEdqjk9qBO080JOKzs+Y4fTvKnJCFmJWaHfWga+n06s=;
 b=aJX1iWjcoq3oXxXUxAntR5g+OleUMV0yam8NBHJiQsnGVI0HpAAaTm+/ztLQTCmy2sD6P
 7juEAo8v84TcopHb0oHuNIRK89rc8skzXEr0xIphxaKE4n5UtsQE8PV43RlslY49783n6BC
 EMB8YtAlLbvOpX0empaT1yuMtb6orjs=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 5957F807B0
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 03 Jun 2026 09:25:30 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1780471530;
	b=zyzh7WAwKbdOWr9YYH73ltG9GVEZFEZ52DmMQcMgWO5fPoEJYN0Ghl6VQay8rP+Bl9kX3y
	lM/Ciab0HNrxPBuyNgVRtbXVn/IrN0jBLCSG++BxRv/ISC6U4PB3gYw0B8cA/HPe4bqiXB
	ahy7+Q6ZSdXqZ0RfTuxLboeoC5hgC8E=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=OU1RDsRf;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 23.88.38.48 as permitted sender) smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1780471530;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=IEdqjk9qBO080JOKzs+Y4fTvKnJCFmJWaHfWga+n06s=;
	b=2pY8aW8bVoQOxZrN+78g8mhdo52/PeMEeIeCh+jXuWnjY5U+zXNdP4+yq1FSBB6SRXVvGJ
	Qgx4GTG1kKAkUgZNa5P9aw7hOeLdBYh3w2h20nf23A7GZmDRJq+iRF35Jr4bi9UNy5JJjt
	rZCNjyTd4kxffl5MZDl7H7bAFyvM49o=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1780471529;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IEdqjk9qBO080JOKzs+Y4fTvKnJCFmJWaHfWga+n06s=;
	b=OU1RDsRfY7v4BEHemFMzYU8SeGYRiTLGy/tDBOSAZmnTBdjBKbp3PFxkwN1c0IFebWY/3S
	t8dvafkFB9Gakod9gWv/Dp9pFtesucfIbx+JQoQlz63leWUopxo/8V3U80enXyTcnf0DkM
	Bzs84MmhwNRcd01DSojJ84hpJkPXtPIbd0CMpjGB/LoE1/YgCadn8Z6xk/a4CzEViMEou8
	yVni74n5aRcr9QkVVZgdok1SNBNqdYDfxZ8bc3kHiale29QaHcmlfRKXaqpkD6yvZG4Yrt
	gJTYt1yP1644i0SFywTtkmMoBaEiTZQlcR+jtlaBuke1uexju60F5CIGD9to1g==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Sven Eckelmann <sven@narfation.org>,
	stable@kernel.org,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net-next 01/15] batman-adv: tp_meter: keep unacked list in
 ascending ordered
Date: Wed,  3 Jun 2026 09:25:12 +0200
Message-ID: <20260603072527.174487-2-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260603072527.174487-1-sw@simonwunderlich.de>
References: <20260603072527.174487-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: LG2BBDWMJN6RNLR6KBE67BP2KXPR5RFB
X-Message-ID-Hash: LG2BBDWMJN6RNLR6KBE67BP2KXPR5RFB
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/LG2BBDWMJN6RNLR6KBE67BP2KXPR5RFB/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Sven Eckelmann <sven@narfation.org>

When batadv_tp_handle_out_of_order inserts a new entry in the list of
unacked (out of order) packets, it searches from the entry with the newest
sequence number towards oldest sequence number. If an entry is found which
is older than the newly entry, the new entry has to be added after the
found one to keep the ascending order.

But for this operation list_add_tail() was used. But this function adds an
entry _before_ another one. As result, the list would contain a lot of
swapped sequence numbers. The consumer of this list
(batadv_tp_ack_unordered()) would then fail to correctly ack packets.

Cc: stable@kernel.org
Fixes: 33a3bb4a3345 ("batman-adv: throughput meter implementation")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/tp_meter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/tp_meter.c b/net/batman-adv/tp_meter.c
index aefe757277b20..0e39ea33e5f27 100644
--- a/net/batman-adv/tp_meter.c
+++ b/net/batman-adv/tp_meter.c
@@ -1325,7 +1325,7 @@ static bool batadv_tp_handle_out_of_order(struct batadv_tp_vars *tp_vars,
 		 * one is attached _after_ it. In this way the list is kept in
 		 * ascending order
 		 */
-		list_add_tail(&new->list, &un->list);
+		list_add(&new->list, &un->list);
 		added = true;
 		break;
 	}
-- 
2.47.3

