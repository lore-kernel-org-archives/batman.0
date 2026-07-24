Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7F99C531C9
	for <batman@archiver.kernel.org>; Fri, 24 Jul 2026 06:52:07 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id BBD4D8404B
	for <batman@archiver.kernel.org>; Fri, 24 Jul 2026 08:52:05 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1784875925;
 b=cR+EgL/8KLIgum11PsxOt1eU8sC/+k4WYaC82YzqZ6O0gbxEIMuy8K0/KFa6D93Cl6SUw
 d3bDV3G8LaySlXJF7a3Cec2BzMEVMcRUKzRqDZmWqMAJV7w+lk/xb4SYr0Rfx7Awoc4+dYo
 YkswzbtYyOJy1XMviofgB5G43H5BcCo=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1784875925; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=h/pfmEDMjf2r4yBFbb+ttohRKqKYgdxm00K6VWNgYKA=;
 b=MOA+zkx1XPW8txcyAUkK6czc4n4r31xOi9694ab4//6kDhH2tG3zOW5qx5BQ8DhpcaZ5U
 UhHHCsXp28Tek+OPWO1Gqkd3IvvobJoOZAvb6u1ynTM3lYp5176m7iNl2ddOrAqO+ULrDDq
 6nlcdRHXiwuUiTDDGceGPy43ArBpyMw=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 5F8FB81E8C
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 24 Jul 2026 08:51:50 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1784875920;
	b=XbnkC9GAsBFQzZDlgWOm0l+elfXzXzJ0E0kUHp051AW5PXBjC037vpVBeR4VM+2qgmh33A
	6//udFnU6LBb/vtzcKsXx8417DC2DPjgC4oaS8z+4QpVN+xG8QJPDC0UN2SsNyZoB/qYa5
	Ssg7uk5E47el1l/M7gthyrhN8ssQ+TI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1784875920;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=h/pfmEDMjf2r4yBFbb+ttohRKqKYgdxm00K6VWNgYKA=;
	b=m3dpGHqaEVLpc/QDEBSu3tjUdPjx7+6ME2lohY5RRMjYbhsZNg1p5dYgqi5N7qNGnrlYkq
	cKiIGZB7HSW+9i5akxPGFw3TQPH0gk8AKInZVYlRIEfKIMr54pzbf2mfPrM6UvBw+Z014k
	Y5qSxinkhZNWytFjCbD5wXW5qbLjnXY=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=HWgtdJ5H;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id DD0C820288;
	Fri, 24 Jul 2026 06:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1784875909;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h/pfmEDMjf2r4yBFbb+ttohRKqKYgdxm00K6VWNgYKA=;
	b=HWgtdJ5Ht4exdHy+7MgInowBmzl1lWvuId6R2Vzlvo1nx1W0sW3KoWCBg2g+N270QgUjKz
	Tlxepr7V1lNsfv5tkIpuz9dQD/jPGLGe2R1vUwRZK76J2A1yGfRRS1SiesnVxlpxWqTWB5
	hPSkNm1LBLeXvPKGYnt7d5vH+4c+n/I=
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 24 Jul 2026 08:51:38 +0200
Subject: [PATCH batadv v3 1/5] batman-adv: limit number of parallel learned
 neighbors
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260724-resource-limit-v3-1-be845f27ff62@narfation.org>
References: <20260724-resource-limit-v3-0-be845f27ff62@narfation.org>
In-Reply-To: <20260724-resource-limit-v3-0-be845f27ff62@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6028; i=sven@narfation.org;
 h=from:subject:message-id; bh=H/IU7xHjVdpxbz+G/ZlApxGJGsJaqzUxM6luWafWQXE=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFnJ3PXPti+6kaxdt4Ih6Eeu99Unq+ZsPiJ9wzu8Yl/Yi
 Ti2+cGnO0pZGMS4GGTFFFn2XMk/v5n9rfznaR+PwsxhZQIZwsDFKQATSX3D8FcmL+ZGn3vCyulH
 GlmC4jx/rF6gqDRvgmRa9Hmh2qZQIx5GhpU3FmqKpQZtfxdtyJa4XH/dUnFPbu+ZLKmfVwhM13I
 05AYA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: L2UEIIILRVKJ2DF3FVAZHZ4MVJK5H53I
X-Message-ID-Hash: L2UEIIILRVKJ2DF3FVAZHZ4MVJK5H53I
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/L2UEIIILRVKJ2DF3FVAZHZ4MVJK5H53I/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

A malicious actor behind one hardif may spam the kernel with OGMs using a
random source MAC address, each of which will create a neighbor node entry,
a dynamic allocation in the kernel. This will at some point exhaust the
available memory.

Mitigate this by maintaining a per meshif count of those automatically
generated entries in neigh_learned, and a limit in neigh_max_learned. If
the limit is hit, new entries are not learned anymore.

For backwards compatibility, the default setting of 0 disables the limit.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 include/uapi/linux/batman_adv.h |  6 ++++++
 net/batman-adv/mesh-interface.c |  3 +++
 net/batman-adv/netlink.c        | 10 ++++++++++
 net/batman-adv/originator.c     | 19 +++++++++++++++++--
 net/batman-adv/types.h          |  9 +++++++++
 5 files changed, 45 insertions(+), 2 deletions(-)

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
index f1bfe2a5..70e13150 100644
--- a/net/batman-adv/mesh-interface.c
+++ b/net/batman-adv/mesh-interface.c
@@ -846,6 +846,9 @@ static int batadv_meshif_init_late(struct net_device *dev)
 #endif
 	atomic_set(&bat_priv->tp_num, 0);
 
