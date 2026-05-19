Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02907CD4F3C
	for <batman-adv@archiver.kernel.org>; Tue, 19 May 2026 07:02:49 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id D40A3809E6
	for <batman-adv@archiver.kernel.org>; Tue, 19 May 2026 09:02:12 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1779174132;
 b=V35fXU8VGYpQyQTq4IC6l18UdUo2iLo0u1ivZpz2e//UcH1ZXD/redzqJPFdknz3gQzOS
 UVsSr85+qaN5gwsJchMnUHcYYTJYANcZvUtb+M/Sqcw6nzkZ7NetXqUbuQLqFu+wE+/uqUL
 HADYY25LCa0k6YlgvBG5ZlhVH5lWanM=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1779174132; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=Fgj2vdcg33p+rE+T/zUzTIgAjOENnII84ZHfz1WqxUA=;
 b=RTIPAuTEuz6Yf3PWzfPTHwZz7fEuhahxNVU039Y0OTir6uD+sGGTbfxA+WQqxENx4JC4r
 3kWRMU9inXx/WK/kKfBPzOl44bfOodoPKHyQn1g0CZ6sNxrgoAr+Rm1Wyyd9deurvh8FKAs
 G8VHXE6KdlxtUlfvOAZuz/QgV6kaa/8=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id DBCD1802ED
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 19 May 2026 09:00:42 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1779174042;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=Fgj2vdcg33p+rE+T/zUzTIgAjOENnII84ZHfz1WqxUA=;
	b=EOxVH0UO7x4iPUGBXazDDiD4LpPfTNjB3GFsilkXlt4so5JsWDeHwJJbXStyLVHGI6ltjy
	oyq2P76UWUuY1ZWRYPeRNhqZGY0p/cnGFKwoOGr6suGlV9nxkaZQxPQxHqbEw1SQz8N6++
	2sXW+eiOmmAZKA3UXAAxoDB5zkYwPTI=
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1779174042;
	b=DpVh5bEcTx757JqKhEgw9zSqzPbv3IgHDH28X51KucE3Ddnf2g5KgdBVkFQ+srll3/n6hB
	5z8u+DYXiPcsUJu5ZeaHX7Z7OhdOpDJyCQpSSCRipNbi5bsD+3d+3tzafcLqToD+ei4o93
	AjxiHRQmzLA5KCHmxsU0VVvFCitiiMg=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=1hbMumkl;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 9C0EF1FE24;
	Tue, 19 May 2026 07:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1779174042;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fgj2vdcg33p+rE+T/zUzTIgAjOENnII84ZHfz1WqxUA=;
	b=1hbMumkl+RR1mof2us2pD811FmiEtiV7BDoeNwjW/flA/R5pPtXBCBn+5OhNHjDM6Xwl/3
	xPnCgjeXuj4HBvY+bBedjZPXCPKHhBMfuybcS0xP20DUaIb8b8IhkBDS/ZHkp2xjC4oj73
	tHFZW0w7zi9RjFWvluyjsMDF/w96RNE=
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 19 May 2026 09:00:36 +0200
Subject: [PATCH batadv v2 1/3] batman-adv: tp_meter: fix race condition in
 send error reporting
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-tp-reason-missing-v2-1-9c5cd1824e3b@narfation.org>
References: <20260519-tp-reason-missing-v2-0-9c5cd1824e3b@narfation.org>
In-Reply-To: <20260519-tp-reason-missing-v2-0-9c5cd1824e3b@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6450; i=sven@narfation.org;
 h=from:subject:message-id; bh=x3dR3obQYmwLTXpr53mMltm1zTuaqyPpDJQNwQDu1M0=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFk8XFOXrXC/bZm15bbdx4Q16+79mXr4sgj7QdVlIeL7Q
 sONv+yN7ChlYRDjYpAVU2TZcyX//Gb2t/Kfp308CjOHlQlkCAMXpwBMhLuFkeF7v5CLzvb+97Y2
 htqStz8x37oTs6o3c8EUB+fweyH3V5ozMkw/l5D03KaiJ3xKzeX1EqqZuYWH0/eyM+36J/pHxNX
 kLj8A
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: EVQJLHVU3BKKTQJOU5N4PM6RT7EI3NLD
X-Message-ID-Hash: EVQJLHVU3BKKTQJOU5N4PM6RT7EI3NLD
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/EVQJLHVU3BKKTQJOU5N4PM6RT7EI3NLD/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

