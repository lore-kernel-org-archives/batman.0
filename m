Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37228CD4F5B
	for <batman@archiver.kernel.org>; Tue, 19 May 2026 07:04:23 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id B9209809CB
	for <batman@archiver.kernel.org>; Tue, 19 May 2026 09:03:53 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1779174233;
 b=pW5F5nEYLXLvBarfNf36bV/UtJzBtQbvAG5kyRWijzhKw8vEmOAytIX42nBBpQjPLj+5c
 uPUwlG0mZG0KEoI2+FEghNqDGwXDEqod2quFxhjkTqgwmfWWiQwfabzHJx5T/NtAwPHOt0y
 UMMRPjxfhP6X4nK3ECKYonq2Juto62M=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1779174233; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=5Xk24i0Vn65vgRBINLvYs+1ROndwfyuwbNzeAAnK7o8=;
 b=lQG1XUO4dtJhLSOoE6mf6azB344/HeRB0THdtFVtHNIj1w98BDFdRY5QLGGcVQlZQhHx/
 I6DeleyCkyfD9hsqj8kS4NMzK46FCFfzswqOOb7OwIKeuhVz6QQ6megZaTeL51biMP9nOjM
 Y3LsnTX/YKHU7wEBKYW0QgNXwGhz034=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 2902D80909
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 19 May 2026 09:00:47 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1779174047;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=5Xk24i0Vn65vgRBINLvYs+1ROndwfyuwbNzeAAnK7o8=;
	b=FYJwsixOWcVIgCyeoKXe9LjRolBqmceVfcj2J9E+Ysyws5FdhUK3BxTqWrlVLs/vfPSF9x
	olqTNkUy/KM4Q21fRKtZurbOROPrGrTvKcT1jPjmfuQGzOo7AYn/5Vwz0B/MCd/4WI3Wqc
	ERT31XB+hyp3YNlRdXInf7NJAo3XvoM=
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1779174047;
	b=nkovpJS7bl/6mqgUmXm6Pf7eNgCuzEJU2YwWcnQcVLw7FPYk657HLKfMAq887rROURq9NN
	H8fMoEv/4CslWzNKSlQCpv+ffbpYsYltdWRePi3mWLg2hmoUlEFVW5FjxBwNWwlDiPl5jG
	x4iWAjryYqe81lVf2I/QyhyoteTixaM=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=WiMaURe3;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id CF8571FE24;
	Tue, 19 May 2026 07:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1779174046;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5Xk24i0Vn65vgRBINLvYs+1ROndwfyuwbNzeAAnK7o8=;
	b=WiMaURe3YR6W3djuMrB9GwAmuafq91C/h+YcoTd5OpakLW04gGuhglmfmkcRqSKua7smXU
	+HpszH/rno/Ja0qSKLPF2VAkpeZTLvb3nXUN1HG3o8BftDgW396FMQlERftu9pk85nh9OY
	ttsdWCblcgxQgprocl5P9ZauqtdrRLA=
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 19 May 2026 09:00:38 +0200
Subject: [PATCH batadv v2 3/3] batman-adv: tp_meter: split vars into sender
 and receiver types
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-tp-reason-missing-v2-3-9c5cd1824e3b@narfation.org>
References: <20260519-tp-reason-missing-v2-0-9c5cd1824e3b@narfation.org>
In-Reply-To: <20260519-tp-reason-missing-v2-0-9c5cd1824e3b@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=41326; i=sven@narfation.org;
 h=from:subject:message-id; bh=Rb1BSbGCyWbxF4xckz4aJyKdOqGwfzXZnh2LgcpFCyQ=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFk8XFPtHyho1N7wjyt68MV64/zY54LLnNdJ5G5gvXH0Z
 XVO8v+jHaUsDGJcDLJiiix7ruSf38z+Vv7ztI9HYeawMoEMYeDiFICJJM9n+Kd0ii/w2977MZ2G
 P10jt/7VsPvfr7P/C2MbK192ofZShdOMDHdU7nm6l8xeW+6b/vZ6xoLmoh0N8ZKPLIy3+/tn1jh
 wsQMA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: WOFRSRGO72ZKE24F2W2NRGUUNMVOHVXG
X-Message-ID-Hash: WOFRSRGO72ZKE24F2W2NRGUUNMVOHVXG
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/WOFRSRGO72ZKE24F2W2NRGUUNMVOHVXG/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

The monolithic batadv_tp_vars struct holds fields for both sender and
receiver roles, distinguished only by a runtime enum role. This makes it
easy to accidentally access a field intended for the opposite role, since
neither the compiler nor the type system provide any guard against such
mistakes. The role check also adds unnecessary branching in several code
paths.

Introduce batadv_tp_vars_common to hold fields shared across both roles,
then derive two separate types (sender/receiver) from it. The functions can
operate on them without any ambiguity about the available fields. This also
reduces the memory footprint of receiver sessions, which no longer carry
the substantial sender-only fields.

Care must be taken to prevent concurrent TP sessions between the same two
peers in opposite directions, since sender and receiver sessions are now
tracked in separate lists and a lookup in one list no longer detects a
session in the other.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/main.c     |   3 +-
 net/batman-adv/tp_meter.c | 396 ++++++++++++++++++++++++++--------------------
 net/batman-adv/types.h    | 101 ++++++------
 3 files changed, 281 insertions(+), 219 deletions(-)

diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index a4d33ee0..fc80f958 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -181,7 +181,8 @@ int batadv_mesh_init(struct net_device *mesh_iface)
 	INIT_HLIST_HEAD(&bat_priv->tvlv.container_list);
 	INIT_HLIST_HEAD(&bat_priv->tvlv.handler_list);
 	INIT_HLIST_HEAD(&bat_priv->meshif_vlan_list);
-	INIT_HLIST_HEAD(&bat_priv->tp_list);
+	INIT_HLIST_HEAD(&bat_priv->tp_sender_list);
+	INIT_HLIST_HEAD(&bat_priv->tp_receiver_list);
 
 	bat_priv->gw.generation = 0;
 
diff --git a/net/batman-adv/tp_meter.c b/net/batman-adv/tp_meter.c
index 0fc4ca78..f1dc610d 100644
--- a/net/batman-adv/tp_meter.c
+++ b/net/batman-adv/tp_meter.c
@@ -142,7 +142,7 @@ static u32 batadv_tp_cwnd(u32 base, u32 increment, u32 min)
  * 2) if the session is in Congestion Avoidance, the CWND has to be
  * increased by MSS * MSS / CWND for every unique received ACK
  */
