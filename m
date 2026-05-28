Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7843CD6E44
	for <batman-adv@archiver.kernel.org>; Thu, 28 May 2026 14:39:15 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 37382843F8
	for <batman-adv@archiver.kernel.org>; Thu, 28 May 2026 16:39:14 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1779979154;
 b=Z+WZehO72BewrdiL7YPf3pqPT5AEFN/W6xaHxm5anaTpT84b5Q8xLPKy/FblO0issYJxq
 BrivcwHRqrF7TX8X0039Wt4fTdoK3HuArlqMxVu/NEqaMqZmcQwU9dvutBiVjtZOOoVUNlF
 efZCZvd+UNF0wnZg632xvSCXUxYr2Tw=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1779979154; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=tlRW/1o5c5Pn9BcJXzRZfsihaCkWvKRTb1wXQ9KjKv8=;
 b=tuQ97NI4YnZKQuBCYx1fUnZaokYmJxTBfgsvNM6v+ljTbTK2SLdzoTIPlhgnHknT8hQOm
 v9/mi079ssvXAh3ooNoXLL9z1ph698yv7PhJTpKW2fp6G+454P27HBbWHycbGSVnvTKxNml
 /x0TF7+6+T+IIyCzB1E0mowjRXqFNyk=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de
 [IPv6:2a01:4f8:c17:e8c0::1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 994F483E04
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 28 May 2026 16:29:35 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1779978575;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=tlRW/1o5c5Pn9BcJXzRZfsihaCkWvKRTb1wXQ9KjKv8=;
	b=1sdWgDBQk44PS6YfItaBjyV8e2M9YOX6TLuIdJosMtJpMVGYYQf3OWWGs/4O6/kdReV0Xt
	u1k+Yig9k2+31pVKqzLsylI8ZuyAXcfJ1dL3l2ZBQH6crUHkZtHJlpDxbhihKubUv/qgyl
	2FoYCot6VlFnglgb7Lb2zq0jX+fMgOc=
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1779978575;
	b=SDAZzljGxEEmmyNgNvZ4nlgBsCjGEkVvwI39zyJFiffleIu8m962ox1h7z3KixuT5gbw/Z
	bIkaUU8VzkABmPZEx9z++RV9JKGXDSGVGCC9tdn2THiJaUtorX49gHNruEfDMMccQtwtRm
	3LUGEuuUx22pXrKtpkK6hVgpI6JvFnI=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b="zOi1U/YQ";
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 2a01:4f8:c17:e8c0::1 as permitted sender)
 smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1779978574;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tlRW/1o5c5Pn9BcJXzRZfsihaCkWvKRTb1wXQ9KjKv8=;
	b=zOi1U/YQxRf3sp1ZGgtCjuiwONVc4+wXHvcj6fO/zyzuC0WzgjafdCGZ5P5yrtNJT0rNqX
	tyy7OgVvULtcJzrnN/IgUAYY8EujTwzF/Ro+R6QLp45nZP9clJJgqBjij7K8a1w+FpMtUp
	mnJQEuqh8ZyAWX08Jtvs6UNp6vJPZLn0d2wL190XLkto5UR6ANhucnQWHvPRNNtgR7/bWv
	Os4pdYlQ9t+XzukSJCFXOu5lUReAq3blMyA2L5wLm8aPmhgkqUSPjLVFLtOn9DH1kQy3Su
	amNzVbg2edcL4m8RSCNb2QJHkFSFk9QVR6Cz8Qo7HvgGt/xC0ZxiR4Eqr8uzRw==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Sven Eckelmann <sven@narfation.org>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net-next 12/15] batman-adv: replace non-atomic last_ttvn with
 (READ|WRITE)_ONCE
