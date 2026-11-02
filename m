Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD98606A327
	for <batman@archiver.kernel.org>; Mon,  2 Nov 2026 21:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=narfation.org header.i=@narfation.org header.a=rsa-sha256 header.s=20121 header.b=HkImrLbs
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id A71D7820F3
	for <batman@archiver.kernel.org>; Mon, 02 Nov 2026 22:27:48 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1793654868;
 b=sF2OcFAfpXnnHGr6kQ8CpSjN5zbbQyJgRTRMWSl4mSc4cC+KMPmoLMNd9any61NuT5CxR
 IBxuzhzd+VkQQ900t0U4n5PKQ/Yg+qJrZNZSVSTbE5gGyO+VY9QttO1nEPn3+HiY2OzwcOX
 ObptYJ05BvG/be07ifH3Vm4pvIvT704=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1793654868; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=gCn7S71D+9CRVNo62f3W5f8tvh8PrDWsDMQkOP8DYyA=;
 b=oZ21aiGNCS9+XW+xgll7XwWvUP01E0Q+NLwU++//7E748IxLJ7cHf9Kymt3FOPq2wVG+R
 xeTdrrEVATOivddozNKKSmczN/VBsbhnhrc8pw5ESWY36jvTsxG+2qBJDQnhcvnG4lSL/Fr
 P7aZ8UjW3fr1lKBPpi7O59wHjlsqh9U=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id C22FD82679
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 02 Nov 2026 22:27:07 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1793654827;
	b=qYxe5Q+wxK2I9cOywPAC1XzfauD0PYkvPi7VnKPhblDGogU+h2fMHbl8YJm7F95BGW6lv5
	PgWTA2/7Zh/fXBs6dWMogo7RW0SeWDEdZWFQhLlqrumuHUaVM8I91Fie+qtLe3GoWbQP04
	iej/09NXh7b5dmc+VIi3AgOj2JLGPWc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1793654827;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=gCn7S71D+9CRVNo62f3W5f8tvh8PrDWsDMQkOP8DYyA=;
	b=eC0GdeK7GsFC85sXgU+Gnrh/+mvUmInm9MJFHbc9z1nvFbMhZTo8Mq5F9uKRaWtkLsY4XS
	PaFFPueiKGPnl2j+bg/FHYMigdJwKuXRQEROR72rpaUCUEn8vyL6/R617DmfEjym8zC54E
	ilTJw22ro/n3CPSCPyS5/BntSD0Uc4o=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=HkImrLbs;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 80B2B1FDF5;
	Mon, 02 Nov 2026 21:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1793654827;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gCn7S71D+9CRVNo62f3W5f8tvh8PrDWsDMQkOP8DYyA=;
	b=HkImrLbsiTlV/6s7wXIMiOr2xVf10VT0El5bHecl7YR9UUrxJ7X8BntmVzKtcKQM1hmPQN
	K2x8qxDXMXQi0RKNnMx3rmoRn+5uwuGSmkc2DqIzxQTBdRN8jD9787GiX4k5TE5IwlszhU
	TDoxrf7ZXgleXUefGOIMVbb/6yhuzdk=
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 02 Nov 2026 22:26:57 +0100
Subject: [PATCH batadv v4 1/5] batman-adv: limit number of parallel learned
 neighbors
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-resource-limit-v4-1-7ff9da793db4@narfation.org>
References: <20261102-resource-limit-v4-0-7ff9da793db4@narfation.org>
In-Reply-To: <20261102-resource-limit-v4-0-7ff9da793db4@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5666; i=sven@narfation.org;
 h=from:subject:message-id; bh=rc57UN6ozZ8S+VwUSR4jRcV/LiTnyhtVYFRNGA9cCLg=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFkvGVRkTpUyGYXMSn/VkVjufSn4086GRNN/8v8TFzypW
 nDZzyyuo5SFQYyLQVZMkWXPlfzzm9nfyn+e9vEozBxWJpAhDFycAjCRpTwM/7P0fZS2Coots14d
 ZP0keqOK546l32QjPiRZHJS02LV0+TSG/w7Kq14vU2bj4zpoqnKIf5VeskvZpOurE5vthb5O74y
 o5gcA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: Q5CXFVDUSHYB67GBAP4KVARR3HMVZSQB
