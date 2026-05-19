Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AE80CD4F3C
	for <batman-adv@archiver.kernel.org>; Tue, 19 May 2026 07:14:17 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id A556480728
	for <batman-adv@archiver.kernel.org>; Tue, 19 May 2026 09:14:15 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1779174855;
 b=K3PTIfRmcaSjjTf7bwpA1+P61RfekAsArnc/LUfNfWDl5gQERD22ddDZiJW6B0yMBTWIq
 li2MFF+7xpKl2usTvvMDI0QqzdZ36W5J/dZIFjsAmW4ckBFj63pNd2EqqnkxLXBQQ4EhqXo
 VvQsx2aP172KT5l8aA0Agp0pFCE2O7E=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1779174855; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=DuNSwr9qXH3NZSEzo6TTE9Wq3c+xIMh8L0x59FYWeHI=;
 b=nQmFyuJU6FvOTpFNsDuVw1EVKZ54RRI26eQL+F4enQyUu5Jb0moa1NkCZAqrbwsDYdDUy
 DUbSAQMNJV2HWhyQ4EBy2o9f/14TsVZWUch2pc36x9zd6Q6IpzkcHkUF14ktaDi/MyO+XNO
 4S7jSOcqIVSbEs8gJGFuFHagu4+xERk=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 34A8780E2E
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 19 May 2026 09:04:56 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1779174296;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=DuNSwr9qXH3NZSEzo6TTE9Wq3c+xIMh8L0x59FYWeHI=;
	b=CLQ1Y6AdK92Hk5tVs0DxyKBFAX1Om0+q3N89RlXQUcMybzqwMSqfYEfV5bdT6Wkkb3zEkp
	vpNG8X5g9YBwJEA1pSZztO7CaIZke13W2CIrvTdeIUuu100N8U0Qt8NiiH06ppblHvx38h
	9LpKRBdi6XFdj/SjQjQxb/n2ywHF8Eo=
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1779174296;
	b=AKNWwOMlhiUjYJEDHRw+32NeW1eW2/Z2lVQRpMdj27cnKgCqPPVYu5BLexsuSSnWgjNQ60
	6GKq9Z+M84gK7Act3LovCsI5OsH0o4UjD/HohVh/y3Zip02bYJ+Z+Z7rf2NZ+42yt51Bnt
	y7IF9FofJlNzht2afsog/C6UT1DN0F8=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=2YOGGfzq;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id E41B31FD9C;
	Tue, 19 May 2026 07:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1779174296;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DuNSwr9qXH3NZSEzo6TTE9Wq3c+xIMh8L0x59FYWeHI=;
	b=2YOGGfzqJ9/ss2LtlsdcPBftzq4CoUf0tALBPH1UqyUoXFbY4lld4S+RRxJAEunBzwBMRp
	YrUE6SyzGv9U8h7o6VPPNEhEXf4UKA7+tiMZkRaIqFmUX2YQ0PWgPAustCGRCI+LIGOU09
	eruqtc/5FssqGbjcTNWZac9k8xb9JXw=
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 19 May 2026 09:04:41 +0200
Subject: [PATCH batadv v2 6/7] batman-adv: replace non-atomic last_ttvn
 with (READ|WRITE)_ONCE
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-atomic-to-write-once-v2-6-1b643e847a56@narfation.org>
References: <20260519-atomic-to-write-once-v2-0-1b643e847a56@narfation.org>
In-Reply-To: <20260519-atomic-to-write-once-v2-0-1b643e847a56@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5818; i=sven@narfation.org;
 h=from:subject:message-id; bh=m5Sic6RGzCm/FypcyEcR7uOonw7XuRp58urVVlIppZg=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFk83G3lltvDbAvebb9jxyK/vfnT2+YLZZ/Tn/utjHh2/
 vpzd++AjlIWBjEuBlkxRZY9V/LPb2Z/K/952sejMHNYmUCGMHBxCsBEbHYzMiwVv/v335WsByf4
 LQ4p3tgUqfXgH+cy6x7duVbP3qV1CTgy/M9tENhw+m2iFvvMtlkPDJ19bjMJHdeavv3n+/Q5iwv
 4P3EAAA==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: VHQLVGDZTZM6SOABJKS4SPFA3MPNS3T2
X-Message-ID-Hash: VHQLVGDZTZM6SOABJKS4SPFA3MPNS3T2
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/VHQLVGDZTZM6SOABJKS4SPFA3MPNS3T2/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

The last TT version number of an meshif is only accessed as plain
loads/stores and does not require full atomic_t semantics. Convert to an
native integer and replace its users with READ_ONCE()/WRITE_ONCE() to avoid
load/store tearing.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/originator.c        |  2 +-
 net/batman-adv/routing.c           |  4 ++--
 net/batman-adv/send.c              |  2 +-
 net/batman-adv/translation-table.c | 16 ++++++++--------
 net/batman-adv/types.h             |  2 +-
 5 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
