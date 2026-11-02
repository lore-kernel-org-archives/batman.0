Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD70606A327
	for <batman@archiver.kernel.org>; Mon,  2 Nov 2026 21:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=narfation.org header.i=@narfation.org header.a=rsa-sha256 header.s=20121 header.b=gQCQA5jp
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id C432A844E8
	for <batman@archiver.kernel.org>; Mon, 02 Nov 2026 22:28:56 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1793654936;
 b=xlxlnbYmnABeROtvgzpGHduFb64qUt0+gqzUxI+7O616xbvtl0UVYTfzKHvUCoC8soAlf
 aCHzdl671rKEEWDj5pSpVOgNcL20tHhv8hycJS+ljwhZO5+kmOjzG6LjdHVeDqiQXM1uGPs
 eEtnniAZaH2Z82Cypowr7sJkf12dJQc=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1793654936; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=uTCr4PH8Pdfe7/I/TiK4+GKW6oJ6FWdc09W7JGdXakY=;
 b=VXXwNiAvFSU7Z2VL55c4ZTB0Z0kF1IimEtsc06AftndMXYBhiYL2nWnTUARVlG0jxyG4l
 UDnPodsQ9paRo4qcRXy6PZN312lrW+GVCjQzhXFtJE6xi+olI4bTr1/Tyiv1ZpXjD+KzJdk
 H4kTB+N6NrhCxlqQh3yHz7AKl/iCVhs=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id BA1C1820F3
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 02 Nov 2026 22:27:11 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1793654831;
	b=YBXZ6kws4hMiI91LnWUA4zYezVYWsQj2dE07BVBS2e053KLJoTrFtVw4tqH/OmLHHSNwkM
	wcyZAPxiI6LRXquarD0wNyl6faaXy+7HlCJgMf48s5OTeaLnKY6siZDPOwL8tl1UM3T4AJ
	Mj2HrYjqjKUcHWnpasy6/kAdP3NTCFA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1793654831;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=uTCr4PH8Pdfe7/I/TiK4+GKW6oJ6FWdc09W7JGdXakY=;
	b=IdcwmkMH9/pyaoznbCxrTuUyhbGu8jsWTfmz3CFzPg4k7ycmkzI+soVHFOMT5xGEIQgKC4
	x01GkK5oQpFhwHVbTxKBJQ1cEx+kdYHeFJ68GYEE45bLg28fddHgytdl1FHMnr8np091H8
	O/4QesWT4Akx2mEYKqm+qEspWFiTTXs=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=gQCQA5jp;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 5F0401FDF5;
	Mon, 02 Nov 2026 21:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1793654831;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uTCr4PH8Pdfe7/I/TiK4+GKW6oJ6FWdc09W7JGdXakY=;
	b=gQCQA5jpm2a4ivhymWYjk9VkxyfmTdkT5BcGGA6FLx075nGe3//2C+Be5A3pmON0MnZBhK
	s9G5Vyg1sD5FdRFCB3TVnIkDIffTLJdEz10S+0bgYqPkgY7FFHn8MlYK3b6IqdgDsoZOuR
	G1WeROjThYMxcm2oCEJcrAVl/zoebRc=
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 02 Nov 2026 22:26:59 +0100
Subject: [PATCH batadv v4 3/5] batman-adv: limit number of parallel learned
 DAT entries
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-resource-limit-v4-3-7ff9da793db4@narfation.org>
References: <20261102-resource-limit-v4-0-7ff9da793db4@narfation.org>
In-Reply-To: <20261102-resource-limit-v4-0-7ff9da793db4@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5601; i=sven@narfation.org;
 h=from:subject:message-id; bh=MiGtGeX6tQfz2u8QSvUKQsvdzOH3TDbnTRmVhzJqDvk=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFkvGVSdL1b/dmvZxnph3aS3ayJaxZzu1kdkM/7dtnU+O
 +/UHevmdJSyMIhxMciKKbLsuZJ/fjP7W/nP0z4ehZnDygQyhIGLUwAmonySkWHhWaOzy5RbVy4p
 nfd7diRLWhvD8fTItf31py4ybZrseVSdkeHRt1NKD249EH767kX9nuXSzKlhz3pl7GQcajX5G+Q
 2BrMCAA==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: NP3N3XM32BK73W2CRKVYR22TENCZGY5E
X-Message-ID-Hash: NP3N3XM32BK73W2CRKVYR22TENCZGY5E
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/NP3N3XM32BK73W2CRKVYR22TENCZGY5E/>
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

A malicious actor behind one bridge port may spam the kernel with ARP/DHCP
using a random IP address, causing the creation of a DAT entry, a dynamic
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
index e5c1d1d4..8cbdd384 100644
--- a/include/uapi/linux/batman_adv.h
+++ b/include/uapi/linux/batman_adv.h
@@ -493,6 +493,12 @@ enum batadv_nl_attrs {
 	 */
 	BATADV_ATTR_ORIG_MAX_LEARNED,
 
+	/**
+	 * @BATADV_ATTR_DAT_MAX_LEARNED: defines the maximum number of DAT entries
+	 * which can be learned in parallel. 0 disables the limit.
+	 */
+	BATADV_ATTR_DAT_MAX_LEARNED,
+
 	/* add attributes above here, update the policy in netlink.c */
 
 	/**
diff --git a/net/batman-adv/distributed-arp-table.c b/net/batman-adv/distributed-arp-table.c
index a6145383..7316d783 100644
--- a/net/batman-adv/distributed-arp-table.c
+++ b/net/batman-adv/distributed-arp-table.c
@@ -250,6 +250,7 @@ static void __batadv_dat_purge(struct batadv_priv *bat_priv,
 			hlist_del_rcu(&dat_entry->hash_entry);
 			atomic_inc(&bat_priv->dat.hash->generation);
 			batadv_dat_entry_put(dat_entry);
+			atomic_dec(&bat_priv->dat.learned);
 		}
 		spin_unlock_bh(list_lock);
 	}
@@ -445,6 +446,8 @@ static void batadv_dat_entry_add(struct batadv_priv *bat_priv, __be32 ip,
 {
 	u64 u64_mac = ether_addr_to_u64(mac_addr);
 	struct batadv_dat_entry *dat_entry;
+	u32 dat_max_learned;
+	int dat_learned;
 	int hash_added;
 
 	dat_entry = batadv_dat_entry_hash_find(bat_priv, ip, vid);
@@ -460,9 +463,18 @@ static void batadv_dat_entry_add(struct batadv_priv *bat_priv, __be32 ip,
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
 
 	dat_entry->key.ip = ip;
 	dat_entry->key.vid = vid;
@@ -478,6 +490,7 @@ static void batadv_dat_entry_add(struct batadv_priv *bat_priv, __be32 ip,
 	if (unlikely(hash_added != 0)) {
 		/* remove the reference for the hash */
 		batadv_dat_entry_put(dat_entry);
+		atomic_dec(&bat_priv->dat.learned);
 		goto out;
 	}
 
diff --git a/net/batman-adv/mesh-interface.c b/net/batman-adv/mesh-interface.c
index 581ec303..e21c0d10 100644
--- a/net/batman-adv/mesh-interface.c
+++ b/net/batman-adv/mesh-interface.c
@@ -839,6 +839,9 @@ static int batadv_meshif_init_late(struct net_device *dev)
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
index 37b6b925..12650156 100644
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
index 2b7916b5..4b42160e 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -1230,6 +1230,12 @@ struct batadv_priv_dat {
 
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

