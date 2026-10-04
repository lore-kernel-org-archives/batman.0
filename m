Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E4E6CA5FCE
	for <batman@archiver.kernel.org>; Sun,  4 Oct 2026 10:11:24 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 3A925844B2
	for <batman@archiver.kernel.org>; Sun, 04 Oct 2026 12:11:23 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1791108683;
 b=Nw9Pso0F/PgAIgfJRIs+gUw6+mRw/z58eaM3w4yOZhDr/SDNyefwPVg3nf+754/25bGy8
 4qUE1pf4mAO5xh3xWnNY3GVKPEZMbVEfgmGjA8+Ho+x2lyS5FLrLrAcR6D8DmicRrZ5mbE6
 53xBBriLHadALmQhvibxbPQf5Tc+st0=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1791108683; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=cv/t6JoTpxF5YgCKrZshxPUoswc3yWuJ3jjz+xKK+nA=;
 b=el4dTY5pjwNlXy2WiCb9ctvPI7cM7yXnXQ0EwKPKx2bAdmDcMlqIGEKcISOdfgf2TDt88
 RgftB2EtOXLRhC4Ywn2cxrLRuiacxrHBQAhPEozXtNWRL9wNbD6290zz9/Qz/NQPJQnFmWU
 e8TupIPP+xiz90M35wA7VSBIgok/Mgk=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 1B153841D3
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 04 Oct 2026 12:09:15 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1791108555;
	b=DaBkkdFf3OYGFATw/2SyTLv/+0jwf3JnSTrsv9kMdOm78HzXExln8TQHJN87OAxMjBOs6J
	SXbTpCtkE2S7HwKcuZtw2pEwCMz88md5z+2Vz+JQb26/Ba3EO47XJ7d5qFGAKcm00e0UZk
	FkS3EnkhzmdzYJY2MZxdxhmQzD8Ux9k=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1791108555;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=cv/t6JoTpxF5YgCKrZshxPUoswc3yWuJ3jjz+xKK+nA=;
	b=L2hvGjA/8lYPgtU58AjHxcR9UF6FjFvccyrW7I6Nrb9xm65ywS6N2wX9iH6fQgAmKF2PDg
	5kixYvu2U6CV0Al8wB6zKDAsKwXlzO0NYCoDykz84BcXsl+kZPd6Et2N94qP0p25xHJ2WB
	A6uvq4s8FArv687H1wveQLiV1WzygXM=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b="EJV2/fHH";
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id CC37620494;
	Sun, 04 Oct 2026 10:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1791108554;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cv/t6JoTpxF5YgCKrZshxPUoswc3yWuJ3jjz+xKK+nA=;
	b=EJV2/fHHGYCnar1lAs1R5ZBc9juvxgYnw12ZUAG+h+wfQacorLXPcuNTwWTEt4A03Pg1xf
	nGrN09cycoadxscrJFsmVGLRRbEp2E5/X3QBSK3/ucIG5CdKrHj7CE+mFGXX0M5gae5L9o
	EZVpK0lrjzPajjs5lYhM+bv8jcKBnCQ=
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 04 Oct 2026 12:08:42 +0200
Subject: [PATCH batadv v2 7/9] batman-adv: annotate hardif_neigh_node
 last_seen with READ/WRITE_ONCE
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261004-dat-last_update-once-v2-7-ab012a4b18ed@narfation.org>
References: <20261004-dat-last_update-once-v2-0-ab012a4b18ed@narfation.org>
In-Reply-To: <20261004-dat-last_update-once-v2-0-ab012a4b18ed@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3625; i=sven@narfation.org;
 h=from:subject:message-id; bh=uznJZOAhuAIAviDAtCTfu8RTOgy6h1vpn753Y++P+UM=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFmHVLc6tm+4IxNpxuU/J2rLN7UN28Q+zuLlfOy1uDBgG
 9engNLVHaUsDGJcDLJiiix7ruSf38z+Vv7ztI9HYeawMoEMYeDiFICJsHxnZNh3M68nsaHGZvGJ
 /fHqr8wubNqxW6leI9tMVNsnRqy2JoLhr2iTR0Ox3HTjCZ8+e3N3ZqYyJrJke61P/nXxfD6f9W0
 LPgA=
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: TCM6MSZPHUPOMH7ZK5XABKASQZWDMTOQ
X-Message-ID-Hash: TCM6MSZPHUPOMH7ZK5XABKASQZWDMTOQ
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/TCM6MSZPHUPOMH7ZK5XABKASQZWDMTOQ/>
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

