Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32127CD4F21
	for <batman@archiver.kernel.org>; Wed, 13 May 2026 21:58:28 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 7421B815BB
	for <batman@archiver.kernel.org>; Wed, 13 May 2026 23:58:26 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1778709506;
 b=DAQ4Pv9P6exsWXuFpTWUsioz+Siv4jW3m2n8VxyLu6q9muG1jlLbp0BDK12ptSYLdW+Ss
 K5CCJPb2fWEiqsajeEakYEmT40/kyTi+VIUkCFRhTlVpsWf2zoAKY2UFNRLm2VERv0H93M6
 tx2YIbfOhFsdi2pnWA9DurNl+X9k23A=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1778709506; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=B9sQE3yoRkn9Odt+RnU9UvfoRrvJ+2zV8aMuaiIp4gQ=;
 b=CohvmHyU4Ied5NfsK+z5E4chnuCKEZkWvGvW29d+PLaCO45fFMXv58MOHqtHK41UWMeZq
 HlAkH4/ZMRv5SxR9Ha7o3rsPj9EmiSgnVrtBMfAO+OiWx1I+jJqmLoavtjQmYhTOVdRtCyk
 +26t/JwFgRD9b2cLT2Fq8Ep8ev6P9yo=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id F01B28460D
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 13 May 2026 23:58:00 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1778709481;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=B9sQE3yoRkn9Odt+RnU9UvfoRrvJ+2zV8aMuaiIp4gQ=;
	b=ObmyV3Wy2OGglr6qdYjvifkqzDanI5w8dH1PTIREZA3dT/Lrrm9PU8NefinyP9YV5Nflt4
	KL8Ou+XhKBwdUwdER/aFhicbqgb8JBTvu/a0bLnupcMt6qcXItKluwv13ddQnWl+GwTe/1
	dMQ81sa8Ja5AtMJ2aGuHsA2RxQ0UbE4=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=IU69wJou;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1778709481;
	b=tMDgKKHivWt0hdIJXc8J2XyWPf0h1HbO9CVQFLzbYd7g/mb2bbMW1GKCxkqYe9sntFAHSz
	EkJVQzHMKtPtKvZQbl8g/dIp80WwrHZMl2n9FPF46bC+v3Byg+WInJM6iqGobGf2xGwVsC
	DDs2+hkqUzvNiJ4/qD9+2g7KxqQmIhs=
Received: by dvalin.narfation.org (Postfix) id A135D21550;
	Wed, 13 May 2026 21:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1778709479;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=B9sQE3yoRkn9Odt+RnU9UvfoRrvJ+2zV8aMuaiIp4gQ=;
	b=IU69wJoujvVlbAf6yG786mRLrXT2bHP6pg+7BJBK5FAbaqoNbacqqMYVXZqiSF7iR3L2SD
	Lx/Gu1lQnUwKWdphEr67wNTj1UJNWgiqTLkCHbv7t8KiIVm7Z4pv6Vqz9X6N6SZHw+1QmO
	nOBbHwK9ZaBxpHEu4XE7GWjmyozByPQ=
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 13 May 2026 23:57:52 +0200
Subject: [PATCH batadv] batman-adv: tp_meter: fix race condition in send
 error reporting
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260513-tp-reason-missing-v1-1-752a882bd61a@narfation.org>
X-B4-Tracking: v=1; b=H4sIAN/zBGoC/yWMwQqDMBAFf0XeuQvG1Bb6K6WHVTd2C42STaUg/
 ntTPc7AzAqTpGK4VSuSLGo6xQLuVKF/chyFdCiMpm4udes85ZmSsE2R3mqmcaTgmFsXfPDXM0o
 3Jwn63Z93dJx5WPA4vH26l/T5P8S2/QCFq5iffQAAAA==