+	atomic_set(&bat_priv->neigh_learned, 0);
+	WRITE_ONCE(bat_priv->neigh_max_learned, 0);
+
 	WRITE_ONCE(bat_priv->tt.local_changes, 0);
 	bat_priv->tt.last_changeset = NULL;
 	bat_priv->tt.last_changeset_len = 0;
diff --git a/net/batman-adv/netlink.c b/net/batman-adv/netlink.c
index bb1ef3ee..64bec41a 100644
--- a/net/batman-adv/netlink.c
+++ b/net/batman-adv/netlink.c
@@ -154,6 +154,7 @@ static const struct nla_policy batadv_netlink_policy[NUM_BATADV_ATTR] = {
 	[BATADV_ATTR_ORIG_INTERVAL]		= { .type = NLA_U32 },
 	[BATADV_ATTR_ELP_INTERVAL]		= { .type = NLA_U32 },
 	[BATADV_ATTR_THROUGHPUT_OVERRIDE]	= { .type = NLA_U32 },
+	[BATADV_ATTR_NEIGH_MAX_LEARNED]		= { .type = NLA_U32 },
 };
 
 /**
@@ -355,6 +356,10 @@ static int batadv_netlink_mesh_fill(struct sk_buff *msg,
 			READ_ONCE(bat_priv->orig_interval)))
 		goto nla_put_failure;
 
+	if (nla_put_u32(msg, BATADV_ATTR_NEIGH_MAX_LEARNED,
+			READ_ONCE(bat_priv->neigh_max_learned)))
+		goto nla_put_failure;
+
 	batadv_hardif_put(primary_if);
 
 	genlmsg_end(msg, hdr);
@@ -600,6 +605,11 @@ static int batadv_netlink_set_mesh(struct sk_buff *skb, struct genl_info *info)
 		WRITE_ONCE(bat_priv->orig_interval, orig_interval);
 	}
 
+	if (info->attrs[BATADV_ATTR_NEIGH_MAX_LEARNED]) {
+		WRITE_ONCE(bat_priv->neigh_max_learned,
+			   nla_get_u32(info->attrs[BATADV_ATTR_NEIGH_MAX_LEARNED]));
+	}
+
 	batadv_netlink_notify_mesh(bat_priv);
 
 	return 0;
diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
index f06583ef..d6a5bd7c 100644
--- a/net/batman-adv/originator.c
+++ b/net/batman-adv/originator.c
@@ -299,6 +299,7 @@ void batadv_neigh_node_release(struct kref *ref)
 
 	batadv_hardif_put(neigh_node->if_incoming);
 
+	atomic_dec(&neigh_node->bat_priv->neigh_learned);
 	kfree_rcu(neigh_node, rcu);
 }
 
@@ -675,6 +676,8 @@ batadv_neigh_node_create(struct batadv_orig_node *orig_node,
 {
 	struct batadv_hardif_neigh_node *hardif_neigh = NULL;
 	struct batadv_neigh_node *neigh_node;
+	u32 neigh_max_learned;
+	int neigh_learned;
 
 	spin_lock_bh(&orig_node->neigh_list_lock);
 
@@ -682,14 +685,25 @@ batadv_neigh_node_create(struct batadv_orig_node *orig_node,
 	if (neigh_node)
 		goto out;
 
+	neigh_max_learned = READ_ONCE(orig_node->bat_priv->neigh_max_learned);
+	neigh_learned = atomic_inc_return(&orig_node->bat_priv->neigh_learned);
+	if (neigh_max_learned && neigh_learned > neigh_max_learned) {
+		atomic_dec(&orig_node->bat_priv->neigh_learned);
+		goto out;
+	}
+
 	hardif_neigh = batadv_hardif_neigh_get_or_create(hard_iface,
 							 neigh_addr, orig_node);
-	if (!hardif_neigh)
+	if (!hardif_neigh) {
+		atomic_dec(&orig_node->bat_priv->neigh_learned);
 		goto out;
+	}
 
 	neigh_node = kzalloc_obj(*neigh_node, GFP_ATOMIC);
-	if (!neigh_node)
+	if (!neigh_node) {
+		atomic_dec(&orig_node->bat_priv->neigh_learned);
 		goto out;
+	}
 
 	INIT_HLIST_NODE(&neigh_node->list);
 	INIT_HLIST_HEAD(&neigh_node->ifinfo_list);
@@ -699,6 +713,7 @@ batadv_neigh_node_create(struct batadv_orig_node *orig_node,
 	ether_addr_copy(neigh_node->addr, neigh_addr);
 	neigh_node->if_incoming = hard_iface;
 	neigh_node->last_seen = jiffies;
+	neigh_node->bat_priv = orig_node->bat_priv;
 
 #ifdef CONFIG_BATMAN_ADV_BATMAN_V
 	ACCESS_PRIVATE(neigh_node, orig_node_id) = orig_node;
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index d6e15d46..e404a6b4 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -679,6 +679,9 @@ struct batadv_neigh_node {
 	/** @addr: the MAC address of the neighboring interface */
 	u8 addr[ETH_ALEN];
 
+	/** @bat_priv: pointer to the mesh object */
+	struct batadv_priv *bat_priv;
+
 	/** @ifinfo_list: list for routing metrics per outgoing interface */
 	struct hlist_head ifinfo_list;
 
@@ -1700,6 +1703,12 @@ struct batadv_priv {
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

