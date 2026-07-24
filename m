Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7D2BC531F9
	for <batman@archiver.kernel.org>; Fri, 24 Jul 2026 06:53:34 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 75F6384189
	for <batman@archiver.kernel.org>; Fri, 24 Jul 2026 08:53:33 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1784876013;
 b=SwG/hosc9y/3kyMG1NNheR1cSoVuOxgnORMDmg1AJfSkpOzqPBpCMrtcR0N9roLzzHAtn
 dlOVHNS/bNKhr6Lrb9wpyXEVDDFwPEtSMX4rSSCoEd1gyg49cD8iSgR6B2cQgTwc2RSA6ky
 2RUZbob4a+hOoiOAfKEFhL+6jO+8P/g=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1784876013; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=g6DkVAGLVaKivI38X9uiJK76FtCRo6hakHEl/sy9avA=;
 b=r6Ontj8BuKGHUxR0ZorkKYiDDIO6UBY10mPF+s+PFap2Fah1aRYrPGXVfKlnFIklwuIYI
 kvn9DQzwtxjJdGF8/4mDFYLTrOGqT+gDP/BpoKNZo/Xka3G2YePAvYhUPxQU7nf72s1tWco
 jlFaa4BLWmHDBeWIcfhf/EUzQ6nCSng=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id AB1ED81E8C
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 24 Jul 2026 08:51:52 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1784875922;
	b=uRrmqbhCJ7MIDt9WU2o/aI1FB/G4PmN/21Z1IGtqmTLvP8+jnONZn8rKyRXSpqWKyi7cI0
	BNhkbep/CmU57PAvG2yNcQbp/YCpQ40+YidPGg9qNMJg80ol4JivHpKtmTjYoSNIwvfhQc
	p/EjMiN/DOVENpWVQzG49p55VsRvPqE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1784875922;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=g6DkVAGLVaKivI38X9uiJK76FtCRo6hakHEl/sy9avA=;
	b=tpbWSp1dVDVSL14WjVBt3xTCxpOul2KFZTvV2A2hVVCHAc6KmGDdkOHwObeBO+fyKQaV6v
	xQ2rsMQj3qAa2YQ3ykJcH8de0mJwMB45AhpdW0ov6BkyhIArBOOZHMrAYtzZvoPYaZ9anL
	YJLIONj+NSZ2SnGHmolDo2TaJGpLRJs=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=qyQnf3FT;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id D844A2035A;
	Fri, 24 Jul 2026 06:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1784875911;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g6DkVAGLVaKivI38X9uiJK76FtCRo6hakHEl/sy9avA=;
	b=qyQnf3FTbdR7uUsK2GAXXG3mjWw/prTapYU8UBaX1RsmoipeWXtVa9G4ABPyyVN+Xz6WnN
	m/MAZDo5sfMdWCqDD9nTJAwx3hl0fVBry/i+BPXsm24iVDp2Rosuzr7k1Vl9oVeyBwCJOB
	CgbK+xKLXMVCNwv5mr7JbiUIlHdpkMg=
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 24 Jul 2026 08:51:39 +0200
Subject: [PATCH batadv v3 2/5] batman-adv: limit number of parallel learned
 originators
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260724-resource-limit-v3-2-be845f27ff62@narfation.org>
References: <20260724-resource-limit-v3-0-be845f27ff62@narfation.org>
In-Reply-To: <20260724-resource-limit-v3-0-be845f27ff62@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6837; i=sven@narfation.org;
 h=from:subject:message-id; bh=UfzU4+pmZrNMOV5YeVD7rAJXZd64vOvZsp6kaBVyplU=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFnJ3PU1xUkPDAUdJQXP/t1166lceTrTJJNDIiws7m+cl
 jWZLUzrKGVhEONikBVTZNlzJf/8Zva38p+nfTwKM4eVCWQIAxenAExkgjzDP51Tn/0rjTP59whd
 /hRzJPRh05wvh1canJ7mfVfN1HI3jynDP7NzGlY9bCEy1Ryqiqz3vul0KqfUT9/2OT9DMWa/7hU
 RfgA=
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: 7YNRLMVCKFALTK5FO4PHKKT5BRLRVNCE
X-Message-ID-Hash: 7YNRLMVCKFALTK5FO4PHKKT5BRLRVNCE
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/7YNRLMVCKFALTK5FO4PHKKT5BRLRVNCE/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

