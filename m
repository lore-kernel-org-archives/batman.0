Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A78BCD343F
	for <batman@archiver.kernel.org>; Fri, 15 May 2026 20:59:38 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id B706C85B45
	for <batman@archiver.kernel.org>; Fri, 15 May 2026 22:59:36 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1778878776;
 b=k4pcVRO92M20BKuDQDxyWOrlshmeHDC1sh6iOOjlWXNKyKlXEQYT42KSb/iMTLqyT0YF+
 ysevQG+6Exe4Ux8sursBy4hi04IbCHtEURwjW6HzBTYfzJU5I2iR7iCLxf5m0fsw4bjBfI0
 B/CNHIp9M65n0SFcLWtKebC5wzWk2eY=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1778878776; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=SlHj3BYtyc3KT3jktVxtdF6XWyg1CmQIs41FBAbv0fM=;
 b=efHo4WlaoBBeZmGEVr0m3pFPJvtEqga1ScD5EomFngFT/tpVvnYdBGjmC+nu/yw7mlsCx
 gHlMMtX93PIYG+eRBF2bDZZy9NSuvs2zgDduGvYnqwmrrsz+oJbVFe6b3Bd/lf9RSfzjyA0
 08jwWaIWloiSlLBZxGVqKVu8/9IrQ4A=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 2002A8227E
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 15 May 2026 22:59:04 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1778878754;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=SlHj3BYtyc3KT3jktVxtdF6XWyg1CmQIs41FBAbv0fM=;
	b=Mp/px3/tsbXe8y8LU6wI4OQpSZJNemGwPi0OdXtfjTo7eABLbABTt+xn79HYswMtLQiJQa
	qlguhNWF0NFZCDmjE/+0oIKYUkOOPH6A5pZiZf3GoY94vXNw3+jouQSy3diD9kcraYRF6D
	5RK7Zt3K6n2OXhDipTnFinmVzZKUCwU=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=uNtEfglr;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1778878754;
	b=0zHC9WPusQE/07vtxb6RYGoigQVDGDd9GGMS5jl8LSmJM4lJYVY295ea5jTqIlArCxzHA2
	92pSjoHQbjutB8UN91dD0ZFMf/zAbfvW/MWee0XvALVV5nxAvPPx5qeHaECDZJC1bBItXL
	+tc8CD0VSFKhFIHtCwWpJINjLZlpXd4=
Received: by dvalin.narfation.org (Postfix) id B783C1FF1D;
	Fri, 15 May 2026 20:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1778878742;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=SlHj3BYtyc3KT3jktVxtdF6XWyg1CmQIs41FBAbv0fM=;
	b=uNtEfglrPgazuegWXftc3Z/ihnhDarySKwTDvKPRLoGmqfYcQxUP9Ph61K/KsemmYa3BET
	9MnGMo+FkFBetvxRbINVEkP75BdTLRuKz7WAx2f+z4hkK4ehzJvTMt3yJdlatUwdMHkPgS
	S0lKB/ehgWgtY6KG3cRGSb7nL6m+7b0=
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 15 May 2026 22:58:58 +0200
Subject: [PATCH RFC batadv] batman-adv: iv: recover OGM scheduling after
 forward packet error
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: 
 <20260515-bat_iv-own-fwd-failure-recover-v1-1-caa171e7d59e@narfation.org>
X-B4-Tracking: v=1; b=H4sIABGJB2oC/yWNywrCMBBFf6XM2oGktPWxFfwAtyKSJhMdkUQmb
 SqU/rupLs+9cM4MiYQpwaGaQShz4hgK6E0F9mHCnZBdYahV3alWt9ib4cYZ4xTQTw694dcohEI
 2ZhJU2nZmS82u2WsokreQ588vcIHz6bhuRWFchuv/TmP/JDusEViWL9KMzIiRAAAA
X-Change-ID: 20260515-bat_iv-own-fwd-failure-recover-01c6a7e48491
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=8086; i=sven@narfation.org;
 h=from:subject:message-id; bh=9Cd2j2A3VDlSV0jW+aJ0GRuv7BWUVg9Sy9BbubeLMDM=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFnsnUKlUndnLmauXWb6yzhuxxnxgsCHXB992jy9mh1OL
 N3rOOlNRykLgxgXg6yYIsueK/nnN7O/lf887eNRmDmsTCBDGLg4BWAiM7YzMjxu+3rlEfvVjluu
 93T8F3l3CfNZWBxa5+kQOUnV7eUL70iG/9VqUzr6TgafaA3pXHkw8n7xTz+j08LnBSJssv98rgt
 jYgQA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: QR26K32RJGTUV3Q44KDZTI6CLVPTJPIE
X-Message-ID-Hash: QR26K32RJGTUV3Q44KDZTI6CLVPTJPIE
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/QR26K32RJGTUV3Q44KDZTI6CLVPTJPIE/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

