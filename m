Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4639DCD8C9D
	for <batman-adv@archiver.kernel.org>; Thu, 11 Jun 2026 17:30:44 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id CD9A5844C9
	for <batman-adv@archiver.kernel.org>; Thu, 11 Jun 2026 19:30:42 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1781199042;
 b=flDFPDknjiSB+je7jzW08qEPYdj0qllyqz1ypM6Ly1/em1hTpStB1qQJBPuc9HAEmvWgi
 QiSqYNWwg+z288dLU/omOeAFaJFIQgDJqujsH40dkrffcPEOrP+/T1YdS4BsHKFL43J9YgL
 n16hYbxGl54EgIkRu6vLFxtNcoc83GE=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1781199042; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=GVfuD75N1dYUH5tNlumzrTuZxuUB7JTdGmYxeSZsfqM=;
 b=0hkBGdV5puVlZeX0rS+ZIuD1NfWdZ9efdDpsye0hyKOfhFBfwsBYv8Z2XonFXenyDuYBO
 FbOKGFoJxNZNGnWTAwAFvkPSDzrysRenRGPhOK33aXL1E5j476L/Q8mU4B91YI9KvtQCV0J
 pQS52tEeH2lXD6SEPb0mvxUCl80CeYQ=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id B8C8583107
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 11 Jun 2026 19:24:50 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1781198690;
	b=1oFn3R05/HZzqsnBUaEf5mWMtmTd6R5e5jAMW6YA77FUigEdMTS1WIJOirjc3a6JGUbSqZ
	PwB4guQBLvZnULdtdUVyExJFkNhPWp5EUJWiWmELC3JYCH1UttxfaGTzwbH6VMv0tHo10w
	/DeWwcsRcdejJfVE7RoJSUwlrxrNz1U=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1781198690;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=GVfuD75N1dYUH5tNlumzrTuZxuUB7JTdGmYxeSZsfqM=;
	b=DeHK5zJNrmA/9y8mOlkFcQ8X6VAvVdjjMuAAj+3GG31RUqar1OnA8d1kHL2KMhlQMEeRWw
	hO9k2ton9Yne0iP8dlL7LHVY1Q5A9UZxKSsiEl1mAqJ56musHVH9laJve8ddIEcV0SepPX
	F44bjOrRkYb8etRO41GsziX/1FoIvlk=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=f7rwp2GQ;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org
Received: by dvalin.narfation.org (Postfix) id 40B771FD51;
	Thu, 11 Jun 2026 17:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1781198690;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GVfuD75N1dYUH5tNlumzrTuZxuUB7JTdGmYxeSZsfqM=;
	b=f7rwp2GQu/q48XnEMchFNnNMg28haeeo3QifldHx4B75sebT/83MSwXCjUaOO0O/luYhan
	Qldt85rxZo0kye17ERRpAcnN3EawBq8AQ9SqCLlmVav1LDYU4334taQk79onr1802IBlSU
	i/TVS5eCzypGEzee3wL4RqLBFQipMd0=
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 11 Jun 2026 19:24:13 +0200
Subject: [PATCH batadv v2 8/9] batman-adv: tp_meter: adjust name of
 receiver lock
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260611-tp-unacked-list-v2-8-47389466c5c1@narfation.org>
References: <20260611-tp-unacked-list-v2-0-47389466c5c1@narfation.org>
In-Reply-To: <20260611-tp-unacked-list-v2-0-47389466c5c1@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4439; i=sven@narfation.org;
 h=from:subject:message-id; bh=Klse0qO7hjRBHkTjxAStrN7wfnlH5UCj/A6KJWR46iI=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFla761/r7dKn2d1ZMult3tWRW4McS2qKe40WZHz/seDp
 8uibv827ihlYRDjYpAVU2TZcyX//Gb2t/Kfp308CjOHlQlkCAMXpwBM5HQew1+pzaemdvjflrm2
 Lfzp64fai688vce3NW7lqvAbXUG/predZGTY8P/+H9ED7U5c2xyVA77KX3kUMV0rbf3O9P/802c
 mie1lBAA=
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: XQNIEBD6JTTLXIU25ZT7T4L6MPPEOXP6
X-Message-ID-Hash: XQNIEBD6JTTLXIU25ZT7T4L6MPPEOXP6
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/XQNIEBD6JTTLXIU25ZT7T4L6MPPEOXP6/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

The lock used to protect the receiver from reading/writing in parallel to
ack sequence number relevant data was still called unacked_lock. But it is
no longer only about the unacked_list. Use a broader term to reflect this.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/tp_meter.c | 20 ++++++++++----------
 net/batman-adv/types.h    |  4 ++--
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/net/batman-adv/tp_meter.c b/net/batman-adv/tp_meter.c
index f18ce360..ffd3171d 100644
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
index e03f8da1..cc93a2c2 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -1471,8 +1471,8 @@ struct batadv_tp_receiver {
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