batadv_tp_sender_shutdown() previously used two separate variables to track
session state: sending (an atomic flag indicating whether the session was
active) and reason (a plain enum storing the stop reason). This introduced
a race window between the two writes: after sending was cleared to 0,
batadv_tp_send() could observe the stopped state and call
batadv_tp_sender_end() before reason was written, causing the wrong stop
reason to be reported to the caller.

Fix this by consolidating both variables into a single atomic send_result,
which holds 0 while the session is running and the stop reason once it
ends.

Fixes: 98d7a766b645 ("batman-adv: throughput meter implementation")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/tp_meter.c | 40 +++++++++++++++++++++++++---------------
 net/batman-adv/types.h    | 10 +++++-----
 2 files changed, 30 insertions(+), 20 deletions(-)

diff --git a/net/batman-adv/tp_meter.c b/net/batman-adv/tp_meter.c
index 1fd15260..3ce6d9b2 100644
--- a/net/batman-adv/tp_meter.c
+++ b/net/batman-adv/tp_meter.c
@@ -413,11 +413,14 @@ static void batadv_tp_sender_cleanup(struct batadv_tp_vars *tp_vars)
 static void batadv_tp_sender_end(struct batadv_priv *bat_priv,
 				 struct batadv_tp_vars *tp_vars)
 {
+	enum batadv_tp_meter_reason reason;
 	u32 session_cookie;
 
+	reason = atomic_read(&tp_vars->send_result);
+
 	batadv_dbg(BATADV_DBG_TP_METER, bat_priv,
 		   "Test towards %pM finished..shutting down (reason=%d)\n",
-		   tp_vars->other_end, tp_vars->reason);
+		   tp_vars->other_end, reason);
 
 	batadv_dbg(BATADV_DBG_TP_METER, bat_priv,
 		   "Last timing stats: SRTT=%ums RTTVAR=%ums RTO=%ums\n",
@@ -430,7 +433,7 @@ static void batadv_tp_sender_end(struct batadv_priv *bat_priv,
 	session_cookie = batadv_tp_session_cookie(tp_vars->session,
 						  tp_vars->icmp_uid);
 
-	batadv_tp_batctl_notify(tp_vars->reason,
+	batadv_tp_batctl_notify(reason,
 				tp_vars->other_end,
 				bat_priv,
 				tp_vars->start_time,
@@ -446,10 +449,18 @@ static void batadv_tp_sender_end(struct batadv_priv *bat_priv,
 static void batadv_tp_sender_shutdown(struct batadv_tp_vars *tp_vars,
 				      enum batadv_tp_meter_reason reason)
 {
-	if (atomic_xchg(&tp_vars->sending, 0) != 1)
-		return;
+	atomic_cmpxchg(&tp_vars->send_result, 0, reason);
+}
 
-	tp_vars->reason = reason;
+/**
+ * batadv_tp_sender_stopped() - check if tp session was stopped with reason
+ * @tp_vars: the private data of the current TP meter session
+ *
+ * Return: whether stop reason was found
+ */
+static bool batadv_tp_sender_stopped(struct batadv_tp_vars *tp_vars)
+{
+	return atomic_read(&tp_vars->send_result) != 0;
 }
 
 /**
@@ -479,7 +490,7 @@ static void batadv_tp_reset_sender_timer(struct batadv_tp_vars *tp_vars)
 	/* most of the time this function is invoked while normal packet
 	 * reception...
 	 */
-	if (unlikely(atomic_read(&tp_vars->sending) == 0))
+	if (unlikely(batadv_tp_sender_stopped(tp_vars)))
 		/* timer ref will be dropped in batadv_tp_sender_cleanup */
 		return;
 
@@ -499,7 +510,7 @@ static void batadv_tp_sender_timeout(struct timer_list *t)
 	struct batadv_tp_vars *tp_vars = timer_container_of(tp_vars, t, timer);
 	struct batadv_priv *bat_priv = tp_vars->bat_priv;
 
-	if (atomic_read(&tp_vars->sending) == 0)
+	if (batadv_tp_sender_stopped(tp_vars))
 		return;
 
 	/* if the user waited long enough...shutdown the test */
@@ -661,7 +672,7 @@ static void batadv_tp_recv_ack(struct batadv_priv *bat_priv,
 	if (unlikely(tp_vars->role != BATADV_TP_SENDER))
 		goto out;
 
-	if (unlikely(atomic_read(&tp_vars->sending) == 0))
+	if (unlikely(batadv_tp_sender_stopped(tp_vars)))
 		goto out;
 
 	/* old ACK? silently drop it.. */
@@ -827,21 +838,21 @@ static int batadv_tp_send(void *arg)
 
 	if (unlikely(tp_vars->role != BATADV_TP_SENDER)) {
 		err = BATADV_TP_REASON_DST_UNREACHABLE;
-		tp_vars->reason = err;
+		batadv_tp_sender_shutdown(tp_vars, err);
 		goto out;
 	}
 
 	orig_node = batadv_orig_hash_find(bat_priv, tp_vars->other_end);
 	if (unlikely(!orig_node)) {
 		err = BATADV_TP_REASON_DST_UNREACHABLE;
-		tp_vars->reason = err;
+		batadv_tp_sender_shutdown(tp_vars, err);
 		goto out;
 	}
 
 	primary_if = batadv_primary_if_get_selected(bat_priv);
 	if (unlikely(!primary_if)) {
 		err = BATADV_TP_REASON_DST_UNREACHABLE;
-		tp_vars->reason = err;
+		batadv_tp_sender_shutdown(tp_vars, err);
 		goto out;
 	}
 
@@ -860,7 +871,7 @@ static int batadv_tp_send(void *arg)
 	queue_delayed_work(batadv_event_workqueue, &tp_vars->finish_work,
 			   msecs_to_jiffies(tp_vars->test_length));
 
-	while (atomic_read(&tp_vars->sending) != 0) {
+	while (!batadv_tp_sender_stopped(tp_vars)) {
 		if (unlikely(!batadv_tp_avail(tp_vars, payload_len))) {
 			batadv_tp_wait_available(tp_vars, payload_len);
 			continue;
@@ -883,8 +894,7 @@ static int batadv_tp_send(void *arg)
 				   "Meter: %s() cannot send packets (%d)\n",
 				   __func__, err);
 			/* ensure nobody else tries to stop the thread now */
-			if (atomic_xchg(&tp_vars->sending, 0) == 1)
-				tp_vars->reason = err;
+			batadv_tp_sender_shutdown(tp_vars, err);
 			break;
 		}
 
@@ -1006,7 +1016,7 @@ void batadv_tp_start(struct batadv_priv *bat_priv, const u8 *dst,
 	ether_addr_copy(tp_vars->other_end, dst);
 	kref_init(&tp_vars->refcount);
 	tp_vars->role = BATADV_TP_SENDER;
-	atomic_set(&tp_vars->sending, 1);
+	atomic_set(&tp_vars->send_result, 0);
 	memcpy(tp_vars->session, session_id, sizeof(session_id));
 	tp_vars->icmp_uid = icmp_uid;
 
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index c8c3e806..fb0e4cb8 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -1320,15 +1320,15 @@ struct batadv_tp_vars {
 	/** @role: receiver/sender modi */
 	enum batadv_tp_meter_role role;
 
-	/** @sending: sending binary semaphore: 1 if sending, 0 is not */
-	atomic_t sending;
+	/**
+	 * @send_result: 0 when sending is ongoing and otherwise
+	 * enum batadv_tp_meter_reason
+	 */
+	atomic_t send_result;
 
 	/** @receiving: receiving binary semaphore: 1 if receiving, 0 is not */
 	atomic_t receiving;
 
-	/** @reason: reason for a stopped session */
-	enum batadv_tp_meter_reason reason;
-
 	/** @finish_work: work item for the finishing procedure */
 	struct delayed_work finish_work;
 

-- 
2.47.3

