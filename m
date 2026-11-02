Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E225C606A32C
	for <batman@archiver.kernel.org>; Mon,  2 Nov 2026 21:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=narfation.org header.i=@narfation.org header.a=rsa-sha256 header.s=20121 header.b=E6Z3/sye
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 8B0F480517
	for <batman@archiver.kernel.org>; Mon, 02 Nov 2026 22:29:26 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1793654966;
 b=jX8AH9DNxO+32OVidz7EgrwZLwau9ZU1PE+SPNw0TtcBpGiqrlEMwYvo1iqEhnpGnO5wZ
 BEDtAhiFOm4HR6qiPNoJI5x5DRs7nblqMG0bG79fcADh7F3KfDDy+tMfAK1zqEv4DxlhvAP
 ypyLMg/W51yT1riHPNKZIC1byI6/3Y8=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1793654966; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=o92tsGfc7hctSH3kISN63FummBGNQY8atnzLEUyloIk=;
 b=fC5GE3MO9nXTFy+4DiW/WqG+stNy9tuJoMXc0lPYLMpMCBMmczzjPXZ4tvcuc52lm54mU
 3iC7MaXIpYKpsRYF7RDOYW0N5F9STh5+wZqK7w+WtxWomkrVGtQbbs8HCOZaNseDU7YSFsv
 wjSeOx6ag3AEGVEPvLIcw+cMJLybIPI=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id B558182DCF
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 02 Nov 2026 22:27:13 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1793654833;
	b=wbRO+rMlBN/g4oge1pMVAeC32AMqm5ZqRGouqjMEED2v70ehkCp35KktO9k9bxPFWPNF2j
	X0ZnqbkpMsBhHZbvXoZ94uLMQgq4UCIDUQ2TUQBHRXEIWArJp7VUGq5P7hf3FHZBFDCMMU
	pL2V4atyLJVyseHcrTowZ9YplSEEiSM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1793654833;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=o92tsGfc7hctSH3kISN63FummBGNQY8atnzLEUyloIk=;
	b=35eduxza+pGI0rvEwZRC0R3fO7SIEuK3amdyD0sqXOqFru0x522joRbR/GA1jvJWRbXU3/
	elTuibME7YCPVsOhIFT0wW632gJnDQYYSL49EmkG1zoUq36p7G1V3uUbQTAB4UBHzMIrcX
	pDFrnsaAnhvDGRzJm9uzcCx7NftyyqE=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b="E6Z3/sye";
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 695941FD51;
	Mon, 02 Nov 2026 21:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1793654833;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o92tsGfc7hctSH3kISN63FummBGNQY8atnzLEUyloIk=;
	b=E6Z3/syehdWkCvj3VWTz46sUQ8G5Vbo+qzVck9dDBTjEeJCi6NnnsCEu9EiGgWBQZdHmAW
	nEv/I1SFpgJL3fqYm4qcg7mXCA3PEqI8v9kpw2LiLVhorXdbtkgRQ9RCOu4/8pdQP5UBCH
	n0uK3KxsB1rIe8nR3IVJ1R5HGWwGcL4=
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 02 Nov 2026 22:27:00 +0100
Subject: [PATCH batadv v4 4/5] batman-adv: limit number of parallel learned
 BLA backbones
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-resource-limit-v4-4-7ff9da793db4@narfation.org>
References: <20261102-resource-limit-v4-0-7ff9da793db4@narfation.org>
In-Reply-To: <20261102-resource-limit-v4-0-7ff9da793db4@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6554; i=sven@narfation.org;
 h=from:subject:message-id; bh=WaXYwdFJj2Iknti8LL6aYlGD11CULMC/UCNO8Ry1hFQ=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFkvGVR91x+w6ljycI7P6uxm86bnicczHoQHLFvHs6DnD
 nMjo8X7jlIWBjEuBlkxRZY9V/LPb2Z/K/952sejMHNYmUCGMHBxCsBEmKwYGfY2Bv9i0o6OZLr/
 IUFZ4eJ8tS1l8WkhDxfdn9h7c6/3DRdGhl63tzaORwvO7Xjw+fWpaIHnpuWpRSWVXJOZrjekr3H
 YzgcA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: QZ4WDO4AYJWYLWS5AV7X2I3DZQHCQWL2
