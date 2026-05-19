Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 367BACD4F3C
	for <batman-adv@archiver.kernel.org>; Tue, 19 May 2026 07:06:14 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 68F9680A84
	for <batman-adv@archiver.kernel.org>; Tue, 19 May 2026 09:06:09 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1779174369;
 b=U2nBftCUZgaovszC9cdYN6nXQMe+EGc3tWatk5r540votw+zTWf0L+6cbctVopBruvXRy
 AAa73KaYGyMElLo6eCiSntbag4eleSTV//Nv8ahNK4tKmDi0bqkAMcigin/VWkSdspc+5s+
 5KLNubbgEOK41n3jkw+bYuHlE6GXEnI=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1779174369; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=Ij8P/uXqUGZbPkCfxlaLG5bqRJJregxdG1T9IcvO+rQ=;
 b=R60haaIjJ8Hgtx5pwByCBJW4wNBBov7rP8l6QLHFbKbara3Rj8AZJUY+6JZmhpRXeUDNe
 7s2SyXu+fnWxIr/gpD0024CnxyPoj09QB4D2CLlG+uOh0NMnNTW11lcGkN0qxIpJE2+WHeT
 0HM9IU41PzgJRGf3d/GObjLFhisjW9A=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 4177080BA6
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 19 May 2026 09:02:25 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1779174145;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=Ij8P/uXqUGZbPkCfxlaLG5bqRJJregxdG1T9IcvO+rQ=;
	b=ualQbR/qwuhJhGqwTUgiF4kpLfXDHOYzwoEGrtUYVN6bTWr9WlfAfxzFTN28a37FRT16cJ
	xSqmp5OA7fplFjoFvn/ZsF2a/QLxSXZffjhQZ5oVWOyoEdH+qwHTNFp1pig6+bHVJcExI+
	XKw+B1WKIqDWfITg8rmLOr4mI5anm+c=
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1779174145;
	b=oC6EWup2iY1UwJ/66ozzTZFrnRm/Z5C8DzUOs2CaZJsTPMz4TxAV/zxEKEIbLJvL+4M806
	y9VwvnBDSXUp+kfWd4RI2uUpr66S/medZ27JW0V0zInU/C0UH0z8A9BZ1N1nYYyCtvNayc
	XTld7B8yjUQ3rhUygu0ApK155FZvsd8=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=mRTIi26v;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 0340B1FE24;
	Tue, 19 May 2026 07:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1779174145;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ij8P/uXqUGZbPkCfxlaLG5bqRJJregxdG1T9IcvO+rQ=;
	b=mRTIi26vdJTBrCLdYM4R5Yr2cYZt78IzTwyytase/eZ8vfn8W+GfrNA0qYsWHPmEz/Cned
	stDJeDhRCGYMoYEC/IEbw6mXWgu8uEaXmPObXCpVkXCPRyxEnUbBzMQBqGFwf7OHKt317s
	JzWtai7/wpGkYAlzLF089bptpAcFNV4=
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 19 May 2026 09:02:16 +0200
Subject: [PATCH RFC batadv v2 2/5] batman-adv: limit numbers of parallel
 learned originators
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-resource-limit-v2-2-489c3c919a54@narfation.org>
References: <20260519-resource-limit-v2-0-489c3c919a54@narfation.org>
In-Reply-To: <20260519-resource-limit-v2-0-489c3c919a54@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7567; i=sven@narfation.org;
 h=from:subject:message-id; bh=81Ld7UshJujgpKFyd6toDPBENTihyBa+mXJRiE28qc4=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFk8XD/+9T/MKQj5feRF+fwvJ/zuVWe6t8gf2G9xLit0w
 95FHw3YO0pZGMS4GGTFFFn2XMk/v5n9rfznaR+PwsxhZQIZwsDFKQAT8dZlZPhzaKr7voVMslYb
 zSb3fAm9Wc7TyP004FnJnkOvC2ulZq9lZPjuXMDa/ltiGe/NHZY90/Ztfrd0c8XRJZ/j1jNtOjx
 r1zs2AA==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: Z5VPTTA7BUOE3ARODSW5ALH4AFF6HOQV
X-Message-ID-Hash: Z5VPTTA7BUOE3ARODSW5ALH4AFF6HOQV
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/Z5VPTTA7BUOE3ARODSW5ALH4AFF6HOQV/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

A malicious actor behind one bridge port may spam the kernel with OGMs with
a random source MAC address, each of which will create an originator node
entry, each of which is a dynamic allocation in the kernel. This will at
some point exhaust the available memory.

