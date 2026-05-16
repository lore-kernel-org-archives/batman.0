Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F8EBCD4F21
	for <batman@archiver.kernel.org>; Sat, 16 May 2026 12:39:55 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id F207985ECD
	for <batman@archiver.kernel.org>; Sat, 16 May 2026 14:39:53 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1778935193;
 b=OFyjfyBshVWYPX3a/SiNugD+qN6NV8WJLgDxU4MYkhXgeovOH7EsmniUmJdo1OlDbfw01
 c93oQr11K6roQPFS+G06HL951xwMTRQ76fOfnrDdr4OzhDdFA9SnTbbpM0O+0MdZTCGwW+w
 A/LSt4DDdctRNGiwW7tzETL3Hz9VMZ8=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1778935193; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=6Lyxicns0jWSnZ1CvxckyFCRnx1gDYpO2zZkXm8lSkI=;
 b=2DAf0pt0h28pivRbHYpp075dQsiGawyCzH26KsT+kmneFM6vcOL6NszsunQhYQ9PD9O7F
 oOo2kTiFiPPk5xDxE9m8kI1ZhnE8AJ53WjZ0IATM4ViTxkl4lgUTT16/dBPbrSp1ZQ1YCjW
 g6mcVM/s1ckWLYdCRzKGU8ErkKm8ch4=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 518B985DEF
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sat, 16 May 2026 14:36:00 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1778934960;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=6Lyxicns0jWSnZ1CvxckyFCRnx1gDYpO2zZkXm8lSkI=;
	b=feJlYyAqJ8c1TMZBjDan4IyIP2YO6yQ8aIZb91T1jVvvMCxy7PKsGSqK0oH2cJMHazFMVs
	xhe80wVdFc8ZxipfmkUK/QuOBz+Gb4wz0iyMobjv78g4ss5E/uLSDjrntCMsfZjErpkLPS
	i0M8K0Isuh+OIhEN4oX6r/fNEk1EjsU=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=XTSOTYce;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1778934960;
	b=jrgFI9NsipAox2TDSoWW5ze+kRQraXBL63BS78X9lqUv7vOitRwZp3R9SOPuzs3xpyrqnv
	snfEO1T8DHj9oyBwTCbJpuHF1J2WLD461WDphhjMG7t7r2zgQyYzA3Y9vDqVcyBpTKEfn+
	QkzYcnh6pBpr8shJsj+qbT0Rnip/mOY=
Received: by dvalin.narfation.org (Postfix) id E603020101;
	Sat, 16 May 2026 12:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1778934960;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6Lyxicns0jWSnZ1CvxckyFCRnx1gDYpO2zZkXm8lSkI=;
	b=XTSOTYceWBeoExTa0LfHztCD1i5NqeA7jcupypji4FFKFljKlxf5nVUTgi0LVUjPKtoMmg
	1CxawHobUQzGA0tkPRsdAsQrWAnansTri+O7VEqFHTDAmlo851z6E5bqX3bj+dwqzpBgWo
	swP9CLN0C91XzmO7S2kx4Eq0w/Vcs4g=
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 16 May 2026 14:35:22 +0200
Subject: [PATCH RFC batadv 5/5] batman-adv: limit numbers of parallel
 learned BLA claims
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260516-resource-limit-v1-5-6f597360ed2b@narfation.org>
References: <20260516-resource-limit-v1-0-6f597360ed2b@narfation.org>
In-Reply-To: <20260516-resource-limit-v1-0-6f597360ed2b@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5948; i=sven@narfation.org;
 h=from:subject:message-id; bh=r0LMBfdU3ruRh3kVuX0f23K40CnK91t0klvuXmeTZ3g=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFkcKd2z2XOPX7yygSFhUam007fU8JbWnuWKU6u+39Bgd
 3ba/dqgo5SFQYyLQVZMkWXPlfzzm9nfyn+e9vEozBxWJpAhDFycAjCR3puMDBeUqqwnT6tSnjRV
 N+BX0x0VpiWx/468/Oa3YX3tXCX7dUyMDC8Yvl9Wm2xrHKLK+1cq2evwBQ/H2lm1Ros6dXTPTvR
 W5wIA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: XMTAWYYCHKHMWJC6N3RYF7GQNUNCUVAI
X-Message-ID-Hash: XMTAWYYCHKHMWJC6N3RYF7GQNUNCUVAI
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/XMTAWYYCHKHMWJC6N3RYF7GQNUNCUVAI/>
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
index c8976da5..6ecc34e1 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -1680,6 +1680,12 @@ struct batadv_priv {
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

