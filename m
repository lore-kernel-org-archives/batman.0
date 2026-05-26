Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B615CD5BC8
	for <batman-adv@archiver.kernel.org>; Tue, 26 May 2026 19:46:18 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 6258683C55
	for <batman-adv@archiver.kernel.org>; Tue, 26 May 2026 21:46:16 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1779824776;
 b=AgTgC6HZFLNok5+ZhZJFhMnhvfSok9jOGINEkLm3kV9pgVep/iAzE8zr4V76TkZZcWfcK
 jySJUdYZOAFu9MiBqsyPxYhcV5k5GXuOvMHdpzk4YAvHMDITFk/FKRDqR6mzwXpy/hpIyJf
 gOBC92lOVLA3zrrGk1yk5n/X/SfITu0=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1779824776; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=lU8rbgo43HT4HSkuGbXdNCEmkvzzcZzcCV5Or4ImeYk=;
 b=wMCnLhT2tf/W+FoFYbL+5eonsiLIYQwohl89+LwOhQBMFltFhoe5G+QG0ZCw1qDoDryl4
 hDB54b9r03fcEwqyktieHPPvE15WeyxTkJufORNp/4H+LzqVQx7pIrGFfV8ymyU8hLxEcHt
 Kg2G0sDt7OWCTq0S1AFLQ22yiwWe3E4=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 931158109D
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 26 May 2026 21:45:34 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1779824744;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=lU8rbgo43HT4HSkuGbXdNCEmkvzzcZzcCV5Or4ImeYk=;
	b=rVg7mhfGHRJcCD062lR+ZOe6IUkJrkTp7V7iSKxIEaoJ3guX27ojBMDZRdkLWeGBgTnioa
	u8FOeZEzEl6yVnQW8c7N14hzgsR966n3SiP/s/fJEfFQG8jpmtgZLrtjkUBukrlfTyORE+
	7vZusxn1zvNaOuNNmpJUctLjVBHaCgo=
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1779824744;
	b=v7cHgVGtL5LqAg+BGdQrYecSxevOlIbBCqGxuWXdPwC388EM+OQhbrCAAwbcVH5IxxIgAm
	MQ8RzPDbBYrD0rWUFTMZPJwWe6Lhjk4tg8LHYLMcRvFyd6GR0NFQupeH78RmsvjUqPS90t
	AIt1gzQ5TNl/v9BKddbFnmMtUyn5tgI=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=TUBpiQPv;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 5A0631FDD5;
	Tue, 26 May 2026 19:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1779824733;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=lU8rbgo43HT4HSkuGbXdNCEmkvzzcZzcCV5Or4ImeYk=;
	b=TUBpiQPvuZGFYGXXn34/37bvqeKhgK/1WdRENGLzp9Me6f0f/WMMbWG4T1KF1ANn4wgzTv
	d6qxVxF4kpkbXwi1hPQQjWXJltk7t3zD2fw3DiUVTTyW/Htb8gly8PE/bHlhSWgIrYHC+S
	Q2IzRXl+hVUmNUAhbx3Z60sc17zOB7o=
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 26 May 2026 21:45:16 +0200
Subject: [PATCH batadv] batman-adv: convert cancellation of work items to
 disable helper
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260526-cancel-to-disable-v1-1-c9cffb8c0034@narfation.org>
X-B4-Tracking: v=1; b=H4sIAEv4FWoC/yWMQQrCMBAAv1L23IUkYlC/Ij1sklVXSirZNAilf
 zfqcQZmNlAuwgqXYYPCTVSW3MGOA8QH5TujpM7gjPPm6DxGypFnrAsmUQozo7UHMvZkKPkz9O5
 V+Cbv3/MKgSqlBtPf6xqeHOt3CPv+AVsSsQF9AAAA
X-Change-ID: 20260526-cancel-to-disable-113a0180ad69
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=9077; i=sven@narfation.org;
 h=from:subject:message-id; bh=8hWU0HFaSBMONub2u4tq44Jj3BFvsXNXsmR6sryusPA=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFmiP/zWLot12jY/7KChC+/km8mzzWXZ49r1lwp9/99gp
 j11yf2THaUsDGJcDLJiiix7ruSf38z+Vv7ztI9HYeawMoEMYeDiFICJHAhhZHh2Lttldtepdv0g
 U7NMJ/7VecfP8ys7qJ2Yb7zu9hLTr/MY/vt+PJUbdO/VJHuWoksSvv2Fv3wDU81lenmT2Jlfz57
 SxwEA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: HQYCIKNVPX67LRNAGHKO4HOSXHA5W4MA
