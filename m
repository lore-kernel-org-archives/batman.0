Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E4C9CD4F3C
	for <batman@archiver.kernel.org>; Sat, 16 May 2026 12:39:10 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id EB38C853DF
	for <batman@archiver.kernel.org>; Sat, 16 May 2026 14:39:08 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1778935148;
 b=fQTOILD/GzCBcVkcGW+t75fiksj5vtl0cxdz0e8DSQtSfgFovUPjl476ruaWBab05ol77
 1nV1r7Yf0oeGmU1doTykG2FXbqlUn9+oW+WxImVBqaEBsbgWAuWNzVMhPqO0S7IUJ8SWRA1
 kvoE2tKUeXF8ZmXRocBBSotEyUnWIgw=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1778935148; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=3Bw2FwVEy6gWBXkN7LPoEbvf0LxUJePIDlHIfVXJP9I=;
 b=4M/OioVOnp48caoyK1ZvjXMzQVbqwXZ+H583qCZvxngzSkxGKUDeDfTxSNjeem9XFDRhQ
 d0TPepMzYa2GSjF8jAeB7w5vV7C21RYbSD4dlG9zSAVuOjdYZ5jaS2kAA/yfEtwUCV7wFwq
 OKgxW40OtkWwi+V43gEUW6vaXtXTLbE=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id A960A82349
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sat, 16 May 2026 14:35:51 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1778934951;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=3Bw2FwVEy6gWBXkN7LPoEbvf0LxUJePIDlHIfVXJP9I=;
	b=2YM04zkaEQw9hRRPuIy3na/ZCk5OG6FGeWTqaQOL7YuEmDwFvb9QzdYW4nRuCzEZnSGsCw
	WNerDRLZU3KqUrHGTs4KNF9MeCMxQGQk67aqBEVFgYJcls78Sfi+7JbgCNij5AqmMdcm26
	w44VXWRwpOV0/FsA5py+BakvtQJ78DU=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=CiIQmm3D;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1778934951;
	b=PzKRJr5Te96LENglvwqyFAvP5yAJSLVvH7ptEeMMhZJwmZAtyeBAgJkURWZWPzd6uCBk+1
	XE2r/0o9Ege9pR/DF2kEoqq6PVu6jYtmslgb1Tv3xjGwf7VRWG+JiwwfT/+E0ferY8SxZC
	/KU8M/avXJahIp844vR0WaXsDJxMv2M=
Received: by dvalin.narfation.org (Postfix) id 9D95E20101;
	Sat, 16 May 2026 12:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1778934949;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3Bw2FwVEy6gWBXkN7LPoEbvf0LxUJePIDlHIfVXJP9I=;
	b=CiIQmm3DiDUsJVqAxW483HUikQoUAV5VHYP+92fPCmZ3B5Xp6b8U81xTt3vqqH9ENRhiLM
	5jA9tX5Vjai63O5KTqm5rTigzj02RU6YazovlloEOlNc7MT5M2lRHjOvnmRijPX102/FMr
	ZDNVzjR+vXSpI0sk9xUkPJq+Ht8gIvw=
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 16 May 2026 14:35:21 +0200
Subject: [PATCH RFC batadv 4/5] batman-adv: limit numbers of parallel
 learned BLA backbones
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260516-resource-limit-v1-4-6f597360ed2b@narfation.org>
References: <20260516-resource-limit-v1-0-6f597360ed2b@narfation.org>
In-Reply-To: <20260516-resource-limit-v1-0-6f597360ed2b@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5983; i=sven@narfation.org;
 h=from:subject:message-id; bh=cTPj4OEi48Ri2oAX+x2SGz1aYRT1ANp5CfevB5+oOxg=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFkcKd2lUl6nQrouJIapz1htE2TQ6tJT65P7/s9N1WfZx
 61V2m07SlkYxLgYZMUUWfZcyT+/mf2t/OdpH4/CzGFlAhnCwMUpABNRl2L4Z/wns1WxpcOQV9fx
 UvXnpZPC2MMUJ9z/IP+s3+7zPbWm5YwMc48vt8tkWmIafHd6y/2CdJvtDUs6bj3bfDfYQPXEM+n
 5fAA=
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: AO7RNPITM5I35NW5XP72YXMJDVI724VV
X-Message-ID-Hash: AO7RNPITM5I35NW5XP72YXMJDVI724VV
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/AO7RNPITM5I35NW5XP72YXMJDVI724VV/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

