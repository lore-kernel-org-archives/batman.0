Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1130C531C9
	for <batman@archiver.kernel.org>; Fri, 24 Jul 2026 06:55:52 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 1BE13842AA
	for <batman@archiver.kernel.org>; Fri, 24 Jul 2026 08:55:51 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1784876151;
 b=MIwlI3PiLGkCoRBgWoaXT9sCFTAP+EMinxBCxNCx6yTJpCYVKXwgIFWm/KVO8SP3+ASHu
 vZMaIznaohn2GlBtYuzCRFqZR8t7mGMlvFSnAppmgKzYXnnzrijs0YCCmjUDepcMC5iIlzB
 TFa3l/n6ofjPK8zM/fV1eD4WYy595wU=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1784876151; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=H30WaBKHfckHHG46pbn93gZ6Dh17ld50nnv8MrocgA0=;
 b=n5dqWXudBcMTjKRd9btWk2gCBbvWYhg8zmkp+AajxFx0ryeWBOwOOMvgk7S+VlNUYfbBw
 m0eN9+gTN5jfHEF904s/5ynjWU9sBU8R4YoGj4gU3nKVlPFSQMVArAj07J5F1Od/f21nxVi
 d9UcfOjnpZZO7M/p1hVNoP5xYzOPpXA=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 31F4B84038
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 24 Jul 2026 08:51:56 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1784875926;
	b=gZnrOI7drjGggbNNAqGC2S1mozf7lWYnl5ZtHhJw0kiCqAW+GQR578oLoj5cjwsHS/jTjy
	v46mFp+WlblHdGzEbFSb2cDKgY7brar26AKV65QWqoyfS67fhbFuXZJZQp3xW9lZcPAfpa
	J7gzVVaqx88aYTg+ksi+EXfRM9BJhGU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1784875926;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=H30WaBKHfckHHG46pbn93gZ6Dh17ld50nnv8MrocgA0=;
	b=KBrfrP+Y9INFelxUb2F8vIqxd0GFc+1UtScVDsLJNZum7YuchllLu5KmuWm6mP0pzkuELg
	fvQk6/mUBJb32/NUpQsk/NN3L6zkQltTczOdNrdX66bw6c/lyx7DAAsD/HveafrU4mIz5p
	ns63fXvj0f3V9gFsQ/2+Q0z0/GrIR94=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=TrB+C02X;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id C785A20551;
	Fri, 24 Jul 2026 06:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1784875915;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H30WaBKHfckHHG46pbn93gZ6Dh17ld50nnv8MrocgA0=;
	b=TrB+C02XQpC/qY2z8haa/z3z+AVY1L80U4yg7knoX7eJ3DNs5h5F7LfoP1nbnks0PD2LJR
	FIvYs2+rg6jM/rOddSKiS2U8L2gbeYyp1tIrL0dM+/Aly+StfxNpWwsSkUTxNMHl/gKNog
	kfhM9L2OYEk8rAenRDQn5gBHYpwNI/Q=
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 24 Jul 2026 08:51:41 +0200
Subject: [PATCH batadv v3 4/5] batman-adv: limit number of parallel learned
 BLA backbones
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260724-resource-limit-v3-4-be845f27ff62@narfation.org>
References: <20260724-resource-limit-v3-0-be845f27ff62@narfation.org>
In-Reply-To: <20260724-resource-limit-v3-0-be845f27ff62@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6503; i=sven@narfation.org;
 h=from:subject:message-id; bh=DOcRVFdpq0Y6ozSwCsPgC7/yFawGlubGY8ihB+eVpSw=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFnJ3A1ZJtYBxbNfLmhdO1fzwSvP4xyix6LCf20VvqzTe
 b1ePGBpRykLgxgXg6yYIsueK/nnN7O/lf887eNRmDmsTCBDGLg4BWAirzcx/E9PkGjw6Ch6xqDE
 5b+J/czlk/u+Ovzb7KFtM/W/uNnBBemMDMu57wdLh0pNeLbq0dQMxRg/548n9S0/L5h0Un7z6pM
 cyxgB
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: TDYWFNQ2L64RRTLI27LGDE3XUU2EPOSP
X-Message-ID-Hash: TDYWFNQ2L64RRTLI27LGDE3XUU2EPOSP
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/TDYWFNQ2L64RRTLI27LGDE3XUU2EPOSP/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

