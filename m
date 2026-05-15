Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1363CD4851
	for <batman@archiver.kernel.org>; Fri, 15 May 2026 10:04:58 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 2E5FB85C0F
	for <batman@archiver.kernel.org>; Fri, 15 May 2026 12:04:57 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1778839497;
 b=UGj2vihVEeLUhjtb47+Q15HImhhf9JdEGdz7xA4ZY8WHRtllTVmuIrUlEi2LKyXtpzi+v
 p1lFPiKH4TTBnCxvU4pkU1l63YdML/SWWGahCK5/B59v48yXtobE5/n+Db9mE/uYSIIdQ+G
 0zOCZ8pb3SyW1igWdIPPAUZWq0rnl3k=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1778839497; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=JeFU2yocd90391ZPALZwK9q60q3TKgjMlk+bp4HtH7o=;
 b=vxDoCDoUwv/UDhxtB4WOgcDhI21tE4N5Kc49QYSyefbXdStlJYbxyCGMXimw2VU+PkXxd
 sHJc6JhzA5mtwqyW8/OPO+WhgeMD+SokocN9CqzNPRy++OaSBuoBNHgwudQpxIBI06KFKRD
 98bs1e5IpeJkD1ynSWqwikcYPo3jNwQ=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de
 [IPv6:2a01:4f8:c17:e8c0::1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 4841285337
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 15 May 2026 11:55:57 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1778838957;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=JeFU2yocd90391ZPALZwK9q60q3TKgjMlk+bp4HtH7o=;
	b=uTuFZp2DXWygRyVNWIiHGIxG1iz0X/TXKKruQwaLEMNkJHYkzJ+1PcWwWjU/rvRhnjmpfu
	VWo0chszclOq7ZFAeRiKMOhsv7XXRQeUpRk+o/jGt/qkrSzxcttgYwHanS8v1xjt3R0GK3
	KA9t18G7WRFtjF1FD3TCK3Zm4UAgnDQ=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=e7kNwOJF;
	dmarc=pass (policy=none) header.from=simonwunderlich.de;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 2a01:4f8:c17:e8c0::1 as permitted sender) smtp.mailfrom=sw@simonwunderlich.de
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1778838957;
	b=zoCwZVSKUZG+FEyjeZgrDJ3CFW4aWqlp9FpBNjxV0C5R7hRdoz/lH+wxDxFBV23K68bako
	AW/dO9ozEkXHdkMwJPkxItiUYK+hsDvgLzXVhaici9a9+DNuyHp1PqL3BnIjYR0rmvXsTR
	uZz4JSa7T7uq9YfuSFCQotnsLCGMEwg=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1778838956;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JeFU2yocd90391ZPALZwK9q60q3TKgjMlk+bp4HtH7o=;
	b=e7kNwOJFS6mSE1d3pyb3IM9FkmKlhNQ1XjGK1d1aJtc4F3DIWFQUd13UfQYned1DoroL5j
	RkjHEb+OlxkleU1xe7J1TDRB4W1cZiiJs1n8knzN70FdPrGbIE1gGc5S2TPk29Ogw4J6oI
	mgBNYFeCcyEHdtPPBjqBsSZlmOsvuHBAKhl0/UAEYVfPPSQ32UJdMgKfn3zumkjKtCpq49
	MW9ggHk0qjaz4RLJMyaFrltQA1iE1NI5O7W/pVTSRMAxfrHHbYE/VemUM6/jKnj4K6Mgk+
	hM+1pjulYKqMBKAYTU4Rzr/Q8jAuvsFP9EdkgAk3amLjUcT/I2RO5gmj0CUvzw==
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
	Yuan Tan <yuantan098@gmail.com>,
	Yifan Wu <yifanwucs@gmail.com>,
	Juefei Pu <tomapufckgml@gmail.com>,
	Xin Liu <bird@lzu.edu.cn>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net 11/14] batman-adv: dat: handle forward allocation error
Date: Fri, 15 May 2026 11:55:36 +0200
Message-ID: <20260515095540.325586-12-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260515095540.325586-1-sw@simonwunderlich.de>
References: <20260515095540.325586-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: H6PHFD4Y6TRQ3A2OCL42ZJRKBMV523M2
X-Message-ID-Hash: H6PHFD4Y6TRQ3A2OCL42ZJRKBMV523M2
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/H6PHFD4Y6TRQ3A2OCL42ZJRKBMV523M2/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Sven Eckelmann <sven@narfation.org>

batadv_dat_forward_data() calls pskb_copy_for_clone() to duplicate an skb
for each DHT candidate, but does not check the return value before passing
it to batadv_send_skb_prepare_unicast_4addr(). That function dereferences
the skb unconditionally, so a failed allocation triggers a NULL pointer
dereference.

Skip forwarding to the current DHT candidate on allocation failure.

Cc: stable@kernel.org
Fixes: 785ea1144182 ("batman-adv: Distributed ARP Table - create DHT helper functions")
Reported-by: Yuan Tan <yuantan098@gmail.com>
Reported-by: Yifan Wu <yifanwucs@gmail.com>
Reported-by: Juefei Pu <tomapufckgml@gmail.com>
Reported-by: Xin Liu <bird@lzu.edu.cn>
Reviewed-by: Yuan Tan <yuantan098@gmail.com>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/distributed-arp-table.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/batman-adv/distributed-arp-table.c b/net/batman-adv/distributed-arp-table.c
index 3efc4cf50b469..0a8bd95e2f99e 100644
--- a/net/batman-adv/distributed-arp-table.c
+++ b/net/batman-adv/distributed-arp-table.c
@@ -696,6 +696,9 @@ static bool batadv_dat_forward_data(struct batadv_priv *bat_priv,
 			goto free_orig;
 
 		tmp_skb = pskb_copy_for_clone(skb, GFP_ATOMIC);
+		if (!tmp_skb)
+			goto free_neigh;
+
 		if (!batadv_send_skb_prepare_unicast_4addr(bat_priv, tmp_skb,
 							   cand[i].orig_node,
 							   packet_subtype)) {
-- 
2.47.3

