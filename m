Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07C72CA5FEC
	for <batman@archiver.kernel.org>; Sun,  4 Oct 2026 10:10:22 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 30B5081E86
	for <batman@archiver.kernel.org>; Sun, 04 Oct 2026 12:10:21 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1791108621;
 b=3+LbDHmo2JqXqMpYHb+jVHQiZMCPVW92GZ/+W1K5dgh5Ecz6uMBp/f2vJ4XudwNIOpi5p
 xX5D0A3VySuyQiKK1veLfn4OFh6fo+t1eDJW9tHnOG0jjNio33F/vhgGq/IS2pM+dwo/P0I
 4LwZl9hgosU4VbpYKShPUeI/S2wuDHs=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1791108621; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=L+8un0deqAXnSCm0qY9A5hbfKr/tp2CeeCyV34SbKqA=;
 b=E/dYU6nayFy6jiQXhAw2D6N76TojH+UYuyAGmYFZmoTfFX8wAzgL7dav8X1bLhkF9eDpf
 YXS/u4XivdED8HrWyE5MQp1B1Vy6cAsusift+Ps+NB4OjfJONtu7aNUuj569p+IkN/aiYLu
 QK9IC1Uqcq7X5LEjEfdciBGw7WkNa4o=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 432A681CA7
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 04 Oct 2026 12:09:13 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1791108553;
	b=i3Cvti1oSt430GPuPJBdj85hZcC9MSUZW6ikPFwBJzcDI09UNg2EC1R+u2x19I5WqGA0Dw
	k/yRssQacQ0qnMlPn/LHLWwmZRDSjByctgf9tGkg6RiAie9OYS2WeXNqGq9jCoo80xkQY1
	etzdVi0EiiEUb9N2/Tu7oqFzf9J8xGQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1791108553;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=L+8un0deqAXnSCm0qY9A5hbfKr/tp2CeeCyV34SbKqA=;
	b=CuUuZAuLuW80dGwkiR3ZMiUqPw2hn+qRSc5JedDduvp7jzembtDTfCUvtOuhRVy4BGEn/S
	Csgx82pJNPOfbC9s6oW7WbJq4jeVM1uqN1lVik27u4Xtrc6NjYVEiJry4j7Gnrt8SUVF2v
	IUWR1dyVAgT1lKWZ6GojD7aHwHtQsYA=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=mMyEeRAR;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 957B42046C;
	Sun, 04 Oct 2026 10:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1791108552;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L+8un0deqAXnSCm0qY9A5hbfKr/tp2CeeCyV34SbKqA=;
	b=mMyEeRARwlk7KqN4eL9R56v+cXljA52cWyVYlZraWUlEi+sCjSss7VAU5Mi24lrEcpseo9
	uUaUNd66XcysnNUDtRrsgx+NDQWEzupaCqTQ/KJ6Ed/NXc6Zue5+q2rY8lKIMOkouP5RXI
	MDdmWNldfqPOKoqPKbLeRzSgrZzqwyI=
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 04 Oct 2026 12:08:41 +0200
Subject: [PATCH batadv v2 6/9] batman-adv: annotate neigh_node last_seen
 with READ/WRITE_ONCE
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261004-dat-last_update-once-v2-6-ab012a4b18ed@narfation.org>
References: <20261004-dat-last_update-once-v2-0-ab012a4b18ed@narfation.org>
In-Reply-To: <20261004-dat-last_update-once-v2-0-ab012a4b18ed@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>, Sashiko <sashiko-bot@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4103; i=sven@narfation.org;
 h=from:subject:message-id; bh=ZeX2xMSimVJ3THQCvCgKQrUCbxHrfCNro0K0uRS2kSc=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFmHVLc8EDg4Qaw+ZLeMoKlQ5EXDOe2PPqRe91wqUmqVd
 0pS+U5WRykLgxgXg6yYIsueK/nnN7O/lf887eNRmDmsTCBDGLg4BWAiK1IY/gpdE8tQNOS7xJDg
 4Fcf/PfrfO8cc7ct2ckvq/aV3m0/W8bwV/TpxeZ8Z44IxWa1U1u69pXvOns+Nv9MwKPfbHvmqhz
 fyAgA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: DUWYIGBPN55YASHJQNT5KKD3TZWHQWVN
X-Message-ID-Hash: DUWYIGBPN55YASHJQNT5KKD3TZWHQWVN
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/DUWYIGBPN55YASHJQNT5KKD3TZWHQWVN/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

The last_seen field for batadv_neigh_node tracks the jiffies value of the
most recent activity and is used to detect timeouts. These accesses are not
consistently protected by a lock, so READ_ONCE/WRITE_ONCE must be used to
prevent data races caused by compiler optimizations.

To avoid an underflow due to an non-strict order read of jffies vs
last_seen, use jiffies_delta_to_msecs instead of jiffies_to_msecs to
evaluate the delta.

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
index a56b2fb6..d250e47a 100644
--- a/net/batman-adv/bat_v_elp.c
+++ b/net/batman-adv/bat_v_elp.c
@@ -508,6 +508,7 @@ static void batadv_v_elp_neigh_update(struct batadv_priv *bat_priv,
 	struct batadv_hardif_neigh_node *hardif_neigh;
 	struct batadv_orig_node *orig_neigh;
 	struct batadv_neigh_node *neigh;
+	unsigned long last_seen;
 	s32 elp_latest_seqno;
 	s32 seqno_diff;
 
@@ -533,8 +534,9 @@ static void batadv_v_elp_neigh_update(struct batadv_priv *bat_priv,
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

