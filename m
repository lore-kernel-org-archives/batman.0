Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6268CCD5BD1
	for <batman-adv@archiver.kernel.org>; Mon,  1 Jun 2026 04:59:39 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id E10248427B
	for <batman-adv@archiver.kernel.org>; Mon, 01 Jun 2026 06:59:37 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1780289977;
 b=fd3YlUr9FIiGWjVSdIsQO9L/mbd87bQN2ITUdcKhSeWMar2xFTxc9+WSI3SCg1JgvyrHH
 dntRmrySTUzzFmpJ/eU/1smxd5c/A7OvW0T50ccOcyQYvK5UqxhM7ucthdoWBZ8Zbxd7KZm
 ALo5EncX+eMEMcKsusifgjUlGojSQms=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1780289977; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=L5McamP3ISp3d0OusR1dsAZ5RJromoEHfn5UDkCjc1c=;
 b=fnwbkIOJzaJQyrnsqkeiP3I9WKYxvWclIUw6Qy0rO0pbHKuQ0kZ52IpHSGSnUEQ3JYAAW
 Eq7jHobb6aGUs6OshU8Omtv2oETi5hd3vQ/J1ixokwLAelVpaKY1GUawLxKZamrck8DtCHI
 IGY0/ZtYICrhIAWYJFLXEMTWvnKzeQY=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 3747784000
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 01 Jun 2026 06:54:38 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1780289678;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=L5McamP3ISp3d0OusR1dsAZ5RJromoEHfn5UDkCjc1c=;
	b=B2MFR3tn9MEstPqX2CkCHbt1jdDVHwHUVG1A5zvmaIOtJUcEJavY0EshqgbZEbidJ8ZgRn
	MskDyhwfzzAisNT9U2TEg0PD7ejDvcVov4lXoc/dyZdCtQkORMujJUAkwlip+MIUuArM0k
	mFwpMIqYVk+m9UKvzCfcn0Cqv0Rqd9I=
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1780289678;
	b=qPlRCfRpxe726eREipKdLLMdCkEiM0lsvCkAQGfWPF5OIE4/QOr1dTitIqX36mU9sa1oAo
	bSZPxE10Vt8avsbze9b0EQ7segJy7bo1jfYqpmzDZ1ZElDWqdPUFaOYRflyN6lDqV+3I9E
	dpymEcRojxTIHl5yJWFUtvNe9sd+JyI=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=Un6orBZX;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id A5F161FEED;
	Mon, 01 Jun 2026 04:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1780289677;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L5McamP3ISp3d0OusR1dsAZ5RJromoEHfn5UDkCjc1c=;
	b=Un6orBZXQVOOmtIUvQuhX9e3wUDwjGuM8fV4laqm02B6HqJSWcR5Xr7RQkfEIKHX1m0XSi
	hCJGgYc4H9h2/Y1Yo6N/GPGhILsDsbHkohjwu36qP4Et0Mj7o6YVPNdtUjQHySvQrMk4As
	tkCx83IvRyOLp5p8QOKVxMjEuoneIFA=
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 01 Jun 2026 06:54:20 +0200
Subject: [PATCH batadv v5 6/7] batman-adv: tp_meter: use locking for all
 congestion control variables
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-tp-reason-missing-v5-6-78a5b8fe6e67@narfation.org>
References: <20260601-tp-reason-missing-v5-0-78a5b8fe6e67@narfation.org>
In-Reply-To: <20260601-tp-reason-missing-v5-0-78a5b8fe6e67@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=18092; i=sven@narfation.org;
 h=from:subject:message-id; bh=4Hl7UdWLzCEBVspf0/D8TWPgOhRYn7Rx+fKGik00ncc=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFmyAtXny7OevRZ7kHf/0PMPz5tkGJhuRNxyNqv4e9hje
 oi+uqdNRykLgxgXg6yYIsueK/nnN7O/lf887eNRmDmsTCBDGLg4BWAi6xYzMuwvOmUacuJ1W0nt
 vw3+fqKxG5TzFodfvVfK+u4s6+rH23UZGW70RFRVfNvoemxW+U7lVKZDi7ge8b6teTc76mLDWzW
 LN0wA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: OZDMYOV4DKC5B5SAIAF3ZWHB4PEH7EYP