A malicious actor on the backbone Ethernet may spam the kernel with BLA
announcements using a random source MAC address and a valid group ID (local
group ID, or one that exists on the mesh), each of which will create a BLA
backbone, a dynamic allocation in the kernel. This will at some point
exhaust the available memory.

Mitigate this by maintaining a per meshif count of those automatically
generated entries in bla.backbone_learned, and a limit in
bla.backbone_max_learned. If the limit is hit, new entries are not learned
anymore.

For backwards compatibility, the default setting of 0 disables the limit.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 include/uapi/linux/batman_adv.h        |  6 ++++++
 net/batman-adv/bridge_loop_avoidance.c | 25 ++++++++++++++++++++++++-
 net/batman-adv/mesh-interface.c        |  3 +++
 net/batman-adv/netlink.c               | 10 ++++++++++
 net/batman-adv/types.h                 |  9 +++++++++
 5 files changed, 52 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/batman_adv.h b/include/uapi/linux/batman_adv.h
index 184f2bc8..33049818 100644
--- a/include/uapi/linux/batman_adv.h
+++ b/include/uapi/linux/batman_adv.h
@@ -499,6 +499,12 @@ enum batadv_nl_attrs {
 	 */
 	BATADV_ATTR_DAT_MAX_LEARNED,
 
+	/**
+	 * @BATADV_ATTR_BLA_BACKBONE_MAX_LEARNED: defines the maximum number of BLA backbones
+	 * which can be learned in parallel
+	 */
+	BATADV_ATTR_BLA_BACKBONE_MAX_LEARNED,
+
 	/* add attributes above here, update the policy in netlink.c */
 
 	/**
diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
index f231afbe..949c887b 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -154,6 +154,9 @@ static void batadv_backbone_gw_release(struct kref *ref)
 	backbone_gw = container_of(ref, struct batadv_bla_backbone_gw,
 				   refcount);
 
+	if (!backbone_gw->own)
+		atomic_dec(&backbone_gw->bat_priv->bla.backbone_learned);
+
 	kfree_rcu(backbone_gw, rcu);
 }
 
@@ -488,6 +491,8 @@ batadv_bla_get_backbone_gw(struct batadv_priv *bat_priv, const u8 *orig,
 {
 	struct batadv_bla_backbone_gw *entry;
 	struct batadv_orig_node *orig_node;
+	u32 bla_backbone_max_learned;
+	int bla_backbone_learned;
 	int hash_added;
 
 	entry = batadv_backbone_hash_find(bat_priv, orig, vid);
@@ -499,11 +504,25 @@ batadv_bla_get_backbone_gw(struct batadv_priv *bat_priv, const u8 *orig,
 		   "%s(): not found (%pM, %d), creating new entry\n", __func__,
 		   orig, batadv_print_vid(vid));
 
+	if (!own_backbone) {
+		bla_backbone_max_learned = READ_ONCE(bat_priv->bla.backbone_max_learned);
+		bla_backbone_learned = atomic_inc_return(&bat_priv->bla.backbone_learned);
+		if (bla_backbone_max_learned && bla_backbone_learned > bla_backbone_max_learned) {
+			atomic_dec(&bat_priv->bla.backbone_learned);
+			return NULL;
+		}
+	}
+
 	entry = kzalloc_obj(*entry, GFP_ATOMIC);
-	if (!entry)
+	if (!entry) {
+		if (!own_backbone)
+			atomic_dec(&bat_priv->bla.backbone_learned);
+
 		return NULL;
+	}
 
 	entry->vid = vid;
+	entry->own = own_backbone;
 	WRITE_ONCE(entry->lasttime, jiffies);
 	entry->crc = BATADV_BLA_CRC_INIT;
 	entry->bat_priv = bat_priv;
@@ -523,6 +542,10 @@ batadv_bla_get_backbone_gw(struct batadv_priv *bat_priv, const u8 *orig,
 	if (unlikely(hash_added != 0)) {
 		/* hash failed, free the structure */
 		kfree(entry);
+
+		if (!own_backbone)
+			atomic_dec(&bat_priv->bla.backbone_learned);
+
 		return NULL;
 	}
 
