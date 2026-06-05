Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C30FCD6E5D
	for <batman-adv@archiver.kernel.org>; Fri,  5 Jun 2026 07:24:11 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id CE8D483EAA
	for <batman-adv@archiver.kernel.org>; Fri, 05 Jun 2026 09:24:09 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1780644249;
 b=SHr9ZjWIwK05sxS+hCFDU/f26ioqatETVZuatlLv22Xg15Xg7prxNZbVHFXm1mz+SfRvh
 Nb0KPUc3M0P9UO/3nLAyGHTeAheBqoYtW4le+VUjFovSN6loxZ6vyceLMc7utidVsL1a2xm
 63ykSYmUwiymJobvOHyM7gR/xXnKyG4=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1780644249; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=XayUOr0ee7YPv+5l8yPXIocEHJrmBbPJHkDKJCahM0w=;
 b=m8wMPXYU6QPrU3lUqnwfhfQKPwCqNsfnOOIMaskdSSxLoljfSYNhyvRESRxdsM0sMJwZU
 THAgma65AXT//9CrtSkMGIUGmy2rI6S4DKYDUxeiAKUgG+24X19uJsSm1W2IGPodSKA1kpv
 2bYvbRmvuGNMdRitdrS30vOlHVJYbTc=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id B4FD081096
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 05 Jun 2026 09:20:12 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1780644017;
	b=bVyDa3WZBi4XZf5X2Kbgqjalq+SRkAROkeNyb/bNAm+vsQ4CbdpqOCH0tC3Lb2KRuiOLKy
	nQchPoFU5+n38tvLg+SHPbycbLYq3TwxCu2U7cHRnXm0lU1KBQ6Kq7OnnzBkmPm5NiXKsm
	Ytph9wlXBjFm4lou6s0yHOC/cGBdaqY=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=F6OsP8ML;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 23.88.38.48 as permitted sender) smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1780644017;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=XayUOr0ee7YPv+5l8yPXIocEHJrmBbPJHkDKJCahM0w=;
	b=L9i4gTYWl4yBjcFxVVYqsPUCS6wsOngt0+pSO/V8gjq7sKLva9dA7/tuYRx3tueS1hyccv
	bPc77hTPxhvLmzT6cp5OHI4mHHVtcgabQIcEmNUY1eB9UUKN8WORXfZs21dIlEs1dTIJuE
	349mb8mWn6My1sEoqmwhhxrf/sEo9mk=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1780644011;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XayUOr0ee7YPv+5l8yPXIocEHJrmBbPJHkDKJCahM0w=;
	b=F6OsP8ML4T0t0AuyENeYKkY0QWxRdUEm6tshcPh/drduvkPek/+JyGlWxz5P9wot2zobei
	8xLnfMcj3SLLckicq4d70F0x1xuV6I13hVg5crTmf3IPxpKw/sFfW3kGKZZw5EkJ8aOxv0
	FbLANQPUa8MKxxedwyiuVlYcnB/FvGCbwnYit6FHk6oBiQvgN7/+CXu7bb3OVfD8S65L1O
	TG9XwDpqyPjpVXjnZ7hAtpAqOPs4XWMf2dC85M5bhU6KJ9JUAvR1wwZDxEsZAvia8t4EVx
	HsN7IqbAbR9DDoCRn7L8YY2GTCCqoPpmWQD4V0oB4S2S/h5d56cZ8dAL/yKDvA==
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
Subject: [PATCH net-next 02/11] batman-adv: convert cancellation of work items
 to disable helper
Date: Fri,  5 Jun 2026 09:19:56 +0200
Message-ID: <20260605072005.490368-3-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260605072005.490368-1-sw@simonwunderlich.de>
References: <20260605072005.490368-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: B4JNF7WNENNAMRAK7FCBLEMDMNUS3MGX
X-Message-ID-Hash: B4JNF7WNENNAMRAK7FCBLEMDMNUS3MGX
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/B4JNF7WNENNAMRAK7FCBLEMDMNUS3MGX/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Sven Eckelmann <sven@narfation.org>

With commit 86898fa6b8cd ("workqueue: Implement disable/enable for
(delayed) work items"), work queues gained the ability to permanently
disallow re-queuing of work items. This is particularly important during
object teardown, where a work item must not be re-armed after shutdown
begins.

Convert all cancel_work_sync() and cancel_delayed_work_sync() call sites to
their disable_* equivalents to clarify the intent to prevent re-arming
after teardown.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/bat_iv_ogm.c            | 2 +-
 net/batman-adv/bat_v.c                 | 2 ++
 net/batman-adv/bat_v_elp.c             | 6 +++---
 net/batman-adv/bat_v_ogm.c             | 6 ++++--
 net/batman-adv/bridge_loop_avoidance.c | 4 ++--
 net/batman-adv/distributed-arp-table.c | 2 +-
 net/batman-adv/multicast.c             | 2 +-
 net/batman-adv/originator.c            | 2 +-
 net/batman-adv/send.c                  | 2 +-
 net/batman-adv/tp_meter.c              | 2 +-
 net/batman-adv/translation-table.c     | 2 +-
 11 files changed, 18 insertions(+), 14 deletions(-)

diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index 6f5a468c4084c..7588e64e7ba6f 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -230,7 +230,7 @@ static void batadv_iv_ogm_iface_disable(struct batadv_hard_iface *hard_iface)
 
 	mutex_unlock(&hard_iface->bat_iv.ogm_buff_mutex);
 
-	cancel_delayed_work_sync(&hard_iface->bat_iv.reschedule_work);
+	disable_delayed_work_sync(&hard_iface->bat_iv.reschedule_work);
 }
 
 static void batadv_iv_ogm_iface_update_mac(struct batadv_hard_iface *hard_iface)