A malicious actor behind one bridge port may spam the kernel with OGMs with
a random source MAC address, each of which will create a BLA backbone, each
of which is a dynamic allocation in the kernel. This will at some point
exhaust the available memory.

Mitigate this by maintaining a per meshif count of those automatically
generated entries in orig_learned, and a limit in orig_max_learned. If the
limit is hit new entries are not learned anymore.

For backwards compatibility, the default setting of 0 disables the limit.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 include/uapi/linux/batman_adv.h        |  6 ++++++
 net/batman-adv/bridge_loop_avoidance.c | 11 +++++++++++
 net/batman-adv/mesh-interface.c        |  3 +++
 net/batman-adv/netlink.c               | 10 ++++++++++
 net/batman-adv/types.h                 |  6 ++++++
 5 files changed, 36 insertions(+)

diff --git a/include/uapi/linux/batman_adv.h b/include/uapi/linux/batman_adv.h
index cca87d42..4188d83c 100644
--- a/include/uapi/linux/batman_adv.h
+++ b/include/uapi/linux/batman_adv.h
@@ -499,6 +499,12 @@ enum batadv_nl_attrs {
 	 */
 	BATADV_ATTR_DAT_MAX_LEARNED,
 
+	/**
+	 * @BATADV_ATTR_BLA_BACKBONE_MAX_LEARNED: defines the maximum number of BLA backbone
+	 * which can be learned in parallel
+	 */
+	BATADV_ATTR_BLA_BACKBONE_MAX_LEARNED,
+
 	/* add attributes above here, update the policy in netlink.c */
 
 	/**
diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
index cec11f12..8bb8dec6 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -494,6 +494,8 @@ batadv_bla_get_backbone_gw(struct batadv_priv *bat_priv, const u8 *orig,
 {
 	struct batadv_bla_backbone_gw *entry;
 	struct batadv_orig_node *orig_node;
+	u32 bla_backbone_max_learned;
+	int bla_backbone_learned;
 	int hash_added;
 
 	entry = batadv_backbone_hash_find(bat_priv, orig, vid);
@@ -505,6 +507,11 @@ batadv_bla_get_backbone_gw(struct batadv_priv *bat_priv, const u8 *orig,
 		   "%s(): not found (%pM, %d), creating new entry\n", __func__,
 		   orig, batadv_print_vid(vid));
 
+	bla_backbone_max_learned = READ_ONCE(bat_priv->bla_backbone_max_learned);
+	bla_backbone_learned = atomic_read(&bat_priv->bla_backbone_learned);
+	if (bla_backbone_max_learned && bla_backbone_learned >= bla_backbone_max_learned)
+		return NULL;
+
 	entry = kzalloc_obj(*entry, GFP_ATOMIC);
 	if (!entry)
 		return NULL;
@@ -520,6 +527,8 @@ batadv_bla_get_backbone_gw(struct batadv_priv *bat_priv, const u8 *orig,
 	INIT_WORK(&entry->report_work, batadv_bla_loopdetect_report);
 	kref_init(&entry->refcount);
 
+	atomic_inc(&bat_priv->bla_backbone_learned);
+
 	kref_get(&entry->refcount);
 	hash_added = batadv_hash_add(bat_priv->bla.backbone_hash,
 				     batadv_compare_backbone_gw,
@@ -529,6 +538,7 @@ batadv_bla_get_backbone_gw(struct batadv_priv *bat_priv, const u8 *orig,
 	if (unlikely(hash_added != 0)) {
 		/* hash failed, free the structure */
 		kfree(entry);
+		atomic_dec(&bat_priv->bla_backbone_learned);
 		return NULL;
 	}
 