When batadv_iv_ogm_schedule_buff() fails to allocate and queue a forward
packet for OGM transmission, the work item that drives periodic OGM
scheduling is never re-armed. This silently halts transmission of the
node's own OGMs on the affected interface — only OGMs from other peers
continue to be aggregated and forwarded.

Fix this by tracking whether batadv_iv_ogm_queue_add() (and transitively
batadv_iv_ogm_aggregate_new()) successfully scheduled a forward packet.
When scheduling fails, batadv_iv_ogm_schedule_buff() falls back to queuing
a dedicated recovery work item (reschedule_work) that fires after one
originator interval and calls batadv_iv_ogm_schedule() again.

Fixes: d893c5d00f63 ("[batman-adv] Cleanup aggregation.[ch]")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
See https://www.open-mesh.org/issues/433
---
 net/batman-adv/bat_iv_ogm.c | 75 ++++++++++++++++++++++++++++++++++++---------
 net/batman-adv/types.h      |  3 ++
 2 files changed, 64 insertions(+), 14 deletions(-)

diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index 74ef7dc2..e67a296f 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -224,6 +224,8 @@ static void batadv_iv_ogm_iface_disable(struct batadv_hard_iface *hard_iface)
 	hard_iface->bat_iv.ogm_buff = NULL;
 
 	mutex_unlock(&hard_iface->bat_iv.ogm_buff_mutex);
+
+	cancel_delayed_work_sync(&hard_iface->bat_iv.reschedule_work);
 }
 
 static void batadv_iv_ogm_iface_update_mac(struct batadv_hard_iface *hard_iface)
