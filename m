Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB4D4C531C9
	for <batman@archiver.kernel.org>; Fri, 24 Jul 2026 06:52:51 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 2DC198421C
	for <batman@archiver.kernel.org>; Fri, 24 Jul 2026 08:52:50 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1784875970;
 b=cKdo61Z9XhWe53Zfk1lp0/kyh4MVDQCHFNVtvDIFs0SRysnAdmktMrCLdwCo4xURkrwi1
 1gCSmtoxUxFR4nfJikdRApq1du4pIlMDP3qyMUCAU/5CUi7cQGDDHFvTy4vWgHtsh+fwusA
 NJVTq3jkwHLJWUTc8LCphPesdVjOHSE=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1784875970; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=zhV0nHi+Vm9gVDxUDx0FXlXhn6u36IgNxPfcJJRIxT8=;
 b=XdrtQEx50IZfwthC3ZNhkOnJy2ZH2UVz3ZHDimwF2tZcTpDGp4FnFXKDshIsT/4woeVCS
 hu+oBbzivT2/dBbIQv3PFqKsSIIL8l1cngxgZB9eie0i0f9nOI2XE29249MGBcOSywNHB26
 G1vuOBQd7jtE+vQUoIJQ3H4Oz+Tb+WU=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 1DDAE833D0
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 24 Jul 2026 08:52:01 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1784875921;
	b=nNHnDJIBLTJ/tkI9+eNqzUFSa+rjsC8cnhzyNLUU6k7O2blDuxloHm79ZF5/0fJkg8YzS1
	FT/taQW+jTTomUG73iFe3A2xe2DyGL7gbn8Y/PGpJWpDaVMUOVgcFc1XrGN2DURQCi6HxQ
	SDv3YzU0OWBoLqSDpRzIq2wkvK06CHY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1784875921;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=zhV0nHi+Vm9gVDxUDx0FXlXhn6u36IgNxPfcJJRIxT8=;
	b=RCEtQEEOL0bSialaIxQtpUIWxHvrjk+fDaion66km8J3DkXYVs23lRTqkY8c6O312gMEGm
	YNZj3AXnswLejfnqBH9em1JSD8MVf4SYD3A/l7ARX+j6KI6D3OH6kQCLVi5JsS1YlSN5JB
	Djy5awvtUyzfvWTsJ/3uh4hg9MhPzp4=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=F3zeDmIO;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id A304B1FE7E;
	Fri, 24 Jul 2026 06:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1784875917;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zhV0nHi+Vm9gVDxUDx0FXlXhn6u36IgNxPfcJJRIxT8=;
	b=F3zeDmIOKGIZqHC+DWXaRyzaZ+zXfyTrdUrxOBQ1s4hkEjyKdTn7FMVxs5b/0f7Dy3mxNj
	YDElDCW4Z3cVPdvkkR95EpbSSn334YYT10vfFYoZ+OkGyk+IM9f/Hwylg3YbMJMab7Nk6l
	ah+cw+5a5CzooT012Y5HhneyTo2w7FM=
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 24 Jul 2026 08:51:42 +0200
Subject: [PATCH batadv v3 5/5] batman-adv: limit number of parallel learned
 BLA claims
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260724-resource-limit-v3-5-be845f27ff62@narfation.org>
References: <20260724-resource-limit-v3-0-be845f27ff62@narfation.org>
In-Reply-To: <20260724-resource-limit-v3-0-be845f27ff62@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6394; i=sven@narfation.org;
 h=from:subject:message-id; bh=9+UEUcqWzj2MdLcRrocRANffVjUBmah3VR04P4scv4o=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFnJ3A1TReclzv33ZMrKDRZCMxhKP+96tENR7ab6h+wPE
 eVrO5fM7ihlYRDjYpAVU2TZcyX//Gb2t/Kfp308CjOHlQlkCAMXpwBMRGEvwx/O3RvWpArEs9SJ
 T9W/vXG1pbp6y6uLWzRtT7Sn1q7ybT/P8E/t2dON4nPPn1GfH3klvyAgKKpd1Okrd9YHubZ/ZVK
 KHpwA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: JZGE3Z5OILPOKHK67FEFJA6ENDI3RTAJ
