Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C086BCD4F58
	for <batman@archiver.kernel.org>; Tue, 19 May 2026 07:07:07 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 4174A81088
	for <batman@archiver.kernel.org>; Tue, 19 May 2026 09:07:02 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1779174422;
 b=DV49XGymanqfrqxtB93ld7SdI/YZoyMVG8tbXjnGX6JUd8jtf8/flnI4iv+eUJ1L0bxNf
 7lPON5w5NjgSsG/NGOMIKXoisvvcEheAnE2fisiExQBtSUuikOs7puI1YZUwHS72fB2D9QF
 trW3l6XzwKeVB31joUFKKpL5wrQ7HR4=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1779174422; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=D3KESNwnXk6D630XKfQfUQv6ri7+an2cla86fjTZ4OY=;
 b=X8iZNxBrGsawtgGFuKUhwbN9QHiNvfoGE7cnITdCz4GPLUTEAUM7G14F4tEYQIO9UA5Wj
 6V0yj6T2j4Dr5Yhhdsq99LvGvplRJUh+aiVAaUvRmMZRhDjIK7b4tsEyThS1rtGeTJc9Pyb
 urhFyReGS4bWcPAbFnOwleUDs5uWUf4=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 96EE980BFC
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 19 May 2026 09:02:37 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1779174157;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=D3KESNwnXk6D630XKfQfUQv6ri7+an2cla86fjTZ4OY=;
	b=IL6rjVG9tzSDbXYzjAkfzAlE/wfCF7X0K8aJl9bVGwvqWDdqFUIjLRmQa649X0YiMJUvhl
	GXfX+CZdS3hclHs6eLKGYxZC7Del5IVDlApdwt9vX1O19UQhNe+ruZDTTFCKRA0Q062UcC
	4hG1Shp5LhpYfPpjErp2sU6kKxBn0pY=
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1779174157;
	b=SqeJ9dZRPTMbbukWLteuj9yU4IF8mpH9NXDGGUlhQQZ6utKKpdz1zkyspzTdsMw/RsPVgA
	p1oryUlZnvPp1C9NOIpKg5gwma/os55RWMFOyLbWYDPNsPHpNsQjNlNH+FrZahNHLU7YAi
	CYdGi8kJ8dGiCg0tRTOoM0agElm8YJc=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=v3SaJysF;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 4ECC81FE24;
	Tue, 19 May 2026 07:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1779174157;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D3KESNwnXk6D630XKfQfUQv6ri7+an2cla86fjTZ4OY=;
	b=v3SaJysFHOCSom7U85GKHAO/vQFMkUvSWbnsxBdfj+zUltxrXWbMXoVmx9cf8NqJHrV15T
	PWjmc91ai2UvosMBlwSj+iTHh4SP8eLG1aNPUxyb2Sluc+HkcCSZJlleun7Bh7/HueTy3Y
	sPxCF2VCB0c96Q9xnJR6US0sYqwQDa8=
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 19 May 2026 09:02:17 +0200
Subject: [PATCH RFC batadv v2 3/5] batman-adv: limit numbers of parallel
 learned DAT entries
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-resource-limit-v2-3-489c3c919a54@narfation.org>
References: <20260519-resource-limit-v2-0-489c3c919a54@narfation.org>
In-Reply-To: <20260519-resource-limit-v2-0-489c3c919a54@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5670; i=sven@narfation.org;
 h=from:subject:message-id; bh=sJdw6rnyx9MrV3ZGEiE+HWBnaD3qfhP+sC+vVCPfZ2I=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFk8XD9a7+mWec5XPSFpoP5opdQRp/0c9f82x5s8YS38U
 ihxaPaZjlIWBjEuBlkxRZY9V/LPb2Z/K/952sejMHNYmUCGMHBxCsBEgoQYGT52Z8bEhXhp3HE5
 /mlZccjb6TucV022OvZ5meD23rN2GzwY/meurDgb8/dx3/W8JRlztVauu/qt+Ef5Ssc7y7sVbQq
 9njABAA==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: 3Y5PSSSRPWQRFRWYGUSFQTCHUQENSLNO
