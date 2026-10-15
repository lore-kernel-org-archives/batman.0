Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC8E3CC6B2F
	for <batman@archiver.kernel.org>; Thu, 15 Oct 2026 07:09:16 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 01F4F8443B
	for <batman@archiver.kernel.org>; Thu, 15 Oct 2026 09:09:15 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1792048154;
 b=SNhkGWHPd+SCBe/D0qN+LG5Vr1Tf1lPvelfampzFMMJiVM6DW0fru1hbeRdO/8yxLPP4t
 2Y9BrcJndrCF5uIvgaeSFKvEltc1ZM4IWFLtHdAO5kEjnJI05sc+0H01cSpiz915ydURh9+
 8ecKJLnsrFzMRCC4a7EkmMyKivETC+A=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1792048154; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=ZkNoHx8I6IHPN/xO2SVZ8XxQ/gzvqFHMrCQ2Iy5Ytlc=;
 b=ljnLxC/bhWTbyCr86EPRe+J7nd61qM59db9GxlckphII8GmXVezZlcJ/b5hABeSSQm6jt
 HLhNrjWawaQQd+eo0LvNIqCrVz1wDGQBaKZuXffXNN2IHrSG9mvEWgdDhscJqQ5kD7M/yyR
 ZxbT8z7gGz9sUbxCDr+CBBgupzOOe2Q=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 3B19381D48
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 15 Oct 2026 09:08:55 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1792048145;
	b=bHPtxNhlwjB7uPx4bC2SgxPu++0cbKmEiCz9r6Lo9VfnrEvZ/5x2FTJHhnr3KEPX3tTCKN
	g0cTBkIzC/sKTP7NlGXsfPPjYO8/81NvQmdLw4h1ARaYOqcPGCBIrJCcYHK8QTdyDMsuDc
	4RR/nwucj0h/P9d18dsSfYeSpV9wOys=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1792048145;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=ZkNoHx8I6IHPN/xO2SVZ8XxQ/gzvqFHMrCQ2Iy5Ytlc=;
	b=ZucKKWLdYbRw2oVEXjaCwjtyi86cDM0UgbshAoI5ugkMY8y8et44vomeFOTRKN+A4Ye0D8
	1IhSiG/JpBvjk+0/nAr5dF9NlM7o8n8qdAlxHbKBf58U9QcLlGLYn/UJDD2i8ZJ9unEoBV
	gjY3P72A4mPkQ1dkYbgU67rN6bJAWa4=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=CzhxDBZC;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 4ACA420411;
	Thu, 15 Oct 2026 07:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1792048134;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ZkNoHx8I6IHPN/xO2SVZ8XxQ/gzvqFHMrCQ2Iy5Ytlc=;
	b=CzhxDBZCpsGpYnPx7AbGOAahnLz2OVDKts+b2JKWP7DJXX2uA4nA3tFjS80oyH6UHDDKi6
	ClcbMKKv5MazXnE8g23W74fQbKiovKhFjHRzzXNmBZEHnQLKFGdlu92t5AJ+25uPfey1TN
	axXm3eOZeUH/5bjce2HYz6n/Q5884HI=
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 15 Oct 2026 09:08:44 +0200
Subject: [PATCH batadv] batman-adv: mark functions inheriting critical
 sections
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-must_hold-v1-1-7ddbb82da7c3@narfation.org>
X-B4-Tracking: v=1; b=H4sIAPt70GoC/yWMUQqDMBAFryLvuwETNLS9SikSk1W3tFqyUQTx7
 qb1c4ZhNghFJsG92BBpYeFpzKAvBfzgxp4Uh8wwpbG61LX6zJKaYXoHdTO+oq6uvLVX5P4bqeP
 1/3qgdcmFBc/Ty9y+yKffCPt+AMdkWpV1AAAA
X-Change-ID: 20261015-must_hold-92c4ef54c668
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=14545; i=sven@narfation.org;
 h=from:subject:message-id; bh=zGNpZuVJGebkaIKTy5exMC5r/sYqftddTL9uvSsP194=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFkXapjFnW2lOedGsGUIvGc4/uZJ/hY/d4eXhu2pcdk3d
 ifsuHe/o5SFQYyLQVZMkWXPlfzzm9nfyn+e9vEozBxWJpAhDFycAjCRWVMZGS4su/K6ZGHhalGR
 Gf8eMR+I8c++FbnQ7b/9sg//rPfwP4xkZPiXv277Bfa+iohQe90uB932xfVbrsy590TI8q3w7nS
 ZfCYA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: 4PN6DXPINXZ56APVXDRYETZCRIAO3HEV
