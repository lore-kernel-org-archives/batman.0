Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98A50CD4F58
	for <batman@archiver.kernel.org>; Tue, 19 May 2026 07:09:18 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 50147810DE
	for <batman@archiver.kernel.org>; Tue, 19 May 2026 09:08:39 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1779174519;
 b=QrQBHL1Tzl2kBIbRMvDE9ZoHWmvwPD1WCvBBOye2VZVF1opY5Qrk6H3HcPgsDXR/g+ByM
 OBdZx7XLhp9hBod6R6DpmuaoWBkexdpOD2eGqO4RzascVMRr4TOQSKTDL4/AetENl+6EamK
 ueEtt4PrgMSXS6G7REzHrUmDunZj+/A=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1779174519; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=/HNckXLlYzCvSOP7k5kmv/b5MNXmeiasrq4UUatl18I=;
 b=JLYxwsi3ppCneMC44NqhrHmqlziss1B92WIx/Yij78XXA6/aXeWM8NyNKa30mTj0/3t7i
 LVMw+e3tzawFYECkFdrVcgv39kBhgHpYOMuyq7SVI66n1PgTOlFb8l9fxb2oisSKbBdE5UT
 axrkSvNjD3e76odQ6dMkg/IYCnOg+hM=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 3E09580C1F
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 19 May 2026 09:02:44 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1779174164;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=/HNckXLlYzCvSOP7k5kmv/b5MNXmeiasrq4UUatl18I=;
	b=oxqpgpwIi8u4RrxVXdmYbuP73sft+l4QnwcZc7vCsmmSrI60Flx3LPfG7s/k/x56YDBd+h
	zekIRU2dUJ0ROBDdbpXFKjoAvsq/Q020SVAWwb8TuHuhEdZ02fgTv0j3b950gm8qUBpvDQ
	jp3j97yzzZeW4jEjKFrLa+sIynu/vo4=
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1779174164;
	b=mOmOVMzZdoL+vEtLdIT27U8QfZVTc7I4U1klB/uRTAUWbXiZHlCoP9zZp+T9U6yseB1/xG
	gnnQEkeaE6Z65Ds32uU7KjWXQd6utZyZveBLiz96+PgNMPuli3kDS8PxaRBGzl4WNW1AQf
	dCnWVxRpiH1+DH6k0HOANGLNBhdK0/A=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=zgOP5zcd;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 6AC691FE24;
	Tue, 19 May 2026 07:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1779174163;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/HNckXLlYzCvSOP7k5kmv/b5MNXmeiasrq4UUatl18I=;
	b=zgOP5zcdePBjO+K1/vTsiyw7aGdfznHd0Z5m1UKHa79S6sqClkPl1tzY0Isuuk66P7YPks
	FEJmGWojpzAU5iALMjCsNB6AsTiG5BKVCb001QWzdXuF51a8pTKDDdSztWEjtbkACo0czv
	xnrVOBzD15K52l8pjJTMx5XTopFCvfQ=
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 19 May 2026 09:02:19 +0200
Subject: [PATCH RFC batadv v2 5/5] batman-adv: limit numbers of parallel
 learned BLA claims
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-resource-limit-v2-5-489c3c919a54@narfation.org>
References: <20260519-resource-limit-v2-0-489c3c919a54@narfation.org>
In-Reply-To: <20260519-resource-limit-v2-0-489c3c919a54@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5948; i=sven@narfation.org;
 h=from:subject:message-id; bh=wvABgStmvWkeRpqcE126MHLazwSXarg1BjWdJ180jVk=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFk8XD/tdkowPHjfNntvvvPfKPFfbvszrsyN3vPsvMPfs
 +eEXiff7ShlYRDjYpAVU2TZcyX//Gb2t/Kfp308CjOHlQlkCAMXpwBMZMI8RoY9XPv9xBouvuqz
 cuBJzvx54qXdm91XNO+/srTbKBgWeWcfI0Pr7ConlSfPXfpd62XmX3dVOrDCul/nzn6Gry8z2No
 mirIDAA==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: 65U4ZFP7LENLG2A2VP4HPDHQQ6FTBWJ3
X-Message-ID-Hash: 65U4ZFP7LENLG2A2VP4HPDHQQ6FTBWJ3
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/65U4ZFP7LENLG2A2VP4HPDHQQ6FTBWJ3/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