A malicious actor behind one hardif may spam the kernel with OGMs using a
random source MAC address, each of which will create an originator node
entry, a dynamic allocation in the kernel. This will at some point exhaust
the available memory.

Mitigate this by maintaining a per meshif count of those automatically
generated entries in orig_learned, and a limit in orig_max_learned. If the
limit is hit, new entries are not learned anymore.

For backwards compatibility, the default setting of 0 disables the limit.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 include/uapi/linux/batman_adv.h |  6 ++++++
 net/batman-adv/bat_iv_ogm.c     | 15 +++++++++++++--
 net/batman-adv/bat_v_ogm.c      | 15 +++++++++++++--
 net/batman-adv/mesh-interface.c |  3 +++
 net/batman-adv/netlink.c        | 10 ++++++++++
 net/batman-adv/originator.c     |  3 +++
 net/batman-adv/types.h          |  6 ++++++
 7 files changed, 54 insertions(+), 4 deletions(-)

diff --git a/include/uapi/linux/batman_adv.h b/include/uapi/linux/batman_adv.h
index addb6092..325cd687 100644
--- a/include/uapi/linux/batman_adv.h
+++ b/include/uapi/linux/batman_adv.h
@@ -487,6 +487,12 @@ enum batadv_nl_attrs {
 	 */
 	BATADV_ATTR_NEIGH_MAX_LEARNED,
 
+	/**
+	 * @BATADV_ATTR_ORIG_MAX_LEARNED: defines the maximum number of originators
+	 * which can be learned in parallel
+	 */
+	BATADV_ATTR_ORIG_MAX_LEARNED,
+
 	/* add attributes above here, update the policy in netlink.c */
 
 	/**
diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index aff279b8..0efba915 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -141,15 +141,26 @@ static struct batadv_orig_node *
 batadv_iv_ogm_orig_get(struct batadv_priv *bat_priv, const u8 *addr)
 {
 	struct batadv_orig_node *orig_node;
+	u32 orig_max_learned;
+	int orig_learned;
 	int hash_added;
 
 	orig_node = batadv_orig_hash_find(bat_priv, addr);
 	if (orig_node)
 		return orig_node;
 
-	orig_node = batadv_orig_node_new(bat_priv, addr);
-	if (!orig_node)
+	orig_max_learned = READ_ONCE(bat_priv->orig_max_learned);
+	orig_learned = atomic_inc_return(&bat_priv->orig_learned);
+	if (orig_max_learned && orig_learned > orig_max_learned) {
+		atomic_dec(&bat_priv->orig_learned);
 		return NULL;
+	}
+
+	orig_node = batadv_orig_node_new(bat_priv, addr);
+	if (!orig_node) {
+		atomic_dec(&bat_priv->orig_learned);
+		return NULL;
+	}
 
 	spin_lock_init(&orig_node->bat_iv.ogm_cnt_lock);
 
diff --git a/net/batman-adv/bat_v_ogm.c b/net/batman-adv/bat_v_ogm.c
index 70846c99..c1354291 100644
--- a/net/batman-adv/bat_v_ogm.c
+++ b/net/batman-adv/bat_v_ogm.c
@@ -56,15 +56,26 @@ struct batadv_orig_node *batadv_v_ogm_orig_get(struct batadv_priv *bat_priv,
 					       const u8 *addr)
 {
 	struct batadv_orig_node *orig_node;
+	u32 orig_max_learned;
+	int orig_learned;
 	int hash_added;
 
 	orig_node = batadv_orig_hash_find(bat_priv, addr);
 	if (orig_node)
 		return orig_node;
 
-	orig_node = batadv_orig_node_new(bat_priv, addr);
-	if (!orig_node)
+	orig_max_learned = READ_ONCE(bat_priv->orig_max_learned);
+	orig_learned = atomic_inc_return(&bat_priv->orig_learned);
+	if (orig_max_learned && orig_learned > orig_max_learned) {
+		atomic_dec(&bat_priv->orig_learned);
 		return NULL;
+	}
+
+	orig_node = batadv_orig_node_new(bat_priv, addr);
+	if (!orig_node) {
+		atomic_dec(&bat_priv->orig_learned);
+		return NULL;
+	}
 
 	kref_get(&orig_node->refcount);
 	hash_added = batadv_hash_add(bat_priv->orig_hash, batadv_compare_orig,
diff --git a/net/batman-adv/mesh-interface.c b/net/batman-adv/mesh-interface.c
index 70e13150..e9155ff3 100644
--- a/net/batman-adv/mesh-interface.c
+++ b/net/batman-adv/mesh-interface.c
@@ -849,6 +849,9 @@ static int batadv_meshif_init_late(struct net_device *dev)
 	atomic_set(&bat_priv->neigh_learned, 0);
 	WRITE_ONCE(bat_priv->neigh_max_learned, 0);
 
+	atomic_set(&bat_priv->orig_learned, 0);
+	WRITE_ONCE(bat_priv->orig_max_learned, 0);
+
 	WRITE_ONCE(bat_priv->tt.local_changes, 0);
 	bat_priv->tt.last_changeset = NULL;
 	bat_priv->tt.last_changeset_len = 0;
diff --git a/net/batman-adv/netlink.c b/net/batman-adv/netlink.c
index 64bec41a..41ed7aaf 100644
--- a/net/batman-adv/netlink.c
+++ b/net/batman-adv/netlink.c
@@ -155,6 +155,7 @@ static const struct nla_policy batadv_netlink_policy[NUM_BATADV_ATTR] = {
 	[BATADV_ATTR_ELP_INTERVAL]		= { .type = NLA_U32 },
 	[BATADV_ATTR_THROUGHPUT_OVERRIDE]	= { .type = NLA_U32 },
 	[BATADV_ATTR_NEIGH_MAX_LEARNED]		= { .type = NLA_U32 },
+	[BATADV_ATTR_ORIG_MAX_LEARNED]		= { .type = NLA_U32 },
 };
 
 /**
@@ -360,6 +361,10 @@ static int batadv_netlink_mesh_fill(struct sk_buff *msg,
 			READ_ONCE(bat_priv->neigh_max_learned)))
 		goto nla_put_failure;
 
+	if (nla_put_u32(msg, BATADV_ATTR_ORIG_MAX_LEARNED,
+			READ_ONCE(bat_priv->orig_max_learned)))
+		goto nla_put_failure;
+
 	batadv_hardif_put(primary_if);
 
 	genlmsg_end(msg, hdr);
@@ -610,6 +615,11 @@ static int batadv_netlink_set_mesh(struct sk_buff *skb, struct genl_info *info)
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
index d6a5bd7c..f2910366 100644
--- a/net/batman-adv/originator.c
+++ b/net/batman-adv/originator.c
@@ -876,9 +876,11 @@ void batadv_orig_node_release(struct kref *ref)
 	struct batadv_neigh_node *neigh_node;
 	struct batadv_orig_node *orig_node;
 	struct batadv_orig_node_vlan *vlan;
+	struct batadv_priv *bat_priv;
 	struct hlist_node *node_tmp;
 
 	orig_node = container_of(ref, struct batadv_orig_node, refcount);
+	bat_priv = orig_node->bat_priv;
 
 	spin_lock_bh(&orig_node->neigh_list_lock);
 
@@ -910,6 +912,7 @@ void batadv_orig_node_release(struct kref *ref)
 
 	batadv_mcast_purge_orig(orig_node);
 
+	atomic_dec(&bat_priv->orig_learned);
 	call_rcu(&orig_node->rcu, batadv_orig_node_free_rcu);
 }
 
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index e404a6b4..66096bfe 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -1709,6 +1709,12 @@ struct batadv_priv {
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