X-Message-ID-Hash: Q5CXFVDUSHYB67GBAP4KVARR3HMVZSQB
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/Q5CXFVDUSHYB67GBAP4KVARR3HMVZSQB/>
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
 net/batman-adv/types.h          |  6 ++++++
 5 files changed, 42 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/batman_adv.h b/include/uapi/linux/batman_adv.h
index 936bcac2..debd2ae1 100644
--- a/include/uapi/linux/batman_adv.h
+++ b/include/uapi/linux/batman_adv.h
@@ -481,6 +481,12 @@ enum batadv_nl_attrs {
 	 */
 	BATADV_ATTR_MULTICAST_FANOUT,
 
+	/**
+	 * @BATADV_ATTR_NEIGH_MAX_LEARNED: defines the maximum number of neighbors
+	 * which can be learned in parallel. 0 disables the limit.
+	 */
+	BATADV_ATTR_NEIGH_MAX_LEARNED,
+
 	/* add attributes above here, update the policy in netlink.c */
 
 	/**
diff --git a/net/batman-adv/mesh-interface.c b/net/batman-adv/mesh-interface.c
index bc152e0b..a6956720 100644
--- a/net/batman-adv/mesh-interface.c
+++ b/net/batman-adv/mesh-interface.c
@@ -873,6 +873,9 @@ static int batadv_meshif_init_late(struct net_device *dev)
 #endif
 	atomic_set(&bat_priv->tp_num, 0);
 
+	atomic_set(&bat_priv->neigh_learned, 0);
+	WRITE_ONCE(bat_priv->neigh_max_learned, 0);
+
 	WRITE_ONCE(bat_priv->tt.local_changes, 0);
 	bat_priv->tt.last_changeset = NULL;
 	bat_priv->tt.last_changeset_len = 0;
diff --git a/net/batman-adv/netlink.c b/net/batman-adv/netlink.c
index 38adcc1d..21719d30 100644
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
index 25a3f78a..cfe5b3ef 100644
--- a/net/batman-adv/originator.c
+++ b/net/batman-adv/originator.c
@@ -269,6 +269,7 @@ void batadv_neigh_ifinfo_release(struct kref *ref)
 void batadv_hardif_neigh_release(struct kref *ref)
 {
 	struct batadv_hardif_neigh_node *hardif_neigh;
+	struct batadv_priv *bat_priv;
 
 	hardif_neigh = container_of(ref, struct batadv_hardif_neigh_node,
 				    refcount);
@@ -277,6 +278,9 @@ void batadv_hardif_neigh_release(struct kref *ref)
 	hlist_del_init_rcu(&hardif_neigh->list);
 	spin_unlock_bh(&hardif_neigh->if_incoming->neigh_list_lock);
 
+	bat_priv = netdev_priv(hardif_neigh->if_incoming->mesh_iface);
+	atomic_dec(&bat_priv->neigh_learned);
+
 	batadv_hardif_put(hardif_neigh->if_incoming);
 	kfree_rcu(hardif_neigh, rcu);
 }
@@ -577,6 +581,8 @@ batadv_hardif_neigh_create(struct batadv_hard_iface *hard_iface,
 {
 	struct batadv_priv *bat_priv = netdev_priv(hard_iface->mesh_iface);
 	struct batadv_hardif_neigh_node *hardif_neigh;
+	u32 neigh_max_learned;
+	int neigh_learned;
 
 	spin_lock_bh(&hard_iface->neigh_list_lock);
 
@@ -585,9 +591,18 @@ batadv_hardif_neigh_create(struct batadv_hard_iface *hard_iface,
 	if (hardif_neigh)
 		goto out;
 
-	hardif_neigh = kzalloc_obj(*hardif_neigh, GFP_ATOMIC);
-	if (!hardif_neigh)
+	neigh_max_learned = READ_ONCE(bat_priv->neigh_max_learned);
+	neigh_learned = atomic_inc_return(&bat_priv->neigh_learned);
+	if (neigh_max_learned && neigh_learned > neigh_max_learned) {
+		atomic_dec(&bat_priv->neigh_learned);
 		goto out;
+	}
+
+	hardif_neigh = kzalloc_obj(*hardif_neigh, GFP_ATOMIC);
+	if (!hardif_neigh) {
+		atomic_dec(&bat_priv->neigh_learned);
+		goto out;
+	}
 
 	kref_get(&hard_iface->refcount);
 	INIT_HLIST_NODE(&hardif_neigh->list);
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 16ecbc45..b938f761 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -1730,6 +1730,12 @@ struct batadv_priv {
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

