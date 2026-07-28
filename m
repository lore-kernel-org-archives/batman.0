Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AC36C53219
	for <batman@archiver.kernel.org>; Tue, 28 Jul 2026 13:48:50 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id BBF1A84554
	for <batman@archiver.kernel.org>; Tue, 28 Jul 2026 15:48:48 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1785246528;
 b=iNefDC/mvEdzZoMdkh/H6BJiqre7oURVmioUV4ruBRWEkV5qfE836FBhHe/G+bCpyXLk4
 PZ5rMzBb1HYsTC/o6RTL2aDT7q0GA12qsIIZPlQb6NwglEffVuVDpPrBC8RjC+VtIHP4Lfz
 JuWVmKFsI5TJA0N7jo2yRbYFuu/R1OQ=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1785246528; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=Ztq8SRtvcEFRCMYTiSYKI//vQUA+bsO51pzL1p9wrjE=;
 b=Tm2uSSVe5dDHEf+0/mcSXV14n7wIKllrNP0aaTLtlrkQZk7dO0qQfXjzTUe1ZTIP0HQI3
 wuebM9oxQb2g3dj3zY96wKPC6HiZOjWCxeYz+l5pDyy3y9qWoi8sJec343C6FF3kXhgndpm
 NTCAhoksGcH7Qh77nP7JGyIayDdzDjI=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de
 [IPv6:2a01:4f8:c17:e8c0::1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 72DE8846AA
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 28 Jul 2026 15:39:28 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1785245968;
	b=JY9jLlQPzrMZTH+49eoac59E/GHPc84YzZf4o9ILaJHgT9PY1VCe2kak6h0195x9cmxufT
	sy2M8myvIC0qfTb6A3T/Nbimf1wu37m4GaTpAHdEMB6g5G4fgNjNq/7PizB11CpfNwePsL
	HlkJfKBKHEPMmNVt5JeWAYDOg2UdyTU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1785245968;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=Ztq8SRtvcEFRCMYTiSYKI//vQUA+bsO51pzL1p9wrjE=;
	b=P1B/AGUwnpvqWtag7jZANacG11l8c81MD4T9toMQcbO42K5eXyMMwQLs9XTb8LY3iQqlcp
	u4Dl31iXd6cqjxeJM6licd4jMRoIoZZNKDLEvH3zmgXo2U+j/6PSUSE/bgMnrDozUpb6y9
	ViFP3GQfii3drqy2YE5wD8IVofs4cjA=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=FsyUG+Cf;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 2a01:4f8:c17:e8c0::1 as permitted sender)
 smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