X-Message-ID-Hash: OZDMYOV4DKC5B5SAIAF3ZWHB4PEH7EYP
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/OZDMYOV4DKC5B5SAIAF3ZWHB4PEH7EYP/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Some variables used atomic_t for concurrent access while others relied on
cwnd_lock, leading to an inconsistent locking model. This can be simplified
by:

* keeping all congestion control decisions inside the cc_lock
* variables which can be accessed without a lock must use
  READ_ONCE/WRITE_ONE

This is only possible, by extracting the congestion control logic from
batadv_tp_recv_ack() into a new helper batadv_tp_handle_ack(). Its
decisions are returned as a batadv_tp_ack_reaction enum value and then
applied by the caller. This separates the algorithm (deciding what to do)
from the mechanism (actually doing it).

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/tp_meter.c | 330 +++++++++++++++++++++++++++-------------------
 net/batman-adv/types.h    |   8 +-
 2 files changed, 199 insertions(+), 139 deletions(-)

diff --git a/net/batman-adv/tp_meter.c b/net/batman-adv/tp_meter.c
index 6e1fafba..a41ae84f 100644
--- a/net/batman-adv/tp_meter.c
+++ b/net/batman-adv/tp_meter.c
@@ -143,14 +143,12 @@ static u32 batadv_tp_cwnd(u32 base, u32 increment, u32 min)
  * increased by MSS * MSS / CWND for every unique received ACK
  */
 static void batadv_tp_update_cwnd(struct batadv_tp_sender *tp_vars, u32 mss)
+	__must_hold(&tp_vars->cwnd_lock)
 {
-	spin_lock_bh(&tp_vars->cwnd_lock);
-
 	/* slow start... */
 	if (tp_vars->cwnd <= tp_vars->ss_threshold) {
 		tp_vars->dec_cwnd = 0;
 		tp_vars->cwnd = batadv_tp_cwnd(tp_vars->cwnd, mss, mss);
-		spin_unlock_bh(&tp_vars->cwnd_lock);
 		return;
 	}
 
@@ -160,15 +158,11 @@ static void batadv_tp_update_cwnd(struct batadv_tp_sender *tp_vars, u32 mss)
 	/* increment CWND at least of 1 (section 3.1 of RFC5681) */
 	tp_vars->dec_cwnd += max_t(u32, 1U << 3,
 				   ((mss * mss) << 3) / tp_vars->cwnd);
-	if (tp_vars->dec_cwnd < (mss << 3)) {
-		spin_unlock_bh(&tp_vars->cwnd_lock);
+	if (tp_vars->dec_cwnd < (mss << 3))
 		return;
-	}
 
 	tp_vars->cwnd = batadv_tp_cwnd(tp_vars->cwnd, mss, mss);
 	tp_vars->dec_cwnd = 0;
-
-	spin_unlock_bh(&tp_vars->cwnd_lock);
 }
 
 /**
@@ -178,6 +172,7 @@ static void batadv_tp_update_cwnd(struct batadv_tp_sender *tp_vars, u32 mss)
  */
 static void batadv_tp_update_rto(struct batadv_tp_sender *tp_vars,
 				 u32 new_rtt)
+	__must_hold(&tp_vars->cwnd_lock)
 {
 	long m = new_rtt;
 
@@ -197,14 +192,14 @@ static void batadv_tp_update_rto(struct batadv_tp_sender *tp_vars,
 		tp_vars->rttvar += m; /* mdev ~= 3/4 rttvar + 1/4 new */
 	} else {
 		/* first measure getting in */
-		tp_vars->srtt = m << 3;	/* take the measured time to be srtt */
+		tp_vars->srtt = m << 3; /* take the measured time to be srtt */
 		tp_vars->rttvar = m << 1; /* new_rtt / 2 */
 	}
 
 	/* rto = srtt + 4 * rttvar.
 	 * rttvar is scaled by 4, therefore doesn't need to be multiplied
 	 */
-	tp_vars->rto = (tp_vars->srtt >> 3) + tp_vars->rttvar;
+	WRITE_ONCE(tp_vars->rto, (tp_vars->srtt >> 3) + tp_vars->rttvar);
 }
 
 /**
@@ -525,7 +520,8 @@ static void batadv_tp_reset_sender_timer(struct batadv_tp_sender *tp_vars)
 		/* timer ref will be dropped in batadv_tp_sender_cleanup */
 		return;
 
