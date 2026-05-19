Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51194CD4F58
	for <batman-adv@archiver.kernel.org>; Tue, 19 May 2026 07:07:57 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 04C13809C7
	for <batman-adv@archiver.kernel.org>; Tue, 19 May 2026 09:07:47 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1779174467;
 b=sgCZH/yVq/AA9TtHMvGMY1wfwb5W98DJBsc/Zy5XYqq01dGUcpF0nR36mPPuP6+pNxs6s
 4noC6B6oYtzpxlm2CxoXW5HjvOGTiZsip7HJB26jCVv2fpTsVJNXRPjdT1+wR1sHtmS56pi
 9FDJRvKFoRnzkPSiSe2Dbimf+D5gxq4=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1779174467; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=P3r3acPyowC0IumkVD3ECbP4nlNw1vK1sJyiYUaFblM=;
 b=whF4ifbcLAK+kPzD+8xaYMitH64QiQ8RnesA0OVq+dO/Ossbnr9Ev7EkhL0aW1MPxMKuF
 bWL/GT1u7kyy37Y0hF5pc9OHc61YNo2YCTBNuDe0CVFU0PveJe94DD+4C+Y/QfcFWHi5yAs
 R1Q1kZ0wT/nvVp9ai+8Oq8qMPSY/BCM=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 84C6F80C33
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 19 May 2026 09:02:41 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1779174161;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=P3r3acPyowC0IumkVD3ECbP4nlNw1vK1sJyiYUaFblM=;
	b=2eApn+t29gQBY6NPblUdjuC8ozwQgrFhGJDq5gJwbfRrN+naqfU0mfqJeU8bZUUxEikrgl
	b0VWoPMwhQkBbhJT+LB8elvTBMo2zCqL4olKhq0XOkfp/ZYwYN79ZV47Q9EsD0yF3pOoTj
	Ejnoiq0yiRx2Ys9AYMfTaLnxtnUXn/o=
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1779174161;
	b=VJjyV0PdvGZ3FFL1eZmnEvIEQ/RYAEBkMPWnnjVayDec4I2NWWPyJs4P1RjZyalBkIphak
	7NqPepe7SeIu1y4oCPqEi0Hslc8do8O1P63bN4FHbVCP+C+zpBrvhZQCJn0QoRA7nR0I2b
	XUWPFasP26W3R1ET5QXzX3lqloHmKnU=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=2C0ImPQW;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 441BC1FE24;
	Tue, 19 May 2026 07:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1779174161;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P3r3acPyowC0IumkVD3ECbP4nlNw1vK1sJyiYUaFblM=;
	b=2C0ImPQWRoyF4mVwdYTLbJEtCkzbCZyXRkg35vCvKh2Vmt5X7Lm0yHgTekYrWLNc+t4chI
	oLB7PCP1fe1/j/QFfU3LXYGqO+FMMEClVICD6OCZMxMA5sBTqsPoARinxlWQVL0t0WD8AA
	0KLp+Ldt0nvP2SBEQmQbmN2tcWi2yxk=
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 19 May 2026 09:02:18 +0200
Subject: [PATCH RFC batadv v2 4/5] batman-adv: limit numbers of parallel
 learned BLA backbones
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-resource-limit-v2-4-489c3c919a54@narfation.org>
References: <20260519-resource-limit-v2-0-489c3c919a54@narfation.org>
In-Reply-To: <20260519-resource-limit-v2-0-489c3c919a54@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5983; i=sven@narfation.org;
 h=from:subject:message-id; bh=oVcAgDfnNSfGzbsl33Hm27pV6BykGKUYmpoRHWykmS4=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFk8XD8buDT286yO4mRM7WjNFxHybnylyb1MTFqVOYczM
 f7i72sdpSwMYlwMsmKKLHuu5J/fzP5W/vO0j0dh5rAygQxh4OIUgIlkzmT4K3xL57BcUd6tdTo3
 F7g31T14F/27J9I9fOokm6bks0K5vgz/S3YGzv/O0Veom2m0ZvMZrXbOqT/qFdZ5za3bd7Yz9e5
 WFgA=
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: HTXG6OSSIF7BDCIMMS7KDO76PR5HR5SY
X-Message-ID-Hash: HTXG6OSSIF7BDCIMMS7KDO76PR5HR5SY
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/HTXG6OSSIF7BDCIMMS7KDO76PR5HR5SY/>
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
index c8bf2212..c091b19e 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -1656,6 +1656,12 @@ struct batadv_priv {
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

