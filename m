Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C9C2CD98C5
	for <batman-adv@archiver.kernel.org>; Tue,  9 Jun 2026 15:59:02 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 0B2F0808C4
	for <batman-adv@archiver.kernel.org>; Tue, 09 Jun 2026 17:59:01 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1781020741;
 b=OV9b8mBZMBJZ6O59pppDCjKzgbDA9bHqSa8Ays4QktsdPL7vWLmCgsMb/cBisNNw0Goud
 Tkygfer4i7eLY1k+6jm5vSvIctt1MKttzN9W4y/HL6xWKE28SILj7VAgw6m0FZK6sk8RLqf
 lyBeCqF1VhqH2eEIuB1TsGMdMu9zNo0=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1781020741; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=dasNgxgK2YWWllO3dr6BdHx/ufTrKu7f8qN3MzOIh80=;
 b=CGjrPzPsBkSzTR2yrfPJk57fLyk8T3HQRMr44oBcD4tfDcf0vrsqvU2xAE+GuJABHxMD6
 wJmTaKQ6npPVRjQAzYio1thRZrwjFkzU763CAMR+TUn15Pyc9aMwg+fJaAPg4yYHyiKWux6
 vWVklS5O54Gi8ZIrqvdVleFpfQR17AA=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 34BB68116A
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 09 Jun 2026 17:57:51 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1781020676;
	b=cSDHUJ1PlU38cfPLYSu9UpdUV6cb7Gdx8FwSZPCZqrH4uvo42fd9Uu+jFMvc8QIeMymlhY
	fGbgmtAmHNg8t23a0kSzFGn+qN1ugzO37prrLN84ngf5HkMheUsSsWXI2RgFypk4+fvtZF
	lEvs62o94XoNaGBtyMQo3Y0P+YS+5gY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1781020676;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=dasNgxgK2YWWllO3dr6BdHx/ufTrKu7f8qN3MzOIh80=;
	b=QFiJOwYeXbIlHKarsfPC0ASKrLU+vWtkIZW1722vb77zZfns+eeDc3soQAd9GAVUMhJg9G
	fh+b6o0gyJYDZWWSEBNNMKzpVOUjQN7sg2F4eZVpyP//Wf5iJaBRUbauht8nz+D3docqmj
	hhwOsrgocnIbO693BLsgOrVLsmyN/gM=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=LLdf5TOd;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org
Received: by dvalin.narfation.org (Postfix) id BA4872023F;
	Tue, 09 Jun 2026 15:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1781020670;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dasNgxgK2YWWllO3dr6BdHx/ufTrKu7f8qN3MzOIh80=;
	b=LLdf5TOdX1KQHRQLdOa9X2o9FBB2FEGC4UN+4syJUR2/Gx0W0zn6QiZN8+Kh111ATQQ0Y4
	VFT6irkHSiV+GgB0ZV7j6DBDlx9cqaq1YIeuucGjrvIeB2xruJnklmsclKmb3xZHzrH0rf
	bFDE0Z40BIsCmfLW8f1hPZjplCyeGrc=
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 09 Jun 2026 17:57:41 +0200
Subject: [PATCH batadv 2/2] batman-adv: switch var declarations to reverse
 x-mas tree order
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-reverse-xmas-v1-2-e8ccef99b87b@narfation.org>
References: <20260609-reverse-xmas-v1-0-e8ccef99b87b@narfation.org>
In-Reply-To: <20260609-reverse-xmas-v1-0-e8ccef99b87b@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=109763; i=sven@narfation.org;
 h=from:subject:message-id; bh=IB96aOlCNrkUReFY9JFCJw4AEeqEDZQyPnnroa4B8H4=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFka5l93a9+oYg/Y1vXztEJR6ta+E9/4jl5//UL1vehHr
 aM3tuXqdpSyMIhxMciKKbLsuZJ/fjP7W/nP0z4ehZnDygQyhIGLUwAm8peT4X90r9Y8ZiGXZVNX
 WpnO+Kl353zvpyt3GzhjzA2b8pdy3FFhZFjVPCuqr3Cd/Qz16Z0xzzOVWvm/9ih49jsqCuw4+2l
 mKgsA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: XWPIWXTVQZYCWNZFHOGKXNAXNAZ4OUZO
X-Message-ID-Hash: XWPIWXTVQZYCWNZFHOGKXNAXNAZ4OUZO
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/XWPIWXTVQZYCWNZFHOGKXNAXNAZ4OUZO/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

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
---
 net/batman-adv/bat_algo.c              |   3 +-
 net/batman-adv/bat_iv_ogm.c            | 137 ++++++++++++------------
 net/batman-adv/bat_v.c                 |  28 ++---
 net/batman-adv/bat_v_elp.c             |  18 ++--
 net/batman-adv/bat_v_ogm.c             |  29 ++---
 net/batman-adv/bridge_loop_avoidance.c |  94 ++++++++--------
 net/batman-adv/distributed-arp-table.c |  86 +++++++--------
 net/batman-adv/fragmentation.c         |  36 ++++---
 net/batman-adv/gateway_client.c        |  28 ++---
 net/batman-adv/gateway_common.c        |   2 +-
 net/batman-adv/hard-interface.c        |  12 +--
 net/batman-adv/hash.h                  |   8 +-
 net/batman-adv/log.h                   |  16 ++-
 net/batman-adv/main.c                  |  20 ++--
 net/batman-adv/mesh-interface.c        |  40 ++++---
 net/batman-adv/multicast.c             |  36 +++----
 net/batman-adv/multicast_forw.c        |  11 +-
 net/batman-adv/netlink.c               |   8 +-
 net/batman-adv/originator.c            |  38 +++----
 net/batman-adv/routing.c               |  56 +++++-----
 net/batman-adv/send.c                  |   4 +-
 net/batman-adv/tp_meter.c              |  37 +++----
 net/batman-adv/translation-table.c     | 189 +++++++++++++++++----------------
 net/batman-adv/tvlv.c                  |  16 +--
 24 files changed, 482 insertions(+), 470 deletions(-)

