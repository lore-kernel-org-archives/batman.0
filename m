Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7A45CD98F6
	for <batman@archiver.kernel.org>; Fri, 19 Jun 2026 07:07:49 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 53201855F8
	for <batman@archiver.kernel.org>; Fri, 19 Jun 2026 09:07:48 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1781852868;
 b=SalvlpwUYzQCJ89wNOCJ0GZkLBtoCnvPLoIho1oaJPS+Sa5DKtHcKUddQxA9HmztE132c
 PW9wdc9UuCMdaWajLvpHvEMmGds0EsZtubKfML17FO+SH1KX6p+TW34G7RlaXTaWZ/KS9j/
 pVhjhdi5ko78w9LH6avNFNlz4fwFU18=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1781852868; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=rCAtFVt4ZMP2kO4nXKaanvQl9nP0Gsfhi/ip7sFYGPU=;
 b=XT1HtJ3uwl11XsEdmre6+bHfB/Xbj+yN5ECs8JFp2JvbqWOtN5+R3CPyC2U4mvbNGV6Da
 F9rdq81rE3AEz7RBea2vVY80dfg3db601lymOGfdtBEA0aJyubDIRbsmqV4Tw6NTwDvX5/P
 fJl6M/IyNDFRFr7VFNhZYpL0Q77ZpaE=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 17D1483176
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 19 Jun 2026 09:00:54 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1781852455;
	b=FOrMND1XQhrYzqouC9Kh5m5c37YV1Fdye7U6d3eu6QksiJga6lptFi3zkV+kbylM5vCFYl
	myeofaPs/olYd0QORu+AXaSMQn3rSw2Hj6dRVK6rGXaYd7NAW+ifsPw8TBhOEqhS3EhH47
	+vRc1gfyt3YULsYC08n2S+x8GH/EAog=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1781852455;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=rCAtFVt4ZMP2kO4nXKaanvQl9nP0Gsfhi/ip7sFYGPU=;
	b=3II3jEJXxyHdt/H7vZ+kcTbcRgpHtqjPXKG0UwbmEwK76jw30+gMIk7mxlFSwWj2/tNY8H
	w6XoCLnbc2iOGgeSi0ANqcPaIbv2s6G6C9JZJxtmn0mR1PUioCALQSZZKMVqEM9wxua/EF
	hErjZTb45GXaFl1YHReEfYe+0ftUGko=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=A05KCRQy;
	dmarc=pass (policy=none) header.from=simonwunderlich.de;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 23.88.38.48 as permitted sender) smtp.mailfrom=sw@simonwunderlich.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1781852453;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rCAtFVt4ZMP2kO4nXKaanvQl9nP0Gsfhi/ip7sFYGPU=;
	b=A05KCRQyRsYS6Idsa7MZHFlmbya3+zeRShHcAVvPsZsqIarAL01Deio+sNEwSD8rDid3bG
	WEITAEuS6sxkLMkp8WDaHR8WXRq0D8RNUOgOyzZiYKFeDmMGxqk8M0BZTBdBOfawuOCLbE
	JaLFbh51h0/79NX95M35EqXyXIHCjRS4sRoWvSR75APlEGar3pLyzfyMzOEZ4nmoz5MRK0
	N6Ix2Ihw0EXjfO9ANeTJqbaD+kQVN0yOlbjP02t8VR+TbPlfvvX/R2c82TgOY8csi1aRFc
	ZXyupNB/4UW5i6MBFUinAbnwt+DDIScFyLRVWfLROdbJEIFsNFwsQX4ZmeUwFA==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Sven Eckelmann <sven@narfation.org>,
	stable@kernel.org,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net 09/15] batman-adv: tp_meter: prevent parallel
 modifications of last_recv
Date: Fri, 19 Jun 2026 09:00:39 +0200
Message-ID: <20260619070045.438101-10-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260619070045.438101-1-sw@simonwunderlich.de>
References: <20260619070045.438101-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: OAYQ5ARPSCC6MOKVTUPZ362UVKVLDPE7
X-Message-ID-Hash: OAYQ5ARPSCC6MOKVTUPZ362UVKVLDPE7
X-MailFrom: sw@simonwunderlich.de
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/OAYQ5ARPSCC6MOKVTUPZ362UVKVLDPE7/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Sven Eckelmann <sven@narfation.org>

When last_recv is updated to store the last receive sequence number, it is
assuming that nothing is modifying in parallel while:

* check for outdated packets is done
* out of order check is performed (and packets are stored in out-of-order
  queue)
* the out-of-order queue was searched for closed gaps
* sequence number for next ack is calculated

Nothing of that was actually protected. It could therefore happen that the
last_recv was updated multiple times in parallel and the final sequence
number was calculated with deltas which had no connection to the sequence
number they were added to.

Lock this whole region with the same lock which was already used to protect
the unacked (out-of-order) list.

Cc: stable@kernel.org
Fixes: 33a3bb4a3345 ("batman-adv: throughput meter implementation")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/tp_meter.c | 22 +++++++++++++---------
 net/batman-adv/types.h    |  2 +-
 2 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/net/batman-adv/tp_meter.c b/net/batman-adv/tp_meter.c
