Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85C4ACA5FED
	for <batman@archiver.kernel.org>; Tue,  6 Oct 2026 16:51:52 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 20E4180FE0
	for <batman@archiver.kernel.org>; Tue, 06 Oct 2026 18:51:51 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1791305511;
 b=gI6YDGsqu7mLkIYs5jfCYyC6pFnXYEFdC9VUq/v6PpTLKVAdigeOt6lro4HLXDGArp8F9
 RD+ucDwvrpKqX6zugz+t93Xh1hLS1SvGRmzhl7SMtg9uCH3dIFBvBlKuE6p6S3lTrNpv9OD
 KuTDghsfiUnKz5QgyvJlHOP8pnxE6fM=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1791305511; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=cv/t6JoTpxF5YgCKrZshxPUoswc3yWuJ3jjz+xKK+nA=;
 b=DQMf9a5pdvGgRxqh5wzUfo/hfGrpVZ2Sa27KQSbF/zb7SYvJ/FxyegMyklgfFq8dAW9Gv
 jutiAd5uQg0UUikxGc5v1EenLjl+gzcfTTDLnXe0uqE3Q4BjjIOtOebGPL3SmdMn+prsoKz
 wD4wZWOzo/kLEY+ro/hxfFhNuHulK9k=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 9D8FB8425B
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 06 Oct 2026 18:48:44 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1791305324;
	b=EeyHbrWREAmpVmv7gKhJ6/LP08HzNiFWHyinDrocqNVadcHQlf6J1AYsIcr4V71yUJ++i2
	pchJYaLMF9bjw0ddrS5RhP9z/7a6ba5Emx0kS5wyocJXUZy0Q+kms6AwyXGkvQZTEWM6+7
	ZDu9L5bv2c1XB69rbLZMOULGZfURCpA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1791305324;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=cv/t6JoTpxF5YgCKrZshxPUoswc3yWuJ3jjz+xKK+nA=;
	b=FrqswLFIKW9O80R62lxKfY5Ipj4ZiaIskE6TtBrcyejsr3ENk+UKMG+bGTOu2aZrQAeAco
	Kz5MU1KLMT6PoxBta5hv+mXAPbk2KoFktSiB27vVvoap2e8+cych5YHbSf5EtG89bi0Ng8
	yImZsMCxNCK/zMz9q9TAaicxMjEqvI0=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=09xkr4Xy;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 5FB381FFBB;
	Tue, 06 Oct 2026 16:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1791305324;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cv/t6JoTpxF5YgCKrZshxPUoswc3yWuJ3jjz+xKK+nA=;
	b=09xkr4XymvfVq95U01rnVYtmkrGvhGBHGjzAZVlg/aeRuwD4AOi3iOcpMWsdiDpIGkUmR0
	CjFHdKcHfq+kE+1apYAT7sQoOQdTQfvS7dF/8aEVDNBLlEO8VnDYbAdQQNfsOsSjD4Cmmo
	OxwjLYjWE8Ox5HvO9WcpPPtA8EETkEE=
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 06 Oct 2026 18:47:09 +0200
Subject: [PATCH batadv v3 7/9] batman-adv: annotate hardif_neigh_node
 last_seen with READ/WRITE_ONCE
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261006-dat-last_update-once-v3-7-316aefdd5f5f@narfation.org>
References: <20261006-dat-last_update-once-v3-0-316aefdd5f5f@narfation.org>
In-Reply-To: <20261006-dat-last_update-once-v3-0-316aefdd5f5f@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3625; i=sven@narfation.org;
 h=from:subject:message-id; bh=uznJZOAhuAIAviDAtCTfu8RTOgy6h1vpn753Y++P+UM=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFlH1bi2s9T92aC+dqpsys5fhSy+p46v4z9/4OMl3t+Md
 +f7KYkc6ShlYRDjYpAVU2TZcyX//Gb2t/Kfp308CjOHlQlkCAMXpwBMpOw4w//kSdbtLy+JT+MM
 X3r11CW5mvXiPc4tmVtuqy+KUb9g1ajDyLBSMin+uYrMup4iS2cvmdot17pPsE/35aq5tZPt5f+
 qbF4A
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: POEGWQPFRJCSET7YUW35TXDBZQKKVMJ5
X-Message-ID-Hash: POEGWQPFRJCSET7YUW35TXDBZQKKVMJ5
X-MailFrom: sven@narfation.org
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/POEGWQPFRJCSET7YUW35TXDBZQKKVMJ5/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

