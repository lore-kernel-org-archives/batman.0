Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D478CD4F54
	for <batman@archiver.kernel.org>; Tue, 19 May 2026 07:05:52 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 7550980853
	for <batman@archiver.kernel.org>; Tue, 19 May 2026 09:05:31 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1779174331;
 b=b+w1dgYO3QR7jLVhgZt0o3lsXUjDQcKRwkmJM3MtMQrChwNP4XpcKmKXqwD6mrcxSbBrg
 GWK2vGKrluj0Ic2ndlqKXPGssdHMWHLHw58hSZQtt320rGwMOZ2fAUqtfxn4dNuBPl1qWQN
 kBpT4B6JU65RkhKxRvQPvvCYF5XHpJU=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1779174331; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=c8KbAOod2FhNWvMXBuMIjXA4ID/7SFd+2NM/filkrdw=;
 b=h3yECDe/L+5kwVXfzheWydUyy/mNOpSj0+ZsRNXWqh+P4LLxr5Fx4iyNPW1BKi/I2etp4
 xQFZ0I8OlY9rgS4M2l1F4Qke1jzgCb1sRj7GIGMfctfGm/Ebc1Pa86Pq4Uc/88E5pshXxv0
 kYbY+imqxPDipG4n4fgk5ER9eY9a1KY=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 2EF8E80B8E
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 19 May 2026 09:02:23 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1779174143;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=c8KbAOod2FhNWvMXBuMIjXA4ID/7SFd+2NM/filkrdw=;
	b=muFZiPdHLD4sUwenVymPE+2wgqDSXOgNyaeOhFVbEgLKfu7a/2Ah6Qfj58vAVoKZsOuHnv
	+gw58GNWWfwtyqEmQ6AxjJo3ERxh93ZAej18S37r5tCjGerBY6G2htqSx2Mrdl59rclYAv
	kAj7QyK7RV0fpG+3K3JpXp3RHX+bUXw=
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1779174143;
	b=x5EayZiFawpV6qrJNbCwp4S0k32dJIrRvpjvyuhI1F/BDBNCYSyEMVR7Ch2dSb421dt+O3
	wW2IO7xFCNEJkqVou9TiQRablRiNhS4l/pjZT31GlCrHhaPnK9scxGtLyFbEbyb2kXWsNZ
	ix+UqXjsfnmzSOmkzX8RZtxtPBC1h4M=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=t9C1Sqaf;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id DBAF21FE24;
	Tue, 19 May 2026 07:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1779174142;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c8KbAOod2FhNWvMXBuMIjXA4ID/7SFd+2NM/filkrdw=;
	b=t9C1Sqaf6VKfR93mIfO2uSkvWzYpetDDDP4cgckvTE9qkJPNC5/UxU/oJnAOfehlobuaC6
	k2eK4e/Xqj/6Wyg3NdRKN+23IBaFD+c0mWGljF2wAHdyQ8tR1F4EMQnk3aFSPok8986jas
	ngHJjHMgxEFi76azxNvnHJHLjzVUluU=
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 19 May 2026 09:02:15 +0200
Subject: [PATCH RFC batadv v2 1/5] batman-adv: limit numbers of parallel
 learned neighbors
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-resource-limit-v2-1-489c3c919a54@narfation.org>
References: <20260519-resource-limit-v2-0-489c3c919a54@narfation.org>
In-Reply-To: <20260519-resource-limit-v2-0-489c3c919a54@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5860; i=sven@narfation.org;
 h=from:subject:message-id; bh=m/Ak1hSixqQMO1XTh2K7FVtCzPheepxlv6SzRF2wGKY=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFk8XD8YFcRm2Bw2EhYRqL3uVz/J3CtxluCL/LqGH+17d
 dx/TNjcUcrCIMbFICumyLLnSv75zexv5T9P+3gUZg4rE8gQBi5OAZjIr4cM/xOfM8tObHzg9iHu
 +IZzB4rNuDu/We26HPNm4de/XcGyf8IYGZZoxhQxazpdZJ/30/32nKvq4ietuabXWXGtPyh9/ef
 kr/wA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: FB4L2O2LPMFORHU4IVEAGPRSKUN43BX6
X-Message-ID-Hash: FB4L2O2LPMFORHU4IVEAGPRSKUN43BX6
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/FB4L2O2LPMFORHU4IVEAGPRSKUN43BX6/>
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
index c8c3e806..13349350 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -1637,6 +1637,12 @@ struct batadv_priv {
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