@@ -1256,6 +1266,7 @@ static void batadv_bla_purge_backbone_gw(struct batadv_priv *bat_priv, int now)
 
 			hlist_del_rcu(&backbone_gw->hash_entry);
 			batadv_backbone_gw_put(backbone_gw);
+			atomic_dec(&bat_priv->bla_backbone_learned);
 		}
 		spin_unlock_bh(list_lock);
 	}
diff --git a/net/batman-adv/mesh-interface.c b/net/batman-adv/mesh-interface.c
index 851a078d..1594a2d6 100644
--- a/net/batman-adv/mesh-interface.c
+++ b/net/batman-adv/mesh-interface.c
@@ -790,6 +790,9 @@ static int batadv_meshif_init_late(struct net_device *dev)
 	atomic_set(&bat_priv->tt.ogm_append_cnt, 0);
 #ifdef CONFIG_BATMAN_ADV_BLA
 	atomic_set(&bat_priv->bla.num_requests, 0);
+
+	atomic_set(&bat_priv->bla_backbone_learned, 0);
+	WRITE_ONCE(bat_priv->bla_backbone_max_learned, 0);
 #endif
 	atomic_set(&bat_priv->tp_num, 0);
 
diff --git a/net/batman-adv/netlink.c b/net/batman-adv/netlink.c
index 742b1e3e..5d4bccdc 100644
--- a/net/batman-adv/netlink.c
+++ b/net/batman-adv/netlink.c
@@ -150,6 +150,7 @@ static const struct nla_policy batadv_netlink_policy[NUM_BATADV_ATTR] = {
 	[BATADV_ATTR_NEIGH_MAX_LEARNED]		= { .type = NLA_U32 },
 	[BATADV_ATTR_ORIG_MAX_LEARNED]		= { .type = NLA_U32 },
 	[BATADV_ATTR_DAT_MAX_LEARNED]		= { .type = NLA_U32 },
+	[BATADV_ATTR_BLA_BACKBONE_MAX_LEARNED]	= { .type = NLA_U32 },
 };
 
 /**
@@ -293,6 +294,10 @@ static int batadv_netlink_mesh_fill(struct sk_buff *msg,
 	if (nla_put_u8(msg, BATADV_ATTR_BRIDGE_LOOP_AVOIDANCE_ENABLED,
 		       !!atomic_read(&bat_priv->bridge_loop_avoidance)))
 		goto nla_put_failure;
+
+	if (nla_put_u32(msg, BATADV_ATTR_BLA_BACKBONE_MAX_LEARNED,
+			READ_ONCE(bat_priv->bla_backbone_max_learned)))
+		goto nla_put_failure;
 #endif /* CONFIG_BATMAN_ADV_BLA */
 
 #ifdef CONFIG_BATMAN_ADV_DAT
@@ -483,6 +488,11 @@ static int batadv_netlink_set_mesh(struct sk_buff *skb, struct genl_info *info)
 			   !!nla_get_u8(attr));
 		batadv_bla_status_update(bat_priv->mesh_iface);
 	}
+
+	if (info->attrs[BATADV_ATTR_BLA_BACKBONE_MAX_LEARNED]) {
+		WRITE_ONCE(bat_priv->bla_backbone_max_learned,
+			   nla_get_u32(info->attrs[BATADV_ATTR_BLA_BACKBONE_MAX_LEARNED]));
+	}
 #endif /* CONFIG_BATMAN_ADV_BLA */
 
 #ifdef CONFIG_BATMAN_ADV_DAT
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 32d396dc..c8976da5 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -1674,6 +1674,12 @@ struct batadv_priv {
 	atomic_t orig_learned;
 
 #ifdef CONFIG_BATMAN_ADV_BLA
+	/** @bla_backbone_max_learned: Maximum number of backbone_gw */
+	u32 bla_backbone_max_learned;
+
+	/** @bla_backbone_learned: current number of learned backbone_gw entries */
+	atomic_t bla_backbone_learned;
+
 	/** @bla: bridge loop avoidance data */
 	struct batadv_priv_bla bla;
 #endif

-- 
2.47.3

