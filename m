Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0E61CD4F21
	for <batman@archiver.kernel.org>; Tue, 12 May 2026 19:55:26 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 6E0F085C16
	for <batman@archiver.kernel.org>; Tue, 12 May 2026 21:55:25 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1778615725;
 b=FQ+HS207/qiTG/K6Gn4DjrUSvf42rFOEmLnrojZdoVL/2+uw0GimvLfC9D8MvEL/cHpxl
 N0W6hiH0alriEcVIPyYQ9lM4x4Xdst2JntXQK2f9Le8MW8zVbUQOWtaBegeVQ3WO9fz+MSP
 UIpbR5IsDPNsioOhZyfgRsMh9vHYdcU=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1778615725; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=OiEjy1ezE5bg3gfjv1ETIZvyqr2/47t0YZYCV76Jsp8=;
 b=XoXmnLBymup9Wrjvf5CFORvRt8ICibxIlWhJZFDd7CN+DIYWGslj72szIdQfhDNdbM+/5
 82Dw8O2/PRV+NFKC8XL+TBUfOb7KbfY+z9c7w2NxmbEaGeIkDiPYgN3AksQz+cHJ07s7X61
 ssDMc2+D3uldGEFV2/uKVs2jZD2xVpE=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id B58D7858A4
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 12 May 2026 21:53:29 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1778615614;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=OiEjy1ezE5bg3gfjv1ETIZvyqr2/47t0YZYCV76Jsp8=;
	b=ZdnvxrvBMIdMqxUTrkd/GNQKaywK/wkYQ99vJ8vvgdsaobAkhd8RKTCZnAjOgA4h28mZMW
	puu7TZp3yOqlp37Fd8GLPw5pr15tdm5drYyhueHionIceuSIDkHBgeSdtEnpEcM0qVK3Dx
	Kcj37Ij2F4q60lDW1jjhuFvQgL8UIYU=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=j3M36Drv;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1778615614;
	b=momefaHPqBouvxcBR16ivB5LQ3OkjXRb553U3z1DxhE+owQBgttFy5YSU+2rCe2Qsdwfhz
	qXjJe+fkr9YiK6E7XV4D8fjeFEZoo5eFeStS42452ZkOSgI8U4RVoa/vKMVhRgc0RZ+iBO
	ht+d1zRyoUZpmFYoqFzaqyboX74wq90=
Received: by dvalin.narfation.org (Postfix) id E69461FE70;
	Tue, 12 May 2026 19:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1778615609;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OiEjy1ezE5bg3gfjv1ETIZvyqr2/47t0YZYCV76Jsp8=;
	b=j3M36DrvjXsYS0N4OpZEQRYhod8yDE19Ni2OFzUEwbUWRI7IGGGWFkU/3VnZ/jeJH1ei0g
	5mxkWIb9aKGDCtaZ6Y3PLX2X9EUlGeIENzwvecvCOkjcgQ0tA3ORmMk/XHITDLFsj5Sr4V
	W9oEtupfwQLnDLsS0zo2+6LIv36jKpM=
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 12 May 2026 21:53:06 +0200
Subject: [PATCH batadv 1/7] batman-adv: replace non-atomic meshif config
 fields with (READ|WRITE)_ONCE
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-atomic-to-write-once-v1-1-76a4272fac0d@narfation.org>
References: <20260512-atomic-to-write-once-v1-0-76a4272fac0d@narfation.org>
In-Reply-To: <20260512-atomic-to-write-once-v1-0-76a4272fac0d@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=36302; i=sven@narfation.org;
 h=from:subject:message-id; bh=20F0Rajrfigd7qr1oSEVG480BfBWPOc+nwwInF1TPwA=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFnMrcock5ZYPLz1MHDD7ptiyvk3t990zM2/oXbc5o/hV
 Pf78llJHaUsDGJcDLJiiix7ruSf38z+Vv7ztI9HYeawMoEMYeDiFICJLMxl+B9Vek+hIr3+++dP
 G1jmbHH2fjxt5YzjWnJyPqXMFqpfrgowMkx73uz14fKbiDkrE01ni+p8t13DaXEkIV/+ZGnXnTk
 TtvMDAA==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: ZZ6FV6AA4P4JV3Z7KV7TKIYSM5A2H7Q5
X-Message-ID-Hash: ZZ6FV6AA4P4JV3Z7KV7TKIYSM5A2H7Q5
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/ZZ6FV6AA4P4JV3Z7KV7TKIYSM5A2H7Q5/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

The meshif configuration values are only accessed as plain loads/stores and
do not require full atomic_t semantics. Convert these fields to native
integer types and replace their users with READ_ONCE()/WRITE_ONCE() to
avoid load/store tearing.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/bat_iv_ogm.c            | 24 +++++-----
 net/batman-adv/bat_v.c                 |  5 ++-
 net/batman-adv/bat_v_ogm.c             |  7 +--
 net/batman-adv/bridge_loop_avoidance.c | 14 +++---
 net/batman-adv/distributed-arp-table.c | 16 +++----
 net/batman-adv/gateway_client.c        |  6 +--
 net/batman-adv/gateway_common.c        | 14 +++---
 net/batman-adv/hard-interface.c        | 10 ++---
 net/batman-adv/log.h                   |  2 +-
 net/batman-adv/mesh-interface.c        | 28 ++++++------
 net/batman-adv/multicast.c             |  4 +-
 net/batman-adv/netlink.c               | 57 ++++++++++++------------
 net/batman-adv/originator.c            |  1 -
 net/batman-adv/routing.c               |  2 +-
 net/batman-adv/send.c                  |  2 +-
 net/batman-adv/types.h                 | 80 +++++++++++++++++-----------------
 16 files changed, 139 insertions(+), 133 deletions(-)

diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index 74ef7dc2..06cecc32 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -13,6 +13,7 @@
 #include <linux/bug.h>
 #include <linux/byteorder/generic.h>
 #include <linux/cache.h>
+#include <linux/compiler.h>
 #include <linux/container_of.h>
 #include <linux/errno.h>
 #include <linux/etherdevice.h>
