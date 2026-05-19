Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3243CD4F3C
	for <batman@archiver.kernel.org>; Tue, 19 May 2026 07:01:15 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id D539680840
	for <batman@archiver.kernel.org>; Tue, 19 May 2026 08:59:49 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1779173989;
 b=2krE8MNspVgx1KJdvwnUChI8HCEMcFXI0SpWT4xiky7Cgh1R8XIIfgqhWxZJ5G1iDewaY
 ZsrPiEGZACAVcqS/iDU6CTCYVwFXEf0DofPPo+8vfQX1S9C86f/KUfMmuzxsen4aJy7D8uh
 T+0GxjObFFr4Sm7fo9qVi/I0HBdIXaQ=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1779173989; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=7QewiORzE8BQPgHRy57MNc9HdYNa+ba5P4xhzdV0nT0=;
 b=mFjryDwLvt+L8U2FvkG1TcykE1X9wUnU+FmkI9lJfSy5/9TuVjgBLDNsBY6AKJg/ej7hb
 rqJRBdQZHia4VLleHakRTKxhbx7WdaHcqfjifeQyqRzsISHz6irDBQ7ZfUJAWzYkKO9uzyE
 Ehp44/FdZdtbp5uQoxrtXb2sh/ztlWg=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 0703F80232
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 19 May 2026 08:58:58 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1779173949;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=7QewiORzE8BQPgHRy57MNc9HdYNa+ba5P4xhzdV0nT0=;
	b=WLSfTP537YY4s7f/zkyJ2edyCrnYIHrR6y/J57suB4Sr/x5a5bqe0yG0gk10vJRyxa8FSD
	fBzZ66NrRWqPbA0fUI9yzSNO5seq736Yp0YTVIqgCeFthO0bUA6Om9LfVmUHH4XiDg8CiL
	PpUaCy1hPoTIShYThQdREyrfklS/tWQ=
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1779173949;
	b=Wmr5LciBnWNFLk2feUsTmXzCSvd0yp/2uRm9P1Wdrm2z072QB+72bmssk8DywiiAYUx0On
	9Mi+0YCWDFWFqgJEaU397wAkHlfycAF2WppUvd7gkqgp6fnBYIl2Ck188lw10SmHCLsh63
	qAGII+i7476P3xXb67nrP42drOnlPis=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=JBmuyRrg;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id EE6B01FD9C;
	Tue, 19 May 2026 06:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1779173938;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7QewiORzE8BQPgHRy57MNc9HdYNa+ba5P4xhzdV0nT0=;
	b=JBmuyRrg/dF6UgkSh3o50B6NeJP246wFpj4oaYbbKcDiMrLFxb7FzU4XK5I+4QEg8R8soO
	1wzVuAnehP7vxzRjpqo2ros0jtFrQHwkozp2hRMjGRTnXF/eW61O9c94MV+CZTPQoi5+77
	9uUfqJVzXp0POwk/qr/KZAm3flVxchc=
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 19 May 2026 08:58:54 +0200
Subject: [PATCH batadv v2] batman-adv: iv: recover OGM scheduling after
 forward packet error
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: 
 <20260519-bat_iv-own-fwd-failure-recover-v2-1-e1ae4fa705b9@narfation.org>
X-B4-Tracking: v=1; b=H4sIAC0KDGoC/41PSw6CMBC9ipm1YyjhI668hyFmKAPUGGqmpWgId
 7fgBVy+l/ddwLEYdnA5LCAcjDN2jCA9HkAPNPaMpo0Y0iQtklzl2JC/m4B2HrGbW+zIPCdhFNY
 2sGCidEElZ+esUhBDXsKdee8FN4heagPUP95NzYO139I35WCct/LZlwS16/8tDQoVaiJVKi7bv
 OLrSNKRj19OVnqo13X9AodEOrjqAAAA