diff --git a/net/batman-adv/mesh-interface.c b/net/batman-adv/mesh-interface.c
index a34fdd41..0e313ac8 100644
--- a/net/batman-adv/mesh-interface.c
+++ b/net/batman-adv/mesh-interface.c
@@ -846,6 +846,9 @@ static int batadv_meshif_init_late(struct net_device *dev)
 #ifdef CONFIG_BATMAN_ADV_BLA
 	atomic_set(&bat_priv->bla.num_requests, 0);
 	spin_lock_init(&bat_priv->bla.num_requests_lock);
+
+	atomic_set(&bat_priv->bla.backbone_learned, 0);
+	WRITE_ONCE(bat_priv->bla.backbone_max_learned, 0);
 #endif
 	atomic_set(&bat_priv->tp_num, 0);
 
diff --git a/net/batman-adv/netlink.c b/net/batman-adv/netlink.c
index d146d7c7..f49d7a5e 100644
--- a/net/batman-adv/netlink.c
+++ b/net/batman-adv/netlink.c
@@ -157,6 +157,7 @@ static const struct nla_policy batadv_netlink_policy[NUM_BATADV_ATTR] = {
 	[BATADV_ATTR_NEIGH_MAX_LEARNED]		= { .type = NLA_U32 },
 	[BATADV_ATTR_ORIG_MAX_LEARNED]		= { .type = NLA_U32 },
 	[BATADV_ATTR_DAT_MAX_LEARNED]		= { .type = NLA_U32 },
+	[BATADV_ATTR_BLA_BACKBONE_MAX_LEARNED]	= { .type = NLA_U32 },
 };
 
 /**
@@ -300,6 +301,10 @@ static int batadv_netlink_mesh_fill(struct sk_buff *msg,
 	if (nla_put_u8(msg, BATADV_ATTR_BRIDGE_LOOP_AVOIDANCE_ENABLED,
 		       !!READ_ONCE(bat_priv->bridge_loop_avoidance)))
 		goto nla_put_failure;
+
+	if (nla_put_u32(msg, BATADV_ATTR_BLA_BACKBONE_MAX_LEARNED,
+			READ_ONCE(bat_priv->bla.backbone_max_learned)))
+		goto nla_put_failure;
 #endif /* CONFIG_BATMAN_ADV_BLA */
 
 #ifdef CONFIG_BATMAN_ADV_DAT
@@ -490,6 +495,11 @@ static int batadv_netlink_set_mesh(struct sk_buff *skb, struct genl_info *info)
 			   !!nla_get_u8(attr));
 		batadv_bla_status_update(bat_priv->mesh_iface);
 	}
+
+	if (info->attrs[BATADV_ATTR_BLA_BACKBONE_MAX_LEARNED]) {
+		WRITE_ONCE(bat_priv->bla.backbone_max_learned,
+			   nla_get_u32(info->attrs[BATADV_ATTR_BLA_BACKBONE_MAX_LEARNED]));
+	}
 #endif /* CONFIG_BATMAN_ADV_BLA */
 
 #ifdef CONFIG_BATMAN_ADV_DAT
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 6001273b..22d47509 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -1071,6 +1071,12 @@ struct batadv_priv_bla {
 	/** @num_requests: number of bla requests in flight */
 	atomic_t num_requests;
 
+	/** @backbone_max_learned: Maximum number of backbone_gw */
+	u32 backbone_max_learned;
+
+	/** @backbone_learned: current number of learned backbone_gw entries */
+	atomic_t backbone_learned;
+
 	/**
 	 * @num_requests_lock: locks update num_requests +
 	 * batadv_backbone_gw::state + batadv_backbone_gw::wait_periods update
@@ -1791,6 +1797,9 @@ struct batadv_bla_backbone_gw {
 	/** @vid: vlan id this gateway was detected on */
 	unsigned short vid;
 
+	/** @own: it is the local backbone gateway */
+	bool own:1;
+
 	/** @hash_entry: hlist node for &batadv_priv_bla.backbone_hash */
 	struct hlist_node hash_entry;
 

-- 
2.47.3

