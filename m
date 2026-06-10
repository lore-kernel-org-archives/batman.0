Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 908A7CD98C7
	for <batman-adv@archiver.kernel.org>; Wed, 10 Jun 2026 19:27:00 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id C954B83E1F
	for <batman-adv@archiver.kernel.org>; Wed, 10 Jun 2026 21:26:58 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1781119618;
 b=bpXXzHR7U9sDwo5EfxTO0WSU3SBD/cfIsv96cHQqOrXsQcfQekvH0bNfo4JcuFZi4noYl
 iVuAdK6d3XN2QOt7mso5TA9YXEGobe988kMmjRXS9TUM4R/4VvTtadshp2NXv8chgtaP1Yl
 3L6LfsMM9bSBf8+FDTH1hNO0+IvRbYc=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1781119618; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=/7w1p71EYXdBPBHi9un2jfCntx2ixCDoyM5/jUZp+/I=;
 b=rO4/K5cZAYnKmhtSRBzbXz5Bmq3jLqJWBDYsu8Z/lLhc/D4Lg87RZcd/u+PxH1knHXY5a
 9ILvAWwpErlacnVf8MD6hDcOlAPpFSE04xxL6LOTR4YavvWUBxxITSOHXqrWU8UZfYCssN5
 7P8IfiT2Bmn2I69Lc1l7pHBLXKVnV9k=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 2D7A6827CE
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 10 Jun 2026 21:26:39 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1781119609;
	b=a+YuENPBPj7r1xSvBgKUPHI+pSxBCwDnIFlUyIYm4YQN/9VEUA73uRyOYqDHYNrDsrdYXL
	tiG/gUvynjLl9JSORqMe0sxjNAnP9J8WohY9iIcvSS0Lbd4QTHaGQPhldvHMX9YxORJd33
	loOvYorTdNWs1f6RyyCMVxkjov6Be08=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1781119609;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=/7w1p71EYXdBPBHi9un2jfCntx2ixCDoyM5/jUZp+/I=;
	b=TqmD609hDAqIlnyCD7cLEHtYd6H880/ZXU54scO+UzzI/BIf5KnlTsIcAnAr+FpHccElJf
	5RrWDnDJl2HMe4im3JwUvLzY77g5R1jT8RPO4t7LQMbg6txyhmqoEk3W24J04QLKUn9CSb
	LXE+gQG4cC3tej3OumJIaXk/HeqZ0/c=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=Q+p5WywK;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org
Received: by dvalin.narfation.org (Postfix) id 6746C1FED3;
	Wed, 10 Jun 2026 19:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1781119598;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/7w1p71EYXdBPBHi9un2jfCntx2ixCDoyM5/jUZp+/I=;
	b=Q+p5WywKQRZGmkQglT2dYp+N1u/nVCBYPMMSOCXL72WmsRAxEbKBEc9L5eNWmEjJqoyssx
	lLlJke1lc/zINBttjmZkbM53WPU7TLV1tYGHfdbLNil2bVcGgk+mKh2VTE90s6u9kXu6Yu
	BOHdqfO4FJRjCx0RhgTUyyJsJmWJqgk=
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 10 Jun 2026 21:26:35 +0200
Subject: [PATCH batadv] batman-adv: tp_meter: keep unacked list for
 receivers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260610-tp-unacked-list-v1-1-02ecd953ebdd@narfation.org>
X-B4-Tracking: v=1; b=H4sIAGq6KWoC/yWM0QrCMAwAf2Xk2UA7sKK/Ij6kTTajUkfTjcHYv
 1v18Q7uNjApKgaXboMii5q+cwN/6CDdKY+Cyo2hd31wwTusE86Z0lMYX2oVOUQ6s/P+JEdo1VR
 k0PV3vEKkSrzA7e9tjg9J9buDff8Ah5zdjXsAAAA=
X-Change-ID: 20260610-tp-unacked-list-d6ba9d0117e5
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=8424; i=sven@narfation.org;
 h=from:subject:message-id; bh=HWhLbsfvv46KTgK1T/M9mYyMMnp7cphSNKGc6+eWR/o=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFmau7JTPdj7VJzzZIr3GSZcVpwjnsf55Mr88yvnaq+7s
 PV4oGJXRykLgxgXg6yYIsueK/nnN7O/lf887eNRmDmsTCBDGLg4BWAiMyYz/DPxWnZYbH7ghzL2
 C4/uxNwocK4o2lJ/9nd41+pjjoVvDV0YGd50+0YdCrTfP/vHOX6eQ/zbtdqUg5kc39xsfVJrr3X
 Jkx0A
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: UW3JQMODPCNZZQO5DN44HEMAK7GHJD32
X-Message-ID-Hash: UW3JQMODPCNZZQO5DN44HEMAK7GHJD32
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/UW3JQMODPCNZZQO5DN44HEMAK7GHJD32/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

There is no need to share the unacked list between sender and receivers.
Only receivers will ever write to and read from it. The initialization in
batadv_tp_start() was therefore never needed. After its removal, it is
enough to just store it in struct batadv_tp_receiver.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/tp_meter.c | 82 ++++++++++++++++++++++++++---------------------
 net/batman-adv/types.h    | 14 ++++----
 2 files changed, 53 insertions(+), 43 deletions(-)