Mitigate this by maintaining a per meshif count of those automatically
generated entries in orig_learned, and a limit in orig_max_learned. If the
limit is hit new entries are not learned anymore.

For backwards compatibility, the default setting of 0 disables the limit.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 include/uapi/linux/batman_adv.h |  6 ++++++
 net/batman-adv/bat_iv_ogm.c     | 13 ++++++++++++-
 net/batman-adv/bat_v_ogm.c      | 11 +++++++++++
 net/batman-adv/mesh-interface.c |  3 +++
 net/batman-adv/netlink.c        | 10 ++++++++++
 net/batman-adv/originator.c     |  2 ++
 net/batman-adv/types.h          |  6 ++++++
 7 files changed, 50 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/batman_adv.h b/include/uapi/linux/batman_adv.h
index addb6092..b3c04ab0 100644
--- a/include/uapi/linux/batman_adv.h
+++ b/include/uapi/linux/batman_adv.h
@@ -487,6 +487,12 @@ enum batadv_nl_attrs {
 	 */
 	BATADV_ATTR_NEIGH_MAX_LEARNED,
 
+	/**
+	 * @BATADV_ATTR_ORIG_MAX_LEARNED: defines the maximum number of originator
+	 * which can be learned in parallel
+	 */
+	BATADV_ATTR_ORIG_MAX_LEARNED,
+
 	/* add attributes above here, update the policy in netlink.c */
 
 	/**
diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index 74ef7dc2..cc289f55 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -13,6 +13,7 @@
 #include <linux/bug.h>
 #include <linux/byteorder/generic.h>
 #include <linux/cache.h>
+#include <linux/compiler.h>
 #include <linux/container_of.h>
 #include <linux/errno.h>
 #include <linux/etherdevice.h>
@@ -140,24 +141,34 @@ static struct batadv_orig_node *
 batadv_iv_ogm_orig_get(struct batadv_priv *bat_priv, const u8 *addr)
 {
 	struct batadv_orig_node *orig_node;
+	u32 orig_max_learned;
+	int orig_learned;
 	int hash_added;
 
 	orig_node = batadv_orig_hash_find(bat_priv, addr);
 	if (orig_node)
 		return orig_node;
 
+	orig_max_learned = READ_ONCE(bat_priv->orig_max_learned);
+	orig_learned = atomic_read(&bat_priv->orig_learned);
+	if (orig_max_learned && orig_learned >= orig_max_learned)
+		return NULL;
+
 	orig_node = batadv_orig_node_new(bat_priv, addr);
 	if (!orig_node)
 		return NULL;
 
 	spin_lock_init(&orig_node->bat_iv.ogm_cnt_lock);
+	atomic_inc(&bat_priv->orig_learned);
 
 	kref_get(&orig_node->refcount);
 	hash_added = batadv_hash_add(bat_priv->orig_hash, batadv_compare_orig,
 				     batadv_choose_orig, orig_node,
 				     &orig_node->hash_entry);
-	if (hash_added != 0)
+	if (hash_added != 0) {
+		atomic_dec(&bat_priv->orig_learned);
 		goto free_orig_node_hash;
+	}
 
 	return orig_node;
 
diff --git a/net/batman-adv/bat_v_ogm.c b/net/batman-adv/bat_v_ogm.c
index e3870492..dd57f4a7 100644
--- a/net/batman-adv/bat_v_ogm.c
+++ b/net/batman-adv/bat_v_ogm.c
@@ -9,6 +9,7 @@
 
 #include <linux/atomic.h>
 #include <linux/byteorder/generic.h>
+#include <linux/compiler.h>
 #include <linux/container_of.h>
 #include <linux/errno.h>
 #include <linux/etherdevice.h>
@@ -54,16 +55,25 @@ struct batadv_orig_node *batadv_v_ogm_orig_get(struct batadv_priv *bat_priv,
 					       const u8 *addr)
 {
 	struct batadv_orig_node *orig_node;
+	u32 orig_max_learned;
+	int orig_learned;
 	int hash_added;
 
 	orig_node = batadv_orig_hash_find(bat_priv, addr);
 	if (orig_node)
 		return orig_node;
 
+	orig_max_learned = READ_ONCE(bat_priv->orig_max_learned);
+	orig_learned = atomic_read(&bat_priv->orig_learned);
+	if (orig_max_learned && orig_learned >= orig_max_learned)
+		return NULL;
+
 	orig_node = batadv_orig_node_new(bat_priv, addr);
 	if (!orig_node)
 		return NULL;
 
+	atomic_inc(&bat_priv->orig_learned);
+
 	kref_get(&orig_node->refcount);
 	hash_added = batadv_hash_add(bat_priv->orig_hash, batadv_compare_orig,
 				     batadv_choose_orig, orig_node,
@@ -73,6 +83,7 @@ struct batadv_orig_node *batadv_v_ogm_orig_get(struct batadv_priv *bat_priv,
 		batadv_orig_node_put(orig_node);
 		batadv_orig_node_put(orig_node);
 		orig_node = NULL;
+		atomic_dec(&bat_priv->orig_learned);
 	}
 
 	return orig_node;
diff --git a/net/batman-adv/mesh-interface.c b/net/batman-adv/mesh-interface.c
index b9302c58..fad788cc 100644
--- a/net/batman-adv/mesh-interface.c
+++ b/net/batman-adv/mesh-interface.c
@@ -793,6 +793,9 @@ static int batadv_meshif_init_late(struct net_device *dev)
 	atomic_set(&bat_priv->neigh_learned, 0);
 	WRITE_ONCE(bat_priv->neigh_max_learned, 0);
 
+	atomic_set(&bat_priv->orig_learned, 0);
+	WRITE_ONCE(bat_priv->orig_max_learned, 0);
+
 	WRITE_ONCE(bat_priv->tt.local_changes, 0);
 	bat_priv->tt.last_changeset = NULL;
 	bat_priv->tt.last_changeset_len = 0;
diff --git a/net/batman-adv/netlink.c b/net/batman-adv/netlink.c
index 915a7d74..2b5fb1d6 100644
--- a/net/batman-adv/netlink.c
+++ b/net/batman-adv/netlink.c
@@ -148,6 +148,7 @@ static const struct nla_policy batadv_netlink_policy[NUM_BATADV_ATTR] = {
 	[BATADV_ATTR_ELP_INTERVAL]		= { .type = NLA_U32 },
 	[BATADV_ATTR_THROUGHPUT_OVERRIDE]	= { .type = NLA_U32 },
 	[BATADV_ATTR_NEIGH_MAX_LEARNED]		= { .type = NLA_U32 },
+	[BATADV_ATTR_ORIG_MAX_LEARNED]		= { .type = NLA_U32 },
 };
 
 /**
@@ -353,6 +354,10 @@ static int batadv_netlink_mesh_fill(struct sk_buff *msg,
 			READ_ONCE(bat_priv->neigh_max_learned)))
 		goto nla_put_failure;
 
+	if (nla_put_u32(msg, BATADV_ATTR_ORIG_MAX_LEARNED,
+			READ_ONCE(bat_priv->orig_max_learned)))
+		goto nla_put_failure;
+
 	batadv_hardif_put(primary_if);
 
 	genlmsg_end(msg, hdr);
@@ -603,6 +608,11 @@ static int batadv_netlink_set_mesh(struct sk_buff *skb, struct genl_info *info)
 			   nla_get_u32(info->attrs[BATADV_ATTR_NEIGH_MAX_LEARNED]));
 	}
 
+	if (info->attrs[BATADV_ATTR_ORIG_MAX_LEARNED]) {
+		WRITE_ONCE(bat_priv->orig_max_learned,
+			   nla_get_u32(info->attrs[BATADV_ATTR_ORIG_MAX_LEARNED]));
+	}
+
 	batadv_netlink_notify_mesh(bat_priv);
 
 	return 0;
diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
index 90f553fc..3c48e006 100644
--- a/net/batman-adv/originator.c
+++ b/net/batman-adv/originator.c
@@ -930,6 +930,7 @@ void batadv_originator_free(struct batadv_priv *bat_priv)
 					  head, hash_entry) {
 			hlist_del_rcu(&orig_node->hash_entry);
 			batadv_orig_node_put(orig_node);
+			atomic_dec(&bat_priv->orig_learned);
 		}
 		spin_unlock_bh(list_lock);
 	}
@@ -1297,6 +1298,7 @@ void batadv_purge_orig_ref(struct batadv_priv *bat_priv)
 							  orig_node, -1,
 							  "originator timed out");
 				batadv_orig_node_put(orig_node);
+				atomic_dec(&bat_priv->orig_learned);
 				continue;
 			}
 
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 13349350..49398aeb 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -1643,6 +1643,12 @@ struct batadv_priv {
 	/** @neigh_learned: current number of learned neighbors */
 	atomic_t neigh_learned;
 
+	/** @orig_max_learned: Maximum number of originators */
+	u32 orig_max_learned;
+
+	/** @orig_learned: current number of learned originators */
+	atomic_t orig_learned;
+
 #ifdef CONFIG_BATMAN_ADV_BLA
 	/** @bla: bridge loop avoidance data */
 	struct batadv_priv_bla bla;

-- 
2.47.3