X-Message-ID-Hash: 3Y5PSSSRPWQRFRWYGUSFQTCHUQENSLNO
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/3Y5PSSSRPWQRFRWYGUSFQTCHUQENSLNO/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

A malicious actor behind one bridge port may spam the kernel with OGMs with
a random source MAC address, each of which will create a DAT entry, each of
which is a dynamic allocation in the kernel. This will at some point
exhaust the available memory.

Mitigate this by maintaining a per meshif count of those automatically
generated entries in orig_learned, and a limit in orig_max_learned. If the
limit is hit new entries are not learned anymore.

For backwards compatibility, the default setting of 0 disables the limit.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 include/uapi/linux/batman_adv.h        |  6 ++++++
 net/batman-adv/distributed-arp-table.c | 11 +++++++++++
 net/batman-adv/mesh-interface.c        |  3 +++
 net/batman-adv/netlink.c               | 10 ++++++++++
 net/batman-adv/types.h                 |  6 ++++++
 5 files changed, 36 insertions(+)

diff --git a/include/uapi/linux/batman_adv.h b/include/uapi/linux/batman_adv.h
index b3c04ab0..cca87d42 100644
--- a/include/uapi/linux/batman_adv.h
+++ b/include/uapi/linux/batman_adv.h
@@ -493,6 +493,12 @@ enum batadv_nl_attrs {
 	 */
 	BATADV_ATTR_ORIG_MAX_LEARNED,
 
+	/**
+	 * @BATADV_ATTR_DAT_MAX_LEARNED: defines the maximum number of DAT entries
+	 * which can be learned in parallel
+	 */
+	BATADV_ATTR_DAT_MAX_LEARNED,
+
 	/* add attributes above here, update the policy in netlink.c */
 
 	/**
diff --git a/net/batman-adv/distributed-arp-table.c b/net/batman-adv/distributed-arp-table.c
index 0a8bd95e..99569a2f 100644
--- a/net/batman-adv/distributed-arp-table.c
+++ b/net/batman-adv/distributed-arp-table.c
@@ -181,6 +181,7 @@ static void __batadv_dat_purge(struct batadv_priv *bat_priv,
 
 			hlist_del_rcu(&dat_entry->hash_entry);
 			batadv_dat_entry_put(dat_entry);
+			atomic_dec(&bat_priv->dat_learned);
 		}
 		spin_unlock_bh(list_lock);
 	}
@@ -366,6 +367,8 @@ static void batadv_dat_entry_add(struct batadv_priv *bat_priv, __be32 ip,
 				 u8 *mac_addr, unsigned short vid)
 {
 	struct batadv_dat_entry *dat_entry;
+	u32 dat_max_learned;
+	int dat_learned;
 	int hash_added;
 
 	dat_entry = batadv_dat_entry_hash_find(bat_priv, ip, vid);
@@ -381,6 +384,11 @@ static void batadv_dat_entry_add(struct batadv_priv *bat_priv, __be32 ip,
 		goto out;
 	}
 
+	dat_max_learned = READ_ONCE(bat_priv->dat_max_learned);
+	dat_learned = atomic_read(&bat_priv->dat_learned);
+	if (dat_max_learned && dat_learned >= dat_max_learned)
+		goto out;
+
 	dat_entry = kmalloc_obj(*dat_entry, GFP_ATOMIC);
 	if (!dat_entry)
 		goto out;
@@ -391,6 +399,8 @@ static void batadv_dat_entry_add(struct batadv_priv *bat_priv, __be32 ip,
 	dat_entry->last_update = jiffies;
 	kref_init(&dat_entry->refcount);
 
+	atomic_inc(&bat_priv->dat_learned);
+
 	kref_get(&dat_entry->refcount);
 	hash_added = batadv_hash_add(bat_priv->dat.hash, batadv_compare_dat,
 				     batadv_hash_dat, dat_entry,
@@ -399,6 +409,7 @@ static void batadv_dat_entry_add(struct batadv_priv *bat_priv, __be32 ip,
 	if (unlikely(hash_added != 0)) {
 		/* remove the reference for the hash */
 		batadv_dat_entry_put(dat_entry);
+		atomic_dec(&bat_priv->dat_learned);
 		goto out;
 	}
 