diff --git a/net/batman-adv/tp_meter.c b/net/batman-adv/tp_meter.c
index 7e98cbfb..22ae0123 100644
--- a/net/batman-adv/tp_meter.c
+++ b/net/batman-adv/tp_meter.c
@@ -353,28 +353,16 @@ batadv_tp_list_find_sender_session(struct batadv_priv *bat_priv, const u8 *dst,
 }
 
 /**
- * batadv_tp_vars_common_release() - release batadv_tp_vars_common from lists
+ * batadv_tp_sender_release() - release batadv_tp_sender
  *  and queue for free after rcu grace period
  * @ref: kref pointer of the batadv_tp_vars_common
  */
-static void batadv_tp_vars_common_release(struct kref *ref)
+static void batadv_tp_sender_release(struct kref *ref)
 {
-	struct batadv_tp_vars_common *tp_vars;
-	struct batadv_tp_unacked *un, *safe;
+	struct batadv_tp_sender *tp_vars;
 
-	tp_vars = container_of(ref, struct batadv_tp_vars_common, refcount);
-
-	/* lock should not be needed because this object is now out of any
-	 * context!
-	 */
-	spin_lock_bh(&tp_vars->unacked_lock);
-	list_for_each_entry_safe(un, safe, &tp_vars->unacked_list, list) {
-		list_del(&un->list);
-		kfree(un);
-	}
-	spin_unlock_bh(&tp_vars->unacked_lock);
-
-	kfree_rcu(tp_vars, rcu);
+	tp_vars = container_of(ref, struct batadv_tp_sender, common.refcount);
+	kfree_rcu(tp_vars, common.rcu);
 }
 
 /**
@@ -387,7 +375,7 @@ static void batadv_tp_sender_put(struct batadv_tp_sender *tp_vars)
 	if (!tp_vars)
 		return;
 
-	kref_put(&tp_vars->common.refcount, batadv_tp_vars_common_release);
+	kref_put(&tp_vars->common.refcount, batadv_tp_sender_release);
 }
 
 /**
@@ -1140,9 +1128,6 @@ void batadv_tp_start(struct batadv_priv *bat_priv, const u8 *dst,
 	init_waitqueue_head(&tp_vars->more_bytes);
 	init_completion(&tp_vars->finished);
 
-	spin_lock_init(&tp_vars->common.unacked_lock);
-	INIT_LIST_HEAD(&tp_vars->common.unacked_list);
-
 	spin_lock_init(&tp_vars->cc_lock);
 
 	tp_vars->prerandom_offset = 0;
@@ -1246,6 +1231,31 @@ batadv_tp_list_find_receiver_session(struct batadv_priv *bat_priv, const u8 *dst
 	return tp_vars;
 }
 
+/**
+ * batadv_tp_receiver_release() - release batadv_tp_receiver
+ *  and queue for free after rcu grace period
+ * @ref: kref pointer of the batadv_tp_vars_common
+ */
+static void batadv_tp_receiver_release(struct kref *ref)
+{
+	struct batadv_tp_unacked *un, *safe;
+	struct batadv_tp_receiver *tp_vars;
+
+	tp_vars = container_of(ref, struct batadv_tp_receiver, common.refcount);
+
+	/* lock should not be needed because this object is now out of any
+	 * context!
+	 */
+	spin_lock_bh(&tp_vars->unacked_lock);
+	list_for_each_entry_safe(un, safe, &tp_vars->unacked_list, list) {
+		list_del(&un->list);
+		kfree(un);
+	}
+	spin_unlock_bh(&tp_vars->unacked_lock);
+
+	kfree_rcu(tp_vars, common.rcu);
+}
+
 /**
  * batadv_tp_receiver_put() - decrement the batadv_tp_receiver
  *  refcounter and possibly release it
@@ -1256,7 +1266,7 @@ static void batadv_tp_receiver_put(struct batadv_tp_receiver *tp_vars)
 	if (!tp_vars)
 		return;
 
-	kref_put(&tp_vars->common.refcount, batadv_tp_vars_common_release);
+	kref_put(&tp_vars->common.refcount, batadv_tp_receiver_release);
 }
 
 /**
@@ -1299,12 +1309,12 @@ static void batadv_tp_receiver_shutdown(struct timer_list *t)
 	if (batadv_tp_list_detach(&tp_vars->common))
 		batadv_tp_receiver_put(tp_vars);
 
-	spin_lock_bh(&tp_vars->common.unacked_lock);
-	list_for_each_entry_safe(un, safe, &tp_vars->common.unacked_list, list) {
+	spin_lock_bh(&tp_vars->unacked_lock);
+	list_for_each_entry_safe(un, safe, &tp_vars->unacked_list, list) {
 		list_del(&un->list);
 		kfree(un);
 	}
-	spin_unlock_bh(&tp_vars->common.unacked_lock);
+	spin_unlock_bh(&tp_vars->unacked_lock);
 
 	/* drop reference of timer */
 	if (WARN_ON(atomic_xchg(&tp_vars->receiving, 0) != 1))
