Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E1B2CD4F21
	for <batman@archiver.kernel.org>; Sat, 16 May 2026 12:37:33 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 9924385E7B
	for <batman@archiver.kernel.org>; Sat, 16 May 2026 14:37:31 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1778935051;
 b=Az2D+z7+ll/y8jN70Cmcc80caYTgN0JvK0qWsVE6AkduDoBhElm3ViefdeQCxAgqyq+jg
 tnFSp3KxdYr6NIHIMa9ynNIaFJ1nSDEvY/B5fFXWBex92e4LK++0V8nnfPpHlZ0XrcbQPk9
 OhKUmbSOoERuXdELFL3Rt0toHm2GLKY=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1778935051; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=hM6FYXNlFN4EmdpZ9+EjxQMDo2uzEvgbJwYpU4b4BBw=;
 b=Xutvtsubj+RhQegi3jIocTp8fxG0qJBMG+q5d2aOP5MG9Sn9wMUkrjg+1kG94tAImbihK
 xl5FtEG7jxWNDOQxQZ2sGT8PwK6k9rdqbFJCg5B+autwd07ogn2tW+9WyWvaB0SNKS7OpHy
 iOPzMShBpWL9bQJ9iSuq28Dd1pKmcEs=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 6E3CE85DB2
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sat, 16 May 2026 14:35:42 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1778934947;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=hM6FYXNlFN4EmdpZ9+EjxQMDo2uzEvgbJwYpU4b4BBw=;
	b=NhMrXzMdGnsxUrwNSwildlG2V3JmvLLa1q3WggK4OWvsqIy5uSj8ZFgRA/tnVxW7TC49BE
	pONDHLEez668A5rXm09TQZP+reJBK759qKBq+DGPExT2wuxvq0fJx47fw8zpsaSXFqrXmc
	zCa1/yg7bP/kY8g5rFxv+ZqtziWgE2w=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=hcL0ixpS;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1778934947;
	b=wE8smGnpxQB6PLQdUihvF8V1oKCyoM6DIU1bipAlFc3kJBdbAOtU7ssTCK5jv6V0xVQDDn
	cE5mw/wQOiayr1T5w1ZlpPWpT5fx1o5LSgAzNNAHhXz/U4eQAUTXRRwR8ZZe+75Bex1/Bc
	bMvk8u0HNW1sn7SxiKMgXACpiNrjo1M=
Received: by dvalin.narfation.org (Postfix) id DF2CA20101;
	Sat, 16 May 2026 12:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1778934941;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hM6FYXNlFN4EmdpZ9+EjxQMDo2uzEvgbJwYpU4b4BBw=;
	b=hcL0ixpS+KtGQKZMnbdM1L3ipDohmXh4jmxJwk1VigwZu0KoqHE0FN8Ffd+/Fw3BdBmeRo
	nOUeJ8qMvqeimdDZa9AOhY/ECFsikZECDH3vLgyi6XwjU3JUb3+Jf21Y6nxcoch1K99uN3
	XF24+65Pk3hHfhX50MhECfe1s+hxdDM=
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 16 May 2026 14:35:18 +0200
Subject: [PATCH RFC batadv 1/5] batman-adv: limit numbers of parallel
 learned neighbors
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260516-resource-limit-v1-1-6f597360ed2b@narfation.org>
References: <20260516-resource-limit-v1-0-6f597360ed2b@narfation.org>
In-Reply-To: <20260516-resource-limit-v1-0-6f597360ed2b@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5860; i=sven@narfation.org;
 h=from:subject:message-id; bh=pc6gIaMchHPGRfEYHNHLZspvXQ1xyvPA0+5sQf83IHE=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFkcKV137+Vv2RU562j5GdsXEe39wuG+O4qCrRdqBQbuc
 /dQcb3cUcrCIMbFICumyLLnSv75zexv5T9P+3gUZg4rE8gQBi5OAZjIxUsM//RcFTZp/Fu527/K
 rLnnyq24hxmKl5fvqNjYfm7txur5qb8Z/oee3hfV7u07baZi5XSpdTqpbFzcCo5h2TYWOoJn+G9
 bMAMA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: WZODYDNBTGC2URVUITLRP7K45DQK43OM
