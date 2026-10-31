Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161B7606A31A
	for <batman@archiver.kernel.org>; Sat, 31 Oct 2026 20:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=narfation.org header.i=@narfation.org header.a=rsa-sha256 header.s=20121 header.b=lvY2ChJj
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id B07F980181
	for <batman@archiver.kernel.org>; Sat, 31 Oct 2026 21:32:45 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1793478765;
 b=Oshq1yjWo2Ls0cnlowuBkM8LvpKlkpwf38A49mKtbQUKXlj+5ol2jTCOqli1k1t1K9ki5
 cyNmQhXkMjBUFowKk+VDqhp89vXgWCXfzzfjC9F7ZytIFDgHBlJ5Mml5AWsY7+uSszLoYLm
 +FiNDEPNVd8FBqU3tvF6gIS+sOdjnBk=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1793478765; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=j6iqFmqRxLQjUo6Glc9EVFa4TK9KR5Wv8/blPc3I5p8=;
 b=FHpWX/Bpyq8fQJCYb1oSyMr/biEnJf9K1jqcIMWK7gKv+iIuDXVOqnKgFn7cIpOYs18s5
 xAHd41bPczNlMt9Voq9e4PlLB5K1abPRPuQhG5LHb3ybklVXW9o4Oh1npXhBWId0QYvcjSD
 0VFyfePXqSJPvdz00rwvKu8PzPFVwnA=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id D39D0817C3
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sat, 31 Oct 2026 21:30:39 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1793478639;
	b=3nUeQyWvla4ciCJJlEJCaE2rMV8m+HDGFvuRhL35jujtbhoyUHL75b84wg7wCVOS7t176G
	MovC72ilrJSp2Ky6g3XMDzT0Z+doq/NzWZ3ufYCG+5WyL11shW9g+x10wITMAXE8gjX32c
	e8lghrhf2nB6VgerT5pzuVZxBu/gatQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1793478639;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=j6iqFmqRxLQjUo6Glc9EVFa4TK9KR5Wv8/blPc3I5p8=;
	b=M/Uh3sriN1DFBQpLANNmckVsJJle/Hn6xe/zolpEuvdrqvvwyLgo6eYAxvsQHnT1oWqstG
	0hHp6RvQdpqmLZ3c5AxkNgY1nasZdn99PyALE3+X1jL2kWR1jhb7df2QKfReZzRp2+r5Np
	KFRotJ6wSPQ0U/WE65A0iSFckt4gyFM=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=lvY2ChJj;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 8632D20FE8;
	Sat, 31 Oct 2026 20:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1793478639;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j6iqFmqRxLQjUo6Glc9EVFa4TK9KR5Wv8/blPc3I5p8=;
	b=lvY2ChJjU621LEGaM/0HOQ9BU0ou6wmWpUYC3KQPkGtFLio4OgeCdACd4CIH5t6ggVBp94
	J7lxm+iWGwZ46WGTPjeFRQrkGhaVRfnKoc1kW3hZl/NjfY6dbpmL6TVAd1Wsel6mbBePHn
	2dlWouncl1z/yjuzvpJBUoo4UoNpW2s=
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 31 Oct 2026 21:29:46 +0100
Subject: [PATCH batadv v4 6/7] batman-adv: annotate neigh_node last_seen
 with READ/WRITE_ONCE
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261031-dat-last_update-once-v4-6-3f7994b1f5fe@narfation.org>
References: <20261031-dat-last_update-once-v4-0-3f7994b1f5fe@narfation.org>
In-Reply-To: <20261031-dat-last_update-once-v4-0-3f7994b1f5fe@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>, Sashiko <sashiko-bot@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3942; i=sven@narfation.org;
 h=from:subject:message-id; bh=LjiXVssbQRRu6LBPwg/tgNBxlAeTqca6TJt0QLUQbUo=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFnP/Hfl/t02/XjP395PGlPLLTye6PvOz73K/OdOkWGSR
 6aM7L2nHaUsDGJcDLJiiix7ruSf38z+Vv7ztI9HYeawMoEMYeDiFICJpJUyMtyQ6XxcmJ7H9vNh
 uluUn1/2i8xDdm3CrHG3LDbnn54XosDwz7o5bUdiw6ZNF6c71onvithz2e+70M8mWe/jEqWB+xc
 zMgAA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: ZJHJTA62HT2QFQWP36K4VQQNU3XBUI6N
