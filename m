Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17EEEC531C9
	for <batman@archiver.kernel.org>; Fri, 24 Jul 2026 06:55:09 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 66D208459C
	for <batman@archiver.kernel.org>; Fri, 24 Jul 2026 08:55:07 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1784876107;
 b=yiOEygZoR2CHj4h97vqGXuVENJHG1VH1u/wB/fpqcBR8wm/+1JQCOGZGASxOyV+EUZGcm
 herpLyJdsibnfqoyF52v1uyOZMbseMJ2IRfmL+lAjAEqHGXlR3MGvoQEDdZ7kHh8HinyDYm
 JpBEi807PZuywru+uFa4fS5tkQ2/+A8=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1784876107; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=7rVnPep7XG5IQPUzicQb6NhrIoXfVH7tFzmnqPSn2Ug=;
 b=TbzARE1lhXLowhaDGMAePfzEfw0NtzUxqKEjbsybns27NWm10PPVQCoQwGO8fO/LpX17P
 m05uLkUGmD2koy9Su57IQlQV+vJOYi/WiYbn4ZIt3MhIBLtroC4EaMQ2GqH0Y/PAgoeh+Sa
 /YZHX0jlmWp/ARbXLa7K5g1bqm5VNII=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 4F45481893
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 24 Jul 2026 08:51:54 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1784875924;
	b=2Yj6ok0etQWNsDT4BVSnQjVDr/33YIaGYwaw6YDiRtXQ19rf9xw0DENEQ9fJQZktHF4oP6
	Bg6lvdw4I6ZltXhj34vSX/LGPN+hggn1Xi+kxB7k+11XYgxmg4tyBJHoeyFQVuA0t4Wn6Y
	gk2Zt8LpzTcPa/VJpixhFZ6SvbbE4y0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1784875924;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=7rVnPep7XG5IQPUzicQb6NhrIoXfVH7tFzmnqPSn2Ug=;
	b=BinpyuOLfsvxGVT0Xst4WUi25YZSqCIU7dno9+rUp2fUxd+zI/WDM5as4HGuz8ZzdjwoQQ
	cw3IsATKgKFJtx1+TZfX235dECJDORfYndMCtWuSiae/0OdOI9+LH3543fbZsu2Le9WjZc
	xanyJrGgPCHYqSiM71lDW6yUJL2ZiOs=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=bJuBQL00;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id C7C7C204D0;
	Fri, 24 Jul 2026 06:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1784875913;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7rVnPep7XG5IQPUzicQb6NhrIoXfVH7tFzmnqPSn2Ug=;
	b=bJuBQL00fbEAPdLfI7dui+5+/jJhd8Bu/fv0p+acbpRIpLakvE2B0RZHuyKQO4U2v+tzRo
	bLjxYMDRXC7E0E6+m/5XyH2Wpos0EnC06keIqGaKd+L+CMGNldDyMCm7I3ewn64NnlUssT
	KutBcZ+KLXtPxUqpiI6g0cCBXPW7sNw=
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 24 Jul 2026 08:51:40 +0200
Subject: [PATCH batadv v3 3/5] batman-adv: limit number of parallel learned
 DAT entries
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260724-resource-limit-v3-3-be845f27ff62@narfation.org>
References: <20260724-resource-limit-v3-0-be845f27ff62@narfation.org>
In-Reply-To: <20260724-resource-limit-v3-0-be845f27ff62@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5524; i=sven@narfation.org;
 h=from:subject:message-id; bh=60jJNGMumXLonf+ht384r2XqyWy/utzhU1YbSxPx1Hw=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFnJ3A3Ff0V75peURn3Nsom665MUH6UYEeIaM6N/3cwdy
 XH8l0M7SlkYxLgYZMUUWfZcyT+/mf2t/OdpH4/CzGFlAhnCwMUpABM5Oonhf0j71bOuPk66aveZ
 rnGvVBdcxN2be0ngb0aO2CWnw4cNoxkZJiXzbO82NimIPFnBcGZt/MO8JyYTymaE50yS/tjSkPO
 IDQA=
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: OVVYKTHQDVCN5QMIC34W7ANY5G2O4VTJ
X-Message-ID-Hash: OVVYKTHQDVCN5QMIC34W7ANY5G2O4VTJ
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/OVVYKTHQDVCN5QMIC34W7ANY5G2O4VTJ/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

A malicious actor behind one bridge port may spam the kernel with ARP/DHCP
using a random MAC address, causing the creation of a DAT entry, a dynamic
allocation in the kernel. This will at some point exhaust the available
memory.

Mitigate this by maintaining a per meshif count of those automatically
generated entries in dat.learned, and a limit in dat.max_learned. If the
limit is hit, new entries are not learned anymore.

For backwards compatibility, the default setting of 0 disables the limit.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 include/uapi/linux/batman_adv.h        |  6 ++++++
 net/batman-adv/distributed-arp-table.c | 17 +++++++++++++++--
 net/batman-adv/mesh-interface.c        |  3 +++
 net/batman-adv/netlink.c               | 10 ++++++++++
 net/batman-adv/types.h                 |  6 ++++++
 5 files changed, 40 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/batman_adv.h b/include/uapi/linux/batman_adv.h
