Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DC9CCD6E4A
	for <batman-adv@archiver.kernel.org>; Wed,  3 Jun 2026 04:26:06 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 294DE808E3
	for <batman-adv@archiver.kernel.org>; Wed, 03 Jun 2026 06:26:05 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1780460765;
 b=t3n9TrXff4hBgkAt7kwSn9OkCwKY6oSnuAE9cSjv6j6ERSj0wqao+rJD51GYymUhPcIyh
 dt8cUhID8bW9T0RPVuXLjoYKMn9dqJcfwlvn6ru2mzXrrRDArIdrxk6Zggvvmc16X9nV1Hp
 TkuXpjrn/kXBRsmg9yLCCytIm3GpWyA=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1780460765; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=eXtYzpjWfkMpO5iv14UKGqFHe9kcLPYcelm1RTaozsU=;
 b=fmmN5D2onj3gb99XYiOC6KZIOK5Dx83+tQtZIxsXBoIEKnVGPbr/ZJcp2ZyZN/HE9TLmr
 w0ClT0uP0qMpkCAwMv6Vug3gzt258xDUaLDY7LgVMoNjy8XKaOyC45KBRhKLrls1FqibEPY
 M6F/L7ZNz5vS8+C1jsDthMrEON78VzM=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 4E65C84262
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 03 Jun 2026 06:18:08 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1780460288;
	b=0rpSCwtSh0vwAh/dW6KNU03eu6NJrW7z8wTEzCnEUC4t6p5OqIUmGsi551crYI7KaaDrtg
	ismpL/KIzevTwhSO5803oFyMRK8TclkL8hH/rt+Af44Zf8H2IComIMMWvYHPvHjqlNZrgf
	RNgr8E4j6pw5s+8n0ZQUmeGOTp4+6IE=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=cgxFOfbT;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1780460288;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=eXtYzpjWfkMpO5iv14UKGqFHe9kcLPYcelm1RTaozsU=;
	b=QCfqP7zyL7VJiDwCSMcdZs4KBGqwB3oNxmKR4yYBZbc+DbKDIxHrEVnSYS9IQrxmKIIIPr
	uAP+AnqRH0FuIhVIQsORHKJG92eGCxkKEjbSgked+HZmFYIpJM4qxyMyaSYhBOCdKM+hK1
	wJrYfFl5GD43ienBgWElrnCqZB0AXf4=
Received: by dvalin.narfation.org (Postfix) id E63EF20131;
	Wed, 03 Jun 2026 04:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1780460288;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eXtYzpjWfkMpO5iv14UKGqFHe9kcLPYcelm1RTaozsU=;
	b=cgxFOfbTp9IEW/x3CQYREkxZ4iYW7XT8WxvVFI+i4SRGU2X51bpETPxQopBM3tE+PyP4bK
	PzVxzYI4mAwQ2IKzDU7OUkTa1E+YHKRJrv0KV2U8eaSlEY+Rx8/2AmU4ztEXyFMIijZSAh
	AvTjb169iAGSMox0ezGruwXqZc9q8lI=
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 03 Jun 2026 06:17:23 +0200
Subject: [PATCH batadv v6 11/11] batman-adv: tp_meter: consolidate
 congestion control variables
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260603-tp-reason-missing-v6-11-7011620f93a5@narfation.org>
References: <20260603-tp-reason-missing-v6-0-7011620f93a5@narfation.org>
In-Reply-To: <20260603-tp-reason-missing-v6-0-7011620f93a5@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=17609; i=sven@narfation.org;
 h=from:subject:message-id; bh=jFLT8EWzAUYwQOcq2qr7Gx3ygKeR2PKAvuIgRtwmNdI=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFnyq87sebqmp39i3NxpSR4vG4063U8prrSbKnN7dYRA1
 B333C/LOkpZGMS4GGTFFFn2XMk/v5n9rfznaR+PwsxhZQIZwsDFKQATifFhZLgxn51/X/ncz5vq
 JD2q64NmR/asfKvDXPNl/3p/BwHJ3O0M/xQyHIpy99+x+lK3zuTt1PfOfG8uiCm5vxSaY9rhlHy
 rjhkA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: 5A5AW6FTMOQ5TKEPIQNCTBW6TKR33CZ7