diff --git a/net/batman-adv/mesh-interface.c b/net/batman-adv/mesh-interface.c
index fad788cc..851a078d 100644
--- a/net/batman-adv/mesh-interface.c
+++ b/net/batman-adv/mesh-interface.c
@@ -759,6 +759,9 @@ static int batadv_meshif_init_late(struct net_device *dev)
 #endif
 #ifdef CONFIG_BATMAN_ADV_DAT
 	atomic_set(&bat_priv->distributed_arp_table, 1);
+
+	atomic_set(&bat_priv->dat_learned, 0);
+	WRITE_ONCE(bat_priv->dat_max_learned, 0);
 #endif
 #ifdef CONFIG_BATMAN_ADV_MCAST
 	atomic_set(&bat_priv->multicast_mode, 1);
diff --git a/net/batman-adv/netlink.c b/net/batman-adv/netlink.c
index 2b5fb1d6..742b1e3e 100644
--- a/net/batman-adv/netlink.c
+++ b/net/batman-adv/netlink.c
@@ -149,6 +149,7 @@ static const struct nla_policy batadv_netlink_policy[NUM_BATADV_ATTR] = {
 	[BATADV_ATTR_THROUGHPUT_OVERRIDE]	= { .type = NLA_U32 },
 	[BATADV_ATTR_NEIGH_MAX_LEARNED]		= { .type = NLA_U32 },
 	[BATADV_ATTR_ORIG_MAX_LEARNED]		= { .type = NLA_U32 },
+	[BATADV_ATTR_DAT_MAX_LEARNED]		= { .type = NLA_U32 },
 };
 
 /**
@@ -298,6 +299,10 @@ static int batadv_netlink_mesh_fill(struct sk_buff *msg,
 	if (nla_put_u8(msg, BATADV_ATTR_DISTRIBUTED_ARP_TABLE_ENABLED,
 		       !!atomic_read(&bat_priv->distributed_arp_table)))
 		goto nla_put_failure;
+
+	if (nla_put_u32(msg, BATADV_ATTR_DAT_MAX_LEARNED,
+			READ_ONCE(bat_priv->dat_max_learned)))
+		goto nla_put_failure;
 #endif /* CONFIG_BATMAN_ADV_DAT */
 
 	if (nla_put_u8(msg, BATADV_ATTR_FRAGMENTATION_ENABLED,
@@ -488,6 +493,11 @@ static int batadv_netlink_set_mesh(struct sk_buff *skb, struct genl_info *info)
 			   !!nla_get_u8(attr));
 		batadv_dat_status_update(bat_priv->mesh_iface);
 	}
+
+	if (info->attrs[BATADV_ATTR_DAT_MAX_LEARNED]) {
+		WRITE_ONCE(bat_priv->dat_max_learned,
+			   nla_get_u32(info->attrs[BATADV_ATTR_DAT_MAX_LEARNED]));
+	}
 #endif /* CONFIG_BATMAN_ADV_DAT */
 
 	if (info->attrs[BATADV_ATTR_FRAGMENTATION_ENABLED]) {
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 49398aeb..c8bf2212 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -1535,6 +1535,12 @@ struct batadv_priv {
 	 *  is enabled
 	 */
 	atomic_t distributed_arp_table;
+
+	/** @dat_max_learned: Maximum number of DAT entries */
+	u32 dat_max_learned;
+
+	/** @dat_learned: current number of learned DAT entries */
+	atomic_t dat_learned;
 #endif
 
 #ifdef CONFIG_BATMAN_ADV_MCAST

-- 
2.47.3