X-Message-ID-Hash: QZ4WDO4AYJWYLWS5AV7X2I3DZQHCQWL2
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/QZ4WDO4AYJWYLWS5AV7X2I3DZQHCQWL2/>
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
index 8cbdd384..8ab20963 100644
--- a/include/uapi/linux/batman_adv.h
+++ b/include/uapi/linux/batman_adv.h
@@ -499,6 +499,12 @@ enum batadv_nl_attrs {
 	 */
 	BATADV_ATTR_DAT_MAX_LEARNED,
 
+	/**
+	 * @BATADV_ATTR_BLA_BACKBONE_MAX_LEARNED: defines the maximum number of BLA backbones
+	 * which can be learned in parallel. 0 disables the limit.
+	 */
+	BATADV_ATTR_BLA_BACKBONE_MAX_LEARNED,
+
 	/* add attributes above here, update the policy in netlink.c */
 
 	/**
diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
index 68ff2f94..6bc847df 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -153,6 +153,9 @@ static void batadv_backbone_gw_release(struct kref *ref)
 	backbone_gw = container_of(ref, struct batadv_bla_backbone_gw,
 				   refcount);
 
+	if (!backbone_gw->own)
+		atomic_dec(&backbone_gw->bat_priv->bla.backbone_learned);
+
 	kfree_rcu(backbone_gw, rcu);
 }
 
@@ -490,6 +493,8 @@ batadv_bla_get_backbone_gw(struct batadv_priv *bat_priv, const u8 *orig,
 {
 	struct batadv_bla_backbone_gw *entry;
 	struct batadv_orig_node *orig_node;
+	u32 bla_backbone_max_learned;
+	int bla_backbone_learned;
 	int hash_added;
 
 	entry = batadv_backbone_hash_find(bat_priv, orig, vid);
@@ -501,11 +506,25 @@ batadv_bla_get_backbone_gw(struct batadv_priv *bat_priv, const u8 *orig,
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
 
 	entry->key.vid = vid;
+	entry->own = own_backbone;
 	WRITE_ONCE(entry->lasttime, jiffies);
 	entry->crc = BATADV_BLA_CRC_INIT;
 	entry->bat_priv = bat_priv;
@@ -525,6 +544,10 @@ batadv_bla_get_backbone_gw(struct batadv_priv *bat_priv, const u8 *orig,
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
index e21c0d10..52fe4cfa 100644
--- a/net/batman-adv/mesh-interface.c
+++ b/net/batman-adv/mesh-interface.c
@@ -873,6 +873,9 @@ static int batadv_meshif_init_late(struct net_device *dev)
 #ifdef CONFIG_BATMAN_ADV_BLA
 	atomic_set(&bat_priv->bla.num_requests, 0);
 	spin_lock_init(&bat_priv->bla.num_requests_lock);
+
+	atomic_set(&bat_priv->bla.backbone_learned, 0);
+	WRITE_ONCE(bat_priv->bla.backbone_max_learned, 0);
 #endif
 	atomic_set(&bat_priv->tp_num, 0);
 
diff --git a/net/batman-adv/netlink.c b/net/batman-adv/netlink.c
index 12650156..5535f1cb 100644
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
index 4b42160e..8ab84456 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -1101,6 +1101,12 @@ struct batadv_priv_bla {
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
@@ -1827,6 +1833,9 @@ struct batadv_bla_backbone_gw {
 	/** @key: hash key identifying the backbone gateway */
 	struct batadv_bla_backbone_gw_key key;
 
+	/** @own: it is the local backbone gateway */
+	bool own:1;
+
 	/** @hash_entry: hlist node for &batadv_priv_bla.backbone_hash */
 	struct hlist_node hash_entry;
 

-- 
2.47.3

