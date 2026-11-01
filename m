Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF9B606A324
	for <batman@archiver.kernel.org>; Sun,  1 Nov 2026 18:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=narfation.org header.i=@narfation.org header.a=rsa-sha256 header.s=20121 header.b=lkCzRmfK
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id B67E9803DF
	for <batman@archiver.kernel.org>; Sun, 01 Nov 2026 19:26:46 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1793557606;
 b=G9eZl8WpN/J8C2pxbOs/vZJMOFBhz4v5wCFaapzHJsBzMnBnYevuNmlTcisUFO/Tat9QI
 Sv7wLdgDqcTDp6IVb/FUn9usUeLwb/y+8USWFhZnJJTW3LFQbqW3ClIlFK+5gn7frjzyyZ8
 d9bMfZNdfZJcp++bLLdp2wLEg5YaCy4=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1793557606; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=0u7jJY+FuvUanf7e+DrQchjVT9MDcU2R2mNH4xzhdpE=;
 b=uqKUMT6yO+xWZZdC5ZAjXGPoD+KIXyz2QRC0/I+W3za/iEVBFRAyGaIcKdIZDnBW2vx9S
 Xr62WePej/wDBJc+xU3PVcajeqsolEQbXTfxcnXAS5CB0tcRnvh1+rC3dUyjJb4EX9qs8LY
 zWFTGl1xAhnQmBzbM5U00P61fTK/REE=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 7DCB6840FD
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 01 Nov 2026 19:25:17 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1793557527;
	b=DLs+0HU10HhE3NHrizUxknn0tEop13h5VCfdzUBYVp0dGdKIMhSBglBOnKFXwoVxqA3Zdo
	RmF6mNMoR+Mxbb8USu6M0dbIIYnk3TbmK1TjSLop57O9rcZ6ge9MEcSuS7eKQDqvBMtMVM
	47YUej9MEgkKDxD0qQaGxPTy5hFdlHc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1793557527;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=0u7jJY+FuvUanf7e+DrQchjVT9MDcU2R2mNH4xzhdpE=;
	b=wioMUmnvzGKEP3ELpEdPx8SBHSYIyZG29Q705WoNtqBmygTkyFf2Ej2vlzTJWPW18tlILk
	FVtulK6BgXORtz5IyA1QbaSiubzJdWSNsnQwSRfBZWJPjNpn0exu57RsgY3XqZm3jpSq4Y
	Fi5sAvwYrrx5XxMOSSME+v81+Fw7czY=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=lkCzRmfK;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 122E621EE1;
	Sun, 01 Nov 2026 18:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1793557517;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0u7jJY+FuvUanf7e+DrQchjVT9MDcU2R2mNH4xzhdpE=;
	b=lkCzRmfKlefCfVwoa4jlaqiFLXVHah+5sbmXIP8snsQFghbz3oFS3GMAWKRdoo1JHl6k2I
	6E7UDW36K57qqPnc5DfrwCB8SOT+Y6jxk5/cnk5aPKQNLz39rTuZC1/WatBUv+B7W0kNso
	Chlgwl+gva+YncgPF65Ff2jcl7vTh4s=
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 01 Nov 2026 19:24:45 +0100
Subject: [PATCH batadv v2 2/2] batman-adv: mark functions inheriting
 critical sections
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261101-must_hold-v2-2-782bcc7d85fa@narfation.org>
References: <20261101-must_hold-v2-0-782bcc7d85fa@narfation.org>
In-Reply-To: <20261101-must_hold-v2-0-782bcc7d85fa@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=14032; i=sven@narfation.org;
 h=from:subject:message-id; bh=pUVXlLCY3a3U2+lOuqI7F68Gd7ObuYqloZXCri3gnfU=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFnPm7/JZb+PX3J+oWBUt3JAFNsdo7n/79QUbrjgwhflm
 bX12a7zHaUsDGJcDLJiiix7ruSf38z+Vv7ztI9HYeawMoEMYeDiFICJGHxiZPjGlZP085bprskL
 Jfbtv1e0Y0aX5ruwBaYvG679nTBZVnEXI8Ppx2onJWql9rTMdwtKmVYjUfxecJbrw/CelTydC6/
 xWLICAA==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: YW52SPOFF3LUM336BNOQTFJ4ZWJRN6BM
X-Message-ID-Hash: YW52SPOFF3LUM336BNOQTFJ4ZWJRN6BM
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/YW52SPOFF3LUM336BNOQTFJ4ZWJRN6BM/>
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