@@ -272,7 +273,7 @@ batadv_iv_ogm_emit_send_time(const struct batadv_priv *bat_priv)
 {
 	unsigned int msecs;
 
-	msecs = atomic_read(&bat_priv->orig_interval) - BATADV_JITTER;
+	msecs = READ_ONCE(bat_priv->orig_interval) - BATADV_JITTER;
 	msecs += get_random_u32_below(2 * BATADV_JITTER);
 
 	return jiffies + msecs_to_jiffies(msecs);
@@ -287,7 +288,7 @@ static unsigned long batadv_iv_ogm_fwd_send_time(void)
 /* apply hop penalty for a normal link */
 static u8 batadv_hop_penalty(u8 tq, const struct batadv_priv *bat_priv)
 {
-	int hop_penalty = atomic_read(&bat_priv->hop_penalty);
+	int hop_penalty = READ_ONCE(bat_priv->hop_penalty);
 	int new_tq;
 
 	new_tq = tq * (BATADV_TQ_MAX_VALUE - hop_penalty);
@@ -551,7 +552,7 @@ static void batadv_iv_ogm_aggregate_new(const unsigned char *packet_buff,
 	unsigned int skb_size;
 	atomic_t *queue_left = own_packet ? NULL : &bat_priv->batman_queue_left;
 
-	if (atomic_read(&bat_priv->aggregated_ogms))
+	if (READ_ONCE(bat_priv->aggregated_ogms))
 		skb_size = max_t(unsigned int, BATADV_MAX_AGGREGATION_BYTES,
 				 packet_len);
 	else
@@ -633,6 +634,7 @@ static void batadv_iv_ogm_queue_add(struct batadv_priv *bat_priv,
 	struct batadv_ogm_packet *batadv_ogm_packet;
 	bool direct_link;
 	unsigned long max_aggregation_jiffies;
+	bool aggregated_ogms;
 
 	batadv_ogm_packet = (struct batadv_ogm_packet *)packet_buff;
 	direct_link = !!(batadv_ogm_packet->flags & BATADV_DIRECTLINK);
@@ -640,8 +642,10 @@ static void batadv_iv_ogm_queue_add(struct batadv_priv *bat_priv,
 
 	/* find position for the packet in the forward queue */
 	spin_lock_bh(&bat_priv->forw_bat_list_lock);
+	aggregated_ogms = READ_ONCE(bat_priv->aggregated_ogms);
+
 	/* own packets are not to be aggregated */
-	if (atomic_read(&bat_priv->aggregated_ogms) && !own_packet) {
+	if (aggregated_ogms && !own_packet) {
 		hlist_for_each_entry(forw_packet_pos,
 				     &bat_priv->forw_bat_list, list) {
 			if (batadv_iv_ogm_can_aggregate(batadv_ogm_packet,
@@ -667,7 +671,7 @@ static void batadv_iv_ogm_queue_add(struct batadv_priv *bat_priv,
 		 * we hold it back for a while, so that it might be aggregated
 		 * later on
 		 */
-		if (!own_packet && atomic_read(&bat_priv->aggregated_ogms))
+		if (!own_packet && aggregated_ogms)
 			send_time += max_aggregation_jiffies;
 
 		batadv_iv_ogm_aggregate_new(packet_buff, packet_len,
@@ -2273,7 +2277,7 @@ static void batadv_iv_iface_enabled(struct batadv_hard_iface *hard_iface)
 static void batadv_iv_init_sel_class(struct batadv_priv *bat_priv)
 {
 	/* set default TQ difference threshold to 20 */
-	atomic_set(&bat_priv->gw.sel_class, 20);
+	WRITE_ONCE(bat_priv->gw.sel_class, 20);
 }
 
 static struct batadv_gw_node *
@@ -2305,7 +2309,7 @@ batadv_iv_gw_get_best_gw_node(struct batadv_priv *bat_priv)
 
 		tq_avg = router_ifinfo->bat_iv.tq_avg;
 
-		switch (atomic_read(&bat_priv->gw.sel_class)) {
+		switch (READ_ONCE(bat_priv->gw.sel_class)) {
 		case 1: /* fast connection */
 			tmp_gw_factor = tq_avg * tq_avg;
 			tmp_gw_factor *= gw_node->bandwidth_down;
@@ -2359,13 +2363,14 @@ static bool batadv_iv_gw_is_eligible(struct batadv_priv *bat_priv,
 {
 	struct batadv_neigh_ifinfo *router_orig_ifinfo = NULL;
 	struct batadv_neigh_ifinfo *router_gw_ifinfo = NULL;
+	u32 sel_class = READ_ONCE(bat_priv->gw.sel_class);
 	struct batadv_neigh_node *router_gw = NULL;
 	struct batadv_neigh_node *router_orig = NULL;
 	u8 gw_tq_avg, orig_tq_avg;
 	bool ret = false;
 
 	/* dynamic re-election is performed only on fast or late switch */
-	if (atomic_read(&bat_priv->gw.sel_class) <= 2)
+	if (sel_class <= 2)
 		return false;
 
 	router_gw = batadv_orig_router_get(curr_gw_orig, BATADV_IF_DEFAULT);
@@ -2400,8 +2405,7 @@ static bool batadv_iv_gw_is_eligible(struct batadv_priv *bat_priv,
 	/* if the routing class is greater than 3 the value tells us how much
 	 * greater the TQ value of the new gateway must be
 	 */
-	if ((atomic_read(&bat_priv->gw.sel_class) > 3) &&
-	    (orig_tq_avg - gw_tq_avg < atomic_read(&bat_priv->gw.sel_class)))
+	if (sel_class > 3 && orig_tq_avg - gw_tq_avg < sel_class)
 		goto out;
 
 	batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
diff --git a/net/batman-adv/bat_v.c b/net/batman-adv/bat_v.c
index de944471..492058a8 100644
--- a/net/batman-adv/bat_v.c
+++ b/net/batman-adv/bat_v.c
@@ -9,6 +9,7 @@
 
 #include <linux/atomic.h>
 #include <linux/cache.h>
+#include <linux/compiler.h>
 #include <linux/errno.h>
 #include <linux/if_ether.h>
 #include <linux/init.h>
@@ -505,7 +506,7 @@ static bool batadv_v_neigh_is_sob(struct batadv_neigh_node *neigh1,
 static void batadv_v_init_sel_class(struct batadv_priv *bat_priv)
 {
 	/* set default throughput difference threshold to 5Mbps */
-	atomic_set(&bat_priv->gw.sel_class, 50);
+	WRITE_ONCE(bat_priv->gw.sel_class, 50);
 }
 
 /**
@@ -602,7 +603,7 @@ static bool batadv_v_gw_is_eligible(struct batadv_priv *bat_priv,
 	u32 gw_throughput, orig_throughput, threshold;
 	bool ret = false;
 
-	threshold = atomic_read(&bat_priv->gw.sel_class);
+	threshold = READ_ONCE(bat_priv->gw.sel_class);
 
 	curr_gw = batadv_gw_node_get(bat_priv, curr_gw_orig);
 	if (!curr_gw) {
diff --git a/net/batman-adv/bat_v_ogm.c b/net/batman-adv/bat_v_ogm.c
index 9914346a..4c637e00 100644
--- a/net/batman-adv/bat_v_ogm.c
+++ b/net/batman-adv/bat_v_ogm.c
@@ -10,6 +10,7 @@
 #include <linux/atomic.h>
 #include <linux/bug.h>
 #include <linux/byteorder/generic.h>
+#include <linux/compiler.h>
 #include <linux/container_of.h>
 #include <linux/errno.h>
 #include <linux/etherdevice.h>
@@ -106,7 +107,7 @@ static void batadv_v_ogm_start_timer(struct batadv_priv *bat_priv)
 	if (delayed_work_pending(&bat_priv->bat_v.ogm_wq))
 		return;
 
-	msecs = atomic_read(&bat_priv->orig_interval) - BATADV_JITTER;
+	msecs = READ_ONCE(bat_priv->orig_interval) - BATADV_JITTER;
 	msecs += get_random_u32_below(2 * BATADV_JITTER);
 	queue_delayed_work(batadv_event_workqueue, &bat_priv->bat_v.ogm_wq,
 			   msecs_to_jiffies(msecs));
@@ -240,7 +241,7 @@ static void batadv_v_ogm_queue_on_if(struct sk_buff *skb,
 {
 	struct batadv_priv *bat_priv = netdev_priv(hard_iface->mesh_iface);
 
-	if (!atomic_read(&bat_priv->aggregated_ogms)) {
+	if (!READ_ONCE(bat_priv->aggregated_ogms)) {
 		batadv_v_ogm_send_to_if(skb, hard_iface);
 		return;
 	}
@@ -475,7 +476,7 @@ static u32 batadv_v_forward_penalty(struct batadv_priv *bat_priv,
 				    u32 throughput)
 {
 	int if_hop_penalty = atomic_read(&if_incoming->hop_penalty);
-	int hop_penalty = atomic_read(&bat_priv->hop_penalty);
+	int hop_penalty = READ_ONCE(bat_priv->hop_penalty);
 	int hop_penalty_max = BATADV_TQ_MAX_VALUE;
 
 	/* Apply per hardif hop penalty */
diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
index cec11f12..675514af 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -1349,7 +1349,7 @@ void batadv_bla_update_orig_address(struct batadv_priv *bat_priv,
 	bat_priv->bla.claim_dest.group = group;
 
 	/* purge everything when bridge loop avoidance is turned off */
-	if (!atomic_read(&bat_priv->bridge_loop_avoidance))
+	if (!READ_ONCE(bat_priv->bridge_loop_avoidance))
 		oldif = NULL;
 
 	if (!oldif) {
@@ -1453,7 +1453,7 @@ static void batadv_bla_periodic_work(struct work_struct *work)
 	batadv_bla_purge_claims(bat_priv, primary_if, 0);
 	batadv_bla_purge_backbone_gw(bat_priv, 0);
 
-	if (!atomic_read(&bat_priv->bridge_loop_avoidance))
+	if (!READ_ONCE(bat_priv->bridge_loop_avoidance))
 		goto out;
 
 	if (atomic_dec_and_test(&bat_priv->bla.loopdetect_next)) {
@@ -1745,7 +1745,7 @@ bool batadv_bla_is_backbone_gw_orig(struct batadv_priv *bat_priv, u8 *orig,
 	struct batadv_bla_backbone_gw *backbone_gw;
 	int i;
 
-	if (!atomic_read(&bat_priv->bridge_loop_avoidance))
+	if (!READ_ONCE(bat_priv->bridge_loop_avoidance))
 		return false;
 
 	if (!hash)
@@ -1783,7 +1783,7 @@ bool batadv_bla_is_backbone_gw(struct sk_buff *skb,
 	struct batadv_bla_backbone_gw *backbone_gw;
 	unsigned short vid;
 
-	if (!atomic_read(&orig_node->bat_priv->bridge_loop_avoidance))
+	if (!READ_ONCE(orig_node->bat_priv->bridge_loop_avoidance))
 		return false;
 
 	/* first, find out the vid. */
@@ -1915,7 +1915,7 @@ bool batadv_bla_rx(struct batadv_priv *bat_priv, struct sk_buff *skb,
 	if (!primary_if)
 		goto handled;
 
-	if (!atomic_read(&bat_priv->bridge_loop_avoidance))
+	if (!READ_ONCE(bat_priv->bridge_loop_avoidance))
 		goto allow;
 
 	if (batadv_bla_loopdetect_check(bat_priv, skb, primary_if, vid))
@@ -2047,7 +2047,7 @@ bool batadv_bla_tx(struct batadv_priv *bat_priv, struct sk_buff *skb,
 	if (!primary_if)
 		goto out;
 
-	if (!atomic_read(&bat_priv->bridge_loop_avoidance))
+	if (!READ_ONCE(bat_priv->bridge_loop_avoidance))
 		goto allow;
 
 	if (batadv_bla_process_claim(bat_priv, primary_if, skb))
@@ -2467,7 +2467,7 @@ bool batadv_bla_check_claim(struct batadv_priv *bat_priv,
 	struct batadv_hard_iface *primary_if = NULL;
 	bool ret = true;
 
-	if (!atomic_read(&bat_priv->bridge_loop_avoidance))
+	if (!READ_ONCE(bat_priv->bridge_loop_avoidance))
 		return ret;
 
 	primary_if = batadv_primary_if_get_selected(bat_priv);
diff --git a/net/batman-adv/distributed-arp-table.c b/net/batman-adv/distributed-arp-table.c
index 3efc4cf5..f8fcb38d 100644
--- a/net/batman-adv/distributed-arp-table.c
+++ b/net/batman-adv/distributed-arp-table.c
@@ -739,7 +739,7 @@ static void batadv_dat_tvlv_container_update(struct batadv_priv *bat_priv)
 {
 	char dat_mode;
 
-	dat_mode = atomic_read(&bat_priv->distributed_arp_table);
+	dat_mode = READ_ONCE(bat_priv->distributed_arp_table);
 
 	switch (dat_mode) {
 	case 0:
@@ -1135,7 +1135,7 @@ bool batadv_dat_snoop_outgoing_arp_request(struct batadv_priv *bat_priv,
 	int hdr_size = 0;
 	unsigned short vid;
 
-	if (!atomic_read(&bat_priv->distributed_arp_table))
+	if (!READ_ONCE(bat_priv->distributed_arp_table))
 		goto out;
 
 	vid = batadv_dat_get_vid(skb, &hdr_size);
@@ -1230,7 +1230,7 @@ bool batadv_dat_snoop_incoming_arp_request(struct batadv_priv *bat_priv,
 	unsigned short vid;
 	int err;
 
-	if (!atomic_read(&bat_priv->distributed_arp_table))
+	if (!READ_ONCE(bat_priv->distributed_arp_table))
 		goto out;
 
 	vid = batadv_dat_get_vid(skb, &hdr_size);
@@ -1292,7 +1292,7 @@ void batadv_dat_snoop_outgoing_arp_reply(struct batadv_priv *bat_priv,
 	int hdr_size = 0;
 	unsigned short vid;
 
-	if (!atomic_read(&bat_priv->distributed_arp_table))
+	if (!READ_ONCE(bat_priv->distributed_arp_table))
 		return;
 
 	vid = batadv_dat_get_vid(skb, &hdr_size);
@@ -1340,7 +1340,7 @@ bool batadv_dat_snoop_incoming_arp_reply(struct batadv_priv *bat_priv,
 	bool dropped = false;
 	unsigned short vid;
 
-	if (!atomic_read(&bat_priv->distributed_arp_table))
+	if (!READ_ONCE(bat_priv->distributed_arp_table))
 		goto out;
 
 	vid = batadv_dat_get_vid(skb, &hdr_size);
@@ -1710,7 +1710,7 @@ void batadv_dat_snoop_outgoing_dhcp_ack(struct batadv_priv *bat_priv,
 	u8 chaddr[BATADV_DHCP_CHADDR_LEN];
 	__be32 ip_src, yiaddr;
 
-	if (!atomic_read(&bat_priv->distributed_arp_table))
+	if (!READ_ONCE(bat_priv->distributed_arp_table))
 		return;
 
 	if (!batadv_dat_check_dhcp_ack(skb, proto, &ip_src, chaddr, &yiaddr))
@@ -1740,7 +1740,7 @@ void batadv_dat_snoop_incoming_dhcp_ack(struct batadv_priv *bat_priv,
 	__be16 proto;
 	u8 *hw_src;
 
-	if (!atomic_read(&bat_priv->distributed_arp_table))
+	if (!READ_ONCE(bat_priv->distributed_arp_table))
 		return;
 
 	if (unlikely(!pskb_may_pull(skb, hdr_size + ETH_HLEN)))
@@ -1785,7 +1785,7 @@ bool batadv_dat_drop_broadcast_packet(struct batadv_priv *bat_priv,
 	int hdr_size = sizeof(struct batadv_bcast_packet);
 	unsigned short vid;
 
-	if (!atomic_read(&bat_priv->distributed_arp_table))
+	if (!READ_ONCE(bat_priv->distributed_arp_table))
 		goto out;
 
 	/* If this packet is an ARP_REQUEST and the node already has the
diff --git a/net/batman-adv/gateway_client.c b/net/batman-adv/gateway_client.c
index a4ab3d44..0beed9ae 100644
--- a/net/batman-adv/gateway_client.c
+++ b/net/batman-adv/gateway_client.c
@@ -171,7 +171,7 @@ void batadv_gw_check_client_stop(struct batadv_priv *bat_priv)
 {
 	struct batadv_gw_node *curr_gw;
 
-	if (atomic_read(&bat_priv->gw.mode) != BATADV_GW_MODE_CLIENT)
+	if (READ_ONCE(bat_priv->gw.mode) != BATADV_GW_MODE_CLIENT)
 		return;
 
 	curr_gw = batadv_gw_get_selected_gw_node(bat_priv);
@@ -203,7 +203,7 @@ void batadv_gw_election(struct batadv_priv *bat_priv)
 	struct batadv_neigh_ifinfo *router_ifinfo = NULL;
 	char gw_addr[18] = { '\0' };
 
-	if (atomic_read(&bat_priv->gw.mode) != BATADV_GW_MODE_CLIENT)
+	if (READ_ONCE(bat_priv->gw.mode) != BATADV_GW_MODE_CLIENT)
 		goto out;
 
 	if (!bat_priv->algo_ops->gw.get_best_gw_node)
@@ -699,7 +699,7 @@ bool batadv_gw_out_of_range(struct batadv_priv *bat_priv,
 	if (!gw_node)
 		goto out;
 
-	switch (atomic_read(&bat_priv->gw.mode)) {
+	switch (READ_ONCE(bat_priv->gw.mode)) {
 	case BATADV_GW_MODE_SERVER:
 		/* If we are a GW then we are our best GW. We can artificially
 		 * set the tq towards ourself as the maximum value
diff --git a/net/batman-adv/gateway_common.c b/net/batman-adv/gateway_common.c
index 315fa90f..675ebf09 100644
--- a/net/batman-adv/gateway_common.c
+++ b/net/batman-adv/gateway_common.c
@@ -7,8 +7,8 @@
 #include "gateway_common.h"
 #include "main.h"
 
-#include <linux/atomic.h>
 #include <linux/byteorder/generic.h>
+#include <linux/compiler.h>
 #include <linux/stddef.h>
 #include <linux/types.h>
 #include <uapi/linux/batadv_packet.h>
@@ -25,10 +25,10 @@
 void batadv_gw_tvlv_container_update(struct batadv_priv *bat_priv)
 {
 	struct batadv_tvlv_gateway_data gw;
+	enum batadv_gw_modes gw_mode;
 	u32 down, up;
-	char gw_mode;
 
-	gw_mode = atomic_read(&bat_priv->gw.mode);
+	gw_mode = READ_ONCE(bat_priv->gw.mode);
 
 	switch (gw_mode) {
 	case BATADV_GW_MODE_OFF:
@@ -36,8 +36,8 @@ void batadv_gw_tvlv_container_update(struct batadv_priv *bat_priv)
 		batadv_tvlv_container_unregister(bat_priv, BATADV_TVLV_GW, 1);
 		break;
 	case BATADV_GW_MODE_SERVER:
-		down = atomic_read(&bat_priv->gw.bandwidth_down);
-		up = atomic_read(&bat_priv->gw.bandwidth_up);
+		down = READ_ONCE(bat_priv->gw.bandwidth_down);
+		up = READ_ONCE(bat_priv->gw.bandwidth_up);
 		gw.bandwidth_down = htonl(down);
 		gw.bandwidth_up = htonl(up);
 		batadv_tvlv_container_register(bat_priv, BATADV_TVLV_GW, 1,
@@ -83,7 +83,7 @@ static void batadv_gw_tvlv_ogm_handler_v1(struct batadv_priv *bat_priv,
 
 	/* restart gateway selection */
 	if (gateway.bandwidth_down != 0 &&
-	    atomic_read(&bat_priv->gw.mode) == BATADV_GW_MODE_CLIENT)
+	    READ_ONCE(bat_priv->gw.mode) == BATADV_GW_MODE_CLIENT)
 		batadv_gw_check_election(bat_priv, orig);
 }
 
@@ -96,7 +96,7 @@ void batadv_gw_init(struct batadv_priv *bat_priv)
 	if (bat_priv->algo_ops->gw.init_sel_class)
 		bat_priv->algo_ops->gw.init_sel_class(bat_priv);
 	else
-		atomic_set(&bat_priv->gw.sel_class, 1);
+		WRITE_ONCE(bat_priv->gw.sel_class, 1);
 
 	batadv_tvlv_handler_register(bat_priv, batadv_gw_tvlv_ogm_handler_v1,
 				     NULL, NULL, BATADV_TVLV_GW, 1,
diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index 4b3804ef..389be6f8 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -595,7 +595,7 @@ int batadv_hardif_min_mtu(struct net_device *mesh_iface)
 	}
 	rcu_read_unlock();
 
-	if (atomic_read(&bat_priv->fragmentation) == 0)
+	if (READ_ONCE(bat_priv->fragmentation) == 0)
 		goto out;
 
 	/* with fragmentation enabled the maximum size of internally generated
@@ -710,6 +710,7 @@ int batadv_hardif_enable_interface(struct batadv_hard_iface *hard_iface,
 	int max_header_len = batadv_max_header_len();
 	unsigned int required_mtu;
 	unsigned int hardif_mtu;
+	bool fragmentation;
 	int ret;
 
 	hardif_mtu = READ_ONCE(hard_iface->net_dev->mtu);
@@ -747,15 +748,14 @@ int batadv_hardif_enable_interface(struct batadv_hard_iface *hard_iface,
 	batadv_info(hard_iface->mesh_iface, "Adding interface: %s\n",
 		    hard_iface->net_dev->name);
 
-	if (atomic_read(&bat_priv->fragmentation) &&
-	    hardif_mtu < required_mtu)
+	fragmentation = READ_ONCE(bat_priv->fragmentation);
+	if (fragmentation && hardif_mtu < required_mtu)
 		batadv_info(hard_iface->mesh_iface,
 			    "The MTU of interface %s is too small (%i) to handle the transport of batman-adv packets. Packets going over this interface will be fragmented on layer2 which could impact the performance. Setting the MTU to %i would solve the problem.\n",
 			    hard_iface->net_dev->name, hardif_mtu,
 			    required_mtu);
 
-	if (!atomic_read(&bat_priv->fragmentation) &&
-	    hardif_mtu < required_mtu)
+	if (!fragmentation && hardif_mtu < required_mtu)
 		batadv_info(hard_iface->mesh_iface,
 			    "The MTU of interface %s is too small (%i) to handle the transport of batman-adv packets. If you experience problems getting traffic through try increasing the MTU to %i.\n",
 			    hard_iface->net_dev->name, hardif_mtu,
diff --git a/net/batman-adv/log.h b/net/batman-adv/log.h
index 225b747a..a0d2b0d6 100644
--- a/net/batman-adv/log.h
+++ b/net/batman-adv/log.h
@@ -76,7 +76,7 @@ __printf(2, 3);
 #define _batadv_dbg(type, bat_priv, ratelimited, fmt, arg...)		\
 	do {								\
 		struct batadv_priv *__batpriv = (bat_priv);		\
-		if (atomic_read(&__batpriv->log_level) & (type) &&	\
+		if (READ_ONCE(__batpriv->log_level) & (type) &&	\
 		    (!(ratelimited) || net_ratelimit()))		\
 			batadv_debug_log(__batpriv, fmt, ## arg);	\
 	}								\
diff --git a/net/batman-adv/mesh-interface.c b/net/batman-adv/mesh-interface.c
index 50c26037..d1f50b8b 100644
--- a/net/batman-adv/mesh-interface.c
+++ b/net/batman-adv/mesh-interface.c
@@ -255,7 +255,7 @@ static netdev_tx_t batadv_interface_tx(struct sk_buff *skb,
 	if (batadv_compare_eth(ethhdr->h_dest, ectp_addr))
 		goto dropped;
 
-	gw_mode = atomic_read(&bat_priv->gw.mode);
+	gw_mode = READ_ONCE(bat_priv->gw.mode);
 	if (is_multicast_ether_addr(ethhdr->h_dest)) {
 		/* if gw mode is off, broadcast every packet */
 		if (gw_mode == BATADV_GW_MODE_OFF) {
@@ -752,31 +752,31 @@ static int batadv_meshif_init_late(struct net_device *dev)
 	if (!bat_priv->bat_counters)
 		return -ENOMEM;
 
-	atomic_set(&bat_priv->aggregated_ogms, 1);
-	atomic_set(&bat_priv->bonding, 0);
+	WRITE_ONCE(bat_priv->aggregated_ogms, 1);
+	WRITE_ONCE(bat_priv->bonding, 0);
 #ifdef CONFIG_BATMAN_ADV_BLA
-	atomic_set(&bat_priv->bridge_loop_avoidance, 1);
+	WRITE_ONCE(bat_priv->bridge_loop_avoidance, 1);
 #endif
 #ifdef CONFIG_BATMAN_ADV_DAT
-	atomic_set(&bat_priv->distributed_arp_table, 1);
+	WRITE_ONCE(bat_priv->distributed_arp_table, 1);
 #endif
 #ifdef CONFIG_BATMAN_ADV_MCAST
-	atomic_set(&bat_priv->multicast_mode, 1);
-	atomic_set(&bat_priv->multicast_fanout, 16);
+	WRITE_ONCE(bat_priv->multicast_mode, 1);
+	WRITE_ONCE(bat_priv->multicast_fanout, 16);
 	atomic_set(&bat_priv->mcast.num_want_all_unsnoopables, 0);
 	atomic_set(&bat_priv->mcast.num_want_all_ipv4, 0);
 	atomic_set(&bat_priv->mcast.num_want_all_ipv6, 0);
 	atomic_set(&bat_priv->mcast.num_no_mc_ptype_capa, 0);
 #endif
-	atomic_set(&bat_priv->gw.mode, BATADV_GW_MODE_OFF);
-	atomic_set(&bat_priv->gw.bandwidth_down, 100);
-	atomic_set(&bat_priv->gw.bandwidth_up, 20);
-	atomic_set(&bat_priv->orig_interval, 1000);
-	atomic_set(&bat_priv->hop_penalty, 30);
+	WRITE_ONCE(bat_priv->gw.mode, BATADV_GW_MODE_OFF);
+	WRITE_ONCE(bat_priv->gw.bandwidth_down, 100);
+	WRITE_ONCE(bat_priv->gw.bandwidth_up, 20);
+	WRITE_ONCE(bat_priv->orig_interval, 1000);
+	WRITE_ONCE(bat_priv->hop_penalty, 30);
 #ifdef CONFIG_BATMAN_ADV_DEBUG
-	atomic_set(&bat_priv->log_level, 0);
+	WRITE_ONCE(bat_priv->log_level, 0);
 #endif
-	atomic_set(&bat_priv->fragmentation, 1);
+	WRITE_ONCE(bat_priv->fragmentation, 1);
 	atomic_set(&bat_priv->packet_size_max, BATADV_MAX_MTU);
 	atomic_set(&bat_priv->bcast_queue_left, BATADV_BCAST_QUEUE_LEN);
 	atomic_set(&bat_priv->batman_queue_left, BATADV_BATMAN_QUEUE_LEN);
diff --git a/net/batman-adv/multicast.c b/net/batman-adv/multicast.c
index 7dba0c2b..942439ba 100644
--- a/net/batman-adv/multicast.c
+++ b/net/batman-adv/multicast.c
@@ -1106,7 +1106,7 @@ static int batadv_mcast_forw_mode_check(struct batadv_priv *bat_priv,
 {
 	struct ethhdr *ethhdr = eth_hdr(skb);
 
-	if (!atomic_read(&bat_priv->multicast_mode))
+	if (!READ_ONCE(bat_priv->multicast_mode))
 		return -EINVAL;
 
 	switch (ntohs(ethhdr->h_proto)) {
@@ -1211,7 +1211,7 @@ batadv_mcast_forw_mode_by_count(struct batadv_priv *bat_priv,
 	    batadv_mcast_forw_push(bat_priv, skb, vid, is_routable, count))
 		return BATADV_FORW_MCAST;
 
-	if (count <= atomic_read(&bat_priv->multicast_fanout))
+	if (count <= READ_ONCE(bat_priv->multicast_fanout))
 		return BATADV_FORW_UCASTS;
 
 	return BATADV_FORW_BCAST;
diff --git a/net/batman-adv/netlink.c b/net/batman-adv/netlink.c
index e52f44e7..dcf06536 100644
--- a/net/batman-adv/netlink.c
+++ b/net/batman-adv/netlink.c
@@ -13,6 +13,7 @@
 #include <linux/bug.h>
 #include <linux/byteorder/generic.h>
 #include <linux/cache.h>
+#include <linux/compiler.h>
 #include <linux/err.h>
 #include <linux/errno.h>
 #include <linux/gfp.h>
@@ -267,7 +268,7 @@ static int batadv_netlink_mesh_fill(struct sk_buff *msg,
 	}
 
 	if (nla_put_u8(msg, BATADV_ATTR_AGGREGATED_OGMS_ENABLED,
-		       !!atomic_read(&bat_priv->aggregated_ogms)))
+		       !!READ_ONCE(bat_priv->aggregated_ogms)))
 		goto nla_put_failure;
 
 	if (batadv_netlink_mesh_fill_ap_isolation(msg, bat_priv))
@@ -282,35 +283,35 @@ static int batadv_netlink_mesh_fill(struct sk_buff *msg,
 		goto nla_put_failure;
 
 	if (nla_put_u8(msg, BATADV_ATTR_BONDING_ENABLED,
-		       !!atomic_read(&bat_priv->bonding)))
+		       !!READ_ONCE(bat_priv->bonding)))
 		goto nla_put_failure;
 
 #ifdef CONFIG_BATMAN_ADV_BLA
 	if (nla_put_u8(msg, BATADV_ATTR_BRIDGE_LOOP_AVOIDANCE_ENABLED,
-		       !!atomic_read(&bat_priv->bridge_loop_avoidance)))
+		       !!READ_ONCE(bat_priv->bridge_loop_avoidance)))
 		goto nla_put_failure;
 #endif /* CONFIG_BATMAN_ADV_BLA */
 
 #ifdef CONFIG_BATMAN_ADV_DAT
 	if (nla_put_u8(msg, BATADV_ATTR_DISTRIBUTED_ARP_TABLE_ENABLED,
-		       !!atomic_read(&bat_priv->distributed_arp_table)))
+		       !!READ_ONCE(bat_priv->distributed_arp_table)))
 		goto nla_put_failure;
 #endif /* CONFIG_BATMAN_ADV_DAT */
 
 	if (nla_put_u8(msg, BATADV_ATTR_FRAGMENTATION_ENABLED,
-		       !!atomic_read(&bat_priv->fragmentation)))
+		       !!READ_ONCE(bat_priv->fragmentation)))
 		goto nla_put_failure;
 
 	if (nla_put_u32(msg, BATADV_ATTR_GW_BANDWIDTH_DOWN,
-			atomic_read(&bat_priv->gw.bandwidth_down)))
+			READ_ONCE(bat_priv->gw.bandwidth_down)))
 		goto nla_put_failure;
 
 	if (nla_put_u32(msg, BATADV_ATTR_GW_BANDWIDTH_UP,
-			atomic_read(&bat_priv->gw.bandwidth_up)))
+			READ_ONCE(bat_priv->gw.bandwidth_up)))
 		goto nla_put_failure;
 
 	if (nla_put_u8(msg, BATADV_ATTR_GW_MODE,
-		       atomic_read(&bat_priv->gw.mode)))
+		       READ_ONCE(bat_priv->gw.mode)))
 		goto nla_put_failure;
 
 	if (bat_priv->algo_ops->gw.get_best_gw_node &&
@@ -319,32 +320,32 @@ static int batadv_netlink_mesh_fill(struct sk_buff *msg,
 		 * in use does not implement the GW API
 		 */
 		if (nla_put_u32(msg, BATADV_ATTR_GW_SEL_CLASS,
-				atomic_read(&bat_priv->gw.sel_class)))
+				READ_ONCE(bat_priv->gw.sel_class)))
 			goto nla_put_failure;
 	}
 
 	if (nla_put_u8(msg, BATADV_ATTR_HOP_PENALTY,
-		       atomic_read(&bat_priv->hop_penalty)))
+		       READ_ONCE(bat_priv->hop_penalty)))
 		goto nla_put_failure;
 
 #ifdef CONFIG_BATMAN_ADV_DEBUG
 	if (nla_put_u32(msg, BATADV_ATTR_LOG_LEVEL,
-			atomic_read(&bat_priv->log_level)))
+			READ_ONCE(bat_priv->log_level)))
 		goto nla_put_failure;
 #endif /* CONFIG_BATMAN_ADV_DEBUG */
 
 #ifdef CONFIG_BATMAN_ADV_MCAST
 	if (nla_put_u8(msg, BATADV_ATTR_MULTICAST_FORCEFLOOD_ENABLED,
-		       !atomic_read(&bat_priv->multicast_mode)))
+		       !READ_ONCE(bat_priv->multicast_mode)))
 		goto nla_put_failure;
 
 	if (nla_put_u32(msg, BATADV_ATTR_MULTICAST_FANOUT,
-			atomic_read(&bat_priv->multicast_fanout)))
+			READ_ONCE(bat_priv->multicast_fanout)))
 		goto nla_put_failure;
 #endif /* CONFIG_BATMAN_ADV_MCAST */
 
 	if (nla_put_u32(msg, BATADV_ATTR_ORIG_INTERVAL,
-			atomic_read(&bat_priv->orig_interval)))
+			READ_ONCE(bat_priv->orig_interval)))
 		goto nla_put_failure;
 
 	batadv_hardif_put(primary_if);
@@ -432,7 +433,7 @@ static int batadv_netlink_set_mesh(struct sk_buff *skb, struct genl_info *info)
 	if (info->attrs[BATADV_ATTR_AGGREGATED_OGMS_ENABLED]) {
 		attr = info->attrs[BATADV_ATTR_AGGREGATED_OGMS_ENABLED];
 
-		atomic_set(&bat_priv->aggregated_ogms, !!nla_get_u8(attr));
+		WRITE_ONCE(bat_priv->aggregated_ogms, !!nla_get_u8(attr));
 	}
 
 	if (info->attrs[BATADV_ATTR_AP_ISOLATION_ENABLED]) {
@@ -456,14 +457,14 @@ static int batadv_netlink_set_mesh(struct sk_buff *skb, struct genl_info *info)
 	if (info->attrs[BATADV_ATTR_BONDING_ENABLED]) {
 		attr = info->attrs[BATADV_ATTR_BONDING_ENABLED];
 
-		atomic_set(&bat_priv->bonding, !!nla_get_u8(attr));
+		WRITE_ONCE(bat_priv->bonding, !!nla_get_u8(attr));
 	}
 
 #ifdef CONFIG_BATMAN_ADV_BLA
 	if (info->attrs[BATADV_ATTR_BRIDGE_LOOP_AVOIDANCE_ENABLED]) {
 		attr = info->attrs[BATADV_ATTR_BRIDGE_LOOP_AVOIDANCE_ENABLED];
 
-		atomic_set(&bat_priv->bridge_loop_avoidance,
+		WRITE_ONCE(bat_priv->bridge_loop_avoidance,
 			   !!nla_get_u8(attr));
 		batadv_bla_status_update(bat_priv->mesh_iface);
 	}
@@ -473,7 +474,7 @@ static int batadv_netlink_set_mesh(struct sk_buff *skb, struct genl_info *info)
 	if (info->attrs[BATADV_ATTR_DISTRIBUTED_ARP_TABLE_ENABLED]) {
 		attr = info->attrs[BATADV_ATTR_DISTRIBUTED_ARP_TABLE_ENABLED];
 
-		atomic_set(&bat_priv->distributed_arp_table,
+		WRITE_ONCE(bat_priv->distributed_arp_table,
 			   !!nla_get_u8(attr));
 		batadv_dat_status_update(bat_priv->mesh_iface);
 	}
@@ -482,7 +483,7 @@ static int batadv_netlink_set_mesh(struct sk_buff *skb, struct genl_info *info)
 	if (info->attrs[BATADV_ATTR_FRAGMENTATION_ENABLED]) {
 		attr = info->attrs[BATADV_ATTR_FRAGMENTATION_ENABLED];
 
-		atomic_set(&bat_priv->fragmentation, !!nla_get_u8(attr));
+		WRITE_ONCE(bat_priv->fragmentation, !!nla_get_u8(attr));
 
 		rtnl_lock();
 		batadv_update_min_mtu(bat_priv->mesh_iface);
@@ -492,14 +493,14 @@ static int batadv_netlink_set_mesh(struct sk_buff *skb, struct genl_info *info)
 	if (info->attrs[BATADV_ATTR_GW_BANDWIDTH_DOWN]) {
 		attr = info->attrs[BATADV_ATTR_GW_BANDWIDTH_DOWN];
 
-		atomic_set(&bat_priv->gw.bandwidth_down, nla_get_u32(attr));
+		WRITE_ONCE(bat_priv->gw.bandwidth_down, nla_get_u32(attr));
 		batadv_gw_tvlv_container_update(bat_priv);
 	}
 
 	if (info->attrs[BATADV_ATTR_GW_BANDWIDTH_UP]) {
 		attr = info->attrs[BATADV_ATTR_GW_BANDWIDTH_UP];
 
-		atomic_set(&bat_priv->gw.bandwidth_up, nla_get_u32(attr));
+		WRITE_ONCE(bat_priv->gw.bandwidth_up, nla_get_u32(attr));
 		batadv_gw_tvlv_container_update(bat_priv);
 	}
 
@@ -527,7 +528,7 @@ static int batadv_netlink_set_mesh(struct sk_buff *skb, struct genl_info *info)
 			 * changing the gateway state
 			 */
 			batadv_gw_check_client_stop(bat_priv);
-			atomic_set(&bat_priv->gw.mode, gw_mode);
+			WRITE_ONCE(bat_priv->gw.mode, gw_mode);
 			batadv_gw_tvlv_container_update(bat_priv);
 		}
 	}
@@ -546,7 +547,7 @@ static int batadv_netlink_set_mesh(struct sk_buff *skb, struct genl_info *info)
 		sel_class = nla_get_u32(attr);
 
 		if (sel_class >= 1 && sel_class <= sel_class_max) {
-			atomic_set(&bat_priv->gw.sel_class, sel_class);
+			WRITE_ONCE(bat_priv->gw.sel_class, sel_class);
 			batadv_gw_reselect(bat_priv);
 		}
 	}
@@ -554,14 +555,14 @@ static int batadv_netlink_set_mesh(struct sk_buff *skb, struct genl_info *info)
 	if (info->attrs[BATADV_ATTR_HOP_PENALTY]) {
 		attr = info->attrs[BATADV_ATTR_HOP_PENALTY];
 
-		atomic_set(&bat_priv->hop_penalty, nla_get_u8(attr));
+		WRITE_ONCE(bat_priv->hop_penalty, nla_get_u8(attr));
 	}
 
 #ifdef CONFIG_BATMAN_ADV_DEBUG
 	if (info->attrs[BATADV_ATTR_LOG_LEVEL]) {
 		attr = info->attrs[BATADV_ATTR_LOG_LEVEL];
 
-		atomic_set(&bat_priv->log_level,
+		WRITE_ONCE(bat_priv->log_level,
 			   nla_get_u32(attr) & BATADV_DBG_ALL);
 	}
 #endif /* CONFIG_BATMAN_ADV_DEBUG */
@@ -570,13 +571,13 @@ static int batadv_netlink_set_mesh(struct sk_buff *skb, struct genl_info *info)
 	if (info->attrs[BATADV_ATTR_MULTICAST_FORCEFLOOD_ENABLED]) {
 		attr = info->attrs[BATADV_ATTR_MULTICAST_FORCEFLOOD_ENABLED];
 
-		atomic_set(&bat_priv->multicast_mode, !nla_get_u8(attr));
+		WRITE_ONCE(bat_priv->multicast_mode, !nla_get_u8(attr));
 	}
 
 	if (info->attrs[BATADV_ATTR_MULTICAST_FANOUT]) {
 		attr = info->attrs[BATADV_ATTR_MULTICAST_FANOUT];
 
-		atomic_set(&bat_priv->multicast_fanout, nla_get_u32(attr));
+		WRITE_ONCE(bat_priv->multicast_fanout, nla_get_u32(attr));
 	}
 #endif /* CONFIG_BATMAN_ADV_MCAST */
 
@@ -589,7 +590,7 @@ static int batadv_netlink_set_mesh(struct sk_buff *skb, struct genl_info *info)
 		orig_interval = min_t(u32, orig_interval, INT_MAX);
 		orig_interval = max_t(u32, orig_interval, 2 * BATADV_JITTER);
 
-		atomic_set(&bat_priv->orig_interval, orig_interval);
+		WRITE_ONCE(bat_priv->orig_interval, orig_interval);
 	}
 
 	batadv_netlink_notify_mesh(bat_priv);
diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
index b3468cca..5a5cb277 100644
--- a/net/batman-adv/originator.c
+++ b/net/batman-adv/originator.c
@@ -7,7 +7,6 @@
 #include "originator.h"
 #include "main.h"
 
-#include <linux/atomic.h>
 #include <linux/container_of.h>
 #include <linux/err.h>
 #include <linux/errno.h>
diff --git a/net/batman-adv/routing.c b/net/batman-adv/routing.c
index 12c16f81..1dd295d9 100644
--- a/net/batman-adv/routing.c
+++ b/net/batman-adv/routing.c
@@ -543,7 +543,7 @@ batadv_find_router(struct batadv_priv *bat_priv,
 	/* only consider bonding for recv_if == BATADV_IF_DEFAULT (first hop)
 	 * and if activated.
 	 */
-	if (!(recv_if == BATADV_IF_DEFAULT && atomic_read(&bat_priv->bonding)))
+	if (!(recv_if == BATADV_IF_DEFAULT && READ_ONCE(bat_priv->bonding)))
 		return router;
 
 	/* bonding: loop through the list of possible routers found
diff --git a/net/batman-adv/send.c b/net/batman-adv/send.c
index 60cd67ec..62ae98ee 100644
--- a/net/batman-adv/send.c
+++ b/net/batman-adv/send.c
@@ -185,7 +185,7 @@ int batadv_send_skb_to_orig(struct sk_buff *skb,
 	/* Check if the skb is too large to send in one piece and fragment
 	 * it if needed.
 	 */
-	if (atomic_read(&bat_priv->fragmentation) &&
+	if (READ_ONCE(bat_priv->fragmentation) &&
 	    skb->len > neigh_node->if_incoming->net_dev->mtu) {
 		/* Fragment and send packet. */
 		ret = batadv_frag_send_packet(skb, orig_node, neigh_node);
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 739439e2..cf354f2c 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -1092,21 +1092,21 @@ struct batadv_priv_gw {
 	/**
 	 * @mode: gateway operation: off, client or server (see batadv_gw_modes)
 	 */
-	atomic_t mode;
+	enum batadv_gw_modes mode;
 
 	/** @sel_class: gateway selection class (applies if gw_mode client) */
-	atomic_t sel_class;
+	u32 sel_class;
 
 	/**
 	 * @bandwidth_down: advertised uplink download bandwidth (if gw_mode
 	 *  server)
 	 */
-	atomic_t bandwidth_down;
+	u32 bandwidth_down;
 
 	/**
 	 * @bandwidth_up: advertised uplink upload bandwidth (if gw_mode server)
 	 */
-	atomic_t bandwidth_up;
+	u32 bandwidth_up;
 
 	/** @reselect: bool indicating a gateway re-selection is in progress */
 	atomic_t reselect;
@@ -1497,16 +1497,46 @@ struct batadv_priv {
 	/**
 	 * @aggregated_ogms: bool indicating whether OGM aggregation is enabled
 	 */
-	atomic_t aggregated_ogms;
+	u8 aggregated_ogms;
 
 	/** @bonding: bool indicating whether traffic bonding is enabled */
-	atomic_t bonding;
+	u8 bonding;
 
 	/**
 	 * @fragmentation: bool indicating whether traffic fragmentation is
 	 *  enabled
 	 */
-	atomic_t fragmentation;
+	u8 fragmentation;
+
+#ifdef CONFIG_BATMAN_ADV_BLA
+	/**
+	 * @bridge_loop_avoidance: bool indicating whether bridge loop
+	 *  avoidance is enabled
+	 */
+	u8 bridge_loop_avoidance;
+#endif
+
+#ifdef CONFIG_BATMAN_ADV_DAT
+	/**
+	 * @distributed_arp_table: bool indicating whether distributed ARP table
+	 *  is enabled
+	 */
+	u8 distributed_arp_table;
+#endif
+
+#ifdef CONFIG_BATMAN_ADV_MCAST
+	/**
+	 * @multicast_mode: Enable or disable multicast optimizations on this
+	 *  node's sender/originating side
+	 */
+	u8 multicast_mode;
+
+	/**
+	 * @multicast_fanout: Maximum number of packet copies to generate for a
+	 *  multicast-to-unicast conversion
+	 */
+	u32 multicast_fanout;
+#endif
 
 	/**
 	 * @packet_size_max: max packet size that can be transmitted via
@@ -1521,48 +1551,18 @@ struct batadv_priv {
 	 */
 	atomic_t frag_seqno;
 
-#ifdef CONFIG_BATMAN_ADV_BLA
-	/**
-	 * @bridge_loop_avoidance: bool indicating whether bridge loop
-	 *  avoidance is enabled
-	 */
-	atomic_t bridge_loop_avoidance;
-#endif
-
-#ifdef CONFIG_BATMAN_ADV_DAT
-	/**
-	 * @distributed_arp_table: bool indicating whether distributed ARP table
-	 *  is enabled
-	 */
-	atomic_t distributed_arp_table;
-#endif
-
-#ifdef CONFIG_BATMAN_ADV_MCAST
-	/**
-	 * @multicast_mode: Enable or disable multicast optimizations on this
-	 *  node's sender/originating side
-	 */
-	atomic_t multicast_mode;
-
-	/**
-	 * @multicast_fanout: Maximum number of packet copies to generate for a
-	 *  multicast-to-unicast conversion
-	 */
-	atomic_t multicast_fanout;
-#endif
-
 	/** @orig_interval: OGM broadcast interval in milliseconds */
-	atomic_t orig_interval;
+	u32 orig_interval;
 
 	/**
 	 * @hop_penalty: penalty which will be applied to an OGM's tq-field on
 	 *  every hop
 	 */
-	atomic_t hop_penalty;
+	u8 hop_penalty;
 
 #ifdef CONFIG_BATMAN_ADV_DEBUG
 	/** @log_level: configured log level (see batadv_dbg_level) */
-	atomic_t log_level;
+	u32 log_level;
 #endif
 
 	/**

-- 
2.47.3