A malicious actor behind one bridge port may spam the kernel with OGMs with
a random source MAC address, each of which will create a BLA claim, each of
which is a dynamic allocation in the kernel. This will at some point
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
index 4188d83c..65d1c0eb 100644
--- a/include/uapi/linux/batman_adv.h
+++ b/include/uapi/linux/batman_adv.h
@@ -505,6 +505,12 @@ enum batadv_nl_attrs {
 	 */
 	BATADV_ATTR_BLA_BACKBONE_MAX_LEARNED,
 
+	/**
+	 * @BATADV_ATTR_BLA_CLAIM_MAX_LEARNED: defines the maximum number of BLA claim
+	 * which can be learned in parallel
+	 */
+	BATADV_ATTR_BLA_CLAIM_MAX_LEARNED,
+
 	/* add attributes above here, update the policy in netlink.c */
 
 	/**
diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
index 8bb8dec6..f39b02f9 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -320,6 +320,7 @@ batadv_bla_del_backbone_claims(struct batadv_bla_backbone_gw *backbone_gw)
 
 			hlist_del_rcu(&claim->hash_entry);
 			batadv_claim_put(claim);
+			atomic_dec(&backbone_gw->bat_priv->bla_claim_learned);
 		}
 		spin_unlock_bh(list_lock);
 	}
@@ -700,7 +701,9 @@ static void batadv_bla_add_claim(struct batadv_priv *bat_priv,
 	struct batadv_bla_backbone_gw *old_backbone_gw;
 	struct batadv_bla_claim *claim;
 	struct batadv_bla_claim search_claim;
+	u32 bla_claim_max_learned;
 	bool remove_crc = false;
+	int bla_claim_learned;
 	int hash_added;
 
 	ether_addr_copy(search_claim.addr, mac);
@@ -709,6 +712,11 @@ static void batadv_bla_add_claim(struct batadv_priv *bat_priv,
 
 	/* create a new claim entry if it does not exist yet. */
 	if (!claim) {
+		bla_claim_max_learned = READ_ONCE(bat_priv->bla_claim_max_learned);
+		bla_claim_learned = atomic_read(&bat_priv->bla_claim_learned);
+		if (bla_claim_max_learned && bla_claim_learned >= bla_claim_max_learned)
+			return;
+
 		claim = kzalloc_obj(*claim, GFP_ATOMIC);
 		if (!claim)
 			return;
@@ -721,6 +729,8 @@ static void batadv_bla_add_claim(struct batadv_priv *bat_priv,
 		claim->backbone_gw = backbone_gw;
 		kref_init(&claim->refcount);
 
+		atomic_inc(&bat_priv->bla_claim_learned);
+
 		batadv_dbg(BATADV_DBG_BLA, bat_priv,
 			   "%s(): adding new entry %pM, vid %d to hash ...\n",
 			   __func__, mac, batadv_print_vid(vid));
@@ -735,6 +745,7 @@ static void batadv_bla_add_claim(struct batadv_priv *bat_priv,
 			/* only local changes happened. */
 			batadv_backbone_gw_put(backbone_gw);
 			kfree(claim);
+			atomic_dec(&bat_priv->bla_claim_learned);
 			return;
 		}
 	} else {
diff --git a/net/batman-adv/mesh-interface.c b/net/batman-adv/mesh-interface.c
index 1594a2d6..8fd47cef 100644
--- a/net/batman-adv/mesh-interface.c
+++ b/net/batman-adv/mesh-interface.c
@@ -793,6 +793,9 @@ static int batadv_meshif_init_late(struct net_device *dev)
 
 	atomic_set(&bat_priv->bla_backbone_learned, 0);
 	WRITE_ONCE(bat_priv->bla_backbone_max_learned, 0);
+
+	atomic_set(&bat_priv->bla_claim_learned, 0);
+	WRITE_ONCE(bat_priv->bla_claim_max_learned, 0);
 #endif
 	atomic_set(&bat_priv->tp_num, 0);
 
diff --git a/net/batman-adv/netlink.c b/net/batman-adv/netlink.c
index 5d4bccdc..8cafbac5 100644
--- a/net/batman-adv/netlink.c
+++ b/net/batman-adv/netlink.c
@@ -151,6 +151,7 @@ static const struct nla_policy batadv_netlink_policy[NUM_BATADV_ATTR] = {
 	[BATADV_ATTR_ORIG_MAX_LEARNED]		= { .type = NLA_U32 },
 	[BATADV_ATTR_DAT_MAX_LEARNED]		= { .type = NLA_U32 },
 	[BATADV_ATTR_BLA_BACKBONE_MAX_LEARNED]	= { .type = NLA_U32 },
+	[BATADV_ATTR_BLA_CLAIM_MAX_LEARNED]	= { .type = NLA_U32 },
 };
 
 /**
@@ -298,6 +299,10 @@ static int batadv_netlink_mesh_fill(struct sk_buff *msg,
 	if (nla_put_u32(msg, BATADV_ATTR_BLA_BACKBONE_MAX_LEARNED,
 			READ_ONCE(bat_priv->bla_backbone_max_learned)))
 		goto nla_put_failure;
+
+	if (nla_put_u32(msg, BATADV_ATTR_BLA_CLAIM_MAX_LEARNED,
+			READ_ONCE(bat_priv->bla_claim_max_learned)))
+		goto nla_put_failure;
 #endif /* CONFIG_BATMAN_ADV_BLA */
 
 #ifdef CONFIG_BATMAN_ADV_DAT
@@ -493,6 +498,11 @@ static int batadv_netlink_set_mesh(struct sk_buff *skb, struct genl_info *info)
 		WRITE_ONCE(bat_priv->bla_backbone_max_learned,
 			   nla_get_u32(info->attrs[BATADV_ATTR_BLA_BACKBONE_MAX_LEARNED]));
 	}
+
+	if (info->attrs[BATADV_ATTR_BLA_CLAIM_MAX_LEARNED]) {
+		WRITE_ONCE(bat_priv->bla_claim_max_learned,
+			   nla_get_u32(info->attrs[BATADV_ATTR_BLA_CLAIM_MAX_LEARNED]));
+	}
 #endif /* CONFIG_BATMAN_ADV_BLA */
 
 #ifdef CONFIG_BATMAN_ADV_DAT
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index c091b19e..ddd9f1e0 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -1662,6 +1662,12 @@ struct batadv_priv {
 	/** @bla_backbone_learned: current number of learned backbone_gw entries */
 	atomic_t bla_backbone_learned;
 
+	/** @bla_claim_max_learned: Maximum number of claim */
+	u32 bla_claim_max_learned;
+
+	/** @bla_claim_learned: current number of learned claim entries */
+	atomic_t bla_claim_learned;
+
 	/** @bla: bridge loop avoidance data */
 	struct batadv_priv_bla bla;
 #endif

-- 
2.47.3

