Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1D9606A33D
	for <batman@archiver.kernel.org>; Mon,  2 Nov 2026 21:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=narfation.org header.i=@narfation.org header.a=rsa-sha256 header.s=20121 header.b=lj/Hh52G
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 03F4D81B9D
	for <batman@archiver.kernel.org>; Mon, 02 Nov 2026 22:30:02 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1793655002;
 b=ntjltGUlWHo+EJRewdxaOI163D5usYbfNlwtfVXVITkTbkYM3PayuLI/wg0AtmPi/TX9Z
 iylWND7VzpWdfMPzT1mnkygvoKt46BR36EewAbucDqr5hJqFqSqnaEFdHzJ8K98EgFuw7/l
 jIN3QCgMsAoK1BV8BHL0GvqxTzhTQjs=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1793655002; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=2Ip7HrmTOIscvBhEJhZyKMdu5Oa0tDjNH43kQWEHQik=;
 b=OFk1DcqYyUoMwsC8XLybQC6vpepAAP9Vup5o5rr7or+CZH9C6DnAy4bGF3MUEEOlYK3h1
 5noklVHi6aoEnqXSgiXkfOYo0A7jYCyKsXzINiD52V4IeMeRx11xggBqShICKcgo1WJ7KWU
 PZT58Vf0dV4moWd9X/NCVFSVCcT+bD4=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 66258843B7
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 02 Nov 2026 22:27:16 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1793654836;
	b=T9TTxEZ90xJUWoWnVdOhkwYvhwJ3WoSggmwOurFlOZWdMVUZUlctMibZvMDtw/JElXIpaV
	egrfqaf7LpQS668YV7R2Yk6mj4dZWxCVM6a9LxmkMmRNuYjku+0EbUhpBDjk2DRP5qrH8q
	Kj5VLHRV4vBi5ZnFpBbajoQt1PBb5Fs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1793654836;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=2Ip7HrmTOIscvBhEJhZyKMdu5Oa0tDjNH43kQWEHQik=;
	b=CP8Wgclo0KFtGCHVrdbq3zlp/Y5cY5cVhln0fnwHmHge/n7GRjdAZGED8xx6VzfdVk/Ilw
	wEMF+cY7rvKXMeL50gu0M74ofoNjJUY/UbnIFOffuxq74NtInjV5N9YpLeJvvK62fV+QcI
	X6IKzxNwQtTxfUafTC0YmfYA8G3BqFc=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b="lj/Hh52G";
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id EC1FF1FD51;
	Mon, 02 Nov 2026 21:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1793654836;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2Ip7HrmTOIscvBhEJhZyKMdu5Oa0tDjNH43kQWEHQik=;
	b=lj/Hh52GOb49GIwNUmNj3CfEB6jV111lmlxd2AQCeF3rhmqsyBcklagmgAn1kAtGbTF0hS
	m62ovles5uYxqefDWY2l/YS3uvdyDX8WbUpAKajpLsZpsl5OLuNT6wJo3reEEX0HvKZYfI
	Xykv22PkV92DSh9j4dL77O+HrAOWyTg=
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 02 Nov 2026 22:27:01 +0100
Subject: [PATCH batadv v4 5/5] batman-adv: limit number of parallel learned
 BLA claims
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-resource-limit-v4-5-7ff9da793db4@narfation.org>
References: <20261102-resource-limit-v4-0-7ff9da793db4@narfation.org>
In-Reply-To: <20261102-resource-limit-v4-0-7ff9da793db4@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6409; i=sven@narfation.org;
 h=from:subject:message-id; bh=xHjBS1xOoRLu5+0+ReTi3+4yKu6SxdNMkAFxUrlz0HQ=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFkvGVRdLoTeuK9xmGdxorMNM2OwUZu57fLVTL4HmzfM0
 WOqyP3cUcrCIMbFICumyLLnSv75zexv5T9P+3gUZg4rE8gQBi5OAZhIpzUjw+2KJuanH3t23I96
 o3zo2h2dUA3l3rcCTmv0z9ke2cvM7cPIsHlv3tNlRz0MnGpr556W+BbPXeLxIMFn7hOfe3H2AhY
 PWQE=
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: SCGOOOD4SD5KIPTTQ7VI2CCCEREUB73E
X-Message-ID-Hash: SCGOOOD4SD5KIPTTQ7VI2CCCEREUB73E
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/SCGOOOD4SD5KIPTTQ7VI2CCCEREUB73E/>
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
index 8ab20963..047d5241 100644
--- a/include/uapi/linux/batman_adv.h
+++ b/include/uapi/linux/batman_adv.h
@@ -505,6 +505,12 @@ enum batadv_nl_attrs {
 	 */
 	BATADV_ATTR_BLA_BACKBONE_MAX_LEARNED,
 
+	/**
+	 * @BATADV_ATTR_BLA_CLAIM_MAX_LEARNED: defines the maximum number of BLA claims
+	 * which can be learned in parallel. 0 disables the limit.
+	 */
+	BATADV_ATTR_BLA_CLAIM_MAX_LEARNED,
+
 	/* add attributes above here, update the policy in netlink.c */
 
 	/**
diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
index 6bc847df..11dfa95a 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -181,6 +181,7 @@ static void batadv_claim_release(struct kref *ref)
 {
 	struct batadv_bla_backbone_gw *old_backbone_gw;
 	struct batadv_bla_claim *claim;
+	struct batadv_priv *bat_priv;
 
 	claim = container_of(ref, struct batadv_bla_claim, refcount);
 
@@ -193,8 +194,10 @@ static void batadv_claim_release(struct kref *ref)
 	old_backbone_gw->crc ^= crc16(0, claim->key.addr, ETH_ALEN);
 	spin_unlock_bh(&old_backbone_gw->crc_lock);
 
+	bat_priv = old_backbone_gw->bat_priv;
 	batadv_backbone_gw_put(old_backbone_gw);
 
+	atomic_dec(&bat_priv->bla.claim_learned);
 	kfree_rcu(claim, rcu);
 }
 
@@ -716,6 +719,8 @@ static void batadv_bla_add_claim(struct batadv_priv *bat_priv,
 	struct batadv_bla_backbone_gw *old_backbone_gw;
 	struct batadv_bla_claim_key claim_key;
 	struct batadv_bla_claim *claim;
+	u32 bla_claim_max_learned;
+	int bla_claim_learned;
 	int hash_added;
 	u16 claim_crc;
 	bool changed;
@@ -727,9 +732,18 @@ static void batadv_bla_add_claim(struct batadv_priv *bat_priv,
 
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
 
 		ether_addr_copy(claim->key.addr, mac);
 		claim->key.vid = vid;
@@ -750,8 +764,9 @@ static void batadv_bla_add_claim(struct batadv_priv *bat_priv,
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
index 52fe4cfa..d74f1e5d 100644
--- a/net/batman-adv/mesh-interface.c
+++ b/net/batman-adv/mesh-interface.c
@@ -876,6 +876,9 @@ static int batadv_meshif_init_late(struct net_device *dev)
 
 	atomic_set(&bat_priv->bla.backbone_learned, 0);
 	WRITE_ONCE(bat_priv->bla.backbone_max_learned, 0);
+
+	atomic_set(&bat_priv->bla.claim_learned, 0);
+	WRITE_ONCE(bat_priv->bla.claim_max_learned, 0);
 #endif
 	atomic_set(&bat_priv->tp_num, 0);
 
diff --git a/net/batman-adv/netlink.c b/net/batman-adv/netlink.c
index 5535f1cb..6c583e9e 100644
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
index 8ab84456..0538189c 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -1107,6 +1107,12 @@ struct batadv_priv_bla {
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