X-Message-ID-Hash: HQYCIKNVPX67LRNAGHKO4HOSXHA5W4MA
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/HQYCIKNVPX67LRNAGHKO4HOSXHA5W4MA/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

With commit 86898fa6b8cd ("workqueue: Implement disable/enable for
(delayed) work items"), work queues gained the ability to permanently
disallow re-queuing of work items. This is particularly important during
object teardown, where a work item must not be re-armed after shutdown
begins.

Convert all cancel_work_sync() and cancel_delayed_work_sync() call sites to
their disable_* equivalents to clarify the intent to prevent re-arming
after teardown.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
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
index b8b1b997..6538d54d 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -225,7 +225,7 @@ static void batadv_iv_ogm_iface_disable(struct batadv_hard_iface *hard_iface)
 
 	mutex_unlock(&hard_iface->bat_iv.ogm_buff_mutex);
 
-	cancel_delayed_work_sync(&hard_iface->bat_iv.reschedule_work);
+	disable_delayed_work_sync(&hard_iface->bat_iv.reschedule_work);
 }
 
 static void batadv_iv_ogm_iface_update_mac(struct batadv_hard_iface *hard_iface)
diff --git a/net/batman-adv/bat_v.c b/net/batman-adv/bat_v.c
index de944471..c19fa26c 100644
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
index fdc2abe9..d43f555f 100644
--- a/net/batman-adv/bat_v_elp.c
+++ b/net/batman-adv/bat_v_elp.c
@@ -112,7 +112,7 @@ static bool batadv_v_elp_get_throughput(struct batadv_hardif_neigh_node *neigh,
 			goto default_throughput;
 
 		/* only use rtnl_trylock because the elp worker will be cancelled while
-		 * the rntl_lock is held. the cancel_delayed_work_sync() would otherwise
+		 * the rntl_lock is held. the disable_delayed_work_sync() would otherwise
 		 * wait forever when the elp work_item was started and it is then also
 		 * trying to rtnl_lock
 		 */
@@ -159,7 +159,7 @@ static bool batadv_v_elp_get_throughput(struct batadv_hardif_neigh_node *neigh,
 	}
 
 	/* only use rtnl_trylock because the elp worker will be cancelled while
-	 * the rntl_lock is held. the cancel_delayed_work_sync() would otherwise
+	 * the rntl_lock is held. the disable_delayed_work_sync() would otherwise
 	 * wait forever when the elp work_item was started and it is then also
 	 * trying to rtnl_lock
 	 */
@@ -444,7 +444,7 @@ int batadv_v_elp_iface_enable(struct batadv_hard_iface *hard_iface)
  */
 void batadv_v_elp_iface_disable(struct batadv_hard_iface *hard_iface)
 {
-	cancel_delayed_work_sync(&hard_iface->bat_v.elp_wq);
+	disable_delayed_work_sync(&hard_iface->bat_v.elp_wq);
 
 	dev_kfree_skb(hard_iface->bat_v.elp_skb);
 	hard_iface->bat_v.elp_skb = NULL;
diff --git a/net/batman-adv/bat_v_ogm.c b/net/batman-adv/bat_v_ogm.c
index d66ca77b..645e4b8a 100644
--- a/net/batman-adv/bat_v_ogm.c
+++ b/net/batman-adv/bat_v_ogm.c
@@ -417,6 +417,8 @@ int batadv_v_ogm_iface_enable(struct batadv_hard_iface *hard_iface)
 {
 	struct batadv_priv *bat_priv = netdev_priv(hard_iface->mesh_iface);
 
+	enable_delayed_work(&hard_iface->bat_v.aggr_wq);
+
 	batadv_v_ogm_start_queue_timer(hard_iface);
 	batadv_v_ogm_start_timer(bat_priv);
 
@@ -429,7 +431,7 @@ int batadv_v_ogm_iface_enable(struct batadv_hard_iface *hard_iface)
  */
 void batadv_v_ogm_iface_disable(struct batadv_hard_iface *hard_iface)
 {
-	cancel_delayed_work_sync(&hard_iface->bat_v.aggr_wq);
+	disable_delayed_work_sync(&hard_iface->bat_v.aggr_wq);
 
 	spin_lock_bh(&hard_iface->bat_v.aggr_list.lock);
 	batadv_v_ogm_aggr_list_free(hard_iface);
@@ -1079,7 +1081,7 @@ int batadv_v_ogm_init(struct batadv_priv *bat_priv)
  */
 void batadv_v_ogm_free(struct batadv_priv *bat_priv)
 {
-	cancel_delayed_work_sync(&bat_priv->bat_v.ogm_wq);
+	disable_delayed_work_sync(&bat_priv->bat_v.ogm_wq);
 
 	mutex_lock(&bat_priv->bat_v.ogm_buff_mutex);
 
diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
index ffe85401..828f6cae 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -1281,7 +1281,7 @@ static void batadv_bla_purge_backbone_gw(struct batadv_priv *bat_priv, int now)
 
 			if (purged) {
 				/* reference for pending report_work */
-				if (cancel_work_sync(&backbone_gw->report_work))
+				if (disable_work_sync(&backbone_gw->report_work))
 					batadv_backbone_gw_put(backbone_gw);
 
 				/* reference for hash_entry */
@@ -1849,7 +1849,7 @@ void batadv_bla_free(struct batadv_priv *bat_priv)
 {
 	struct batadv_hard_iface *primary_if;
 
-	cancel_delayed_work_sync(&bat_priv->bla.work);
+	disable_delayed_work_sync(&bat_priv->bla.work);
 	primary_if = batadv_primary_if_get_selected(bat_priv);
 
 	if (bat_priv->bla.claim_hash) {
diff --git a/net/batman-adv/distributed-arp-table.c b/net/batman-adv/distributed-arp-table.c
index 0a8bd95e..9dce7da4 100644
--- a/net/batman-adv/distributed-arp-table.c
+++ b/net/batman-adv/distributed-arp-table.c
@@ -837,7 +837,7 @@ void batadv_dat_free(struct batadv_priv *bat_priv)
 	batadv_tvlv_container_unregister(bat_priv, BATADV_TVLV_DAT, 1);
 	batadv_tvlv_handler_unregister(bat_priv, BATADV_TVLV_DAT, 1);
 
-	cancel_delayed_work_sync(&bat_priv->dat.work);
+	disable_delayed_work_sync(&bat_priv->dat.work);
 
 	batadv_dat_hash_free(bat_priv);
 }
diff --git a/net/batman-adv/multicast.c b/net/batman-adv/multicast.c
index 7dba0c2b..b7a72c23 100644
--- a/net/batman-adv/multicast.c
+++ b/net/batman-adv/multicast.c
@@ -2168,7 +2168,7 @@ int batadv_mcast_flags_dump(struct sk_buff *msg, struct netlink_callback *cb)
  */
 void batadv_mcast_free(struct batadv_priv *bat_priv)
 {
-	cancel_delayed_work_sync(&bat_priv->mcast.work);
+	disable_delayed_work_sync(&bat_priv->mcast.work);
 
 	batadv_tvlv_container_unregister(bat_priv, BATADV_TVLV_MCAST, 2);
 	batadv_tvlv_handler_unregister(bat_priv, BATADV_TVLV_MCAST_TRACKER, 1);
diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
index ad4921b6..d6fa3f22 100644
--- a/net/batman-adv/originator.c
+++ b/net/batman-adv/originator.c
@@ -906,7 +906,7 @@ void batadv_originator_free(struct batadv_priv *bat_priv)
 	if (!hash)
 		return;
 
-	cancel_delayed_work_sync(&bat_priv->orig_work);
+	disable_delayed_work_sync(&bat_priv->orig_work);
 
 	bat_priv->orig_hash = NULL;
 
diff --git a/net/batman-adv/send.c b/net/batman-adv/send.c
index 60cd67ec..dbccfc99 100644
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
index 0fc4ca78..aaf24db1 100644
--- a/net/batman-adv/tp_meter.c
+++ b/net/batman-adv/tp_meter.c
@@ -425,7 +425,7 @@ static void batadv_tp_list_detach(struct batadv_tp_vars *tp_vars)
  */
 static void batadv_tp_sender_cleanup(struct batadv_tp_vars *tp_vars)
 {
-	cancel_delayed_work_sync(&tp_vars->finish_work);
+	disable_delayed_work_sync(&tp_vars->finish_work);
 
 	batadv_tp_list_detach(tp_vars);
 
diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index d72adda4..30873021 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -3606,7 +3606,7 @@ void batadv_tt_free(struct batadv_priv *bat_priv)
 	batadv_tvlv_container_unregister(bat_priv, BATADV_TVLV_TT, 1);
 	batadv_tvlv_handler_unregister(bat_priv, BATADV_TVLV_TT, 1);
 
-	cancel_delayed_work_sync(&bat_priv->tt.work);
+	disable_delayed_work_sync(&bat_priv->tt.work);
 
 	batadv_tt_local_table_free(bat_priv);
 	batadv_tt_global_table_free(bat_priv);

---
base-commit: ec9f686b42917e9b67725d7245b50de72f59fa9e
change-id: 20260526-cancel-to-disable-113a0180ad69

Best regards,
--  
Sven Eckelmann <sven@narfation.org>

