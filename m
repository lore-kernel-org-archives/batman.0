Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 514BCC43327
	for <batman-adv@archiver.kernel.org>; Tue, 30 Jun 2026 14:17:25 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id E1BDF8467B
	for <batman-adv@archiver.kernel.org>; Tue, 30 Jun 2026 16:17:23 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1782829043;
 b=jnAYQ7yfZO8M/UQ0imo4fQjqa38RW6hfbws+yckAuSscsV7nLM1oOTW0qSpQ1Sd1e9E6B
 7FYpO65+N1F4xZdS7sP1GNzrg34rWzXIxIaig74rusNeYcMd3sDLHr6uWanSP4uPhr369Bg
 F5gMyIjDIeWVA1gFjuaGzHhqelHZO2k=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1782829043; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=FzCjWzxPf+rT6MJjI3OB0RLIvAemy3SqIq2nFw9BYZQ=;
 b=yPtfemUgR/7xO9Rp60SI1F11wxdybaSuJQSpzRnTjxSYd6vdx9i39HupEKnSzrJ0FE/4p
 FJJNTmxEJJaSvUQZB+ZTVhRR3O3yzSkTvmkXULslgO6gu5NScxgDcI99z7VhqNAoc9NAxqg
 aWbmusH06AcYGUX5gcwL3KC8zk9Rt7A=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 815FF81125
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 30 Jun 2026 16:06:35 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1782828395;
	b=XfzC5RJvx7f8MomPqwLuks9O0Wafh2qbOiZiXyDTg8Jf0DAG/6ScDhk9DP7VdTKHy9n1JY
	T5oxy8jroKelTk5aq6tTON1ZRJ+X0aJ6jacu3/OPVt3DNi/U/FwpCZWnXi/x15P27/vsOE
	9url/3jg2vFD/PU3rBnU36GsFTwJ0iE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1782828395;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=FzCjWzxPf+rT6MJjI3OB0RLIvAemy3SqIq2nFw9BYZQ=;
	b=3F6uOqXEnAu9C68R+lUdGWS95YJkO57xkqTq98iilYXEr9GfSgihfjy86ITRHNRlKThZ/e
	udn/vmOIEe1YtXwy6um0FbL+Jq95lJNZ7LbyPK/eK02OwTV2xAiyjN/qKscKuTdI9CxyS0
	2WItZUTd1GlpP9FWIpfJ9fF55jQqM6I=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=qdPZ2eil;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 23.88.38.48 as permitted sender) smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1782828394;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FzCjWzxPf+rT6MJjI3OB0RLIvAemy3SqIq2nFw9BYZQ=;
	b=qdPZ2eilYd36XOZnTFmPQp4sVzBR6we9y7v5dhE6p1bBk+tCUSChH60ST3EMkmn4bwUKzF
	vgt2fgiMVvWHGMxHIfxWMFDDX8Y0Eep6cttIr/H9UOPQI6BTiTCYvY68TJksphYvQnHief
	0Fmtfjm8Dporxmnt51lKSQl6ZApx+NXEjHHycSwSGStMfYWY85wir6mLHCpKRLw7nbI8WW
	XivHJYYdLaHfNSEzau4A3QLNoxCPuy5rlvhxz6x1A/sOFiWsq0flEkL6kieg6vgiKpPCdZ
	NG0oL39g/JewXb/jWcxIoZTE9xx/JkYZCSewCDzAnG2+J+KiEix9GjjWn/dnKg==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Sven Eckelmann <sven@narfation.org>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net-next 14/15] batman-adv: tp_meter: adjust name of receiver
 lock
Date: Tue, 30 Jun 2026 16:06:22 +0200
Message-ID: <20260630140623.88431-15-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260630140623.88431-1-sw@simonwunderlich.de>
References: <20260630140623.88431-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: K3VJ4CEMIOPOTLQQLT7EKFHYSFWSJZ7Z
X-Message-ID-Hash: K3VJ4CEMIOPOTLQQLT7EKFHYSFWSJZ7Z
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/K3VJ4CEMIOPOTLQQLT7EKFHYSFWSJZ7Z/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Sven Eckelmann <sven@narfation.org>

The lock used to protect the receiver from reading/writing in parallel to
ack sequence number relevant data was still called unacked_lock. But it is
no longer only about the unacked_list. Use a broader term to reflect this.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/tp_meter.c | 20 ++++++++++----------
 net/batman-adv/types.h    |  4 ++--
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/net/batman-adv/tp_meter.c b/net/batman-adv/tp_meter.c
index f18ce360839d3..ffd3171d4b992 100644
--- a/net/batman-adv/tp_meter.c
+++ b/net/batman-adv/tp_meter.c
@@ -1252,13 +1252,13 @@ static void batadv_tp_receiver_release(struct kref *ref)
 	/* lock should not be needed because this object is now out of any
 	 * context!
 	 */