X-Message-ID-Hash: JZGE3Z5OILPOKHK67FEFJA6ENDI3RTAJ
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/JZGE3Z5OILPOKHK67FEFJA6ENDI3RTAJ/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

A malicious actor on the backbone Ethernet may spam the kernel with BLA
claims using a random source MAC address and a valid group ID (local group
ID, or one that exists on the mesh), each of which will create a BLA claim,
a dynamic allocation in the kernel. This will at some point exhaust the
available memory.

Mitigate this by maintaining a per meshif count of those automatically
generated entries in bla.claim_learned, and a limit in
bla.claim_max_learned. If the limit is hit, new entries are not learned
anymore.

For backwards compatibility, the default setting of 0 disables the limit.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 include/uapi/linux/batman_adv.h        |  6 ++++++
 net/batman-adv/bridge_loop_avoidance.c | 21 ++++++++++++++++++---
 net/batman-adv/mesh-interface.c        |  3 +++
 net/batman-adv/netlink.c               | 10 ++++++++++
 net/batman-adv/types.h                 |  6 ++++++
 5 files changed, 43 insertions(+), 3 deletions(-)

diff --git a/include/uapi/linux/batman_adv.h b/include/uapi/linux/batman_adv.h
index 33049818..460e75c4 100644
--- a/include/uapi/linux/batman_adv.h
+++ b/include/uapi/linux/batman_adv.h
@@ -505,6 +505,12 @@ enum batadv_nl_attrs {
 	 */
 	BATADV_ATTR_BLA_BACKBONE_MAX_LEARNED,
 
+	/**
+	 * @BATADV_ATTR_BLA_CLAIM_MAX_LEARNED: defines the maximum number of BLA claims
+	 * which can be learned in parallel
+	 */
+	BATADV_ATTR_BLA_CLAIM_MAX_LEARNED,
+
 	/* add attributes above here, update the policy in netlink.c */
 
 	/**
diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
index 949c887b..d8e7d7ad 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -182,6 +182,7 @@ static void batadv_claim_release(struct kref *ref)
 {
 	struct batadv_bla_backbone_gw *old_backbone_gw;
 	struct batadv_bla_claim *claim;
+	struct batadv_priv *bat_priv;
 
 	claim = container_of(ref, struct batadv_bla_claim, refcount);
 
@@ -194,8 +195,10 @@ static void batadv_claim_release(struct kref *ref)
 	old_backbone_gw->crc ^= crc16(0, claim->addr, ETH_ALEN);
 	spin_unlock_bh(&old_backbone_gw->crc_lock);
 
+	bat_priv = old_backbone_gw->bat_priv;
 	batadv_backbone_gw_put(old_backbone_gw);
 
+	atomic_dec(&bat_priv->bla.claim_learned);
 	kfree_rcu(claim, rcu);
 }
 
@@ -713,6 +716,8 @@ static void batadv_bla_add_claim(struct batadv_priv *bat_priv,
 	struct batadv_bla_backbone_gw *old_backbone_gw;
 	struct batadv_bla_claim search_claim;
 	struct batadv_bla_claim *claim;
+	u32 bla_claim_max_learned;
+	int bla_claim_learned;
 	int hash_added;
 	u16 claim_crc;
 	bool changed;
@@ -724,9 +729,18 @@ static void batadv_bla_add_claim(struct batadv_priv *bat_priv,
 
 	/* create a new claim entry if it does not exist yet. */
 	if (!claim) {
-		claim = kzalloc_obj(*claim, GFP_ATOMIC);
-		if (!claim)
+		bla_claim_max_learned = READ_ONCE(bat_priv->bla.claim_max_learned);
+		bla_claim_learned = atomic_inc_return(&bat_priv->bla.claim_learned);
+		if (bla_claim_max_learned && bla_claim_learned > bla_claim_max_learned) {
+			atomic_dec(&bat_priv->bla.claim_learned);
 			return;
+		}
+
+		claim = kzalloc_obj(*claim, GFP_ATOMIC);
+		if (!claim) {
+			atomic_dec(&bat_priv->bla.claim_learned);
+			return;
+		}
 
 		ether_addr_copy(claim->addr, mac);
 		spin_lock_init(&claim->backbone_lock);
@@ -747,8 +761,9 @@ static void batadv_bla_add_claim(struct batadv_priv *bat_priv,
 					     &claim->hash_entry);
 
 		if (unlikely(hash_added != 0)) {
-			/* only local changes happened. */
 			batadv_backbone_gw_put(backbone_gw);
+			atomic_dec(&bat_priv->bla.claim_learned);
+			/* only local changes happened. */
 			kfree(claim);
 			return;
 		}
diff --git a/net/batman-adv/mesh-interface.c b/net/batman-adv/mesh-interface.c
index 0e313ac8..4d83be55 100644
--- a/net/batman-adv/mesh-interface.c
+++ b/net/batman-adv/mesh-interface.c
@@ -849,6 +849,9 @@ static int batadv_meshif_init_late(struct net_device *dev)
 
 	atomic_set(&bat_priv->bla.backbone_learned, 0);
 	WRITE_ONCE(bat_priv->bla.backbone_max_learned, 0);
+
+	atomic_set(&bat_priv->bla.claim_learned, 0);
+	WRITE_ONCE(bat_priv->bla.claim_max_learned, 0);
 #endif
 	atomic_set(&bat_priv->tp_num, 0);
 
diff --git a/net/batman-adv/netlink.c b/net/batman-adv/netlink.c
index f49d7a5e..f2c7fd8d 100644
--- a/net/batman-adv/netlink.c
+++ b/net/batman-adv/netlink.c
@@ -158,6 +158,7 @@ static const struct nla_policy batadv_netlink_policy[NUM_BATADV_ATTR] = {
 	[BATADV_ATTR_ORIG_MAX_LEARNED]		= { .type = NLA_U32 },
 	[BATADV_ATTR_DAT_MAX_LEARNED]		= { .type = NLA_U32 },
 	[BATADV_ATTR_BLA_BACKBONE_MAX_LEARNED]	= { .type = NLA_U32 },
+	[BATADV_ATTR_BLA_CLAIM_MAX_LEARNED]	= { .type = NLA_U32 },
 };
 
 /**
@@ -305,6 +306,10 @@ static int batadv_netlink_mesh_fill(struct sk_buff *msg,
 	if (nla_put_u32(msg, BATADV_ATTR_BLA_BACKBONE_MAX_LEARNED,
 			READ_ONCE(bat_priv->bla.backbone_max_learned)))
 		goto nla_put_failure;
+
+	if (nla_put_u32(msg, BATADV_ATTR_BLA_CLAIM_MAX_LEARNED,
+			READ_ONCE(bat_priv->bla.claim_max_learned)))
+		goto nla_put_failure;
 #endif /* CONFIG_BATMAN_ADV_BLA */
 
 #ifdef CONFIG_BATMAN_ADV_DAT
@@ -500,6 +505,11 @@ static int batadv_netlink_set_mesh(struct sk_buff *skb, struct genl_info *info)
 		WRITE_ONCE(bat_priv->bla.backbone_max_learned,
 			   nla_get_u32(info->attrs[BATADV_ATTR_BLA_BACKBONE_MAX_LEARNED]));
 	}
+
+	if (info->attrs[BATADV_ATTR_BLA_CLAIM_MAX_LEARNED]) {
+		WRITE_ONCE(bat_priv->bla.claim_max_learned,
+			   nla_get_u32(info->attrs[BATADV_ATTR_BLA_CLAIM_MAX_LEARNED]));
+	}
 #endif /* CONFIG_BATMAN_ADV_BLA */
 
 #ifdef CONFIG_BATMAN_ADV_DAT
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 22d47509..df2d5ccf 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -1077,6 +1077,12 @@ struct batadv_priv_bla {
 	/** @backbone_learned: current number of learned backbone_gw entries */
 	atomic_t backbone_learned;
 
+	/** @claim_max_learned: Maximum number of claims */
+	u32 claim_max_learned;
+
+	/** @claim_learned: current number of learned claim entries */
+	atomic_t claim_learned;
+
 	/**
 	 * @num_requests_lock: locks update num_requests +
 	 * batadv_backbone_gw::state + batadv_backbone_gw::wait_periods update

-- 
2.47.3

