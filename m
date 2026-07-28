Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6028EC54F4C
	for <batman@archiver.kernel.org>; Tue, 28 Jul 2026 14:04:29 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id B2C3384544
	for <batman@archiver.kernel.org>; Tue, 28 Jul 2026 16:04:23 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1785247463;
 b=ZzWtIgiGUZQvE5qZ57Qu+cN8Pa0mTLFRIN2a8Lemcftogg0pUJClW/R9a0X2NLsq50vpA
 utBMYVXG8sWbH9dzKn8xrgNZzcmeD5bShIU2GP8cjg/OJqRIEFRbe5VpiXV3Hxd+Mo6iABL
 6j2HVOIBV3ku5R1BBvyL1jplJMu+uj0=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1785247463; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=+agXVKeACnz2LqdKfwMHgcXg8V+GOB1c80k2rMyCpt4=;
 b=r65v8KPRcBwEMyIJjQwJFhe/Y/dwirXqRu89bzYVcDu1SQntjls5WixnGpYq/iIHDwuVO
 /IpCoc12xBbPle28aIrI5VLnwRbza7wFTqjA0oxwNQjIeOSXifBS4OMWk/IyeuIIJgWv8SE
 vZyZEOepKRx+0vlyicO7tYseB04la2g=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 19437846DF
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 28 Jul 2026 15:39:29 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1785245969;
	b=r+HNdEO8cHk4WPk9QMjAdES5EwF+4bkocro1bpRPuFZfbMYl+LWvDKEgbp/+qrudqlnSIo
	yw2lTTt1LG8Kn1YfsWbSEus2d0CFnwQhdnTrYrgr/o9LHXPgCJVs2EuZ7tkNWGVLdQEkIf
	B2e3dTLEzMSkqu7svZJpBiIi6zi+Bu8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1785245969;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=+agXVKeACnz2LqdKfwMHgcXg8V+GOB1c80k2rMyCpt4=;
	b=c4awivtZIBnqYCUH6nPRyd3thFDzcJTIS6Tw6wB+OVHQy9OdwEGwYaMKZweRj+YNCZOw1i
	5+JY2u1enA1uAL4OxEVYpFRroqOtQTP9+ZXxpliWav2FGxRxYpeUJ+AM8OaUMRny46BFp3
	oC7HkE+MOul6j+55XIgBgNY9/BF8pr8=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=Kr2PHa14;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 23.88.38.48 as permitted sender) smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