diff --git a/net/batman-adv/bat_v.c b/net/batman-adv/bat_v.c
index ac2932da5472d..cb081038d14f5 100644
--- a/net/batman-adv/bat_v.c
+++ b/net/batman-adv/bat_v.c
@@ -819,6 +819,8 @@ void batadv_v_hardif_init(struct batadv_hard_iface *hard_iface)
 	skb_queue_head_init(&hard_iface->bat_v.aggr_list);
 	INIT_DELAYED_WORK(&hard_iface->bat_v.aggr_wq,
 			  batadv_v_ogm_aggr_work);
+	/* make sure it doesn't run until interface gets enabled */
+	disable_delayed_work(&hard_iface->bat_v.aggr_wq);
 }
 
 /**
diff --git a/net/batman-adv/bat_v_elp.c b/net/batman-adv/bat_v_elp.c
index d53485d17220e..4841f0f1a9b13 100644
--- a/net/batman-adv/bat_v_elp.c
+++ b/net/batman-adv/bat_v_elp.c
@@ -115,7 +115,7 @@ static bool batadv_v_elp_get_throughput(struct batadv_hardif_neigh_node *neigh,
 			goto default_throughput;
 
 		/* only use rtnl_trylock because the elp worker will be cancelled while
-		 * the rntl_lock is held. the cancel_delayed_work_sync() would otherwise
+		 * the rntl_lock is held. the disable_delayed_work_sync() would otherwise
 		 * wait forever when the elp work_item was started and it is then also
 		 * trying to rtnl_lock
 		 */
@@ -162,7 +162,7 @@ static bool batadv_v_elp_get_throughput(struct batadv_hardif_neigh_node *neigh,
 	}
 
 	/* only use rtnl_trylock because the elp worker will be cancelled while
-	 * the rntl_lock is held. the cancel_delayed_work_sync() would otherwise
+	 * the rntl_lock is held. the disable_delayed_work_sync() would otherwise
 	 * wait forever when the elp work_item was started and it is then also
 	 * trying to rtnl_lock
 	 */