-	mod_timer(&tp_vars->common.timer, jiffies + msecs_to_jiffies(tp_vars->rto));
+	mod_timer(&tp_vars->common.timer,
+		  jiffies + msecs_to_jiffies(READ_ONCE(tp_vars->rto)));
 }
 
 /**
@@ -544,8 +540,11 @@ static void batadv_tp_sender_timeout(struct timer_list *t)
 	if (batadv_tp_sender_stopped(tp_vars))
 		return;
 
+	spin_lock_bh(&tp_vars->cwnd_lock);
+
 	/* if the user waited long enough...shutdown the test */
 	if (unlikely(tp_vars->rto >= BATADV_TP_MAX_RTO)) {
+		spin_unlock_bh(&tp_vars->cwnd_lock);
 		batadv_tp_sender_shutdown(tp_vars,
 					  BATADV_TP_REASON_DST_UNREACHABLE);
 		return;
@@ -554,9 +553,7 @@ static void batadv_tp_sender_timeout(struct timer_list *t)
 	/* RTO exponential backoff
 	 * Details in Section 5.5 of RFC6298
 	 */
-	tp_vars->rto <<= 1;
-
-	spin_lock_bh(&tp_vars->cwnd_lock);
+	WRITE_ONCE(tp_vars->rto, tp_vars->rto * 2);
 
 	tp_vars->ss_threshold = tp_vars->cwnd >> 1;
 	if (tp_vars->ss_threshold < BATADV_TP_PLEN * 2)
@@ -565,14 +562,15 @@ static void batadv_tp_sender_timeout(struct timer_list *t)
 	batadv_dbg(BATADV_DBG_TP_METER, bat_priv,
 		   "Meter: RTO fired during test towards %pM! cwnd=%u new ss_thr=%u, resetting last_sent to %u\n",
 		   tp_vars->common.other_end, tp_vars->cwnd, tp_vars->ss_threshold,
-		   atomic_read(&tp_vars->last_acked));
+		   tp_vars->last_acked);
 
 	tp_vars->cwnd = BATADV_TP_PLEN * 3;
 
+	WRITE_ONCE(tp_vars->last_sent, tp_vars->last_acked);
+
 	spin_unlock_bh(&tp_vars->cwnd_lock);
 
 	/* resend the non-ACKed packets.. */
-	tp_vars->last_sent = atomic_read(&tp_vars->last_acked);
 	wake_up(&tp_vars->more_bytes);
 
 	batadv_tp_reset_sender_timer(tp_vars);
@@ -671,80 +669,58 @@ static int batadv_tp_send_msg(struct batadv_tp_sender *tp_vars, const u8 *src,
 }
 
 /**
- * batadv_tp_recv_ack() - ACK receiving function
- * @bat_priv: the bat priv with all the mesh interface information
- * @skb: the buffer containing the received packet
- *
- * Process a received TP ACK packet
+ * enum batadv_tp_ack_reaction - expected reaction to ack packet
  */