Received: from kero.packetmixer.de
 (p200300c59717eaD808F168C97E5563A8.dip0.t-ipconnect.de
 [IPv6:2003:c5:9717:ead8:8f1:68c9:7e55:63a8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id 1E598FA154;
	Tue, 28 Jul 2026 15:39:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1785245968;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ztq8SRtvcEFRCMYTiSYKI//vQUA+bsO51pzL1p9wrjE=;
	b=FsyUG+CfugACpsrtZVbr/C+I0h7+4oFghie0Rma5nQvdoD8SIMAtVdvVsAsecojj/kb8Xa
	ql2Pk5KkE1ioGyd5RqWoAjnkbSaQhfCB8aR0BV9iGlJ4HpchIURZz3Wv11+wxeGnA7SG8u
	KMKxGhwn22lLO9+oHrodlWHseQeWQKXR/ZnKw16RsEAc42xkxdffTmV+KLkCMEoEfv0S4W
	mcPY2mDYWN3LDB0HOo2ZVgKAE46JNBZIbHLVEiU6xf2iDTIv3kFjKgV6y/GnJd2FOkiq+a
	R9vLDHDQJGizNE43uBdT02gosZyygb2Nn1I/G/VlAh6dEC2d8vUCQTWf0deU6g==
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
Subject: [PATCH net-next 12/15] batman-adv: split multiple declarations per
 line
Date: Tue, 28 Jul 2026 15:39:15 +0200
Message-ID: <20260728133918.643267-13-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260728133918.643267-1-sw@simonwunderlich.de>
References: <20260728133918.643267-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: YG3DFM7NETQO3WK2BYHTCCNFNICVBMGP
X-Message-ID-Hash: YG3DFM7NETQO3WK2BYHTCCNFNICVBMGP
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/YG3DFM7NETQO3WK2BYHTCCNFNICVBMGP/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Sven Eckelmann <sven@narfation.org>

The Linux coding style suggests to use single variable declarations per
line. This suggestion turned out to make reviewing patches easier when
single variable declarations are modified. Instead of having to search for
the modified variable, it is directly visible as a line change in the diff.

Most functions are already using this style. The remaining ones are just
adjusted by splitting the lines without ensuring the reverse x-mas tree
order because this makes it easier to check the modification.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/bat_algo.c              |  3 +-
 net/batman-adv/bat_iv_ogm.c            | 38 ++++++++----
 net/batman-adv/bat_v.c                 | 19 ++++--
 net/batman-adv/bat_v_elp.c             |  3 +-
 net/batman-adv/bat_v_ogm.c             | 13 +++--
 net/batman-adv/bridge_loop_avoidance.c | 30 ++++++----
 net/batman-adv/distributed-arp-table.c | 55 ++++++++++++------
 net/batman-adv/fragmentation.c         | 12 ++--
 net/batman-adv/gateway_client.c        |  9 ++-
 net/batman-adv/gateway_common.c        |  6 +-
 net/batman-adv/main.c                  | 12 ++--
 net/batman-adv/mesh-interface.c        | 15 +++--
 net/batman-adv/multicast.c             | 15 +++--
 net/batman-adv/multicast_forw.c        |  9 ++-
 net/batman-adv/originator.c            | 31 ++++++----
 net/batman-adv/routing.c               | 37 ++++++++----
 net/batman-adv/send.c                  |  3 +-
 net/batman-adv/tp_meter.c              | 24 +++++---
 net/batman-adv/translation-table.c     | 80 ++++++++++++++++++--------
 net/batman-adv/tvlv.c                  | 12 ++--
 20 files changed, 288 insertions(+), 138 deletions(-)

diff --git a/net/batman-adv/bat_algo.c b/net/batman-adv/bat_algo.c
index a040141cdf1a4..bd094bc793e30 100644
--- a/net/batman-adv/bat_algo.c
+++ b/net/batman-adv/bat_algo.c
@@ -42,7 +42,8 @@ void batadv_algo_init(void)
  */
 struct batadv_algo_ops *batadv_algo_get(const char *name)
 {
-	struct batadv_algo_ops *bat_algo_ops = NULL, *bat_algo_ops_tmp;
+	struct batadv_algo_ops *bat_algo_ops = NULL;
+	struct batadv_algo_ops *bat_algo_ops_tmp;
 
 	hlist_for_each_entry(bat_algo_ops_tmp, &batadv_algo_list, list) {
 		if (strcmp(bat_algo_ops_tmp->name, name) != 0)
diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index a9e80330fcb63..337e8e3554bb7 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -896,7 +896,8 @@ static void batadv_iv_ogm_schedule_buff(struct batadv_hard_iface *hard_iface)
 	struct batadv_priv *bat_priv = netdev_priv(hard_iface->mesh_iface);
 	struct batadv_ogm_buf *ogm_buff = &hard_iface->bat_iv.ogm_buff;
 	struct batadv_ogm_packet *batadv_ogm_packet;
-	struct batadv_hard_iface *primary_if, *tmp_hard_iface;
+	struct batadv_hard_iface *primary_if;
+	struct batadv_hard_iface *tmp_hard_iface;
 	struct list_head *iter;
 	u32 seqno;
 	u16 tvlv_len = 0;
@@ -1109,7 +1110,8 @@ batadv_iv_ogm_orig_update(struct batadv_priv *bat_priv,
 	struct batadv_neigh_node *neigh_node = NULL;
 	struct batadv_neigh_node *tmp_neigh_node = NULL;
 	struct batadv_neigh_node *router = NULL;
-	u8 sum_orig, sum_neigh;
+	u8 sum_orig;
+	u8 sum_neigh;
 	u8 *neigh_addr;
 	u8 tq_avg;
 
@@ -1241,13 +1243,19 @@ static bool batadv_iv_ogm_calc_tq(struct batadv_orig_node *orig_node,
 				  struct batadv_hard_iface *if_outgoing)
 {
 	struct batadv_priv *bat_priv = netdev_priv(if_incoming->mesh_iface);
-	struct batadv_neigh_node *neigh_node = NULL, *tmp_neigh_node;
+	struct batadv_neigh_node *neigh_node = NULL;
+	struct batadv_neigh_node *tmp_neigh_node;
 	struct batadv_neigh_ifinfo *neigh_ifinfo;
 	u8 total_count;
-	u8 orig_eq_count, neigh_rq_count, neigh_rq_inv, tq_own;
+	u8 orig_eq_count;
+	u8 neigh_rq_count;
+	u8 neigh_rq_inv;
+	u8 tq_own;
 	unsigned int tq_iface_hop_penalty = BATADV_TQ_MAX_VALUE;
-	unsigned int neigh_rq_inv_cube, neigh_rq_max_cube;
-	unsigned int tq_asym_penalty, inv_asym_penalty;
+	unsigned int neigh_rq_inv_cube;
+	unsigned int neigh_rq_max_cube;
+	unsigned int tq_asym_penalty;
+	unsigned int inv_asym_penalty;
 	unsigned int combined_tq;
 	bool ret = false;
 
@@ -1521,7 +1529,8 @@ batadv_iv_ogm_process_per_outif(const struct sk_buff *skb, int ogm_offset,
 	enum batadv_dup_status dup_status;
 	bool is_from_best_next_hop = false;
 	bool is_single_hop_neigh = false;
-	bool sameseq, similar_ttl;
+	bool sameseq;
+	bool similar_ttl;
 	struct sk_buff *skb_priv;
 	struct ethhdr *ethhdr;
 	u8 *prev_sender;
@@ -1747,7 +1756,8 @@ static void batadv_iv_ogm_process(const struct sk_buff *skb, int ogm_offset,
 				  struct batadv_hard_iface *if_incoming)
 {
 	struct batadv_priv *bat_priv = netdev_priv(if_incoming->mesh_iface);
-	struct batadv_orig_node *orig_neigh_node, *orig_node;
+	struct batadv_orig_node *orig_neigh_node;
+	struct batadv_orig_node *orig_node;
 	struct batadv_hard_iface *hard_iface;
 	struct batadv_ogm_packet *ogm_packet;
 	u32 if_incoming_seqno;
@@ -2230,8 +2240,10 @@ static bool batadv_iv_ogm_neigh_diff(struct batadv_neigh_node *neigh1,
 				     struct batadv_hard_iface *if_outgoing2,
 				     int *diff)
 {
-	struct batadv_neigh_ifinfo *neigh1_ifinfo, *neigh2_ifinfo;
-	u8 tq1, tq2;
+	struct batadv_neigh_ifinfo *neigh1_ifinfo;
+	struct batadv_neigh_ifinfo *neigh2_ifinfo;
+	u8 tq1;
+	u8 tq2;
 	bool ret = true;
 
 	neigh1_ifinfo = batadv_neigh_ifinfo_get(neigh1, if_outgoing1);
@@ -2474,7 +2486,8 @@ batadv_iv_gw_get_best_gw_node(struct batadv_priv *bat_priv)
 {
 	struct batadv_neigh_node *router;
 	struct batadv_neigh_ifinfo *router_ifinfo;
-	struct batadv_gw_node *gw_node, *curr_gw = NULL;
+	struct batadv_gw_node *gw_node;
+	struct batadv_gw_node *curr_gw = NULL;
 	u64 max_gw_factor = 0;
 	u64 tmp_gw_factor = 0;
 	u8 max_tq = 0;
@@ -2568,7 +2581,8 @@ static bool batadv_iv_gw_is_eligible(struct batadv_priv *bat_priv,
 	u32 sel_class = READ_ONCE(bat_priv->gw.sel_class);
 	struct batadv_neigh_node *router_gw = NULL;
 	struct batadv_neigh_node *router_orig = NULL;
-	u8 gw_tq_avg, orig_tq_avg;
+	u8 gw_tq_avg;
+	u8 orig_tq_avg;
 	bool ret = false;
 
 	/* dynamic re-election is performed only on fast or late switch */
diff --git a/net/batman-adv/bat_v.c b/net/batman-adv/bat_v.c
index 0068f0e238da6..be28875c201d7 100644
--- a/net/batman-adv/bat_v.c
+++ b/net/batman-adv/bat_v.c
@@ -490,7 +490,8 @@ static int batadv_v_neigh_cmp(struct batadv_neigh_node *neigh1,
 			      struct batadv_neigh_node *neigh2,
 			      struct batadv_hard_iface *if_outgoing2)
 {
-	struct batadv_neigh_ifinfo *ifinfo1, *ifinfo2;
+	struct batadv_neigh_ifinfo *ifinfo1;
+	struct batadv_neigh_ifinfo *ifinfo2;
 	int ret = 0;
 
 	ifinfo1 = batadv_neigh_ifinfo_get(neigh1, if_outgoing1);
@@ -526,7 +527,8 @@ static bool batadv_v_neigh_is_sob(struct batadv_neigh_node *neigh1,
 				  struct batadv_neigh_node *neigh2,
 				  struct batadv_hard_iface *if_outgoing2)
 {
-	struct batadv_neigh_ifinfo *ifinfo1, *ifinfo2;
+	struct batadv_neigh_ifinfo *ifinfo1;
+	struct batadv_neigh_ifinfo *ifinfo2;
 	u32 threshold;
 	bool ret = false;
 
@@ -610,8 +612,10 @@ static int batadv_v_gw_throughput_get(struct batadv_gw_node *gw_node, u32 *bw)
 static struct batadv_gw_node *
 batadv_v_gw_get_best_gw_node(struct batadv_priv *bat_priv)
 {
-	struct batadv_gw_node *gw_node, *curr_gw = NULL;
-	u32 max_bw = 0, bw;
+	struct batadv_gw_node *gw_node;
+	struct batadv_gw_node *curr_gw = NULL;
+	u32 max_bw = 0;
+	u32 bw;
 
 	rcu_read_lock();
 	hlist_for_each_entry_rcu(gw_node, &bat_priv->gw.gateway_list, list) {
@@ -650,8 +654,11 @@ static bool batadv_v_gw_is_eligible(struct batadv_priv *bat_priv,
 				    struct batadv_orig_node *curr_gw_orig,
 				    struct batadv_orig_node *orig_node)
 {
-	struct batadv_gw_node *curr_gw, *orig_gw = NULL;
-	u32 gw_throughput, orig_throughput, threshold;
+	struct batadv_gw_node *curr_gw;
+	struct batadv_gw_node *orig_gw = NULL;
+	u32 gw_throughput;
+	u32 orig_throughput;
+	u32 threshold;
 	bool ret = false;
 
 	threshold = READ_ONCE(bat_priv->gw.sel_class);
diff --git a/net/batman-adv/bat_v_elp.c b/net/batman-adv/bat_v_elp.c
index 262e40040007c..eb7fb8c14ef30 100644
--- a/net/batman-adv/bat_v_elp.c
+++ b/net/batman-adv/bat_v_elp.c
@@ -233,7 +233,8 @@ batadv_v_elp_wifi_neigh_probe(struct batadv_hardif_neigh_node *neigh)
 	struct batadv_priv *bat_priv = netdev_priv(hard_iface->mesh_iface);
 	unsigned long last_tx_diff;
 	struct sk_buff *skb;
-	int probe_len, i;
+	int probe_len;
+	int i;
 	int elp_skb_len;
 
 	/* this probing routine is for Wifi neighbours only */
diff --git a/net/batman-adv/bat_v_ogm.c b/net/batman-adv/bat_v_ogm.c
index e921d49f7eced..d4527663f76d9 100644
--- a/net/batman-adv/bat_v_ogm.c
+++ b/net/batman-adv/bat_v_ogm.c
@@ -271,7 +271,8 @@ static void batadv_v_ogm_send_meshif(struct batadv_priv *bat_priv)
 	struct batadv_hard_iface *hard_iface;
 	struct batadv_ogm2_packet *ogm_packet;
 	struct batadv_ogm_buf *ogm_buff;
-	struct sk_buff *skb, *skb_tmp;
+	struct sk_buff *skb;
+	struct sk_buff *skb_tmp;
 	struct list_head *iter;
 	u16 tvlv_len;
 	int ret;
@@ -706,8 +707,10 @@ static bool batadv_v_ogm_route_update(struct batadv_priv *bat_priv,
 	struct batadv_neigh_node *router = NULL;
 	struct batadv_orig_node *orig_neigh_node;
 	struct batadv_neigh_node *orig_neigh_router = NULL;
-	struct batadv_neigh_ifinfo *router_ifinfo = NULL, *neigh_ifinfo = NULL;
-	u32 router_throughput, neigh_throughput;
+	struct batadv_neigh_ifinfo *router_ifinfo = NULL;
+	struct batadv_neigh_ifinfo *neigh_ifinfo = NULL;
+	u32 router_throughput;
+	u32 neigh_throughput;
 	u32 router_last_seqno;
 	u32 neigh_last_seqno;
 	s32 neigh_seq_diff;
@@ -877,7 +880,9 @@ static void batadv_v_ogm_process(const struct sk_buff *skb, int ogm_offset,
 	struct batadv_neigh_node *neigh_node = NULL;
 	struct batadv_hard_iface *hard_iface;
 	struct batadv_ogm2_packet *ogm_packet;
-	u32 ogm_throughput, link_throughput, path_throughput;
+	u32 ogm_throughput;
+	u32 link_throughput;
+	u32 path_throughput;
 	struct list_head *iter;
 	int ret;
 
diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
index 18eafbeeccfdd..363d1819f521c 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -261,7 +261,8 @@ batadv_backbone_hash_find(struct batadv_priv *bat_priv, const u8 *addr,
 {
 	struct batadv_hashtable *hash = bat_priv->bla.backbone_hash;
 	struct hlist_head *head;
-	struct batadv_bla_backbone_gw search_entry, *backbone_gw;
+	struct batadv_bla_backbone_gw search_entry;
+	struct batadv_bla_backbone_gw *backbone_gw;
 	struct batadv_bla_backbone_gw *backbone_gw_tmp = NULL;
 	int index;
 
@@ -809,7 +810,8 @@ batadv_bla_claim_get_backbone_gw(struct batadv_bla_claim *claim)
 static void batadv_bla_del_claim(struct batadv_priv *bat_priv,
 				 const u8 *mac, const unsigned short vid)
 {
-	struct batadv_bla_claim search_claim, *claim;
+	struct batadv_bla_claim search_claim;
+	struct batadv_bla_claim *claim;
 	struct batadv_bla_claim *claim_removed_entry;
 	struct hlist_node *claim_removed_node;
 
@@ -851,7 +853,8 @@ static bool batadv_handle_announce(struct batadv_priv *bat_priv, u8 *an_addr,
 				   u8 *backbone_addr, unsigned short vid)
 {
 	struct batadv_bla_backbone_gw *backbone_gw;
-	u16 backbone_crc, crc;
+	u16 backbone_crc;
+	u16 crc;
 
 	if (memcmp(an_addr, batadv_announce_mac, 4) != 0)
 		return false;
@@ -1030,7 +1033,8 @@ static int batadv_check_claim_group(struct batadv_priv *bat_priv,
 {
 	u8 *backbone_addr;
 	struct batadv_orig_node *orig_node;
-	struct batadv_bla_claim_dst *bla_dst, *bla_dst_own;
+	struct batadv_bla_claim_dst *bla_dst;
+	struct batadv_bla_claim_dst *bla_dst_own;
 
 	bla_dst = (struct batadv_bla_claim_dst *)hw_dst;
 	bla_dst_own = &bat_priv->bla.claim_dest;
@@ -1099,9 +1103,12 @@ static bool batadv_bla_process_claim(struct batadv_priv *bat_priv,
 				     struct batadv_hard_iface *primary_if,
 				     struct sk_buff *skb)
 {
-	struct batadv_bla_claim_dst *bla_dst, *bla_dst_own;
-	u8 *hw_src, *hw_dst;
-	struct vlan_hdr *vhdr, vhdr_buf;
+	struct batadv_bla_claim_dst *bla_dst;
+	struct batadv_bla_claim_dst *bla_dst_own;
+	u8 *hw_src;
+	u8 *hw_dst;
+	struct vlan_hdr *vhdr;
+	struct vlan_hdr vhdr_buf;
 	struct ethhdr *ethhdr;
 	struct arphdr *arphdr;
 	unsigned short vid;
@@ -1665,7 +1672,8 @@ static bool batadv_bla_check_duplist(struct batadv_priv *bat_priv,
 	struct batadv_bcast_duplist_entry *entry;
 	bool ret = false;
 	int payload_len;
-	int i, curr;
+	int i;
+	int curr;
 	u32 crc;
 
 	/* calculate the crc ... */
@@ -1956,7 +1964,8 @@ bool batadv_bla_rx(struct batadv_priv *bat_priv, struct sk_buff *skb,
 {
 	struct batadv_bla_backbone_gw *backbone_gw;
 	struct ethhdr *ethhdr;
-	struct batadv_bla_claim search_claim, *claim = NULL;
+	struct batadv_bla_claim search_claim;
+	struct batadv_bla_claim *claim = NULL;
 	struct batadv_hard_iface *primary_if;
 	bool own_claim;
 	bool ret;
@@ -2089,7 +2098,8 @@ bool batadv_bla_tx(struct batadv_priv *bat_priv, struct sk_buff *skb,
 		   unsigned short vid)
 {
 	struct ethhdr *ethhdr;
-	struct batadv_bla_claim search_claim, *claim = NULL;
+	struct batadv_bla_claim search_claim;
+	struct batadv_bla_claim *claim = NULL;
 	struct batadv_bla_backbone_gw *backbone_gw;
 	struct batadv_hard_iface *primary_if;
 	bool client_roamed;
diff --git a/net/batman-adv/distributed-arp-table.c b/net/batman-adv/distributed-arp-table.c
index e9cc4690068eb..0ba3ba6a2e382 100644
--- a/net/batman-adv/distributed-arp-table.c
+++ b/net/batman-adv/distributed-arp-table.c
@@ -372,7 +372,9 @@ batadv_dat_entry_hash_find(struct batadv_priv *bat_priv, __be32 ip,
 			   unsigned short vid)
 {
 	struct hlist_head *head;
-	struct batadv_dat_entry to_find, *dat_entry, *dat_entry_tmp = NULL;
+	struct batadv_dat_entry to_find;
+	struct batadv_dat_entry *dat_entry;
+	struct batadv_dat_entry *dat_entry_tmp = NULL;
 	struct batadv_hashtable *hash = bat_priv->dat.hash;
 	u32 index;
 
@@ -475,7 +477,8 @@ static void batadv_dbg_arp(struct batadv_priv *bat_priv, struct sk_buff *skb,
 	struct batadv_unicast_4addr_packet *unicast_4addr_packet;
 	struct batadv_bcast_packet *bcast_pkt;
 	u8 *orig_addr;
-	__be32 ip_src, ip_dst;
+	__be32 ip_src;
+	__be32 ip_dst;
 
 	if (msg)
 		batadv_dbg(BATADV_DBG_DAT, bat_priv, "%s\n", msg);
@@ -612,7 +615,8 @@ static void batadv_choose_next_candidate(struct batadv_priv *bat_priv,
 {
 	batadv_dat_addr_t max = 0;
 	batadv_dat_addr_t tmp_max = 0;
-	struct batadv_orig_node *orig_node, *max_orig_node = NULL;
+	struct batadv_orig_node *orig_node;
+	struct batadv_orig_node *max_orig_node = NULL;
 	struct batadv_hashtable *hash = bat_priv->orig_hash;
 	struct hlist_head *head;
 	int i;
@@ -678,7 +682,8 @@ batadv_dat_select_candidates(struct batadv_priv *bat_priv, __be32 ip_dst,
 			     unsigned short vid)
 {
 	int select;
-	batadv_dat_addr_t last_max = BATADV_DAT_ADDR_MAX, ip_key;
+	batadv_dat_addr_t last_max = BATADV_DAT_ADDR_MAX;
+	batadv_dat_addr_t ip_key;
 	struct batadv_dat_candidate *res;
 	struct batadv_dat_entry dat;
 
@@ -1051,8 +1056,10 @@ static u16 batadv_arp_get_type(struct batadv_priv *bat_priv,
 {
 	struct arphdr *arphdr;
 	struct ethhdr *ethhdr;
-	__be32 ip_src, ip_dst;
-	u8 *hw_src, *hw_dst;
+	__be32 ip_src;
+	__be32 ip_dst;
+	u8 *hw_src;
+	u8 *hw_dst;
 	u16 type = 0;
 
 	/* pull the ethernet header */
@@ -1200,7 +1207,8 @@ bool batadv_dat_snoop_outgoing_arp_request(struct batadv_priv *bat_priv,
 					   struct sk_buff *skb)
 {
 	u16 type = 0;
-	__be32 ip_dst, ip_src;
+	__be32 ip_dst;
+	__be32 ip_src;
 	u8 *hw_src;
 	bool ret = false;
 	struct batadv_dat_entry *dat_entry = NULL;
@@ -1308,7 +1316,8 @@ bool batadv_dat_snoop_incoming_arp_request(struct batadv_priv *bat_priv,
 					   struct sk_buff *skb, int hdr_size)
 {
 	u16 type;
-	__be32 ip_src, ip_dst;
+	__be32 ip_src;
+	__be32 ip_dst;
 	u8 *hw_src;
 	struct sk_buff *skb_new;
 	struct batadv_dat_entry *dat_entry = NULL;
@@ -1379,8 +1388,10 @@ void batadv_dat_snoop_outgoing_arp_reply(struct batadv_priv *bat_priv,
 					 struct sk_buff *skb)
 {
 	u16 type;
-	__be32 ip_src, ip_dst;
-	u8 *hw_src, *hw_dst;
+	__be32 ip_src;
+	__be32 ip_dst;
+	u8 *hw_src;
+	u8 *hw_dst;
 	int hdr_size = 0;
 	unsigned short vid;
 
@@ -1436,8 +1447,10 @@ bool batadv_dat_snoop_incoming_arp_reply(struct batadv_priv *bat_priv,
 {
 	struct batadv_dat_entry *dat_entry = NULL;
 	u16 type;
-	__be32 ip_src, ip_dst;
-	u8 *hw_src, *hw_dst;
+	__be32 ip_src;
+	__be32 ip_dst;
+	u8 *hw_src;
+	u8 *hw_dst;
 	bool dropped = false;
 	unsigned short vid;
 	u8 mac[ETH_ALEN];
@@ -1538,8 +1551,10 @@ static bool
 batadv_dat_check_dhcp_ipudp(struct sk_buff *skb, __be32 *ip_src)
 {
 	unsigned int offset = skb_network_offset(skb);
-	struct udphdr *udphdr, _udphdr;
-	struct iphdr *iphdr, _iphdr;
+	struct udphdr *udphdr;
+	struct udphdr _udphdr;
+	struct iphdr *iphdr;
+	struct iphdr _iphdr;
 
 	iphdr = skb_header_pointer(skb, offset, sizeof(_iphdr), &_iphdr);
 	if (!iphdr || iphdr->version != 4 || iphdr->ihl * 4 < sizeof(_iphdr))
@@ -1577,7 +1592,8 @@ batadv_dat_check_dhcp_ipudp(struct sk_buff *skb, __be32 *ip_src)
 static int
 batadv_dat_check_dhcp(struct sk_buff *skb, __be16 proto, __be32 *ip_src)
 {
-	__be32 *magic, _magic;
+	__be32 *magic;
+	__be32 _magic;
 	unsigned int offset;
 	struct {
 		__u8 op;
@@ -1625,7 +1641,8 @@ batadv_dat_check_dhcp(struct sk_buff *skb, __be16 proto, __be32 *ip_src)
 static int batadv_dat_get_dhcp_message_type(struct sk_buff *skb)
 {
 	unsigned int offset = skb_transport_offset(skb) + sizeof(struct udphdr);
-	u8 *type, _type;
+	u8 *type;
+	u8 _type;
 	struct {
 		u8 type;
 		u8 len;
@@ -1821,7 +1838,8 @@ void batadv_dat_snoop_outgoing_dhcp_ack(struct batadv_priv *bat_priv,
 					unsigned short vid)
 {
 	u8 chaddr[BATADV_DHCP_CHADDR_LEN];
-	__be32 ip_src, yiaddr;
+	__be32 ip_src;
+	__be32 yiaddr;
 
 	if (!READ_ONCE(bat_priv->distributed_arp_table))
 		return;
@@ -1853,7 +1871,8 @@ void batadv_dat_snoop_incoming_dhcp_ack(struct batadv_priv *bat_priv,
 {
 	u8 chaddr[BATADV_DHCP_CHADDR_LEN];
 	struct ethhdr *ethhdr;
-	__be32 ip_src, yiaddr;
+	__be32 ip_src;
+	__be32 yiaddr;
 	unsigned short vid;
 	int hdr_size_tmp;
 	__be16 proto;
diff --git a/net/batman-adv/fragmentation.c b/net/batman-adv/fragmentation.c
index 2e20a2cb64cbf..f382af8588b56 100644
--- a/net/batman-adv/fragmentation.c
+++ b/net/batman-adv/fragmentation.c
@@ -140,11 +140,13 @@ static bool batadv_frag_insert_packet(struct batadv_orig_node *orig_node,
 				      struct hlist_head *chain_out)
 {
 	struct batadv_frag_table_entry *chain;
-	struct batadv_frag_list_entry *frag_entry_new = NULL, *frag_entry_curr;
+	struct batadv_frag_list_entry *frag_entry_new = NULL;
+	struct batadv_frag_list_entry *frag_entry_curr;
 	struct batadv_frag_list_entry *frag_entry_last = NULL;
 	struct batadv_frag_packet *frag_packet;
 	u8 bucket;
-	u16 seqno, hdr_size = sizeof(struct batadv_frag_packet);
+	u16 seqno;
+	u16 hdr_size = sizeof(struct batadv_frag_packet);
 	bool overflow = false;
 	bool ret = false;
 	size_t data_len;
@@ -261,7 +263,8 @@ batadv_frag_merge_packets(struct hlist_head *chain)
 	struct batadv_frag_packet *packet;
 	struct batadv_frag_list_entry *entry;
 	struct sk_buff *skb_out;
-	int size, hdr_size = sizeof(struct batadv_frag_packet);
+	int size;
+	int hdr_size = sizeof(struct batadv_frag_packet);
 	bool dropped = false;
 
 	/* Remove first entry, as this is the destination for the rest of the
@@ -509,7 +512,8 @@ int batadv_frag_send_packet(struct sk_buff *skb,
 	struct sk_buff *skb_fragment;
 	unsigned int mtu = net_dev->mtu;
 	unsigned int header_size = sizeof(frag_header);
-	unsigned int max_fragment_size, num_fragments;
+	unsigned int max_fragment_size;
+	unsigned int num_fragments;
 	int ret;
 
 	/* To avoid merge and refragmentation at next-hops we never send
diff --git a/net/batman-adv/gateway_client.c b/net/batman-adv/gateway_client.c
index f4d53d9ea3b31..b1a5b9ca31888 100644
--- a/net/batman-adv/gateway_client.c
+++ b/net/batman-adv/gateway_client.c
@@ -378,7 +378,8 @@ static void batadv_gw_node_add(struct batadv_priv *bat_priv,
 struct batadv_gw_node *batadv_gw_node_get(struct batadv_priv *bat_priv,
 					  struct batadv_orig_node *orig_node)
 {
-	struct batadv_gw_node *gw_node_tmp, *gw_node = NULL;
+	struct batadv_gw_node *gw_node_tmp;
+	struct batadv_gw_node *gw_node = NULL;
 
 	rcu_read_lock();
 	hlist_for_each_entry_rcu(gw_node_tmp, &bat_priv->gw.gateway_list,
@@ -408,7 +409,8 @@ void batadv_gw_node_update(struct batadv_priv *bat_priv,
 			   struct batadv_orig_node *orig_node,
 			   struct batadv_tvlv_gateway_data *gateway)
 {
-	struct batadv_gw_node *gw_node, *curr_gw = NULL;
+	struct batadv_gw_node *gw_node;
+	struct batadv_gw_node *curr_gw = NULL;
 
 	spin_lock_bh(&bat_priv->gw.list_lock);
 	gw_node = batadv_gw_node_get(bat_priv, orig_node);
@@ -695,7 +697,8 @@ bool batadv_gw_out_of_range(struct batadv_priv *bat_priv,
 	struct batadv_orig_node *orig_dst_node = NULL;
 	struct batadv_gw_node *gw_node = NULL;
 	struct batadv_gw_node *curr_gw = NULL;
-	struct batadv_neigh_ifinfo *curr_ifinfo, *old_ifinfo;
+	struct batadv_neigh_ifinfo *curr_ifinfo;
+	struct batadv_neigh_ifinfo *old_ifinfo;
 	struct ethhdr *ethhdr;
 	bool out_of_range = false;
 	u8 curr_tq_avg;
diff --git a/net/batman-adv/gateway_common.c b/net/batman-adv/gateway_common.c
index 675ebf098d4ec..b5ebe837bfdd1 100644
--- a/net/batman-adv/gateway_common.c
+++ b/net/batman-adv/gateway_common.c
@@ -26,7 +26,8 @@ void batadv_gw_tvlv_container_update(struct batadv_priv *bat_priv)
 {
 	struct batadv_tvlv_gateway_data gw;
 	enum batadv_gw_modes gw_mode;
-	u32 down, up;
+	u32 down;
+	u32 up;
 
 	gw_mode = READ_ONCE(bat_priv->gw.mode);
 
@@ -59,7 +60,8 @@ static void batadv_gw_tvlv_ogm_handler_v1(struct batadv_priv *bat_priv,
 					  u8 flags,
 					  void *tvlv_value, u16 tvlv_value_len)
 {
-	struct batadv_tvlv_gateway_data gateway, *gateway_ptr;
+	struct batadv_tvlv_gateway_data gateway;
+	struct batadv_tvlv_gateway_data *gateway_ptr;
 
 	/* only fetch the tvlv value if the handler wasn't called via the
 	 * CIFNOTFND flag and if there is data to fetch
diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index fa82ffb706b3f..d8e9d20add898 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -368,10 +368,14 @@ int batadv_max_header_len(void)
  */
 void batadv_skb_set_priority(struct sk_buff *skb, int offset)
 {
-	struct iphdr ip_hdr_tmp, *ip_hdr;
-	struct ipv6hdr ip6_hdr_tmp, *ip6_hdr;
-	struct ethhdr ethhdr_tmp, *ethhdr;
-	struct vlan_ethhdr *vhdr, vhdr_tmp;
+	struct iphdr ip_hdr_tmp;
+	struct iphdr *ip_hdr;
+	struct ipv6hdr ip6_hdr_tmp;
+	struct ipv6hdr *ip6_hdr;
+	struct ethhdr ethhdr_tmp;
+	struct ethhdr *ethhdr;
+	struct vlan_ethhdr *vhdr;
+	struct vlan_ethhdr vhdr_tmp;
 	u32 prio;
 
 	/* already set, do nothing */
diff --git a/net/batman-adv/mesh-interface.c b/net/batman-adv/mesh-interface.c
index 982de90906b59..534e96eb96953 100644
--- a/net/batman-adv/mesh-interface.c
+++ b/net/batman-adv/mesh-interface.c
@@ -92,7 +92,8 @@ int batadv_skb_head_push(struct sk_buff *skb, unsigned int len)
  */
 static u64 batadv_sum_counter(struct batadv_priv *bat_priv,  size_t idx)
 {
-	u64 *counters, sum = 0;
+	u64 *counters;
+	u64 sum = 0;
 	int cpu;
 
 	for_each_possible_cpu(cpu) {
@@ -221,12 +222,15 @@ static netdev_tx_t batadv_interface_tx(struct sk_buff *skb,
 	static const u8 ectp_addr[ETH_ALEN] = {0xCF, 0x00, 0x00, 0x00,
 					       0x00, 0x00};
 	enum batadv_dhcp_recipient dhcp_rcp = BATADV_DHCP_NO;
-	u8 *dst_hint = NULL, chaddr[ETH_ALEN];
+	u8 *dst_hint = NULL;
+	u8 chaddr[ETH_ALEN];
 	struct vlan_ethhdr *vhdr;
 	unsigned int header_len = 0;
-	int data_len = skb->len, ret;
+	int data_len = skb->len;
+	int ret;
 	unsigned long brd_delay = 0;
-	bool do_bcast = false, client_added;
+	bool do_bcast = false;
+	bool client_added;
 	unsigned short vid;
 	u32 seqno;
 	int gw_mode;
@@ -569,7 +573,8 @@ void batadv_meshif_vlan_release(struct kref *ref)
 struct batadv_meshif_vlan *batadv_meshif_vlan_get(struct batadv_priv *bat_priv,
 						  unsigned short vid)
 {
-	struct batadv_meshif_vlan *vlan_tmp, *vlan = NULL;
+	struct batadv_meshif_vlan *vlan_tmp;
+	struct batadv_meshif_vlan *vlan = NULL;
 
 	rcu_read_lock();
 	hlist_for_each_entry_rcu(vlan_tmp, &bat_priv->meshif_vlan_list, list) {
diff --git a/net/batman-adv/multicast.c b/net/batman-adv/multicast.c
index 1c5315e55c046..5b9e2168a0467 100644
--- a/net/batman-adv/multicast.c
+++ b/net/batman-adv/multicast.c
@@ -274,7 +274,8 @@ static struct batadv_mcast_mla_flags
 batadv_mcast_mla_flags_get(struct batadv_priv *bat_priv)
 {
 	struct net_device *dev = bat_priv->mesh_iface;
-	struct batadv_mcast_querier_state *qr4, *qr6;
+	struct batadv_mcast_querier_state *qr4;
+	struct batadv_mcast_querier_state *qr6;
 	struct batadv_mcast_mla_flags mla_flags;
 	struct net_device *bridge;
 
@@ -521,7 +522,8 @@ batadv_mcast_mla_meshif_get(struct net_device *dev,
 			    struct batadv_mcast_mla_flags *flags)
 {
 	struct net_device *bridge = batadv_mcast_get_bridge(dev);
-	int ret4, ret6 = 0;
+	int ret4;
+	int ret6 = 0;
 
 	if (bridge)
 		dev = bridge;
@@ -585,7 +587,8 @@ static int batadv_mcast_mla_bridge_get(struct net_device *dev,
 				       struct batadv_mcast_mla_flags *flags)
 {
 	struct list_head bridge_mcast_list = LIST_HEAD_INIT(bridge_mcast_list);
-	struct br_ip_list *br_ip_entry, *tmp;
+	struct br_ip_list *br_ip_entry;
+	struct br_ip_list *tmp;
 	u8 tvlv_flags = flags->tvlv_flags;
 	struct batadv_hw_addr *new;
 	u8 mcast_addr[ETH_ALEN];
@@ -1223,7 +1226,11 @@ enum batadv_forw_mode
 batadv_mcast_forw_mode(struct batadv_priv *bat_priv, struct sk_buff *skb,
 		       unsigned short vid, int *is_routable)
 {
-	int ret, tt_count, ip_count, unsnoop_count, total_count;
+	int ret;
+	int tt_count;
+	int ip_count;
+	int unsnoop_count;
+	int total_count;
 	bool is_unsnoopable = false;
 	struct ethhdr *ethhdr;
 	int rtr_count = 0;
diff --git a/net/batman-adv/multicast_forw.c b/net/batman-adv/multicast_forw.c
index 75a3a4567b08b..6dcac586b1d95 100644
--- a/net/batman-adv/multicast_forw.c
+++ b/net/batman-adv/multicast_forw.c
@@ -368,7 +368,8 @@ static void batadv_mcast_forw_scrape(struct sk_buff *skb,
 				     unsigned short offset,
 				     unsigned short len)
 {
-	char *to, *from;
+	char *to;
+	char *from;
 
 	SKB_LINEAR_ASSERT(skb);
 
@@ -411,7 +412,8 @@ static bool batadv_mcast_forw_push_insert_padding(struct sk_buff *skb,
 						  unsigned short *tvlv_len)
 {
 	unsigned short offset =	*tvlv_len;
-	char *to, *from = skb->data;
+	char *to;
+	char *from = skb->data;
 
 	to = batadv_mcast_forw_push_padding(skb, tvlv_len);
 	if (!to)
@@ -933,7 +935,8 @@ static int batadv_mcast_forw_packet(struct batadv_priv *bat_priv,
 	unsigned int tvlv_len;
 	unsigned long offset;
 	bool xmitted = false;
-	u8 *dest, *next_dest;
+	u8 *dest;
+	u8 *next_dest;
 	u16 num_dests;
 	int ret;
 
diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
index bab1eb61d9ef2..57bb4a0131b0e 100644
--- a/net/batman-adv/originator.c
+++ b/net/batman-adv/originator.c
@@ -54,7 +54,8 @@ batadv_orig_hash_find(struct batadv_priv *bat_priv, const void *data)
 {
 	struct batadv_hashtable *hash = bat_priv->orig_hash;
 	struct hlist_head *head;
-	struct batadv_orig_node *orig_node, *orig_node_tmp = NULL;
+	struct batadv_orig_node *orig_node;
+	struct batadv_orig_node *orig_node_tmp = NULL;
 	int index;
 
 	if (!hash)
@@ -108,7 +109,8 @@ struct batadv_orig_node_vlan *
 batadv_orig_node_vlan_get(struct batadv_orig_node *orig_node,
 			  unsigned short vid)
 {
-	struct batadv_orig_node_vlan *vlan = NULL, *tmp;
+	struct batadv_orig_node_vlan *vlan = NULL;
+	struct batadv_orig_node_vlan *tmp;
 
 	rcu_read_lock();
 	hlist_for_each_entry_rcu(tmp, &orig_node->vlan_list, list) {
@@ -373,7 +375,8 @@ struct batadv_orig_ifinfo *
 batadv_orig_ifinfo_get(struct batadv_orig_node *orig_node,
 		       struct batadv_hard_iface *if_outgoing)
 {
-	struct batadv_orig_ifinfo *tmp, *orig_ifinfo = NULL;
+	struct batadv_orig_ifinfo *tmp;
+	struct batadv_orig_ifinfo *orig_ifinfo = NULL;
 
 	rcu_read_lock();
 	hlist_for_each_entry_rcu(tmp, &orig_node->ifinfo_list,
@@ -451,8 +454,8 @@ struct batadv_neigh_ifinfo *
 batadv_neigh_ifinfo_get(struct batadv_neigh_node *neigh,
 			struct batadv_hard_iface *if_outgoing)
 {
-	struct batadv_neigh_ifinfo *neigh_ifinfo = NULL,
-				   *tmp_neigh_ifinfo;
+	struct batadv_neigh_ifinfo *neigh_ifinfo = NULL;
+	struct batadv_neigh_ifinfo *tmp_neigh_ifinfo;
 
 	rcu_read_lock();
 	hlist_for_each_entry_rcu(tmp_neigh_ifinfo, &neigh->ifinfo_list,
@@ -530,7 +533,8 @@ batadv_neigh_node_get(const struct batadv_orig_node *orig_node,
 		      const struct batadv_hard_iface *hard_iface,
 		      const u8 *addr)
 {
-	struct batadv_neigh_node *tmp_neigh_node, *res = NULL;
+	struct batadv_neigh_node *tmp_neigh_node;
+	struct batadv_neigh_node *res = NULL;
 
 	rcu_read_lock();
 	hlist_for_each_entry_rcu(tmp_neigh_node, &orig_node->neigh_list, list) {
@@ -634,7 +638,8 @@ struct batadv_hardif_neigh_node *
 batadv_hardif_neigh_get(const struct batadv_hard_iface *hard_iface,
 			const u8 *neigh_addr)
 {
-	struct batadv_hardif_neigh_node *tmp_hardif_neigh, *hardif_neigh = NULL;
+	struct batadv_hardif_neigh_node *tmp_hardif_neigh;
+	struct batadv_hardif_neigh_node *hardif_neigh = NULL;
 
 	rcu_read_lock();
 	hlist_for_each_entry_rcu(tmp_hardif_neigh,
@@ -753,7 +758,8 @@ batadv_neigh_node_get_or_create(struct batadv_orig_node *orig_node,
  */
 int batadv_hardif_neigh_dump(struct sk_buff *msg, struct netlink_callback *cb)
 {
-	struct batadv_hard_iface *primary_if, *hard_iface;
+	struct batadv_hard_iface *primary_if;
+	struct batadv_hard_iface *hard_iface;
 	struct net_device *mesh_iface;
 	struct batadv_priv *bat_priv;
 	int ret;
@@ -1167,7 +1173,8 @@ batadv_find_best_neighbor(struct batadv_priv *bat_priv,
 			  struct batadv_orig_node *orig_node,
 			  struct batadv_hard_iface *if_outgoing)
 {
-	struct batadv_neigh_node *best = NULL, *neigh;
+	struct batadv_neigh_node *best = NULL;
+	struct batadv_neigh_node *neigh;
 	struct batadv_algo_ops *bao = bat_priv->algo_ops;
 
 	rcu_read_lock();
@@ -1203,7 +1210,8 @@ static bool batadv_purge_orig_node(struct batadv_priv *bat_priv,
 {
 	struct batadv_neigh_node *best_neigh_node;
 	struct batadv_hard_iface *hard_iface;
-	bool changed_ifinfo, changed_neigh;
+	bool changed_ifinfo;
+	bool changed_neigh;
 	struct list_head *iter;
 
 	if (batadv_has_timed_out(orig_node->last_seen,
@@ -1325,7 +1333,8 @@ static void batadv_purge_orig(struct work_struct *work)
  */
 int batadv_orig_dump(struct sk_buff *msg, struct netlink_callback *cb)
 {
-	struct batadv_hard_iface *primary_if, *hard_iface;
+	struct batadv_hard_iface *primary_if;
+	struct batadv_hard_iface *hard_iface;
 	struct net_device *mesh_iface;
 	struct batadv_priv *bat_priv;
 	int ret;
diff --git a/net/batman-adv/routing.c b/net/batman-adv/routing.c
index 770037b8ca4e4..b4c6e13877c12 100644
--- a/net/batman-adv/routing.c
+++ b/net/batman-adv/routing.c
@@ -276,7 +276,8 @@ static int batadv_recv_my_icmp_packet(struct batadv_priv *bat_priv,
 	struct batadv_hard_iface *primary_if = NULL;
 	struct batadv_orig_node *orig_node = NULL;
 	struct batadv_icmp_header *icmph;
-	int res, ret = NET_RX_DROP;
+	int res;
+	int ret = NET_RX_DROP;
 
 	icmph = (struct batadv_icmp_header *)skb->data;
 
@@ -348,7 +349,8 @@ static int batadv_recv_icmp_ttl_exceeded(struct batadv_priv *bat_priv,
 	struct batadv_hard_iface *primary_if = NULL;
 	struct batadv_orig_node *orig_node = NULL;
 	struct batadv_icmp_packet *icmp_packet;
-	int res, ret = NET_RX_DROP;
+	int res;
+	int ret = NET_RX_DROP;
 
 	icmp_packet = (struct batadv_icmp_packet *)skb->data;
 
@@ -411,7 +413,8 @@ int batadv_recv_icmp_packet(struct sk_buff *skb,
 	struct ethhdr *ethhdr;
 	struct batadv_orig_node *orig_node = NULL;
 	int hdr_size = sizeof(struct batadv_icmp_header);
-	int res, ret = NET_RX_DROP;
+	int res;
+	int ret = NET_RX_DROP;
 
 	/* drop packet if it has not necessary minimum size */
 	if (unlikely(!pskb_may_pull(skb, hdr_size)))
@@ -593,9 +596,11 @@ batadv_find_router(struct batadv_priv *bat_priv,
 	struct batadv_algo_ops *bao = bat_priv->algo_ops;
 	struct batadv_neigh_node *first_candidate_router = NULL;
 	struct batadv_neigh_node *next_candidate_router = NULL;
-	struct batadv_neigh_node *router, *cand_router = NULL;
+	struct batadv_neigh_node *router;
+	struct batadv_neigh_node *cand_router = NULL;
 	struct batadv_neigh_node *last_cand_router = NULL;
-	struct batadv_orig_ifinfo *cand, *first_candidate = NULL;
+	struct batadv_orig_ifinfo *cand;
+	struct batadv_orig_ifinfo *first_candidate = NULL;
 	struct batadv_orig_ifinfo *next_candidate = NULL;
 	struct batadv_orig_ifinfo *last_candidate;
 	bool last_candidate_found = false;
@@ -739,7 +744,9 @@ static int batadv_route_unicast_packet(struct sk_buff *skb,
 	struct batadv_orig_node *orig_node = NULL;
 	struct batadv_unicast_packet *unicast_packet;
 	struct ethhdr *ethhdr = eth_hdr(skb);
-	int res, hdr_len, ret = NET_RX_DROP;
+	int res;
+	int hdr_len;
+	int ret = NET_RX_DROP;
 	unsigned int len;
 
 	unicast_packet = (struct batadv_unicast_packet *)skb->data;
@@ -882,7 +889,8 @@ static bool batadv_check_unicast_ttvn(struct batadv_priv *bat_priv,
 	struct batadv_unicast_packet *unicast_packet;
 	struct batadv_hard_iface *primary_if;
 	struct batadv_orig_node *orig_node;
-	u8 curr_ttvn, old_ttvn;
+	u8 curr_ttvn;
+	u8 old_ttvn;
 	struct ethhdr *ethhdr;
 	unsigned short vid;
 	int is_old_ttvn;
@@ -1002,7 +1010,8 @@ int batadv_recv_unhandled_unicast_packet(struct sk_buff *skb,
 {
 	struct batadv_unicast_packet *unicast_packet;
 	struct batadv_priv *bat_priv = netdev_priv(recv_if->mesh_iface);
-	int check, hdr_size = sizeof(*unicast_packet);
+	int check;
+	int hdr_size = sizeof(*unicast_packet);
 
 	check = batadv_check_unicast_packet(bat_priv, skb, hdr_size);
 	if (check < 0)
@@ -1033,12 +1042,16 @@ int batadv_recv_unicast_packet(struct sk_buff *skb,
 	struct batadv_priv *bat_priv = netdev_priv(recv_if->mesh_iface);
 	struct batadv_unicast_packet *unicast_packet;
 	struct batadv_unicast_4addr_packet *unicast_4addr_packet;
-	u8 *orig_addr, *orig_addr_gw;
-	struct batadv_orig_node *orig_node = NULL, *orig_node_gw = NULL;
-	int check, hdr_size = sizeof(*unicast_packet);
+	u8 *orig_addr;
+	u8 *orig_addr_gw;
+	struct batadv_orig_node *orig_node = NULL;
+	struct batadv_orig_node *orig_node_gw = NULL;
+	int check;
+	int hdr_size = sizeof(*unicast_packet);
 	enum batadv_subtype subtype;
 	int ret = NET_RX_DROP;
-	bool is4addr, is_gw;
+	bool is4addr;
+	bool is_gw;
 
 	unicast_packet = (struct batadv_unicast_packet *)skb->data;
 	is4addr = unicast_packet->packet_type == BATADV_UNICAST_4ADDR;
diff --git a/net/batman-adv/send.c b/net/batman-adv/send.c
index 7f449338a4909..29f2cbc61285d 100644
--- a/net/batman-adv/send.c
+++ b/net/batman-adv/send.c
@@ -394,7 +394,8 @@ int batadv_send_skb_via_tt_generic(struct batadv_priv *bat_priv,
 {
 	struct ethhdr *ethhdr = (struct ethhdr *)skb->data;
 	struct batadv_orig_node *orig_node;
-	u8 *src, *dst;
+	u8 *src;
+	u8 *dst;
 	int ret;
 
 	src = ethhdr->h_source;
diff --git a/net/batman-adv/tp_meter.c b/net/batman-adv/tp_meter.c
index 00467aa79de9d..b957a59dcf262 100644
--- a/net/batman-adv/tp_meter.c
+++ b/net/batman-adv/tp_meter.c
@@ -267,7 +267,8 @@ static void batadv_tp_batctl_error_notify(enum batadv_tp_meter_reason reason,
 static struct batadv_tp_sender *
 batadv_tp_list_find_sender(struct batadv_priv *bat_priv, const u8 *dst)
 {
-	struct batadv_tp_sender *pos, *tp_vars = NULL;
+	struct batadv_tp_sender *pos;
+	struct batadv_tp_sender *tp_vars = NULL;
 
 	rcu_read_lock();
 	hlist_for_each_entry_rcu(pos, &bat_priv->tp_sender_list, common.list) {
@@ -332,7 +333,8 @@ static struct batadv_tp_sender *
 batadv_tp_list_find_sender_session(struct batadv_priv *bat_priv, const u8 *dst,
 				   const u8 *session)
 {
-	struct batadv_tp_sender *pos, *tp_vars = NULL;
+	struct batadv_tp_sender *pos;
+	struct batadv_tp_sender *tp_vars = NULL;
 
 	rcu_read_lock();
 	hlist_for_each_entry_rcu(pos, &bat_priv->tp_sender_list, common.list) {
@@ -864,7 +866,8 @@ static void batadv_tp_recv_ack(struct batadv_priv *bat_priv,
 static bool batadv_tp_avail(struct batadv_tp_sender *tp_vars,
 			    size_t payload_len)
 {
-	u32 win_left, win_limit;
+	u32 win_left;
+	u32 win_limit;
 
 	spin_lock_bh(&tp_vars->cc_lock);
 
@@ -914,7 +917,8 @@ static int batadv_tp_send(void *arg)
 	struct batadv_priv *bat_priv = tp_vars->common.bat_priv;
 	struct batadv_hard_iface *primary_if = NULL;
 	struct batadv_orig_node *orig_node = NULL;
-	size_t payload_len, packet_len;
+	size_t payload_len;
+	size_t packet_len;
 	u32 last_sent;
 	int err = 0;
 
@@ -1211,7 +1215,8 @@ static struct batadv_tp_receiver *
 batadv_tp_list_find_receiver_session(struct batadv_priv *bat_priv, const u8 *dst,
 				     const u8 *session)
 {
-	struct batadv_tp_receiver *pos, *tp_vars = NULL;
+	struct batadv_tp_receiver *pos;
+	struct batadv_tp_receiver *tp_vars = NULL;
 
 	rcu_read_lock();
 	hlist_for_each_entry_rcu(pos, &bat_priv->tp_receiver_list, common.list) {
@@ -1296,7 +1301,8 @@ static void batadv_tp_reset_receiver_timer(struct batadv_tp_receiver *tp_vars)
 static void batadv_tp_receiver_shutdown(struct timer_list *t)
 {
 	struct batadv_tp_receiver *tp_vars = timer_container_of(tp_vars, t, common.timer);
-	struct batadv_tp_unacked *un, *safe;
+	struct batadv_tp_unacked *un;
+	struct batadv_tp_unacked *safe;
 	struct batadv_priv *bat_priv;
 
 	bat_priv = tp_vars->common.bat_priv;
@@ -1351,7 +1357,8 @@ static int batadv_tp_send_ack(struct batadv_priv *bat_priv, const u8 *dst,
 	struct batadv_orig_node *orig_node;
 	struct batadv_icmp_tp_packet *icmp;
 	struct sk_buff *skb;
-	int r, ret;
+	int r;
+	int ret;
 
 	orig_node = batadv_orig_hash_find(bat_priv, dst);
 	if (unlikely(!orig_node)) {
@@ -1528,7 +1535,8 @@ static bool batadv_tp_handle_out_of_order(struct batadv_tp_receiver *tp_vars,
 static void batadv_tp_ack_unordered(struct batadv_tp_receiver *tp_vars)
 	__must_hold(&tp_vars->ack_seqno_lock)
 {
-	struct batadv_tp_unacked *un, *safe;
+	struct batadv_tp_unacked *un;
+	struct batadv_tp_unacked *safe;
 	u32 to_ack;
 
 	/* go through the unacked packet list and possibly ACK them as
diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 47e20b440dea2..4fe09f6da7cc5 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -129,7 +129,9 @@ batadv_tt_hash_find(struct batadv_hashtable *hash, const u8 *addr,
 		    unsigned short vid)
 {
 	struct hlist_head *head;
-	struct batadv_tt_common_entry to_search, *tt, *tt_tmp = NULL;
+	struct batadv_tt_common_entry to_search;
+	struct batadv_tt_common_entry *tt;
+	struct batadv_tt_common_entry *tt_tmp = NULL;
 	u32 index;
 
 	if (!hash)
@@ -421,10 +423,13 @@ static void batadv_tt_local_event(struct batadv_priv *bat_priv,
 				  struct batadv_tt_local_entry *tt_local_entry,
 				  u8 event_flags)
 {
-	struct batadv_tt_change_node *tt_change_node, *entry, *safe;
+	struct batadv_tt_change_node *tt_change_node;
+	struct batadv_tt_change_node *entry;
+	struct batadv_tt_change_node *safe;
 	struct batadv_tt_common_entry *common = &tt_local_entry->common;
 	u8 flags = common->flags | event_flags;
-	bool del_op_requested, del_op_entry;
+	bool del_op_requested;
+	bool del_op_entry;
 	size_t changes;
 
 	tt_change_node = kmem_cache_alloc(batadv_tt_change_cache, GFP_ATOMIC);
@@ -616,7 +621,9 @@ bool batadv_tt_local_add(struct net_device *mesh_iface, const u8 *addr,
 	struct net_device *in_dev = NULL;
 	struct hlist_head *head;
 	struct batadv_tt_orig_list_entry *orig_entry;
-	int hash_added, table_size, packet_size_max;
+	int hash_added;
+	int table_size;
+	int packet_size_max;
 	bool ret = false;
 	bool roamed_back = false;
 	bool iif_is_wifi = false;
@@ -1002,10 +1009,12 @@ batadv_tt_prepare_tvlv_local_data(struct batadv_priv *bat_priv,
  */
 static void batadv_tt_tvlv_container_update(struct batadv_priv *bat_priv)
 {
-	struct batadv_tt_change_node *entry, *safe;
+	struct batadv_tt_change_node *entry;
+	struct batadv_tt_change_node *safe;
 	struct batadv_tvlv_tt_data *tt_data;
 	struct batadv_tvlv_tt_change *tt_change;
-	int tt_diff_len, tt_change_len = 0;
+	int tt_diff_len;
+	int tt_change_len = 0;
 	int tt_diff_entries_num = 0;
 	int tt_diff_entries_count = 0;
 	bool drop_changes = false;
@@ -1285,7 +1294,8 @@ u16 batadv_tt_local_remove(struct batadv_priv *bat_priv, const u8 *addr,
 {
 	struct batadv_tt_local_entry *tt_removed_entry;
 	struct batadv_tt_local_entry *tt_local_entry;
-	u16 flags, curr_flags = BATADV_NO_FLAGS;
+	u16 flags;
+	u16 curr_flags = BATADV_NO_FLAGS;
 	struct hlist_node *tt_removed_node;
 
 	tt_local_entry = batadv_tt_local_hash_find(bat_priv, addr, vid);
@@ -1468,7 +1478,8 @@ static int batadv_tt_global_init(struct batadv_priv *bat_priv)
  */
 static void batadv_tt_changes_list_free(struct batadv_priv *bat_priv)
 {
-	struct batadv_tt_change_node *entry, *safe;
+	struct batadv_tt_change_node *entry;
+	struct batadv_tt_change_node *safe;
 
 	spin_lock_bh(&bat_priv->tt.changes_list_lock);
 
@@ -1497,7 +1508,8 @@ static struct batadv_tt_orig_list_entry *
 batadv_tt_global_orig_entry_find(const struct batadv_tt_global_entry *entry,
 				 const struct batadv_orig_node *orig_node)
 {
-	struct batadv_tt_orig_list_entry *tmp_orig_entry, *orig_entry = NULL;
+	struct batadv_tt_orig_list_entry *tmp_orig_entry;
+	struct batadv_tt_orig_list_entry *orig_entry = NULL;
 	const struct hlist_head *head;
 
 	rcu_read_lock();
@@ -1809,10 +1821,12 @@ static struct batadv_tt_orig_list_entry *
 batadv_transtable_best_orig(struct batadv_priv *bat_priv,
 			    struct batadv_tt_global_entry *tt_global_entry)
 {
-	struct batadv_neigh_node *router, *best_router = NULL;
+	struct batadv_neigh_node *router;
+	struct batadv_neigh_node *best_router = NULL;
 	struct batadv_algo_ops *bao = bat_priv->algo_ops;
 	struct hlist_head *head;
-	struct batadv_tt_orig_list_entry *orig_entry, *best_entry = NULL;
+	struct batadv_tt_orig_list_entry *orig_entry;
+	struct batadv_tt_orig_list_entry *best_entry = NULL;
 
 	head = &tt_global_entry->orig_list;
 	hlist_for_each_entry_rcu(orig_entry, head, list) {
@@ -1919,7 +1933,8 @@ batadv_tt_global_dump_entry(struct sk_buff *msg, u32 portid, u32 seq,
 			    struct batadv_priv *bat_priv,
 			    struct batadv_tt_common_entry *common, int *sub_s)
 {
-	struct batadv_tt_orig_list_entry *orig_entry, *best_entry;
+	struct batadv_tt_orig_list_entry *orig_entry;
+	struct batadv_tt_orig_list_entry *best_entry;
 	struct batadv_tt_global_entry *global;
 	struct hlist_head *head;
 	int sub = 0;
@@ -2536,7 +2551,9 @@ static u32 batadv_tt_global_crc(struct batadv_priv *bat_priv,
 	struct batadv_tt_common_entry *tt_common;
 	struct batadv_tt_global_entry *tt_global;
 	struct hlist_head *head;
-	u32 i, crc_tmp, crc = 0;
+	u32 i;
+	u32 crc_tmp;
+	u32 crc = 0;
 	u8 flags;
 	__be16 tmp_vid;
 
@@ -2614,7 +2631,9 @@ static u32 batadv_tt_local_crc(struct batadv_priv *bat_priv,
 	struct batadv_hashtable *hash = bat_priv->tt.local_hash;
 	struct batadv_tt_common_entry *tt_common;
 	struct hlist_head *head;
-	u32 i, crc_tmp, crc = 0;
+	u32 i;
+	u32 crc_tmp;
+	u32 crc = 0;
 	u8 flags;
 	__be16 tmp_vid;
 
@@ -2765,7 +2784,8 @@ static struct batadv_tt_req_node *
 batadv_tt_req_node_new(struct batadv_priv *bat_priv,
 		       struct batadv_orig_node *orig_node)
 {
-	struct batadv_tt_req_node *tt_req_node_tmp, *tt_req_node = NULL;
+	struct batadv_tt_req_node *tt_req_node_tmp;
+	struct batadv_tt_req_node *tt_req_node = NULL;
 
 	spin_lock_bh(&bat_priv->tt.req_list_lock);
 	hlist_for_each_entry(tt_req_node_tmp, &bat_priv->tt.req_list, list) {
@@ -2874,7 +2894,8 @@ static u16 batadv_tt_tvlv_generate(struct batadv_priv *bat_priv,
 	struct batadv_tt_common_entry *tt_common_entry;
 	struct batadv_tvlv_tt_change *tt_change;
 	struct hlist_head *head;
-	u16 tt_tot, tt_num_entries = 0;
+	u16 tt_tot;
+	u16 tt_num_entries = 0;
 	u8 flags;
 	bool ret;
 	u32 i;
@@ -2928,7 +2949,8 @@ static bool batadv_tt_global_check_crc(struct batadv_orig_node *orig_node,
 {
 	struct batadv_tvlv_tt_vlan_data *tt_vlan_tmp;
 	struct batadv_orig_node_vlan *vlan;
-	int i, orig_num_vlan;
+	int i;
+	int orig_num_vlan;
 	u32 crc;
 
 	/* check if each received CRC matches the locally stored one */
@@ -3035,7 +3057,8 @@ static bool batadv_send_tt_request(struct batadv_priv *bat_priv,
 	struct batadv_tt_req_node *tt_req_node = NULL;
 	struct batadv_hard_iface *primary_if;
 	bool ret = false;
-	int i, size;
+	int i;
+	int size;
 
 	primary_if = batadv_primary_if_get_selected(bat_priv);
 	if (!primary_if)
@@ -3115,8 +3138,10 @@ static bool batadv_send_other_tt_response(struct batadv_priv *bat_priv,
 	struct batadv_orig_node *res_dst_orig_node = NULL;
 	struct batadv_tvlv_tt_change *tt_change;
 	struct batadv_tvlv_tt_data *tvlv_tt_data = NULL;
-	bool ret = false, full_table;
-	u8 orig_ttvn, req_ttvn;
+	bool ret = false;
+	bool full_table;
+	u8 orig_ttvn;
+	u8 req_ttvn;
 	u16 tvlv_len;
 	s32 tt_len;
 
@@ -3244,7 +3269,8 @@ static bool batadv_send_my_tt_response(struct batadv_priv *bat_priv,
 	struct batadv_hard_iface *primary_if = NULL;
 	struct batadv_tvlv_tt_change *tt_change;
 	struct batadv_orig_node *orig_node;
-	u8 my_ttvn, req_ttvn;
+	u8 my_ttvn;
+	u8 req_ttvn;
 	u16 tvlv_len;
 	bool full_table;
 	s32 tt_len;
@@ -3566,7 +3592,8 @@ static void batadv_handle_tt_response(struct batadv_priv *bat_priv,
  */
 static void batadv_tt_roam_list_free(struct batadv_priv *bat_priv)
 {
-	struct batadv_tt_roam_node *node, *safe;
+	struct batadv_tt_roam_node *node;
+	struct batadv_tt_roam_node *safe;
 
 	spin_lock_bh(&bat_priv->tt.roam_list_lock);
 
@@ -3584,7 +3611,8 @@ static void batadv_tt_roam_list_free(struct batadv_priv *bat_priv)
  */
 static void batadv_tt_roam_purge(struct batadv_priv *bat_priv)
 {
-	struct batadv_tt_roam_node *node, *safe;
+	struct batadv_tt_roam_node *node;
+	struct batadv_tt_roam_node *safe;
 
 	spin_lock_bh(&bat_priv->tt.roam_list_lock);
 	list_for_each_entry_safe(node, safe, &bat_priv->tt.roam_list, list) {
@@ -4115,7 +4143,8 @@ void batadv_tt_local_resize_to_mtu(struct net_device *mesh_iface)
 {
 	struct batadv_priv *bat_priv = netdev_priv(mesh_iface);
 	int packet_size_max = READ_ONCE(bat_priv->packet_size_max);
-	int table_size, timeout = BATADV_TT_LOCAL_TIMEOUT / 2;
+	int table_size;
+	int timeout = BATADV_TT_LOCAL_TIMEOUT / 2;
 	bool reduced = false;
 
 	spin_lock_bh(&bat_priv->tt.commit_lock);
@@ -4159,7 +4188,8 @@ static void batadv_tt_tvlv_ogm_handler_v1(struct batadv_priv *bat_priv,
 {
 	struct batadv_tvlv_tt_change *tt_change;
 	struct batadv_tvlv_tt_data *tt_data;
-	u16 num_entries, num_vlan;
+	u16 num_entries;
+	u16 num_vlan;
 	size_t tt_data_sz;
 
 	if (tvlv_value_len < sizeof(*tt_data))
diff --git a/net/batman-adv/tvlv.c b/net/batman-adv/tvlv.c
index 49bf2ed9ecdc3..066468acf20d7 100644
--- a/net/batman-adv/tvlv.c
+++ b/net/batman-adv/tvlv.c
@@ -72,7 +72,8 @@ static void batadv_tvlv_handler_put(struct batadv_tvlv_handler *tvlv_handler)
 static struct batadv_tvlv_handler *
 batadv_tvlv_handler_get(struct batadv_priv *bat_priv, u8 type, u8 version)
 {
-	struct batadv_tvlv_handler *tvlv_handler_tmp, *tvlv_handler = NULL;
+	struct batadv_tvlv_handler *tvlv_handler_tmp;
+	struct batadv_tvlv_handler *tvlv_handler = NULL;
 
 	rcu_read_lock();
 	hlist_for_each_entry_rcu(tvlv_handler_tmp,
@@ -134,7 +135,8 @@ static void batadv_tvlv_container_put(struct batadv_tvlv_container *tvlv)
 static struct batadv_tvlv_container *
 batadv_tvlv_container_get(struct batadv_priv *bat_priv, u8 type, u8 version)
 {
-	struct batadv_tvlv_container *tvlv_tmp, *tvlv = NULL;
+	struct batadv_tvlv_container *tvlv_tmp;
+	struct batadv_tvlv_container *tvlv = NULL;
 
 	lockdep_assert_held(&bat_priv->tvlv.container_list_lock);
 
@@ -236,7 +238,8 @@ void batadv_tvlv_container_register(struct batadv_priv *bat_priv,
 				    u8 type, u8 version,
 				    void *tvlv_value, u16 tvlv_value_len)
 {
-	struct batadv_tvlv_container *tvlv_old, *tvlv_new;
+	struct batadv_tvlv_container *tvlv_old;
+	struct batadv_tvlv_container *tvlv_new;
 
 	if (!tvlv_value)
 		tvlv_value_len = 0;
@@ -394,7 +397,8 @@ static int batadv_tvlv_call_handler(struct batadv_priv *bat_priv,
 				    u16 tvlv_value_len)
 {
 	unsigned int tvlv_offset;
-	u8 *src, *dst;
+	u8 *src;
+	u8 *dst;
 
 	if (!tvlv_handler)
 		return NET_RX_SUCCESS;
-- 
2.47.3