@@ -447,7 +447,7 @@ int batadv_v_elp_iface_enable(struct batadv_hard_iface *hard_iface)
  */
 void batadv_v_elp_iface_disable(struct batadv_hard_iface *hard_iface)
 {
-	cancel_delayed_work_sync(&hard_iface->bat_v.elp_wq);
+	disable_delayed_work_sync(&hard_iface->bat_v.elp_wq);
 
 	dev_kfree_skb(hard_iface->bat_v.elp_skb);
 	hard_iface->bat_v.elp_skb = NULL;
diff --git a/net/batman-adv/bat_v_ogm.c b/net/batman-adv/bat_v_ogm.c
index 5936d0048be01..72ae8ffc9db65 100644
--- a/net/batman-adv/bat_v_ogm.c
+++ b/net/batman-adv/bat_v_ogm.c
@@ -415,6 +415,8 @@ int batadv_v_ogm_iface_enable(struct batadv_hard_iface *hard_iface)
 {
 	struct batadv_priv *bat_priv = netdev_priv(hard_iface->mesh_iface);
 
+	enable_delayed_work(&hard_iface->bat_v.aggr_wq);
+
 	batadv_v_ogm_start_queue_timer(hard_iface);
 	batadv_v_ogm_start_timer(bat_priv);
 
@@ -427,7 +429,7 @@ int batadv_v_ogm_iface_enable(struct batadv_hard_iface *hard_iface)
  */
 void batadv_v_ogm_iface_disable(struct batadv_hard_iface *hard_iface)
 {
-	cancel_delayed_work_sync(&hard_iface->bat_v.aggr_wq);
+	disable_delayed_work_sync(&hard_iface->bat_v.aggr_wq);
 
 	spin_lock_bh(&hard_iface->bat_v.aggr_list.lock);
 	batadv_v_ogm_aggr_list_free(hard_iface);
@@ -1080,7 +1082,7 @@ int batadv_v_ogm_init(struct batadv_priv *bat_priv)
  */
 void batadv_v_ogm_free(struct batadv_priv *bat_priv)
 {
-	cancel_delayed_work_sync(&bat_priv->bat_v.ogm_wq);
+	disable_delayed_work_sync(&bat_priv->bat_v.ogm_wq);
 
 	mutex_lock(&bat_priv->bat_v.ogm_buff_mutex);
 
diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
index 0461f11227d06..0bd24a19ff202 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -1282,7 +1282,7 @@ static void batadv_bla_purge_backbone_gw(struct batadv_priv *bat_priv, int now)
 
 			if (purged) {
 				/* reference for pending report_work */
-				if (cancel_work_sync(&backbone_gw->report_work))
+				if (disable_work_sync(&backbone_gw->report_work))
 					batadv_backbone_gw_put(backbone_gw);
 
 				/* reference for hash_entry */
@@ -1850,7 +1850,7 @@ void batadv_bla_free(struct batadv_priv *bat_priv)
 {
 	struct batadv_hard_iface *primary_if;
 
-	cancel_delayed_work_sync(&bat_priv->bla.work);
+	disable_delayed_work_sync(&bat_priv->bla.work);
 	primary_if = batadv_primary_if_get_selected(bat_priv);
 
 	if (bat_priv->bla.claim_hash) {
diff --git a/net/batman-adv/distributed-arp-table.c b/net/batman-adv/distributed-arp-table.c
index 0b02018c5b850..aaea155b94038 100644
--- a/net/batman-adv/distributed-arp-table.c
+++ b/net/batman-adv/distributed-arp-table.c
@@ -838,7 +838,7 @@ void batadv_dat_free(struct batadv_priv *bat_priv)
 	batadv_tvlv_container_unregister(bat_priv, BATADV_TVLV_DAT, 1);
 	batadv_tvlv_handler_unregister(bat_priv, BATADV_TVLV_DAT, 1);
 
-	cancel_delayed_work_sync(&bat_priv->dat.work);
+	disable_delayed_work_sync(&bat_priv->dat.work);
 
 	batadv_dat_hash_free(bat_priv);
 }
diff --git a/net/batman-adv/multicast.c b/net/batman-adv/multicast.c
index 3274e2ac4f4a7..1c5315e55c046 100644
--- a/net/batman-adv/multicast.c
+++ b/net/batman-adv/multicast.c
@@ -2161,7 +2161,7 @@ int batadv_mcast_flags_dump(struct sk_buff *msg, struct netlink_callback *cb)
  */
 void batadv_mcast_free(struct batadv_priv *bat_priv)
 {
-	cancel_delayed_work_sync(&bat_priv->mcast.work);
+	disable_delayed_work_sync(&bat_priv->mcast.work);
 
 	batadv_tvlv_container_unregister(bat_priv, BATADV_TVLV_MCAST, 2);
 	batadv_tvlv_handler_unregister(bat_priv, BATADV_TVLV_MCAST_TRACKER, 1);
diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
index 15d660ca79376..b161232c10885 100644
--- a/net/batman-adv/originator.c
+++ b/net/batman-adv/originator.c
@@ -908,7 +908,7 @@ void batadv_originator_free(struct batadv_priv *bat_priv)
 	if (!hash)
 		return;
 
-	cancel_delayed_work_sync(&bat_priv->orig_work);
+	disable_delayed_work_sync(&bat_priv->orig_work);
 
 	bat_priv->orig_hash = NULL;
 
diff --git a/net/batman-adv/send.c b/net/batman-adv/send.c
index 5f9da3606a8f5..7f449338a4909 100644
--- a/net/batman-adv/send.c
+++ b/net/batman-adv/send.c
@@ -629,7 +629,7 @@ static void batadv_forw_packet_list_free(struct hlist_head *head)
 
 	hlist_for_each_entry_safe(forw_packet, safe_tmp_node, head,
 				  cleanup_list) {
-		cancel_delayed_work_sync(&forw_packet->delayed_work);
+		disable_delayed_work_sync(&forw_packet->delayed_work);
 
 		hlist_del(&forw_packet->cleanup_list);
 		batadv_forw_packet_free(forw_packet, true);
diff --git a/net/batman-adv/tp_meter.c b/net/batman-adv/tp_meter.c
index cc72468ca2abe..a404d70e053e2 100644
--- a/net/batman-adv/tp_meter.c
+++ b/net/batman-adv/tp_meter.c
@@ -421,7 +421,7 @@ static bool batadv_tp_list_detach(struct batadv_tp_vars_common *tp_vars)
  */
 static void batadv_tp_sender_cleanup(struct batadv_tp_sender *tp_vars)
 {
-	cancel_delayed_work_sync(&tp_vars->finish_work);
+	disable_delayed_work_sync(&tp_vars->finish_work);
 
 	if (batadv_tp_list_detach(&tp_vars->common))
 		batadv_tp_sender_put(tp_vars);
diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index c346e43d47b9b..8b6c49c32c892 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -3574,7 +3574,7 @@ void batadv_tt_free(struct batadv_priv *bat_priv)
 	batadv_tvlv_container_unregister(bat_priv, BATADV_TVLV_TT, 1);
 	batadv_tvlv_handler_unregister(bat_priv, BATADV_TVLV_TT, 1);
 
-	cancel_delayed_work_sync(&bat_priv->tt.work);
+	disable_delayed_work_sync(&bat_priv->tt.work);
 
 	batadv_tt_local_table_free(bat_priv);
 	batadv_tt_global_table_free(bat_priv);
-- 
2.47.3