@@ -536,8 +538,10 @@ batadv_iv_ogm_can_aggregate(const struct batadv_ogm_packet *new_bat_ogm_packet,
  * @if_incoming: interface where the packet was received
  * @if_outgoing: interface for which the retransmission should be considered
  * @own_packet: true if it is a self-generated ogm
+ *
+ * Return: whether forward packet was scheduled
  */
-static void batadv_iv_ogm_aggregate_new(const unsigned char *packet_buff,
+static bool batadv_iv_ogm_aggregate_new(const unsigned char *packet_buff,
 					int packet_len, unsigned long send_time,
 					bool direct_link,
 					struct batadv_hard_iface *if_incoming,
@@ -561,13 +565,13 @@ static void batadv_iv_ogm_aggregate_new(const unsigned char *packet_buff,
 
 	skb = netdev_alloc_skb_ip_align(NULL, skb_size);
 	if (!skb)
-		return;
+		return false;
 
 	forw_packet_aggr = batadv_forw_packet_alloc(if_incoming, if_outgoing,
 						    queue_left, bat_priv, skb);
 	if (!forw_packet_aggr) {
 		kfree_skb(skb);
-		return;
+		return false;
 	}
 
 	forw_packet_aggr->skb->priority = TC_PRIO_CONTROL;
@@ -590,6 +594,8 @@ static void batadv_iv_ogm_aggregate_new(const unsigned char *packet_buff,
 			  batadv_iv_send_outstanding_bat_ogm_packet);
 
 	batadv_forw_packet_ogmv1_queue(bat_priv, forw_packet_aggr, send_time);
+
+	return true;
 }
 
 /* aggregate a new packet into the existing ogm packet */
@@ -617,8 +623,10 @@ static void batadv_iv_ogm_aggregate(struct batadv_forw_packet *forw_packet_aggr,
  * @if_outgoing: interface for which the retransmission should be considered
  * @own_packet: true if it is a self-generated ogm
  * @send_time: timestamp (jiffies) when the packet is to be sent
+ *
+ * Return: whether forward packet was scheduled
  */
-static void batadv_iv_ogm_queue_add(struct batadv_priv *bat_priv,
+static bool batadv_iv_ogm_queue_add(struct batadv_priv *bat_priv,
 				    unsigned char *packet_buff,
 				    int packet_len,
 				    struct batadv_hard_iface *if_incoming,
@@ -670,14 +678,16 @@ static void batadv_iv_ogm_queue_add(struct batadv_priv *bat_priv,
 		if (!own_packet && atomic_read(&bat_priv->aggregated_ogms))
 			send_time += max_aggregation_jiffies;
 
-		batadv_iv_ogm_aggregate_new(packet_buff, packet_len,
-					    send_time, direct_link,
-					    if_incoming, if_outgoing,
-					    own_packet);
+		return batadv_iv_ogm_aggregate_new(packet_buff, packet_len,
+						   send_time, direct_link,
+						   if_incoming, if_outgoing,
+						   own_packet);
 	} else {
 		batadv_iv_ogm_aggregate(forw_packet_aggr, packet_buff,
 					packet_len, direct_link);
 		spin_unlock_bh(&bat_priv->forw_bat_list_lock);
+
+		return true;
 	}
 }
 
@@ -790,6 +800,7 @@ static void batadv_iv_ogm_schedule_buff(struct batadv_hard_iface *hard_iface)
 	u32 seqno;
 	u16 tvlv_len = 0;
 	unsigned long send_time;
+	bool scheduled;
 
 	lockdep_assert_held(&hard_iface->bat_iv.ogm_buff_mutex);
 
@@ -834,8 +845,20 @@ static void batadv_iv_ogm_schedule_buff(struct batadv_hard_iface *hard_iface)
 		/* OGMs from secondary interfaces are only scheduled on their
 		 * respective interfaces.
 		 */
-		batadv_iv_ogm_queue_add(bat_priv, *ogm_buff, *ogm_buff_len,
-					hard_iface, hard_iface, 1, send_time);
+		scheduled = batadv_iv_ogm_queue_add(bat_priv, *ogm_buff, *ogm_buff_len,
+						    hard_iface, hard_iface, 1, send_time);
+		if (scheduled)
+			goto out;
+
+		/* there was a failure scheduling the forward packet
+		 * as result, the batadv_iv_send_outstanding_bat_ogm_packet()
+		 * work item is no longer scheduled. it is therefore necessary
+		 * to reschedule it manually
+		 */
+		queue_delayed_work(batadv_event_workqueue,
+				   &hard_iface->bat_iv.reschedule_work,
+				   msecs_to_jiffies(atomic_read(&bat_priv->orig_interval)));
+
 		goto out;
 	}
 
@@ -847,11 +870,22 @@ static void batadv_iv_ogm_schedule_buff(struct batadv_hard_iface *hard_iface)
 		if (!kref_get_unless_zero(&tmp_hard_iface->refcount))
 			continue;
 
-		batadv_iv_ogm_queue_add(bat_priv, *ogm_buff,
-					*ogm_buff_len, hard_iface,
-					tmp_hard_iface, 1, send_time);
-
+		scheduled = batadv_iv_ogm_queue_add(bat_priv, *ogm_buff,
+						    *ogm_buff_len, hard_iface,
+						    tmp_hard_iface, 1, send_time);
 		batadv_hardif_put(tmp_hard_iface);
+
+		if (scheduled || tmp_hard_iface != hard_iface)
+			continue;
+
+		/* there was a failure scheduling the forward packet
+		 * as result, the batadv_iv_send_outstanding_bat_ogm_packet()
+		 * work item is no longer scheduled. it is therefore necessary
+		 * to reschedule it manually
+		 */
+		queue_delayed_work(batadv_event_workqueue,
+				   &hard_iface->bat_iv.reschedule_work,
+				   msecs_to_jiffies(atomic_read(&bat_priv->orig_interval)));
 	}
 	rcu_read_unlock();
 
@@ -870,6 +904,17 @@ static void batadv_iv_ogm_schedule(struct batadv_hard_iface *hard_iface)
 	mutex_unlock(&hard_iface->bat_iv.ogm_buff_mutex);
 }
 
+static void batadv_iv_ogm_reschedule(struct work_struct *work)
+{
+	struct delayed_work *delayed_work = to_delayed_work(work);
+	struct batadv_hard_iface *hard_iface;
+
+	hard_iface = container_of(delayed_work,
+				  struct batadv_hard_iface,
+				  bat_iv.reschedule_work);
+	batadv_iv_ogm_schedule(hard_iface);
+}
+
 /**
  * batadv_iv_orig_ifinfo_sum() - Get bcast_own sum for originator over interface
  * @orig_node: originator which reproadcasted the OGMs directly
@@ -2262,6 +2307,8 @@ batadv_iv_ogm_neigh_is_sob(struct batadv_neigh_node *neigh1,
 
 static void batadv_iv_iface_enabled(struct batadv_hard_iface *hard_iface)
 {
+	INIT_DELAYED_WORK(&hard_iface->bat_iv.reschedule_work, batadv_iv_ogm_reschedule);
+
 	/* begin scheduling originator messages on that interface */
 	batadv_iv_ogm_schedule(hard_iface);
 }
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index c8c3e806..6138f63a 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -83,6 +83,9 @@ struct batadv_hard_iface_bat_iv {
 	/** @ogm_seqno: OGM sequence number - used to identify each OGM */
 	atomic_t ogm_seqno;
 
+	/** @reschedule_work: recover OGM schedule after schedule error */
+	struct delayed_work reschedule_work;
+
 	/** @ogm_buff_mutex: lock protecting ogm_buff and ogm_buff_len */
 	struct mutex ogm_buff_mutex;
 };

---
base-commit: 724c381c1dcd0f0682ba36909ca6b843d11d3c2f
change-id: 20260515-bat_iv-own-fwd-failure-recover-01c6a7e48491

Best regards,
--  
Sven Eckelmann <sven@narfation.org>