index 325cd687..184f2bc8 100644
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
index bedd0cc7..9820a783 100644
--- a/net/batman-adv/distributed-arp-table.c
+++ b/net/batman-adv/distributed-arp-table.c
@@ -248,6 +248,7 @@ static void __batadv_dat_purge(struct batadv_priv *bat_priv,
 
 			hlist_del_rcu(&dat_entry->hash_entry);
 			batadv_dat_entry_put(dat_entry);
+			atomic_dec(&bat_priv->dat.learned);
 		}
 		spin_unlock_bh(list_lock);
 	}
@@ -446,6 +447,8 @@ static void batadv_dat_entry_add(struct batadv_priv *bat_priv, __be32 ip,
 {
 	u64 u64_mac = ether_addr_to_u64(mac_addr);
 	struct batadv_dat_entry *dat_entry;
+	u32 dat_max_learned;
+	int dat_learned;
 	int hash_added;
 
 	dat_entry = batadv_dat_entry_hash_find(bat_priv, ip, vid);
@@ -461,9 +464,18 @@ static void batadv_dat_entry_add(struct batadv_priv *bat_priv, __be32 ip,
 		goto out;
 	}
 
-	dat_entry = kmalloc_obj(*dat_entry, GFP_ATOMIC);
-	if (!dat_entry)
+	dat_max_learned = READ_ONCE(bat_priv->dat.max_learned);
+	dat_learned = atomic_inc_return(&bat_priv->dat.learned);
+	if (dat_max_learned && dat_learned > dat_max_learned) {
+		atomic_dec(&bat_priv->dat.learned);
 		goto out;
+	}
+
+	dat_entry = kmalloc_obj(*dat_entry, GFP_ATOMIC);
+	if (!dat_entry) {
+		atomic_dec(&bat_priv->dat.learned);
+		goto out;
+	}
 
 	dat_entry->ip = ip;
 	dat_entry->vid = vid;
@@ -479,6 +491,7 @@ static void batadv_dat_entry_add(struct batadv_priv *bat_priv, __be32 ip,
 	if (unlikely(hash_added != 0)) {
 		/* remove the reference for the hash */
 		batadv_dat_entry_put(dat_entry);
+		atomic_dec(&bat_priv->dat.learned);
 		goto out;
 	}
 
diff --git a/net/batman-adv/mesh-interface.c b/net/batman-adv/mesh-interface.c
index e9155ff3..a34fdd41 100644
--- a/net/batman-adv/mesh-interface.c
+++ b/net/batman-adv/mesh-interface.c
@@ -814,6 +814,9 @@ static int batadv_meshif_init_late(struct net_device *dev)
 #endif
 #ifdef CONFIG_BATMAN_ADV_DAT
 	WRITE_ONCE(bat_priv->distributed_arp_table, 1);
+
+	atomic_set(&bat_priv->dat.learned, 0);
+	WRITE_ONCE(bat_priv->dat.max_learned, 0);
 #endif
 #ifdef CONFIG_BATMAN_ADV_MCAST
 	WRITE_ONCE(bat_priv->multicast_mode, 1);
diff --git a/net/batman-adv/netlink.c b/net/batman-adv/netlink.c
index 41ed7aaf..d146d7c7 100644
--- a/net/batman-adv/netlink.c
+++ b/net/batman-adv/netlink.c
@@ -156,6 +156,7 @@ static const struct nla_policy batadv_netlink_policy[NUM_BATADV_ATTR] = {
 	[BATADV_ATTR_THROUGHPUT_OVERRIDE]	= { .type = NLA_U32 },
 	[BATADV_ATTR_NEIGH_MAX_LEARNED]		= { .type = NLA_U32 },
 	[BATADV_ATTR_ORIG_MAX_LEARNED]		= { .type = NLA_U32 },
+	[BATADV_ATTR_DAT_MAX_LEARNED]		= { .type = NLA_U32 },
 };
 
 /**
@@ -305,6 +306,10 @@ static int batadv_netlink_mesh_fill(struct sk_buff *msg,
 	if (nla_put_u8(msg, BATADV_ATTR_DISTRIBUTED_ARP_TABLE_ENABLED,
 		       !!READ_ONCE(bat_priv->distributed_arp_table)))
 		goto nla_put_failure;
+
+	if (nla_put_u32(msg, BATADV_ATTR_DAT_MAX_LEARNED,
+			READ_ONCE(bat_priv->dat.max_learned)))
+		goto nla_put_failure;
 #endif /* CONFIG_BATMAN_ADV_DAT */
 
 	if (nla_put_u8(msg, BATADV_ATTR_FRAGMENTATION_ENABLED,
@@ -495,6 +500,11 @@ static int batadv_netlink_set_mesh(struct sk_buff *skb, struct genl_info *info)
 			   !!nla_get_u8(attr));
 		batadv_dat_status_update(bat_priv->mesh_iface);
 	}
+
+	if (info->attrs[BATADV_ATTR_DAT_MAX_LEARNED]) {
+		WRITE_ONCE(bat_priv->dat.max_learned,
+			   nla_get_u32(info->attrs[BATADV_ATTR_DAT_MAX_LEARNED]));
+	}
 #endif /* CONFIG_BATMAN_ADV_DAT */
 
 	if (info->attrs[BATADV_ATTR_FRAGMENTATION_ENABLED]) {
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 66096bfe..6001273b 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -1200,6 +1200,12 @@ struct batadv_priv_dat {
 
 	/** @work: work queue callback item for cache purging */
 	struct delayed_work work;
+
+	/** @max_learned: Maximum number of DAT entries */
+	u32 max_learned;
+
+	/** @learned: current number of learned DAT entries */
+	atomic_t learned;
 };
 #endif
 

-- 
2.47.3