diff --git a/net/batman-adv/bat_algo.c b/net/batman-adv/bat_algo.c
index 3cd5412c..54cd6eb5 100644
--- a/net/batman-adv/bat_algo.c
+++ b/net/batman-adv/bat_algo.c
@@ -121,8 +121,9 @@ static int batadv_param_set_ra(const char *val, const struct kernel_param *kp)
 {
 	struct batadv_algo_ops *bat_algo_ops;
 	char *algo_name = (char *)val;
-	size_t name_len = strlen(algo_name);
+	size_t name_len;
 
+	name_len = strlen(algo_name);
 	if (name_len > 0 && algo_name[name_len - 1] == '\n')
 		algo_name[name_len - 1] = '\0';
 
diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index fb51b356..55e9af53 100644
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
 
@@ -333,12 +333,12 @@ static void batadv_iv_ogm_send_to_if(struct batadv_forw_packet *forw_packet,
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
@@ -442,13 +442,13 @@ batadv_iv_ogm_can_aggregate(const struct batadv_ogm_packet *new_bat_ogm_packet,
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
@@ -555,10 +555,10 @@ static bool batadv_iv_ogm_aggregate_new(const unsigned char *packet_buff,
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
@@ -572,6 +572,7 @@ static bool batadv_iv_ogm_aggregate_new(const unsigned char *packet_buff,
 	if (!skb)
 		return false;
 
+	queue_left = own_packet ? NULL : &bat_priv->batman_queue_left;
 	forw_packet_aggr = batadv_forw_packet_alloc(if_incoming, if_outgoing,
 						    queue_left, bat_priv, skb);
 	if (!forw_packet_aggr) {
@@ -644,9 +645,9 @@ static bool batadv_iv_ogm_queue_add(struct batadv_priv *bat_priv,
 	struct batadv_forw_packet *forw_packet_aggr = NULL;
 	struct batadv_forw_packet *forw_packet_pos = NULL;
 	struct batadv_ogm_packet *batadv_ogm_packet;
-	bool direct_link;
 	unsigned long max_aggregation_jiffies;
 	bool aggregated_ogms;
+	bool direct_link;
 
 	batadv_ogm_packet = (struct batadv_ogm_packet *)packet_buff;
 	direct_link = !!(batadv_ogm_packet->flags & BATADV_DIRECTLINK);
@@ -762,9 +763,9 @@ batadv_iv_ogm_slide_own_bcast_window(struct batadv_hard_iface *hard_iface)
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
@@ -802,14 +803,14 @@ static void batadv_iv_ogm_schedule_buff(struct batadv_hard_iface *hard_iface)
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
@@ -998,14 +999,14 @@ batadv_iv_ogm_orig_update(struct batadv_priv *bat_priv,
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
@@ -1136,21 +1137,21 @@ static bool batadv_iv_ogm_calc_tq(struct batadv_orig_node *orig_node,
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
@@ -1283,19 +1284,19 @@ batadv_iv_ogm_update_seqnos(const struct ethhdr *ethhdr,
 			    struct batadv_hard_iface *if_outgoing)
 {
 	struct batadv_priv *bat_priv = netdev_priv(if_incoming->mesh_iface);
-	struct batadv_orig_node *orig_node;
 	struct batadv_orig_ifinfo *orig_ifinfo = NULL;
-	struct batadv_neigh_node *neigh_node;
-	struct batadv_neigh_ifinfo *neigh_ifinfo;
-	bool is_dup;
-	s32 seq_diff;
-	bool need_update = false;
-	int set_mark;
-	enum batadv_dup_status ret = BATADV_NO_DUP;
 	u32 seqno = ntohl(batadv_ogm_packet->seqno);
-	u8 *neigh_addr;
-	u8 packet_count;
+	enum batadv_dup_status ret = BATADV_NO_DUP;
+	struct batadv_neigh_ifinfo *neigh_ifinfo;
+	struct batadv_neigh_node *neigh_node;
+	struct batadv_orig_node *orig_node;
+	bool need_update = false;
 	unsigned long *bitmap;
+	u8 packet_count;
+	u8 *neigh_addr;
+	s32 seq_diff;
+	int set_mark;
+	bool is_dup;
 
 	orig_node = batadv_iv_ogm_orig_get(bat_priv, batadv_ogm_packet->orig);
 	if (!orig_node)
@@ -1412,22 +1413,22 @@ batadv_iv_ogm_process_per_outif(const struct sk_buff *skb, int ogm_offset,
 {
 	struct batadv_priv *bat_priv = netdev_priv(if_incoming->mesh_iface);
 	struct batadv_hardif_neigh_node *hardif_neigh = NULL;
-	struct batadv_neigh_node *router = NULL;
-	struct batadv_neigh_node *router_router = NULL;
-	struct batadv_orig_node *orig_neigh_node;
-	struct batadv_orig_ifinfo *orig_ifinfo;
 	struct batadv_neigh_node *orig_neigh_router = NULL;
 	struct batadv_neigh_ifinfo *router_ifinfo = NULL;
+	struct batadv_neigh_node *router_router = NULL;
+	struct batadv_orig_node *orig_neigh_node;
+	struct batadv_neigh_node *router = NULL;
+	struct batadv_orig_ifinfo *orig_ifinfo;
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
@@ -1650,16 +1651,16 @@ static void batadv_iv_ogm_process(const struct sk_buff *skb, int ogm_offset,
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
@@ -1778,8 +1779,8 @@ static void batadv_iv_ogm_process(const struct sk_buff *skb, int ogm_offset,
 
 static void batadv_iv_send_outstanding_bat_ogm_packet(struct work_struct *work)
 {
-	struct delayed_work *delayed_work;
 	struct batadv_forw_packet *forw_packet;
+	struct delayed_work *delayed_work;
 	struct batadv_priv *bat_priv;
 	bool dropped = false;
 
@@ -1819,10 +1820,10 @@ static int batadv_iv_ogm_receive(struct sk_buff *skb,
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
@@ -1912,9 +1913,9 @@ batadv_iv_ogm_orig_dump_subentry(struct sk_buff *msg, u32 portid, u32 seq,
 				 struct batadv_neigh_node *neigh_node,
 				 bool best)
 {
+	unsigned int last_seen_msecs;
 	void *hdr;
 	u8 tq_avg;
-	unsigned int last_seen_msecs;
 
 	last_seen_msecs = jiffies_to_msecs(jiffies - orig_node->last_seen);
 
@@ -1976,9 +1977,9 @@ batadv_iv_ogm_orig_dump_entry(struct sk_buff *msg, u32 portid, u32 seq,
 {
 	struct batadv_neigh_node *neigh_node_best;
 	struct batadv_neigh_node *neigh_node;
+	u8 tq_avg_best;
 	int sub = 0;
 	bool best;
-	u8 tq_avg_best;
 
 	neigh_node_best = batadv_orig_router_get(orig_node, if_outgoing);
 	if (!neigh_node_best)
@@ -2071,11 +2072,11 @@ batadv_iv_ogm_orig_dump(struct sk_buff *msg, struct netlink_callback *cb,
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
@@ -2116,9 +2117,9 @@ static bool batadv_iv_ogm_neigh_diff(struct batadv_neigh_node *neigh1,
 {
 	struct batadv_neigh_ifinfo *neigh1_ifinfo;
 	struct batadv_neigh_ifinfo *neigh2_ifinfo;
+	bool ret = true;
 	u8 tq1;
 	u8 tq2;
-	bool ret = true;
 
 	neigh1_ifinfo = batadv_neigh_ifinfo_get(neigh1, if_outgoing1);
 	neigh2_ifinfo = batadv_neigh_ifinfo_get(neigh2, if_outgoing2);
@@ -2152,8 +2153,8 @@ static int
 batadv_iv_ogm_neigh_dump_neigh(struct sk_buff *msg, u32 portid, u32 seq,
 			       struct batadv_hardif_neigh_node *hardif_neigh)
 {
-	void *hdr;
 	unsigned int last_seen_msecs;
+	void *hdr;
 
 	last_seen_msecs = jiffies_to_msecs(jiffies - hardif_neigh->last_seen);
 
@@ -2231,12 +2232,12 @@ batadv_iv_ogm_neigh_dump(struct sk_buff *msg, struct netlink_callback *cb,
 			 struct batadv_priv *bat_priv,
 			 struct batadv_hard_iface *single_hardif)
 {
-	struct batadv_hard_iface *hard_iface;
-	struct list_head *iter;
-	int i_hardif = 0;
-	int i_hardif_s = cb->args[0];
-	int idx = cb->args[1];
 	int portid = NETLINK_CB(cb->skb).portid;
+	struct batadv_hard_iface *hard_iface;
+	int i_hardif_s = cb->args[0];
+	struct list_head *iter;
+	int idx = cb->args[1];
+	int i_hardif = 0;
 
 	rcu_read_lock();
 	if (single_hardif) {
@@ -2344,15 +2345,15 @@ static void batadv_iv_init_sel_class(struct batadv_priv *bat_priv)
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
@@ -2426,11 +2427,11 @@ static bool batadv_iv_gw_is_eligible(struct batadv_priv *bat_priv,
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
@@ -2501,8 +2502,8 @@ static int batadv_iv_gw_dump_entry(struct sk_buff *msg, u32 portid,
 				   struct batadv_gw_node *gw_node)
 {
 	struct batadv_neigh_ifinfo *router_ifinfo = NULL;
-	struct batadv_neigh_node *router;
 	struct batadv_gw_node *curr_gw = NULL;
+	struct batadv_neigh_node *router;
 	int ret = 0;
 	void *hdr;
 
diff --git a/net/batman-adv/bat_v.c b/net/batman-adv/bat_v.c
index 6b84e107..c0ee4770 100644
--- a/net/batman-adv/bat_v.c
+++ b/net/batman-adv/bat_v.c
@@ -128,9 +128,9 @@ static int
 batadv_v_neigh_dump_neigh(struct sk_buff *msg, u32 portid, u32 seq,
 			  struct batadv_hardif_neigh_node *hardif_neigh)
 {
-	void *hdr;
 	unsigned int last_seen_msecs;
 	u32 throughput;
+	void *hdr;
 
 	last_seen_msecs = jiffies_to_msecs(jiffies - hardif_neigh->last_seen);
 	throughput = ewma_throughput_read(&hardif_neigh->bat_v.throughput);
@@ -211,12 +211,12 @@ batadv_v_neigh_dump(struct sk_buff *msg, struct netlink_callback *cb,
 		    struct batadv_priv *bat_priv,
 		    struct batadv_hard_iface *single_hardif)
 {
-	struct batadv_hard_iface *hard_iface;
-	struct list_head *iter;
-	int i_hardif = 0;
-	int i_hardif_s = cb->args[0];
-	int idx = cb->args[1];
 	int portid = NETLINK_CB(cb->skb).portid;
+	struct batadv_hard_iface *hard_iface;
+	int i_hardif_s = cb->args[0];
+	struct list_head *iter;
+	int idx = cb->args[1];
+	int i_hardif = 0;
 
 	rcu_read_lock();
 	if (single_hardif) {
@@ -421,11 +421,11 @@ batadv_v_orig_dump(struct sk_buff *msg, struct netlink_callback *cb,
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
@@ -477,8 +477,8 @@ static bool batadv_v_neigh_is_sob(struct batadv_neigh_node *neigh1,
 {
 	struct batadv_neigh_ifinfo *ifinfo1;
 	struct batadv_neigh_ifinfo *ifinfo2;
-	u32 threshold;
 	bool ret = false;
+	u32 threshold;
 
 	ifinfo1 = batadv_neigh_ifinfo_get(neigh1, if_outgoing1);
 	if (!ifinfo1)
@@ -560,8 +560,8 @@ static int batadv_v_gw_throughput_get(struct batadv_gw_node *gw_node, u32 *bw)
 static struct batadv_gw_node *
 batadv_v_gw_get_best_gw_node(struct batadv_priv *bat_priv)
 {
-	struct batadv_gw_node *gw_node;
 	struct batadv_gw_node *curr_gw = NULL;
+	struct batadv_gw_node *gw_node;
 	u32 max_bw = 0;
 	u32 bw;
 
@@ -602,12 +602,12 @@ static bool batadv_v_gw_is_eligible(struct batadv_priv *bat_priv,
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
 
@@ -663,8 +663,8 @@ static int batadv_v_gw_dump_entry(struct sk_buff *msg, u32 portid,
 				  struct batadv_gw_node *gw_node)
 {
 	struct batadv_neigh_ifinfo *router_ifinfo = NULL;
-	struct batadv_neigh_node *router;
 	struct batadv_gw_node *curr_gw = NULL;
+	struct batadv_neigh_node *router;
 	int ret = 0;
 	void *hdr;
 
diff --git a/net/batman-adv/bat_v_elp.c b/net/batman-adv/bat_v_elp.c
index 6edd42ff..81680675 100644
--- a/net/batman-adv/bat_v_elp.c
+++ b/net/batman-adv/bat_v_elp.c
@@ -236,12 +236,14 @@ static bool
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
@@ -296,8 +298,8 @@ static void batadv_v_elp_periodic_work(struct work_struct *work)
 	struct batadv_v_metric_queue_entry *metric_entry;
 	struct batadv_v_metric_queue_entry *metric_safe;
 	struct batadv_hardif_neigh_node *hardif_neigh;
-	struct batadv_hard_iface *hard_iface;
 	struct batadv_hard_iface_bat_v *bat_v;
+	struct batadv_hard_iface *hard_iface;
 	struct batadv_elp_packet *elp_packet;
 	struct list_head metric_queue;
 	struct batadv_priv *bat_priv;
@@ -403,9 +405,9 @@ int batadv_v_elp_iface_enable(struct batadv_hard_iface *hard_iface)
 	static const size_t tvlv_padding = sizeof(__be32);
 	struct batadv_elp_packet *elp_packet;
 	unsigned char *elp_buff;
+	int res = -ENOMEM;
 	u32 random_seqno;
 	size_t size;
-	int res = -ENOMEM;
 
 	size = ETH_HLEN + NET_IP_ALIGN + BATADV_ELP_HLEN + tvlv_padding;
 	hard_iface->bat_v.elp_skb = dev_alloc_skb(size);
@@ -508,11 +510,11 @@ static void batadv_v_elp_neigh_update(struct batadv_priv *bat_priv,
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
@@ -564,8 +566,8 @@ int batadv_v_elp_packet_recv(struct sk_buff *skb,
 	struct batadv_elp_packet *elp_packet;
 	struct batadv_hard_iface *primary_if;
 	struct ethhdr *ethhdr;
-	bool res;
 	int ret = NET_RX_DROP;
+	bool res;
 
 	res = batadv_check_management_packet(skb, if_incoming, BATADV_ELP_HLEN);
 	if (!res)
diff --git a/net/batman-adv/bat_v_ogm.c b/net/batman-adv/bat_v_ogm.c
index 1e31af26..4ec191da 100644
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
@@ -268,12 +269,12 @@ static void batadv_v_ogm_queue_on_if(struct batadv_priv *bat_priv,
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
 
@@ -619,11 +620,11 @@ static int batadv_v_ogm_metric_update(struct batadv_priv *bat_priv,
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
@@ -701,17 +702,17 @@ static bool batadv_v_ogm_route_update(struct batadv_priv *bat_priv,
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
@@ -862,16 +863,16 @@ static void batadv_v_ogm_process(const struct sk_buff *skb, int ogm_offset,
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
@@ -997,9 +998,9 @@ int batadv_v_ogm_packet_recv(struct sk_buff *skb,
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
index 7e8fdca9..fe2618b5 100644
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
@@ -342,13 +342,13 @@ batadv_bla_del_backbone_claims(struct batadv_bla_backbone_gw *backbone_gw)
 static void batadv_bla_send_claim(struct batadv_priv *bat_priv, const u8 *mac,
 				  unsigned short vid, int claimtype)
 {
-	struct sk_buff *skb;
-	struct ethhdr *ethhdr;
+	struct batadv_bla_claim_dst local_claim_dest;
 	struct batadv_hard_iface *primary_if;
 	struct net_device *mesh_iface;
-	u8 *hw_src;
-	struct batadv_bla_claim_dst local_claim_dest;
+	struct ethhdr *ethhdr;
+	struct sk_buff *skb;
 	__be32 zeroip = 0;
+	u8 *hw_src;
 
 	primary_if = batadv_primary_if_get_selected(bat_priv);
 	if (!primary_if)
@@ -599,10 +599,10 @@ static void batadv_bla_answer_request(struct batadv_priv *bat_priv,
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
@@ -698,8 +698,8 @@ static void batadv_bla_add_claim(struct batadv_priv *bat_priv,
 				 struct batadv_bla_backbone_gw *backbone_gw)
 {
 	struct batadv_bla_backbone_gw *old_backbone_gw;
-	struct batadv_bla_claim *claim;
 	struct batadv_bla_claim search_claim;
+	struct batadv_bla_claim *claim;
 	bool remove_crc = false;
 	int hash_added;
 
@@ -806,10 +806,10 @@ batadv_bla_claim_get_backbone_gw(struct batadv_bla_claim *claim)
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
@@ -1027,10 +1027,10 @@ static int batadv_check_claim_group(struct batadv_priv *bat_priv,
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
@@ -1094,18 +1094,18 @@ static bool batadv_bla_process_claim(struct batadv_priv *bat_priv,
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
@@ -1237,11 +1237,11 @@ static bool batadv_bla_process_claim(struct batadv_priv *bat_priv,
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
 
@@ -1314,8 +1314,8 @@ static void batadv_bla_purge_claims(struct batadv_priv *bat_priv,
 {
 	struct batadv_bla_backbone_gw *backbone_gw;
 	struct batadv_bla_claim *claim;
-	struct hlist_head *head;
 	struct batadv_hashtable *hash;
+	struct hlist_head *head;
 	int i;
 
 	hash = bat_priv->bla.claim_hash;
@@ -1377,8 +1377,8 @@ void batadv_bla_update_orig_address(struct batadv_priv *bat_priv,
 				    struct batadv_hard_iface *oldif)
 {
 	struct batadv_bla_backbone_gw *backbone_gw;
-	struct hlist_head *head;
 	struct batadv_hashtable *hash;
+	struct hlist_head *head;
 	__be16 group;
 	int i;
 
@@ -1471,14 +1471,14 @@ void batadv_bla_status_update(struct net_device *net_dev)
  */
 static void batadv_bla_periodic_work(struct work_struct *work)
 {
-	struct delayed_work *delayed_work;
-	struct batadv_priv *bat_priv;
-	struct batadv_priv_bla *priv_bla;
-	struct hlist_head *head;
 	struct batadv_bla_backbone_gw *backbone_gw;
-	struct batadv_hashtable *hash;
 	struct batadv_hard_iface *primary_if;
+	struct delayed_work *delayed_work;
+	struct batadv_priv_bla *priv_bla;
+	struct batadv_hashtable *hash;
+	struct batadv_priv *bat_priv;
 	bool send_loopdetect = false;
+	struct hlist_head *head;
 	int i;
 
 	delayed_work = to_delayed_work(work);
@@ -1580,11 +1580,11 @@ static struct lock_class_key batadv_backbone_hash_lock_class_key;
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
 
@@ -1663,9 +1663,9 @@ static bool batadv_bla_check_duplist(struct batadv_priv *bat_priv,
 	struct batadv_bcast_duplist_entry *entry;
 	bool ret = false;
 	int payload_len;
-	int i;
 	int curr;
 	u32 crc;
+	int i;
 
 	/* calculate the crc ... */
 	payload_len = skb->len - payload_offset;
@@ -1787,8 +1787,8 @@ bool batadv_bla_is_backbone_gw_orig(struct batadv_priv *bat_priv, u8 *orig,
 				    unsigned short vid)
 {
 	struct batadv_hashtable *hash = bat_priv->bla.backbone_hash;
-	struct hlist_head *head;
 	struct batadv_bla_backbone_gw *backbone_gw;
+	struct hlist_head *head;
 	int i;
 
 	if (!READ_ONCE(bat_priv->bridge_loop_avoidance))
@@ -1949,10 +1949,10 @@ bool batadv_bla_rx(struct batadv_priv *bat_priv, struct sk_buff *skb,
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
 
@@ -2083,11 +2083,11 @@ bool batadv_bla_rx(struct batadv_priv *bat_priv, struct sk_buff *skb,
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
 
@@ -2188,10 +2188,10 @@ batadv_bla_claim_dump_entry(struct sk_buff *msg, u32 portid,
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
@@ -2350,11 +2350,11 @@ batadv_bla_backbone_dump_entry(struct sk_buff *msg, u32 portid,
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
@@ -2509,10 +2509,10 @@ int batadv_bla_backbone_dump(struct sk_buff *msg, struct netlink_callback *cb)
 bool batadv_bla_check_claim(struct batadv_priv *bat_priv,
 			    u8 *addr, unsigned short vid)
 {
-	struct batadv_bla_backbone_gw *backbone_gw;
-	struct batadv_bla_claim search_claim;
-	struct batadv_bla_claim *claim = NULL;
 	struct batadv_hard_iface *primary_if = NULL;
+	struct batadv_bla_backbone_gw *backbone_gw;
+	struct batadv_bla_claim *claim = NULL;
+	struct batadv_bla_claim search_claim;
 	bool ret = true;
 
 	if (!READ_ONCE(bat_priv->bridge_loop_avoidance))
diff --git a/net/batman-adv/distributed-arp-table.c b/net/batman-adv/distributed-arp-table.c
index 70dd2936..967fd837 100644
--- a/net/batman-adv/distributed-arp-table.c
+++ b/net/batman-adv/distributed-arp-table.c
@@ -285,9 +285,9 @@ static __be32 batadv_arp_ip_dst(struct sk_buff *skb, int hdr_size)
  */
 static u32 batadv_hash_dat(const void *data, u32 size)
 {
-	u32 hash = 0;
 	const struct batadv_dat_entry *dat = data;
 	const unsigned char *key;
+	u32 hash = 0;
 	__be16 vid;
 	u32 i;
 
@@ -326,11 +326,11 @@ static struct batadv_dat_entry *
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
@@ -564,11 +564,11 @@ static void batadv_choose_next_candidate(struct batadv_priv *bat_priv,
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
 
@@ -632,11 +632,11 @@ static struct batadv_dat_candidate *
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
@@ -679,12 +679,12 @@ static bool batadv_dat_forward_data(struct batadv_priv *bat_priv,
 				    struct sk_buff *skb, __be32 ip,
 				    unsigned short vid, int packet_subtype)
 {
-	int i;
+	struct batadv_neigh_node *neigh_node = NULL;
+	struct batadv_dat_candidate *cand;
+	struct sk_buff *tmp_skb;
 	bool ret = false;
 	int send_status;
-	struct batadv_neigh_node *neigh_node = NULL;
-	struct sk_buff *tmp_skb;
-	struct batadv_dat_candidate *cand;
+	int i;
 
 	cand = batadv_dat_select_candidates(bat_priv, ip, vid);
 	if (!cand)
@@ -1001,9 +1001,9 @@ static u16 batadv_arp_get_type(struct batadv_priv *bat_priv,
 	struct ethhdr *ethhdr;
 	__be32 ip_src;
 	__be32 ip_dst;
+	u16 type = 0;
 	u8 *hw_src;
 	u8 *hw_dst;
-	u16 type = 0;
 
 	/* pull the ethernet header */
 	if (unlikely(!pskb_may_pull(skb, hdr_size + ETH_HLEN)))
@@ -1136,16 +1136,16 @@ batadv_dat_arp_create_reply(struct batadv_priv *bat_priv, __be32 ip_src,
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
+	int hdr_size = 0;
+	__be32 ip_dst;
+	__be32 ip_src;
+	u16 type = 0;
+	u8 *hw_src;
 
 	if (!READ_ONCE(bat_priv->distributed_arp_table))
 		goto out;
@@ -1233,14 +1233,14 @@ bool batadv_dat_snoop_outgoing_arp_request(struct batadv_priv *bat_priv,
 bool batadv_dat_snoop_incoming_arp_request(struct batadv_priv *bat_priv,
 					   struct sk_buff *skb, int hdr_size)
 {
-	u16 type;
+	struct batadv_dat_entry *dat_entry = NULL;
+	struct sk_buff *skb_new;
+	unsigned short vid;
+	bool ret = false;
 	__be32 ip_src;
 	__be32 ip_dst;
 	u8 *hw_src;
-	struct sk_buff *skb_new;
-	struct batadv_dat_entry *dat_entry = NULL;
-	bool ret = false;
-	unsigned short vid;
+	u16 type;
 	int err;
 
 	if (!READ_ONCE(bat_priv->distributed_arp_table))
@@ -1299,13 +1299,13 @@ bool batadv_dat_snoop_incoming_arp_request(struct batadv_priv *bat_priv,
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
@@ -1349,13 +1349,13 @@ bool batadv_dat_snoop_incoming_arp_reply(struct batadv_priv *bat_priv,
 					 struct sk_buff *skb, int hdr_size)
 {
 	struct batadv_dat_entry *dat_entry = NULL;
-	u16 type;
+	bool dropped = false;
+	unsigned short vid;
 	__be32 ip_src;
 	__be32 ip_dst;
 	u8 *hw_src;
 	u8 *hw_dst;
-	bool dropped = false;
-	unsigned short vid;
+	u16 type;
 
 	if (!READ_ONCE(bat_priv->distributed_arp_table))
 		goto out;
@@ -1483,8 +1483,6 @@ batadv_dat_check_dhcp_ipudp(struct sk_buff *skb, __be32 *ip_src)
 static int
 batadv_dat_check_dhcp(struct sk_buff *skb, __be16 proto, __be32 *ip_src)
 {
-	__be32 *magic;
-	__be32 _magic;
 	unsigned int offset;
 	struct {
 		__u8 op;
@@ -1492,6 +1490,8 @@ batadv_dat_check_dhcp(struct sk_buff *skb, __be16 proto, __be32 *ip_src)
 		__u8 hlen;
 		__u8 hops;
 	} *dhcp_h, _dhcp_h;
+	__be32 *magic;
+	__be32 _magic;
 
 	if (proto != htons(ETH_P_IP))
 		return -EINVAL;
@@ -1532,12 +1532,12 @@ batadv_dat_check_dhcp(struct sk_buff *skb, __be16 proto, __be32 *ip_src)
 static int batadv_dat_get_dhcp_message_type(struct sk_buff *skb)
 {
 	unsigned int offset = skb_transport_offset(skb) + sizeof(struct udphdr);
-	u8 *type;
-	u8 _type;
 	struct {
 		u8 type;
 		u8 len;
 	} *tl, _tl;
+	u8 *type;
+	u8 _type;
 
 	offset += sizeof(struct batadv_dhcp_packet);
 
@@ -1757,9 +1757,9 @@ void batadv_dat_snoop_incoming_dhcp_ack(struct batadv_priv *bat_priv,
 {
 	u8 chaddr[BATADV_DHCP_CHADDR_LEN];
 	struct ethhdr *ethhdr;
+	unsigned short vid;
 	__be32 ip_src;
 	__be32 yiaddr;
-	unsigned short vid;
 	__be16 proto;
 	u8 *hw_src;
 
@@ -1801,12 +1801,12 @@ void batadv_dat_snoop_incoming_dhcp_ack(struct batadv_priv *bat_priv,
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
index 85d02414..d06a4010 100644
--- a/net/batman-adv/fragmentation.c
+++ b/net/batman-adv/fragmentation.c
@@ -139,17 +139,17 @@ static bool batadv_frag_insert_packet(struct batadv_orig_node *orig_node,
 				      struct sk_buff *skb,
 				      struct hlist_head *chain_out)
 {
-	struct batadv_frag_table_entry *chain;
-	struct batadv_frag_list_entry *frag_entry_new = NULL;
-	struct batadv_frag_list_entry *frag_entry_curr;
 	struct batadv_frag_list_entry *frag_entry_last = NULL;
-	struct batadv_frag_packet *frag_packet;
-	u8 bucket;
-	u16 seqno;
+	struct batadv_frag_list_entry *frag_entry_new = NULL;
 	u16 hdr_size = sizeof(struct batadv_frag_packet);
+	struct batadv_frag_list_entry *frag_entry_curr;
+	struct batadv_frag_packet *frag_packet;
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
-	struct batadv_frag_list_entry *entry;
-	struct sk_buff *skb_out;
-	int size;
 	int hdr_size = sizeof(struct batadv_frag_packet);
+	struct batadv_frag_list_entry *entry;
+	struct batadv_frag_packet *packet;
+	struct sk_buff *skb_out;
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
@@ -403,8 +403,8 @@ bool batadv_frag_skb_fwd(struct sk_buff *skb,
 	struct batadv_priv *bat_priv = netdev_priv(recv_if->mesh_iface);
 	struct batadv_neigh_node *neigh_node = NULL;
 	struct batadv_frag_packet *packet;
-	u16 total_size;
 	bool ret = false;
+	u16 total_size;
 
 	packet = (struct batadv_frag_packet *)skb->data;
 
@@ -451,10 +451,11 @@ static struct sk_buff *batadv_frag_create(struct net_device *net_dev,
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
@@ -486,19 +487,20 @@ int batadv_frag_send_packet(struct sk_buff *skb,
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
index 0e4773c1..7c67d0f6 100644
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
@@ -197,10 +197,10 @@ void batadv_gw_check_client_stop(struct batadv_priv *bat_priv)
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
@@ -370,8 +370,8 @@ static void batadv_gw_node_add(struct batadv_priv *bat_priv,
 struct batadv_gw_node *batadv_gw_node_get(struct batadv_priv *bat_priv,
 					  struct batadv_orig_node *orig_node)
 {
-	struct batadv_gw_node *gw_node_tmp;
 	struct batadv_gw_node *gw_node = NULL;
+	struct batadv_gw_node *gw_node_tmp;
 
 	rcu_read_lock();
 	hlist_for_each_entry_rcu(gw_node_tmp, &bat_priv->gw.gateway_list,
@@ -401,8 +401,8 @@ void batadv_gw_node_update(struct batadv_priv *bat_priv,
 			   struct batadv_orig_node *orig_node,
 			   struct batadv_tvlv_gateway_data *gateway)
 {
-	struct batadv_gw_node *gw_node;
 	struct batadv_gw_node *curr_gw = NULL;
+	struct batadv_gw_node *gw_node;
 
 	spin_lock_bh(&bat_priv->gw.list_lock);
 	gw_node = batadv_gw_node_get(bat_priv, orig_node);
@@ -560,11 +560,11 @@ batadv_gw_dhcp_recipient_get(struct sk_buff *skb, unsigned int *header_len,
 			     u8 *chaddr)
 {
 	enum batadv_dhcp_recipient ret = BATADV_DHCP_NO;
-	struct ethhdr *ethhdr;
-	struct iphdr *iphdr;
-	struct ipv6hdr *ipv6hdr;
-	struct udphdr *udphdr;
 	struct vlan_ethhdr *vhdr;
+	struct ipv6hdr *ipv6hdr;
+	struct ethhdr *ethhdr;
+	struct udphdr *udphdr;
+	struct iphdr *iphdr;
 	int chaddr_offset;
 	__be16 proto;
 	u8 *p;
@@ -680,17 +680,17 @@ batadv_gw_dhcp_recipient_get(struct sk_buff *skb, unsigned int *header_len,
 bool batadv_gw_out_of_range(struct batadv_priv *bat_priv,
 			    struct sk_buff *skb)
 {
+	struct ethhdr *ethhdr = (struct ethhdr *)skb->data;
+	struct batadv_orig_node *orig_dst_node = NULL;
 	struct batadv_neigh_node *neigh_curr = NULL;
 	struct batadv_neigh_node *neigh_old = NULL;
-	struct batadv_orig_node *orig_dst_node = NULL;
-	struct batadv_gw_node *gw_node = NULL;
-	struct batadv_gw_node *curr_gw = NULL;
 	struct batadv_neigh_ifinfo *curr_ifinfo;
 	struct batadv_neigh_ifinfo *old_ifinfo;
-	struct ethhdr *ethhdr = (struct ethhdr *)skb->data;
+	struct batadv_gw_node *gw_node = NULL;
+	struct batadv_gw_node *curr_gw = NULL;
 	bool out_of_range = false;
-	u8 curr_tq_avg;
 	unsigned short vid;
+	u8 curr_tq_avg;
 
 	vid = batadv_get_vid(skb, 0);
 
diff --git a/net/batman-adv/gateway_common.c b/net/batman-adv/gateway_common.c
index b5ebe837..65d33920 100644
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
index 60cee2c2..ca54a3ad 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -338,8 +338,8 @@ static bool batadv_is_cfg80211_netdev(struct net_device *net_device)
  */
 static u32 batadv_wifi_flags_evaluate(struct net_device *net_device)
 {
-	u32 wifi_flags = 0;
 	struct net_device *real_netdev;
+	u32 wifi_flags = 0;
 
 	if (batadv_is_wext_netdev(net_device))
 		wifi_flags |= BATADV_HARDIF_WIFI_WEXT_DIRECT;
@@ -433,8 +433,8 @@ int batadv_hardif_no_broadcast(struct batadv_hard_iface *if_outgoing,
 			       u8 *orig_addr, u8 *orig_neigh)
 {
 	struct batadv_hardif_neigh_node *hardif_neigh;
-	struct hlist_node *first;
 	int ret = BATADV_HARDIF_BCAST_OK;
+	struct hlist_node *first;
 
 	rcu_read_lock();
 
@@ -677,8 +677,8 @@ void batadv_update_min_mtu(struct net_device *mesh_iface)
 static void
 batadv_hardif_activate_interface(struct batadv_hard_iface *hard_iface)
 {
-	struct batadv_priv *bat_priv;
 	struct batadv_hard_iface *primary_if = NULL;
+	struct batadv_priv *bat_priv;
 
 	if (hard_iface->if_status != BATADV_IF_INACTIVE)
 		goto out;
@@ -732,9 +732,9 @@ batadv_hardif_deactivate_interface(struct batadv_hard_iface *hard_iface)
 int batadv_hardif_enable_interface(struct batadv_hard_iface *hard_iface,
 				   struct net_device *mesh_iface)
 {
-	struct batadv_priv *bat_priv;
-	__be16 ethertype = htons(ETH_P_BATMAN);
 	int max_header_len = batadv_max_header_len();
+	__be16 ethertype = htons(ETH_P_BATMAN);
+	struct batadv_priv *bat_priv;
 	unsigned int required_mtu;
 	unsigned int hardif_mtu;
 	bool fragmentation;
@@ -1096,8 +1096,8 @@ static int batadv_hard_if_event(struct notifier_block *this,
 				unsigned long event, void *ptr)
 {
 	struct net_device *net_dev = netdev_notifier_info_to_dev(ptr);
-	struct batadv_hard_iface *hard_iface;
 	struct batadv_hard_iface *primary_if = NULL;
+	struct batadv_hard_iface *hard_iface;
 	struct batadv_priv *bat_priv;
 
 	if (batadv_meshif_is_valid(net_dev))
diff --git a/net/batman-adv/hash.h b/net/batman-adv/hash.h
index 86a2c200..0dd34976 100644
--- a/net/batman-adv/hash.h
+++ b/net/batman-adv/hash.h
@@ -78,11 +78,11 @@ static inline int batadv_hash_add(struct batadv_hashtable *hash,
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
@@ -131,10 +131,10 @@ static inline void *batadv_hash_remove(struct batadv_hashtable *hash,
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
index a0d2b0d6..9f3aed82 100644
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
index ec36954d..75487c19 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -352,14 +352,14 @@ int batadv_max_header_len(void)
  */
 void batadv_skb_set_priority(struct sk_buff *skb, int offset)
 {
-	struct iphdr ip_hdr_tmp;
-	struct iphdr *ip_hdr;
-	struct ipv6hdr ip6_hdr_tmp;
-	struct ipv6hdr *ip6_hdr;
-	struct ethhdr ethhdr_tmp;
-	struct ethhdr *ethhdr;
-	struct vlan_ethhdr *vhdr;
 	struct vlan_ethhdr vhdr_tmp;
+	struct ipv6hdr ip6_hdr_tmp;
+	struct ethhdr ethhdr_tmp;
+	struct vlan_ethhdr *vhdr;
+	struct iphdr ip_hdr_tmp;
+	struct ipv6hdr *ip6_hdr;
+	struct ethhdr *ethhdr;
+	struct iphdr *ip_hdr;
 	u32 prio;
 
 	/* already set, do nothing */
@@ -425,9 +425,9 @@ int batadv_batman_skb_recv(struct sk_buff *skb, struct net_device *dev,
 			   struct packet_type *ptype,
 			   struct net_device *orig_dev)
 {
-	struct batadv_priv *bat_priv;
 	struct batadv_ogm_packet *batadv_ogm_packet;
 	struct batadv_hard_iface *hard_iface;
+	struct batadv_priv *bat_priv;
 	u8 idx;
 
 	hard_iface = container_of(ptype, struct batadv_hard_iface,
@@ -652,9 +652,9 @@ bool batadv_vlan_ap_isola_get(struct batadv_priv *bat_priv, unsigned short vid)
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
index ac77abc1..94e433d2 100644
--- a/net/batman-adv/mesh-interface.c
+++ b/net/batman-adv/mesh-interface.c
@@ -170,31 +170,29 @@ static void batadv_interface_set_rx_mode(struct net_device *dev)
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
+	int network_offset = ETH_HLEN;
+	unsigned int header_len = 0;
+	unsigned long brd_delay = 0;
+	int mcast_is_routable = 0;
+	struct vlan_ethhdr *vhdr;
+	int data_len = skb->len;
+	struct ethhdr *ethhdr;
+	bool do_bcast = false;
 	u8 *dst_hint = NULL;
 	u8 chaddr[ETH_ALEN];
-	struct vlan_ethhdr *vhdr;
-	unsigned int header_len = 0;
-	int data_len = skb->len;
-	int ret;
-	unsigned long brd_delay = 0;
-	bool do_bcast = false;
-	bool client_added;
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
@@ -409,8 +407,8 @@ void batadv_interface_rx(struct net_device *mesh_iface,
 			 struct sk_buff *skb, int hdr_size,
 			 struct batadv_orig_node *orig_node)
 {
-	struct batadv_bcast_packet *batadv_bcast_packet;
 	struct batadv_priv *bat_priv = netdev_priv(mesh_iface);
+	struct batadv_bcast_packet *batadv_bcast_packet;
 	struct vlan_ethhdr *vhdr;
 	struct ethhdr *ethhdr;
 	unsigned short vid;
@@ -523,8 +521,8 @@ void batadv_meshif_vlan_release(struct kref *ref)
 struct batadv_meshif_vlan *batadv_meshif_vlan_get(struct batadv_priv *bat_priv,
 						  unsigned short vid)
 {
-	struct batadv_meshif_vlan *vlan_tmp;
 	struct batadv_meshif_vlan *vlan = NULL;
+	struct batadv_meshif_vlan *vlan_tmp;
 
 	rcu_read_lock();
 	hlist_for_each_entry_rcu(vlan_tmp, &bat_priv->meshif_vlan_list, list) {
@@ -742,10 +740,10 @@ static void batadv_set_lockdep_class(struct net_device *dev)
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
index b8fd4162..c31ea6fa 100644
--- a/net/batman-adv/multicast.c
+++ b/net/batman-adv/multicast.c
@@ -281,9 +281,9 @@ static struct batadv_mcast_mla_flags
 batadv_mcast_mla_flags_get(struct batadv_priv *bat_priv)
 {
 	struct net_device *dev = bat_priv->mesh_iface;
+	struct batadv_mcast_mla_flags mla_flags;
 	struct batadv_mcast_querier_state *qr4;
 	struct batadv_mcast_querier_state *qr6;
-	struct batadv_mcast_mla_flags mla_flags;
 	struct net_device *bridge;
 
 	bridge = batadv_mcast_get_bridge(dev);
@@ -529,8 +529,8 @@ batadv_mcast_mla_meshif_get(struct net_device *dev,
 			    struct batadv_mcast_mla_flags *flags)
 {
 	struct net_device *bridge = batadv_mcast_get_bridge(dev);
-	int ret4;
 	int ret6 = 0;
+	int ret4;
 
 	if (bridge)
 		dev = bridge;
@@ -594,11 +594,11 @@ static int batadv_mcast_mla_bridge_get(struct net_device *dev,
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
@@ -945,8 +945,8 @@ static void __batadv_mcast_mla_update(struct batadv_priv *bat_priv)
  */
 static void batadv_mcast_mla_update(struct work_struct *work)
 {
-	struct delayed_work *delayed_work;
 	struct batadv_priv_mcast *priv_mcast;
+	struct delayed_work *delayed_work;
 	struct batadv_priv *bat_priv;
 
 	delayed_work = to_delayed_work(work);
@@ -1233,14 +1233,14 @@ enum batadv_forw_mode
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
@@ -1315,13 +1315,11 @@ static int
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
@@ -1616,8 +1614,8 @@ static void batadv_mcast_want_unsnoop_update(struct batadv_priv *bat_priv,
 					     struct batadv_orig_node *orig,
 					     u8 mcast_flags)
 {
-	struct hlist_node *node = &orig->mcast_want_all_unsnoopables_node;
 	struct hlist_head *head = &bat_priv->mcast.want_all_unsnoopables_list;
+	struct hlist_node *node = &orig->mcast_want_all_unsnoopables_node;
 
 	lockdep_assert_held(&orig->mcast_handler_lock);
 
@@ -1661,8 +1659,8 @@ static void batadv_mcast_want_ipv4_update(struct batadv_priv *bat_priv,
 					  struct batadv_orig_node *orig,
 					  u8 mcast_flags)
 {
-	struct hlist_node *node = &orig->mcast_want_all_ipv4_node;
 	struct hlist_head *head = &bat_priv->mcast.want_all_ipv4_list;
+	struct hlist_node *node = &orig->mcast_want_all_ipv4_node;
 
 	lockdep_assert_held(&orig->mcast_handler_lock);
 
@@ -1706,8 +1704,8 @@ static void batadv_mcast_want_ipv6_update(struct batadv_priv *bat_priv,
 					  struct batadv_orig_node *orig,
 					  u8 mcast_flags)
 {
-	struct hlist_node *node = &orig->mcast_want_all_ipv6_node;
 	struct hlist_head *head = &bat_priv->mcast.want_all_ipv6_list;
+	struct hlist_node *node = &orig->mcast_want_all_ipv6_node;
 
 	lockdep_assert_held(&orig->mcast_handler_lock);
 
@@ -1751,8 +1749,8 @@ static void batadv_mcast_want_rtr4_update(struct batadv_priv *bat_priv,
 					  struct batadv_orig_node *orig,
 					  u8 mcast_flags)
 {
-	struct hlist_node *node = &orig->mcast_want_all_rtr4_node;
 	struct hlist_head *head = &bat_priv->mcast.want_all_rtr4_list;
+	struct hlist_node *node = &orig->mcast_want_all_rtr4_node;
 
 	lockdep_assert_held(&orig->mcast_handler_lock);
 
@@ -1796,8 +1794,8 @@ static void batadv_mcast_want_rtr6_update(struct batadv_priv *bat_priv,
 					  struct batadv_orig_node *orig,
 					  u8 mcast_flags)
 {
-	struct hlist_node *node = &orig->mcast_want_all_rtr6_node;
 	struct hlist_head *head = &bat_priv->mcast.want_all_rtr6_list;
+	struct hlist_node *node = &orig->mcast_want_all_rtr6_node;
 
 	lockdep_assert_held(&orig->mcast_handler_lock);
 
diff --git a/net/batman-adv/multicast_forw.c b/net/batman-adv/multicast_forw.c
index fa6258b5..663c8bf3 100644
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
@@ -232,7 +232,6 @@ batadv_mcast_forw_push_tt(struct batadv_priv *bat_priv, struct sk_buff *skb,
 			  unsigned short *tvlv_len)
 {
 	struct batadv_tt_orig_list_entry *orig_entry;
-
 	struct batadv_tt_global_entry *tt_global;
 	const u8 *addr = eth_hdr(skb)->h_dest;
 
@@ -368,8 +367,8 @@ static void batadv_mcast_forw_scrape(struct sk_buff *skb,
 				     unsigned short offset,
 				     unsigned short len)
 {
-	char *to;
 	char *from;
+	char *to;
 
 	SKB_LINEAR_ASSERT(skb);
 
@@ -412,8 +411,8 @@ static bool batadv_mcast_forw_push_insert_padding(struct sk_buff *skb,
 						  unsigned short *tvlv_len)
 {
 	unsigned short offset =	*tvlv_len;
-	char *to;
 	char *from = skb->data;
+	char *to;
 
 	to = batadv_mcast_forw_push_padding(skb, tvlv_len);
 	if (!to)
@@ -929,16 +928,16 @@ static int batadv_mcast_forw_packet(struct batadv_priv *bat_priv,
 {
 	struct batadv_tvlv_mcast_tracker *mcast_tracker;
 	struct batadv_neigh_node *neigh_node;
-	unsigned long offset;
 	unsigned long num_dests_off;
 	struct sk_buff *nexthop_skb;
 	unsigned char *skb_net_hdr;
 	bool local_recv = false;
 	unsigned int tvlv_len;
+	unsigned long offset;
 	bool xmitted = false;
-	u8 *dest;
 	u8 *next_dest;
 	u16 num_dests;
+	u8 *dest;
 	int ret;
 
 	/* (at least) TVLV part needs to be linearized */
diff --git a/net/batman-adv/netlink.c b/net/batman-adv/netlink.c
index e3d47f3e..5b1a0d99 100644
--- a/net/batman-adv/netlink.c
+++ b/net/batman-adv/netlink.c
@@ -746,8 +746,8 @@ static int
 batadv_netlink_tp_meter_cancel(struct sk_buff *skb, struct genl_info *info)
 {
 	struct batadv_priv *bat_priv = info->user_ptr[0];
-	u8 *dst;
 	int ret = 0;
+	u8 *dst;
 
 	if (!info->attrs[BATADV_ATTR_ORIG_ADDRESS])
 		return -EINVAL;
@@ -953,10 +953,10 @@ static int batadv_netlink_set_hardif(struct sk_buff *skb,
 static int
 batadv_netlink_dump_hardif(struct sk_buff *msg, struct netlink_callback *cb)
 {
-	struct net_device *mesh_iface;
-	struct batadv_hard_iface *hard_iface;
-	struct batadv_priv *bat_priv;
 	int portid = NETLINK_CB(cb->skb).portid;
+	struct batadv_hard_iface *hard_iface;
+	struct net_device *mesh_iface;
+	struct batadv_priv *bat_priv;
 	int skip = cb->args[0];
 	struct list_head *iter;
 	int i = 0;
diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
index 90694e2e..b812fe22 100644
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
@@ -1117,11 +1117,11 @@ static bool
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
 
@@ -1177,9 +1177,9 @@ batadv_find_best_neighbor(struct batadv_priv *bat_priv,
 			  struct batadv_orig_node *orig_node,
 			  struct batadv_hard_iface *if_outgoing)
 {
+	struct batadv_algo_ops *bao = bat_priv->algo_ops;
 	struct batadv_neigh_node *best = NULL;
 	struct batadv_neigh_node *neigh;
-	struct batadv_algo_ops *bao = bat_priv->algo_ops;
 
 	rcu_read_lock();
 	hlist_for_each_entry_rcu(neigh, &orig_node->neigh_list, list) {
@@ -1214,9 +1214,9 @@ static bool batadv_purge_orig_node(struct batadv_priv *bat_priv,
 {
 	struct batadv_neigh_node *best_neigh_node;
 	struct batadv_hard_iface *hard_iface;
+	struct list_head *iter;
 	bool changed_ifinfo;
 	bool changed_neigh;
-	struct list_head *iter;
 
 	if (batadv_has_timed_out(orig_node->last_seen,
 				 2 * BATADV_PURGE_TIMEOUT)) {
@@ -1268,11 +1268,11 @@ static bool batadv_purge_orig_node(struct batadv_priv *bat_priv,
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
index 7bbcffb5..344f233d 100644
--- a/net/batman-adv/routing.c
+++ b/net/batman-adv/routing.c
@@ -218,8 +218,8 @@ static int batadv_recv_my_icmp_packet(struct batadv_priv *bat_priv,
 	struct batadv_hard_iface *primary_if = NULL;
 	struct batadv_orig_node *orig_node = NULL;
 	struct batadv_icmp_header *icmph;
-	int res;
 	int ret = NET_RX_DROP;
+	int res;
 
 	icmph = (struct batadv_icmp_header *)skb->data;
 
@@ -281,8 +281,8 @@ static int batadv_recv_icmp_ttl_exceeded(struct batadv_priv *bat_priv,
 	struct batadv_hard_iface *primary_if = NULL;
 	struct batadv_orig_node *orig_node = NULL;
 	struct batadv_icmp_packet *icmp_packet;
-	int res;
 	int ret = NET_RX_DROP;
+	int res;
 
 	icmp_packet = (struct batadv_icmp_packet *)skb->data;
 
@@ -340,13 +340,13 @@ int batadv_recv_icmp_packet(struct sk_buff *skb,
 			    struct batadv_hard_iface *recv_if)
 {
 	struct batadv_priv *bat_priv = netdev_priv(recv_if->mesh_iface);
-	struct batadv_icmp_header *icmph;
-	struct batadv_icmp_packet_rr *icmp_packet_rr;
-	struct ethhdr *ethhdr;
-	struct batadv_orig_node *orig_node = NULL;
 	int hdr_size = sizeof(struct batadv_icmp_header);
-	int res;
+	struct batadv_icmp_packet_rr *icmp_packet_rr;
+	struct batadv_orig_node *orig_node = NULL;
+	struct batadv_icmp_header *icmph;
+	struct ethhdr *ethhdr;
 	int ret = NET_RX_DROP;
+	int res;
 
 	/* drop packet if it has not necessary minimum size */
 	if (unlikely(!pskb_may_pull(skb, hdr_size)))
@@ -525,17 +525,17 @@ batadv_find_router(struct batadv_priv *bat_priv,
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
@@ -661,13 +661,13 @@ static int batadv_route_unicast_packet(struct sk_buff *skb,
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
 
@@ -750,10 +750,10 @@ batadv_reroute_unicast_packet(struct batadv_priv *bat_priv, struct sk_buff *skb,
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
@@ -795,11 +795,11 @@ static bool batadv_check_unicast_ttvn(struct batadv_priv *bat_priv,
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
@@ -915,10 +915,10 @@ static bool batadv_check_unicast_ttvn(struct batadv_priv *bat_priv,
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
@@ -947,18 +947,18 @@ int batadv_recv_unicast_packet(struct sk_buff *skb,
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
@@ -1055,10 +1055,10 @@ int batadv_recv_unicast_tvlv(struct sk_buff *skb,
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
@@ -1174,8 +1174,8 @@ int batadv_recv_bcast_packet(struct sk_buff *skb,
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
index 29f2cbc6..2122560c 100644
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
index d479ba87..aac91ab9 100644
--- a/net/batman-adv/tp_meter.c
+++ b/net/batman-adv/tp_meter.c
@@ -216,9 +216,9 @@ static void batadv_tp_batctl_notify(enum batadv_tp_meter_reason reason,
 				    unsigned long start_time, u64 total_sent,
 				    u32 cookie)
 {
+	u32 total_bytes;
 	u32 test_time;
 	u8 result;
-	u32 total_bytes;
 
 	if (!batadv_tp_is_error(reason)) {
 		result = BATADV_TP_REASON_COMPLETE;
@@ -262,8 +262,8 @@ static void batadv_tp_batctl_error_notify(enum batadv_tp_meter_reason reason,
 static struct batadv_tp_sender *
 batadv_tp_list_find_sender(struct batadv_priv *bat_priv, const u8 *dst)
 {
-	struct batadv_tp_sender *pos;
 	struct batadv_tp_sender *tp_vars = NULL;
+	struct batadv_tp_sender *pos;
 
 	rcu_read_lock();
 	hlist_for_each_entry_rcu(pos, &bat_priv->tp_sender_list, common.list) {
@@ -328,8 +328,8 @@ static struct batadv_tp_sender *
 batadv_tp_list_find_sender_session(struct batadv_priv *bat_priv, const u8 *dst,
 				   const u8 *session)
 {
-	struct batadv_tp_sender *pos;
 	struct batadv_tp_sender *tp_vars = NULL;
+	struct batadv_tp_sender *pos;
 
 	rcu_read_lock();
 	hlist_for_each_entry_rcu(pos, &bat_priv->tp_sender_list, common.list) {
@@ -362,8 +362,8 @@ batadv_tp_list_find_sender_session(struct batadv_priv *bat_priv, const u8 *dst,
 static void batadv_tp_vars_common_release(struct kref *ref)
 {
 	struct batadv_tp_vars_common *tp_vars;
-	struct batadv_tp_unacked *un;
 	struct batadv_tp_unacked *safe;
+	struct batadv_tp_unacked *un;
 
 	tp_vars = container_of(ref, struct batadv_tp_vars_common, refcount);
 
@@ -588,8 +588,8 @@ static void batadv_tp_sender_timeout(struct timer_list *t)
 static void batadv_tp_fill_prerandom(struct batadv_tp_sender *tp_vars,
 				     u8 *buf, size_t nbytes)
 {
-	u32 local_offset;
 	size_t bytes_inbuf;
+	u32 local_offset;
 	size_t to_copy;
 	size_t pos = 0;
 
@@ -635,9 +635,9 @@ static int batadv_tp_send_msg(struct batadv_tp_sender *tp_vars, const u8 *src,
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
@@ -874,8 +874,8 @@ static void batadv_tp_recv_ack(struct batadv_priv *bat_priv,
 static bool batadv_tp_avail(struct batadv_tp_sender *tp_vars,
 			    size_t payload_len)
 {
-	u32 win_left;
 	u32 win_limit;
+	u32 win_left;
 
 	spin_lock_bh(&tp_vars->cc_lock);
 
@@ -921,15 +921,16 @@ static int batadv_tp_wait_available(struct batadv_tp_sender *tp_vars, size_t ple
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
@@ -1017,8 +1018,8 @@ static int batadv_tp_send(void *arg)
  */
 static void batadv_tp_start_kthread(struct batadv_tp_sender *tp_vars)
 {
-	struct task_struct *kthread;
 	struct batadv_priv *bat_priv = tp_vars->common.bat_priv;
+	struct task_struct *kthread;
 	u32 session_cookie;
 
 	kref_get(&tp_vars->common.refcount);
@@ -1054,9 +1055,9 @@ void batadv_tp_start(struct batadv_priv *bat_priv, const u8 *dst,
 		     u32 test_length, u32 *cookie)
 {
 	struct batadv_tp_sender *tp_vars;
+	u32 session_cookie;
 	u8 session_id[2];
 	u8 icmp_uid;
-	u32 session_cookie;
 
 	get_random_bytes(session_id, sizeof(session_id));
 	get_random_bytes(&icmp_uid, 1);
@@ -1226,8 +1227,8 @@ static struct batadv_tp_receiver *
 batadv_tp_list_find_receiver_session(struct batadv_priv *bat_priv, const u8 *dst,
 				     const u8 *session)
 {
-	struct batadv_tp_receiver *pos;
 	struct batadv_tp_receiver *tp_vars = NULL;
+	struct batadv_tp_receiver *pos;
 
 	rcu_read_lock();
 	hlist_for_each_entry_rcu(pos, &bat_priv->tp_receiver_list, common.list) {
@@ -1285,8 +1286,8 @@ static void batadv_tp_reset_receiver_timer(struct batadv_tp_receiver *tp_vars)
 static void batadv_tp_receiver_shutdown(struct timer_list *t)
 {
 	struct batadv_tp_receiver *tp_vars = timer_container_of(tp_vars, t, common.timer);
-	struct batadv_tp_unacked *un;
 	struct batadv_tp_unacked *safe;
+	struct batadv_tp_unacked *un;
 	struct batadv_priv *bat_priv;
 
 	bat_priv = tp_vars->common.bat_priv;
@@ -1340,8 +1341,8 @@ static int batadv_tp_send_ack(struct batadv_priv *bat_priv, const u8 *dst,
 	struct batadv_orig_node *orig_node;
 	struct batadv_icmp_tp_packet *icmp;
 	struct sk_buff *skb;
-	int r;
 	int ret;
+	int r;
 
 	orig_node = batadv_orig_hash_find(bat_priv, dst);
 	if (unlikely(!orig_node)) {
@@ -1406,10 +1407,10 @@ static bool batadv_tp_handle_out_of_order(struct batadv_tp_receiver *tp_vars,
 					  const struct sk_buff *skb)
 {
 	const struct batadv_icmp_tp_packet *icmp;
-	struct batadv_tp_unacked *un;
 	struct batadv_tp_unacked *new;
-	u32 payload_len;
+	struct batadv_tp_unacked *un;
 	bool added = false;
+	u32 payload_len;
 
 	new = kmalloc_obj(*new, GFP_ATOMIC);
 	if (unlikely(!new))
@@ -1475,8 +1476,8 @@ static bool batadv_tp_handle_out_of_order(struct batadv_tp_receiver *tp_vars,
  */
 static void batadv_tp_ack_unordered(struct batadv_tp_receiver *tp_vars)
 {
-	struct batadv_tp_unacked *un;
 	struct batadv_tp_unacked *safe;
+	struct batadv_tp_unacked *un;
 	u32 to_ack;
 
 	/* go through the unacked packet list and possibly ACK them as
diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index ac73b636..c4cbffc7 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -156,10 +156,10 @@ static struct batadv_tt_common_entry *
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
@@ -203,8 +203,8 @@ static struct batadv_tt_local_entry *
 batadv_tt_local_hash_find(struct batadv_priv *bat_priv, const u8 *addr,
 			  unsigned short vid)
 {
-	struct batadv_tt_common_entry *tt_common_entry;
 	struct batadv_tt_local_entry *tt_local_entry = NULL;
+	struct batadv_tt_common_entry *tt_common_entry;
 
 	tt_common_entry = batadv_tt_hash_find(bat_priv->tt.local_hash, addr,
 					      vid);
@@ -228,8 +228,8 @@ struct batadv_tt_global_entry *
 batadv_tt_global_hash_find(struct batadv_priv *bat_priv, const u8 *addr,
 			   unsigned short vid)
 {
-	struct batadv_tt_common_entry *tt_common_entry;
 	struct batadv_tt_global_entry *tt_global_entry = NULL;
+	struct batadv_tt_common_entry *tt_common_entry;
 
 	tt_common_entry = batadv_tt_hash_find(bat_priv->tt.global_hash, addr,
 					      vid);
@@ -463,11 +463,11 @@ static void batadv_tt_local_event(struct batadv_priv *bat_priv,
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
@@ -556,9 +556,9 @@ static u16 batadv_tt_entries(u16 tt_len)
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
@@ -636,20 +636,20 @@ bool batadv_tt_local_add(struct net_device *mesh_iface, const u8 *addr,
 			 unsigned short vid, int ifindex, u32 mark)
 {
 	struct batadv_priv *bat_priv = netdev_priv(mesh_iface);
-	struct batadv_tt_local_entry *tt_local;
 	struct batadv_tt_global_entry *tt_global = NULL;
-	struct net *net = dev_net(mesh_iface);
-	struct batadv_meshif_vlan *vlan;
-	struct net_device *in_dev = NULL;
-	struct hlist_head *head;
 	struct batadv_tt_orig_list_entry *orig_entry;
-	int hash_added;
-	int table_size;
-	int packet_size_max;
-	bool ret = false;
+	struct batadv_tt_local_entry *tt_local;
+	struct net *net = dev_net(mesh_iface);
+	struct net_device *in_dev = NULL;
+	struct batadv_meshif_vlan *vlan;
 	bool roamed_back = false;
 	bool iif_is_wifi = false;
+	struct hlist_head *head;
+	int packet_size_max;
+	bool ret = false;
 	u8 remote_flags;
+	int hash_added;
+	int table_size;
 	u32 match_mark;
 
 	if (ifindex != BATADV_NULL_IFINDEX)
@@ -1031,16 +1031,16 @@ batadv_tt_prepare_tvlv_local_data(struct batadv_priv *bat_priv,
  */
 static void batadv_tt_tvlv_container_update(struct batadv_priv *bat_priv)
 {
-	struct batadv_tt_change_node *entry;
-	struct batadv_tt_change_node *safe;
-	struct batadv_tvlv_tt_data *tt_data;
 	struct batadv_tvlv_tt_change *tt_change;
-	int tt_diff_len;
-	int tt_change_len = 0;
-	int tt_diff_entries_num = 0;
+	struct batadv_tt_change_node *entry;
+	struct batadv_tvlv_tt_data *tt_data;
+	struct batadv_tt_change_node *safe;
 	int tt_diff_entries_count = 0;
+	int tt_diff_entries_num = 0;
 	bool drop_changes = false;
 	size_t tt_extra_len = 0;
+	int tt_change_len = 0;
+	int tt_diff_len;
 	u16 tvlv_len;
 
 	tt_diff_entries_num = READ_ONCE(bat_priv->tt.local_changes);
@@ -1133,10 +1133,10 @@ batadv_tt_local_dump_entry(struct sk_buff *msg, u32 portid,
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
@@ -1227,14 +1227,14 @@ batadv_tt_local_dump_bucket(struct sk_buff *msg, u32 portid,
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
@@ -1305,9 +1305,9 @@ u16 batadv_tt_local_remove(struct batadv_priv *bat_priv, const u8 *addr,
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
@@ -1366,8 +1366,8 @@ static void batadv_tt_local_purge_list(struct batadv_priv *bat_priv,
 				       struct hlist_head *head,
 				       int timeout)
 {
-	struct batadv_tt_local_entry *tt_local_entry;
 	struct batadv_tt_common_entry *tt_common_entry;
+	struct batadv_tt_local_entry *tt_local_entry;
 	struct hlist_node *node_tmp;
 
 	hlist_for_each_entry_safe(tt_common_entry, node_tmp, head,
@@ -1399,9 +1399,9 @@ static void batadv_tt_local_purge_list(struct batadv_priv *bat_priv,
 static void batadv_tt_local_purge(struct batadv_priv *bat_priv,
 				  int timeout)
 {
+	spinlock_t *list_lock; /* protects write access to the hash lists */
 	struct batadv_hashtable *hash = bat_priv->tt.local_hash;
 	struct hlist_head *head;
-	spinlock_t *list_lock; /* protects write access to the hash lists */
 	u32 i;
 
 	for (i = 0; i < hash->size; i++) {
@@ -1416,10 +1416,10 @@ static void batadv_tt_local_purge(struct batadv_priv *bat_priv,
 
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
@@ -1499,8 +1499,8 @@ static struct batadv_tt_orig_list_entry *
 batadv_tt_global_orig_entry_find(const struct batadv_tt_global_entry *entry,
 				 const struct batadv_orig_node *orig_node)
 {
-	struct batadv_tt_orig_list_entry *tmp_orig_entry;
 	struct batadv_tt_orig_list_entry *orig_entry = NULL;
+	struct batadv_tt_orig_list_entry *tmp_orig_entry;
 	const struct hlist_head *head;
 
 	rcu_read_lock();
@@ -1653,10 +1653,10 @@ static bool batadv_tt_global_add(struct batadv_priv *bat_priv,
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
@@ -1812,12 +1812,12 @@ static struct batadv_tt_orig_list_entry *
 batadv_transtable_best_orig(struct batadv_priv *bat_priv,
 			    struct batadv_tt_global_entry *tt_global_entry)
 {
-	struct batadv_neigh_node *router;
-	struct batadv_neigh_node *best_router = NULL;
-	struct batadv_algo_ops *bao = bat_priv->algo_ops;
-	struct hlist_head *head;
-	struct batadv_tt_orig_list_entry *orig_entry;
 	struct batadv_tt_orig_list_entry *best_entry = NULL;
+	struct batadv_algo_ops *bao = bat_priv->algo_ops;
+	struct batadv_neigh_node *best_router = NULL;
+	struct batadv_tt_orig_list_entry *orig_entry;
+	struct batadv_neigh_node *router;
+	struct hlist_head *head;
 
 	head = &tt_global_entry->orig_list;
 	hlist_for_each_entry_rcu(orig_entry, head, list) {
@@ -1863,9 +1863,9 @@ batadv_tt_global_dump_subentry(struct sk_buff *msg, u32 portid, u32 seq,
 			       bool best)
 {
 	u16 flags = (common->flags & (~BATADV_TT_SYNC_MASK)) | orig->flags;
-	void *hdr;
 	struct batadv_orig_node_vlan *vlan;
 	u8 last_ttvn;
+	void *hdr;
 	u32 crc;
 
 	vlan = batadv_orig_node_vlan_get(orig->orig_node,
@@ -2000,16 +2000,16 @@ batadv_tt_global_dump_bucket(struct sk_buff *msg, u32 portid, u32 seq,
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
@@ -2080,9 +2080,9 @@ _batadv_tt_global_del_orig_entry(struct batadv_tt_global_entry *tt_global_entry,
 static void
 batadv_tt_global_del_orig_list(struct batadv_tt_global_entry *tt_global_entry)
 {
+	struct batadv_tt_orig_list_entry *orig_entry;
 	struct hlist_head *head;
 	struct hlist_node *safe;
-	struct batadv_tt_orig_list_entry *orig_entry;
 
 	spin_lock_bh(&tt_global_entry->list_lock);
 	head = &tt_global_entry->orig_list;
@@ -2107,9 +2107,9 @@ batadv_tt_global_del_orig_node(struct batadv_priv *bat_priv,
 			       struct batadv_orig_node *orig_node,
 			       const char *message)
 {
+	struct batadv_tt_orig_list_entry *orig_entry;
 	struct hlist_head *head;
 	struct hlist_node *safe;
-	struct batadv_tt_orig_list_entry *orig_entry;
 	unsigned short vid;
 
 	spin_lock_bh(&tt_global_entry->list_lock);
@@ -2139,9 +2139,9 @@ batadv_tt_global_del_roaming(struct batadv_priv *bat_priv,
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
@@ -2185,8 +2185,8 @@ static void batadv_tt_global_del(struct batadv_priv *bat_priv,
 				 const unsigned char *addr, unsigned short vid,
 				 const char *message, bool roaming)
 {
-	struct batadv_tt_global_entry *tt_global_entry;
 	struct batadv_tt_local_entry *local_entry = NULL;
+	struct batadv_tt_global_entry *tt_global_entry;
 
 	tt_global_entry = batadv_tt_global_hash_find(bat_priv, addr, vid);
 	if (!tt_global_entry)
@@ -2248,14 +2248,14 @@ void batadv_tt_global_del_orig(struct batadv_priv *bat_priv,
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
@@ -2296,9 +2296,9 @@ void batadv_tt_global_del_orig(struct batadv_priv *bat_priv,
 static bool batadv_tt_global_to_purge(struct batadv_tt_global_entry *tt_global,
 				      char **msg)
 {
-	bool purge = false;
 	unsigned long roam_timeout = BATADV_TT_CLIENT_ROAM_TIMEOUT;
 	unsigned long temp_timeout = BATADV_TT_CLIENT_TEMP_TIMEOUT;
+	bool purge = false;
 
 	if ((tt_global->common.flags & BATADV_TT_CLIENT_ROAM) &&
 	    batadv_has_timed_out(tt_global->roam_at, roam_timeout)) {
@@ -2317,14 +2317,14 @@ static bool batadv_tt_global_to_purge(struct batadv_tt_global_entry *tt_global,
 
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
@@ -2356,10 +2356,10 @@ static void batadv_tt_global_purge(struct batadv_priv *bat_priv)
 
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
@@ -2425,10 +2425,10 @@ struct batadv_orig_node *batadv_transtable_search(struct batadv_priv *bat_priv,
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
@@ -2497,11 +2497,11 @@ static u32 batadv_tt_global_crc(struct batadv_priv *bat_priv,
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
@@ -2577,11 +2577,11 @@ static u32 batadv_tt_local_crc(struct batadv_priv *bat_priv,
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
@@ -2710,8 +2710,8 @@ static struct batadv_tt_req_node *
 batadv_tt_req_node_new(struct batadv_priv *bat_priv,
 		       struct batadv_orig_node *orig_node)
 {
-	struct batadv_tt_req_node *tt_req_node_tmp;
 	struct batadv_tt_req_node *tt_req_node = NULL;
+	struct batadv_tt_req_node *tt_req_node_tmp;
 
 	spin_lock_bh(&bat_priv->tt.req_list_lock);
 	hlist_for_each_entry(tt_req_node_tmp, &bat_priv->tt.req_list, list) {
@@ -2820,8 +2820,8 @@ static u16 batadv_tt_tvlv_generate(struct batadv_priv *bat_priv,
 	struct batadv_tt_common_entry *tt_common_entry;
 	struct batadv_tvlv_tt_change *tt_change;
 	struct hlist_head *head;
-	u16 tt_tot;
 	u16 tt_num_entries = 0;
+	u16 tt_tot;
 	u8 flags;
 	bool ret;
 	u32 i;
@@ -2875,9 +2875,9 @@ static bool batadv_tt_global_check_crc(struct batadv_orig_node *orig_node,
 {
 	struct batadv_tvlv_tt_vlan_data *tt_vlan_tmp;
 	struct batadv_orig_node_vlan *vlan;
-	int i;
 	int orig_num_vlan;
 	u32 crc;
+	int i;
 
 	/* check if each received CRC matches the locally stored one */
 	for (i = 0; i < num_vlan; i++) {
@@ -2983,8 +2983,8 @@ static bool batadv_send_tt_request(struct batadv_priv *bat_priv,
 	struct batadv_tt_req_node *tt_req_node = NULL;
 	struct batadv_hard_iface *primary_if;
 	bool ret = false;
-	int i;
 	int size;
+	int i;
 
 	primary_if = batadv_primary_if_get_selected(bat_priv);
 	if (!primary_if)
@@ -3060,15 +3060,15 @@ static bool batadv_send_other_tt_response(struct batadv_priv *bat_priv,
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
@@ -3195,10 +3195,10 @@ static bool batadv_send_my_tt_response(struct batadv_priv *bat_priv,
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
@@ -3321,8 +3321,8 @@ static void _batadv_tt_update_changes(struct batadv_priv *bat_priv,
 				      struct batadv_tvlv_tt_change *tt_change,
 				      u16 tt_num_changes, u8 ttvn)
 {
-	int i;
 	int roams;
+	int i;
 
 	for (i = 0; i < tt_num_changes; i++) {
 		if ((tt_change + i)->flags & BATADV_TT_CLIENT_DEL) {
@@ -3432,11 +3432,11 @@ static void batadv_handle_tt_response(struct batadv_priv *bat_priv,
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
@@ -3582,8 +3582,8 @@ static void batadv_send_roam_adv(struct batadv_priv *bat_priv, u8 *client,
 				 unsigned short vid,
 				 struct batadv_orig_node *orig_node)
 {
-	struct batadv_hard_iface *primary_if;
 	struct batadv_tvlv_roam_adv tvlv_roam;
+	struct batadv_hard_iface *primary_if;
 
 	primary_if = batadv_primary_if_get_selected(bat_priv);
 	if (!primary_if)
@@ -3701,12 +3701,12 @@ static void batadv_tt_local_set_flags(struct batadv_priv *bat_priv, u16 flags,
 /* Purge out all the tt local entries marked with BATADV_TT_CLIENT_PENDING */
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
@@ -3796,8 +3796,8 @@ void batadv_tt_local_commit_changes(struct batadv_priv *bat_priv)
 bool batadv_is_ap_isolated(struct batadv_priv *bat_priv, u8 *src, u8 *dst,
 			   unsigned short vid)
 {
-	struct batadv_tt_local_entry *tt_local_entry;
 	struct batadv_tt_global_entry *tt_global_entry;
+	struct batadv_tt_local_entry *tt_local_entry;
 	struct batadv_meshif_vlan *vlan;
 	bool ret = false;
 
@@ -4007,14 +4007,15 @@ bool batadv_tt_add_temporary_global_entry(struct batadv_priv *bat_priv,
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
@@ -4053,9 +4054,9 @@ static void batadv_tt_tvlv_ogm_handler_v1(struct batadv_priv *bat_priv,
 {
 	struct batadv_tvlv_tt_change *tt_change;
 	struct batadv_tvlv_tt_data *tt_data;
+	size_t tt_data_sz;
 	u16 num_entries;
 	u16 num_vlan;
-	size_t tt_data_sz;
 
 	if (tvlv_value_len < sizeof(*tt_data))
 		return;
@@ -4095,8 +4096,8 @@ static int batadv_tt_tvlv_unicast_handler_v1(struct batadv_priv *bat_priv,
 					     u16 tvlv_value_len)
 {
 	struct batadv_tvlv_tt_data *tt_data;
-	u16 tt_vlan_len;
 	u16 tt_num_entries;
+	u16 tt_vlan_len;
 	char tt_flag;
 	bool ret;
 
@@ -4177,8 +4178,8 @@ static int batadv_roam_tvlv_unicast_handler_v1(struct batadv_priv *bat_priv,
 					       void *tvlv_value,
 					       u16 tvlv_value_len)
 {
-	struct batadv_tvlv_roam_adv *roaming_adv;
 	struct batadv_orig_node *orig_node = NULL;
+	struct batadv_tvlv_roam_adv *roaming_adv;
 
 	/* If this node is not the intended recipient of the
 	 * roaming advertisement the packet is forwarded
@@ -4281,12 +4282,12 @@ bool batadv_tt_global_is_isolated(struct batadv_priv *bat_priv,
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
index 659c77de..c6f6912f 100644
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
 
@@ -466,11 +466,11 @@ int batadv_tvlv_containers_process(struct batadv_priv *bat_priv,
 				   struct sk_buff *skb, void *tvlv_value,
 				   u16 tvlv_value_len)
 {
+	u8 cifnotfound = BATADV_TVLV_HANDLER_OGM_CIFNOTFND;
 	struct batadv_tvlv_handler *tvlv_handler;
 	struct batadv_tvlv_hdr *tvlv_hdr;
-	u16 tvlv_value_cont_len;
-	u8 cifnotfound = BATADV_TVLV_HANDLER_OGM_CIFNOTFND;
 	int ret = NET_RX_SUCCESS;
+	u16 tvlv_value_cont_len;
 
 	while (tvlv_value_len >= sizeof(*tvlv_hdr)) {
 		tvlv_hdr = tvlv_value;
@@ -527,8 +527,8 @@ void batadv_tvlv_ogm_receive(struct batadv_priv *bat_priv,
 			     struct batadv_ogm_packet *batadv_ogm_packet,
 			     struct batadv_orig_node *orig_node)
 {
-	void *tvlv_value;
 	u16 tvlv_value_len;
+	void *tvlv_value;
 
 	if (!batadv_ogm_packet)
 		return;
@@ -648,12 +648,12 @@ void batadv_tvlv_unicast_send(struct batadv_priv *bat_priv, const u8 *src,
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