Received: from kero.packetmixer.de
 (p200300C59717eAd808f168C97E5563A8.dip0.t-ipconnect.de
 [IPv6:2003:c5:9717:ead8:8f1:68c9:7e55:63a8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id 9CDB7FA15B;
	Tue, 28 Jul 2026 15:39:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1785245968;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+agXVKeACnz2LqdKfwMHgcXg8V+GOB1c80k2rMyCpt4=;
	b=Kr2PHa14YwRyAGYhRazL75Hh+Xwk1rZw5uxtnYZunv04P+1QLeyfOgwWYhbQogzDOmM8p4
	Lk9v3OAqg0MkLr3Gjygf2xZjGOuDxVfOhrf+P6yA3gRl3hnFsGfnisVyRavDRapmY1WK8T
	mkxPoZAP7Xz0HCWPEJtm2P5GgcwIVFZAgsEGWIQooMporxY62qykYTBaoYKnyCHAIybGef
	N0/GKfelzKeiIPm6cBp0JDZLrj90xdXcqyx7okSmGSs06NjTeJAuD0fFW9iVRkcLVvh6ZP
	x84wEk+4vySEfHJYLOouQoxKDiDOT8j5gK749c0JV3sW/2clUW++BJJ+m84pGw==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Sven Eckelmann <sven@narfation.org>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net-next 13/15] batman-adv: switch var declarations to reverse
 x-mas tree order
Date: Tue, 28 Jul 2026 15:39:16 +0200
Message-ID: <20260728133918.643267-14-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260728133918.643267-1-sw@simonwunderlich.de>
References: <20260728133918.643267-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: 4LH62RJFKEXZPXP5GOQDVB44UW3OEUPF
X-Message-ID-Hash: 4LH62RJFKEXZPXP5GOQDVB44UW3OEUPF
X-MailFrom: sw@simonwunderlich.de
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/4LH62RJFKEXZPXP5GOQDVB44UW3OEUPF/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Sven Eckelmann <sven@narfation.org>

The network related code should use for local variable declarations an
ordering scheme which orders lines longest to shortest. Initializations
should only be kept in the declarations when the dependencies between them
are not preventing the reverse x-mas tree order.

Many functions are already using this order. The remaining ones were
supposed to slowly convert to the x-mas tree order when working on them.
But this never happened because the patches tried to only modify the
relevant lines. Instead of getting better, the order often just became
worse.

Just fix the remaining offending functions to finally solve this coding
style (minor) problem.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/bat_algo.c              |   3 +-
 net/batman-adv/bat_iv_ogm.c            | 129 +++++++++---------
 net/batman-adv/bat_v.c                 |  24 ++--
 net/batman-adv/bat_v_elp.c             |  18 +--
 net/batman-adv/bat_v_ogm.c             |  29 ++--
 net/batman-adv/bridge_loop_avoidance.c |  90 ++++++-------
 net/batman-adv/distributed-arp-table.c | 130 ++++++++++--------
 net/batman-adv/fragmentation.c         |  32 ++---
 net/batman-adv/gateway_client.c        |  26 ++--
 net/batman-adv/gateway_common.c        |   2 +-
 net/batman-adv/hard-interface.c        |  12 +-
 net/batman-adv/hash.h                  |   8 +-
 net/batman-adv/log.h                   |  16 ++-
 net/batman-adv/main.c                  |  16 +--
 net/batman-adv/mesh-interface.c        |  38 +++---
 net/batman-adv/multicast.c             |  36 +++--
 net/batman-adv/multicast_forw.c        |  13 +-
 net/batman-adv/netlink.c               |   6 +-
 net/batman-adv/originator.c            |  38 +++---
 net/batman-adv/routing.c               |  54 ++++----
 net/batman-adv/send.c                  |   4 +-
 net/batman-adv/tp_meter.c              |  31 ++---
 net/batman-adv/translation-table.c     | 179 +++++++++++++------------
 net/batman-adv/tvlv.c                  |  16 +--
 24 files changed, 491 insertions(+), 459 deletions(-)

diff --git a/net/batman-adv/bat_algo.c b/net/batman-adv/bat_algo.c
index bd094bc793e30..93cd77680e644 100644
--- a/net/batman-adv/bat_algo.c
+++ b/net/batman-adv/bat_algo.c
@@ -131,8 +131,9 @@ static int batadv_param_set_ra(const char *val, const struct kernel_param *kp)
 {
 	struct batadv_algo_ops *bat_algo_ops;
 	char *algo_name = (char *)val;
-	size_t name_len = strlen(algo_name);
+	size_t name_len;
 
+	name_len = strlen(algo_name);
 	if (name_len > 0 && algo_name[name_len - 1] == '\n')
 		algo_name[name_len - 1] = '\0';
 
diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index 337e8e3554bb7..aff279b83da49 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -106,8 +106,8 @@ static u8 batadv_ring_buffer_avg(const u8 lq_recv[])
 {
 	const u8 *ptr;
 	u16 count = 0;
-	u16 i = 0;
 	u16 sum = 0;
+	u16 i = 0;
 
 	ptr = lq_recv;
 
@@ -408,12 +408,12 @@ static void batadv_iv_ogm_send_to_if(struct batadv_forw_packet *forw_packet,
 				     struct batadv_hard_iface *hard_iface)
 {
 	struct batadv_priv *bat_priv = netdev_priv(hard_iface->mesh_iface);
-	const char *fwd_str;
-	u8 packet_num;
-	int buff_pos;
 	struct batadv_ogm_packet *batadv_ogm_packet;
+	const char *fwd_str;
 	struct sk_buff *skb;
 	u8 *packet_pos;
+	u8 packet_num;
+	int buff_pos;
 
 	if (hard_iface->if_status != BATADV_IF_ACTIVE)
 		return;
@@ -514,13 +514,13 @@ batadv_iv_ogm_can_aggregate(const struct batadv_ogm_packet *new_bat_ogm_packet,
 			    const struct batadv_hard_iface *if_outgoing,
 			    const struct batadv_forw_packet *forw_packet)
 {
-	struct batadv_ogm_packet *batadv_ogm_packet;
 	unsigned int aggregated_bytes = forw_packet->packet_len + packet_len;
+	struct batadv_ogm_packet *batadv_ogm_packet;
 	struct batadv_hard_iface *primary_if = NULL;
 	u8 packet_num = forw_packet->num_packets;
-	bool res = false;
 	unsigned long aggregation_end_time;
 	unsigned int max_bytes;
+	bool res = false;
 
 	batadv_ogm_packet = (struct batadv_ogm_packet *)forw_packet->skb->data;
 	aggregation_end_time = send_time;
@@ -627,10 +627,10 @@ static bool batadv_iv_ogm_aggregate_new(const unsigned char *packet_buff,
 {
 	struct batadv_priv *bat_priv = netdev_priv(if_incoming->mesh_iface);
 	struct batadv_forw_packet *forw_packet_aggr;
-	struct sk_buff *skb;
 	unsigned char *skb_buff;
 	unsigned int skb_size;
-	atomic_t *queue_left = own_packet ? NULL : &bat_priv->batman_queue_left;
+	atomic_t *queue_left;
+	struct sk_buff *skb;
 
 	if (READ_ONCE(bat_priv->aggregated_ogms))
 		skb_size = max_t(unsigned int, BATADV_MAX_AGGREGATION_BYTES,
@@ -644,6 +644,7 @@ static bool batadv_iv_ogm_aggregate_new(const unsigned char *packet_buff,
 	if (!skb)
 		return false;
 
+	queue_left = own_packet ? NULL : &bat_priv->batman_queue_left;
 	forw_packet_aggr = batadv_forw_packet_alloc(if_incoming, if_outgoing,
 						    queue_left, bat_priv, skb);
 	if (!forw_packet_aggr) {
@@ -723,9 +724,9 @@ static bool batadv_iv_ogm_queue_add(struct batadv_priv *bat_priv,
 	struct batadv_forw_packet *forw_packet_aggr = NULL;
 	struct batadv_forw_packet *forw_packet_pos = NULL;
 	struct batadv_ogm_packet *batadv_ogm_packet;
-	bool direct_link;
 	unsigned long max_aggregation_jiffies;
 	bool aggregated_ogms;
+	bool direct_link;
 
 	batadv_ogm_packet = (struct batadv_ogm_packet *)packet_buff;
 	direct_link = !!(batadv_ogm_packet->flags & BATADV_DIRECTLINK);
@@ -856,9 +857,9 @@ batadv_iv_ogm_slide_own_bcast_window(struct batadv_hard_iface *hard_iface)
 {
 	struct batadv_priv *bat_priv = netdev_priv(hard_iface->mesh_iface);
 	struct batadv_hashtable *hash = bat_priv->orig_hash;
-	struct hlist_head *head;
-	struct batadv_orig_node *orig_node;
 	struct batadv_orig_ifinfo *orig_ifinfo;
+	struct batadv_orig_node *orig_node;
+	struct hlist_head *head;
 	unsigned long *word;
 	u32 i;
 	u8 *w;
@@ -896,14 +897,14 @@ static void batadv_iv_ogm_schedule_buff(struct batadv_hard_iface *hard_iface)
 	struct batadv_priv *bat_priv = netdev_priv(hard_iface->mesh_iface);
 	struct batadv_ogm_buf *ogm_buff = &hard_iface->bat_iv.ogm_buff;
 	struct batadv_ogm_packet *batadv_ogm_packet;
-	struct batadv_hard_iface *primary_if;
 	struct batadv_hard_iface *tmp_hard_iface;
-	struct list_head *iter;
-	u32 seqno;
-	u16 tvlv_len = 0;
+	struct batadv_hard_iface *primary_if;
 	unsigned long send_time;
 	bool reschedule = false;
+	struct list_head *iter;
+	u16 tvlv_len = 0;
 	bool scheduled;
+	u32 seqno;
 	int ret;
 
 	lockdep_assert_held(&hard_iface->bat_iv.ogm_buff_mutex);
@@ -1105,14 +1106,14 @@ batadv_iv_ogm_orig_update(struct batadv_priv *bat_priv,
 			  struct batadv_hard_iface *if_outgoing,
 			  enum batadv_dup_status dup_status)
 {
-	struct batadv_neigh_ifinfo *neigh_ifinfo = NULL;
 	struct batadv_neigh_ifinfo *router_ifinfo = NULL;
-	struct batadv_neigh_node *neigh_node = NULL;
+	struct batadv_neigh_ifinfo *neigh_ifinfo = NULL;
 	struct batadv_neigh_node *tmp_neigh_node = NULL;
+	struct batadv_neigh_node *neigh_node = NULL;
 	struct batadv_neigh_node *router = NULL;
-	u8 sum_orig;
-	u8 sum_neigh;
 	u8 *neigh_addr;
+	u8 sum_neigh;
+	u8 sum_orig;
 	u8 tq_avg;
 
 	batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
@@ -1243,21 +1244,21 @@ static bool batadv_iv_ogm_calc_tq(struct batadv_orig_node *orig_node,
 				  struct batadv_hard_iface *if_outgoing)
 {
 	struct batadv_priv *bat_priv = netdev_priv(if_incoming->mesh_iface);
+	unsigned int tq_iface_hop_penalty = BATADV_TQ_MAX_VALUE;
 	struct batadv_neigh_node *neigh_node = NULL;
 	struct batadv_neigh_node *tmp_neigh_node;
 	struct batadv_neigh_ifinfo *neigh_ifinfo;
-	u8 total_count;
-	u8 orig_eq_count;
-	u8 neigh_rq_count;
-	u8 neigh_rq_inv;
-	u8 tq_own;
-	unsigned int tq_iface_hop_penalty = BATADV_TQ_MAX_VALUE;
 	unsigned int neigh_rq_inv_cube;
 	unsigned int neigh_rq_max_cube;
-	unsigned int tq_asym_penalty;
 	unsigned int inv_asym_penalty;
+	unsigned int tq_asym_penalty;
 	unsigned int combined_tq;
+	u8 neigh_rq_count;
+	u8 orig_eq_count;
 	bool ret = false;
+	u8 neigh_rq_inv;
+	u8 total_count;
+	u8 tq_own;
 
 	/* find corresponding one hop neighbor */
 	rcu_read_lock();
@@ -1390,19 +1391,19 @@ batadv_iv_ogm_update_seqnos(const struct ethhdr *ethhdr,
 			    struct batadv_hard_iface *if_outgoing)
 {
 	struct batadv_priv *bat_priv = netdev_priv(if_incoming->mesh_iface);
-	struct batadv_orig_node *orig_node;
 	struct batadv_orig_ifinfo *orig_ifinfo = NULL;
-	struct batadv_neigh_node *neigh_node;
+	u32 seqno = ntohl(batadv_ogm_packet->seqno);
+	enum batadv_dup_status ret = BATADV_NO_DUP;
 	struct batadv_neigh_ifinfo *neigh_ifinfo;
-	bool is_dup;
-	s32 seq_diff;
+	struct batadv_neigh_node *neigh_node;
+	struct batadv_orig_node *orig_node;
 	bool need_update = false;
-	int set_mark;
-	enum batadv_dup_status ret = BATADV_NO_DUP;
-	u32 seqno = ntohl(batadv_ogm_packet->seqno);
-	u8 *neigh_addr;
-	u8 packet_count;
 	unsigned long *bitmap;
+	u8 packet_count;
+	u8 *neigh_addr;
+	s32 seq_diff;
+	int set_mark;
+	bool is_dup;
 
 	orig_node = batadv_iv_ogm_orig_get(bat_priv, batadv_ogm_packet->orig);
 	if (!orig_node)
@@ -1519,22 +1520,22 @@ batadv_iv_ogm_process_per_outif(const struct sk_buff *skb, int ogm_offset,
 {
 	struct batadv_priv *bat_priv = netdev_priv(if_incoming->mesh_iface);
 	struct batadv_hardif_neigh_node *hardif_neigh = NULL;
-	struct batadv_neigh_node *router = NULL;
+	struct batadv_neigh_node *orig_neigh_router = NULL;
+	struct batadv_neigh_ifinfo *router_ifinfo = NULL;
 	struct batadv_neigh_node *router_router = NULL;
 	struct batadv_orig_node *orig_neigh_node;
+	struct batadv_neigh_node *router = NULL;
 	struct batadv_orig_ifinfo *orig_ifinfo;
-	struct batadv_neigh_node *orig_neigh_router = NULL;
-	struct batadv_neigh_ifinfo *router_ifinfo = NULL;
 	struct batadv_ogm_packet *ogm_packet;
-	enum batadv_dup_status dup_status;
 	bool is_from_best_next_hop = false;
+	enum batadv_dup_status dup_status;
 	bool is_single_hop_neigh = false;
-	bool sameseq;
-	bool similar_ttl;
 	struct sk_buff *skb_priv;
 	struct ethhdr *ethhdr;
-	u8 *prev_sender;
+	bool similar_ttl;
 	bool is_bidirect;
+	u8 *prev_sender;
+	bool sameseq;
 
 	/* create a private copy of the skb, as some functions change tq value
 	 * and/or flags.
@@ -1757,16 +1758,16 @@ static void batadv_iv_ogm_process(const struct sk_buff *skb, int ogm_offset,
 {
 	struct batadv_priv *bat_priv = netdev_priv(if_incoming->mesh_iface);
 	struct batadv_orig_node *orig_neigh_node;
-	struct batadv_orig_node *orig_node;
 	struct batadv_hard_iface *hard_iface;
 	struct batadv_ogm_packet *ogm_packet;
-	u32 if_incoming_seqno;
-	bool has_directlink_flag;
-	struct ethhdr *ethhdr;
+	struct batadv_orig_node *orig_node;
 	bool is_my_oldorig = false;
+	bool has_directlink_flag;
 	bool is_my_addr = false;
 	bool is_my_orig = false;
 	struct list_head *iter;
+	u32 if_incoming_seqno;
+	struct ethhdr *ethhdr;
 
 	ogm_packet = (struct batadv_ogm_packet *)(skb->data + ogm_offset);
 	ethhdr = eth_hdr(skb);
@@ -1893,8 +1894,8 @@ static void batadv_iv_ogm_process(const struct sk_buff *skb, int ogm_offset,
  */
 static void batadv_iv_send_outstanding_bat_ogm_packet(struct work_struct *work)
 {
-	struct delayed_work *delayed_work;
 	struct batadv_forw_packet *forw_packet;
+	struct delayed_work *delayed_work;
 	struct batadv_priv *bat_priv;
 	bool dropped = false;
 
@@ -1945,10 +1946,10 @@ static int batadv_iv_ogm_receive(struct sk_buff *skb,
 {
 	struct batadv_priv *bat_priv = netdev_priv(if_incoming->mesh_iface);
 	struct batadv_ogm_packet *ogm_packet;
+	int ret = NET_RX_DROP;
 	u8 *packet_pos;
 	int ogm_offset;
 	bool res;
-	int ret = NET_RX_DROP;
 
 	res = batadv_check_management_packet(skb, if_incoming, BATADV_OGM_HLEN);
 	if (!res)
@@ -2038,9 +2039,9 @@ batadv_iv_ogm_orig_dump_subentry(struct sk_buff *msg, u32 portid, u32 seq,
 				 struct batadv_neigh_node *neigh_node,
 				 bool best)
 {
+	unsigned int last_seen_msecs;
 	void *hdr;
 	u8 tq_avg;
-	unsigned int last_seen_msecs;
 
 	last_seen_msecs = jiffies_to_msecs(jiffies - orig_node->last_seen);
 
@@ -2102,9 +2103,9 @@ batadv_iv_ogm_orig_dump_entry(struct sk_buff *msg, u32 portid, u32 seq,
 {
 	struct batadv_neigh_node *neigh_node_best;
 	struct batadv_neigh_node *neigh_node;
+	u8 tq_avg_best;
 	int sub = 0;
 	bool best;
-	u8 tq_avg_best;
 
 	neigh_node_best = batadv_orig_router_get(orig_node, if_outgoing);
 	if (!neigh_node_best)
@@ -2197,11 +2198,11 @@ batadv_iv_ogm_orig_dump(struct sk_buff *msg, struct netlink_callback *cb,
 			struct batadv_hard_iface *if_outgoing)
 {
 	struct batadv_hashtable *hash = bat_priv->orig_hash;
-	struct hlist_head *head;
+	int portid = NETLINK_CB(cb->skb).portid;
 	int bucket = cb->args[0];
+	struct hlist_head *head;
 	int idx = cb->args[1];
 	int sub = cb->args[2];
-	int portid = NETLINK_CB(cb->skb).portid;
 
 	while (bucket < hash->size) {
 		head = &hash->table[bucket];
@@ -2242,9 +2243,9 @@ static bool batadv_iv_ogm_neigh_diff(struct batadv_neigh_node *neigh1,
 {
 	struct batadv_neigh_ifinfo *neigh1_ifinfo;
 	struct batadv_neigh_ifinfo *neigh2_ifinfo;
+	bool ret = true;
 	u8 tq1;
 	u8 tq2;
-	bool ret = true;
 
 	neigh1_ifinfo = batadv_neigh_ifinfo_get(neigh1, if_outgoing1);
 	neigh2_ifinfo = batadv_neigh_ifinfo_get(neigh2, if_outgoing2);
@@ -2278,8 +2279,8 @@ static int
 batadv_iv_ogm_neigh_dump_neigh(struct sk_buff *msg, u32 portid, u32 seq,
 			       struct batadv_hardif_neigh_node *hardif_neigh)
 {
-	void *hdr;
 	unsigned int last_seen_msecs;
+	void *hdr;
 
 	last_seen_msecs = jiffies_to_msecs(jiffies - hardif_neigh->last_seen);
 
@@ -2357,12 +2358,12 @@ batadv_iv_ogm_neigh_dump(struct sk_buff *msg, struct netlink_callback *cb,
 			 struct batadv_priv *bat_priv,
 			 struct batadv_hard_iface *single_hardif)
 {
+	int portid = NETLINK_CB(cb->skb).portid;
 	struct batadv_hard_iface *hard_iface;
-	struct list_head *iter;
-	int i_hardif = 0;
 	int i_hardif_s = cb->args[0];
+	struct list_head *iter;
 	int idx = cb->args[1];
-	int portid = NETLINK_CB(cb->skb).portid;
+	int i_hardif = 0;
 
 	rcu_read_lock();
 	if (single_hardif) {
@@ -2484,15 +2485,15 @@ static void batadv_iv_init_sel_class(struct batadv_priv *bat_priv)
 static struct batadv_gw_node *
 batadv_iv_gw_get_best_gw_node(struct batadv_priv *bat_priv)
 {
-	struct batadv_neigh_node *router;
 	struct batadv_neigh_ifinfo *router_ifinfo;
-	struct batadv_gw_node *gw_node;
 	struct batadv_gw_node *curr_gw = NULL;
+	struct batadv_orig_node *orig_node;
+	struct batadv_neigh_node *router;
+	struct batadv_gw_node *gw_node;
 	u64 max_gw_factor = 0;
 	u64 tmp_gw_factor = 0;
 	u8 max_tq = 0;
 	u8 tq_avg;
-	struct batadv_orig_node *orig_node;
 
 	rcu_read_lock();
 	hlist_for_each_entry_rcu(gw_node, &bat_priv->gw.gateway_list, list) {
@@ -2579,11 +2580,11 @@ static bool batadv_iv_gw_is_eligible(struct batadv_priv *bat_priv,
 	struct batadv_neigh_ifinfo *router_orig_ifinfo = NULL;
 	struct batadv_neigh_ifinfo *router_gw_ifinfo = NULL;
 	u32 sel_class = READ_ONCE(bat_priv->gw.sel_class);
-	struct batadv_neigh_node *router_gw = NULL;
 	struct batadv_neigh_node *router_orig = NULL;
-	u8 gw_tq_avg;
-	u8 orig_tq_avg;
+	struct batadv_neigh_node *router_gw = NULL;
 	bool ret = false;
+	u8 orig_tq_avg;
+	u8 gw_tq_avg;
 
 	/* dynamic re-election is performed only on fast or late switch */
 	if (sel_class <= 2)
@@ -2654,8 +2655,8 @@ static int batadv_iv_gw_dump_entry(struct sk_buff *msg, u32 portid,
 				   struct batadv_gw_node *gw_node)
 {
 	struct batadv_neigh_ifinfo *router_ifinfo = NULL;
-	struct batadv_neigh_node *router;
 	struct batadv_gw_node *curr_gw = NULL;
+	struct batadv_neigh_node *router;
 	int ret = 0;
 	void *hdr;
 
diff --git a/net/batman-adv/bat_v.c b/net/batman-adv/bat_v.c
index be28875c201d7..ee372fc9d44e9 100644
--- a/net/batman-adv/bat_v.c
+++ b/net/batman-adv/bat_v.c
@@ -159,9 +159,9 @@ static int
 batadv_v_neigh_dump_neigh(struct sk_buff *msg, u32 portid, u32 seq,
 			  struct batadv_hardif_neigh_node *hardif_neigh)
 {
-	void *hdr;
 	unsigned int last_seen_msecs;
 	u32 throughput;
+	void *hdr;
 
 	last_seen_msecs = jiffies_to_msecs(jiffies - hardif_neigh->last_seen);
 	throughput = ewma_throughput_read(&hardif_neigh->bat_v.throughput);
@@ -242,12 +242,12 @@ batadv_v_neigh_dump(struct sk_buff *msg, struct netlink_callback *cb,
 		    struct batadv_priv *bat_priv,
 		    struct batadv_hard_iface *single_hardif)
 {
+	int portid = NETLINK_CB(cb->skb).portid;
 	struct batadv_hard_iface *hard_iface;
-	struct list_head *iter;
-	int i_hardif = 0;
 	int i_hardif_s = cb->args[0];
+	struct list_head *iter;
 	int idx = cb->args[1];
-	int portid = NETLINK_CB(cb->skb).portid;
+	int i_hardif = 0;
 
 	rcu_read_lock();
 	if (single_hardif) {
@@ -452,11 +452,11 @@ batadv_v_orig_dump(struct sk_buff *msg, struct netlink_callback *cb,
 		   struct batadv_hard_iface *if_outgoing)
 {
 	struct batadv_hashtable *hash = bat_priv->orig_hash;
-	struct hlist_head *head;
+	int portid = NETLINK_CB(cb->skb).portid;
 	int bucket = cb->args[0];
+	struct hlist_head *head;
 	int idx = cb->args[1];
 	int sub = cb->args[2];
-	int portid = NETLINK_CB(cb->skb).portid;
 
 	while (bucket < hash->size) {
 		head = &hash->table[bucket];
@@ -529,8 +529,8 @@ static bool batadv_v_neigh_is_sob(struct batadv_neigh_node *neigh1,
 {
 	struct batadv_neigh_ifinfo *ifinfo1;
 	struct batadv_neigh_ifinfo *ifinfo2;
-	u32 threshold;
 	bool ret = false;
+	u32 threshold;
 
 	ifinfo1 = batadv_neigh_ifinfo_get(neigh1, if_outgoing1);
 	if (!ifinfo1)
@@ -612,8 +612,8 @@ static int batadv_v_gw_throughput_get(struct batadv_gw_node *gw_node, u32 *bw)
 static struct batadv_gw_node *
 batadv_v_gw_get_best_gw_node(struct batadv_priv *bat_priv)
 {
-	struct batadv_gw_node *gw_node;
 	struct batadv_gw_node *curr_gw = NULL;
+	struct batadv_gw_node *gw_node;
 	u32 max_bw = 0;
 	u32 bw;
 
@@ -654,12 +654,12 @@ static bool batadv_v_gw_is_eligible(struct batadv_priv *bat_priv,
 				    struct batadv_orig_node *curr_gw_orig,
 				    struct batadv_orig_node *orig_node)
 {
-	struct batadv_gw_node *curr_gw;
 	struct batadv_gw_node *orig_gw = NULL;
-	u32 gw_throughput;
+	struct batadv_gw_node *curr_gw;
 	u32 orig_throughput;
-	u32 threshold;
+	u32 gw_throughput;
 	bool ret = false;
+	u32 threshold;
 
 	threshold = READ_ONCE(bat_priv->gw.sel_class);
 
@@ -715,8 +715,8 @@ static int batadv_v_gw_dump_entry(struct sk_buff *msg, u32 portid,
 				  struct batadv_gw_node *gw_node)
 {
 	struct batadv_neigh_ifinfo *router_ifinfo = NULL;
-	struct batadv_neigh_node *router;
 	struct batadv_gw_node *curr_gw = NULL;
+	struct batadv_neigh_node *router;
 	int ret = 0;
 	void *hdr;
 
diff --git a/net/batman-adv/bat_v_elp.c b/net/batman-adv/bat_v_elp.c
index eb7fb8c14ef30..6ad6042a5d9b6 100644
--- a/net/batman-adv/bat_v_elp.c
+++ b/net/batman-adv/bat_v_elp.c
@@ -230,12 +230,14 @@ static bool
 batadv_v_elp_wifi_neigh_probe(struct batadv_hardif_neigh_node *neigh)
 {
 	struct batadv_hard_iface *hard_iface = neigh->if_incoming;
-	struct batadv_priv *bat_priv = netdev_priv(hard_iface->mesh_iface);
+	struct batadv_priv *bat_priv;
 	unsigned long last_tx_diff;
 	struct sk_buff *skb;
+	int elp_skb_len;
 	int probe_len;
 	int i;
-	int elp_skb_len;
+
+	bat_priv = netdev_priv(hard_iface->mesh_iface);
 
 	/* this probing routine is for Wifi neighbours only */
 	if (!batadv_is_wifi_hardif(hard_iface))
@@ -290,8 +292,8 @@ static void batadv_v_elp_periodic_work(struct work_struct *work)
 	struct batadv_v_metric_queue_entry *metric_entry;
 	struct batadv_v_metric_queue_entry *metric_safe;
 	struct batadv_hardif_neigh_node *hardif_neigh;
-	struct batadv_hard_iface *hard_iface;
 	struct batadv_hard_iface_bat_v *bat_v;
+	struct batadv_hard_iface *hard_iface;
 	struct batadv_elp_packet *elp_packet;
 	struct list_head metric_queue;
 	struct batadv_priv *bat_priv;
@@ -396,9 +398,9 @@ int batadv_v_elp_iface_enable(struct batadv_hard_iface *hard_iface)
 	static const size_t tvlv_padding = sizeof(__be32);
 	struct batadv_elp_packet *elp_packet;
 	unsigned char *elp_buff;
+	int res = -ENOMEM;
 	u32 random_seqno;
 	size_t size;
-	int res = -ENOMEM;
 
 	size = ETH_HLEN + NET_IP_ALIGN + BATADV_ELP_HLEN + tvlv_padding;
 	hard_iface->bat_v.elp_skb = dev_alloc_skb(size);
@@ -501,11 +503,11 @@ static void batadv_v_elp_neigh_update(struct batadv_priv *bat_priv,
 				      struct batadv_elp_packet *elp_packet)
 
 {
-	struct batadv_neigh_node *neigh;
-	struct batadv_orig_node *orig_neigh;
 	struct batadv_hardif_neigh_node *hardif_neigh;
-	s32 seqno_diff;
+	struct batadv_orig_node *orig_neigh;
+	struct batadv_neigh_node *neigh;
 	s32 elp_latest_seqno;
+	s32 seqno_diff;
 
 	orig_neigh = batadv_v_ogm_orig_get(bat_priv, elp_packet->orig);
 	if (!orig_neigh)
@@ -557,8 +559,8 @@ int batadv_v_elp_packet_recv(struct sk_buff *skb,
 	struct batadv_elp_packet *elp_packet;
 	struct batadv_hard_iface *primary_if;
 	struct ethhdr *ethhdr;
-	bool res;
 	int ret = NET_RX_DROP;
+	bool res;
 
 	res = batadv_check_management_packet(skb, if_incoming, BATADV_ELP_HLEN);
 	if (!res)
diff --git a/net/batman-adv/bat_v_ogm.c b/net/batman-adv/bat_v_ogm.c
index d4527663f76d9..70846c997410d 100644
--- a/net/batman-adv/bat_v_ogm.c
+++ b/net/batman-adv/bat_v_ogm.c
@@ -101,6 +101,7 @@ static void batadv_v_ogm_start_queue_timer(struct batadv_hard_iface *hard_iface)
 static void batadv_v_ogm_start_timer(struct batadv_priv *bat_priv)
 {
 	unsigned long msecs;
+
 	/* this function may be invoked in different contexts (ogm rescheduling
 	 * or hard_iface activation), but the work timer should not be reset
 	 */
@@ -268,12 +269,12 @@ static void batadv_v_ogm_queue_on_if(struct sk_buff *skb,
  */
 static void batadv_v_ogm_send_meshif(struct batadv_priv *bat_priv)
 {
-	struct batadv_hard_iface *hard_iface;
 	struct batadv_ogm2_packet *ogm_packet;
+	struct batadv_hard_iface *hard_iface;
 	struct batadv_ogm_buf *ogm_buff;
-	struct sk_buff *skb;
 	struct sk_buff *skb_tmp;
 	struct list_head *iter;
+	struct sk_buff *skb;
 	u16 tvlv_len;
 	int ret;
 
@@ -622,11 +623,11 @@ static int batadv_v_ogm_metric_update(struct batadv_priv *bat_priv,
 				      struct batadv_hard_iface *if_incoming,
 				      struct batadv_hard_iface *if_outgoing)
 {
-	struct batadv_orig_ifinfo *orig_ifinfo;
 	struct batadv_neigh_ifinfo *neigh_ifinfo = NULL;
+	struct batadv_orig_ifinfo *orig_ifinfo;
 	bool protection_started = false;
-	int ret = -EINVAL;
 	u32 path_throughput;
+	int ret = -EINVAL;
 	s32 seq_diff;
 
 	orig_ifinfo = batadv_orig_ifinfo_new(orig_node, if_outgoing);
@@ -704,17 +705,17 @@ static bool batadv_v_ogm_route_update(struct batadv_priv *bat_priv,
 				      struct batadv_hard_iface *if_incoming,
 				      struct batadv_hard_iface *if_outgoing)
 {
-	struct batadv_neigh_node *router = NULL;
-	struct batadv_orig_node *orig_neigh_node;
 	struct batadv_neigh_node *orig_neigh_router = NULL;
 	struct batadv_neigh_ifinfo *router_ifinfo = NULL;
 	struct batadv_neigh_ifinfo *neigh_ifinfo = NULL;
+	struct batadv_orig_node *orig_neigh_node;
+	struct batadv_neigh_node *router = NULL;
 	u32 router_throughput;
-	u32 neigh_throughput;
 	u32 router_last_seqno;
+	u32 neigh_throughput;
 	u32 neigh_last_seqno;
-	s32 neigh_seq_diff;
 	bool forward = false;
+	s32 neigh_seq_diff;
 
 	orig_neigh_node = batadv_v_ogm_orig_get(bat_priv, ethhdr->h_source);
 	if (!orig_neigh_node)
@@ -874,16 +875,16 @@ static void batadv_v_ogm_process(const struct sk_buff *skb, int ogm_offset,
 				 struct batadv_hard_iface *if_incoming)
 {
 	struct batadv_priv *bat_priv = netdev_priv(if_incoming->mesh_iface);
-	struct ethhdr *ethhdr;
-	struct batadv_orig_node *orig_node = NULL;
 	struct batadv_hardif_neigh_node *hardif_neigh = NULL;
 	struct batadv_neigh_node *neigh_node = NULL;
-	struct batadv_hard_iface *hard_iface;
+	struct batadv_orig_node *orig_node = NULL;
 	struct batadv_ogm2_packet *ogm_packet;
-	u32 ogm_throughput;
+	struct batadv_hard_iface *hard_iface;
+	struct list_head *iter;
+	struct ethhdr *ethhdr;
 	u32 link_throughput;
 	u32 path_throughput;
-	struct list_head *iter;
+	u32 ogm_throughput;
 	int ret;
 
 	ethhdr = eth_hdr(skb);
@@ -1009,9 +1010,9 @@ int batadv_v_ogm_packet_recv(struct sk_buff *skb,
 	struct batadv_priv *bat_priv = netdev_priv(if_incoming->mesh_iface);
 	struct batadv_ogm2_packet *ogm_packet;
 	struct ethhdr *ethhdr;
+	int ret = NET_RX_DROP;
 	int ogm_offset;
 	u8 *packet_pos;
-	int ret = NET_RX_DROP;
 
 	/* did we receive a OGM2 packet on an interface that does not have
 	 * B.A.T.M.A.N. V enabled ?
diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
index 363d1819f521c..f231afbee218a 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -177,8 +177,8 @@ static void batadv_backbone_gw_put(struct batadv_bla_backbone_gw *backbone_gw)
  */
 static void batadv_claim_release(struct kref *ref)
 {
-	struct batadv_bla_claim *claim;
 	struct batadv_bla_backbone_gw *old_backbone_gw;
+	struct batadv_bla_claim *claim;
 
 	claim = container_of(ref, struct batadv_bla_claim, refcount);
 
@@ -220,9 +220,9 @@ batadv_claim_hash_find(struct batadv_priv *bat_priv,
 		       struct batadv_bla_claim *data)
 {
 	struct batadv_hashtable *hash = bat_priv->bla.claim_hash;
-	struct hlist_head *head;
-	struct batadv_bla_claim *claim;
 	struct batadv_bla_claim *claim_tmp = NULL;
+	struct batadv_bla_claim *claim;
+	struct hlist_head *head;
 	int index;
 
 	if (!hash)
@@ -260,10 +260,10 @@ batadv_backbone_hash_find(struct batadv_priv *bat_priv, const u8 *addr,
 			  unsigned short vid)
 {
 	struct batadv_hashtable *hash = bat_priv->bla.backbone_hash;
-	struct hlist_head *head;
+	struct batadv_bla_backbone_gw *backbone_gw_tmp = NULL;
 	struct batadv_bla_backbone_gw search_entry;
 	struct batadv_bla_backbone_gw *backbone_gw;
-	struct batadv_bla_backbone_gw *backbone_gw_tmp = NULL;
+	struct hlist_head *head;
 	int index;
 
 	if (!hash)
@@ -299,12 +299,12 @@ batadv_backbone_hash_find(struct batadv_priv *bat_priv, const u8 *addr,
 static void
 batadv_bla_del_backbone_claims(struct batadv_bla_backbone_gw *backbone_gw)
 {
+	spinlock_t *list_lock;	/* protects write access to the hash lists */
+	struct batadv_bla_claim *claim;
 	struct batadv_hashtable *hash;
 	struct hlist_node *node_tmp;
 	struct hlist_head *head;
-	struct batadv_bla_claim *claim;
 	int i;
-	spinlock_t *list_lock;	/* protects write access to the hash lists */
 
 	hash = backbone_gw->bat_priv->bla.claim_hash;
 	if (!hash)
@@ -337,12 +337,12 @@ batadv_bla_del_backbone_claims(struct batadv_bla_backbone_gw *backbone_gw)
 static void batadv_bla_send_claim(struct batadv_priv *bat_priv, const u8 *mac,
 				  unsigned short vid, int claimtype)
 {
-	struct sk_buff *skb;
-	struct ethhdr *ethhdr;
-	struct batadv_hard_iface *primary_if;
-	u8 *hw_src;
 	struct batadv_bla_claim_dst local_claim_dest;
+	struct batadv_hard_iface *primary_if;
+	struct ethhdr *ethhdr;
+	struct sk_buff *skb;
 	__be32 zeroip = 0;
+	u8 *hw_src;
 
 	primary_if = batadv_primary_if_get_selected(bat_priv);
 	if (!primary_if)
@@ -589,10 +589,10 @@ static void batadv_bla_answer_request(struct batadv_priv *bat_priv,
 				      struct batadv_hard_iface *primary_if,
 				      unsigned short vid)
 {
-	struct hlist_head *head;
-	struct batadv_hashtable *hash;
-	struct batadv_bla_claim *claim;
 	struct batadv_bla_backbone_gw *backbone_gw;
+	struct batadv_bla_claim *claim;
+	struct batadv_hashtable *hash;
+	struct hlist_head *head;
 	int i;
 
 	batadv_dbg(BATADV_DBG_BLA, bat_priv,
@@ -688,8 +688,8 @@ static void batadv_bla_add_claim(struct batadv_priv *bat_priv,
 				 struct batadv_bla_backbone_gw *backbone_gw)
 {
 	struct batadv_bla_backbone_gw *old_backbone_gw;
-	struct batadv_bla_claim *claim;
 	struct batadv_bla_claim search_claim;
+	struct batadv_bla_claim *claim;
 	int hash_added;
 	u16 claim_crc;
 	bool changed;
@@ -810,10 +810,10 @@ batadv_bla_claim_get_backbone_gw(struct batadv_bla_claim *claim)
 static void batadv_bla_del_claim(struct batadv_priv *bat_priv,
 				 const u8 *mac, const unsigned short vid)
 {
-	struct batadv_bla_claim search_claim;
-	struct batadv_bla_claim *claim;
 	struct batadv_bla_claim *claim_removed_entry;
 	struct hlist_node *claim_removed_node;
+	struct batadv_bla_claim search_claim;
+	struct batadv_bla_claim *claim;
 
 	ether_addr_copy(search_claim.addr, mac);
 	search_claim.vid = vid;
@@ -1031,10 +1031,10 @@ static int batadv_check_claim_group(struct batadv_priv *bat_priv,
 				    u8 *hw_src, u8 *hw_dst,
 				    struct ethhdr *ethhdr)
 {
-	u8 *backbone_addr;
-	struct batadv_orig_node *orig_node;
-	struct batadv_bla_claim_dst *bla_dst;
 	struct batadv_bla_claim_dst *bla_dst_own;
+	struct batadv_bla_claim_dst *bla_dst;
+	struct batadv_orig_node *orig_node;
+	u8 *backbone_addr;
 
 	bla_dst = (struct batadv_bla_claim_dst *)hw_dst;
 	bla_dst_own = &bat_priv->bla.claim_dest;
@@ -1103,18 +1103,18 @@ static bool batadv_bla_process_claim(struct batadv_priv *bat_priv,
 				     struct batadv_hard_iface *primary_if,
 				     struct sk_buff *skb)
 {
-	struct batadv_bla_claim_dst *bla_dst;
 	struct batadv_bla_claim_dst *bla_dst_own;
-	u8 *hw_src;
-	u8 *hw_dst;
-	struct vlan_hdr *vhdr;
+	struct batadv_bla_claim_dst *bla_dst;
 	struct vlan_hdr vhdr_buf;
+	struct vlan_hdr *vhdr;
 	struct ethhdr *ethhdr;
 	struct arphdr *arphdr;
 	unsigned short vid;
 	int vlan_depth = 0;
 	__be16 proto;
 	int headlen;
+	u8 *hw_src;
+	u8 *hw_dst;
 	int ret;
 
 	vid = batadv_get_vid(skb, 0);
@@ -1246,11 +1246,11 @@ static bool batadv_bla_process_claim(struct batadv_priv *bat_priv,
  */
 static void batadv_bla_purge_backbone_gw(struct batadv_priv *bat_priv, int now)
 {
+	spinlock_t *list_lock;	/* protects write access to the hash lists */
 	struct batadv_bla_backbone_gw *backbone_gw;
+	struct batadv_hashtable *hash;
 	struct hlist_node *node_tmp;
 	struct hlist_head *head;
-	struct batadv_hashtable *hash;
-	spinlock_t *list_lock;	/* protects write access to the hash lists */
 	bool purged;
 	int i;
 
@@ -1323,8 +1323,8 @@ static void batadv_bla_purge_claims(struct batadv_priv *bat_priv,
 {
 	struct batadv_bla_backbone_gw *backbone_gw;
 	struct batadv_bla_claim *claim;
-	struct hlist_head *head;
 	struct batadv_hashtable *hash;
+	struct hlist_head *head;
 	int i;
 
 	hash = bat_priv->bla.claim_hash;
@@ -1386,8 +1386,8 @@ void batadv_bla_update_orig_address(struct batadv_priv *bat_priv,
 				    struct batadv_hard_iface *oldif)
 {
 	struct batadv_bla_backbone_gw *backbone_gw;
-	struct hlist_head *head;
 	struct batadv_hashtable *hash;
+	struct hlist_head *head;
 	__be16 group;
 	int i;
 
@@ -1480,14 +1480,14 @@ void batadv_bla_status_update(struct net_device *net_dev)
  */
 static void batadv_bla_periodic_work(struct work_struct *work)
 {
+	struct batadv_bla_backbone_gw *backbone_gw;
+	struct batadv_hard_iface *primary_if;
 	struct delayed_work *delayed_work;
-	struct batadv_priv *bat_priv;
 	struct batadv_priv_bla *priv_bla;
-	struct hlist_head *head;
-	struct batadv_bla_backbone_gw *backbone_gw;
 	struct batadv_hashtable *hash;
-	struct batadv_hard_iface *primary_if;
+	struct batadv_priv *bat_priv;
 	bool send_loopdetect = false;
+	struct hlist_head *head;
 	int i;
 
 	delayed_work = to_delayed_work(work);
@@ -1589,11 +1589,11 @@ static struct lock_class_key batadv_backbone_hash_lock_class_key;
  */
 int batadv_bla_init(struct batadv_priv *bat_priv)
 {
-	int i;
 	u8 claim_dest[ETH_ALEN] = {0xff, 0x43, 0x05, 0x00, 0x00, 0x00};
 	struct batadv_hard_iface *primary_if;
-	u16 crc;
 	unsigned long entrytime;
+	u16 crc;
+	int i;
 
 	spin_lock_init(&bat_priv->bla.bcast_duplist_lock);
 
@@ -1672,9 +1672,9 @@ static bool batadv_bla_check_duplist(struct batadv_priv *bat_priv,
 	struct batadv_bcast_duplist_entry *entry;
 	bool ret = false;
 	int payload_len;
-	int i;
 	int curr;
 	u32 crc;
+	int i;
 
 	/* calculate the crc ... */
 	payload_len = skb->len - payload_offset;
@@ -1796,8 +1796,8 @@ bool batadv_bla_is_backbone_gw_orig(struct batadv_priv *bat_priv, u8 *orig,
 				    unsigned short vid)
 {
 	struct batadv_hashtable *hash = bat_priv->bla.backbone_hash;
-	struct hlist_head *head;
 	struct batadv_bla_backbone_gw *backbone_gw;
+	struct hlist_head *head;
 	int i;
 
 	if (!READ_ONCE(bat_priv->bridge_loop_avoidance))
@@ -1963,10 +1963,10 @@ bool batadv_bla_rx(struct batadv_priv *bat_priv, struct sk_buff *skb,
 		   unsigned short vid, int packet_type)
 {
 	struct batadv_bla_backbone_gw *backbone_gw;
-	struct ethhdr *ethhdr;
-	struct batadv_bla_claim search_claim;
 	struct batadv_bla_claim *claim = NULL;
+	struct batadv_bla_claim search_claim;
 	struct batadv_hard_iface *primary_if;
+	struct ethhdr *ethhdr;
 	bool own_claim;
 	bool ret;
 
@@ -2097,11 +2097,11 @@ bool batadv_bla_rx(struct batadv_priv *bat_priv, struct sk_buff *skb,
 bool batadv_bla_tx(struct batadv_priv *bat_priv, struct sk_buff *skb,
 		   unsigned short vid)
 {
-	struct ethhdr *ethhdr;
-	struct batadv_bla_claim search_claim;
-	struct batadv_bla_claim *claim = NULL;
 	struct batadv_bla_backbone_gw *backbone_gw;
+	struct batadv_bla_claim *claim = NULL;
+	struct batadv_bla_claim search_claim;
 	struct batadv_hard_iface *primary_if;
+	struct ethhdr *ethhdr;
 	bool client_roamed;
 	bool ret = false;
 
@@ -2202,10 +2202,10 @@ batadv_bla_claim_dump_entry(struct sk_buff *msg, u32 portid,
 {
 	const u8 *primary_addr = primary_if->net_dev->dev_addr;
 	struct batadv_bla_backbone_gw *backbone_gw;
+	int ret = -EINVAL;
 	u16 backbone_crc;
 	bool is_own;
 	void *hdr;
-	int ret = -EINVAL;
 
 	hdr = genlmsg_put(msg, portid, cb->nlh->nlmsg_seq,
 			  &batadv_netlink_family, NLM_F_MULTI,
@@ -2364,11 +2364,11 @@ batadv_bla_backbone_dump_entry(struct sk_buff *msg, u32 portid,
 			       struct batadv_bla_backbone_gw *backbone_gw)
 {
 	const u8 *primary_addr = primary_if->net_dev->dev_addr;
+	int ret = -EINVAL;
 	u16 backbone_crc;
 	bool is_own;
 	int msecs;
 	void *hdr;
-	int ret = -EINVAL;
 
 	hdr = genlmsg_put(msg, portid, cb->nlh->nlmsg_seq,
 			  &batadv_netlink_family, NLM_F_MULTI,
@@ -2523,10 +2523,10 @@ int batadv_bla_backbone_dump(struct sk_buff *msg, struct netlink_callback *cb)
 bool batadv_bla_check_claim(struct batadv_priv *bat_priv,
 			    u8 *addr, unsigned short vid)
 {
+	struct batadv_hard_iface *primary_if = NULL;
 	struct batadv_bla_backbone_gw *backbone_gw;
-	struct batadv_bla_claim search_claim;
 	struct batadv_bla_claim *claim = NULL;
-	struct batadv_hard_iface *primary_if = NULL;
+	struct batadv_bla_claim search_claim;
 	bool ret = true;
 
 	if (!READ_ONCE(bat_priv->bridge_loop_avoidance))
diff --git a/net/batman-adv/distributed-arp-table.c b/net/batman-adv/distributed-arp-table.c
index 0ba3ba6a2e382..bedd0cc76550d 100644
--- a/net/batman-adv/distributed-arp-table.c
+++ b/net/batman-adv/distributed-arp-table.c
@@ -128,6 +128,34 @@ struct batadv_dhcp_packet {
 	/* __u8 options[]; */
 };
 
+/**
+ * struct batadv_dhcp_header - minimal BOOTP/DHCP packet header
+ */
+struct batadv_dhcp_header {
+	/** @op: message op code / message type */
+	__u8 op;
+
+	/** @htype: hardware address type */
+	__u8 htype;
+
+	/** @hlen: hardware address length */
+	__u8 hlen;
+
+	/** @hops: number of relay hops */
+	__u8 hops;
+};
+
+/**
+ * struct batadv_dhcp_option_header - BOOTP/DHCP option header
+ */
+struct batadv_dhcp_option_header {
+	/** @type: type of option */
+	__u8 type;
+
+	/** @len: length of option */
+	__u8 len;
+};
+
 #define BATADV_DHCP_YIADDR_LEN sizeof(((struct batadv_dhcp_packet *)0)->yiaddr)
 #define BATADV_DHCP_CHADDR_LEN sizeof(((struct batadv_dhcp_packet *)0)->chaddr)
 
@@ -330,9 +358,9 @@ static __be32 batadv_arp_ip_dst(struct sk_buff *skb, int hdr_size)
  */
 static u32 batadv_hash_dat(const void *data, u32 size)
 {
-	u32 hash = 0;
 	const struct batadv_dat_entry *dat = data;
 	const unsigned char *key;
+	u32 hash = 0;
 	__be16 vid;
 	u32 i;
 
@@ -371,11 +399,11 @@ static struct batadv_dat_entry *
 batadv_dat_entry_hash_find(struct batadv_priv *bat_priv, __be32 ip,
 			   unsigned short vid)
 {
-	struct hlist_head *head;
-	struct batadv_dat_entry to_find;
-	struct batadv_dat_entry *dat_entry;
-	struct batadv_dat_entry *dat_entry_tmp = NULL;
 	struct batadv_hashtable *hash = bat_priv->dat.hash;
+	struct batadv_dat_entry *dat_entry_tmp = NULL;
+	struct batadv_dat_entry *dat_entry;
+	struct batadv_dat_entry to_find;
+	struct hlist_head *head;
 	u32 index;
 
 	if (!hash)
@@ -613,11 +641,11 @@ static void batadv_choose_next_candidate(struct batadv_priv *bat_priv,
 					 int select, batadv_dat_addr_t ip_key,
 					 batadv_dat_addr_t *last_max)
 {
-	batadv_dat_addr_t max = 0;
-	batadv_dat_addr_t tmp_max = 0;
-	struct batadv_orig_node *orig_node;
-	struct batadv_orig_node *max_orig_node = NULL;
 	struct batadv_hashtable *hash = bat_priv->orig_hash;
+	struct batadv_orig_node *max_orig_node = NULL;
+	struct batadv_orig_node *orig_node;
+	batadv_dat_addr_t tmp_max = 0;
+	batadv_dat_addr_t max = 0;
 	struct hlist_head *head;
 	int i;
 
@@ -681,11 +709,11 @@ static struct batadv_dat_candidate *
 batadv_dat_select_candidates(struct batadv_priv *bat_priv, __be32 ip_dst,
 			     unsigned short vid)
 {
-	int select;
 	batadv_dat_addr_t last_max = BATADV_DAT_ADDR_MAX;
-	batadv_dat_addr_t ip_key;
 	struct batadv_dat_candidate *res;
 	struct batadv_dat_entry dat;
+	batadv_dat_addr_t ip_key;
+	int select;
 
 	if (!bat_priv->orig_hash)
 		return NULL;
@@ -728,12 +756,12 @@ static bool batadv_dat_forward_data(struct batadv_priv *bat_priv,
 				    struct sk_buff *skb, __be32 ip,
 				    unsigned short vid, int packet_subtype)
 {
-	int i;
-	bool ret = false;
-	int send_status;
 	struct batadv_neigh_node *neigh_node = NULL;
-	struct sk_buff *tmp_skb;
 	struct batadv_dat_candidate *cand;
+	struct sk_buff *tmp_skb;
+	bool ret = false;
+	int send_status;
+	int i;
 
 	cand = batadv_dat_select_candidates(bat_priv, ip, vid);
 	if (!cand)
@@ -1058,9 +1086,9 @@ static u16 batadv_arp_get_type(struct batadv_priv *bat_priv,
 	struct ethhdr *ethhdr;
 	__be32 ip_src;
 	__be32 ip_dst;
+	u16 type = 0;
 	u8 *hw_src;
 	u8 *hw_dst;
-	u16 type = 0;
 
 	/* pull the ethernet header */
 	if (unlikely(!pskb_may_pull(skb, hdr_size + ETH_HLEN)))
@@ -1206,18 +1234,18 @@ batadv_dat_arp_create_reply(struct batadv_priv *bat_priv, __be32 ip_src,
 bool batadv_dat_snoop_outgoing_arp_request(struct batadv_priv *bat_priv,
 					   struct sk_buff *skb)
 {
-	u16 type = 0;
-	__be32 ip_dst;
-	__be32 ip_src;
-	u8 *hw_src;
-	bool ret = false;
+	struct net_device *mesh_iface = bat_priv->mesh_iface;
 	struct batadv_dat_entry *dat_entry = NULL;
 	struct sk_buff *skb_new;
-	struct net_device *mesh_iface = bat_priv->mesh_iface;
-	int hdr_size = 0;
 	unsigned short vid;
+	bool ret = false;
 	u8 mac[ETH_ALEN];
+	int hdr_size = 0;
+	__be32 ip_dst;
+	__be32 ip_src;
+	u16 type = 0;
 	u64 u64_mac;
+	u8 *hw_src;
 
 	if (!READ_ONCE(bat_priv->distributed_arp_table))
 		goto out;
@@ -1315,16 +1343,16 @@ bool batadv_dat_snoop_outgoing_arp_request(struct batadv_priv *bat_priv,
 bool batadv_dat_snoop_incoming_arp_request(struct batadv_priv *bat_priv,
 					   struct sk_buff *skb, int hdr_size)
 {
-	u16 type;
-	__be32 ip_src;
-	__be32 ip_dst;
-	u8 *hw_src;
-	struct sk_buff *skb_new;
 	struct batadv_dat_entry *dat_entry = NULL;
-	bool ret = false;
+	struct sk_buff *skb_new;
 	unsigned short vid;
+	bool ret = false;
 	u8 mac[ETH_ALEN];
+	__be32 ip_src;
+	__be32 ip_dst;
 	u64 u64_mac;
+	u8 *hw_src;
+	u16 type;
 	int err;
 
 	if (!READ_ONCE(bat_priv->distributed_arp_table))
@@ -1387,13 +1415,13 @@ bool batadv_dat_snoop_incoming_arp_request(struct batadv_priv *bat_priv,
 void batadv_dat_snoop_outgoing_arp_reply(struct batadv_priv *bat_priv,
 					 struct sk_buff *skb)
 {
-	u16 type;
+	unsigned short vid;
+	int hdr_size = 0;
 	__be32 ip_src;
 	__be32 ip_dst;
 	u8 *hw_src;
 	u8 *hw_dst;
-	int hdr_size = 0;
-	unsigned short vid;
+	u16 type;
 
 	if (!READ_ONCE(bat_priv->distributed_arp_table))
 		return;
@@ -1446,15 +1474,15 @@ bool batadv_dat_snoop_incoming_arp_reply(struct batadv_priv *bat_priv,
 					 struct sk_buff *skb, int hdr_size)
 {
 	struct batadv_dat_entry *dat_entry = NULL;
-	u16 type;
-	__be32 ip_src;
-	__be32 ip_dst;
-	u8 *hw_src;
-	u8 *hw_dst;
 	bool dropped = false;
 	unsigned short vid;
 	u8 mac[ETH_ALEN];
+	__be32 ip_src;
+	__be32 ip_dst;
 	u64 u64_mac;
+	u8 *hw_src;
+	u8 *hw_dst;
+	u16 type;
 
 	if (!READ_ONCE(bat_priv->distributed_arp_table))
 		goto out;
@@ -1592,15 +1620,11 @@ batadv_dat_check_dhcp_ipudp(struct sk_buff *skb, __be32 *ip_src)
 static int
 batadv_dat_check_dhcp(struct sk_buff *skb, __be16 proto, __be32 *ip_src)
 {
+	struct batadv_dhcp_header *dhcp_h;
+	struct batadv_dhcp_header _dhcp_h;
+	unsigned int offset;
 	__be32 *magic;
 	__be32 _magic;
-	unsigned int offset;
-	struct {
-		__u8 op;
-		__u8 htype;
-		__u8 hlen;
-		__u8 hops;
-	} *dhcp_h, _dhcp_h;
 
 	if (proto != htons(ETH_P_IP))
 		return -EINVAL;
@@ -1641,12 +1665,10 @@ batadv_dat_check_dhcp(struct sk_buff *skb, __be16 proto, __be32 *ip_src)
 static int batadv_dat_get_dhcp_message_type(struct sk_buff *skb)
 {
 	unsigned int offset = skb_transport_offset(skb) + sizeof(struct udphdr);
+	struct batadv_dhcp_option_header *tl;
+	struct batadv_dhcp_option_header _tl;
 	u8 *type;
 	u8 _type;
-	struct {
-		u8 type;
-		u8 len;
-	} *tl, _tl;
 
 	offset += sizeof(struct batadv_dhcp_packet);
 
@@ -1871,10 +1893,10 @@ void batadv_dat_snoop_incoming_dhcp_ack(struct batadv_priv *bat_priv,
 {
 	u8 chaddr[BATADV_DHCP_CHADDR_LEN];
 	struct ethhdr *ethhdr;
-	__be32 ip_src;
-	__be32 yiaddr;
 	unsigned short vid;
 	int hdr_size_tmp;
+	__be32 ip_src;
+	__be32 yiaddr;
 	__be16 proto;
 	u8 *hw_src;
 
@@ -1923,12 +1945,12 @@ void batadv_dat_snoop_incoming_dhcp_ack(struct batadv_priv *bat_priv,
 bool batadv_dat_drop_broadcast_packet(struct batadv_priv *bat_priv,
 				      struct batadv_forw_packet *forw_packet)
 {
-	u16 type;
-	__be32 ip_dst;
-	struct batadv_dat_entry *dat_entry = NULL;
-	bool ret = false;
 	int hdr_size = sizeof(struct batadv_bcast_packet);
+	struct batadv_dat_entry *dat_entry = NULL;
 	unsigned short vid;
+	bool ret = false;
+	__be32 ip_dst;
+	u16 type;
 
 	if (!READ_ONCE(bat_priv->distributed_arp_table))
 		goto out;
diff --git a/net/batman-adv/fragmentation.c b/net/batman-adv/fragmentation.c
index f382af8588b56..5142a911db9ff 100644
--- a/net/batman-adv/fragmentation.c
+++ b/net/batman-adv/fragmentation.c
@@ -139,17 +139,17 @@ static bool batadv_frag_insert_packet(struct batadv_orig_node *orig_node,
 				      struct sk_buff *skb,
 				      struct hlist_head *chain_out)
 {
-	struct batadv_frag_table_entry *chain;
+	struct batadv_frag_list_entry *frag_entry_last = NULL;
 	struct batadv_frag_list_entry *frag_entry_new = NULL;
+	u16 hdr_size = sizeof(struct batadv_frag_packet);
 	struct batadv_frag_list_entry *frag_entry_curr;
-	struct batadv_frag_list_entry *frag_entry_last = NULL;
 	struct batadv_frag_packet *frag_packet;
-	u8 bucket;
-	u16 seqno;
-	u16 hdr_size = sizeof(struct batadv_frag_packet);
+	struct batadv_frag_table_entry *chain;
 	bool overflow = false;
 	bool ret = false;
 	size_t data_len;
+	u8 bucket;
+	u16 seqno;
 
 	/* Linearize packet to avoid linearizing 16 packets in a row when doing
 	 * the later merge. Non-linear merge should be added to remove this
@@ -260,12 +260,12 @@ static bool batadv_frag_insert_packet(struct batadv_orig_node *orig_node,
 static struct sk_buff *
 batadv_frag_merge_packets(struct hlist_head *chain)
 {
-	struct batadv_frag_packet *packet;
+	int hdr_size = sizeof(struct batadv_frag_packet);
 	struct batadv_frag_list_entry *entry;
+	struct batadv_frag_packet *packet;
 	struct sk_buff *skb_out;
-	int size;
-	int hdr_size = sizeof(struct batadv_frag_packet);
 	bool dropped = false;
+	int size;
 
 	/* Remove first entry, as this is the destination for the rest of the
 	 * fragments.
@@ -351,8 +351,8 @@ static bool batadv_skb_is_frag(struct sk_buff *skb)
 bool batadv_frag_skb_buffer(struct sk_buff **skb,
 			    struct batadv_orig_node *orig_node_src)
 {
-	struct sk_buff *skb_out = NULL;
 	struct hlist_head head = HLIST_HEAD_INIT;
+	struct sk_buff *skb_out = NULL;
 	bool ret = false;
 
 	/* Add packet to buffer and table entry if merge is possible. */
@@ -406,8 +406,8 @@ bool batadv_frag_skb_fwd(struct sk_buff *skb,
 	struct batadv_priv *bat_priv = netdev_priv(recv_if->mesh_iface);
 	struct batadv_neigh_node *neigh_node = NULL;
 	struct batadv_frag_packet *packet;
-	u16 total_size;
 	bool ret = false;
+	u16 total_size;
 
 	packet = (struct batadv_frag_packet *)skb->data;
 
@@ -471,10 +471,11 @@ static struct sk_buff *batadv_frag_create(struct net_device *net_dev,
 {
 	unsigned int ll_reserved = LL_RESERVED_SPACE(net_dev);
 	unsigned int tailroom = net_dev->needed_tailroom;
-	struct sk_buff *skb_fragment;
 	unsigned int header_size = sizeof(*frag_head);
-	unsigned int mtu = fragment_size + header_size;
+	struct sk_buff *skb_fragment;
+	unsigned int mtu;
 
+	mtu = fragment_size + header_size;
 	skb_fragment = dev_alloc_skb(ll_reserved + mtu + tailroom);
 	if (!skb_fragment)
 		goto err;
@@ -506,19 +507,20 @@ int batadv_frag_send_packet(struct sk_buff *skb,
 			    struct batadv_neigh_node *neigh_node)
 {
 	struct net_device *net_dev = neigh_node->if_incoming->net_dev;
-	struct batadv_priv *bat_priv;
 	struct batadv_hard_iface *primary_if = NULL;
 	struct batadv_frag_packet frag_header;
-	struct sk_buff *skb_fragment;
 	unsigned int mtu = net_dev->mtu;
-	unsigned int header_size = sizeof(frag_header);
 	unsigned int max_fragment_size;
+	struct batadv_priv *bat_priv;
+	struct sk_buff *skb_fragment;
 	unsigned int num_fragments;
+	unsigned int header_size;
 	int ret;
 
 	/* To avoid merge and refragmentation at next-hops we never send
 	 * fragments larger than BATADV_FRAG_MAX_FRAG_SIZE
 	 */
+	header_size = sizeof(frag_header);
 	mtu = min_t(unsigned int, mtu, BATADV_FRAG_MAX_FRAG_SIZE);
 	max_fragment_size = mtu - header_size;
 
diff --git a/net/batman-adv/gateway_client.c b/net/batman-adv/gateway_client.c
index b1a5b9ca31888..0dfbd3f514c1c 100644
--- a/net/batman-adv/gateway_client.c
+++ b/net/batman-adv/gateway_client.c
@@ -103,8 +103,8 @@ batadv_gw_get_selected_gw_node(struct batadv_priv *bat_priv)
 struct batadv_orig_node *
 batadv_gw_get_selected_orig(struct batadv_priv *bat_priv)
 {
-	struct batadv_gw_node *gw_node;
 	struct batadv_orig_node *orig_node = NULL;
+	struct batadv_gw_node *gw_node;
 
 	gw_node = batadv_gw_get_selected_gw_node(bat_priv);
 	if (!gw_node)
@@ -205,10 +205,10 @@ void batadv_gw_check_client_stop(struct batadv_priv *bat_priv)
  */
 void batadv_gw_election(struct batadv_priv *bat_priv)
 {
+	struct batadv_neigh_ifinfo *router_ifinfo = NULL;
+	struct batadv_neigh_node *router = NULL;
 	struct batadv_gw_node *curr_gw = NULL;
 	struct batadv_gw_node *next_gw = NULL;
-	struct batadv_neigh_node *router = NULL;
-	struct batadv_neigh_ifinfo *router_ifinfo = NULL;
 	char gw_addr[18] = { '\0' };
 
 	if (READ_ONCE(bat_priv->gw.mode) != BATADV_GW_MODE_CLIENT)
@@ -378,8 +378,8 @@ static void batadv_gw_node_add(struct batadv_priv *bat_priv,
 struct batadv_gw_node *batadv_gw_node_get(struct batadv_priv *bat_priv,
 					  struct batadv_orig_node *orig_node)
 {
-	struct batadv_gw_node *gw_node_tmp;
 	struct batadv_gw_node *gw_node = NULL;
+	struct batadv_gw_node *gw_node_tmp;
 
 	rcu_read_lock();
 	hlist_for_each_entry_rcu(gw_node_tmp, &bat_priv->gw.gateway_list,
@@ -409,8 +409,8 @@ void batadv_gw_node_update(struct batadv_priv *bat_priv,
 			   struct batadv_orig_node *orig_node,
 			   struct batadv_tvlv_gateway_data *gateway)
 {
-	struct batadv_gw_node *gw_node;
 	struct batadv_gw_node *curr_gw = NULL;
+	struct batadv_gw_node *gw_node;
 
 	spin_lock_bh(&bat_priv->gw.list_lock);
 	gw_node = batadv_gw_node_get(bat_priv, orig_node);
@@ -568,11 +568,11 @@ batadv_gw_dhcp_recipient_get(struct sk_buff *skb, unsigned int *header_len,
 			     u8 *chaddr)
 {
 	enum batadv_dhcp_recipient ret = BATADV_DHCP_NO;
-	struct ethhdr *ethhdr;
-	struct iphdr *iphdr;
+	struct vlan_ethhdr *vhdr;
 	struct ipv6hdr *ipv6hdr;
+	struct ethhdr *ethhdr;
 	struct udphdr *udphdr;
-	struct vlan_ethhdr *vhdr;
+	struct iphdr *iphdr;
 	int chaddr_offset;
 	__be16 proto;
 	u8 *p;
@@ -692,17 +692,17 @@ batadv_gw_dhcp_recipient_get(struct sk_buff *skb, unsigned int *header_len,
 bool batadv_gw_out_of_range(struct batadv_priv *bat_priv,
 			    struct sk_buff *skb)
 {
+	struct batadv_orig_node *orig_dst_node = NULL;
 	struct batadv_neigh_node *neigh_curr = NULL;
 	struct batadv_neigh_node *neigh_old = NULL;
-	struct batadv_orig_node *orig_dst_node = NULL;
-	struct batadv_gw_node *gw_node = NULL;
-	struct batadv_gw_node *curr_gw = NULL;
 	struct batadv_neigh_ifinfo *curr_ifinfo;
 	struct batadv_neigh_ifinfo *old_ifinfo;
-	struct ethhdr *ethhdr;
+	struct batadv_gw_node *gw_node = NULL;
+	struct batadv_gw_node *curr_gw = NULL;
 	bool out_of_range = false;
-	u8 curr_tq_avg;
+	struct ethhdr *ethhdr;
 	unsigned short vid;
+	u8 curr_tq_avg;
 
 	vid = batadv_get_vid(skb, 0);
 	ethhdr = (struct ethhdr *)skb->data;
diff --git a/net/batman-adv/gateway_common.c b/net/batman-adv/gateway_common.c
index b5ebe837bfdd1..65d3392050906 100644
--- a/net/batman-adv/gateway_common.c
+++ b/net/batman-adv/gateway_common.c
@@ -60,8 +60,8 @@ static void batadv_gw_tvlv_ogm_handler_v1(struct batadv_priv *bat_priv,
 					  u8 flags,
 					  void *tvlv_value, u16 tvlv_value_len)
 {
-	struct batadv_tvlv_gateway_data gateway;
 	struct batadv_tvlv_gateway_data *gateway_ptr;
+	struct batadv_tvlv_gateway_data gateway;
 
 	/* only fetch the tvlv value if the handler wasn't called via the
 	 * CIFNOTFND flag and if there is data to fetch
diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index 1950b8809d99f..e7ad295504e4f 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -350,8 +350,8 @@ static bool batadv_is_cfg80211_netdev(struct net_device *net_device)
  */
 static u32 batadv_wifi_flags_evaluate(struct net_device *net_device)
 {
-	u32 wifi_flags = 0;
 	struct net_device *real_netdev;
+	u32 wifi_flags = 0;
 
 	if (batadv_is_wext_netdev(net_device))
 		wifi_flags |= BATADV_HARDIF_WIFI_WEXT_DIRECT;
@@ -445,8 +445,8 @@ int batadv_hardif_no_broadcast(struct batadv_hard_iface *if_outgoing,
 			       u8 *orig_addr, u8 *orig_neigh)
 {
 	struct batadv_hardif_neigh_node *hardif_neigh;
-	struct hlist_node *first;
 	int ret = BATADV_HARDIF_BCAST_OK;
+	struct hlist_node *first;
 
 	rcu_read_lock();
 
@@ -731,8 +731,8 @@ void batadv_update_min_mtu(struct net_device *mesh_iface)
 static void
 batadv_hardif_activate_interface(struct batadv_hard_iface *hard_iface)
 {
-	struct batadv_priv *bat_priv;
 	struct batadv_hard_iface *primary_if = NULL;
+	struct batadv_priv *bat_priv;
 
 	if (hard_iface->if_status != BATADV_IF_INACTIVE)
 		goto out;
@@ -794,10 +794,10 @@ batadv_hardif_deactivate_interface(struct batadv_hard_iface *hard_iface)
 int batadv_hardif_enable_interface(struct net_device *net_dev,
 				   struct net_device *mesh_iface)
 {
-	struct batadv_priv *bat_priv;
-	__be16 ethertype = htons(ETH_P_BATMAN);
 	int max_header_len = batadv_max_header_len();
+	__be16 ethertype = htons(ETH_P_BATMAN);
 	struct batadv_hard_iface *hard_iface;
+	struct batadv_priv *bat_priv;
 	unsigned int required_mtu;
 	unsigned int hardif_mtu;
 	bool fragmentation;
@@ -1106,8 +1106,8 @@ static int batadv_hard_if_event(struct notifier_block *this,
 				unsigned long event, void *ptr)
 {
 	struct net_device *net_dev = netdev_notifier_info_to_dev(ptr);
-	struct batadv_hard_iface *hard_iface;
 	struct batadv_hard_iface *primary_if = NULL;
+	struct batadv_hard_iface *hard_iface;
 	struct batadv_priv *bat_priv;
 
 	if (batadv_meshif_is_valid(net_dev))
diff --git a/net/batman-adv/hash.h b/net/batman-adv/hash.h
index debbbc936cf74..755ced52a01c5 100644
--- a/net/batman-adv/hash.h
+++ b/net/batman-adv/hash.h
@@ -92,11 +92,11 @@ static inline int batadv_hash_add(struct batadv_hashtable *hash,
 				  const void *data,
 				  struct hlist_node *data_node)
 {
-	u32 index;
-	int ret = -1;
+	spinlock_t *list_lock; /* spinlock to protect write access */
 	struct hlist_head *head;
 	struct hlist_node *node;
-	spinlock_t *list_lock; /* spinlock to protect write access */
+	int ret = -1;
+	u32 index;
 
 	if (!hash)
 		goto out;
@@ -145,10 +145,10 @@ static inline void *batadv_hash_remove(struct batadv_hashtable *hash,
 				       batadv_hashdata_choose_cb choose,
 				       void *data)
 {
-	u32 index;
 	struct hlist_node *node;
 	struct hlist_head *head;
 	void *data_save = NULL;
+	u32 index;
 
 	index = choose(data, hash->size);
 	head = &hash->table[index];
diff --git a/net/batman-adv/log.h b/net/batman-adv/log.h
index a0d2b0d64b2b0..9f3aed826dea6 100644
--- a/net/batman-adv/log.h
+++ b/net/batman-adv/log.h
@@ -117,8 +117,12 @@ static inline void _batadv_dbg(int type __always_unused,
  */
 #define batadv_info(net_dev, fmt, arg...)				\
 	do {								\
-		struct net_device *_netdev = (net_dev);                 \
-		struct batadv_priv *_batpriv = netdev_priv(_netdev);    \
+		struct batadv_priv *_batpriv;				\
+		struct net_device *_netdev;				\
+									\
+		_netdev = (net_dev);					\
+		_batpriv = netdev_priv(_netdev);			\
+									\
 		batadv_dbg(BATADV_DBG_ALL, _batpriv, fmt, ## arg);	\
 		pr_info("%s: " fmt, _netdev->name, ## arg);		\
 	} while (0)
@@ -131,8 +135,12 @@ static inline void _batadv_dbg(int type __always_unused,
  */
 #define batadv_err(net_dev, fmt, arg...)				\
 	do {								\
-		struct net_device *_netdev = (net_dev);                 \
-		struct batadv_priv *_batpriv = netdev_priv(_netdev);    \
+		struct batadv_priv *_batpriv;				\
+		struct net_device *_netdev;				\
+									\
+		_netdev = (net_dev);					\
+		_batpriv = netdev_priv(_netdev);			\
+									\
 		batadv_dbg(BATADV_DBG_ALL, _batpriv, fmt, ## arg);	\
 		pr_err("%s: " fmt, _netdev->name, ## arg);		\
 	} while (0)
diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index d8e9d20add898..5981e8eb6d979 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -368,14 +368,14 @@ int batadv_max_header_len(void)
  */
 void batadv_skb_set_priority(struct sk_buff *skb, int offset)
 {
-	struct iphdr ip_hdr_tmp;
-	struct iphdr *ip_hdr;
+	struct vlan_ethhdr vhdr_tmp;
 	struct ipv6hdr ip6_hdr_tmp;
-	struct ipv6hdr *ip6_hdr;
 	struct ethhdr ethhdr_tmp;
-	struct ethhdr *ethhdr;
 	struct vlan_ethhdr *vhdr;
-	struct vlan_ethhdr vhdr_tmp;
+	struct iphdr ip_hdr_tmp;
+	struct ipv6hdr *ip6_hdr;
+	struct ethhdr *ethhdr;
+	struct iphdr *ip_hdr;
 	u32 prio;
 
 	/* already set, do nothing */
@@ -448,9 +448,9 @@ int batadv_batman_skb_recv(struct sk_buff *skb, struct net_device *dev,
 			   struct packet_type *ptype,
 			   struct net_device *orig_dev)
 {
-	struct batadv_priv *bat_priv;
 	struct batadv_ogm_packet *batadv_ogm_packet;
 	struct batadv_hard_iface *hard_iface;
+	struct batadv_priv *bat_priv;
 	u8 idx;
 
 	hard_iface = container_of(ptype, struct batadv_hard_iface,
@@ -687,9 +687,9 @@ bool batadv_vlan_ap_isola_get(struct batadv_priv *bat_priv, unsigned short vid)
 int batadv_throw_uevent(struct batadv_priv *bat_priv, enum batadv_uev_type type,
 			enum batadv_uev_action action, const char *data)
 {
-	int ret = -ENOMEM;
-	struct kobject *bat_kobj;
 	char *uevent_env[4] = { NULL, NULL, NULL, NULL };
+	struct kobject *bat_kobj;
+	int ret = -ENOMEM;
 
 	bat_kobj = &bat_priv->mesh_iface->dev.kobj;
 
diff --git a/net/batman-adv/mesh-interface.c b/net/batman-adv/mesh-interface.c
index 534e96eb96953..90830b10403f3 100644
--- a/net/batman-adv/mesh-interface.c
+++ b/net/batman-adv/mesh-interface.c
@@ -213,31 +213,29 @@ static void batadv_interface_set_rx_mode(struct net_device *dev)
 static netdev_tx_t batadv_interface_tx(struct sk_buff *skb,
 				       struct net_device *mesh_iface)
 {
-	struct ethhdr *ethhdr;
+	static const u8 ectp_addr[ETH_ALEN] = {0xCF, 0x00, 0x00, 0x00, 0x00, 0x00};
+	static const u8 stp_addr[ETH_ALEN] = {0x01, 0x80, 0xC2, 0x00, 0x00, 0x00};
 	struct batadv_priv *bat_priv = netdev_priv(mesh_iface);
+	enum batadv_dhcp_recipient dhcp_rcp = BATADV_DHCP_NO;
+	enum batadv_forw_mode forw_mode = BATADV_FORW_BCAST;
 	struct batadv_hard_iface *primary_if = NULL;
 	struct batadv_bcast_packet *bcast_packet;
-	static const u8 stp_addr[ETH_ALEN] = {0x01, 0x80, 0xC2, 0x00,
-					      0x00, 0x00};
-	static const u8 ectp_addr[ETH_ALEN] = {0xCF, 0x00, 0x00, 0x00,
-					       0x00, 0x00};
-	enum batadv_dhcp_recipient dhcp_rcp = BATADV_DHCP_NO;
-	u8 *dst_hint = NULL;
-	u8 chaddr[ETH_ALEN];
-	struct vlan_ethhdr *vhdr;
+	int network_offset = ETH_HLEN;
 	unsigned int header_len = 0;
-	int data_len = skb->len;
-	int ret;
 	unsigned long brd_delay = 0;
+	int mcast_is_routable = 0;
+	struct vlan_ethhdr *vhdr;
+	int data_len = skb->len;
+	struct ethhdr *ethhdr;
 	bool do_bcast = false;
-	bool client_added;
+	u8 *dst_hint = NULL;
+	u8 chaddr[ETH_ALEN];
 	unsigned short vid;
-	u32 seqno;
-	int gw_mode;
-	enum batadv_forw_mode forw_mode = BATADV_FORW_BCAST;
-	int mcast_is_routable = 0;
-	int network_offset = ETH_HLEN;
+	bool client_added;
 	__be16 proto;
+	int gw_mode;
+	u32 seqno;
+	int ret;
 
 	if (READ_ONCE(bat_priv->mesh_state) != BATADV_MESH_ACTIVE)
 		goto dropped;
@@ -458,8 +456,8 @@ void batadv_interface_rx(struct net_device *mesh_iface,
 			 struct sk_buff *skb, int hdr_size,
 			 struct batadv_orig_node *orig_node)
 {
-	struct batadv_bcast_packet *batadv_bcast_packet;
 	struct batadv_priv *bat_priv = netdev_priv(mesh_iface);
+	struct batadv_bcast_packet *batadv_bcast_packet;
 	struct vlan_ethhdr *vhdr;
 	struct ethhdr *ethhdr;
 	unsigned short vid;
@@ -573,8 +571,8 @@ void batadv_meshif_vlan_release(struct kref *ref)
 struct batadv_meshif_vlan *batadv_meshif_vlan_get(struct batadv_priv *bat_priv,
 						  unsigned short vid)
 {
-	struct batadv_meshif_vlan *vlan_tmp;
 	struct batadv_meshif_vlan *vlan = NULL;
+	struct batadv_meshif_vlan *vlan_tmp;
 
 	rcu_read_lock();
 	hlist_for_each_entry_rcu(vlan_tmp, &bat_priv->meshif_vlan_list, list) {
@@ -792,10 +790,10 @@ static void batadv_set_lockdep_class(struct net_device *dev)
  */
 static int batadv_meshif_init_late(struct net_device *dev)
 {
+	size_t cnt_len = sizeof(u64) * BATADV_CNT_NUM;
 	struct batadv_priv *bat_priv;
 	u32 random_seqno;
 	int ret;
-	size_t cnt_len = sizeof(u64) * BATADV_CNT_NUM;
 
 	batadv_set_lockdep_class(dev);
 
diff --git a/net/batman-adv/multicast.c b/net/batman-adv/multicast.c
index 5b9e2168a0467..929dca6f21f50 100644
--- a/net/batman-adv/multicast.c
+++ b/net/batman-adv/multicast.c
@@ -274,9 +274,9 @@ static struct batadv_mcast_mla_flags
 batadv_mcast_mla_flags_get(struct batadv_priv *bat_priv)
 {
 	struct net_device *dev = bat_priv->mesh_iface;
+	struct batadv_mcast_mla_flags mla_flags;
 	struct batadv_mcast_querier_state *qr4;
 	struct batadv_mcast_querier_state *qr6;
-	struct batadv_mcast_mla_flags mla_flags;
 	struct net_device *bridge;
 
 	bridge = batadv_mcast_get_bridge(dev);
@@ -522,8 +522,8 @@ batadv_mcast_mla_meshif_get(struct net_device *dev,
 			    struct batadv_mcast_mla_flags *flags)
 {
 	struct net_device *bridge = batadv_mcast_get_bridge(dev);
-	int ret4;
 	int ret6 = 0;
+	int ret4;
 
 	if (bridge)
 		dev = bridge;
@@ -587,11 +587,11 @@ static int batadv_mcast_mla_bridge_get(struct net_device *dev,
 				       struct batadv_mcast_mla_flags *flags)
 {
 	struct list_head bridge_mcast_list = LIST_HEAD_INIT(bridge_mcast_list);
-	struct br_ip_list *br_ip_entry;
-	struct br_ip_list *tmp;
 	u8 tvlv_flags = flags->tvlv_flags;
+	struct br_ip_list *br_ip_entry;
 	struct batadv_hw_addr *new;
 	u8 mcast_addr[ETH_ALEN];
+	struct br_ip_list *tmp;
 	int ret;
 
 	/* we don't need to detect these devices/listeners, the IGMP/MLD
@@ -938,8 +938,8 @@ static void __batadv_mcast_mla_update(struct batadv_priv *bat_priv)
  */
 static void batadv_mcast_mla_update(struct work_struct *work)
 {
-	struct delayed_work *delayed_work;
 	struct batadv_priv_mcast *priv_mcast;
+	struct delayed_work *delayed_work;
 	struct batadv_priv *bat_priv;
 
 	delayed_work = to_delayed_work(work);
@@ -1226,14 +1226,14 @@ enum batadv_forw_mode
 batadv_mcast_forw_mode(struct batadv_priv *bat_priv, struct sk_buff *skb,
 		       unsigned short vid, int *is_routable)
 {
-	int ret;
-	int tt_count;
-	int ip_count;
-	int unsnoop_count;
-	int total_count;
 	bool is_unsnoopable = false;
 	struct ethhdr *ethhdr;
+	int unsnoop_count;
 	int rtr_count = 0;
+	int total_count;
+	int tt_count;
+	int ip_count;
+	int ret;
 
 	ret = batadv_mcast_forw_mode_check(bat_priv, skb, &is_unsnoopable,
 					   is_routable);
@@ -1308,13 +1308,11 @@ static int
 batadv_mcast_forw_tt(struct batadv_priv *bat_priv, struct sk_buff *skb,
 		     unsigned short vid)
 {
-	int ret = NET_XMIT_SUCCESS;
-	struct sk_buff *newskb;
-
 	struct batadv_tt_orig_list_entry *orig_entry;
-
 	struct batadv_tt_global_entry *tt_global;
 	const u8 *addr = eth_hdr(skb)->h_dest;
+	int ret = NET_XMIT_SUCCESS;
+	struct sk_buff *newskb;
 
 	tt_global = batadv_tt_global_hash_find(bat_priv, addr, vid);
 	if (!tt_global)
@@ -1609,8 +1607,8 @@ static void batadv_mcast_want_unsnoop_update(struct batadv_priv *bat_priv,
 					     struct batadv_orig_node *orig,
 					     u8 mcast_flags)
 {
-	struct hlist_node *node = &orig->mcast_want_all_unsnoopables_node;
 	struct hlist_head *head = &bat_priv->mcast.want_all_unsnoopables_list;
+	struct hlist_node *node = &orig->mcast_want_all_unsnoopables_node;
 
 	lockdep_assert_held(&orig->mcast_handler_lock);
 
@@ -1654,8 +1652,8 @@ static void batadv_mcast_want_ipv4_update(struct batadv_priv *bat_priv,
 					  struct batadv_orig_node *orig,
 					  u8 mcast_flags)
 {
-	struct hlist_node *node = &orig->mcast_want_all_ipv4_node;
 	struct hlist_head *head = &bat_priv->mcast.want_all_ipv4_list;
+	struct hlist_node *node = &orig->mcast_want_all_ipv4_node;
 
 	lockdep_assert_held(&orig->mcast_handler_lock);
 
@@ -1699,8 +1697,8 @@ static void batadv_mcast_want_ipv6_update(struct batadv_priv *bat_priv,
 					  struct batadv_orig_node *orig,
 					  u8 mcast_flags)
 {
-	struct hlist_node *node = &orig->mcast_want_all_ipv6_node;
 	struct hlist_head *head = &bat_priv->mcast.want_all_ipv6_list;
+	struct hlist_node *node = &orig->mcast_want_all_ipv6_node;
 
 	lockdep_assert_held(&orig->mcast_handler_lock);
 
@@ -1744,8 +1742,8 @@ static void batadv_mcast_want_rtr4_update(struct batadv_priv *bat_priv,
 					  struct batadv_orig_node *orig,
 					  u8 mcast_flags)
 {
-	struct hlist_node *node = &orig->mcast_want_all_rtr4_node;
 	struct hlist_head *head = &bat_priv->mcast.want_all_rtr4_list;
+	struct hlist_node *node = &orig->mcast_want_all_rtr4_node;
 
 	lockdep_assert_held(&orig->mcast_handler_lock);
 
@@ -1789,8 +1787,8 @@ static void batadv_mcast_want_rtr6_update(struct batadv_priv *bat_priv,
 					  struct batadv_orig_node *orig,
 					  u8 mcast_flags)
 {
-	struct hlist_node *node = &orig->mcast_want_all_rtr6_node;
 	struct hlist_head *head = &bat_priv->mcast.want_all_rtr6_list;
+	struct hlist_node *node = &orig->mcast_want_all_rtr6_node;
 
 	lockdep_assert_held(&orig->mcast_handler_lock);
 
diff --git a/net/batman-adv/multicast_forw.c b/net/batman-adv/multicast_forw.c
index 6dcac586b1d95..ccd4ae158dcd3 100644
--- a/net/batman-adv/multicast_forw.c
+++ b/net/batman-adv/multicast_forw.c
@@ -195,8 +195,8 @@ static int batadv_mcast_forw_push_dests_list(struct batadv_priv *bat_priv,
 					     unsigned short *num_dests,
 					     unsigned short *tvlv_len)
 {
-	struct hlist_node *node;
 	struct batadv_orig_node *orig_node;
+	struct hlist_node *node;
 
 	rcu_read_lock();
 	__hlist_for_each_rcu(node, head) {
@@ -232,12 +232,9 @@ batadv_mcast_forw_push_tt(struct batadv_priv *bat_priv, struct sk_buff *skb,
 			  unsigned short *tvlv_len)
 {
 	struct batadv_tt_orig_list_entry *orig_entry;
-
 	struct batadv_tt_global_entry *tt_global;
 	const u8 *addr = eth_hdr(skb)->h_dest;
-
-	/* ok */
-	int ret = true;
+	int ret = true; /* ok */
 
 	tt_global = batadv_tt_global_hash_find(bat_priv, addr, vid);
 	if (!tt_global)
@@ -368,8 +365,8 @@ static void batadv_mcast_forw_scrape(struct sk_buff *skb,
 				     unsigned short offset,
 				     unsigned short len)
 {
-	char *to;
 	char *from;
+	char *to;
 
 	SKB_LINEAR_ASSERT(skb);
 
@@ -412,8 +409,8 @@ static bool batadv_mcast_forw_push_insert_padding(struct sk_buff *skb,
 						  unsigned short *tvlv_len)
 {
 	unsigned short offset =	*tvlv_len;
-	char *to;
 	char *from = skb->data;
+	char *to;
 
 	to = batadv_mcast_forw_push_padding(skb, tvlv_len);
 	if (!to)
@@ -935,9 +932,9 @@ static int batadv_mcast_forw_packet(struct batadv_priv *bat_priv,
 	unsigned int tvlv_len;
 	unsigned long offset;
 	bool xmitted = false;
-	u8 *dest;
 	u8 *next_dest;
 	u16 num_dests;
+	u8 *dest;
 	int ret;
 
 	/* (at least) TVLV part needs to be linearized */
diff --git a/net/batman-adv/netlink.c b/net/batman-adv/netlink.c
index f4aa7d2055107..926210a67d640 100644
--- a/net/batman-adv/netlink.c
+++ b/net/batman-adv/netlink.c
@@ -752,8 +752,8 @@ static int
 batadv_netlink_tp_meter_cancel(struct sk_buff *skb, struct genl_info *info)
 {
 	struct batadv_priv *bat_priv = info->user_ptr[0];
-	u8 *dst;
 	int ret = 0;
+	u8 *dst;
 
 	if (!info->attrs[BATADV_ATTR_ORIG_ADDRESS])
 		return -EINVAL;
@@ -959,10 +959,10 @@ static int batadv_netlink_set_hardif(struct sk_buff *skb,
 static int
 batadv_netlink_dump_hardif(struct sk_buff *msg, struct netlink_callback *cb)
 {
-	struct net_device *mesh_iface;
+	int portid = NETLINK_CB(cb->skb).portid;
 	struct batadv_hard_iface *hard_iface;
+	struct net_device *mesh_iface;
 	struct batadv_priv *bat_priv;
-	int portid = NETLINK_CB(cb->skb).portid;
 	int skip = cb->args[0];
 	struct list_head *iter;
 	int i = 0;
diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
index 57bb4a0131b0e..f06583ef9b3f5 100644
--- a/net/batman-adv/originator.c
+++ b/net/batman-adv/originator.c
@@ -53,9 +53,9 @@ struct batadv_orig_node *
 batadv_orig_hash_find(struct batadv_priv *bat_priv, const void *data)
 {
 	struct batadv_hashtable *hash = bat_priv->orig_hash;
-	struct hlist_head *head;
-	struct batadv_orig_node *orig_node;
 	struct batadv_orig_node *orig_node_tmp = NULL;
+	struct batadv_orig_node *orig_node;
+	struct hlist_head *head;
 	int index;
 
 	if (!hash)
@@ -284,9 +284,9 @@ void batadv_hardif_neigh_release(struct kref *ref)
  */
 void batadv_neigh_node_release(struct kref *ref)
 {
-	struct hlist_node *node_tmp;
-	struct batadv_neigh_node *neigh_node;
 	struct batadv_neigh_ifinfo *neigh_ifinfo;
+	struct batadv_neigh_node *neigh_node;
+	struct hlist_node *node_tmp;
 
 	neigh_node = container_of(ref, struct batadv_neigh_node, refcount);
 
@@ -316,8 +316,8 @@ struct batadv_neigh_node *
 batadv_orig_router_get(struct batadv_orig_node *orig_node,
 		       const struct batadv_hard_iface *if_outgoing)
 {
-	struct batadv_orig_ifinfo *orig_ifinfo;
 	struct batadv_neigh_node *router = NULL;
+	struct batadv_orig_ifinfo *orig_ifinfo;
 
 	rcu_read_lock();
 	hlist_for_each_entry_rcu(orig_ifinfo, &orig_node->ifinfo_list, list) {
@@ -375,8 +375,8 @@ struct batadv_orig_ifinfo *
 batadv_orig_ifinfo_get(struct batadv_orig_node *orig_node,
 		       struct batadv_hard_iface *if_outgoing)
 {
-	struct batadv_orig_ifinfo *tmp;
 	struct batadv_orig_ifinfo *orig_ifinfo = NULL;
+	struct batadv_orig_ifinfo *tmp;
 
 	rcu_read_lock();
 	hlist_for_each_entry_rcu(tmp, &orig_node->ifinfo_list,
@@ -638,8 +638,8 @@ struct batadv_hardif_neigh_node *
 batadv_hardif_neigh_get(const struct batadv_hard_iface *hard_iface,
 			const u8 *neigh_addr)
 {
-	struct batadv_hardif_neigh_node *tmp_hardif_neigh;
 	struct batadv_hardif_neigh_node *hardif_neigh = NULL;
+	struct batadv_hardif_neigh_node *tmp_hardif_neigh;
 
 	rcu_read_lock();
 	hlist_for_each_entry_rcu(tmp_hardif_neigh,
@@ -673,8 +673,8 @@ batadv_neigh_node_create(struct batadv_orig_node *orig_node,
 			 struct batadv_hard_iface *hard_iface,
 			 const u8 *neigh_addr)
 {
-	struct batadv_neigh_node *neigh_node;
 	struct batadv_hardif_neigh_node *hardif_neigh = NULL;
+	struct batadv_neigh_node *neigh_node;
 
 	spin_lock_bh(&orig_node->neigh_list_lock);
 
@@ -856,12 +856,12 @@ static void batadv_orig_node_free_rcu(struct rcu_head *rcu)
  */
 void batadv_orig_node_release(struct kref *ref)
 {
-	struct hlist_node *node_tmp;
+	struct batadv_orig_ifinfo *last_candidate;
+	struct batadv_orig_ifinfo *orig_ifinfo;
 	struct batadv_neigh_node *neigh_node;
 	struct batadv_orig_node *orig_node;
-	struct batadv_orig_ifinfo *orig_ifinfo;
 	struct batadv_orig_node_vlan *vlan;
-	struct batadv_orig_ifinfo *last_candidate;
+	struct hlist_node *node_tmp;
 
 	orig_node = container_of(ref, struct batadv_orig_node, refcount);
 
@@ -904,11 +904,11 @@ void batadv_orig_node_release(struct kref *ref)
  */
 void batadv_originator_free(struct batadv_priv *bat_priv)
 {
+	spinlock_t *list_lock; /* spinlock to protect write access */
 	struct batadv_hashtable *hash = bat_priv->orig_hash;
+	struct batadv_orig_node *orig_node;
 	struct hlist_node *node_tmp;
 	struct hlist_head *head;
-	spinlock_t *list_lock; /* spinlock to protect write access */
-	struct batadv_orig_node *orig_node;
 	u32 i;
 
 	if (!hash)
@@ -1115,11 +1115,11 @@ static bool
 batadv_purge_orig_neighbors(struct batadv_priv *bat_priv,
 			    struct batadv_orig_node *orig_node)
 {
-	struct hlist_node *node_tmp;
+	struct batadv_hard_iface *if_incoming;
 	struct batadv_neigh_node *neigh_node;
+	struct hlist_node *node_tmp;
 	bool neigh_purged = false;
 	unsigned long last_seen;
-	struct batadv_hard_iface *if_incoming;
 
 	spin_lock_bh(&orig_node->neigh_list_lock);
 
@@ -1173,9 +1173,9 @@ batadv_find_best_neighbor(struct batadv_priv *bat_priv,
 			  struct batadv_orig_node *orig_node,
 			  struct batadv_hard_iface *if_outgoing)
 {
+	struct batadv_algo_ops *bao = bat_priv->algo_ops;
 	struct batadv_neigh_node *best = NULL;
 	struct batadv_neigh_node *neigh;
-	struct batadv_algo_ops *bao = bat_priv->algo_ops;
 
 	rcu_read_lock();
 	hlist_for_each_entry_rcu(neigh, &orig_node->neigh_list, list) {
@@ -1210,9 +1210,9 @@ static bool batadv_purge_orig_node(struct batadv_priv *bat_priv,
 {
 	struct batadv_neigh_node *best_neigh_node;
 	struct batadv_hard_iface *hard_iface;
+	struct list_head *iter;
 	bool changed_ifinfo;
 	bool changed_neigh;
-	struct list_head *iter;
 
 	if (batadv_has_timed_out(orig_node->last_seen,
 				 2 * BATADV_PURGE_TIMEOUT)) {
@@ -1264,11 +1264,11 @@ static bool batadv_purge_orig_node(struct batadv_priv *bat_priv,
  */
 void batadv_purge_orig_ref(struct batadv_priv *bat_priv)
 {
+	spinlock_t *list_lock; /* spinlock to protect write access */
 	struct batadv_hashtable *hash = bat_priv->orig_hash;
+	struct batadv_orig_node *orig_node;
 	struct hlist_node *node_tmp;
 	struct hlist_head *head;
-	spinlock_t *list_lock; /* spinlock to protect write access */
-	struct batadv_orig_node *orig_node;
 	u32 i;
 
 	if (!hash)
diff --git a/net/batman-adv/routing.c b/net/batman-adv/routing.c
index b4c6e13877c12..15ef47d30406e 100644
--- a/net/batman-adv/routing.c
+++ b/net/batman-adv/routing.c
@@ -276,8 +276,8 @@ static int batadv_recv_my_icmp_packet(struct batadv_priv *bat_priv,
 	struct batadv_hard_iface *primary_if = NULL;
 	struct batadv_orig_node *orig_node = NULL;
 	struct batadv_icmp_header *icmph;
-	int res;
 	int ret = NET_RX_DROP;
+	int res;
 
 	icmph = (struct batadv_icmp_header *)skb->data;
 
@@ -349,8 +349,8 @@ static int batadv_recv_icmp_ttl_exceeded(struct batadv_priv *bat_priv,
 	struct batadv_hard_iface *primary_if = NULL;
 	struct batadv_orig_node *orig_node = NULL;
 	struct batadv_icmp_packet *icmp_packet;
-	int res;
 	int ret = NET_RX_DROP;
+	int res;
 
 	icmp_packet = (struct batadv_icmp_packet *)skb->data;
 
@@ -408,13 +408,13 @@ int batadv_recv_icmp_packet(struct sk_buff *skb,
 			    struct batadv_hard_iface *recv_if)
 {
 	struct batadv_priv *bat_priv = netdev_priv(recv_if->mesh_iface);
-	struct batadv_icmp_header *icmph;
+	int hdr_size = sizeof(struct batadv_icmp_header);
 	struct batadv_icmp_packet_rr *icmp_packet_rr;
-	struct ethhdr *ethhdr;
 	struct batadv_orig_node *orig_node = NULL;
-	int hdr_size = sizeof(struct batadv_icmp_header);
-	int res;
+	struct batadv_icmp_header *icmph;
+	struct ethhdr *ethhdr;
 	int ret = NET_RX_DROP;
+	int res;
 
 	/* drop packet if it has not necessary minimum size */
 	if (unlikely(!pskb_may_pull(skb, hdr_size)))
@@ -593,17 +593,17 @@ batadv_find_router(struct batadv_priv *bat_priv,
 		   struct batadv_orig_node *orig_node,
 		   struct batadv_hard_iface *recv_if)
 {
-	struct batadv_algo_ops *bao = bat_priv->algo_ops;
 	struct batadv_neigh_node *first_candidate_router = NULL;
 	struct batadv_neigh_node *next_candidate_router = NULL;
-	struct batadv_neigh_node *router;
-	struct batadv_neigh_node *cand_router = NULL;
 	struct batadv_neigh_node *last_cand_router = NULL;
-	struct batadv_orig_ifinfo *cand;
 	struct batadv_orig_ifinfo *first_candidate = NULL;
+	struct batadv_algo_ops *bao = bat_priv->algo_ops;
 	struct batadv_orig_ifinfo *next_candidate = NULL;
+	struct batadv_neigh_node *cand_router = NULL;
 	struct batadv_orig_ifinfo *last_candidate;
 	bool last_candidate_found = false;
+	struct batadv_neigh_node *router;
+	struct batadv_orig_ifinfo *cand;
 
 	if (!orig_node)
 		return NULL;
@@ -741,13 +741,13 @@ static int batadv_route_unicast_packet(struct sk_buff *skb,
 				       struct batadv_hard_iface *recv_if)
 {
 	struct batadv_priv *bat_priv = netdev_priv(recv_if->mesh_iface);
-	struct batadv_orig_node *orig_node = NULL;
 	struct batadv_unicast_packet *unicast_packet;
+	struct batadv_orig_node *orig_node = NULL;
 	struct ethhdr *ethhdr = eth_hdr(skb);
-	int res;
-	int hdr_len;
 	int ret = NET_RX_DROP;
 	unsigned int len;
+	int hdr_len;
+	int res;
 
 	unicast_packet = (struct batadv_unicast_packet *)skb->data;
 
@@ -830,10 +830,10 @@ batadv_reroute_unicast_packet(struct batadv_priv *bat_priv, struct sk_buff *skb,
 			      struct batadv_unicast_packet *unicast_packet,
 			      u8 *dst_addr, unsigned short vid)
 {
-	struct batadv_orig_node *orig_node = NULL;
 	struct batadv_hard_iface *primary_if = NULL;
-	bool ret = false;
+	struct batadv_orig_node *orig_node = NULL;
 	const u8 *orig_addr;
+	bool ret = false;
 	u8 orig_ttvn;
 
 	if (batadv_is_my_client(bat_priv, dst_addr, vid)) {
@@ -889,11 +889,11 @@ static bool batadv_check_unicast_ttvn(struct batadv_priv *bat_priv,
 	struct batadv_unicast_packet *unicast_packet;
 	struct batadv_hard_iface *primary_if;
 	struct batadv_orig_node *orig_node;
-	u8 curr_ttvn;
-	u8 old_ttvn;
 	struct ethhdr *ethhdr;
 	unsigned short vid;
 	int is_old_ttvn;
+	u8 curr_ttvn;
+	u8 old_ttvn;
 
 	/* check if there is enough data before accessing it */
 	if (!pskb_may_pull(skb, hdr_len + ETH_HLEN))
@@ -1008,10 +1008,10 @@ static bool batadv_check_unicast_ttvn(struct batadv_priv *bat_priv,
 int batadv_recv_unhandled_unicast_packet(struct sk_buff *skb,
 					 struct batadv_hard_iface *recv_if)
 {
-	struct batadv_unicast_packet *unicast_packet;
 	struct batadv_priv *bat_priv = netdev_priv(recv_if->mesh_iface);
-	int check;
+	struct batadv_unicast_packet *unicast_packet;
 	int hdr_size = sizeof(*unicast_packet);
+	int check;
 
 	check = batadv_check_unicast_packet(bat_priv, skb, hdr_size);
 	if (check < 0)
@@ -1040,18 +1040,18 @@ int batadv_recv_unicast_packet(struct sk_buff *skb,
 			       struct batadv_hard_iface *recv_if)
 {
 	struct batadv_priv *bat_priv = netdev_priv(recv_if->mesh_iface);
-	struct batadv_unicast_packet *unicast_packet;
 	struct batadv_unicast_4addr_packet *unicast_4addr_packet;
-	u8 *orig_addr;
-	u8 *orig_addr_gw;
-	struct batadv_orig_node *orig_node = NULL;
+	struct batadv_unicast_packet *unicast_packet;
 	struct batadv_orig_node *orig_node_gw = NULL;
-	int check;
+	struct batadv_orig_node *orig_node = NULL;
 	int hdr_size = sizeof(*unicast_packet);
 	enum batadv_subtype subtype;
 	int ret = NET_RX_DROP;
+	u8 *orig_addr_gw;
+	u8 *orig_addr;
 	bool is4addr;
 	bool is_gw;
+	int check;
 
 	unicast_packet = (struct batadv_unicast_packet *)skb->data;
 	is4addr = unicast_packet->packet_type == BATADV_UNICAST_4ADDR;
@@ -1148,10 +1148,10 @@ int batadv_recv_unicast_tvlv(struct sk_buff *skb,
 {
 	struct batadv_priv *bat_priv = netdev_priv(recv_if->mesh_iface);
 	struct batadv_unicast_tvlv_packet *unicast_tvlv_packet;
-	unsigned char *tvlv_buff;
-	u16 tvlv_buff_len;
 	int hdr_size = sizeof(*unicast_tvlv_packet);
+	unsigned char *tvlv_buff;
 	int ret = NET_RX_DROP;
+	u16 tvlv_buff_len;
 
 	if (batadv_check_unicast_packet(bat_priv, skb, hdr_size) < 0)
 		goto free_skb;
@@ -1266,8 +1266,8 @@ int batadv_recv_bcast_packet(struct sk_buff *skb,
 	struct batadv_priv *bat_priv = netdev_priv(recv_if->mesh_iface);
 	struct batadv_orig_node *orig_node = NULL;
 	struct batadv_bcast_packet *bcast_packet;
-	struct ethhdr *ethhdr;
 	int hdr_size = sizeof(*bcast_packet);
+	struct ethhdr *ethhdr;
 	s32 seq_diff;
 	u32 seqno;
 	int ret;
diff --git a/net/batman-adv/send.c b/net/batman-adv/send.c
index 29f2cbc61285d..2122560c90e51 100644
--- a/net/batman-adv/send.c
+++ b/net/batman-adv/send.c
@@ -271,8 +271,8 @@ bool batadv_send_skb_prepare_unicast_4addr(struct batadv_priv *bat_priv,
 					   struct batadv_orig_node *orig,
 					   int packet_subtype)
 {
-	struct batadv_hard_iface *primary_if;
 	struct batadv_unicast_4addr_packet *uc_4addr_packet;
+	struct batadv_hard_iface *primary_if;
 	bool ret = false;
 
 	primary_if = batadv_primary_if_get_selected(bat_priv);
@@ -322,8 +322,8 @@ int batadv_send_skb_unicast(struct batadv_priv *bat_priv,
 			    unsigned short vid)
 {
 	struct batadv_unicast_packet *unicast_packet;
-	struct ethhdr *ethhdr;
 	int ret = NET_XMIT_DROP;
+	struct ethhdr *ethhdr;
 
 	if (!orig_node)
 		goto out;
diff --git a/net/batman-adv/tp_meter.c b/net/batman-adv/tp_meter.c
index b957a59dcf262..022eb13e8ec47 100644
--- a/net/batman-adv/tp_meter.c
+++ b/net/batman-adv/tp_meter.c
@@ -221,9 +221,9 @@ static void batadv_tp_batctl_notify(enum batadv_tp_meter_reason reason,
 				    unsigned long start_time, u64 total_sent,
 				    u32 cookie)
 {
+	u32 total_bytes;
 	u32 test_time;
 	u8 result;
-	u32 total_bytes;
 
 	if (!batadv_tp_is_error(reason)) {
 		result = BATADV_TP_REASON_COMPLETE;
@@ -267,8 +267,8 @@ static void batadv_tp_batctl_error_notify(enum batadv_tp_meter_reason reason,
 static struct batadv_tp_sender *
 batadv_tp_list_find_sender(struct batadv_priv *bat_priv, const u8 *dst)
 {
-	struct batadv_tp_sender *pos;
 	struct batadv_tp_sender *tp_vars = NULL;
+	struct batadv_tp_sender *pos;
 
 	rcu_read_lock();
 	hlist_for_each_entry_rcu(pos, &bat_priv->tp_sender_list, common.list) {
@@ -333,8 +333,8 @@ static struct batadv_tp_sender *
 batadv_tp_list_find_sender_session(struct batadv_priv *bat_priv, const u8 *dst,
 				   const u8 *session)
 {
-	struct batadv_tp_sender *pos;
 	struct batadv_tp_sender *tp_vars = NULL;
+	struct batadv_tp_sender *pos;
 
 	rcu_read_lock();
 	hlist_for_each_entry_rcu(pos, &bat_priv->tp_sender_list, common.list) {
@@ -580,8 +580,8 @@ static void batadv_tp_sender_timeout(struct timer_list *t)
 static void batadv_tp_fill_prerandom(struct batadv_tp_sender *tp_vars,
 				     u8 *buf, size_t nbytes)
 {
-	u32 local_offset;
 	size_t bytes_inbuf;
+	u32 local_offset;
 	size_t to_copy;
 	size_t pos = 0;
 
@@ -627,9 +627,9 @@ static int batadv_tp_send_msg(struct batadv_tp_sender *tp_vars, const u8 *src,
 {
 	struct batadv_icmp_tp_packet *icmp;
 	struct sk_buff *skb;
-	int r;
-	u8 *data;
 	size_t data_len;
+	u8 *data;
+	int r;
 
 	skb = netdev_alloc_skb_ip_align(NULL, len + ETH_HLEN);
 	if (unlikely(!skb))
@@ -866,8 +866,8 @@ static void batadv_tp_recv_ack(struct batadv_priv *bat_priv,
 static bool batadv_tp_avail(struct batadv_tp_sender *tp_vars,
 			    size_t payload_len)
 {
-	u32 win_left;
 	u32 win_limit;
+	u32 win_left;
 
 	spin_lock_bh(&tp_vars->cc_lock);
 
@@ -913,15 +913,16 @@ static int batadv_tp_wait_available(struct batadv_tp_sender *tp_vars, size_t ple
  */
 static int batadv_tp_send(void *arg)
 {
-	struct batadv_tp_sender *tp_vars = arg;
-	struct batadv_priv *bat_priv = tp_vars->common.bat_priv;
 	struct batadv_hard_iface *primary_if = NULL;
 	struct batadv_orig_node *orig_node = NULL;
+	struct batadv_tp_sender *tp_vars = arg;
+	struct batadv_priv *bat_priv;
 	size_t payload_len;
 	size_t packet_len;
 	u32 last_sent;
 	int err = 0;
 
+	bat_priv = tp_vars->common.bat_priv;
 	orig_node = batadv_orig_hash_find(bat_priv, tp_vars->common.other_end);
 	if (unlikely(!orig_node)) {
 		err = BATADV_TP_REASON_DST_UNREACHABLE;
@@ -1009,8 +1010,8 @@ static int batadv_tp_send(void *arg)
  */
 static void batadv_tp_start_kthread(struct batadv_tp_sender *tp_vars)
 {
-	struct task_struct *kthread;
 	struct batadv_priv *bat_priv = tp_vars->common.bat_priv;
+	struct task_struct *kthread;
 	u32 session_cookie;
 
 	kref_get(&tp_vars->common.refcount);
@@ -1046,9 +1047,9 @@ void batadv_tp_start(struct batadv_priv *bat_priv, const u8 *dst,
 		     u32 test_length, u32 *cookie)
 {
 	struct batadv_tp_sender *tp_vars;
+	u32 session_cookie;
 	u8 session_id[2];
 	u8 icmp_uid;
-	u32 session_cookie;
 
 	get_random_bytes(session_id, sizeof(session_id));
 	get_random_bytes(&icmp_uid, 1);
@@ -1215,8 +1216,8 @@ static struct batadv_tp_receiver *
 batadv_tp_list_find_receiver_session(struct batadv_priv *bat_priv, const u8 *dst,
 				     const u8 *session)
 {
-	struct batadv_tp_receiver *pos;
 	struct batadv_tp_receiver *tp_vars = NULL;
+	struct batadv_tp_receiver *pos;
 
 	rcu_read_lock();
 	hlist_for_each_entry_rcu(pos, &bat_priv->tp_receiver_list, common.list) {
@@ -1301,8 +1302,8 @@ static void batadv_tp_reset_receiver_timer(struct batadv_tp_receiver *tp_vars)
 static void batadv_tp_receiver_shutdown(struct timer_list *t)
 {
 	struct batadv_tp_receiver *tp_vars = timer_container_of(tp_vars, t, common.timer);
-	struct batadv_tp_unacked *un;
 	struct batadv_tp_unacked *safe;
+	struct batadv_tp_unacked *un;
 	struct batadv_priv *bat_priv;
 
 	bat_priv = tp_vars->common.bat_priv;
@@ -1357,8 +1358,8 @@ static int batadv_tp_send_ack(struct batadv_priv *bat_priv, const u8 *dst,
 	struct batadv_orig_node *orig_node;
 	struct batadv_icmp_tp_packet *icmp;
 	struct sk_buff *skb;
-	int r;
 	int ret;
+	int r;
 
 	orig_node = batadv_orig_hash_find(bat_priv, dst);
 	if (unlikely(!orig_node)) {
@@ -1535,8 +1536,8 @@ static bool batadv_tp_handle_out_of_order(struct batadv_tp_receiver *tp_vars,
 static void batadv_tp_ack_unordered(struct batadv_tp_receiver *tp_vars)
 	__must_hold(&tp_vars->ack_seqno_lock)
 {
-	struct batadv_tp_unacked *un;
 	struct batadv_tp_unacked *safe;
+	struct batadv_tp_unacked *un;
 	u32 to_ack;
 
 	/* go through the unacked packet list and possibly ACK them as
diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 4fe09f6da7cc5..96bfd5f303c1e 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -128,10 +128,10 @@ static struct batadv_tt_common_entry *
 batadv_tt_hash_find(struct batadv_hashtable *hash, const u8 *addr,
 		    unsigned short vid)
 {
-	struct hlist_head *head;
+	struct batadv_tt_common_entry *tt_tmp = NULL;
 	struct batadv_tt_common_entry to_search;
 	struct batadv_tt_common_entry *tt;
-	struct batadv_tt_common_entry *tt_tmp = NULL;
+	struct hlist_head *head;
 	u32 index;
 
 	if (!hash)
@@ -175,8 +175,8 @@ static struct batadv_tt_local_entry *
 batadv_tt_local_hash_find(struct batadv_priv *bat_priv, const u8 *addr,
 			  unsigned short vid)
 {
-	struct batadv_tt_common_entry *tt_common_entry;
 	struct batadv_tt_local_entry *tt_local_entry = NULL;
+	struct batadv_tt_common_entry *tt_common_entry;
 
 	tt_common_entry = batadv_tt_hash_find(bat_priv->tt.local_hash, addr,
 					      vid);
@@ -200,8 +200,8 @@ struct batadv_tt_global_entry *
 batadv_tt_global_hash_find(struct batadv_priv *bat_priv, const u8 *addr,
 			   unsigned short vid)
 {
-	struct batadv_tt_common_entry *tt_common_entry;
 	struct batadv_tt_global_entry *tt_global_entry = NULL;
+	struct batadv_tt_common_entry *tt_common_entry;
 
 	tt_common_entry = batadv_tt_hash_find(bat_priv->tt.global_hash, addr,
 					      vid);
@@ -423,11 +423,11 @@ static void batadv_tt_local_event(struct batadv_priv *bat_priv,
 				  struct batadv_tt_local_entry *tt_local_entry,
 				  u8 event_flags)
 {
+	struct batadv_tt_common_entry *common = &tt_local_entry->common;
 	struct batadv_tt_change_node *tt_change_node;
+	u8 flags = common->flags | event_flags;
 	struct batadv_tt_change_node *entry;
 	struct batadv_tt_change_node *safe;
-	struct batadv_tt_common_entry *common = &tt_local_entry->common;
-	u8 flags = common->flags | event_flags;
 	bool del_op_requested;
 	bool del_op_entry;
 	size_t changes;
@@ -519,9 +519,9 @@ static u16 batadv_tt_entries(u16 tt_len)
  */
 static int batadv_tt_local_table_transmit_size(struct batadv_priv *bat_priv)
 {
-	u16 num_vlan = 0;
-	u16 tt_local_entries = 0;
 	struct batadv_meshif_vlan *vlan;
+	u16 tt_local_entries = 0;
+	u16 num_vlan = 0;
 	int hdr_size;
 
 	rcu_read_lock();
@@ -614,20 +614,20 @@ bool batadv_tt_local_add(struct net_device *mesh_iface, const u8 *addr,
 			 unsigned short vid, int ifindex, u32 mark)
 {
 	struct batadv_priv *bat_priv = netdev_priv(mesh_iface);
-	struct batadv_tt_local_entry *tt_local;
 	struct batadv_tt_global_entry *tt_global = NULL;
+	struct batadv_tt_orig_list_entry *orig_entry;
+	struct batadv_tt_local_entry *tt_local;
 	struct net *net = dev_net(mesh_iface);
-	struct batadv_meshif_vlan *vlan;
 	struct net_device *in_dev = NULL;
+	struct batadv_meshif_vlan *vlan;
+	bool roamed_back = false;
+	bool iif_is_wifi = false;
 	struct hlist_head *head;
-	struct batadv_tt_orig_list_entry *orig_entry;
-	int hash_added;
-	int table_size;
 	int packet_size_max;
 	bool ret = false;
-	bool roamed_back = false;
-	bool iif_is_wifi = false;
 	u8 remote_flags;
+	int hash_added;
+	int table_size;
 	u32 match_mark;
 
 	if (ifindex != BATADV_NULL_IFINDEX)
@@ -1009,16 +1009,16 @@ batadv_tt_prepare_tvlv_local_data(struct batadv_priv *bat_priv,
  */
 static void batadv_tt_tvlv_container_update(struct batadv_priv *bat_priv)
 {
+	struct batadv_tvlv_tt_change *tt_change;
 	struct batadv_tt_change_node *entry;
-	struct batadv_tt_change_node *safe;
 	struct batadv_tvlv_tt_data *tt_data;
-	struct batadv_tvlv_tt_change *tt_change;
-	int tt_diff_len;
-	int tt_change_len = 0;
-	int tt_diff_entries_num = 0;
+	struct batadv_tt_change_node *safe;
 	int tt_diff_entries_count = 0;
+	int tt_diff_entries_num = 0;
 	bool drop_changes = false;
 	size_t tt_extra_len = 0;
+	int tt_change_len = 0;
+	int tt_diff_len;
 	u16 tvlv_len;
 
 	tt_diff_entries_num = READ_ONCE(bat_priv->tt.local_changes);
@@ -1111,10 +1111,10 @@ batadv_tt_local_dump_entry(struct sk_buff *msg, u32 portid,
 			   struct batadv_priv *bat_priv,
 			   struct batadv_tt_common_entry *common)
 {
-	void *hdr;
-	struct batadv_meshif_vlan *vlan;
 	struct batadv_tt_local_entry *local;
+	struct batadv_meshif_vlan *vlan;
 	unsigned int last_seen_msecs;
+	void *hdr;
 	u32 crc;
 
 	local = container_of(common, struct batadv_tt_local_entry, common);
@@ -1205,14 +1205,14 @@ batadv_tt_local_dump_bucket(struct sk_buff *msg, u32 portid,
  */
 int batadv_tt_local_dump(struct sk_buff *msg, struct netlink_callback *cb)
 {
-	struct net_device *mesh_iface;
-	struct batadv_priv *bat_priv;
 	struct batadv_hard_iface *primary_if = NULL;
+	int portid = NETLINK_CB(cb->skb).portid;
+	struct net_device *mesh_iface;
 	struct batadv_hashtable *hash;
-	int ret;
+	struct batadv_priv *bat_priv;
 	int bucket = cb->args[0];
 	int idx = cb->args[1];
-	int portid = NETLINK_CB(cb->skb).portid;
+	int ret;
 
 	mesh_iface = batadv_netlink_get_meshif(cb);
 	if (IS_ERR(mesh_iface))
@@ -1294,9 +1294,9 @@ u16 batadv_tt_local_remove(struct batadv_priv *bat_priv, const u8 *addr,
 {
 	struct batadv_tt_local_entry *tt_removed_entry;
 	struct batadv_tt_local_entry *tt_local_entry;
-	u16 flags;
-	u16 curr_flags = BATADV_NO_FLAGS;
 	struct hlist_node *tt_removed_node;
+	u16 curr_flags = BATADV_NO_FLAGS;
+	u16 flags;
 
 	tt_local_entry = batadv_tt_local_hash_find(bat_priv, addr, vid);
 	if (!tt_local_entry)
@@ -1355,8 +1355,8 @@ static void batadv_tt_local_purge_list(struct batadv_priv *bat_priv,
 				       struct hlist_head *head,
 				       int timeout)
 {
-	struct batadv_tt_local_entry *tt_local_entry;
 	struct batadv_tt_common_entry *tt_common_entry;
+	struct batadv_tt_local_entry *tt_local_entry;
 	struct hlist_node *node_tmp;
 
 	hlist_for_each_entry_safe(tt_common_entry, node_tmp, head,
@@ -1388,9 +1388,9 @@ static void batadv_tt_local_purge_list(struct batadv_priv *bat_priv,
 static void batadv_tt_local_purge(struct batadv_priv *bat_priv,
 				  int timeout)
 {
+	spinlock_t *list_lock; /* protects write access to the hash lists */
 	struct batadv_hashtable *hash = bat_priv->tt.local_hash;
 	struct hlist_head *head;
-	spinlock_t *list_lock; /* protects write access to the hash lists */
 	u32 i;
 
 	for (i = 0; i < hash->size; i++) {
@@ -1412,10 +1412,10 @@ static void batadv_tt_local_purge(struct batadv_priv *bat_priv,
  */
 static void batadv_tt_local_table_free(struct batadv_priv *bat_priv)
 {
-	struct batadv_hashtable *hash;
 	spinlock_t *list_lock; /* protects write access to the hash lists */
 	struct batadv_tt_common_entry *tt_common_entry;
 	struct batadv_tt_local_entry *tt_local;
+	struct batadv_hashtable *hash;
 	struct hlist_node *node_tmp;
 	struct hlist_head *head;
 	u32 i;
@@ -1508,8 +1508,8 @@ static struct batadv_tt_orig_list_entry *
 batadv_tt_global_orig_entry_find(const struct batadv_tt_global_entry *entry,
 				 const struct batadv_orig_node *orig_node)
 {
-	struct batadv_tt_orig_list_entry *tmp_orig_entry;
 	struct batadv_tt_orig_list_entry *orig_entry = NULL;
+	struct batadv_tt_orig_list_entry *tmp_orig_entry;
 	const struct hlist_head *head;
 
 	rcu_read_lock();
@@ -1662,10 +1662,10 @@ static bool batadv_tt_global_add(struct batadv_priv *bat_priv,
 {
 	struct batadv_tt_global_entry *tt_global_entry;
 	struct batadv_tt_local_entry *tt_local_entry;
-	bool ret = false;
-	int hash_added;
 	struct batadv_tt_common_entry *common;
+	bool ret = false;
 	u16 local_flags;
+	int hash_added;
 
 	/* ignore global entries from backbone nodes */
 	if (batadv_bla_is_backbone_gw_orig(bat_priv, orig_node->orig, vid))
@@ -1821,12 +1821,12 @@ static struct batadv_tt_orig_list_entry *
 batadv_transtable_best_orig(struct batadv_priv *bat_priv,
 			    struct batadv_tt_global_entry *tt_global_entry)
 {
-	struct batadv_neigh_node *router;
-	struct batadv_neigh_node *best_router = NULL;
+	struct batadv_tt_orig_list_entry *best_entry = NULL;
 	struct batadv_algo_ops *bao = bat_priv->algo_ops;
-	struct hlist_head *head;
+	struct batadv_neigh_node *best_router = NULL;
 	struct batadv_tt_orig_list_entry *orig_entry;
-	struct batadv_tt_orig_list_entry *best_entry = NULL;
+	struct batadv_neigh_node *router;
+	struct hlist_head *head;
 
 	head = &tt_global_entry->orig_list;
 	hlist_for_each_entry_rcu(orig_entry, head, list) {
@@ -1872,9 +1872,9 @@ batadv_tt_global_dump_subentry(struct sk_buff *msg, u32 portid, u32 seq,
 			       bool best)
 {
 	u16 flags = (common->flags & (~BATADV_TT_SYNC_MASK)) | orig->flags;
-	void *hdr;
 	struct batadv_orig_node_vlan *vlan;
 	u8 last_ttvn;
+	void *hdr;
 	u32 crc;
 
 	vlan = batadv_orig_node_vlan_get(orig->orig_node,
@@ -2009,16 +2009,16 @@ batadv_tt_global_dump_bucket(struct sk_buff *msg, u32 portid, u32 seq,
  */
 int batadv_tt_global_dump(struct sk_buff *msg, struct netlink_callback *cb)
 {
-	struct net_device *mesh_iface;
-	struct batadv_priv *bat_priv;
 	struct batadv_hard_iface *primary_if = NULL;
+	int portid = NETLINK_CB(cb->skb).portid;
+	struct net_device *mesh_iface;
 	struct batadv_hashtable *hash;
-	struct hlist_head *head;
-	int ret;
+	struct batadv_priv *bat_priv;
 	int bucket = cb->args[0];
+	struct hlist_head *head;
 	int idx = cb->args[1];
 	int sub = cb->args[2];
-	int portid = NETLINK_CB(cb->skb).portid;
+	int ret;
 
 	mesh_iface = batadv_netlink_get_meshif(cb);
 	if (IS_ERR(mesh_iface))
@@ -2093,9 +2093,9 @@ _batadv_tt_global_del_orig_entry(struct batadv_tt_global_entry *tt_global_entry,
 static void
 batadv_tt_global_del_orig_list(struct batadv_tt_global_entry *tt_global_entry)
 {
+	struct batadv_tt_orig_list_entry *orig_entry;
 	struct hlist_head *head;
 	struct hlist_node *safe;
-	struct batadv_tt_orig_list_entry *orig_entry;
 
 	spin_lock_bh(&tt_global_entry->list_lock);
 	head = &tt_global_entry->orig_list;
@@ -2120,9 +2120,9 @@ batadv_tt_global_del_orig_node(struct batadv_priv *bat_priv,
 			       struct batadv_orig_node *orig_node,
 			       const char *message)
 {
+	struct batadv_tt_orig_list_entry *orig_entry;
 	struct hlist_head *head;
 	struct hlist_node *safe;
-	struct batadv_tt_orig_list_entry *orig_entry;
 	unsigned short vid;
 
 	spin_lock_bh(&tt_global_entry->list_lock);
@@ -2160,9 +2160,9 @@ batadv_tt_global_del_roaming(struct batadv_priv *bat_priv,
 			     struct batadv_orig_node *orig_node,
 			     const char *message)
 {
-	bool last_entry = true;
-	struct hlist_head *head;
 	struct batadv_tt_orig_list_entry *orig_entry;
+	struct hlist_head *head;
+	bool last_entry = true;
 
 	/* no local entry exists, case 1:
 	 * Check if this is the last one or if other entries exist.
@@ -2206,8 +2206,8 @@ static void batadv_tt_global_del(struct batadv_priv *bat_priv,
 				 const unsigned char *addr, unsigned short vid,
 				 const char *message, bool roaming)
 {
-	struct batadv_tt_global_entry *tt_global_entry;
 	struct batadv_tt_local_entry *local_entry = NULL;
+	struct batadv_tt_global_entry *tt_global_entry;
 
 	tt_global_entry = batadv_tt_global_hash_find(bat_priv, addr, vid);
 	if (!tt_global_entry)
@@ -2269,14 +2269,14 @@ void batadv_tt_global_del_orig(struct batadv_priv *bat_priv,
 			       s32 match_vid,
 			       const char *message)
 {
-	struct batadv_tt_global_entry *tt_global;
-	struct batadv_tt_common_entry *tt_common_entry;
-	u32 i;
+	spinlock_t *list_lock; /* protects write access to the hash lists */
 	struct batadv_hashtable *hash = bat_priv->tt.global_hash;
+	struct batadv_tt_common_entry *tt_common_entry;
+	struct batadv_tt_global_entry *tt_global;
 	struct hlist_node *safe;
 	struct hlist_head *head;
-	spinlock_t *list_lock; /* protects write access to the hash lists */
 	unsigned short vid;
+	u32 i;
 
 	if (!hash)
 		return;
@@ -2326,9 +2326,9 @@ void batadv_tt_global_del_orig(struct batadv_priv *bat_priv,
 static bool batadv_tt_global_to_purge(struct batadv_tt_global_entry *tt_global,
 				      char **msg)
 {
-	bool purge = false;
 	unsigned long roam_timeout = BATADV_TT_CLIENT_ROAM_TIMEOUT;
 	unsigned long temp_timeout = BATADV_TT_CLIENT_TEMP_TIMEOUT;
+	bool purge = false;
 
 	if ((tt_global->common.flags & BATADV_TT_CLIENT_ROAM) &&
 	    batadv_has_timed_out(tt_global->roam_at, roam_timeout)) {
@@ -2354,14 +2354,14 @@ static bool batadv_tt_global_to_purge(struct batadv_tt_global_entry *tt_global,
  */
 static void batadv_tt_global_purge(struct batadv_priv *bat_priv)
 {
-	struct batadv_hashtable *hash = bat_priv->tt.global_hash;
-	struct hlist_head *head;
-	struct hlist_node *node_tmp;
 	spinlock_t *list_lock; /* protects write access to the hash lists */
-	u32 i;
-	char *msg = NULL;
+	struct batadv_hashtable *hash = bat_priv->tt.global_hash;
 	struct batadv_tt_common_entry *tt_common;
 	struct batadv_tt_global_entry *tt_global;
+	struct hlist_node *node_tmp;
+	struct hlist_head *head;
+	char *msg = NULL;
+	u32 i;
 
 	for (i = 0; i < hash->size; i++) {
 		head = &hash->table[i];
@@ -2400,10 +2400,10 @@ static void batadv_tt_global_purge(struct batadv_priv *bat_priv)
  */
 static void batadv_tt_global_table_free(struct batadv_priv *bat_priv)
 {
-	struct batadv_hashtable *hash;
 	spinlock_t *list_lock; /* protects write access to the hash lists */
 	struct batadv_tt_common_entry *tt_common_entry;
 	struct batadv_tt_global_entry *tt_global;
+	struct batadv_hashtable *hash;
 	struct hlist_node *node_tmp;
 	struct hlist_head *head;
 	u32 i;
@@ -2479,10 +2479,10 @@ struct batadv_orig_node *batadv_transtable_search(struct batadv_priv *bat_priv,
 						  const u8 *addr,
 						  unsigned short vid)
 {
-	struct batadv_tt_local_entry *tt_local_entry = NULL;
 	struct batadv_tt_global_entry *tt_global_entry = NULL;
-	struct batadv_orig_node *orig_node = NULL;
+	struct batadv_tt_local_entry *tt_local_entry = NULL;
 	struct batadv_tt_orig_list_entry *best_entry;
+	struct batadv_orig_node *orig_node = NULL;
 
 	if (src && batadv_vlan_ap_isola_get(bat_priv, vid)) {
 		tt_local_entry = batadv_tt_local_hash_find(bat_priv, src, vid);
@@ -2551,11 +2551,11 @@ static u32 batadv_tt_global_crc(struct batadv_priv *bat_priv,
 	struct batadv_tt_common_entry *tt_common;
 	struct batadv_tt_global_entry *tt_global;
 	struct hlist_head *head;
-	u32 i;
+	__be16 tmp_vid;
 	u32 crc_tmp;
 	u32 crc = 0;
 	u8 flags;
-	__be16 tmp_vid;
+	u32 i;
 
 	for (i = 0; i < hash->size; i++) {
 		head = &hash->table[i];
@@ -2631,11 +2631,11 @@ static u32 batadv_tt_local_crc(struct batadv_priv *bat_priv,
 	struct batadv_hashtable *hash = bat_priv->tt.local_hash;
 	struct batadv_tt_common_entry *tt_common;
 	struct hlist_head *head;
-	u32 i;
+	__be16 tmp_vid;
 	u32 crc_tmp;
 	u32 crc = 0;
 	u8 flags;
-	__be16 tmp_vid;
+	u32 i;
 
 	for (i = 0; i < hash->size; i++) {
 		head = &hash->table[i];
@@ -2784,8 +2784,8 @@ static struct batadv_tt_req_node *
 batadv_tt_req_node_new(struct batadv_priv *bat_priv,
 		       struct batadv_orig_node *orig_node)
 {
-	struct batadv_tt_req_node *tt_req_node_tmp;
 	struct batadv_tt_req_node *tt_req_node = NULL;
+	struct batadv_tt_req_node *tt_req_node_tmp;
 
 	spin_lock_bh(&bat_priv->tt.req_list_lock);
 	hlist_for_each_entry(tt_req_node_tmp, &bat_priv->tt.req_list, list) {
@@ -2894,8 +2894,8 @@ static u16 batadv_tt_tvlv_generate(struct batadv_priv *bat_priv,
 	struct batadv_tt_common_entry *tt_common_entry;
 	struct batadv_tvlv_tt_change *tt_change;
 	struct hlist_head *head;
-	u16 tt_tot;
 	u16 tt_num_entries = 0;
+	u16 tt_tot;
 	u8 flags;
 	bool ret;
 	u32 i;
@@ -2949,9 +2949,9 @@ static bool batadv_tt_global_check_crc(struct batadv_orig_node *orig_node,
 {
 	struct batadv_tvlv_tt_vlan_data *tt_vlan_tmp;
 	struct batadv_orig_node_vlan *vlan;
-	int i;
 	int orig_num_vlan;
 	u32 crc;
+	int i;
 
 	/* check if each received CRC matches the locally stored one */
 	for (i = 0; i < num_vlan; i++) {
@@ -3057,8 +3057,8 @@ static bool batadv_send_tt_request(struct batadv_priv *bat_priv,
 	struct batadv_tt_req_node *tt_req_node = NULL;
 	struct batadv_hard_iface *primary_if;
 	bool ret = false;
-	int i;
 	int size;
+	int i;
 
 	primary_if = batadv_primary_if_get_selected(bat_priv);
 	if (!primary_if)
@@ -3134,15 +3134,15 @@ static bool batadv_send_other_tt_response(struct batadv_priv *bat_priv,
 					  struct batadv_tvlv_tt_data *tt_data,
 					  u8 *req_src, u8 *req_dst)
 {
-	struct batadv_orig_node *req_dst_orig_node;
 	struct batadv_orig_node *res_dst_orig_node = NULL;
-	struct batadv_tvlv_tt_change *tt_change;
 	struct batadv_tvlv_tt_data *tvlv_tt_data = NULL;
+	struct batadv_orig_node *req_dst_orig_node;
+	struct batadv_tvlv_tt_change *tt_change;
 	bool ret = false;
 	bool full_table;
 	u8 orig_ttvn;
-	u8 req_ttvn;
 	u16 tvlv_len;
+	u8 req_ttvn;
 	s32 tt_len;
 
 	batadv_dbg(BATADV_DBG_TT, bat_priv,
@@ -3269,10 +3269,10 @@ static bool batadv_send_my_tt_response(struct batadv_priv *bat_priv,
 	struct batadv_hard_iface *primary_if = NULL;
 	struct batadv_tvlv_tt_change *tt_change;
 	struct batadv_orig_node *orig_node;
-	u8 my_ttvn;
-	u8 req_ttvn;
-	u16 tvlv_len;
 	bool full_table;
+	u16 tvlv_len;
+	u8 req_ttvn;
+	u8 my_ttvn;
 	s32 tt_len;
 
 	batadv_dbg(BATADV_DBG_TT, bat_priv,
@@ -3407,8 +3407,8 @@ static void _batadv_tt_update_changes(struct batadv_priv *bat_priv,
 				      struct batadv_tvlv_tt_change *tt_change,
 				      u16 tt_num_changes, u8 ttvn)
 {
-	int i;
 	int roams;
+	int i;
 
 	for (i = 0; i < tt_num_changes; i++) {
 		if ((tt_change + i)->flags & BATADV_TT_CLIENT_DEL) {
@@ -3539,11 +3539,11 @@ static void batadv_handle_tt_response(struct batadv_priv *bat_priv,
 				      struct batadv_tvlv_tt_data *tt_data,
 				      u8 *resp_src, u16 num_entries)
 {
-	struct batadv_tt_req_node *node;
-	struct hlist_node *safe;
 	struct batadv_orig_node *orig_node = NULL;
 	struct batadv_tvlv_tt_change *tt_change;
+	struct batadv_tt_req_node *node;
 	u8 *tvlv_ptr = (u8 *)tt_data;
+	struct hlist_node *safe;
 
 	batadv_dbg(BATADV_DBG_TT, bat_priv,
 		   "Received TT_RESPONSE from %pM for ttvn %d t_size: %d [%c]\n",
@@ -3702,8 +3702,8 @@ static void batadv_send_roam_adv(struct batadv_priv *bat_priv, u8 *client,
 				 unsigned short vid,
 				 struct batadv_orig_node *orig_node)
 {
-	struct batadv_hard_iface *primary_if;
 	struct batadv_tvlv_roam_adv tvlv_roam;
+	struct batadv_hard_iface *primary_if;
 
 	primary_if = batadv_primary_if_get_selected(bat_priv);
 	if (!primary_if)
@@ -3836,12 +3836,12 @@ static void batadv_tt_local_set_flags(struct batadv_priv *bat_priv, u16 flags,
  */
 static void batadv_tt_local_purge_pending_clients(struct batadv_priv *bat_priv)
 {
+	spinlock_t *list_lock; /* protects write access to the hash lists */
 	struct batadv_hashtable *hash = bat_priv->tt.local_hash;
 	struct batadv_tt_common_entry *tt_common;
 	struct batadv_tt_local_entry *tt_local;
 	struct hlist_node *node_tmp;
 	struct hlist_head *head;
-	spinlock_t *list_lock; /* protects write access to the hash lists */
 	u32 i;
 
 	if (!hash)
@@ -3931,8 +3931,8 @@ void batadv_tt_local_commit_changes(struct batadv_priv *bat_priv)
 bool batadv_is_ap_isolated(struct batadv_priv *bat_priv, u8 *src, u8 *dst,
 			   unsigned short vid)
 {
-	struct batadv_tt_local_entry *tt_local_entry;
 	struct batadv_tt_global_entry *tt_global_entry;
+	struct batadv_tt_local_entry *tt_local_entry;
 	struct batadv_meshif_vlan *vlan;
 	bool ret = false;
 
@@ -4142,14 +4142,15 @@ bool batadv_tt_add_temporary_global_entry(struct batadv_priv *bat_priv,
 void batadv_tt_local_resize_to_mtu(struct net_device *mesh_iface)
 {
 	struct batadv_priv *bat_priv = netdev_priv(mesh_iface);
-	int packet_size_max = READ_ONCE(bat_priv->packet_size_max);
-	int table_size;
 	int timeout = BATADV_TT_LOCAL_TIMEOUT / 2;
 	bool reduced = false;
+	int packet_size_max;
+	int table_size;
 
 	spin_lock_bh(&bat_priv->tt.commit_lock);
 
 	while (timeout) {
+		packet_size_max = READ_ONCE(bat_priv->packet_size_max);
 		table_size = batadv_tt_local_table_transmit_size(bat_priv);
 		if (packet_size_max >= table_size)
 			break;
@@ -4188,9 +4189,9 @@ static void batadv_tt_tvlv_ogm_handler_v1(struct batadv_priv *bat_priv,
 {
 	struct batadv_tvlv_tt_change *tt_change;
 	struct batadv_tvlv_tt_data *tt_data;
+	size_t tt_data_sz;
 	u16 num_entries;
 	u16 num_vlan;
-	size_t tt_data_sz;
 
 	if (tvlv_value_len < sizeof(*tt_data))
 		return;
@@ -4312,8 +4313,8 @@ static int batadv_roam_tvlv_unicast_handler_v1(struct batadv_priv *bat_priv,
 					       void *tvlv_value,
 					       u16 tvlv_value_len)
 {
-	struct batadv_tvlv_roam_adv *roaming_adv;
 	struct batadv_orig_node *orig_node = NULL;
+	struct batadv_tvlv_roam_adv *roaming_adv;
 
 	/* If this node is not the intended recipient of the
 	 * roaming advertisement the packet is forwarded
@@ -4416,12 +4417,12 @@ bool batadv_tt_global_is_isolated(struct batadv_priv *bat_priv,
  */
 int __init batadv_tt_cache_init(void)
 {
-	size_t tl_size = sizeof(struct batadv_tt_local_entry);
-	size_t tg_size = sizeof(struct batadv_tt_global_entry);
 	size_t tt_orig_size = sizeof(struct batadv_tt_orig_list_entry);
 	size_t tt_change_size = sizeof(struct batadv_tt_change_node);
-	size_t tt_req_size = sizeof(struct batadv_tt_req_node);
 	size_t tt_roam_size = sizeof(struct batadv_tt_roam_node);
+	size_t tg_size = sizeof(struct batadv_tt_global_entry);
+	size_t tt_req_size = sizeof(struct batadv_tt_req_node);
+	size_t tl_size = sizeof(struct batadv_tt_local_entry);
 
 	batadv_tl_cache = kmem_cache_create("batadv_tl_cache", tl_size, 0,
 					    SLAB_HWCACHE_ALIGN, NULL);
diff --git a/net/batman-adv/tvlv.c b/net/batman-adv/tvlv.c
index 066468acf20d7..5600aaf00627c 100644
--- a/net/batman-adv/tvlv.c
+++ b/net/batman-adv/tvlv.c
@@ -72,8 +72,8 @@ static void batadv_tvlv_handler_put(struct batadv_tvlv_handler *tvlv_handler)
 static struct batadv_tvlv_handler *
 batadv_tvlv_handler_get(struct batadv_priv *bat_priv, u8 type, u8 version)
 {
-	struct batadv_tvlv_handler *tvlv_handler_tmp;
 	struct batadv_tvlv_handler *tvlv_handler = NULL;
+	struct batadv_tvlv_handler *tvlv_handler_tmp;
 
 	rcu_read_lock();
 	hlist_for_each_entry_rcu(tvlv_handler_tmp,
@@ -135,8 +135,8 @@ static void batadv_tvlv_container_put(struct batadv_tvlv_container *tvlv)
 static struct batadv_tvlv_container *
 batadv_tvlv_container_get(struct batadv_priv *bat_priv, u8 type, u8 version)
 {
-	struct batadv_tvlv_container *tvlv_tmp;
 	struct batadv_tvlv_container *tvlv = NULL;
+	struct batadv_tvlv_container *tvlv_tmp;
 
 	lockdep_assert_held(&bat_priv->tvlv.container_list_lock);
 
@@ -537,13 +537,13 @@ int batadv_tvlv_containers_process(struct batadv_priv *bat_priv,
 				   struct sk_buff *skb, void *tvlv_value,
 				   u16 tvlv_value_len)
 {
+	u8 cifnotfound = BATADV_TVLV_HANDLER_OGM_CIFNOTFND;
 	u16 tvlv_value_start_len = tvlv_value_len;
 	struct batadv_tvlv_handler *tvlv_handler;
 	void *tvlv_value_start = tvlv_value;
 	struct batadv_tvlv_hdr *tvlv_hdr;
-	u16 tvlv_value_cont_len;
-	u8 cifnotfound = BATADV_TVLV_HANDLER_OGM_CIFNOTFND;
 	int ret = NET_RX_SUCCESS;
+	u16 tvlv_value_cont_len;
 
 	while ((tvlv_hdr = batadv_tvlv_hdr_next(&tvlv_value, &tvlv_value_len))) {
 		tvlv_value_cont_len = ntohs(tvlv_hdr->len);
@@ -600,8 +600,8 @@ void batadv_tvlv_ogm_receive(struct batadv_priv *bat_priv,
 			     struct batadv_ogm_packet *batadv_ogm_packet,
 			     struct batadv_orig_node *orig_node)
 {
-	void *tvlv_value;
 	u16 tvlv_value_len;
+	void *tvlv_value;
 
 	if (!batadv_ogm_packet)
 		return;
@@ -721,12 +721,12 @@ void batadv_tvlv_unicast_send(struct batadv_priv *bat_priv, const u8 *src,
 			      void *tvlv_value, u16 tvlv_value_len)
 {
 	struct batadv_unicast_tvlv_packet *unicast_tvlv_packet;
-	struct batadv_tvlv_hdr *tvlv_hdr;
+	ssize_t hdr_len = sizeof(*unicast_tvlv_packet);
 	struct batadv_orig_node *orig_node;
-	struct sk_buff *skb;
+	struct batadv_tvlv_hdr *tvlv_hdr;
 	unsigned char *tvlv_buff;
 	unsigned int tvlv_len;
-	ssize_t hdr_len = sizeof(*unicast_tvlv_packet);
+	struct sk_buff *skb;
 
 	orig_node = batadv_orig_hash_find(bat_priv, dst);
 	if (!orig_node)
-- 
2.47.3