@@ -1412,10 +1422,10 @@ static bool batadv_tp_handle_out_of_order(struct batadv_tp_receiver *tp_vars,
 	payload_len = skb->len - sizeof(struct batadv_unicast_packet);
 	new->len = payload_len;
 
-	spin_lock_bh(&tp_vars->common.unacked_lock);
+	spin_lock_bh(&tp_vars->unacked_lock);
 	/* if the list is empty immediately attach this new object */
-	if (list_empty(&tp_vars->common.unacked_list)) {
-		list_add(&new->list, &tp_vars->common.unacked_list);
+	if (list_empty(&tp_vars->unacked_list)) {
+		list_add(&new->list, &tp_vars->unacked_list);
 		goto out;
 	}
 
@@ -1426,7 +1436,7 @@ static bool batadv_tp_handle_out_of_order(struct batadv_tp_receiver *tp_vars,
 	 * the last received packet (the one being processed now) has a bigger
 	 * seqno than all the others already stored.
 	 */
-	list_for_each_entry_reverse(un, &tp_vars->common.unacked_list, list) {
+	list_for_each_entry_reverse(un, &tp_vars->unacked_list, list) {
 		/* check for duplicates */
 		if (new->seqno == un->seqno) {
 			if (new->len > un->len)
@@ -1451,10 +1461,10 @@ static bool batadv_tp_handle_out_of_order(struct batadv_tp_receiver *tp_vars,
 
 	/* received packet with smallest seqno out of order; add it to front */
 	if (!added)
-		list_add(&new->list, &tp_vars->common.unacked_list);
+		list_add(&new->list, &tp_vars->unacked_list);
 
 out:
-	spin_unlock_bh(&tp_vars->common.unacked_lock);
+	spin_unlock_bh(&tp_vars->unacked_lock);
 
 	return true;
 }
@@ -1472,8 +1482,8 @@ static void batadv_tp_ack_unordered(struct batadv_tp_receiver *tp_vars)
 	/* go through the unacked packet list and possibly ACK them as
 	 * well
 	 */
-	spin_lock_bh(&tp_vars->common.unacked_lock);
-	list_for_each_entry_safe(un, safe, &tp_vars->common.unacked_list, list) {
+	spin_lock_bh(&tp_vars->unacked_lock);
+	list_for_each_entry_safe(un, safe, &tp_vars->unacked_list, list) {
 		/* the list is ordered, therefore it is possible to stop as soon
 		 * there is a gap between the last acked seqno and the seqno of
 		 * the packet under inspection
@@ -1489,7 +1499,7 @@ static void batadv_tp_ack_unordered(struct batadv_tp_receiver *tp_vars)
 		list_del(&un->list);
 		kfree(un);
 	}
-	spin_unlock_bh(&tp_vars->common.unacked_lock);
+	spin_unlock_bh(&tp_vars->unacked_lock);
 }
 
 /**
@@ -1535,8 +1545,8 @@ batadv_tp_init_recv(struct batadv_priv *bat_priv,
 	tp_vars->common.bat_priv = bat_priv;
 	kref_init(&tp_vars->common.refcount);
 
-	spin_lock_init(&tp_vars->common.unacked_lock);
-	INIT_LIST_HEAD(&tp_vars->common.unacked_list);
+	spin_lock_init(&tp_vars->unacked_lock);
+	INIT_LIST_HEAD(&tp_vars->unacked_list);
 
 	kref_get(&tp_vars->common.refcount);
 	timer_setup(&tp_vars->common.timer, batadv_tp_receiver_shutdown, 0);
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 5fd5bd35..bced25d7 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -1331,7 +1331,7 @@ struct batadv_tp_unacked {
 	/** @len: length of the packet */
 	u16 len;
 
-	/** @list: list node for &batadv_tp_vars_common.unacked_list */
+	/** @list: list node for &batadv_tp_receiver.unacked_list */
 	struct list_head list;
 };
 
@@ -1354,12 +1354,6 @@ struct batadv_tp_vars_common {
 	/** @session: TP session identifier */
 	u8 session[2];
 
-	/** @unacked_list: list of unacked packets (meta-info only) */
-	struct list_head unacked_list;
-
-	/** @unacked_lock: protect unacked_list */
-	spinlock_t unacked_lock;
-
 	/** @refcount: number of context where the object is used */
 	struct kref refcount;
 
@@ -1473,6 +1467,12 @@ struct batadv_tp_receiver {
 
 	/** @last_recv_time: time (jiffies) a msg was received */
 	unsigned long last_recv_time;
+
+	/** @unacked_list: list of unacked packets (meta-info only) */
+	struct list_head unacked_list;
+
+	/** @unacked_lock: protect unacked_list */
+	spinlock_t unacked_lock;
 };
 
 /**

---
base-commit: 385b248dd4e46c4ce022adeb1b13e547d1954901
change-id: 20260610-tp-unacked-list-d6ba9d0117e5

Best regards,
--  
Sven Eckelmann <sven@narfation.org>