The last_seen field for batadv_hardif_neigh_node tracks the jiffies value
of the most recent activity and is used to detect timeouts. These accesses
are not consistently protected by a lock, so READ_ONCE/WRITE_ONCE must be
used to prevent data races caused by compiler optimizations.

To avoid an underflow due to an non-strict order read of jffies vs
last_seen, use jiffies_delta_to_msecs instead of jiffies_to_msecs to
evaluate the delta.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/bat_iv_ogm.c | 6 ++++--
 net/batman-adv/bat_v.c      | 4 +++-
 net/batman-adv/bat_v_elp.c  | 2 +-
 net/batman-adv/originator.c | 2 +-
 4 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index d4b6c09d..4e15af1e 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -1569,7 +1569,7 @@ batadv_iv_ogm_process_per_outif(const struct sk_buff *skb, int ogm_offset,
 		hardif_neigh = batadv_hardif_neigh_get(if_incoming,
 						       ethhdr->h_source);
 		if (hardif_neigh)
-			hardif_neigh->last_seen = jiffies;
+			WRITE_ONCE(hardif_neigh->last_seen, jiffies);
 	}
 
 	router = batadv_orig_router_get(orig_node, if_outgoing);
@@ -2287,9 +2287,11 @@ batadv_iv_ogm_neigh_dump_neigh(struct sk_buff *msg, u32 portid, u32 seq,
 			       struct batadv_hardif_neigh_node *hardif_neigh)
 {
 	unsigned int last_seen_msecs;
+	unsigned long last_seen;
 	void *hdr;
 
-	last_seen_msecs = jiffies_to_msecs(jiffies - hardif_neigh->last_seen);
+	last_seen = READ_ONCE(hardif_neigh->last_seen);
+	last_seen_msecs = jiffies_delta_to_msecs(jiffies - last_seen);
 
 	hdr = genlmsg_put(msg, portid, seq, &batadv_netlink_family,
 			  NLM_F_MULTI, BATADV_CMD_GET_NEIGHBORS);
diff --git a/net/batman-adv/bat_v.c b/net/batman-adv/bat_v.c
index de80e656..be113e9a 100644
--- a/net/batman-adv/bat_v.c
+++ b/net/batman-adv/bat_v.c
@@ -160,10 +160,12 @@ batadv_v_neigh_dump_neigh(struct sk_buff *msg, u32 portid, u32 seq,
 			  struct batadv_hardif_neigh_node *hardif_neigh)
 {
 	unsigned int last_seen_msecs;
+	unsigned long last_seen;
 	u32 throughput;
 	void *hdr;
 
-	last_seen_msecs = jiffies_to_msecs(jiffies - hardif_neigh->last_seen);
+	last_seen = READ_ONCE(hardif_neigh->last_seen);
+	last_seen_msecs = jiffies_delta_to_msecs(jiffies - last_seen);
 	throughput = ewma_throughput_read(&hardif_neigh->bat_v.throughput);
 	throughput = throughput * 100;
 
diff --git a/net/batman-adv/bat_v_elp.c b/net/batman-adv/bat_v_elp.c
index d250e47a..ee571384 100644
--- a/net/batman-adv/bat_v_elp.c
+++ b/net/batman-adv/bat_v_elp.c
@@ -536,7 +536,7 @@ static void batadv_v_elp_neigh_update(struct batadv_priv *bat_priv,
 
 	last_seen = jiffies;
 	WRITE_ONCE(neigh->last_seen, last_seen);
-	hardif_neigh->last_seen = last_seen;
+	WRITE_ONCE(hardif_neigh->last_seen, last_seen);
 	hardif_neigh->bat_v.elp_latest_seqno = ntohl(elp_packet->seqno);
 	hardif_neigh->bat_v.elp_interval = ntohl(elp_packet->elp_interval);
 
diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
index 352a8805..0f47ac3e 100644
--- a/net/batman-adv/originator.c
+++ b/net/batman-adv/originator.c
@@ -587,7 +587,7 @@ batadv_hardif_neigh_create(struct batadv_hard_iface *hard_iface,
 	ether_addr_copy(hardif_neigh->addr, neigh_addr);
 	ether_addr_copy(hardif_neigh->orig, orig_node->orig);
 	hardif_neigh->if_incoming = hard_iface;
-	hardif_neigh->last_seen = jiffies;
+	WRITE_ONCE(hardif_neigh->last_seen, jiffies);
 
 	kref_init(&hardif_neigh->refcount);
 

-- 
2.47.3