X-Change-ID: 20260513-tp-reason-missing-f1aa51f3f374
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6582; i=sven@narfation.org;
 h=from:subject:message-id; bh=Ggiqg8/HLyvw+FpIib43uXCkZ+I5g4M/8Nxuq5ec3Jk=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFksnx+5MkTss1xpvjv9Uvw3Z62u5879n9n3FaQ4J717X
 tO5pvlQRykLgxgXg6yYIsueK/nnN7O/lf887eNRmDmsTCBDGLg4BWAiTl8Y/nuv3VWaWPnLqt5I
 bpa4/4nXn+y6fBqN/zzv69sl8pV13kxGhpMHzPgcrr42PLFu1sdjPxP/VgV2CheYbT3LH23Wpnl
 +Pw8A
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: PXQ5IIO7JIOI4N7QAE4KCCESMA2NGRHU
X-Message-ID-Hash: PXQ5IIO7JIOI4N7QAE4KCCESMA2NGRHU
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/PXQ5IIO7JIOI4N7QAE4KCCESMA2NGRHU/>
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
index ca6c3f63..a8a15ecc 100644
--- a/net/batman-adv/tp_meter.c
+++ b/net/batman-adv/tp_meter.c
@@ -419,11 +419,14 @@ static void batadv_tp_sender_cleanup(struct batadv_tp_vars *tp_vars)
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
@@ -436,7 +439,7 @@ static void batadv_tp_sender_end(struct batadv_priv *bat_priv,
 	session_cookie = batadv_tp_session_cookie(tp_vars->session,
 						  tp_vars->icmp_uid);
 
-	batadv_tp_batctl_notify(tp_vars->reason,
+	batadv_tp_batctl_notify(reason,
 				tp_vars->other_end,
 				bat_priv,
 				tp_vars->start_time,
@@ -452,10 +455,18 @@ static void batadv_tp_sender_end(struct batadv_priv *bat_priv,
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
@@ -485,7 +496,7 @@ static void batadv_tp_reset_sender_timer(struct batadv_tp_vars *tp_vars)
 	/* most of the time this function is invoked while normal packet
 	 * reception...
 	 */
-	if (unlikely(atomic_read(&tp_vars->sending) == 0))
+	if (unlikely(batadv_tp_sender_stopped(tp_vars)))
 		/* timer ref will be dropped in batadv_tp_sender_cleanup */
 		return;
 
@@ -505,7 +516,7 @@ static void batadv_tp_sender_timeout(struct timer_list *t)
 	struct batadv_tp_vars *tp_vars = timer_container_of(tp_vars, t, timer);
 	struct batadv_priv *bat_priv = tp_vars->bat_priv;
 
-	if (atomic_read(&tp_vars->sending) == 0)
+	if (batadv_tp_sender_stopped(tp_vars))
 		return;
 
 	/* if the user waited long enough...shutdown the test */
@@ -664,7 +675,7 @@ static void batadv_tp_recv_ack(struct batadv_priv *bat_priv,
 	if (unlikely(!tp_vars))
 		return;
 
-	if (unlikely(atomic_read(&tp_vars->sending) == 0))
+	if (unlikely(batadv_tp_sender_stopped(tp_vars)))
 		goto out;
 
 	/* old ACK? silently drop it.. */
@@ -830,21 +841,21 @@ static int batadv_tp_send(void *arg)
 
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
 
@@ -863,7 +874,7 @@ static int batadv_tp_send(void *arg)
 	queue_delayed_work(batadv_event_workqueue, &tp_vars->finish_work,
 			   msecs_to_jiffies(tp_vars->test_length));
 
-	while (atomic_read(&tp_vars->sending) != 0) {
+	while (!batadv_tp_sender_stopped(tp_vars)) {
 		if (unlikely(!batadv_tp_avail(tp_vars, payload_len))) {
 			batadv_tp_wait_available(tp_vars, payload_len);
 			continue;
@@ -886,8 +897,7 @@ static int batadv_tp_send(void *arg)
 				   "Meter: %s() cannot send packets (%d)\n",
 				   __func__, err);
 			/* ensure nobody else tries to stop the thread now */
-			if (atomic_xchg(&tp_vars->sending, 0) == 1)
-				tp_vars->reason = err;
+			batadv_tp_sender_shutdown(tp_vars, err);
 			break;
 		}
 
@@ -1009,7 +1019,7 @@ void batadv_tp_start(struct batadv_priv *bat_priv, const u8 *dst,
 	ether_addr_copy(tp_vars->other_end, dst);
 	kref_init(&tp_vars->refcount);
 	tp_vars->role = BATADV_TP_SENDER;
-	atomic_set(&tp_vars->sending, 1);
+	atomic_set(&tp_vars->send_result, 0);
 	memcpy(tp_vars->session, session_id, sizeof(session_id));
 	tp_vars->icmp_uid = icmp_uid;
 
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 739439e2..a7d1ea3a 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -1320,15 +1320,15 @@ struct batadv_tp_vars {
 	/** @role: receiver/sender modi */
 	enum batadv_tp_meter_role role;
 
-	/** @sending: sending binary semaphore: 1 if sending, 0 is not */
-	atomic_t sending;
+	/**
+	 * @stop_reason: 0 when sending is ongoing and otherwise
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
 

---
base-commit: 57c6af492c1948145db835bb3ea2980472558298
change-id: 20260513-tp-reason-missing-f1aa51f3f374

Best regards,
--  
Sven Eckelmann <sven@narfation.org>

