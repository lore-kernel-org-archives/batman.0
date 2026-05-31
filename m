Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17761CD6E51
	for <batman-adv@archiver.kernel.org>; Sun, 31 May 2026 08:34:40 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 9EC4980BB8
	for <batman-adv@archiver.kernel.org>; Sun, 31 May 2026 10:34:38 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1780216478;
 b=VBNuFx/YLDGgudBicB7AC+FKYb+Z05sQU3CF5zSb6uQ4axtQtzmeNzlPvVX77OsggQoSp
 VWKrxSTdYDg9sjM7HXoEnEfntZP7Ufiu1Qb1HDO9kXh4PBJPEWTn7XbsS87oFnzv75om/SR
 1qDBLRLGRQRL6DMcU9l33nNiX3BFyzo=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1780216478; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=rxll2T3Um5gTd2nTVV6hR5Xw42p9Lnqvglm+XrKMohw=;
 b=xH2wyuzupe9WGM4VVBn1vCZ2DJlyQ+hr6NavNci+4X/J0DZrm5HZRrS5w37BfMDHRD9ek
 EayuIT8ItAkl/jRJv16S4Ve8Rd9UKJq6gOv40dnLtPBceo+eWiPo6xg2RxE8oa1KpJP5rb8
 5NpPUbsk7Pax6E4oY4jskha/JnKql4I=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 67AC0803BC
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 31 May 2026 10:29:31 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1780216171;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=rxll2T3Um5gTd2nTVV6hR5Xw42p9Lnqvglm+XrKMohw=;
	b=2Wh1btXBgcTTETO/WoAyJoo3a3YDgUc64Ay/6EjnUBw5AoVS1OaawsBNRSk00cCyX1nhA1
	m6Aavg4YBozHv790ZACREBr+L6Tl6LFmAn6o3okupo93aVeAkblMzgRfUrKWpeu3RxEsf3
	f/LD5CC9wzeYHJ/XwHhzYC5r4G8W2EQ=
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1780216171;
	b=hkkE5lA9JR6H7kJ30UXd70+VMY0hEIsabrpVxPC426R3GqIRGb7m4ZNTcsM+cjxo+lIV96
	OHDkjuz4WbBd6GM6GGbjhHznkZLrF/tRy+1WHGxwhttdysgBxJKLNC0Q66y40DGfv8iGC2
	9p9bIPSbSyjXsivRzqdE2mk68Mbzsok=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=rOuEV8nt;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id DBBDE1FD9C;
	Sun, 31 May 2026 08:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1780216171;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rxll2T3Um5gTd2nTVV6hR5Xw42p9Lnqvglm+XrKMohw=;
	b=rOuEV8ntQn2kXHqRmZ4gpjeNjJQ2gKy9W3XklYWhQFMHs5vAzdpxOTmsD0TPekRcz9gBL4
	RPqwaSNBw4fl5uGigi2b2ekAL2yNtNzrsVtxeekLH6v0NAHUE+RtUWrAp5b7UigQ638nk3
	Q3mDwO1xn+DzaJp0M0Z2x2L3PDs/7Gs=
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 31 May 2026 10:28:56 +0200
Subject: [PATCH batadv v4 6/6] batman-adv: tp_meter: consolidate congestion
 control variables
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260531-tp-reason-missing-v4-6-5d2556e00128@narfation.org>
References: <20260531-tp-reason-missing-v4-0-5d2556e00128@narfation.org>
In-Reply-To: <20260531-tp-reason-missing-v4-0-5d2556e00128@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=17427; i=sven@narfation.org;
 h=from:subject:message-id; bh=8+iRvxil9xKf7vo1ABArC8cbIdAZo2QrHyj5kmkXXE8=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFnSHyNimWsic5N+VdjuyEgwSbzxJ2bR+8nmzU0BK1Lmm
 OZU7W7tKGVhEONikBVTZNlzJf/8Zva38p+nfTwKM4eVCWQIAxenAExkBS/DP+3+ubEfQmeILhC2
 VXGomBJhWvJRTDprAvNXQabjSbtsXzAytPJmndmzUrJ95jO3uD6lnlyR7RrvzTxu/t+w5k5XXuw
 /NgA=
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: G2G2IQXPXOBPQC7M2DXIRP6WQZVO5NK2
X-Message-ID-Hash: G2G2IQXPXOBPQC7M2DXIRP6WQZVO5NK2
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/G2G2IQXPXOBPQC7M2DXIRP6WQZVO5NK2/>
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
 net/batman-adv/tp_meter.c | 168 +++++++++++++++++++++++-----------------------
 net/batman-adv/types.h    |  80 ++++++++++++----------
 2 files changed, 127 insertions(+), 121 deletions(-)

diff --git a/net/batman-adv/tp_meter.c b/net/batman-adv/tp_meter.c
index e7a2dde1..c621683b 100644
--- a/net/batman-adv/tp_meter.c
+++ b/net/batman-adv/tp_meter.c
@@ -143,23 +143,23 @@ static u32 batadv_tp_cwnd(u32 base, u32 increment, u32 min)
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
 
 	/* increment CWND at least of 1 (section 3.1 of RFC5681) */