Date: Thu, 28 May 2026 16:29:21 +0200
Message-ID: <20260528142924.329658-13-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260528142924.329658-1-sw@simonwunderlich.de>
References: <20260528142924.329658-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: E5FG3CKCURDTFHP6CGQ5H6EY2M7SLRNQ
X-Message-ID-Hash: E5FG3CKCURDTFHP6CGQ5H6EY2M7SLRNQ
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/E5FG3CKCURDTFHP6CGQ5H6EY2M7SLRNQ/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Sven Eckelmann <sven@narfation.org>

The last TT version number of an meshif is only accessed as plain
loads/stores and does not require full atomic_t semantics. Convert to an
native integer and replace its users with READ_ONCE()/WRITE_ONCE() to avoid
load/store tearing.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/originator.c        |  2 +-
 net/batman-adv/routing.c           |  4 ++--
 net/batman-adv/send.c              |  2 +-
 net/batman-adv/translation-table.c | 16 ++++++++--------
 net/batman-adv/types.h             |  2 +-
 5 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
index 0ce07bfdade59..d05c8240426bd 100644
--- a/net/batman-adv/originator.c
+++ b/net/batman-adv/originator.c
@@ -965,7 +965,7 @@ struct batadv_orig_node *batadv_orig_node_new(struct batadv_priv *bat_priv,
 	orig_node->bat_priv = bat_priv;
 	ether_addr_copy(orig_node->orig, addr);
 	batadv_dat_init_orig_node_addr(orig_node);
-	atomic_set(&orig_node->last_ttvn, 0);
+	WRITE_ONCE(orig_node->last_ttvn, 0);
 	orig_node->tt_buff = NULL;
 	orig_node->tt_buff_len = 0;
 	orig_node->last_seen = jiffies;
diff --git a/net/batman-adv/routing.c b/net/batman-adv/routing.c
index 1dd295d934f49..cd4368b846add 100644
--- a/net/batman-adv/routing.c
+++ b/net/batman-adv/routing.c
@@ -765,7 +765,7 @@ batadv_reroute_unicast_packet(struct batadv_priv *bat_priv, struct sk_buff *skb,
 			goto out;
 
 		orig_addr = orig_node->orig;
-		orig_ttvn = (u8)atomic_read(&orig_node->last_ttvn);
+		orig_ttvn = READ_ONCE(orig_node->last_ttvn);
 	}
 
 	/* update the packet header */
@@ -845,7 +845,7 @@ static bool batadv_check_unicast_ttvn(struct batadv_priv *bat_priv,
 		if (!orig_node)
 			return false;
 
-		curr_ttvn = (u8)atomic_read(&orig_node->last_ttvn);
+		curr_ttvn = READ_ONCE(orig_node->last_ttvn);
 		batadv_orig_node_put(orig_node);
 	}
 
diff --git a/net/batman-adv/send.c b/net/batman-adv/send.c
index c7e86c83242a2..5f9da3606a8f5 100644
--- a/net/batman-adv/send.c
+++ b/net/batman-adv/send.c
@@ -222,7 +222,7 @@ batadv_send_skb_push_fill_unicast(struct sk_buff *skb, int hdr_size,
 				  struct batadv_orig_node *orig_node)
 {
 	struct batadv_unicast_packet *unicast_packet;
-	u8 ttvn = (u8)atomic_read(&orig_node->last_ttvn);
+	u8 ttvn = READ_ONCE(orig_node->last_ttvn);
 
 	if (batadv_skb_head_push(skb, hdr_size) < 0)
 		return false;
diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index e319b0796f7c8..8903b2f84f512 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -841,7 +841,7 @@ batadv_tt_prepare_tvlv_global_data(struct batadv_orig_node *orig_node,
 	}
 
 	(*tt_data)->flags = BATADV_NO_FLAGS;
-	(*tt_data)->ttvn = atomic_read(&orig_node->last_ttvn);
+	(*tt_data)->ttvn = READ_ONCE(orig_node->last_ttvn);
 	(*tt_data)->num_vlan = htons(num_vlan);
 
 	tt_vlan = (*tt_data)->vlan_data;
@@ -1822,7 +1822,7 @@ batadv_tt_global_dump_subentry(struct sk_buff *msg, u32 portid, u32 seq,
 	if (!hdr)
 		return -ENOBUFS;
 
-	last_ttvn = atomic_read(&orig->orig_node->last_ttvn);
+	last_ttvn = READ_ONCE(orig->orig_node->last_ttvn);
 
 	if (nla_put(msg, BATADV_ATTR_TT_ADDRESS, ETH_ALEN, common->addr) ||
 	    nla_put(msg, BATADV_ATTR_ORIG_ADDRESS, ETH_ALEN,
@@ -3013,7 +3013,7 @@ static bool batadv_send_other_tt_response(struct batadv_priv *bat_priv,
 	if (!res_dst_orig_node)
 		goto out;
 
-	orig_ttvn = (u8)atomic_read(&req_dst_orig_node->last_ttvn);
+	orig_ttvn = READ_ONCE(req_dst_orig_node->last_ttvn);
 	req_ttvn = tt_data->ttvn;
 
 	/* this node doesn't have the requested data */
@@ -3300,7 +3300,7 @@ static void batadv_tt_fill_gtable(struct batadv_priv *bat_priv,
 	orig_node->tt_buff = NULL;
 	spin_unlock_bh(&orig_node->tt_buff_lock);
 
-	atomic_set(&orig_node->last_ttvn, ttvn);
+	WRITE_ONCE(orig_node->last_ttvn, ttvn);
 
 out:
 	batadv_orig_node_put(orig_node);
@@ -3316,7 +3316,7 @@ static void batadv_tt_update_changes(struct batadv_priv *bat_priv,
 
 	batadv_tt_save_orig_buffer(bat_priv, orig_node, tt_change,
 				   batadv_tt_len(tt_num_changes));
-	atomic_set(&orig_node->last_ttvn, ttvn);
+	WRITE_ONCE(orig_node->last_ttvn, ttvn);
 }
 
 /**
@@ -3769,7 +3769,7 @@ static void batadv_tt_update_orig(struct batadv_priv *bat_priv,
 				  struct batadv_tvlv_tt_change *tt_change,
 				  u16 tt_num_changes, u8 ttvn)
 {
-	u8 orig_ttvn = (u8)atomic_read(&orig_node->last_ttvn);
+	u8 orig_ttvn = READ_ONCE(orig_node->last_ttvn);
 	struct batadv_tvlv_tt_vlan_data *tt_vlan;
 	bool full_table = true;
 	bool has_tt_init;
@@ -3911,7 +3911,7 @@ bool batadv_tt_add_temporary_global_entry(struct batadv_priv *bat_priv,
 
 	if (!batadv_tt_global_add(bat_priv, orig_node, addr, vid,
 				  BATADV_TT_CLIENT_TEMP,
-				  atomic_read(&orig_node->last_ttvn)))
+				  READ_ONCE(orig_node->last_ttvn)))
 		return false;
 
 	batadv_dbg(BATADV_DBG_TT, bat_priv,
@@ -4125,7 +4125,7 @@ static int batadv_roam_tvlv_unicast_handler_v1(struct batadv_priv *bat_priv,
 
 	batadv_tt_global_add(bat_priv, orig_node, roaming_adv->client,
 			     ntohs(roaming_adv->vid), BATADV_TT_CLIENT_ROAM,
-			     atomic_read(&orig_node->last_ttvn) + 1);
+			     READ_ONCE(orig_node->last_ttvn) + 1);
 
 out:
 	batadv_orig_node_put(orig_node);
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 51880748bc2f5..5d4ad35c19636 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -464,7 +464,7 @@ struct batadv_orig_node {
 	unsigned long capa_initialized;
 
 	/** @last_ttvn: last seen translation table version number */
-	atomic_t last_ttvn;
+	u8 last_ttvn;
 
 	/** @tt_buff: last tt changeset this node received from the orig node */
 	unsigned char *tt_buff;
-- 
2.47.3