X-Message-ID-Hash: 4PN6DXPINXZ56APVXDRYETZCRIAO3HEV
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/4PN6DXPINXZ56APVXDRYETZCRIAO3HEV/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Various functions are not taking a lock themselves but are expecting the
caller to take care of holding the lock/RCU critical section. These are a
perfect use case for Compiler-Based Context Analysis.

For now, just mark these functions as preparation for __guarded_by().

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
The __guarded_by and also need following line at the beginning of
net/batman-adv/Makefile before it is possible to enable
`CONFIG_WARN_CONTEXT_ANALYSIS=y` with clang-23

CONTEXT_ANALYSIS := y

But I am not sure at the moment how to correctly handle some of the corner
cases of __guarded_by and thus didn't submit this part (yet).
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
index 85e99506..2ff2e446 100644
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
@@ -2105,6 +2106,7 @@ batadv_iv_ogm_orig_dump_entry(struct sk_buff *msg, u32 portid, u32 seq,
 			      struct batadv_priv *bat_priv,
 			      struct batadv_hard_iface *if_outgoing,
 			      struct batadv_orig_node *orig_node, int *sub_s)
+	__must_hold_shared(RCU)
 {
 	struct batadv_neigh_node *neigh_node_best;
 	struct batadv_neigh_node *neigh_node;
@@ -2331,6 +2333,7 @@ batadv_iv_ogm_neigh_dump_hardif(struct sk_buff *msg, u32 portid, u32 seq,
 				struct batadv_priv *bat_priv,
 				struct batadv_hard_iface *hard_iface,
 				int *idx_s)
+	__must_hold_shared(RCU)
 {
 	struct batadv_hardif_neigh_node *hardif_neigh;
 	int idx = 0;
diff --git a/net/batman-adv/bat_v.c b/net/batman-adv/bat_v.c
index 596889b3..9aea526d 100644
--- a/net/batman-adv/bat_v.c
+++ b/net/batman-adv/bat_v.c
@@ -210,6 +210,7 @@ batadv_v_neigh_dump_hardif(struct sk_buff *msg, u32 portid, u32 seq,
 			   struct batadv_priv *bat_priv,
 			   struct batadv_hard_iface *hard_iface,
 			   int *idx_s)
+	__must_hold_shared(RCU)
 {
 	struct batadv_hardif_neigh_node *hardif_neigh;
 	int idx = 0;
@@ -365,6 +366,7 @@ batadv_v_orig_dump_entry(struct sk_buff *msg, u32 portid, u32 seq,
 			 struct batadv_priv *bat_priv,
 			 struct batadv_hard_iface *if_outgoing,
 			 struct batadv_orig_node *orig_node, int *sub_s)
+	__must_hold_shared(RCU)
 {
 	struct batadv_neigh_node *neigh_node_best;
 	struct batadv_neigh_node *neigh_node;
diff --git a/net/batman-adv/bat_v_ogm.c b/net/batman-adv/bat_v_ogm.c
index 70846c99..1427f055 100644
--- a/net/batman-adv/bat_v_ogm.c
+++ b/net/batman-adv/bat_v_ogm.c
@@ -162,6 +162,7 @@ static unsigned int batadv_v_ogm_len(struct sk_buff *skb)
  */
 static bool batadv_v_ogm_queue_left(struct sk_buff *skb,
 				    struct batadv_hard_iface *hard_iface)
+	__must_hold(&hard_iface->bat_v.aggr_list.lock)
 {
 	unsigned int max = min_t(unsigned int, hard_iface->net_dev->mtu,
 				 BATADV_MAX_AGGREGATION_BYTES);
@@ -181,6 +182,7 @@ static bool batadv_v_ogm_queue_left(struct sk_buff *skb,
  * Caller needs to hold the hard_iface->bat_v.aggr_list.lock.
  */
 static void batadv_v_ogm_aggr_list_free(struct batadv_hard_iface *hard_iface)
+	__must_hold(&hard_iface->bat_v.aggr_list.lock)
 {
 	lockdep_assert_held(&hard_iface->bat_v.aggr_list.lock);
 
@@ -200,6 +202,7 @@ static void batadv_v_ogm_aggr_list_free(struct batadv_hard_iface *hard_iface)
  * Caller needs to hold the hard_iface->bat_v.aggr_list.lock.
  */
 static void batadv_v_ogm_aggr_send(struct batadv_hard_iface *hard_iface)
+	__must_hold(&hard_iface->bat_v.aggr_list.lock)
 {
 	unsigned int aggr_len = hard_iface->bat_v.aggr_len;
 	struct sk_buff *skb_aggr;
@@ -268,6 +271,7 @@ static void batadv_v_ogm_queue_on_if(struct sk_buff *skb,
  * @bat_priv: the bat priv with all the mesh interface information
  */
 static void batadv_v_ogm_send_meshif(struct batadv_priv *bat_priv)
+	__must_hold(&bat_priv->bat_v.ogm_buff_mutex)
 {
 	struct batadv_ogm2_packet *ogm_packet;
 	struct batadv_hard_iface *hard_iface;
diff --git a/net/batman-adv/fragmentation.c b/net/batman-adv/fragmentation.c
index 493af309..ac0478ed 100644
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
index 51e28102..0b687fd2 100644
--- a/net/batman-adv/fragmentation.h
+++ b/net/batman-adv/fragmentation.h
@@ -35,6 +35,7 @@ int batadv_frag_send_packet(struct sk_buff *skb,
  */
 static inline bool
 batadv_frag_check_entry(struct batadv_frag_table_entry *frags_entry)
+	__must_hold(&frags_entry->lock)
 {
 	if (!hlist_empty(&frags_entry->fragment_list) &&
 	    batadv_has_timed_out(frags_entry->timestamp, BATADV_FRAG_TIMEOUT))
diff --git a/net/batman-adv/gateway_client.c b/net/batman-adv/gateway_client.c
index e6e97c04..51234e4f 100644
--- a/net/batman-adv/gateway_client.c
+++ b/net/batman-adv/gateway_client.c
@@ -333,6 +333,7 @@ void batadv_gw_check_election(struct batadv_priv *bat_priv,
 static void batadv_gw_node_add(struct batadv_priv *bat_priv,
 			       struct batadv_orig_node *orig_node,
 			       struct batadv_tvlv_gateway_data *gateway)
+	__must_hold(&bat_priv->gw.list_lock)
 {
 	struct batadv_gw_node *gw_node;
 
diff --git a/net/batman-adv/multicast.c b/net/batman-adv/multicast.c
index 22dd28d5..6ebab4eb 100644
--- a/net/batman-adv/multicast.c
+++ b/net/batman-adv/multicast.c
@@ -108,6 +108,7 @@ static struct net_device *batadv_mcast_get_bridge(struct net_device *mesh_iface)
  * Return: BATADV_NO_FLAGS if present, BATADV_MCAST_WANT_NO_RTR4 otherwise.
  */
 static u8 batadv_mcast_mla_rtr_flags_meshif_get_ipv4(struct net_device *dev)
+	__must_hold_shared(RCU)
 {
 	struct in_device *in_dev = __in_dev_get_rcu(dev);
 
@@ -130,6 +131,7 @@ static u8 batadv_mcast_mla_rtr_flags_meshif_get_ipv4(struct net_device *dev)
  */
 #if IS_ENABLED(CONFIG_IPV6_MROUTE)
 static u8 batadv_mcast_mla_rtr_flags_meshif_get_ipv6(struct net_device *dev)
+	__must_hold_shared(RCU)
 {
 	struct inet6_dev *in6_dev = __in6_dev_get(dev);
 
@@ -683,6 +685,7 @@ static void batadv_mcast_mla_list_free(struct hlist_head *mcast_list)
  */
 static void batadv_mcast_mla_tt_retract(struct batadv_priv *bat_priv,
 					struct hlist_head *mcast_list)
+	__must_hold(&bat_priv->mcast.mla_lock)
 {
 	struct batadv_hw_addr *mcast_entry;
 	struct hlist_node *tmp;
@@ -713,6 +716,7 @@ static void batadv_mcast_mla_tt_retract(struct batadv_priv *bat_priv,
  */
 static void batadv_mcast_mla_tt_add(struct batadv_priv *bat_priv,
 				    struct hlist_head *mcast_list)
+	__must_hold(&bat_priv->mcast.mla_lock)
 {
 	struct batadv_hw_addr *mcast_entry;
 	struct hlist_node *tmp;
@@ -761,6 +765,7 @@ static void
 batadv_mcast_querier_log(struct batadv_priv *bat_priv, char *str_proto,
 			 struct batadv_mcast_querier_state *old_state,
 			 struct batadv_mcast_querier_state *new_state)
+	__must_hold(&bat_priv->mcast.mla_lock)
 {
 	if (!old_state->exists && new_state->exists)
 		batadv_info(bat_priv->mesh_iface, "%s Querier appeared\n",
@@ -806,6 +811,7 @@ batadv_mcast_querier_log(struct batadv_priv *bat_priv, char *str_proto,
 static void
 batadv_mcast_bridge_log(struct batadv_priv *bat_priv,
 			struct batadv_mcast_mla_flags *new_flags)
+	__must_hold(&bat_priv->mcast.mla_lock)
 {
 	struct batadv_mcast_mla_flags *old_flags = &bat_priv->mcast.mla_flags;
 
@@ -835,6 +841,7 @@ batadv_mcast_bridge_log(struct batadv_priv *bat_priv,
  * should be used to notify userspace about the change.
  */
 static void batadv_mcast_flags_log(struct batadv_priv *bat_priv, u8 flags)
+	__must_hold(&bat_priv->mcast.mla_lock)
 {
 	bool old_enabled = bat_priv->mcast.mla_flags.enabled;
 	u8 old_flags = bat_priv->mcast.mla_flags.tvlv_flags;
@@ -870,6 +877,7 @@ static void batadv_mcast_flags_log(struct batadv_priv *bat_priv, u8 flags)
 static void
 batadv_mcast_mla_flags_update(struct batadv_priv *bat_priv,
 			      struct batadv_mcast_mla_flags *flags)
+	__must_hold(&bat_priv->mcast.mla_lock)
 {
 	struct batadv_tvlv_mcast_data mcast_data;
 
@@ -1612,6 +1620,7 @@ int batadv_mcast_forw_send(struct batadv_priv *bat_priv, struct sk_buff *skb,
 static void batadv_mcast_want_unsnoop_update(struct batadv_priv *bat_priv,
 					     struct batadv_orig_node *orig,
 					     u8 mcast_flags)
+	__must_hold(&orig->mcast_handler_lock)
 {
 	struct hlist_head *head = &bat_priv->mcast.want_all_unsnoopables_list;
 	struct hlist_node *node = &orig->mcast_want_all_unsnoopables_node;
@@ -1657,6 +1666,7 @@ static void batadv_mcast_want_unsnoop_update(struct batadv_priv *bat_priv,
 static void batadv_mcast_want_ipv4_update(struct batadv_priv *bat_priv,
 					  struct batadv_orig_node *orig,
 					  u8 mcast_flags)
+	__must_hold(&orig->mcast_handler_lock)
 {
 	struct hlist_head *head = &bat_priv->mcast.want_all_ipv4_list;
 	struct hlist_node *node = &orig->mcast_want_all_ipv4_node;
@@ -1702,6 +1712,7 @@ static void batadv_mcast_want_ipv4_update(struct batadv_priv *bat_priv,
 static void batadv_mcast_want_ipv6_update(struct batadv_priv *bat_priv,
 					  struct batadv_orig_node *orig,
 					  u8 mcast_flags)
+	__must_hold(&orig->mcast_handler_lock)
 {
 	struct hlist_head *head = &bat_priv->mcast.want_all_ipv6_list;
 	struct hlist_node *node = &orig->mcast_want_all_ipv6_node;
@@ -1747,6 +1758,7 @@ static void batadv_mcast_want_ipv6_update(struct batadv_priv *bat_priv,
 static void batadv_mcast_want_rtr4_update(struct batadv_priv *bat_priv,
 					  struct batadv_orig_node *orig,
 					  u8 mcast_flags)
+	__must_hold(&orig->mcast_handler_lock)
 {
 	struct hlist_head *head = &bat_priv->mcast.want_all_rtr4_list;
 	struct hlist_node *node = &orig->mcast_want_all_rtr4_node;
@@ -1792,6 +1804,7 @@ static void batadv_mcast_want_rtr4_update(struct batadv_priv *bat_priv,
 static void batadv_mcast_want_rtr6_update(struct batadv_priv *bat_priv,
 					  struct batadv_orig_node *orig,
 					  u8 mcast_flags)
+	__must_hold(&orig->mcast_handler_lock)
 {
 	struct hlist_head *head = &bat_priv->mcast.want_all_rtr6_list;
 	struct hlist_node *node = &orig->mcast_want_all_rtr6_node;
@@ -1835,6 +1848,7 @@ static void batadv_mcast_want_rtr6_update(struct batadv_priv *bat_priv,
 static void batadv_mcast_have_mc_ptype_update(struct batadv_priv *bat_priv,
 					      struct batadv_orig_node *orig,
 					      u8 mcast_flags)
+	__must_hold(&orig->mcast_handler_lock)
 {
 	lockdep_assert_held(&orig->mcast_handler_lock);
 
diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index e46040fd..2b9e9fd2 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -2357,6 +2357,7 @@ static bool batadv_tt_global_add(struct batadv_priv *bat_priv,
 static struct batadv_tt_orig_list_entry *
 batadv_transtable_best_orig(struct batadv_priv *bat_priv,
 			    struct batadv_tt_global_entry *tt_global_entry)
+	__must_hold_shared(RCU)
 {
 	struct batadv_tt_orig_list_entry *best_entry = NULL;
 	struct batadv_algo_ops *bao = bat_priv->algo_ops;
@@ -2470,6 +2471,7 @@ static int
 batadv_tt_global_dump_entry(struct sk_buff *msg, u32 portid, u32 seq,
 			    struct batadv_priv *bat_priv,
 			    struct batadv_tt_common_entry *common, int *sub_s)
+	__must_hold_shared(RCU)
 {
 	struct batadv_tt_orig_list_entry *orig_entry;
 	struct batadv_tt_orig_list_entry *best_entry;
@@ -2610,6 +2612,7 @@ int batadv_tt_global_dump(struct sk_buff *msg, struct netlink_callback *cb)
 static void
 _batadv_tt_global_del_orig_entry(struct batadv_tt_global_entry *tt_global_entry,
 				 struct batadv_tt_orig_list_entry *orig_entry)
+	__must_hold(&tt_global_entry->list_lock)
 {
 	lockdep_assert_held(&tt_global_entry->list_lock);
 
@@ -4464,6 +4467,7 @@ static void batadv_tt_local_purge_pending_clients(struct batadv_priv *bat_priv)
  * Caller must hold tt->commit_lock.
  */
 static void batadv_tt_local_commit_changes_nolock(struct batadv_priv *bat_priv)
+	__must_hold(&bat_priv->tt.commit_lock)
 {
 	lockdep_assert_held(&bat_priv->tt.commit_lock);
 
diff --git a/net/batman-adv/tvlv.c b/net/batman-adv/tvlv.c
index 93492d39..d1e402e2 100644
--- a/net/batman-adv/tvlv.c
+++ b/net/batman-adv/tvlv.c
@@ -134,6 +134,7 @@ static void batadv_tvlv_container_put(struct batadv_tvlv_container *tvlv)
  */
 static struct batadv_tvlv_container *
 batadv_tvlv_container_get(struct batadv_priv *bat_priv, u8 type, u8 version)
+	__must_hold(&bat_priv->tvlv.container_list_lock)
 {
 	struct batadv_tvlv_container *tvlv = NULL;
 	struct batadv_tvlv_container *tvlv_tmp;
@@ -166,6 +167,7 @@ batadv_tvlv_container_get(struct batadv_priv *bat_priv, u8 type, u8 version)
  * Return: size of all currently registered tvlv containers in bytes.
  */
 static size_t batadv_tvlv_container_list_size(struct batadv_priv *bat_priv)
+	__must_hold(&bat_priv->tvlv.container_list_lock)
 {
 	struct batadv_tvlv_container *tvlv;
 	size_t tvlv_len = 0;
@@ -191,6 +193,7 @@ static size_t batadv_tvlv_container_list_size(struct batadv_priv *bat_priv)
  */
 static void batadv_tvlv_container_remove(struct batadv_priv *bat_priv,
 					 struct batadv_tvlv_container *tvlv)
+	__must_hold(&bat_priv->tvlv.container_list_lock)
 {
 	lockdep_assert_held(&bat_priv->tvlv.container_list_lock);
 

---
base-commit: 0eaac0f4187bc9b69b41d90998fd7b93ab07e53e
change-id: 20261015-must_hold-92c4ef54c668

Best regards,
--  
Sven Eckelmann <sven@narfation.org>

