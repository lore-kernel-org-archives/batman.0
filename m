Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 764F1C43458
	for <batman-adv@archiver.kernel.org>; Wed,  8 Jul 2026 09:23:29 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 1C55581F41
	for <batman-adv@archiver.kernel.org>; Wed, 08 Jul 2026 11:23:28 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1783502608;
 b=R0vg0TJChDeX9Rm3JFh0bScCLE7kb/z3wzXYpsXKK3+MeGMl2rnEFHrV1rSJBzp4+n7qK
 QcQiY6L0shsHxbHormyBth7VTjfRlaF7K42xeCl9WOrcD0BuKRuwdL6oBiwW0cN9ODmX1wN
 CQwQ5jj8sUCQ18pZF1ovjIvFnLQ3ubY=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1783502608; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=OCuwXId2v7DqeCQJa2ngxjQ154iwoRqGBdMHJgjMJ0g=;
 b=Dvv8frTB9iuyRMwwVbi7SoCex7IAlod+534E6V00SpZCdYvP8hOCS1fVXjNOJ0SObTnhQ
 yM7wEhzIrSt+BTBWlCfhpXvbV5k4b90UoME7gv9AHKZhaBev+b+LllaVs7HV2cbO4YRlH5u
 oXCpXUdmI3uWT5fWm6cg88q6ye7Zshs=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de
 [IPv6:2a01:4f8:c17:e8c0::1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 510B983454
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 08 Jul 2026 11:18:45 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1783502325;
	b=iuq8O4U2xakmyp99OkxmZYxY/LTiJasdMoPvsu1CLHxfw6c3ys0g9l4fsWUT9GZzPBknKa
	/Yn2rBKjYiaOzlcz2Rv4U0VALkBjNcEew5qvqMSvoXUUWbNXodYI5HbkCaIwac1o+UhqNr
	EW9H/cmQckU6M0E7t2zX7/9wq9+0K74=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1783502325;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=OCuwXId2v7DqeCQJa2ngxjQ154iwoRqGBdMHJgjMJ0g=;
	b=nJBn5vHmxk/s9HEOCGDRVKmlJxzRioHE6QDE5p6pLvWaYEV8fcqtIG0Ey1Qm0Pgv4pesAZ
	/XL1Wos8zw2ObQBDy37MgZyQHjmrHyMI3ofjiXJ5VoYHTDaBYBqxfZN3nw9GQUjCuxSRj8
	OSWaV/1Z/GsgYciVBxTTrSF+oZFtxzE=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=iEMFPxTV;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 2a01:4f8:c17:e8c0::1 as permitted sender)
 smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1783502324;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OCuwXId2v7DqeCQJa2ngxjQ154iwoRqGBdMHJgjMJ0g=;
	b=iEMFPxTV6sLsxPX2IPpL2EVdoyPo87/ewUWZdWebm8ROvWiQCtLSUTsiAV8F/gLkITAkxO
	J+JO0obTTMS2zelB0BgXU3322PJxSmte5jT6KJ+KKCE5XwTQkqvRZrHZtOcG3+VnFSXfB9
	AL3t0nEiCx4EIDXhFHrgTDoA860VxVGL+G65LctT82Ig3KJZrFgzoIFRi5PZZnBaU6Yul8
	ac75RDyN3eF5lNt08uBJ4kO1aRSwAJ8eG0n2RQcZUEnBTz+Mbs+tyqKK+gBysHhR8j+DDV
	A1q9y4zFDx0uAnsruju6BXs+MOzxl73JFTWyaD9olG4U8NwIV3ecp+3MtSC4/g==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Sven Eckelmann <sven@narfation.org>,
	stable@vger.kernel.org,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net 8/9] batman-adv: mcast: avoid OOB read of num_dests header
Date: Wed,  8 Jul 2026 11:18:20 +0200
Message-ID: <20260708091821.314516-9-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260708091821.314516-1-sw@simonwunderlich.de>
References: <20260708091821.314516-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: MMUVOJ6KN4CSAIQL3KOBOBFBVY3XAIP2
X-Message-ID-Hash: MMUVOJ6KN4CSAIQL3KOBOBFBVY3XAIP2
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/MMUVOJ6KN4CSAIQL3KOBOBFBVY3XAIP2/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Sven Eckelmann <sven@narfation.org>

Before the access to struct batadv_tvlv_mcast_tracker's num_dests, it is
attempted to check whether enough space is actually in the network header.
But instead of using offsetofend() to check for the whole size (2) which
must be accessible, offsetof() of is called. The latter is always returning
0. The comparison with the network header length will always return that
enough data is available - even when only 1 or 0 bytes are accessible.

Instead of using offsetofend(), use the more common check for the whole
header.

Cc: stable@vger.kernel.org
Fixes: 07afe1ba288c ("batman-adv: mcast: implement multicast packet reception and forwarding")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/multicast_forw.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/net/batman-adv/multicast_forw.c b/net/batman-adv/multicast_forw.c
index b8668a80b94a1..1404a3b7adfb1 100644
--- a/net/batman-adv/multicast_forw.c
+++ b/net/batman-adv/multicast_forw.c
@@ -927,11 +927,11 @@ static int batadv_mcast_forw_packet(struct batadv_priv *bat_priv,
 {
 	struct batadv_tvlv_mcast_tracker *mcast_tracker;
 	struct batadv_neigh_node *neigh_node;
-	unsigned long offset, num_dests_off;
 	struct sk_buff *nexthop_skb;
 	unsigned char *skb_net_hdr;
 	bool local_recv = false;
 	unsigned int tvlv_len;
+	unsigned long offset;
 	bool xmitted = false;
 	u8 *dest, *next_dest;
 	u16 num_dests;
@@ -940,9 +940,8 @@ static int batadv_mcast_forw_packet(struct batadv_priv *bat_priv,
 	/* (at least) TVLV part needs to be linearized */
 	SKB_LINEAR_ASSERT(skb);
 
-	/* check if num_dests is within skb length */
-	num_dests_off = offsetof(struct batadv_tvlv_mcast_tracker, num_dests);
-	if (num_dests_off > skb_network_header_len(skb))
+	/* check if batadv_tvlv_mcast_tracker header is within skb length */
+	if (sizeof(*mcast_tracker) > skb_network_header_len(skb))
 		return -EINVAL;
 
 	skb_net_hdr = skb_network_header(skb);
-- 
2.47.3