index 5a5cb277..84dfb4fd 100644
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
index 1dd295d9..cd4368b8 100644
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
index c7e86c83..5f9da360 100644
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
index 382a5826..675338c9 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -880,7 +880,7 @@ batadv_tt_prepare_tvlv_global_data(struct batadv_orig_node *orig_node,
 	}
 
 	(*tt_data)->flags = BATADV_NO_FLAGS;
-	(*tt_data)->ttvn = atomic_read(&orig_node->last_ttvn);
+	(*tt_data)->ttvn = READ_ONCE(orig_node->last_ttvn);
 	(*tt_data)->num_vlan = htons(num_vlan);
 
 	tt_vlan = (*tt_data)->vlan_data;
@@ -1861,7 +1861,7 @@ batadv_tt_global_dump_subentry(struct sk_buff *msg, u32 portid, u32 seq,
 	if (!hdr)
 		return -ENOBUFS;
 
-	last_ttvn = atomic_read(&orig->orig_node->last_ttvn);
+	last_ttvn = READ_ONCE(orig->orig_node->last_ttvn);
 
 	if (nla_put(msg, BATADV_ATTR_TT_ADDRESS, ETH_ALEN, common->addr) ||
 	    nla_put(msg, BATADV_ATTR_ORIG_ADDRESS, ETH_ALEN,
@@ -3052,7 +3052,7 @@ static bool batadv_send_other_tt_response(struct batadv_priv *bat_priv,
 	if (!res_dst_orig_node)
 		goto out;
 
-	orig_ttvn = (u8)atomic_read(&req_dst_orig_node->last_ttvn);
+	orig_ttvn = READ_ONCE(req_dst_orig_node->last_ttvn);
 	req_ttvn = tt_data->ttvn;
 
 	/* this node doesn't have the requested data */
@@ -3339,7 +3339,7 @@ static void batadv_tt_fill_gtable(struct batadv_priv *bat_priv,
 	orig_node->tt_buff = NULL;
 	spin_unlock_bh(&orig_node->tt_buff_lock);
 
-	atomic_set(&orig_node->last_ttvn, ttvn);
+	WRITE_ONCE(orig_node->last_ttvn, ttvn);
 
 out:
 	batadv_orig_node_put(orig_node);
@@ -3355,7 +3355,7 @@ static void batadv_tt_update_changes(struct batadv_priv *bat_priv,
 
 	batadv_tt_save_orig_buffer(bat_priv, orig_node, tt_change,
 				   batadv_tt_len(tt_num_changes));
-	atomic_set(&orig_node->last_ttvn, ttvn);
+	WRITE_ONCE(orig_node->last_ttvn, ttvn);
 }
 
 /**
@@ -3808,7 +3808,7 @@ static void batadv_tt_update_orig(struct batadv_priv *bat_priv,
 				  struct batadv_tvlv_tt_change *tt_change,
 				  u16 tt_num_changes, u8 ttvn)
 {
-	u8 orig_ttvn = (u8)atomic_read(&orig_node->last_ttvn);
+	u8 orig_ttvn = READ_ONCE(orig_node->last_ttvn);
 	struct batadv_tvlv_tt_vlan_data *tt_vlan;
 	bool full_table = true;
 	bool has_tt_init;
@@ -3950,7 +3950,7 @@ bool batadv_tt_add_temporary_global_entry(struct batadv_priv *bat_priv,
 
 	if (!batadv_tt_global_add(bat_priv, orig_node, addr, vid,
 				  BATADV_TT_CLIENT_TEMP,
-				  atomic_read(&orig_node->last_ttvn)))
+				  READ_ONCE(orig_node->last_ttvn)))
 		return false;
 
 	batadv_dbg(BATADV_DBG_TT, bat_priv,
@@ -4164,7 +4164,7 @@ static int batadv_roam_tvlv_unicast_handler_v1(struct batadv_priv *bat_priv,
 
 	batadv_tt_global_add(bat_priv, orig_node, roaming_adv->client,
 			     ntohs(roaming_adv->vid), BATADV_TT_CLIENT_ROAM,
-			     atomic_read(&orig_node->last_ttvn) + 1);
+			     READ_ONCE(orig_node->last_ttvn) + 1);
 
 out:
 	batadv_orig_node_put(orig_node);
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index d483abb8..154de214 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -443,7 +443,7 @@ struct batadv_orig_node {
 	unsigned long capa_initialized;
 
 	/** @last_ttvn: last seen translation table version number */
-	atomic_t last_ttvn;
+	u8 last_ttvn;
 
 	/** @tt_buff: last tt changeset this node received from the orig node */
 	unsigned char *tt_buff;

-- 
2.47.3