-	tp_vars->dec_cwnd += max_t(u32, 1U << 3,
-				   ((mss * mss) << 6) / (tp_vars->cwnd << 3));
-	if (tp_vars->dec_cwnd < (mss << 3))
+	tp_vars->cc.dec_cwnd += max_t(u32, 1U << 3,
+				      ((mss * mss) << 6) / (tp_vars->cc.cwnd << 3));
+	if (tp_vars->cc.dec_cwnd < (mss << 3))
 		return;
 
-	tp_vars->cwnd = batadv_tp_cwnd(tp_vars->cwnd, mss, mss);
-	tp_vars->dec_cwnd = 0;
+	tp_vars->cc.cwnd = batadv_tp_cwnd(tp_vars->cc.cwnd, mss, mss);
+	tp_vars->cc.dec_cwnd = 0;
 }
 
 /**
@@ -169,7 +169,7 @@ static void batadv_tp_update_cwnd(struct batadv_tp_sender *tp_vars, u32 mss)
  */
 static void batadv_tp_update_rto(struct batadv_tp_sender *tp_vars,
 				 u32 new_rtt)
-	__must_hold(&tp_vars->cwnd_lock)
+	__must_hold(&tp_vars->cc_lock)
 {
 	long m = new_rtt;
 
@@ -179,24 +179,24 @@ static void batadv_tp_update_rto(struct batadv_tp_sender *tp_vars,
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
@@ -447,11 +447,11 @@ static void batadv_tp_sender_end(struct batadv_priv *bat_priv,
 
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
@@ -518,7 +518,7 @@ static void batadv_tp_reset_sender_timer(struct batadv_tp_sender *tp_vars)
 		return;
 
 	mod_timer(&tp_vars->common.timer,
-		  jiffies + msecs_to_jiffies(READ_ONCE(tp_vars->rto)));
+		  jiffies + msecs_to_jiffies(READ_ONCE(tp_vars->cc.rto)));
 }
 
 /**
@@ -537,11 +537,11 @@ static void batadv_tp_sender_timeout(struct timer_list *t)
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
@@ -550,22 +550,22 @@ static void batadv_tp_sender_timeout(struct timer_list *t)
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
@@ -695,81 +695,81 @@ static enum batadv_tp_ack_reaction
 batadv_tp_handle_ack(struct batadv_priv *bat_priv,
 		     struct batadv_tp_sender *tp_vars,
 		     u32 recv_ack, size_t mss)
-	__must_hold(&tp_vars->cwnd_lock)
+	__must_hold(&tp_vars->cc_lock)
 {
 	static enum batadv_tp_ack_reaction reaction;
 
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
 
-		if (!batadv_seq_before(recv_ack, tp_vars->recover))
+		if (!batadv_seq_before(recv_ack, tp_vars->cc.recover))
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
@@ -811,7 +811,7 @@ static void batadv_tp_recv_ack(struct batadv_priv *bat_priv,
 		goto out;
 
 	/* old ACK? silently drop it.. */
-	if (batadv_seq_before(recv_ack, READ_ONCE(tp_vars->last_acked)))
+	if (batadv_seq_before(recv_ack, READ_ONCE(tp_vars->cc.last_acked)))
 		goto out;
 
 	primary_if = batadv_primary_if_get_selected(bat_priv);
@@ -822,14 +822,14 @@ static void batadv_tp_recv_ack(struct batadv_priv *bat_priv,
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
@@ -870,16 +870,16 @@ static bool batadv_tp_avail(struct batadv_tp_sender *tp_vars,
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
@@ -961,7 +961,7 @@ static int batadv_tp_send(void *arg)
 		 * the size of the unicast header
 		 */
 		packet_len = payload_len + sizeof(struct batadv_unicast_packet);
-		last_sent = READ_ONCE(tp_vars->last_sent);
+		last_sent = READ_ONCE(tp_vars->cc.last_sent);
 
 		err = batadv_tp_send_msg(tp_vars, primary_if->net_dev->dev_addr,
 					 orig_node, last_sent, packet_len,
@@ -980,10 +980,10 @@ static int batadv_tp_send(void *arg)
 
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
@@ -1101,28 +1101,28 @@ void batadv_tp_start(struct batadv_priv *bat_priv, const u8 *dst,
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
+	tp_vars->cc.cwnd = BATADV_TP_PLEN * 3;
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
 
@@ -1138,7 +1138,7 @@ void batadv_tp_start(struct batadv_priv *bat_priv, const u8 *dst,
 	spin_lock_init(&tp_vars->common.unacked_lock);
 	INIT_LIST_HEAD(&tp_vars->common.unacked_list);
 
-	spin_lock_init(&tp_vars->cwnd_lock);
+	spin_lock_init(&tp_vars->cc_lock);
 
 	tp_vars->prerandom_offset = 0;
 	spin_lock_init(&tp_vars->prerandom_lock);
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 8064f696..53dc42e7 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -1328,6 +1328,45 @@ struct batadv_tp_vars_common {
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
@@ -1344,15 +1383,6 @@ struct batadv_tp_sender {
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
 
@@ -1365,39 +1395,15 @@ struct batadv_tp_sender {
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