Various functions are not taking a lock themselves but are expecting the
caller to take care of holding the lock/RCU critical section. These are a
perfect use case for Compiler-Based Context Analysis.

For now, just mark these functions as preparation for __guarded_by().

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/bat_iv_ogm.c        |  3 +++
 net/batman-adv/bat_v.c             |  2 ++
 net/batman-adv/bat_v_ogm.c         |  4 ++++
 net/batman-adv/fragmentation.c     |  1 +
 net/batman-adv/fragmentation.h     |  1 +
 net/batman-adv/gateway_client.c    |  1 +
 net/batman-adv/multicast.c         | 14 ++++++++++++++
 net/batman-adv/translation-table.c |  4 ++++
 net/batman-adv/tvlv.c              |  3 +++
 9 files changed, 33 insertions(+)

diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index 4f60e50d..7b47c253 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -893,6 +893,7 @@ batadv_iv_ogm_slide_own_bcast_window(struct batadv_hard_iface *hard_iface)
  * @hard_iface: interface whose ogm buffer should be transmitted
  */
 static void batadv_iv_ogm_schedule_buff(struct batadv_hard_iface *hard_iface)
+	__must_hold(&hard_iface->bat_iv.ogm_buff_mutex)
 {
 	struct batadv_priv *bat_priv = netdev_priv(hard_iface->mesh_iface);
 	struct batadv_ogm_buf *ogm_buff = &hard_iface->bat_iv.ogm_buff;
@@ -2108,6 +2109,7 @@ batadv_iv_ogm_orig_dump_entry(struct sk_buff *msg, u32 portid, u32 seq,
 			      struct batadv_priv *bat_priv,
 			      struct batadv_hard_iface *if_outgoing,
 			      struct batadv_orig_node *orig_node, int *sub_s)
+	__must_hold_shared(RCU)
 {
 	struct batadv_neigh_node *neigh_node_best;
 	struct batadv_neigh_node *neigh_node;
@@ -2336,6 +2338,7 @@ batadv_iv_ogm_neigh_dump_hardif(struct sk_buff *msg, u32 portid, u32 seq,
 				struct batadv_priv *bat_priv,
 				struct batadv_hard_iface *hard_iface,
 				int *idx_s)
+	__must_hold_shared(RCU)
 {
 	struct batadv_hardif_neigh_node *hardif_neigh;
 	int idx = 0;
diff --git a/net/batman-adv/bat_v.c b/net/batman-adv/bat_v.c
index 1214e6f9..8de71a2c 100644
--- a/net/batman-adv/bat_v.c
+++ b/net/batman-adv/bat_v.c
@@ -213,6 +213,7 @@ batadv_v_neigh_dump_hardif(struct sk_buff *msg, u32 portid, u32 seq,
 			   struct batadv_priv *bat_priv,
 			   struct batadv_hard_iface *hard_iface,
 			   int *idx_s)
+	__must_hold_shared(RCU)
 {
 	struct batadv_hardif_neigh_node *hardif_neigh;
 	int idx = 0;
@@ -370,6 +371,7 @@ batadv_v_orig_dump_entry(struct sk_buff *msg, u32 portid, u32 seq,
 			 struct batadv_priv *bat_priv,
 			 struct batadv_hard_iface *if_outgoing,
 			 struct batadv_orig_node *orig_node, int *sub_s)
+	__must_hold_shared(RCU)
 {
 	struct batadv_neigh_node *neigh_node_best;
 	struct batadv_neigh_node *neigh_node;
diff --git a/net/batman-adv/bat_v_ogm.c b/net/batman-adv/bat_v_ogm.c
index c2ad9ac0..108bb144 100644
--- a/net/batman-adv/bat_v_ogm.c
+++ b/net/batman-adv/bat_v_ogm.c
@@ -163,6 +163,7 @@ static unsigned int batadv_v_ogm_len(struct sk_buff *skb)
  */
 static bool batadv_v_ogm_queue_left(struct sk_buff *skb,
 				    struct batadv_hard_iface *hard_iface)
+	__must_hold(&hard_iface->bat_v.aggr_list.lock)
 {
 	unsigned int max = min_t(unsigned int, hard_iface->net_dev->mtu,
 				 BATADV_MAX_AGGREGATION_BYTES);
@@ -182,6 +183,7 @@ static bool batadv_v_ogm_queue_left(struct sk_buff *skb,
  * Caller needs to hold the hard_iface->bat_v.aggr_list.lock.
  */
 static void batadv_v_ogm_aggr_list_free(struct batadv_hard_iface *hard_iface)
+	__must_hold(&hard_iface->bat_v.aggr_list.lock)
 {
 	lockdep_assert_held(&hard_iface->bat_v.aggr_list.lock);
 
@@ -201,6 +203,7 @@ static void batadv_v_ogm_aggr_list_free(struct batadv_hard_iface *hard_iface)
  * Caller needs to hold the hard_iface->bat_v.aggr_list.lock.
  */
 static void batadv_v_ogm_aggr_send(struct batadv_hard_iface *hard_iface)
+	__must_hold(&hard_iface->bat_v.aggr_list.lock)
 {
 	unsigned int aggr_len = hard_iface->bat_v.aggr_len;
 	struct sk_buff *skb_aggr;
@@ -269,6 +272,7 @@ static void batadv_v_ogm_queue_on_if(struct sk_buff *skb,
  * @bat_priv: the bat priv with all the mesh interface information
  */
 static void batadv_v_ogm_send_meshif(struct batadv_priv *bat_priv)
+	__must_hold(&bat_priv->bat_v.ogm_buff_mutex)
 {
 	struct batadv_ogm2_packet *ogm_packet;
 	struct batadv_hard_iface *hard_iface;
diff --git a/net/batman-adv/fragmentation.c b/net/batman-adv/fragmentation.c
index 3a9c4ea8..1224155b 100644
--- a/net/batman-adv/fragmentation.c
+++ b/net/batman-adv/fragmentation.c
@@ -107,6 +107,7 @@ static size_t batadv_frag_size_limit(void)
  */
 static bool batadv_frag_init_chain(struct batadv_frag_table_entry *chain,
 				   u16 seqno)
+	__must_hold(&chain->lock)
 {
 	lockdep_assert_held(&chain->lock);
 
diff --git a/net/batman-adv/fragmentation.h b/net/batman-adv/fragmentation.h
index 3c98a4f8..a0b93a4c 100644
--- a/net/batman-adv/fragmentation.h
+++ b/net/batman-adv/fragmentation.h
@@ -36,6 +36,7 @@ int batadv_frag_send_packet(struct sk_buff *skb,
  */
 static inline bool
 batadv_frag_check_entry(struct batadv_frag_table_entry *frags_entry)
+	__must_hold(&frags_entry->lock)
 {
 	if (!hlist_empty(&frags_entry->fragment_list) &&
 	    batadv_has_timed_out(frags_entry->timestamp, BATADV_FRAG_TIMEOUT))
diff --git a/net/batman-adv/gateway_client.c b/net/batman-adv/gateway_client.c
index 0dddcea7..20535164 100644
--- a/net/batman-adv/gateway_client.c
+++ b/net/batman-adv/gateway_client.c
@@ -335,6 +335,7 @@ void batadv_gw_check_election(struct batadv_priv *bat_priv,
 static void batadv_gw_node_add(struct batadv_priv *bat_priv,
 			       struct batadv_orig_node *orig_node,
 			       struct batadv_tvlv_gateway_data *gateway)
+	__must_hold(&bat_priv->gw.list_lock)
 {
 	struct batadv_gw_node *gw_node;
 
diff --git a/net/batman-adv/multicast.c b/net/batman-adv/multicast.c
index 4380241a..1ea2c773 100644
--- a/net/batman-adv/multicast.c
+++ b/net/batman-adv/multicast.c
@@ -110,6 +110,7 @@ batadv_mcast_get_bridge(struct net_device *mesh_iface)
  * Return: BATADV_NO_FLAGS if present, BATADV_MCAST_WANT_NO_RTR4 otherwise.
  */
 static u8 batadv_mcast_mla_rtr_flags_meshif_get_ipv4(struct net_device *dev)
+	__must_hold_shared(RCU)
 {
 	struct in_device *in_dev = __in_dev_get_rcu(dev);
 
@@ -132,6 +133,7 @@ static u8 batadv_mcast_mla_rtr_flags_meshif_get_ipv4(struct net_device *dev)
  */
 #if IS_ENABLED(CONFIG_IPV6_MROUTE)
 static u8 batadv_mcast_mla_rtr_flags_meshif_get_ipv6(struct net_device *dev)
+	__must_hold_shared(RCU)
 {
 	struct inet6_dev *in6_dev = __in6_dev_get(dev);
 
@@ -685,6 +687,7 @@ static void batadv_mcast_mla_list_free(struct hlist_head *mcast_list)
  */
 static void batadv_mcast_mla_tt_retract(struct batadv_priv *bat_priv,
 					struct hlist_head *mcast_list)
+	__must_hold(&bat_priv->mcast.mla_lock)
 {
 	struct batadv_hw_addr *mcast_entry;
 	struct hlist_node *tmp;
@@ -715,6 +718,7 @@ static void batadv_mcast_mla_tt_retract(struct batadv_priv *bat_priv,
  */
 static void batadv_mcast_mla_tt_add(struct batadv_priv *bat_priv,
 				    struct hlist_head *mcast_list)
+	__must_hold(&bat_priv->mcast.mla_lock)
 {
 	struct batadv_hw_addr *mcast_entry;
 	struct hlist_node *tmp;
@@ -763,6 +767,7 @@ static void
 batadv_mcast_querier_log(struct batadv_priv *bat_priv, char *str_proto,
 			 struct batadv_mcast_querier_state *old_state,
 			 struct batadv_mcast_querier_state *new_state)
+	__must_hold(&bat_priv->mcast.mla_lock)
 {
 	if (!old_state->exists && new_state->exists)
 		batadv_info(bat_priv->mesh_iface, "%s Querier appeared\n",
@@ -808,6 +813,7 @@ batadv_mcast_querier_log(struct batadv_priv *bat_priv, char *str_proto,
 static void
 batadv_mcast_bridge_log(struct batadv_priv *bat_priv,
 			struct batadv_mcast_mla_flags *new_flags)
+	__must_hold(&bat_priv->mcast.mla_lock)
 {
 	struct batadv_mcast_mla_flags *old_flags = &bat_priv->mcast.mla_flags;
 
@@ -837,6 +843,7 @@ batadv_mcast_bridge_log(struct batadv_priv *bat_priv,
  * should be used to notify userspace about the change.
  */
 static void batadv_mcast_flags_log(struct batadv_priv *bat_priv, u8 flags)
+	__must_hold(&bat_priv->mcast.mla_lock)
 {
 	bool old_enabled = bat_priv->mcast.mla_flags.enabled;
 	u8 old_flags = bat_priv->mcast.mla_flags.tvlv_flags;
@@ -872,6 +879,7 @@ static void batadv_mcast_flags_log(struct batadv_priv *bat_priv, u8 flags)
 static void
 batadv_mcast_mla_flags_update(struct batadv_priv *bat_priv,
 			      struct batadv_mcast_mla_flags *flags)
+	__must_hold(&bat_priv->mcast.mla_lock)
 {
 	struct batadv_tvlv_mcast_data mcast_data;
 
@@ -1618,6 +1626,7 @@ int batadv_mcast_forw_send(struct batadv_priv *bat_priv, struct sk_buff *skb,
 static void batadv_mcast_want_unsnoop_update(struct batadv_priv *bat_priv,
 					     struct batadv_orig_node *orig,
 					     u8 mcast_flags)
+	__must_hold(&orig->mcast_handler_lock)
 {
 	struct hlist_head *head = &bat_priv->mcast.want_all_unsnoopables_list;
 	struct hlist_node *node = &orig->mcast_want_all_unsnoopables_node;
@@ -1663,6 +1672,7 @@ static void batadv_mcast_want_unsnoop_update(struct batadv_priv *bat_priv,
 static void batadv_mcast_want_ipv4_update(struct batadv_priv *bat_priv,
 					  struct batadv_orig_node *orig,
 					  u8 mcast_flags)
+	__must_hold(&orig->mcast_handler_lock)
 {
 	struct hlist_head *head = &bat_priv->mcast.want_all_ipv4_list;
 	struct hlist_node *node = &orig->mcast_want_all_ipv4_node;
@@ -1708,6 +1718,7 @@ static void batadv_mcast_want_ipv4_update(struct batadv_priv *bat_priv,
 static void batadv_mcast_want_ipv6_update(struct batadv_priv *bat_priv,
 					  struct batadv_orig_node *orig,
 					  u8 mcast_flags)
+	__must_hold(&orig->mcast_handler_lock)
 {
 	struct hlist_head *head = &bat_priv->mcast.want_all_ipv6_list;
 	struct hlist_node *node = &orig->mcast_want_all_ipv6_node;
@@ -1753,6 +1764,7 @@ static void batadv_mcast_want_ipv6_update(struct batadv_priv *bat_priv,
 static void batadv_mcast_want_rtr4_update(struct batadv_priv *bat_priv,
 					  struct batadv_orig_node *orig,
 					  u8 mcast_flags)
+	__must_hold(&orig->mcast_handler_lock)
 {
 	struct hlist_head *head = &bat_priv->mcast.want_all_rtr4_list;
 	struct hlist_node *node = &orig->mcast_want_all_rtr4_node;
@@ -1798,6 +1810,7 @@ static void batadv_mcast_want_rtr4_update(struct batadv_priv *bat_priv,
 static void batadv_mcast_want_rtr6_update(struct batadv_priv *bat_priv,
 					  struct batadv_orig_node *orig,
 					  u8 mcast_flags)
+	__must_hold(&orig->mcast_handler_lock)
 {
 	struct hlist_head *head = &bat_priv->mcast.want_all_rtr6_list;
 	struct hlist_node *node = &orig->mcast_want_all_rtr6_node;
@@ -1841,6 +1854,7 @@ static void batadv_mcast_want_rtr6_update(struct batadv_priv *bat_priv,
 static void batadv_mcast_have_mc_ptype_update(struct batadv_priv *bat_priv,
 					      struct batadv_orig_node *orig,
 					      u8 mcast_flags)
+	__must_hold(&orig->mcast_handler_lock)
 {
 	lockdep_assert_held(&orig->mcast_handler_lock);
 
diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 346db140..b9407ad5 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -2419,6 +2419,7 @@ static bool batadv_tt_global_add(struct batadv_priv *bat_priv,
 static struct batadv_tt_orig_list_entry *
 batadv_transtable_best_orig(struct batadv_priv *bat_priv,
 			    struct batadv_tt_global_entry *tt_global_entry)
+	__must_hold_shared(RCU)
 {
 	struct batadv_tt_orig_list_entry *best_entry = NULL;
 	struct batadv_algo_ops *bao = bat_priv->algo_ops;
@@ -2532,6 +2533,7 @@ static int
 batadv_tt_global_dump_entry(struct sk_buff *msg, u32 portid, u32 seq,
 			    struct batadv_priv *bat_priv,
 			    struct batadv_tt_common_entry *common, int *sub_s)
+	__must_hold_shared(RCU)
 {
 	struct batadv_tt_orig_list_entry *orig_entry;
 	struct batadv_tt_orig_list_entry *best_entry;
@@ -2672,6 +2674,7 @@ int batadv_tt_global_dump(struct sk_buff *msg, struct netlink_callback *cb)
 static void
 _batadv_tt_global_del_orig_entry(struct batadv_tt_global_entry *tt_global_entry,
 				 struct batadv_tt_orig_list_entry *orig_entry)
+	__must_hold(&tt_global_entry->list_lock)
 {
 	lockdep_assert_held(&tt_global_entry->list_lock);
 
@@ -4545,6 +4548,7 @@ static void batadv_tt_local_purge_pending_clients(struct batadv_priv *bat_priv)
  * Caller must hold tt->commit_lock.
  */
 static void batadv_tt_local_commit_changes_nolock(struct batadv_priv *bat_priv)
+	__must_hold(&bat_priv->tt.commit_lock)
 {
 	LIST_HEAD(changes_list);
 	int changes_num;
diff --git a/net/batman-adv/tvlv.c b/net/batman-adv/tvlv.c
index d26f3f77..aa8dbaa5 100644
--- a/net/batman-adv/tvlv.c
+++ b/net/batman-adv/tvlv.c
@@ -136,6 +136,7 @@ static void batadv_tvlv_container_put(struct batadv_tvlv_container *tvlv)
  */
 static struct batadv_tvlv_container * __must_check
 batadv_tvlv_container_get(struct batadv_priv *bat_priv, u8 type, u8 version)
+	__must_hold(&bat_priv->tvlv.container_list_lock)
 {
 	struct batadv_tvlv_container *tvlv = NULL;
 	struct batadv_tvlv_container *tvlv_tmp;
@@ -168,6 +169,7 @@ batadv_tvlv_container_get(struct batadv_priv *bat_priv, u8 type, u8 version)
  * Return: size of all currently registered tvlv containers in bytes.
  */
 static size_t batadv_tvlv_container_list_size(struct batadv_priv *bat_priv)
+	__must_hold(&bat_priv->tvlv.container_list_lock)
 {
 	struct batadv_tvlv_container *tvlv;
 	size_t tvlv_len = 0;
@@ -193,6 +195,7 @@ static size_t batadv_tvlv_container_list_size(struct batadv_priv *bat_priv)
  */
 static void batadv_tvlv_container_remove(struct batadv_priv *bat_priv,
 					 struct batadv_tvlv_container *tvlv)
+	__must_hold(&bat_priv->tvlv.container_list_lock)
 {
 	lockdep_assert_held(&bat_priv->tvlv.container_list_lock);
 

-- 
2.47.3