X-Message-ID-Hash: 5A5AW6FTMOQ5TKEPIQNCTBW6TKR33CZ7
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/5A5AW6FTMOQ5TKEPIQNCTBW6TKR33CZ7/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Congestion control variables in batadv_tp_sender were scattered across the
struct without clear grouping, making it difficult to reason about which
fields require cwnd_lock (now "cc_lock") protection. These should be
combined in a structure to make it more easily visible which variable
should be read/modified with the cc_lock held.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/tp_meter.c | 170 +++++++++++++++++++++++-----------------------
 net/batman-adv/types.h    |  80 ++++++++++++----------
 2 files changed, 128 insertions(+), 122 deletions(-)

diff --git a/net/batman-adv/tp_meter.c b/net/batman-adv/tp_meter.c
index e9ba1c45..978e32d9 100644
--- a/net/batman-adv/tp_meter.c
+++ b/net/batman-adv/tp_meter.c
@@ -143,12 +143,12 @@ static u32 batadv_tp_cwnd(u32 base, u32 increment, u32 min)
  * increased by MSS * MSS / CWND for every unique received ACK
  */
 static void batadv_tp_update_cwnd(struct batadv_tp_sender *tp_vars, u32 mss)
-	__must_hold(&tp_vars->cwnd_lock)
+	__must_hold(&tp_vars->cc_lock)
 {
 	/* slow start... */
-	if (tp_vars->cwnd <= tp_vars->ss_threshold) {
-		tp_vars->dec_cwnd = 0;
-		tp_vars->cwnd = batadv_tp_cwnd(tp_vars->cwnd, mss, mss);
+	if (tp_vars->cc.cwnd <= tp_vars->cc.ss_threshold) {
+		tp_vars->cc.dec_cwnd = 0;
+		tp_vars->cc.cwnd = batadv_tp_cwnd(tp_vars->cc.cwnd, mss, mss);
 		return;
 	}
 
@@ -156,13 +156,13 @@ static void batadv_tp_update_cwnd(struct batadv_tp_sender *tp_vars, u32 mss)
 	mss = min_t(u32, mss, (1U << 14) - 1);
 
 	/* increment CWND at least of 1 (section 3.1 of RFC5681) */
-	tp_vars->dec_cwnd += max_t(u32, 1U << 3,
-				   ((mss * mss) << 3) / tp_vars->cwnd);
-	if (tp_vars->dec_cwnd < (mss << 3))
+	tp_vars->cc.dec_cwnd += max_t(u32, 1U << 3,
+				      ((mss * mss) << 3) / tp_vars->cc.cwnd);
+	if (tp_vars->cc.dec_cwnd < (mss << 3))
 		return;
 
-	tp_vars->cwnd = batadv_tp_cwnd(tp_vars->cwnd, mss, mss);
-	tp_vars->dec_cwnd = 0;
+	tp_vars->cc.cwnd = batadv_tp_cwnd(tp_vars->cc.cwnd, mss, mss);
+	tp_vars->cc.dec_cwnd = 0;
 }
 
 /**
@@ -172,7 +172,7 @@ static void batadv_tp_update_cwnd(struct batadv_tp_sender *tp_vars, u32 mss)
  */
 static void batadv_tp_update_rto(struct batadv_tp_sender *tp_vars,
 				 u32 new_rtt)
-	__must_hold(&tp_vars->cwnd_lock)
+	__must_hold(&tp_vars->cc_lock)
 {
 	long m = new_rtt;
 
@@ -182,24 +182,24 @@ static void batadv_tp_update_rto(struct batadv_tp_sender *tp_vars,
 	 * It's tricky to understand. Don't lose hair please.
 	 * Inspired by tcp_rtt_estimator() tcp_input.c
 	 */
-	if (tp_vars->srtt != 0) {
-		m -= (tp_vars->srtt >> 3); /* m is now error in rtt est */
-		tp_vars->srtt += m; /* rtt = 7/8 srtt + 1/8 new */
+	if (tp_vars->cc.srtt != 0) {
+		m -= (tp_vars->cc.srtt >> 3); /* m is now error in rtt est */
+		tp_vars->cc.srtt += m; /* rtt = 7/8 srtt + 1/8 new */
 		if (m < 0)
 			m = -m;
 
-		m -= (tp_vars->rttvar >> 2);
-		tp_vars->rttvar += m; /* mdev ~= 3/4 rttvar + 1/4 new */
+		m -= (tp_vars->cc.rttvar >> 2);
+		tp_vars->cc.rttvar += m; /* mdev ~= 3/4 rttvar + 1/4 new */
 	} else {
 		/* first measure getting in */
-		tp_vars->srtt = m << 3; /* take the measured time to be srtt */
-		tp_vars->rttvar = m << 1; /* new_rtt / 2 */
+		tp_vars->cc.srtt = m << 3; /* take the measured time to be srtt */
+		tp_vars->cc.rttvar = m << 1; /* new_rtt / 2 */
 	}
 
 	/* rto = srtt + 4 * rttvar.
 	 * rttvar is scaled by 4, therefore doesn't need to be multiplied
 	 */
-	WRITE_ONCE(tp_vars->rto, (tp_vars->srtt >> 3) + tp_vars->rttvar);
+	WRITE_ONCE(tp_vars->cc.rto, (tp_vars->cc.srtt >> 3) + tp_vars->cc.rttvar);
 }
 
 /**
@@ -450,11 +450,11 @@ static void batadv_tp_sender_end(struct batadv_priv *bat_priv,
 
 	batadv_dbg(BATADV_DBG_TP_METER, bat_priv,
 		   "Last timing stats: SRTT=%ums RTTVAR=%ums RTO=%ums\n",
-		   tp_vars->srtt >> 3, tp_vars->rttvar >> 2, tp_vars->rto);
+		   tp_vars->cc.srtt >> 3, tp_vars->cc.rttvar >> 2, tp_vars->cc.rto);
 
 	batadv_dbg(BATADV_DBG_TP_METER, bat_priv,
 		   "Final values: cwnd=%u ss_threshold=%u\n",
-		   tp_vars->cwnd, tp_vars->ss_threshold);
+		   tp_vars->cc.cwnd, tp_vars->cc.ss_threshold);
 
 	session_cookie = batadv_tp_session_cookie(tp_vars->common.session,
 						  tp_vars->icmp_uid);
@@ -521,7 +521,7 @@ static void batadv_tp_reset_sender_timer(struct batadv_tp_sender *tp_vars)
 		return;
 
 	mod_timer(&tp_vars->common.timer,
-		  jiffies + msecs_to_jiffies(READ_ONCE(tp_vars->rto)));
+		  jiffies + msecs_to_jiffies(READ_ONCE(tp_vars->cc.rto)));
 }
 
 /**
@@ -540,11 +540,11 @@ static void batadv_tp_sender_timeout(struct timer_list *t)
 	if (batadv_tp_sender_stopped(tp_vars))
 		return;
 
-	spin_lock_bh(&tp_vars->cwnd_lock);
+	spin_lock_bh(&tp_vars->cc_lock);
 
 	/* if the user waited long enough...shutdown the test */
-	if (unlikely(tp_vars->rto >= BATADV_TP_MAX_RTO)) {
-		spin_unlock_bh(&tp_vars->cwnd_lock);
+	if (unlikely(tp_vars->cc.rto >= BATADV_TP_MAX_RTO)) {
+		spin_unlock_bh(&tp_vars->cc_lock);
 		batadv_tp_sender_shutdown(tp_vars,
 					  BATADV_TP_REASON_DST_UNREACHABLE);
 		return;
@@ -553,22 +553,22 @@ static void batadv_tp_sender_timeout(struct timer_list *t)
 	/* RTO exponential backoff
 	 * Details in Section 5.5 of RFC6298
 	 */
-	WRITE_ONCE(tp_vars->rto, tp_vars->rto * 2);
+	WRITE_ONCE(tp_vars->cc.rto, tp_vars->cc.rto * 2);
 
-	tp_vars->ss_threshold = tp_vars->cwnd >> 1;
-	if (tp_vars->ss_threshold < BATADV_TP_PLEN * 2)
-		tp_vars->ss_threshold = BATADV_TP_PLEN * 2;
+	tp_vars->cc.ss_threshold = tp_vars->cc.cwnd >> 1;
+	if (tp_vars->cc.ss_threshold < BATADV_TP_PLEN * 2)
+		tp_vars->cc.ss_threshold = BATADV_TP_PLEN * 2;
 
 	batadv_dbg(BATADV_DBG_TP_METER, bat_priv,
 		   "Meter: RTO fired during test towards %pM! cwnd=%u new ss_thr=%u, resetting last_sent to %u\n",
-		   tp_vars->common.other_end, tp_vars->cwnd, tp_vars->ss_threshold,
-		   tp_vars->last_acked);
+		   tp_vars->common.other_end, tp_vars->cc.cwnd, tp_vars->cc.ss_threshold,
+		   tp_vars->cc.last_acked);
 
-	tp_vars->cwnd = BATADV_TP_PLEN * 3;
+	tp_vars->cc.cwnd = BATADV_TP_PLEN * 3;
 
-	WRITE_ONCE(tp_vars->last_sent, tp_vars->last_acked);
+	WRITE_ONCE(tp_vars->cc.last_sent, tp_vars->cc.last_acked);
 
-	spin_unlock_bh(&tp_vars->cwnd_lock);
+	spin_unlock_bh(&tp_vars->cc_lock);
 
 	/* resend the non-ACKed packets.. */
 	wake_up(&tp_vars->more_bytes);
@@ -698,81 +698,81 @@ static enum batadv_tp_ack_reaction
 batadv_tp_handle_ack(struct batadv_priv *bat_priv,
 		     struct batadv_tp_sender *tp_vars,
 		     u32 recv_ack, size_t mss)
-	__must_hold(&tp_vars->cwnd_lock)
+	__must_hold(&tp_vars->cc_lock)
 {
 	enum batadv_tp_ack_reaction reaction;
 
-	if (batadv_seq_before(recv_ack, tp_vars->last_acked))
+	if (batadv_seq_before(recv_ack, tp_vars->cc.last_acked))
 		return BATADV_TP_ACK_REACTION_OLD_ACK;
 
 	/* check if this ACK is a duplicate */
-	if (tp_vars->last_acked == recv_ack) {
+	if (tp_vars->cc.last_acked == recv_ack) {
 		/* if this is the third duplicate ACK do Fast Retransmit */
-		if (tp_vars->dup_acks > 3)
+		if (tp_vars->cc.dup_acks > 3)
 			return BATADV_TP_ACK_REACTION_IGNORE;
 
-		tp_vars->dup_acks++;
-		if (tp_vars->dup_acks != 3)
+		tp_vars->cc.dup_acks++;
+		if (tp_vars->cc.dup_acks != 3)
 			return BATADV_TP_ACK_REACTION_IGNORE;
 
-		if (!batadv_seq_before(tp_vars->recover, recv_ack))
+		if (!batadv_seq_before(tp_vars->cc.recover, recv_ack))
 			return BATADV_TP_ACK_REACTION_IGNORE;
 
 		/* Fast Recovery */
-		tp_vars->fast_recovery = true;
+		tp_vars->cc.fast_recovery = true;
 
 		/* Set recover to the last outstanding seqno when Fast Recovery
 		 * is entered. RFC6582, Section 3.2, step 1
 		 */
-		tp_vars->recover = tp_vars->last_sent;
-		tp_vars->ss_threshold = tp_vars->cwnd >> 1;
+		tp_vars->cc.recover = tp_vars->cc.last_sent;
+		tp_vars->cc.ss_threshold = tp_vars->cc.cwnd >> 1;
 		batadv_dbg(BATADV_DBG_TP_METER, bat_priv,
 			   "Meter: Fast Recovery, (cur cwnd=%u) ss_thr=%u last_sent=%u recv_ack=%u\n",
-			   tp_vars->cwnd, tp_vars->ss_threshold,
-			   tp_vars->last_sent, recv_ack);
-		tp_vars->cwnd = batadv_tp_cwnd(tp_vars->ss_threshold, 3 * mss,
-					       mss);
-		tp_vars->dec_cwnd = 0;
-		WRITE_ONCE(tp_vars->last_sent, recv_ack);
+			   tp_vars->cc.cwnd, tp_vars->cc.ss_threshold,
+			   tp_vars->cc.last_sent, recv_ack);
+		tp_vars->cc.cwnd = batadv_tp_cwnd(tp_vars->cc.ss_threshold, 3 * mss,
+						  mss);
+		tp_vars->cc.dec_cwnd = 0;
+		WRITE_ONCE(tp_vars->cc.last_sent, recv_ack);
 
 		return BATADV_TP_ACK_REACTION_RESEND_WAKEUP;
 	}
 
 	/* count the acked data */
-	atomic64_add(recv_ack - tp_vars->last_acked, &tp_vars->tot_sent);
+	atomic64_add(recv_ack - tp_vars->cc.last_acked, &tp_vars->tot_sent);
 
 	/* reset the duplicate ACKs counter */
-	tp_vars->dup_acks = 0;
+	tp_vars->cc.dup_acks = 0;
 
-	if (tp_vars->fast_recovery) {
+	if (tp_vars->cc.fast_recovery) {
 		/* partial ACK */
-		if (batadv_seq_before(recv_ack, tp_vars->recover)) {
+		if (batadv_seq_before(recv_ack, tp_vars->cc.recover)) {
 			/* this is another hole in the window. React
 			 * immediately as specified by NewReno (see
 			 * Section 3.2 of RFC6582 for details)
 			 */
 			reaction = BATADV_TP_ACK_REACTION_RESEND_WAKEUP;
-			tp_vars->cwnd = batadv_tp_cwnd(tp_vars->cwnd,
-						       mss, mss);
+			tp_vars->cc.cwnd = batadv_tp_cwnd(tp_vars->cc.cwnd,
+							  mss, mss);
 		} else {
-			tp_vars->fast_recovery = false;
+			tp_vars->cc.fast_recovery = false;
 			/* set cwnd to the value of ss_threshold at the
 			 * moment that Fast Recovery was entered.
 			 * RFC6582, Section 3.2, step 3
 			 */
-			tp_vars->cwnd = batadv_tp_cwnd(tp_vars->ss_threshold,
-						       0, mss);
+			tp_vars->cc.cwnd = batadv_tp_cwnd(tp_vars->cc.ss_threshold,
+							  0, mss);
 			reaction = BATADV_TP_ACK_REACTION_WAKEUP;
 		}
 	} else {
-		if (recv_ack - tp_vars->last_acked >= mss)
+		if (recv_ack - tp_vars->cc.last_acked >= mss)
 			batadv_tp_update_cwnd(tp_vars, mss);
 
 		reaction = BATADV_TP_ACK_REACTION_WAKEUP;
 	}
 
 	/* move the Transmit Window */
-	WRITE_ONCE(tp_vars->last_acked, recv_ack);
+	WRITE_ONCE(tp_vars->cc.last_acked, recv_ack);
 
 	return reaction;
 }
@@ -814,7 +814,7 @@ static void batadv_tp_recv_ack(struct batadv_priv *bat_priv,
 		goto out;
 
 	/* old ACK? silently drop it.. */
-	if (batadv_seq_before(recv_ack, READ_ONCE(tp_vars->last_acked)))
+	if (batadv_seq_before(recv_ack, READ_ONCE(tp_vars->cc.last_acked)))
 		goto out;
 
 	primary_if = batadv_primary_if_get_selected(bat_priv);
@@ -825,14 +825,14 @@ static void batadv_tp_recv_ack(struct batadv_priv *bat_priv,
 	if (unlikely(!orig_node))
 		goto out;
 
-	spin_lock_bh(&tp_vars->cwnd_lock);
+	spin_lock_bh(&tp_vars->cc_lock);
 	/* update RTO with the new sampled RTT, if any */
 	rtt = jiffies_to_msecs(jiffies) - ntohl(icmp->timestamp);
 	if (icmp->timestamp && rtt)
 		batadv_tp_update_rto(tp_vars, rtt);
 
 	reaction = batadv_tp_handle_ack(bat_priv, tp_vars, recv_ack, mss);
-	spin_unlock_bh(&tp_vars->cwnd_lock);
+	spin_unlock_bh(&tp_vars->cc_lock);
 
 	if (reaction == BATADV_TP_ACK_REACTION_OLD_ACK)
 		goto out;
@@ -873,16 +873,16 @@ static bool batadv_tp_avail(struct batadv_tp_sender *tp_vars,
 {
 	u32 win_left, win_limit;
 
-	spin_lock_bh(&tp_vars->cwnd_lock);
+	spin_lock_bh(&tp_vars->cc_lock);
 
-	win_limit = tp_vars->last_acked + tp_vars->cwnd;
+	win_limit = tp_vars->cc.last_acked + tp_vars->cc.cwnd;
 
-	if (batadv_seq_before(tp_vars->last_sent, win_limit))
-		win_left = win_limit - tp_vars->last_sent;
+	if (batadv_seq_before(tp_vars->cc.last_sent, win_limit))
+		win_left = win_limit - tp_vars->cc.last_sent;
 	else
 		win_left = 0;
 
-	spin_unlock_bh(&tp_vars->cwnd_lock);
+	spin_unlock_bh(&tp_vars->cc_lock);
 
 	return win_left >= payload_len;
 }
@@ -964,7 +964,7 @@ static int batadv_tp_send(void *arg)
 		 * the size of the unicast header
 		 */
 		packet_len = payload_len + sizeof(struct batadv_unicast_packet);
-		last_sent = READ_ONCE(tp_vars->last_sent);
+		last_sent = READ_ONCE(tp_vars->cc.last_sent);
 
 		err = batadv_tp_send_msg(tp_vars, primary_if->net_dev->dev_addr,
 					 orig_node, last_sent, packet_len,
@@ -983,10 +983,10 @@ static int batadv_tp_send(void *arg)
 
 		/* right-shift the TWND */
 		if (!err) {
-			spin_lock_bh(&tp_vars->cwnd_lock);
-			if (tp_vars->last_sent == last_sent)
-				WRITE_ONCE(tp_vars->last_sent, last_sent + payload_len);
-			spin_unlock_bh(&tp_vars->cwnd_lock);
+			spin_lock_bh(&tp_vars->cc_lock);
+			if (tp_vars->cc.last_sent == last_sent)
+				WRITE_ONCE(tp_vars->cc.last_sent, last_sent + payload_len);
+			spin_unlock_bh(&tp_vars->cc_lock);
 		}
 
 		cond_resched();
@@ -1104,30 +1104,30 @@ void batadv_tp_start(struct batadv_priv *bat_priv, const u8 *dst,
 	memcpy(tp_vars->common.session, session_id, sizeof(session_id));
 	tp_vars->icmp_uid = icmp_uid;
 
-	WRITE_ONCE(tp_vars->last_sent, BATADV_TP_FIRST_SEQ);
-	WRITE_ONCE(tp_vars->dup_acks, 0);
-	WRITE_ONCE(tp_vars->last_acked, BATADV_TP_FIRST_SEQ);
-	tp_vars->fast_recovery = false;
-	tp_vars->recover = BATADV_TP_FIRST_SEQ;
+	WRITE_ONCE(tp_vars->cc.last_sent, BATADV_TP_FIRST_SEQ);
+	WRITE_ONCE(tp_vars->cc.dup_acks, 0);
+	WRITE_ONCE(tp_vars->cc.last_acked, BATADV_TP_FIRST_SEQ);
+	tp_vars->cc.fast_recovery = false;
+	tp_vars->cc.recover = BATADV_TP_FIRST_SEQ;
 
 	/* initialise the CWND to 3*MSS (Section 3.1 in RFC5681).
 	 * For batman-adv the MSS is the size of the payload received by the
 	 * mesh_interface, hence its MTU
 	 */
-	tp_vars->cwnd = BATADV_TP_PLEN * 3;
-	tp_vars->dec_cwnd = 0;
+	tp_vars->cc.cwnd = BATADV_TP_PLEN * 3;
+	tp_vars->cc.dec_cwnd = 0;
 
 	/* at the beginning initialise the SS threshold to the biggest possible
 	 * window size, hence the AWND size
 	 */
-	tp_vars->ss_threshold = BATADV_TP_AWND;
+	tp_vars->cc.ss_threshold = BATADV_TP_AWND;
 
 	/* RTO initial value is 3 seconds.
 	 * Details in Section 2.1 of RFC6298
 	 */
-	WRITE_ONCE(tp_vars->rto, 1000);
-	tp_vars->srtt = 0;
-	tp_vars->rttvar = 0;
+	WRITE_ONCE(tp_vars->cc.rto, 1000);
+	tp_vars->cc.srtt = 0;
+	tp_vars->cc.rttvar = 0;
 
 	atomic64_set(&tp_vars->tot_sent, 0);
 
@@ -1143,7 +1143,7 @@ void batadv_tp_start(struct batadv_priv *bat_priv, const u8 *dst,
 	spin_lock_init(&tp_vars->common.unacked_lock);
 	INIT_LIST_HEAD(&tp_vars->common.unacked_list);
 
-	spin_lock_init(&tp_vars->cwnd_lock);
+	spin_lock_init(&tp_vars->cc_lock);
 
 	tp_vars->prerandom_offset = 0;
 	spin_lock_init(&tp_vars->prerandom_lock);
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index c782f04a..5eb0371d 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -1367,6 +1367,45 @@ struct batadv_tp_vars_common {
 	struct rcu_head rcu;
 };
 
+/** struct batadv_tp_sender_cc - congestion control variables */
+struct batadv_tp_sender_cc {
+	/** @fast_recovery: true if in Fast Recovery mode */
+	bool fast_recovery:1;
+
+	/** @dup_acks: duplicate ACKs counter */
+	u8 dup_acks;
+
+	/** @dec_cwnd: decimal part of the cwnd used during linear growth */
+	u16 dec_cwnd;
+
+	/** @cwnd: current size of the congestion window */
+	u32 cwnd;
+
+	/**
+	 * @ss_threshold: Slow Start threshold. Once cwnd exceeds this value the
+	 *  connection switches to the Congestion Avoidance state
+	 */
+	u32 ss_threshold;
+
+	/** @last_acked: last acked byte */
+	u32 last_acked;
+
+	/** @last_sent: last sent byte, not yet acked */
+	u32 last_sent;
+
+	/** @recover: last sent seqno when entering Fast Recovery */
+	u32 recover;
+
+	/** @rto: sender timeout */
+	u32 rto;
+
+	/** @srtt: smoothed RTT scaled by 2^3 */
+	u32 srtt;
+
+	/** @rttvar: RTT variation scaled by 2^2 */
+	u32 rttvar;
+};
+
 /**
  * struct batadv_tp_sender - sender tp meter private variables per session
  */
@@ -1383,15 +1422,6 @@ struct batadv_tp_sender {
 	 */
 	atomic_t send_result;
 
-	/** @last_sent: last sent byte, not yet acked */
-	u32 last_sent;
-
-	/** @fast_recovery: true if in Fast Recovery mode */
-	bool fast_recovery:1;
-
-	/** @recover: last sent seqno when entering Fast Recovery */
-	u32 recover;
-
 	/** @finish_work: work item for the finishing procedure */
 	struct delayed_work finish_work;
 
@@ -1404,39 +1434,15 @@ struct batadv_tp_sender {
 	/** @icmp_uid: local ICMP "socket" index */
 	u8 icmp_uid;
 
-	/** @dec_cwnd: decimal part of the cwnd used during linear growth */
-	u16 dec_cwnd;
+	/** @cc: congestion control variables */
+	struct batadv_tp_sender_cc cc;
 
-	/** @cwnd: current size of the congestion window */
-	u32 cwnd;
-
-	/** @cwnd_lock: lock do protect congestion control variables */
-	spinlock_t cwnd_lock;
-
-	/**
-	 * @ss_threshold: Slow Start threshold. Once cwnd exceeds this value the
-	 *  connection switches to the Congestion Avoidance state
-	 */
-	u32 ss_threshold;
-
-	/** @last_acked: last acked byte */
-	u32 last_acked;
+	/** @cc_lock: lock do protect @cc */
+	spinlock_t cc_lock;
 
 	/** @tot_sent: amount of data sent/ACKed so far */
 	atomic64_t tot_sent;
 
-	/** @dup_acks: duplicate ACKs counter */
-	u8 dup_acks;
-
-	/** @rto: sender timeout */
-	u32 rto;
-
-	/** @srtt: smoothed RTT scaled by 2^3 */
-	u32 srtt;
-
-	/** @rttvar: RTT variation scaled by 2^2 */
-	u32 rttvar;
-
 	/**
 	 * @more_bytes: waiting queue anchor when waiting for more ack/retry
 	 *  timeout

-- 
2.47.3