-	spin_lock_bh(&tp_vars->unacked_lock);
+	spin_lock_bh(&tp_vars->ack_seqno_lock);
 	list_for_each_entry_safe(un, safe, &tp_vars->unacked_list, list) {
 		list_del(&un->list);
 		kfree(un);
 		tp_vars->unacked_count--;
 	}
-	spin_unlock_bh(&tp_vars->unacked_lock);
+	spin_unlock_bh(&tp_vars->ack_seqno_lock);
 
 	kfree_rcu(tp_vars, common.rcu);
 }
@@ -1316,13 +1316,13 @@ static void batadv_tp_receiver_shutdown(struct timer_list *t)
 	if (batadv_tp_list_detach(&tp_vars->common))
 		batadv_tp_receiver_put(tp_vars);
 
-	spin_lock_bh(&tp_vars->unacked_lock);
+	spin_lock_bh(&tp_vars->ack_seqno_lock);
 	list_for_each_entry_safe(un, safe, &tp_vars->unacked_list, list) {
 		list_del(&un->list);
 		kfree(un);
 		tp_vars->unacked_count--;
 	}
-	spin_unlock_bh(&tp_vars->unacked_lock);
+	spin_unlock_bh(&tp_vars->ack_seqno_lock);
 
 	/* drop reference of timer */
 	if (WARN_ON(atomic_xchg(&tp_vars->receiving, 0) != 1))
@@ -1415,7 +1415,7 @@ static int batadv_tp_send_ack(struct batadv_priv *bat_priv, const u8 *dst,
  */
 static bool batadv_tp_handle_out_of_order(struct batadv_tp_receiver *tp_vars,
 					  u32 seqno, u32 payload_len)
-	__must_hold(&tp_vars->unacked_lock)
+	__must_hold(&tp_vars->ack_seqno_lock)
 {
 	struct batadv_tp_unacked *un, *new;
 	struct batadv_tp_unacked *safe;
@@ -1532,7 +1532,7 @@ static bool batadv_tp_handle_out_of_order(struct batadv_tp_receiver *tp_vars,
  * @tp_vars: the private data of the current TP meter session
  */
 static void batadv_tp_ack_unordered(struct batadv_tp_receiver *tp_vars)
-	__must_hold(&tp_vars->unacked_lock)
+	__must_hold(&tp_vars->ack_seqno_lock)
 {
 	struct batadv_tp_unacked *un, *safe;
 	u32 to_ack;
@@ -1602,7 +1602,7 @@ batadv_tp_init_recv(struct batadv_priv *bat_priv,
 	tp_vars->common.bat_priv = bat_priv;
 	kref_init(&tp_vars->common.refcount);
 
-	spin_lock_init(&tp_vars->unacked_lock);
+	spin_lock_init(&tp_vars->ack_seqno_lock);
 	INIT_LIST_HEAD(&tp_vars->unacked_list);
 	tp_vars->unacked_count = 0;
 
@@ -1664,7 +1664,7 @@ static void batadv_tp_recv_msg(struct batadv_priv *bat_priv,
 		WRITE_ONCE(tp_vars->last_recv_time, jiffies);
 	}
 
-	spin_lock_bh(&tp_vars->unacked_lock);
+	spin_lock_bh(&tp_vars->ack_seqno_lock);
 
 	/* if the packet is a duplicate, it may be the case that an ACK has been
 	 * lost. Resend the ACK
@@ -1680,7 +1680,7 @@ static void batadv_tp_recv_msg(struct batadv_priv *bat_priv,
 		 * not been enqueued correctly
 		 */
 		if (!batadv_tp_handle_out_of_order(tp_vars, seqno, payload_len)) {
-			spin_unlock_bh(&tp_vars->unacked_lock);
+			spin_unlock_bh(&tp_vars->ack_seqno_lock);
 			goto out;
 		}
 
@@ -1696,7 +1696,7 @@ static void batadv_tp_recv_msg(struct batadv_priv *bat_priv,
 
 send_ack:
 	to_ack = tp_vars->last_recv;
-	spin_unlock_bh(&tp_vars->unacked_lock);
+	spin_unlock_bh(&tp_vars->ack_seqno_lock);
 
 	/* send the ACK. If the received packet was out of order, the ACK that
 	 * is going to be sent is a duplicate (the sender will count them and
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index c194d8069774c..cd12755d21f35 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -1474,8 +1474,8 @@ struct batadv_tp_receiver {
 	/** @unacked_list: list of unacked packets (meta-info only) */
 	struct list_head unacked_list;
 
-	/** @unacked_lock: protect unacked_list + &batadv_tp_receiver.last_recv */
-	spinlock_t unacked_lock;
+	/** @ack_seqno_lock: protect unacked_list + &batadv_tp_receiver.last_recv */
+	spinlock_t ack_seqno_lock;
 
 	/** @unacked_count: number of unacked entries */
 	size_t unacked_count;
-- 
2.47.3