index fb87fa141e32a..055aa1ee6ac5c 100644
--- a/net/batman-adv/tp_meter.c
+++ b/net/batman-adv/tp_meter.c
@@ -1402,6 +1402,7 @@ static int batadv_tp_send_ack(struct batadv_priv *bat_priv, const u8 *dst,
  */
 static bool batadv_tp_handle_out_of_order(struct batadv_tp_receiver *tp_vars,
 					  const struct sk_buff *skb)
+	__must_hold(&tp_vars->common.unacked_lock)
 {
 	const struct batadv_icmp_tp_packet *icmp;
 	struct batadv_tp_unacked *un, *new;
@@ -1418,12 +1419,11 @@ static bool batadv_tp_handle_out_of_order(struct batadv_tp_receiver *tp_vars,
 	payload_len = skb->len - sizeof(struct batadv_unicast_packet);
 	new->len = payload_len;
 
-	spin_lock_bh(&tp_vars->common.unacked_lock);
 	/* if the list is empty immediately attach this new object */
 	if (list_empty(&tp_vars->common.unacked_list)) {
 		list_add(&new->list, &tp_vars->common.unacked_list);
 		tp_vars->common.unacked_count++;
-		goto out;
+		return true;
 	}
 
 	/* otherwise loop over the list and either drop the packet because this
@@ -1472,9 +1472,6 @@ static bool batadv_tp_handle_out_of_order(struct batadv_tp_receiver *tp_vars,
 		tp_vars->common.unacked_count--;
 	}
 
-out:
-	spin_unlock_bh(&tp_vars->common.unacked_lock);
-
 	return true;
 }
 
@@ -1484,6 +1481,7 @@ static bool batadv_tp_handle_out_of_order(struct batadv_tp_receiver *tp_vars,
  * @tp_vars: the private data of the current TP meter session
  */
 static void batadv_tp_ack_unordered(struct batadv_tp_receiver *tp_vars)
+	__must_hold(&tp_vars->common.unacked_lock)
 {
 	struct batadv_tp_unacked *un, *safe;
 	u32 to_ack;
@@ -1491,7 +1489,6 @@ static void batadv_tp_ack_unordered(struct batadv_tp_receiver *tp_vars)
 	/* go through the unacked packet list and possibly ACK them as
 	 * well
 	 */
-	spin_lock_bh(&tp_vars->common.unacked_lock);
 	list_for_each_entry_safe(un, safe, &tp_vars->common.unacked_list, list) {
 		/* the list is ordered, therefore it is possible to stop as soon
 		 * there is a gap between the last acked seqno and the seqno of
@@ -1509,7 +1506,6 @@ static void batadv_tp_ack_unordered(struct batadv_tp_receiver *tp_vars)
 		kfree(un);
 		tp_vars->common.unacked_count--;
 	}
-	spin_unlock_bh(&tp_vars->common.unacked_lock);
 }
 
 /**
@@ -1588,6 +1584,7 @@ static void batadv_tp_recv_msg(struct batadv_priv *bat_priv,
 	const struct batadv_icmp_tp_packet *icmp;
 	struct batadv_tp_receiver *tp_vars;
 	size_t packet_size;
+	u32 to_ack;
 	u32 seqno;
 
 	icmp = (struct batadv_icmp_tp_packet *)skb->data;
@@ -1616,6 +1613,8 @@ static void batadv_tp_recv_msg(struct batadv_priv *bat_priv,
 		WRITE_ONCE(tp_vars->last_recv_time, jiffies);
 	}
 
+	spin_lock_bh(&tp_vars->common.unacked_lock);
+
 	/* if the packet is a duplicate, it may be the case that an ACK has been
 	 * lost. Resend the ACK
 	 */
@@ -1627,8 +1626,10 @@ static void batadv_tp_recv_msg(struct batadv_priv *bat_priv,
 		/* exit immediately (and do not send any ACK) if the packet has
 		 * not been enqueued correctly
 		 */
-		if (!batadv_tp_handle_out_of_order(tp_vars, skb))
+		if (!batadv_tp_handle_out_of_order(tp_vars, skb)) {
+			spin_unlock_bh(&tp_vars->common.unacked_lock);
 			goto out;
+		}
 
 		/* send a duplicate ACK */
 		goto send_ack;
@@ -1642,11 +1643,14 @@ static void batadv_tp_recv_msg(struct batadv_priv *bat_priv,
 	batadv_tp_ack_unordered(tp_vars);
 
 send_ack:
+	to_ack = tp_vars->last_recv;
+	spin_unlock_bh(&tp_vars->common.unacked_lock);
+
 	/* send the ACK. If the received packet was out of order, the ACK that
 	 * is going to be sent is a duplicate (the sender will count them and
 	 * possibly enter Fast Retransmit as soon as it has reached 3)
 	 */
-	batadv_tp_send_ack(bat_priv, icmp->orig, tp_vars->last_recv,
+	batadv_tp_send_ack(bat_priv, icmp->orig, to_ack,
 			   icmp->timestamp, icmp->session, icmp->uid);
 out:
 	batadv_tp_receiver_put(tp_vars);
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 9fa8e73ff6e59..c1b3f989566f5 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -1363,7 +1363,7 @@ struct batadv_tp_vars_common {
 	/** @unacked_list: list of unacked packets (meta-info only) */
 	struct list_head unacked_list;
 
-	/** @unacked_lock: protect unacked_list */
+	/** @unacked_lock: protect unacked_list + &batadv_tp_receiver.last_recv */
 	spinlock_t unacked_lock;
 
 	/** @unacked_count: number of unacked entries */
-- 
2.47.3