X-Message-ID-Hash: WZODYDNBTGC2URVUITLRP7K45DQK43OM
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/WZODYDNBTGC2URVUITLRP7K45DQK43OM/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

A malicious actor behind one bridge port may spam the kernel with OGMs with
a random source MAC address, each of which will create a neighbor node
entry, each of which is a dynamic allocation in the kernel. This will at
some point exhaust the available memory.

Mitigate this by maintaining a per meshif count of those automatically
generated entries in neigh_learned, and a limit in neigh_max_learned. If
the limit is hit new entries are not learned anymore.

For backwards compatibility, the default setting of 0 disables the limit.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 include/uapi/linux/batman_adv.h |  6 ++++++
 net/batman-adv/mesh-interface.c |  3 +++
 net/batman-adv/netlink.c        | 11 +++++++++++
 net/batman-adv/originator.c     | 12 ++++++++++++
 net/batman-adv/types.h          |  6 ++++++
 5 files changed, 38 insertions(+)

diff --git a/include/uapi/linux/batman_adv.h b/include/uapi/linux/batman_adv.h
index 936bcac2..addb6092 100644
--- a/include/uapi/linux/batman_adv.h
+++ b/include/uapi/linux/batman_adv.h
@@ -481,6 +481,12 @@ enum batadv_nl_attrs {
 	 */
 	BATADV_ATTR_MULTICAST_FANOUT,
 
+	/**
+	 * @BATADV_ATTR_NEIGH_MAX_LEARNED: defines the maximum number of neighbors
+	 * which can be learned in parallel
+	 */
+	BATADV_ATTR_NEIGH_MAX_LEARNED,
+
 	/* add attributes above here, update the policy in netlink.c */
 
 	/**
diff --git a/net/batman-adv/mesh-interface.c b/net/batman-adv/mesh-interface.c
index 50c26037..b9302c58 100644
--- a/net/batman-adv/mesh-interface.c
+++ b/net/batman-adv/mesh-interface.c
@@ -790,6 +790,9 @@ static int batadv_meshif_init_late(struct net_device *dev)
 #endif
 	atomic_set(&bat_priv->tp_num, 0);
 
+	atomic_set(&bat_priv->neigh_learned, 0);
+	WRITE_ONCE(bat_priv->neigh_max_learned, 0);
+
 	WRITE_ONCE(bat_priv->tt.local_changes, 0);
 	bat_priv->tt.last_changeset = NULL;
 	bat_priv->tt.last_changeset_len = 0;
diff --git a/net/batman-adv/netlink.c b/net/batman-adv/netlink.c
index e52f44e7..915a7d74 100644
--- a/net/batman-adv/netlink.c
+++ b/net/batman-adv/netlink.c
@@ -13,6 +13,7 @@
 #include <linux/bug.h>
 #include <linux/byteorder/generic.h>
 #include <linux/cache.h>
+#include <linux/compiler.h>
 #include <linux/err.h>
 #include <linux/errno.h>
 #include <linux/gfp.h>
@@ -146,6 +147,7 @@ static const struct nla_policy batadv_netlink_policy[NUM_BATADV_ATTR] = {
 	[BATADV_ATTR_ORIG_INTERVAL]		= { .type = NLA_U32 },
 	[BATADV_ATTR_ELP_INTERVAL]		= { .type = NLA_U32 },
 	[BATADV_ATTR_THROUGHPUT_OVERRIDE]	= { .type = NLA_U32 },
+	[BATADV_ATTR_NEIGH_MAX_LEARNED]		= { .type = NLA_U32 },
 };
 
 /**
@@ -347,6 +349,10 @@ static int batadv_netlink_mesh_fill(struct sk_buff *msg,
 			atomic_read(&bat_priv->orig_interval)))
 		goto nla_put_failure;
 
+	if (nla_put_u32(msg, BATADV_ATTR_NEIGH_MAX_LEARNED,
+			READ_ONCE(bat_priv->neigh_max_learned)))
+		goto nla_put_failure;
+
 	batadv_hardif_put(primary_if);
 
 	genlmsg_end(msg, hdr);
@@ -592,6 +598,11 @@ static int batadv_netlink_set_mesh(struct sk_buff *skb, struct genl_info *info)
 		atomic_set(&bat_priv->orig_interval, orig_interval);
 	}
 
+	if (info->attrs[BATADV_ATTR_NEIGH_MAX_LEARNED]) {
+		WRITE_ONCE(bat_priv->neigh_max_learned,
+			   nla_get_u32(info->attrs[BATADV_ATTR_NEIGH_MAX_LEARNED]));
+	}
+
 	batadv_netlink_notify_mesh(bat_priv);
 
 	return 0;
diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
index b3468cca..90f553fc 100644
--- a/net/batman-adv/originator.c
+++ b/net/batman-adv/originator.c
@@ -671,6 +671,8 @@ batadv_neigh_node_create(struct batadv_orig_node *orig_node,
 {
 	struct batadv_neigh_node *neigh_node;
 	struct batadv_hardif_neigh_node *hardif_neigh = NULL;
+	u32 neigh_max_learned;
+	int neigh_learned;
 
 	spin_lock_bh(&orig_node->neigh_list_lock);
 
@@ -678,6 +680,11 @@ batadv_neigh_node_create(struct batadv_orig_node *orig_node,
 	if (neigh_node)
 		goto out;
 
+	neigh_max_learned = READ_ONCE(orig_node->bat_priv->neigh_max_learned);
+	neigh_learned = atomic_read(&orig_node->bat_priv->neigh_learned);
+	if (neigh_max_learned && neigh_learned >= neigh_max_learned)
+		goto out;
+
 	hardif_neigh = batadv_hardif_neigh_get_or_create(hard_iface,
 							 neigh_addr, orig_node);
 	if (!hardif_neigh)
@@ -701,6 +708,8 @@ batadv_neigh_node_create(struct batadv_orig_node *orig_node,
 	kref_get(&hardif_neigh->refcount);
 	neigh_node->hardif_neigh = hardif_neigh;
 
+	atomic_inc(&orig_node->bat_priv->neigh_learned);
+
 	/* extra reference for return */
 	kref_init(&neigh_node->refcount);
 
@@ -866,6 +875,8 @@ void batadv_orig_node_release(struct kref *ref)
 				  &orig_node->neigh_list, list) {
 		hlist_del_rcu(&neigh_node->list);
 		batadv_neigh_node_put(neigh_node);
+
+		atomic_dec(&orig_node->bat_priv->neigh_learned);
 	}
 
 	hlist_for_each_entry_safe(orig_ifinfo, node_tmp,
@@ -1144,6 +1155,7 @@ batadv_purge_orig_neighbors(struct batadv_priv *bat_priv,
 
 			hlist_del_rcu(&neigh_node->list);
 			batadv_neigh_node_put(neigh_node);
+			atomic_dec(&bat_priv->neigh_learned);
 		} else {
 			/* only necessary if not the whole neighbor is to be
 			 * deleted, but some interface has been removed.
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index a76afc25..bad73d6b 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -1655,6 +1655,12 @@ struct batadv_priv {
 	/** @meshif_vlan_list_lock: lock protecting meshif_vlan_list */
 	spinlock_t meshif_vlan_list_lock;
 
+	/** @neigh_max_learned: Maximum number of neighbors */
+	u32 neigh_max_learned;
+
+	/** @neigh_learned: current number of learned neighbors */
+	atomic_t neigh_learned;
+
 #ifdef CONFIG_BATMAN_ADV_BLA
 	/** @bla: bridge loop avoidance data */
 	struct batadv_priv_bla bla;

-- 
2.47.3