-static void batadv_tp_update_cwnd(struct batadv_tp_vars *tp_vars, u32 mss)
+static void batadv_tp_update_cwnd(struct batadv_tp_sender *tp_vars, u32 mss)
 {
 	spin_lock_bh(&tp_vars->cwnd_lock);
 
@@ -173,7 +173,7 @@ static void batadv_tp_update_cwnd(struct batadv_tp_vars *tp_vars, u32 mss)
  * @tp_vars: the private data of the current TP meter session
  * @new_rtt: new roundtrip time in msec
  */
-static void batadv_tp_update_rto(struct batadv_tp_vars *tp_vars,
+static void batadv_tp_update_rto(struct batadv_tp_sender *tp_vars,
 				 u32 new_rtt)
 {
 	long m = new_rtt;
@@ -252,35 +252,30 @@ static void batadv_tp_batctl_error_notify(enum batadv_tp_meter_reason reason,
 }
 
 /**
- * batadv_tp_list_find() - find a tp_vars object in the global list
+ * batadv_tp_list_find_sender() - find a sender tp_vars object in the global list
  * @bat_priv: the bat priv with all the mesh interface information
  * @dst: the other endpoint MAC address to look for
- * @role: role of the session
  *
  * Look for a tp_vars object matching dst as end_point and return it after
  * having increment the refcounter. Return NULL is not found
  *
  * Return: matching tp_vars or NULL when no tp_vars with @dst was found
  */
-static struct batadv_tp_vars *batadv_tp_list_find(struct batadv_priv *bat_priv,
-						  const u8 *dst,
-						  enum batadv_tp_meter_role role)
+static struct batadv_tp_sender *
+batadv_tp_list_find_sender(struct batadv_priv *bat_priv, const u8 *dst)
 {
-	struct batadv_tp_vars *pos, *tp_vars = NULL;
+	struct batadv_tp_sender *pos, *tp_vars = NULL;
 
 	rcu_read_lock();
-	hlist_for_each_entry_rcu(pos, &bat_priv->tp_list, list) {
-		if (!batadv_compare_eth(pos->other_end, dst))
-			continue;
-
-		if (pos->role != role)
+	hlist_for_each_entry_rcu(pos, &bat_priv->tp_sender_list, common.list) {
+		if (!batadv_compare_eth(pos->common.other_end, dst))
 			continue;
 
 		/* most of the time this function is invoked during the normal
 		 * process..it makes sens to pay more when the session is
 		 * finished and to speed the process up during the measurement
 		 */
-		if (unlikely(!kref_get_unless_zero(&pos->refcount)))
+		if (unlikely(!kref_get_unless_zero(&pos->common.refcount)))
 			continue;
 
 		tp_vars = pos;
@@ -301,10 +296,16 @@ static struct batadv_tp_vars *batadv_tp_list_find(struct batadv_priv *bat_priv,
 static bool batadv_tp_list_active(struct batadv_priv *bat_priv, const u8 *dst)
 	__must_hold(&bat_priv->tp_list_lock)
 {
-	struct batadv_tp_vars *tp_vars;
+	struct batadv_tp_receiver *tp_receiver;
+	struct batadv_tp_sender *tp_sender;
 
-	hlist_for_each_entry_rcu(tp_vars, &bat_priv->tp_list, list) {
-		if (batadv_compare_eth(tp_vars->other_end, dst))
+	hlist_for_each_entry_rcu(tp_sender, &bat_priv->tp_sender_list, common.list) {
+		if (batadv_compare_eth(tp_sender->common.other_end, dst))
+			return true;
+	}
+
+	hlist_for_each_entry_rcu(tp_receiver, &bat_priv->tp_receiver_list, common.list) {
+		if (batadv_compare_eth(tp_receiver->common.other_end, dst))
 			return true;
 	}
 
@@ -312,12 +313,11 @@ static bool batadv_tp_list_active(struct batadv_priv *bat_priv, const u8 *dst)
 }
 
 /**
- * batadv_tp_list_find_session() - find tp_vars session object in the global
- *  list
+ * batadv_tp_list_find_sender_session() - find tp_vars sender session
+ *  object in the global list
  * @bat_priv: the bat priv with all the mesh interface information
  * @dst: the other endpoint MAC address to look for
  * @session: session identifier
- * @role: role of the session
  *
  * Look for a tp_vars object matching dst as end_point, session as tp meter
  * session and return it after having increment the refcounter. Return NULL
@@ -325,28 +325,25 @@ static bool batadv_tp_list_active(struct batadv_priv *bat_priv, const u8 *dst)
  *
  * Return: matching tp_vars or NULL when no tp_vars was found
  */
-static struct batadv_tp_vars *
-batadv_tp_list_find_session(struct batadv_priv *bat_priv, const u8 *dst,
-			    const u8 *session, enum batadv_tp_meter_role role)
+static struct batadv_tp_sender *
+batadv_tp_list_find_sender_session(struct batadv_priv *bat_priv, const u8 *dst,
+				   const u8 *session)
 {
-	struct batadv_tp_vars *pos, *tp_vars = NULL;
+	struct batadv_tp_sender *pos, *tp_vars = NULL;
 
 	rcu_read_lock();
-	hlist_for_each_entry_rcu(pos, &bat_priv->tp_list, list) {
-		if (!batadv_compare_eth(pos->other_end, dst))
+	hlist_for_each_entry_rcu(pos, &bat_priv->tp_sender_list, common.list) {
+		if (!batadv_compare_eth(pos->common.other_end, dst))
 			continue;
 
-		if (memcmp(pos->session, session, sizeof(pos->session)) != 0)
-			continue;
-
-		if (pos->role != role)
+		if (memcmp(pos->common.session, session, sizeof(pos->common.session)) != 0)
 			continue;
 
 		/* most of the time this function is invoked during the normal
 		 * process..it makes sense to pay more when the session is
 		 * finished and to speed the process up during the measurement
 		 */
-		if (unlikely(!kref_get_unless_zero(&pos->refcount)))
+		if (unlikely(!kref_get_unless_zero(&pos->common.refcount)))
 			continue;
 
 		tp_vars = pos;
@@ -358,16 +355,16 @@ batadv_tp_list_find_session(struct batadv_priv *bat_priv, const u8 *dst,
 }
 
 /**
- * batadv_tp_vars_release() - release batadv_tp_vars from lists and queue for
- *  free after rcu grace period
+ * batadv_tp_vars_common_release() - release batadv_tp_vars_common from lists
+ *  and queue for free after rcu grace period
  * @ref: kref pointer of the batadv_tp_vars
  */
-static void batadv_tp_vars_release(struct kref *ref)
+static void batadv_tp_vars_common_release(struct kref *ref)
 {
-	struct batadv_tp_vars *tp_vars;
+	struct batadv_tp_vars_common *tp_vars;
 	struct batadv_tp_unacked *un, *safe;
 
-	tp_vars = container_of(ref, struct batadv_tp_vars, refcount);
+	tp_vars = container_of(ref, struct batadv_tp_vars_common, refcount);
 
 	/* lock should not be needed because this object is now out of any
 	 * context!
@@ -383,23 +380,25 @@ static void batadv_tp_vars_release(struct kref *ref)
 }
 
 /**
- * batadv_tp_vars_put() - decrement the batadv_tp_vars refcounter and possibly
- *  release it
+ * batadv_tp_sender_put() - decrement the batadv_tp_sender
+ *  refcounter and possibly release it
  * @tp_vars: the private data of the current TP meter session to be free'd
  */
-static void batadv_tp_vars_put(struct batadv_tp_vars *tp_vars)
+static void batadv_tp_sender_put(struct batadv_tp_sender *tp_vars)
 {
 	if (!tp_vars)
 		return;
 
-	kref_put(&tp_vars->refcount, batadv_tp_vars_release);
+	kref_put(&tp_vars->common.refcount, batadv_tp_vars_common_release);
 }
 
 /**
- * batadv_tp_list_detach() - remove tp session from mesh session list once
+ * batadv_tp_list_detach() - remove tp receiver session from mesh session list once
  * @tp_vars: the private data of the current TP meter session
+ *
+ * Return: whether tp_vars was detached from list and reference must be freed
  */
-static void batadv_tp_list_detach(struct batadv_tp_vars *tp_vars)
+static bool batadv_tp_list_detach(struct batadv_tp_vars_common *tp_vars)
 {
 	bool detached = false;
 
@@ -411,27 +410,27 @@ static void batadv_tp_list_detach(struct batadv_tp_vars *tp_vars)
 	spin_unlock_bh(&tp_vars->bat_priv->tp_list_lock);
 
 	if (!detached)
-		return;
+		return false;
 
 	atomic_dec(&tp_vars->bat_priv->tp_num);
 
-	/* drop list reference */
-	batadv_tp_vars_put(tp_vars);
+	return true;
 }
 
 /**
  * batadv_tp_sender_cleanup() - cleanup sender data and drop and timer
  * @tp_vars: the private data of the current TP meter session to cleanup
  */
-static void batadv_tp_sender_cleanup(struct batadv_tp_vars *tp_vars)
+static void batadv_tp_sender_cleanup(struct batadv_tp_sender *tp_vars)
 {
 	cancel_delayed_work_sync(&tp_vars->finish_work);
 
-	batadv_tp_list_detach(tp_vars);
+	if (batadv_tp_list_detach(&tp_vars->common))
+		batadv_tp_sender_put(tp_vars);
 
 	/* kill the timer and remove its reference */
-	timer_shutdown_sync(&tp_vars->timer);
-	batadv_tp_vars_put(tp_vars);
+	timer_shutdown_sync(&tp_vars->common.timer);
+	batadv_tp_sender_put(tp_vars);
 }
 
 /**
@@ -440,7 +439,7 @@ static void batadv_tp_sender_cleanup(struct batadv_tp_vars *tp_vars)
  * @tp_vars: the private data of the current TP meter session
  */
 static void batadv_tp_sender_end(struct batadv_priv *bat_priv,
-				 struct batadv_tp_vars *tp_vars)
+				 struct batadv_tp_sender *tp_vars)
 {
 	enum batadv_tp_meter_reason reason;
 	u32 session_cookie;
@@ -449,7 +448,7 @@ static void batadv_tp_sender_end(struct batadv_priv *bat_priv,
 
 	batadv_dbg(BATADV_DBG_TP_METER, bat_priv,
 		   "Test towards %pM finished..shutting down (reason=%d)\n",
-		   tp_vars->other_end, reason);
+		   tp_vars->common.other_end, reason);
 
 	batadv_dbg(BATADV_DBG_TP_METER, bat_priv,
 		   "Last timing stats: SRTT=%ums RTTVAR=%ums RTO=%ums\n",
@@ -459,11 +458,11 @@ static void batadv_tp_sender_end(struct batadv_priv *bat_priv,
 		   "Final values: cwnd=%u ss_threshold=%u\n",
 		   tp_vars->cwnd, tp_vars->ss_threshold);
 
-	session_cookie = batadv_tp_session_cookie(tp_vars->session,
+	session_cookie = batadv_tp_session_cookie(tp_vars->common.session,
 						  tp_vars->icmp_uid);
 
 	batadv_tp_batctl_notify(reason,
-				tp_vars->other_end,
+				tp_vars->common.other_end,
 				bat_priv,
 				tp_vars->start_time,
 				atomic64_read(&tp_vars->tot_sent),
@@ -475,7 +474,7 @@ static void batadv_tp_sender_end(struct batadv_priv *bat_priv,
  * @tp_vars: the private data of the current TP meter session
  * @reason: reason for tp meter session stop
  */
-static void batadv_tp_sender_shutdown(struct batadv_tp_vars *tp_vars,
+static void batadv_tp_sender_shutdown(struct batadv_tp_sender *tp_vars,
 				      enum batadv_tp_meter_reason reason)
 {
 	atomic_cmpxchg(&tp_vars->send_result, 0, reason);
@@ -487,7 +486,7 @@ static void batadv_tp_sender_shutdown(struct batadv_tp_vars *tp_vars,
  *
  * Return: whether stop reason was found
  */
-static bool batadv_tp_sender_stopped(struct batadv_tp_vars *tp_vars)
+static bool batadv_tp_sender_stopped(struct batadv_tp_sender *tp_vars)
 {
 	return atomic_read(&tp_vars->send_result) != 0;
 }
@@ -499,10 +498,10 @@ static bool batadv_tp_sender_stopped(struct batadv_tp_vars *tp_vars)
 static void batadv_tp_sender_finish(struct work_struct *work)
 {
 	struct delayed_work *delayed_work;
-	struct batadv_tp_vars *tp_vars;
+	struct batadv_tp_sender *tp_vars;
 
 	delayed_work = to_delayed_work(work);
-	tp_vars = container_of(delayed_work, struct batadv_tp_vars,
+	tp_vars = container_of(delayed_work, struct batadv_tp_sender,
 			       finish_work);
 
 	batadv_tp_sender_shutdown(tp_vars, BATADV_TP_REASON_COMPLETE);
@@ -514,7 +513,7 @@ static void batadv_tp_sender_finish(struct work_struct *work)
  *
  * Reschedule the timer using tp_vars->rto as delay
  */
-static void batadv_tp_reset_sender_timer(struct batadv_tp_vars *tp_vars)
+static void batadv_tp_reset_sender_timer(struct batadv_tp_sender *tp_vars)
 {
 	/* most of the time this function is invoked while normal packet
 	 * reception...
@@ -523,7 +522,7 @@ static void batadv_tp_reset_sender_timer(struct batadv_tp_vars *tp_vars)
 		/* timer ref will be dropped in batadv_tp_sender_cleanup */
 		return;
 
-	mod_timer(&tp_vars->timer, jiffies + msecs_to_jiffies(tp_vars->rto));
+	mod_timer(&tp_vars->common.timer, jiffies + msecs_to_jiffies(tp_vars->rto));
 }
 
 /**
@@ -536,8 +535,8 @@ static void batadv_tp_reset_sender_timer(struct batadv_tp_vars *tp_vars)
  */
 static void batadv_tp_sender_timeout(struct timer_list *t)
 {
-	struct batadv_tp_vars *tp_vars = timer_container_of(tp_vars, t, timer);
-	struct batadv_priv *bat_priv = tp_vars->bat_priv;
+	struct batadv_tp_sender *tp_vars = timer_container_of(tp_vars, t, common.timer);
+	struct batadv_priv *bat_priv = tp_vars->common.bat_priv;
 
 	if (batadv_tp_sender_stopped(tp_vars))
 		return;
@@ -562,7 +561,7 @@ static void batadv_tp_sender_timeout(struct timer_list *t)
 
 	batadv_dbg(BATADV_DBG_TP_METER, bat_priv,
 		   "Meter: RTO fired during test towards %pM! cwnd=%u new ss_thr=%u, resetting last_sent to %u\n",
-		   tp_vars->other_end, tp_vars->cwnd, tp_vars->ss_threshold,
+		   tp_vars->common.other_end, tp_vars->cwnd, tp_vars->ss_threshold,
 		   atomic_read(&tp_vars->last_acked));
 
 	tp_vars->cwnd = BATADV_TP_PLEN * 3;
@@ -582,7 +581,7 @@ static void batadv_tp_sender_timeout(struct timer_list *t)
  * @buf: Buffer to fill with bytes
  * @nbytes: amount of pseudorandom bytes
  */
-static void batadv_tp_fill_prerandom(struct batadv_tp_vars *tp_vars,
+static void batadv_tp_fill_prerandom(struct batadv_tp_sender *tp_vars,
 				     u8 *buf, size_t nbytes)
 {
 	u32 local_offset;
@@ -625,7 +624,7 @@ static void batadv_tp_fill_prerandom(struct batadv_tp_vars *tp_vars,
  * not reachable, BATADV_TP_REASON_MEMORY_ERROR if the packet couldn't be
  * allocated
  */
-static int batadv_tp_send_msg(struct batadv_tp_vars *tp_vars, const u8 *src,
+static int batadv_tp_send_msg(struct batadv_tp_sender *tp_vars, const u8 *src,
 			      struct batadv_orig_node *orig_node,
 			      u32 seqno, size_t len, const u8 *session,
 			      int uid, u32 timestamp)
@@ -681,7 +680,7 @@ static void batadv_tp_recv_ack(struct batadv_priv *bat_priv,
 	struct batadv_hard_iface *primary_if = NULL;
 	struct batadv_orig_node *orig_node = NULL;
 	const struct batadv_icmp_tp_packet *icmp;
-	struct batadv_tp_vars *tp_vars;
+	struct batadv_tp_sender *tp_vars;
 	const unsigned char *dev_addr;
 	size_t packet_len, mss;
 	u32 rtt, recv_ack, cwnd;
@@ -693,8 +692,8 @@ static void batadv_tp_recv_ack(struct batadv_priv *bat_priv,
 	icmp = (struct batadv_icmp_tp_packet *)skb->data;
 
 	/* find the tp_vars */
-	tp_vars = batadv_tp_list_find_session(bat_priv, icmp->orig,
-					      icmp->session, BATADV_TP_SENDER);
+	tp_vars = batadv_tp_list_find_sender_session(bat_priv, icmp->orig,
+						     icmp->session);
 	if (unlikely(!tp_vars))
 		return;
 
@@ -804,7 +803,7 @@ static void batadv_tp_recv_ack(struct batadv_priv *bat_priv,
 out:
 	batadv_hardif_put(primary_if);
 	batadv_orig_node_put(orig_node);
-	batadv_tp_vars_put(tp_vars);
+	batadv_tp_sender_put(tp_vars);
 }
 
 /**
@@ -814,7 +813,7 @@ static void batadv_tp_recv_ack(struct batadv_priv *bat_priv,
  *
  * Return: true when congestion window is not full, false otherwise
  */
-static bool batadv_tp_avail(struct batadv_tp_vars *tp_vars,
+static bool batadv_tp_avail(struct batadv_tp_sender *tp_vars,
 			    size_t payload_len)
 {
 	u32 win_left, win_limit;
@@ -836,7 +835,7 @@ static bool batadv_tp_avail(struct batadv_tp_vars *tp_vars,
  *  remaining jiffies (at least 1) if the condition evaluated to true before
  *  the timeout elapsed, or -ERESTARTSYS if it was interrupted by a signal.
  */
-static int batadv_tp_wait_available(struct batadv_tp_vars *tp_vars, size_t plen)
+static int batadv_tp_wait_available(struct batadv_tp_sender *tp_vars, size_t plen)
 {
 	int ret;
 
@@ -855,20 +854,14 @@ static int batadv_tp_wait_available(struct batadv_tp_vars *tp_vars, size_t plen)
  */
 static int batadv_tp_send(void *arg)
 {
-	struct batadv_tp_vars *tp_vars = arg;
-	struct batadv_priv *bat_priv = tp_vars->bat_priv;
+	struct batadv_tp_sender *tp_vars = arg;
+	struct batadv_priv *bat_priv = tp_vars->common.bat_priv;
 	struct batadv_hard_iface *primary_if = NULL;
 	struct batadv_orig_node *orig_node = NULL;
 	size_t payload_len, packet_len;
 	int err = 0;
 
-	if (unlikely(tp_vars->role != BATADV_TP_SENDER)) {
-		err = BATADV_TP_REASON_DST_UNREACHABLE;
-		batadv_tp_sender_shutdown(tp_vars, err);
-		goto out;
-	}
-
-	orig_node = batadv_orig_hash_find(bat_priv, tp_vars->other_end);
+	orig_node = batadv_orig_hash_find(bat_priv, tp_vars->common.other_end);
 	if (unlikely(!orig_node)) {
 		err = BATADV_TP_REASON_DST_UNREACHABLE;
 		batadv_tp_sender_shutdown(tp_vars, err);
@@ -911,7 +904,7 @@ static int batadv_tp_send(void *arg)
 		err = batadv_tp_send_msg(tp_vars, primary_if->net_dev->dev_addr,
 					 orig_node, tp_vars->last_sent,
 					 packet_len,
-					 tp_vars->session, tp_vars->icmp_uid,
+					 tp_vars->common.session, tp_vars->icmp_uid,
 					 jiffies_to_msecs(jiffies));
 
 		/* something went wrong during the preparation/transmission */
@@ -939,7 +932,7 @@ static int batadv_tp_send(void *arg)
 	batadv_tp_sender_cleanup(tp_vars);
 	complete(&tp_vars->finished);
 
-	batadv_tp_vars_put(tp_vars);
+	batadv_tp_sender_put(tp_vars);
 
 	return 0;
 }
@@ -949,24 +942,24 @@ static int batadv_tp_send(void *arg)
  *  sender
  * @tp_vars: the private data of the current TP meter session
  */
-static void batadv_tp_start_kthread(struct batadv_tp_vars *tp_vars)
+static void batadv_tp_start_kthread(struct batadv_tp_sender *tp_vars)
 {
 	struct task_struct *kthread;
-	struct batadv_priv *bat_priv = tp_vars->bat_priv;
+	struct batadv_priv *bat_priv = tp_vars->common.bat_priv;
 	u32 session_cookie;
 
-	kref_get(&tp_vars->refcount);
+	kref_get(&tp_vars->common.refcount);
 	kthread = kthread_create(batadv_tp_send, tp_vars, "kbatadv_tp_meter");
 	if (IS_ERR(kthread)) {
-		session_cookie = batadv_tp_session_cookie(tp_vars->session,
+		session_cookie = batadv_tp_session_cookie(tp_vars->common.session,
 							  tp_vars->icmp_uid);
 		pr_err("batadv: cannot create tp meter kthread\n");
 		batadv_tp_batctl_error_notify(BATADV_TP_REASON_MEMORY_ERROR,
-					      tp_vars->other_end,
+					      tp_vars->common.other_end,
 					      bat_priv, session_cookie);
 
 		/* drop reserved reference for kthread */
-		batadv_tp_vars_put(tp_vars);
+		batadv_tp_sender_put(tp_vars);
 
 		/* cleanup of failed tp meter variables */
 		batadv_tp_sender_cleanup(tp_vars);
@@ -987,7 +980,7 @@ static void batadv_tp_start_kthread(struct batadv_tp_vars *tp_vars)
 void batadv_tp_start(struct batadv_priv *bat_priv, const u8 *dst,
 		     u32 test_length, u32 *cookie)
 {
-	struct batadv_tp_vars *tp_vars;
+	struct batadv_tp_sender *tp_vars;
 	u8 session_id[2];
 	u8 icmp_uid;
 	u32 session_cookie;
@@ -1037,11 +1030,10 @@ void batadv_tp_start(struct batadv_priv *bat_priv, const u8 *dst,
 	}
 
 	/* initialize tp_vars */
-	ether_addr_copy(tp_vars->other_end, dst);
-	kref_init(&tp_vars->refcount);
-	tp_vars->role = BATADV_TP_SENDER;
+	ether_addr_copy(tp_vars->common.other_end, dst);
+	kref_init(&tp_vars->common.refcount);
 	atomic_set(&tp_vars->send_result, 0);
-	memcpy(tp_vars->session, session_id, sizeof(session_id));
+	memcpy(tp_vars->common.session, session_id, sizeof(session_id));
 	tp_vars->icmp_uid = icmp_uid;
 
 	tp_vars->last_sent = BATADV_TP_FIRST_SEQ;
@@ -1068,25 +1060,25 @@ void batadv_tp_start(struct batadv_priv *bat_priv, const u8 *dst,
 
 	atomic64_set(&tp_vars->tot_sent, 0);
 
-	kref_get(&tp_vars->refcount);
-	timer_setup(&tp_vars->timer, batadv_tp_sender_timeout, 0);
+	kref_get(&tp_vars->common.refcount);
+	timer_setup(&tp_vars->common.timer, batadv_tp_sender_timeout, 0);
 
-	tp_vars->bat_priv = bat_priv;
+	tp_vars->common.bat_priv = bat_priv;
 	tp_vars->start_time = jiffies;
 
 	init_waitqueue_head(&tp_vars->more_bytes);
 	init_completion(&tp_vars->finished);
 
-	spin_lock_init(&tp_vars->unacked_lock);
-	INIT_LIST_HEAD(&tp_vars->unacked_list);
+	spin_lock_init(&tp_vars->common.unacked_lock);
+	INIT_LIST_HEAD(&tp_vars->common.unacked_list);
 
 	spin_lock_init(&tp_vars->cwnd_lock);
 
 	tp_vars->prerandom_offset = 0;
 	spin_lock_init(&tp_vars->prerandom_lock);
 
-	kref_get(&tp_vars->refcount);
-	hlist_add_head_rcu(&tp_vars->list, &bat_priv->tp_list);
+	kref_get(&tp_vars->common.refcount);
+	hlist_add_head_rcu(&tp_vars->common.list, &bat_priv->tp_sender_list);
 	spin_unlock_bh(&bat_priv->tp_list_lock);
 
 	tp_vars->test_length = test_length;
@@ -1106,7 +1098,7 @@ void batadv_tp_start(struct batadv_priv *bat_priv, const u8 *dst,
 	batadv_tp_start_kthread(tp_vars);
 
 	/* don't return reference to new tp_vars */
-	batadv_tp_vars_put(tp_vars);
+	batadv_tp_sender_put(tp_vars);
 }
 
 /**
@@ -1119,7 +1111,7 @@ void batadv_tp_stop(struct batadv_priv *bat_priv, const u8 *dst,
 		    u8 return_value)
 {
 	struct batadv_orig_node *orig_node;
-	struct batadv_tp_vars *tp_vars;
+	struct batadv_tp_sender *tp_vars;
 
 	batadv_dbg(BATADV_DBG_TP_METER, bat_priv,
 		   "Meter: stopping test towards %pM\n", dst);
@@ -1128,7 +1120,7 @@ void batadv_tp_stop(struct batadv_priv *bat_priv, const u8 *dst,
 	if (!orig_node)
 		return;
 
-	tp_vars = batadv_tp_list_find(bat_priv, orig_node->orig, BATADV_TP_SENDER);
+	tp_vars = batadv_tp_list_find_sender(bat_priv, orig_node->orig);
 	if (!tp_vars) {
 		batadv_dbg(BATADV_DBG_TP_METER, bat_priv,
 			   "Meter: trying to interrupt an already over connection\n");
@@ -1136,20 +1128,75 @@ void batadv_tp_stop(struct batadv_priv *bat_priv, const u8 *dst,
 	}
 
 	batadv_tp_sender_shutdown(tp_vars, return_value);
-	batadv_tp_vars_put(tp_vars);
+	batadv_tp_sender_put(tp_vars);
 out_put_orig_node:
 	batadv_orig_node_put(orig_node);
 }
 
+/**
+ * batadv_tp_list_find_receiver_session() - find tp_vars receiver session
+ *  object in the global list
+ * @bat_priv: the bat priv with all the mesh interface information
+ * @dst: the other endpoint MAC address to look for
+ * @session: session identifier
+ *
+ * Look for a tp_vars object matching dst as end_point, session as tp meter
+ * session and return it after having increment the refcounter. Return NULL
+ * is not found
+ *
+ * Return: matching tp_vars or NULL when no tp_vars was found
+ */
+static struct batadv_tp_receiver *
+batadv_tp_list_find_receiver_session(struct batadv_priv *bat_priv, const u8 *dst,
+				     const u8 *session)
+{
+	struct batadv_tp_receiver *pos, *tp_vars = NULL;
+
+	rcu_read_lock();
+	hlist_for_each_entry_rcu(pos, &bat_priv->tp_receiver_list, common.list) {
+		if (!batadv_compare_eth(pos->common.other_end, dst))
+			continue;
+
+		if (memcmp(pos->common.session, session, sizeof(pos->common.session)) != 0)
+			continue;
+
+		/* most of the time this function is invoked during the normal
+		 * process..it makes sense to pay more when the session is
+		 * finished and to speed the process up during the measurement
+		 */
+		if (unlikely(!kref_get_unless_zero(&pos->common.refcount)))
+			continue;
+
+		tp_vars = pos;
+		break;
+	}
+	rcu_read_unlock();
+
+	return tp_vars;
+}
+
+/**
+ * batadv_tp_receiver_put() - decrement the batadv_tp_receiver
+ *  refcounter and possibly release it
+ * @tp_vars: the private data of the current TP meter session to be free'd
+ */
+static void batadv_tp_receiver_put(struct batadv_tp_receiver *tp_vars)
+{
+	if (!tp_vars)
+		return;
+
+	kref_put(&tp_vars->common.refcount, batadv_tp_vars_common_release);
+}
+
 /**
  * batadv_tp_reset_receiver_timer() - reset the receiver shutdown timer
  * @tp_vars: the private data of the current TP meter session
  *
  * start the receiver shutdown timer or reset it if already started
  */
-static void batadv_tp_reset_receiver_timer(struct batadv_tp_vars *tp_vars)
+static void batadv_tp_reset_receiver_timer(struct batadv_tp_receiver *tp_vars)
 {
-	mod_timer(&tp_vars->timer,
+	mod_timer(&tp_vars->common.timer,
 		  jiffies + msecs_to_jiffies(BATADV_TP_RECV_TIMEOUT));
 }
 
@@ -1160,11 +1207,11 @@ static void batadv_tp_reset_receiver_timer(struct batadv_tp_vars *tp_vars)
  */
 static void batadv_tp_receiver_shutdown(struct timer_list *t)
 {
-	struct batadv_tp_vars *tp_vars = timer_container_of(tp_vars, t, timer);
+	struct batadv_tp_receiver *tp_vars = timer_container_of(tp_vars, t, common.timer);
 	struct batadv_tp_unacked *un, *safe;
 	struct batadv_priv *bat_priv;
 
-	bat_priv = tp_vars->bat_priv;
+	bat_priv = tp_vars->common.bat_priv;
 
 	/* if there is recent activity rearm the timer */
 	if (!batadv_has_timed_out(tp_vars->last_recv_time,
@@ -1176,22 +1223,23 @@ static void batadv_tp_receiver_shutdown(struct timer_list *t)
 
 	batadv_dbg(BATADV_DBG_TP_METER, bat_priv,
 		   "Shutting down for inactivity (more than %dms) from %pM\n",
-		   BATADV_TP_RECV_TIMEOUT, tp_vars->other_end);
+		   BATADV_TP_RECV_TIMEOUT, tp_vars->common.other_end);
 
-	batadv_tp_list_detach(tp_vars);
+	if (batadv_tp_list_detach(&tp_vars->common))
+		batadv_tp_receiver_put(tp_vars);
 
-	spin_lock_bh(&tp_vars->unacked_lock);
-	list_for_each_entry_safe(un, safe, &tp_vars->unacked_list, list) {
+	spin_lock_bh(&tp_vars->common.unacked_lock);
+	list_for_each_entry_safe(un, safe, &tp_vars->common.unacked_list, list) {
 		list_del(&un->list);
 		kfree(un);
 	}
-	spin_unlock_bh(&tp_vars->unacked_lock);
+	spin_unlock_bh(&tp_vars->common.unacked_lock);
 
 	/* drop reference of timer */
 	if (WARN_ON(atomic_xchg(&tp_vars->receiving, 0) != 1))
 		return;
 
-	batadv_tp_vars_put(tp_vars);
+	batadv_tp_receiver_put(tp_vars);
 }
 
 /**
@@ -1275,7 +1323,7 @@ static int batadv_tp_send_ack(struct batadv_priv *bat_priv, const u8 *dst,
  *
  * Return: true if the packed has been successfully processed, false otherwise
  */
-static bool batadv_tp_handle_out_of_order(struct batadv_tp_vars *tp_vars,
+static bool batadv_tp_handle_out_of_order(struct batadv_tp_receiver *tp_vars,
 					  const struct sk_buff *skb)
 {
 	const struct batadv_icmp_tp_packet *icmp;
@@ -1293,10 +1341,10 @@ static bool batadv_tp_handle_out_of_order(struct batadv_tp_vars *tp_vars,
 	payload_len = skb->len - sizeof(struct batadv_unicast_packet);
 	new->len = payload_len;
 
-	spin_lock_bh(&tp_vars->unacked_lock);
+	spin_lock_bh(&tp_vars->common.unacked_lock);
 	/* if the list is empty immediately attach this new object */
-	if (list_empty(&tp_vars->unacked_list)) {
-		list_add(&new->list, &tp_vars->unacked_list);
+	if (list_empty(&tp_vars->common.unacked_list)) {
+		list_add(&new->list, &tp_vars->common.unacked_list);
 		goto out;
 	}
 
@@ -1307,7 +1355,7 @@ static bool batadv_tp_handle_out_of_order(struct batadv_tp_vars *tp_vars,
 	 * the last received packet (the one being processed now) has a bigger
 	 * seqno than all the others already stored.
 	 */
-	list_for_each_entry_reverse(un, &tp_vars->unacked_list, list) {
+	list_for_each_entry_reverse(un, &tp_vars->common.unacked_list, list) {
 		/* check for duplicates */
 		if (new->seqno == un->seqno) {
 			if (new->len > un->len)
@@ -1332,10 +1380,10 @@ static bool batadv_tp_handle_out_of_order(struct batadv_tp_vars *tp_vars,
 
 	/* received packet with smallest seqno out of order; add it to front */
 	if (!added)
-		list_add(&new->list, &tp_vars->unacked_list);
+		list_add(&new->list, &tp_vars->common.unacked_list);
 
 out:
-	spin_unlock_bh(&tp_vars->unacked_lock);
+	spin_unlock_bh(&tp_vars->common.unacked_lock);
 
 	return true;
 }
@@ -1345,7 +1393,7 @@ static bool batadv_tp_handle_out_of_order(struct batadv_tp_vars *tp_vars,
  *  without gaps
  * @tp_vars: the private data of the current TP meter session
  */
-static void batadv_tp_ack_unordered(struct batadv_tp_vars *tp_vars)
+static void batadv_tp_ack_unordered(struct batadv_tp_receiver *tp_vars)
 {
 	struct batadv_tp_unacked *un, *safe;
 	u32 to_ack;
@@ -1353,8 +1401,8 @@ static void batadv_tp_ack_unordered(struct batadv_tp_vars *tp_vars)
 	/* go through the unacked packet list and possibly ACK them as
 	 * well
 	 */
-	spin_lock_bh(&tp_vars->unacked_lock);
-	list_for_each_entry_safe(un, safe, &tp_vars->unacked_list, list) {
+	spin_lock_bh(&tp_vars->common.unacked_lock);
+	list_for_each_entry_safe(un, safe, &tp_vars->common.unacked_list, list) {
 		/* the list is ordered, therefore it is possible to stop as soon
 		 * there is a gap between the last acked seqno and the seqno of
 		 * the packet under inspection
@@ -1370,7 +1418,7 @@ static void batadv_tp_ack_unordered(struct batadv_tp_vars *tp_vars)
 		list_del(&un->list);
 		kfree(un);
 	}
-	spin_unlock_bh(&tp_vars->unacked_lock);
+	spin_unlock_bh(&tp_vars->common.unacked_lock);
 }
 
 /**
@@ -1380,18 +1428,18 @@ static void batadv_tp_ack_unordered(struct batadv_tp_vars *tp_vars)
  *
  * Return: corresponding tp_vars or NULL on errors
  */
-static struct batadv_tp_vars *
+static struct batadv_tp_receiver *
 batadv_tp_init_recv(struct batadv_priv *bat_priv,
 		    const struct batadv_icmp_tp_packet *icmp)
 {
-	struct batadv_tp_vars *tp_vars = NULL;
+	struct batadv_tp_receiver *tp_vars = NULL;
 
 	spin_lock_bh(&bat_priv->tp_list_lock);
 	if (atomic_read(&bat_priv->mesh_state) != BATADV_MESH_ACTIVE)
 		goto out_unlock;
 
-	tp_vars = batadv_tp_list_find_session(bat_priv, icmp->orig,
-					      icmp->session, BATADV_TP_RECEIVER);
+	tp_vars = batadv_tp_list_find_receiver_session(bat_priv, icmp->orig,
+						       icmp->session);
 	if (tp_vars)
 		goto out_unlock;
 
@@ -1407,22 +1455,21 @@ batadv_tp_init_recv(struct batadv_priv *bat_priv,
 		goto out_unlock;
 	}
 
-	ether_addr_copy(tp_vars->other_end, icmp->orig);
-	tp_vars->role = BATADV_TP_RECEIVER;
+	ether_addr_copy(tp_vars->common.other_end, icmp->orig);
 	atomic_set(&tp_vars->receiving, 1);
-	memcpy(tp_vars->session, icmp->session, sizeof(tp_vars->session));
+	memcpy(tp_vars->common.session, icmp->session, sizeof(tp_vars->common.session));
 	tp_vars->last_recv = BATADV_TP_FIRST_SEQ;
-	tp_vars->bat_priv = bat_priv;
-	kref_init(&tp_vars->refcount);
+	tp_vars->common.bat_priv = bat_priv;
+	kref_init(&tp_vars->common.refcount);
 
-	spin_lock_init(&tp_vars->unacked_lock);
-	INIT_LIST_HEAD(&tp_vars->unacked_list);
+	spin_lock_init(&tp_vars->common.unacked_lock);
+	INIT_LIST_HEAD(&tp_vars->common.unacked_list);
 
-	kref_get(&tp_vars->refcount);
-	hlist_add_head_rcu(&tp_vars->list, &bat_priv->tp_list);
+	kref_get(&tp_vars->common.refcount);
+	hlist_add_head_rcu(&tp_vars->common.list, &bat_priv->tp_receiver_list);
 
-	kref_get(&tp_vars->refcount);
-	timer_setup(&tp_vars->timer, batadv_tp_receiver_shutdown, 0);
+	kref_get(&tp_vars->common.refcount);
+	timer_setup(&tp_vars->common.timer, batadv_tp_receiver_shutdown, 0);
 
 	batadv_tp_reset_receiver_timer(tp_vars);
 
@@ -1443,7 +1490,7 @@ static void batadv_tp_recv_msg(struct batadv_priv *bat_priv,
 			       const struct sk_buff *skb)
 {
 	const struct batadv_icmp_tp_packet *icmp;
-	struct batadv_tp_vars *tp_vars;
+	struct batadv_tp_receiver *tp_vars;
 	size_t packet_size;
 	u32 seqno;
 
@@ -1461,8 +1508,8 @@ static void batadv_tp_recv_msg(struct batadv_priv *bat_priv,
 			goto out;
 		}
 	} else {
-		tp_vars = batadv_tp_list_find_session(bat_priv, icmp->orig,
-						      icmp->session, BATADV_TP_RECEIVER);
+		tp_vars = batadv_tp_list_find_receiver_session(bat_priv, icmp->orig,
+							       icmp->session);
 		if (!tp_vars) {
 			batadv_dbg(BATADV_DBG_TP_METER, bat_priv,
 				   "Unexpected packet from %pM!\n",
@@ -1506,7 +1553,7 @@ static void batadv_tp_recv_msg(struct batadv_priv *bat_priv,
 	batadv_tp_send_ack(bat_priv, icmp->orig, tp_vars->last_recv,
 			   icmp->timestamp, icmp->session, icmp->uid);
 out:
-	batadv_tp_vars_put(tp_vars);
+	batadv_tp_receiver_put(tp_vars);
 }
 
 /**
@@ -1546,45 +1593,58 @@ void batadv_tp_meter_recv(struct batadv_priv *bat_priv, struct sk_buff *skb)
  */
 void batadv_tp_stop_all(struct batadv_priv *bat_priv)
 {
-	struct batadv_tp_vars *tp_vars[BATADV_TP_MAX_NUM];
-	struct batadv_tp_vars *tp_var;
-	size_t count = 0;
+	struct batadv_tp_receiver *tp_receivers[BATADV_TP_MAX_NUM];
+	struct batadv_tp_sender *tp_senders[BATADV_TP_MAX_NUM];
+	struct batadv_tp_receiver *tp_receiver;
+	struct batadv_tp_sender *tp_sender;
+	size_t receiver_count = 0;
+	size_t sender_count = 0;
 	size_t i;
 
 	spin_lock_bh(&bat_priv->tp_list_lock);
-	hlist_for_each_entry(tp_var, &bat_priv->tp_list, list) {
-		if (WARN_ON_ONCE(count >= BATADV_TP_MAX_NUM))
+	hlist_for_each_entry(tp_receiver, &bat_priv->tp_receiver_list, common.list) {
+		if (WARN_ON_ONCE(receiver_count >= BATADV_TP_MAX_NUM))
 			break;
 
-		if (!kref_get_unless_zero(&tp_var->refcount))
+		if (!kref_get_unless_zero(&tp_receiver->common.refcount))
 			continue;
 
-		tp_vars[count++] = tp_var;
+		tp_receivers[receiver_count++] = tp_receiver;
+	}
+
+	hlist_for_each_entry(tp_sender, &bat_priv->tp_sender_list, common.list) {
+		if (WARN_ON_ONCE(sender_count >= BATADV_TP_MAX_NUM))
+			break;
+
+		if (!kref_get_unless_zero(&tp_sender->common.refcount))
+			continue;
+
+		tp_senders[sender_count++] = tp_sender;
 	}
 	spin_unlock_bh(&bat_priv->tp_list_lock);
 
-	for (i = 0; i < count; i++) {
-		tp_var = tp_vars[i];
+	for (i = 0; i < receiver_count; i++) {
+		tp_receiver = tp_receivers[i];
 
-		switch (tp_var->role) {
-		case BATADV_TP_SENDER:
-			batadv_tp_sender_shutdown(tp_var,
-						  BATADV_TP_REASON_CANCEL);
-			wake_up(&tp_var->more_bytes);
-			wait_for_completion(&tp_var->finished);
-			break;
-		case BATADV_TP_RECEIVER:
-			batadv_tp_list_detach(tp_var);
-			timer_shutdown_sync(&tp_var->timer);
+		if (batadv_tp_list_detach(&tp_receiver->common))
+			batadv_tp_receiver_put(tp_receiver);
 
-			if (atomic_xchg(&tp_var->receiving, 0) != 1)
-				break;
+		timer_shutdown_sync(&tp_receiver->common.timer);
 
-			batadv_tp_vars_put(tp_var);
-			break;
-		}
+		if (atomic_xchg(&tp_receiver->receiving, 0) != 1)
+			continue;
 
-		batadv_tp_vars_put(tp_var);
+		batadv_tp_receiver_put(tp_receiver);
+	}
+
+	for (i = 0; i < sender_count; i++) {
+		tp_sender = tp_senders[i];
+
+		batadv_tp_sender_shutdown(tp_sender, BATADV_TP_REASON_CANCEL);
+		wake_up(&tp_sender->more_bytes);
+		wait_for_completion(&tp_sender->finished);
+
+		batadv_tp_sender_put(tp_sender);
 	}
 
 	synchronize_net();
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index fb0e4cb8..1500372b 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -1288,21 +1288,10 @@ struct batadv_tp_unacked {
 };
 
 /**
- * enum batadv_tp_meter_role - Modus in tp meter session
+ * struct batadv_tp_vars_common - common tp meter private variables per session
  */
-enum batadv_tp_meter_role {
-	/** @BATADV_TP_RECEIVER: Initialized as receiver */
-	BATADV_TP_RECEIVER,
-
-	/** @BATADV_TP_SENDER: Initialized as sender */
-	BATADV_TP_SENDER
-};
-
-/**
- * struct batadv_tp_vars - tp meter private variables per session
- */
-struct batadv_tp_vars {
-	/** @list: list node for &bat_priv.tp_list */
+struct batadv_tp_vars_common {
+	/** @list: list node for &bat_priv.tp_sender_list/&bat_priv.tp_receiver_list */
 	struct hlist_node list;
 
 	/** @timer: timer for ack (receiver) and retry (sender) */
@@ -1311,14 +1300,34 @@ struct batadv_tp_vars {
 	/** @bat_priv: pointer to the mesh object */
 	struct batadv_priv *bat_priv;
 
-	/** @start_time: start time in jiffies */
-	unsigned long start_time;
-
 	/** @other_end: mac address of remote */
 	u8 other_end[ETH_ALEN];
 
-	/** @role: receiver/sender modi */
-	enum batadv_tp_meter_role role;
+	/** @session: TP session identifier */
+	u8 session[2];
+
+	/** @unacked_list: list of unacked packets (meta-info only) */
+	struct list_head unacked_list;
+
+	/** @unacked_lock: protect unacked_list */
+	spinlock_t unacked_lock;
+
+	/** @refcount: number of context where the object is used */
+	struct kref refcount;
+
+	/** @rcu: struct used for freeing in an RCU-safe manner */
+	struct rcu_head rcu;
+};
+
+/**
+ * struct batadv_tp_sender - sender tp meter private variables per session
+ */
+struct batadv_tp_sender {
+	/** @common: common batadv_tp_vars (best be first member) */
+	struct batadv_tp_vars_common common;
+
+	/** @start_time: start time in jiffies */
+	unsigned long start_time;
 
 	/**
 	 * @send_result: 0 when sending is ongoing and otherwise
@@ -1326,8 +1335,14 @@ struct batadv_tp_vars {
 	 */
 	atomic_t send_result;
 
-	/** @receiving: receiving binary semaphore: 1 if receiving, 0 is not */
-	atomic_t receiving;
+	/** @last_sent: last sent byte, not yet acked */
+	u32 last_sent;
+
+	/** @fast_recovery: true if in Fast Recovery mode */
+	unsigned char fast_recovery:1;
+
+	/** @recover: last sent seqno when entering Fast Recovery */
+	u32 recover;
 
 	/** @finish_work: work item for the finishing procedure */
 	struct delayed_work finish_work;
@@ -1338,14 +1353,9 @@ struct batadv_tp_vars {
 	/** @test_length: test length in milliseconds */
 	u32 test_length;
 
-	/** @session: TP session identifier */
-	u8 session[2];
-
 	/** @icmp_uid: local ICMP "socket" index */
 	u8 icmp_uid;
 
-	/* sender variables */
-
 	/** @dec_cwnd: decimal part of the cwnd used during linear growth */
 	u16 dec_cwnd;
 
@@ -1364,21 +1374,12 @@ struct batadv_tp_vars {
 	/** @last_acked: last acked byte */
 	atomic_t last_acked;
 
-	/** @last_sent: last sent byte, not yet acked */
-	u32 last_sent;
-
 	/** @tot_sent: amount of data sent/ACKed so far */
 	atomic64_t tot_sent;
 
 	/** @dup_acks: duplicate ACKs counter */
 	atomic_t dup_acks;
 
-	/** @fast_recovery: true if in Fast Recovery mode */
-	unsigned char fast_recovery:1;
-
-	/** @recover: last sent seqno when entering Fast Recovery */
-	u32 recover;
-
 	/** @rto: sender timeout */
 	u32 rto;
 
@@ -1399,26 +1400,23 @@ struct batadv_tp_vars {
 
 	/** @prerandom_lock: spinlock protecting access to prerandom_offset */
 	spinlock_t prerandom_lock;
+};
 
-	/* receiver variables */
+/**
+ * struct batadv_tp_receiver - receiver tp meter private variables per session
+ */
+struct batadv_tp_receiver {
+	/** @common: common batadv_tp_vars (best be first member) */
+	struct batadv_tp_vars_common common;
+
+	/** @receiving: receiving binary semaphore: 1 if receiving, 0 is not */
+	atomic_t receiving;
 
 	/** @last_recv: last in-order received packet */
 	u32 last_recv;
 
-	/** @unacked_list: list of unacked packets (meta-info only) */
-	struct list_head unacked_list;
-
-	/** @unacked_lock: protect unacked_list */
-	spinlock_t unacked_lock;
-
 	/** @last_recv_time: time (jiffies) a msg was received */
 	unsigned long last_recv_time;
-
-	/** @refcount: number of context where the object is used */
-	struct kref refcount;
-
-	/** @rcu: struct used for freeing in an RCU-safe manner */
-	struct rcu_head rcu;
 };
 
 /**
@@ -1598,8 +1596,11 @@ struct batadv_priv {
 	 */
 	struct hlist_head forw_bcast_list;
 
-	/** @tp_list: list of tp sessions */
-	struct hlist_head tp_list;
+	/** @tp_sender_list: list of tp sender sessions */
+	struct hlist_head tp_sender_list;
+
+	/** @tp_receiver_list: list of tp receiver sessions */
+	struct hlist_head tp_receiver_list;
 
 	/** @orig_hash: hash table containing mesh participants (orig nodes) */
 	struct batadv_hashtable *orig_hash;

-- 
2.47.3