-static void batadv_tp_recv_ack(struct batadv_priv *bat_priv,
-			       const struct sk_buff *skb)
+enum batadv_tp_ack_reaction {
+	/** @BATADV_TP_ACK_REACTION_OLD_ACK: ignore old ack packet */
+	BATADV_TP_ACK_REACTION_OLD_ACK,
+
+	/** @BATADV_TP_ACK_REACTION_IGNORE: ignore duplicated ack but reset timer */
+	BATADV_TP_ACK_REACTION_IGNORE,
+
+	/** @BATADV_TP_ACK_REACTION_RESEND_WAKEUP: resend data and wakeup "more_bytes" */
+	BATADV_TP_ACK_REACTION_RESEND_WAKEUP,
+
+	/** @BATADV_TP_ACK_REACTION_WAKEUP: wakeup "more_bytes" */
+	BATADV_TP_ACK_REACTION_WAKEUP,
+};
+
+/**
+ * batadv_tp_handle_ack() - Calculate reaction to ACK and update congestion control
+ * @bat_priv: the bat priv with all the mesh interface information
+ * @tp_vars: the private data of the current TP meter session
+ * @recv_ack: received ACK seqno
+ * @mss: maximum segment size for transmission
+ *
+ * Return: expected reaction to this ack
+ */
+static enum batadv_tp_ack_reaction
+batadv_tp_handle_ack(struct batadv_priv *bat_priv,
+		     struct batadv_tp_sender *tp_vars,
+		     u32 recv_ack, size_t mss)
+	__must_hold(&tp_vars->cwnd_lock)
 {
-	struct batadv_hard_iface *primary_if = NULL;
-	struct batadv_orig_node *orig_node = NULL;
-	const struct batadv_icmp_tp_packet *icmp;
-	struct batadv_tp_sender *tp_vars;
-	const unsigned char *dev_addr;
-	size_t packet_len, mss;
-	u32 rtt, recv_ack, cwnd;
+	enum batadv_tp_ack_reaction reaction;
 
-	packet_len = BATADV_TP_PLEN;
-	mss = BATADV_TP_PLEN;
-	packet_len += sizeof(struct batadv_unicast_packet);
-
-	icmp = (struct batadv_icmp_tp_packet *)skb->data;
-
-	/* find the tp_vars */
-	tp_vars = batadv_tp_list_find_sender_session(bat_priv, icmp->orig,
-						     icmp->session);
-	if (unlikely(!tp_vars))
-		return;
-
-	if (unlikely(batadv_tp_sender_stopped(tp_vars)))
-		goto out;
-
-	/* old ACK? silently drop it.. */
-	if (batadv_seq_before(ntohl(icmp->seqno),
-			      (u32)atomic_read(&tp_vars->last_acked)))
-		goto out;
-
-	primary_if = batadv_primary_if_get_selected(bat_priv);
-	if (unlikely(!primary_if))
-		goto out;
-
-	orig_node = batadv_orig_hash_find(bat_priv, icmp->orig);
-	if (unlikely(!orig_node))
-		goto out;
-
-	/* update RTO with the new sampled RTT, if any */
-	rtt = jiffies_to_msecs(jiffies) - ntohl(icmp->timestamp);
-	if (icmp->timestamp && rtt)
-		batadv_tp_update_rto(tp_vars, rtt);
-
-	/* ACK for new data... reset the timer */
-	batadv_tp_reset_sender_timer(tp_vars);
-
-	recv_ack = ntohl(icmp->seqno);
+	if (batadv_seq_before(recv_ack, tp_vars->last_acked))
+		return BATADV_TP_ACK_REACTION_OLD_ACK;
 
 	/* check if this ACK is a duplicate */
-	if (atomic_read(&tp_vars->last_acked) == recv_ack) {
-		atomic_inc(&tp_vars->dup_acks);
-		if (atomic_read(&tp_vars->dup_acks) != 3)
-			goto out;
-
-		if (recv_ack >= tp_vars->recover)
-			goto out;
-
+	if (tp_vars->last_acked == recv_ack) {
 		/* if this is the third duplicate ACK do Fast Retransmit */
-		batadv_tp_send_msg(tp_vars, primary_if->net_dev->dev_addr,
-				   orig_node, recv_ack, packet_len,
-				   icmp->session, icmp->uid,
-				   jiffies_to_msecs(jiffies));
+		if (tp_vars->dup_acks > 3)
+			return BATADV_TP_ACK_REACTION_IGNORE;
 
-		spin_lock_bh(&tp_vars->cwnd_lock);
+		tp_vars->dup_acks++;
+		if (tp_vars->dup_acks != 3)
+			return BATADV_TP_ACK_REACTION_IGNORE;
+
+		if (!batadv_seq_before(recv_ack, tp_vars->recover))
+			return BATADV_TP_ACK_REACTION_IGNORE;
 
 		/* Fast Recovery */
 		tp_vars->fast_recovery = true;
+
 		/* Set recover to the last outstanding seqno when Fast Recovery
 		 * is entered. RFC6582, Section 3.2, step 1
 		 */
@@ -757,52 +733,128 @@ static void batadv_tp_recv_ack(struct batadv_priv *bat_priv,
 		tp_vars->cwnd = batadv_tp_cwnd(tp_vars->ss_threshold, 3 * mss,
 					       mss);
 		tp_vars->dec_cwnd = 0;
-		tp_vars->last_sent = recv_ack;
+		WRITE_ONCE(tp_vars->last_sent, recv_ack);
 
-		spin_unlock_bh(&tp_vars->cwnd_lock);
-	} else {
-		/* count the acked data */
-		atomic64_add(recv_ack - atomic_read(&tp_vars->last_acked),
-			     &tp_vars->tot_sent);
-		/* reset the duplicate ACKs counter */
-		atomic_set(&tp_vars->dup_acks, 0);
-
-		if (tp_vars->fast_recovery) {
-			/* partial ACK */
-			if (batadv_seq_before(recv_ack, tp_vars->recover)) {
-				/* this is another hole in the window. React
-				 * immediately as specified by NewReno (see
-				 * Section 3.2 of RFC6582 for details)
-				 */
-				dev_addr = primary_if->net_dev->dev_addr;
-				batadv_tp_send_msg(tp_vars, dev_addr,
-						   orig_node, recv_ack,
-						   packet_len, icmp->session,
-						   icmp->uid,
-						   jiffies_to_msecs(jiffies));
-				tp_vars->cwnd = batadv_tp_cwnd(tp_vars->cwnd,
-							       mss, mss);
-			} else {
-				tp_vars->fast_recovery = false;
-				/* set cwnd to the value of ss_threshold at the
-				 * moment that Fast Recovery was entered.
-				 * RFC6582, Section 3.2, step 3
-				 */
-				cwnd = batadv_tp_cwnd(tp_vars->ss_threshold, 0,
-						      mss);
-				tp_vars->cwnd = cwnd;
-			}
-			goto move_twnd;
-		}
-
-		if (recv_ack - atomic_read(&tp_vars->last_acked) >= mss)
-			batadv_tp_update_cwnd(tp_vars, mss);
-move_twnd:
-		/* move the Transmit Window */
-		atomic_set(&tp_vars->last_acked, recv_ack);
+		return BATADV_TP_ACK_REACTION_RESEND_WAKEUP;
+	}
+
+	/* count the acked data */
+	atomic64_add(recv_ack - tp_vars->last_acked, &tp_vars->tot_sent);
+
+	/* reset the duplicate ACKs counter */
+	tp_vars->dup_acks = 0;
+
+	if (tp_vars->fast_recovery) {
+		/* partial ACK */
+		if (batadv_seq_before(recv_ack, tp_vars->recover)) {
+			/* this is another hole in the window. React
+			 * immediately as specified by NewReno (see
+			 * Section 3.2 of RFC6582 for details)
+			 */
+			reaction = BATADV_TP_ACK_REACTION_RESEND_WAKEUP;
+			tp_vars->cwnd = batadv_tp_cwnd(tp_vars->cwnd,
+						       mss, mss);
+		} else {
+			tp_vars->fast_recovery = false;
+			/* set cwnd to the value of ss_threshold at the
+			 * moment that Fast Recovery was entered.
+			 * RFC6582, Section 3.2, step 3
+			 */
+			tp_vars->cwnd = batadv_tp_cwnd(tp_vars->ss_threshold,
+						       0, mss);
+			reaction = BATADV_TP_ACK_REACTION_WAKEUP;
+		}
+	} else {
+		if (recv_ack - tp_vars->last_acked >= mss)
+			batadv_tp_update_cwnd(tp_vars, mss);
+
+		reaction = BATADV_TP_ACK_REACTION_WAKEUP;
+	}
+
+	/* move the Transmit Window */
+	WRITE_ONCE(tp_vars->last_acked, recv_ack);
+
+	return reaction;
+}
+
+/**
+ * batadv_tp_recv_ack() - ACK receiving function
+ * @bat_priv: the bat priv with all the mesh interface information
+ * @skb: the buffer containing the received packet
+ *
+ * Process a received TP ACK packet
+ */
+static void batadv_tp_recv_ack(struct batadv_priv *bat_priv,
+			       const struct sk_buff *skb)
+{
+	struct batadv_hard_iface *primary_if = NULL;
+	struct batadv_orig_node *orig_node = NULL;
+	const struct batadv_icmp_tp_packet *icmp;
+	enum batadv_tp_ack_reaction reaction;
+	struct batadv_tp_sender *tp_vars;
+	size_t packet_len;
+	u32 recv_ack;
+	size_t mss;
+	u32 rtt;
+
+	packet_len = BATADV_TP_PLEN;
+	mss = BATADV_TP_PLEN;
+	packet_len += sizeof(struct batadv_unicast_packet);
+
+	icmp = (struct batadv_icmp_tp_packet *)skb->data;
+	recv_ack = ntohl(icmp->seqno);
+
+	/* find the tp_vars */
+	tp_vars = batadv_tp_list_find_sender_session(bat_priv, icmp->orig,
+						     icmp->session);
+	if (unlikely(!tp_vars))
+		return;
+
+	if (unlikely(batadv_tp_sender_stopped(tp_vars)))
+		goto out;
+
+	/* old ACK? silently drop it.. */
+	if (batadv_seq_before(recv_ack, READ_ONCE(tp_vars->last_acked)))
+		goto out;
+
+	primary_if = batadv_primary_if_get_selected(bat_priv);
+	if (unlikely(!primary_if))
+		goto out;
+
+	orig_node = batadv_orig_hash_find(bat_priv, icmp->orig);
+	if (unlikely(!orig_node))
+		goto out;
+
+	spin_lock_bh(&tp_vars->cwnd_lock);
+	/* update RTO with the new sampled RTT, if any */
+	rtt = jiffies_to_msecs(jiffies) - ntohl(icmp->timestamp);
+	if (icmp->timestamp && rtt)
+		batadv_tp_update_rto(tp_vars, rtt);
+
+	reaction = batadv_tp_handle_ack(bat_priv, tp_vars, recv_ack, mss);
+	spin_unlock_bh(&tp_vars->cwnd_lock);
+
+	if (reaction == BATADV_TP_ACK_REACTION_OLD_ACK)
+		goto out;
+
+	/* ACK for new data... reset the timer */
+	batadv_tp_reset_sender_timer(tp_vars);
+
+	switch (reaction) {
+	default:
+	case BATADV_TP_ACK_REACTION_IGNORE:
+		goto out;
+	case BATADV_TP_ACK_REACTION_RESEND_WAKEUP:
+		batadv_tp_send_msg(tp_vars, primary_if->net_dev->dev_addr,
+				   orig_node, recv_ack, packet_len,
+				   icmp->session, icmp->uid,
+				   jiffies_to_msecs(jiffies));
+		fallthrough;
+	case BATADV_TP_ACK_REACTION_WAKEUP:
+		wake_up(&tp_vars->more_bytes);
+		break;
 	}
 
-	wake_up(&tp_vars->more_bytes);
 out:
 	batadv_hardif_put(primary_if);
 	batadv_orig_node_put(orig_node);
@@ -819,16 +871,19 @@ static void batadv_tp_recv_ack(struct batadv_priv *bat_priv,
 static bool batadv_tp_avail(struct batadv_tp_sender *tp_vars,
 			    size_t payload_len)
 {
-	u32 last_sent = tp_vars->last_sent;
 	u32 win_left, win_limit;
 
-	win_limit = atomic_read(&tp_vars->last_acked) + tp_vars->cwnd;
+	spin_lock_bh(&tp_vars->cwnd_lock);
 
-	if (batadv_seq_before(last_sent, win_limit))
-		win_left = win_limit - last_sent;
+	win_limit = tp_vars->last_acked + tp_vars->cwnd;
+
+	if (batadv_seq_before(tp_vars->last_sent, win_limit))
+		win_left = win_limit - tp_vars->last_sent;
 	else
 		win_left = 0;
 
+	spin_unlock_bh(&tp_vars->cwnd_lock);
+
 	return win_left >= payload_len;
 }
 
@@ -867,6 +922,7 @@ static int batadv_tp_send(void *arg)
 	struct batadv_hard_iface *primary_if = NULL;
 	struct batadv_orig_node *orig_node = NULL;
 	size_t payload_len, packet_len;
+	u32 last_sent;
 	int err = 0;
 
 	orig_node = batadv_orig_hash_find(bat_priv, tp_vars->common.other_end);
@@ -908,10 +964,10 @@ static int batadv_tp_send(void *arg)
 		 * the size of the unicast header
 		 */
 		packet_len = payload_len + sizeof(struct batadv_unicast_packet);
+		last_sent = READ_ONCE(tp_vars->last_sent);
 
 		err = batadv_tp_send_msg(tp_vars, primary_if->net_dev->dev_addr,
-					 orig_node, tp_vars->last_sent,
-					 packet_len,
+					 orig_node, last_sent, packet_len,
 					 tp_vars->common.session, tp_vars->icmp_uid,
 					 jiffies_to_msecs(jiffies));
 
@@ -926,8 +982,12 @@ static int batadv_tp_send(void *arg)
 		}
 
 		/* right-shift the TWND */
-		if (!err)
-			tp_vars->last_sent += payload_len;
+		if (!err) {
+			spin_lock_bh(&tp_vars->cwnd_lock);
+			if (tp_vars->last_sent == last_sent)
+				WRITE_ONCE(tp_vars->last_sent, last_sent + payload_len);
+			spin_unlock_bh(&tp_vars->cwnd_lock);
+		}
 
 		cond_resched();
 	}
@@ -1044,9 +1104,9 @@ void batadv_tp_start(struct batadv_priv *bat_priv, const u8 *dst,
 	memcpy(tp_vars->common.session, session_id, sizeof(session_id));
 	tp_vars->icmp_uid = icmp_uid;
 
-	tp_vars->last_sent = BATADV_TP_FIRST_SEQ;
-	atomic_set(&tp_vars->dup_acks, 0);
-	atomic_set(&tp_vars->last_acked, BATADV_TP_FIRST_SEQ);
+	WRITE_ONCE(tp_vars->last_sent, BATADV_TP_FIRST_SEQ);
+	WRITE_ONCE(tp_vars->dup_acks, 0);
+	WRITE_ONCE(tp_vars->last_acked, BATADV_TP_FIRST_SEQ);
 	tp_vars->fast_recovery = false;
 	tp_vars->recover = BATADV_TP_FIRST_SEQ;
 
@@ -1063,7 +1123,7 @@ void batadv_tp_start(struct batadv_priv *bat_priv, const u8 *dst,
 	/* RTO initial value is 3 seconds.
 	 * Details in Section 2.1 of RFC6298
 	 */
-	tp_vars->rto = 1000;
+	WRITE_ONCE(tp_vars->rto, 1000);
 	tp_vars->srtt = 0;
 	tp_vars->rttvar = 0;
 
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 4880bf3e..8064f696 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -1348,7 +1348,7 @@ struct batadv_tp_sender {
 	u32 last_sent;
 
 	/** @fast_recovery: true if in Fast Recovery mode */
-	unsigned char fast_recovery:1;
+	bool fast_recovery:1;
 
 	/** @recover: last sent seqno when entering Fast Recovery */
 	u32 recover;
@@ -1371,7 +1371,7 @@ struct batadv_tp_sender {
 	/** @cwnd: current size of the congestion window */
 	u32 cwnd;
 
-	/** @cwnd_lock: lock do protect @cwnd & @dec_cwnd */
+	/** @cwnd_lock: lock do protect congestion control variables */
 	spinlock_t cwnd_lock;
 
 	/**
@@ -1381,13 +1381,13 @@ struct batadv_tp_sender {
 	u32 ss_threshold;
 
 	/** @last_acked: last acked byte */
-	atomic_t last_acked;
+	u32 last_acked;
 
 	/** @tot_sent: amount of data sent/ACKed so far */
 	atomic64_t tot_sent;
 
 	/** @dup_acks: duplicate ACKs counter */
-	atomic_t dup_acks;
+	u8 dup_acks;
 
 	/** @rto: sender timeout */
 	u32 rto;

-- 
2.47.3