X-Change-ID: 20260515-bat_iv-own-fwd-failure-recover-01c6a7e48491
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=8031; i=sven@narfation.org;
 h=from:subject:message-id; bh=2vWu8L+u4yRBigK4L7iwL3/K0vVJzcfLcfYGI1TPfL4=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFk8XPr8YvEnF/zLPfaAy/TYphxLHbZ5j2TP3fIvPzfLX
 s9h7V+vjlIWBjEuBlkxRZY9V/LPb2Z/K/952sejMHNYmUCGMHBxCsBE5jYw/DNvM56zZmqUzJPF
 O1v5c/eWFa3fvaB23/GzZ/9v2rxquuMXRoblM9jFbAzn7rgdtvlv+UfBaXb7JCalLn8ikLThAuO
 KiHlcAA==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: BZVXKKGTAH2LPI6UBMIQ5I7NOP4OFGM2
X-Message-ID-Hash: BZVXKKGTAH2LPI6UBMIQ5I7NOP4OFGM2
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/BZVXKKGTAH2LPI6UBMIQ5I7NOP4OFGM2/>
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
Changes in v2:
- move reschedule to central place at end of function
- remove RFC prefix
- Link to v1: https://patch.msgid.link/20260515-bat_iv-own-fwd-failure-recover-v1-1-caa171e7d59e@narfation.org
---
 net/batman-adv/bat_iv_ogm.c | 70 ++++++++++++++++++++++++++++++++++++---------
 net/batman-adv/types.h      |  3 ++
 2 files changed, 59 insertions(+), 14 deletions(-)

diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index 74ef7dc2..7115eaed 100644
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
 
@@ -790,6 +800,8 @@ static void batadv_iv_ogm_schedule_buff(struct batadv_hard_iface *hard_iface)
 	u32 seqno;
 	u16 tvlv_len = 0;
 	unsigned long send_time;
+	bool reschedule = false;
+	bool scheduled;
 
 	lockdep_assert_held(&hard_iface->bat_iv.ogm_buff_mutex);
 
@@ -834,8 +846,11 @@ static void batadv_iv_ogm_schedule_buff(struct batadv_hard_iface *hard_iface)
 		/* OGMs from secondary interfaces are only scheduled on their
 		 * respective interfaces.
 		 */
-		batadv_iv_ogm_queue_add(bat_priv, *ogm_buff, *ogm_buff_len,
-					hard_iface, hard_iface, 1, send_time);
+		scheduled = batadv_iv_ogm_queue_add(bat_priv, *ogm_buff, *ogm_buff_len,
+						    hard_iface, hard_iface, 1, send_time);
+		if (!scheduled)
+			reschedule = true;
+
 		goto out;
 	}
 
@@ -847,15 +862,29 @@ static void batadv_iv_ogm_schedule_buff(struct batadv_hard_iface *hard_iface)
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
+		if (!scheduled && tmp_hard_iface == hard_iface)
+			reschedule = true;
+
 	}
 	rcu_read_unlock();
 
 out:
+	if (reschedule) {
+		/* there was a failure scheduling the own forward packet.
+		 * as result, the batadv_iv_send_outstanding_bat_ogm_packet()
+		 * work item is no longer scheduled. it is therefore necessary
+		 * to reschedule it manually
+		 */
+		queue_delayed_work(batadv_event_workqueue,
+				   &hard_iface->bat_iv.reschedule_work,
+				   msecs_to_jiffies(atomic_read(&bat_priv->orig_interval)));
+	}
+
 	batadv_hardif_put(primary_if);
 }
 
@@ -870,6 +899,17 @@ static void batadv_iv_ogm_schedule(struct batadv_hard_iface *hard_iface)
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
@@ -2262,6 +2302,8 @@ batadv_iv_ogm_neigh_is_sob(struct batadv_neigh_node *neigh1,
 
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
base-commit: ff182fc0c666754e3f35f7b63c9ccf0dff239e52
change-id: 20260515-bat_iv-own-fwd-failure-recover-01c6a7e48491

Best regards,
--  
Sven Eckelmann <sven@narfation.org>