X-Message-ID-Hash: ZJHJTA62HT2QFQWP36K4VQQNU3XBUI6N
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/ZJHJTA62HT2QFQWP36K4VQQNU3XBUI6N/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_NONE,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The last_seen field for batadv_neigh_node tracks the jiffies value of the
most recent activity and is used to detect timeouts. These accesses are not
consistently protected by a lock, so READ_ONCE/WRITE_ONCE must be used to
prevent data races caused by compiler optimizations.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/bug/linux-6ad653e2-1ce9-4124-bdf2-2187de5a2c16
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/bat_iv_ogm.c | 4 ++--
 net/batman-adv/bat_v_elp.c  | 6 ++++--
 net/batman-adv/bat_v_ogm.c  | 2 +-
 net/batman-adv/originator.c | 4 ++--
 4 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index ee3a5ac4..d4b6c09d 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -1169,7 +1169,7 @@ batadv_iv_ogm_orig_update(struct batadv_priv *bat_priv,
 	if (!neigh_ifinfo)
 		goto out;
 
-	neigh_node->last_seen = jiffies;
+	WRITE_ONCE(neigh_node->last_seen, jiffies);
 
 	spin_lock_bh(&neigh_node->ifinfo_lock);
 	batadv_ring_buffer_set(neigh_ifinfo->bat_iv.tq_recv,
@@ -1289,7 +1289,7 @@ static bool batadv_iv_ogm_calc_tq(struct batadv_orig_node *orig_node,
 
 	/* if orig_node is direct neighbor update neigh_node last_seen */
 	if (orig_node == orig_neigh_node)
-		neigh_node->last_seen = jiffies;
+		WRITE_ONCE(neigh_node->last_seen, jiffies);
 
 	WRITE_ONCE(orig_node->last_seen, jiffies);
 
diff --git a/net/batman-adv/bat_v_elp.c b/net/batman-adv/bat_v_elp.c
index 6ad6042a..cf84aed0 100644
--- a/net/batman-adv/bat_v_elp.c
+++ b/net/batman-adv/bat_v_elp.c
@@ -506,6 +506,7 @@ static void batadv_v_elp_neigh_update(struct batadv_priv *bat_priv,
 	struct batadv_hardif_neigh_node *hardif_neigh;
 	struct batadv_orig_node *orig_neigh;
 	struct batadv_neigh_node *neigh;
+	unsigned long last_seen;
 	s32 elp_latest_seqno;
 	s32 seqno_diff;
 
@@ -531,8 +532,9 @@ static void batadv_v_elp_neigh_update(struct batadv_priv *bat_priv,
 	if (seqno_diff < 1 && seqno_diff > -BATADV_ELP_MAX_AGE)
 		goto hardif_free;
 
-	neigh->last_seen = jiffies;
-	hardif_neigh->last_seen = jiffies;
+	last_seen = jiffies;
+	WRITE_ONCE(neigh->last_seen, last_seen);
+	hardif_neigh->last_seen = last_seen;
 	hardif_neigh->bat_v.elp_latest_seqno = ntohl(elp_packet->seqno);
 	hardif_neigh->bat_v.elp_interval = ntohl(elp_packet->elp_interval);
 
diff --git a/net/batman-adv/bat_v_ogm.c b/net/batman-adv/bat_v_ogm.c
index 03c70d91..cf3c1d22 100644
--- a/net/batman-adv/bat_v_ogm.c
+++ b/net/batman-adv/bat_v_ogm.c
@@ -658,7 +658,7 @@ static int batadv_v_ogm_metric_update(struct batadv_priv *bat_priv,
 		goto out;
 
 	last_seen = jiffies;
-	neigh_node->last_seen = last_seen;
+	WRITE_ONCE(neigh_node->last_seen, last_seen);
 	WRITE_ONCE(orig_node->last_seen, last_seen);
 
 	orig_ifinfo->last_real_seqno = ntohl(ogm2->seqno);
diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
index 3b925ba9..352a8805 100644
--- a/net/batman-adv/originator.c
+++ b/net/batman-adv/originator.c
@@ -698,7 +698,7 @@ batadv_neigh_node_create(struct batadv_orig_node *orig_node,
 	kref_get(&hard_iface->refcount);
 	ether_addr_copy(neigh_node->addr, neigh_addr);
 	neigh_node->if_incoming = hard_iface;
-	neigh_node->last_seen = jiffies;
+	WRITE_ONCE(neigh_node->last_seen, jiffies);
 
 #ifdef CONFIG_BATMAN_ADV_BATMAN_V
 	ACCESS_PRIVATE(neigh_node, orig_node_id) = orig_node;
@@ -1126,7 +1126,7 @@ batadv_purge_orig_neighbors(struct batadv_priv *bat_priv,
 	/* for all neighbors towards this originator ... */
 	hlist_for_each_entry_safe(neigh_node, node_tmp,
 				  &orig_node->neigh_list, list) {
-		last_seen = neigh_node->last_seen;
+		last_seen = READ_ONCE(neigh_node->last_seen);
 		if_incoming = neigh_node->if_incoming;
 
 		if (batadv_has_timed_out(last_seen, BATADV_PURGE_TIMEOUT) ||

-- 
2.47.3

