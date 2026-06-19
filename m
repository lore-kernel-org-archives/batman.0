Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C74ECD98F6
	for <batman@archiver.kernel.org>; Fri, 19 Jun 2026 07:03:23 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id DE39A841DE
	for <batman@archiver.kernel.org>; Fri, 19 Jun 2026 09:03:21 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1781852601;
 b=1qC/n9g9bLGLiQ28pWF1da06ELd8bac3jESDiWSIjAoOI9Cz5QzruH92Sz5C+PQeMllOw
 JxkWpZrPKnWeI6FQh+RSvHU0WKbvtZFgGWLgNGLKpzrGEDwkHBAjVgeBdiLN7TlFXVMlVsM
 cANIjM2FG7k3uCxSyFIZ2QQUu3syEqs=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1781852601; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=2kBmYM7cKZK+VnBuVFOAYovV9CgsOEsRM5SEqnA1Xz0=;
 b=D+ym+6XxM8ZIX28dvgznxad7zFnLfljCQy20Nb3HQn8GGWF/XrYSNKGLXwGnGNhZ4ca5k
 KhdFO+xJyhs6mlrokgyLjuMTfGhb6XXFprnQ+Y5/vsDnpCZim71aA+B2aqmO0SR4uCLe7jz
 aP1V10Cwukm/s/FNpaAdTRop4R8W860=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de
 [IPv6:2a01:4f8:c17:e8c0::1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 4110583258
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 19 Jun 2026 09:00:54 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1781852454;
	b=m781+Ku88lX7Fdy7RIEJBvTrnkhxYjihQhJ/ozSMzswiZpT3GKSX7zmJbsEWTiXLzWYTLx
	erCWYsWBCPmr6jMudhjiLVFTUspfgrIiMVO290F9Cg9u0rxIeoW8WUPgBKagLjTd9slfe4
	Xtd1cTd7AZn4Y32h2Az31SWc5ZEm0gI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1781852454;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=2kBmYM7cKZK+VnBuVFOAYovV9CgsOEsRM5SEqnA1Xz0=;
	b=Ghp+iPm+nvnGBfjUetWEZpPUmkRIzbmzP0KOpcu4e40+ZY2CXX/20IY4dW5s8ZfO8tACwC
	ZFaexlQFj1E7JfqTsu4fP+LRnMGgmQoSpCoV0wu+iDBbK27QE93dxUTvEDGXeIhTocnIJK
	sOVBwABMjYYECvPlAuuoivYxGm3wo/A=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=xih1w9Ds;
	dmarc=pass (policy=none) header.from=simonwunderlich.de;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 2a01:4f8:c17:e8c0::1 as permitted sender) smtp.mailfrom=sw@simonwunderlich.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1781852452;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2kBmYM7cKZK+VnBuVFOAYovV9CgsOEsRM5SEqnA1Xz0=;
	b=xih1w9DscKlEeeP/K1YS57wWF1iTZZIASHTXIFui/mHEcuSr33VHknvnEuX+EkYzf6dJ9H
	Zeu6KLHPENAv/a+SsW9ZMVhZnsJsVDbftxyeLMjYVbz6EoD0ORpTeOB1xZz7KxVG7X9jm2
	4v2yY2XWmXVIYLvUBSeeqx1mE5MEfHpiuTkS1fZvSj4WQX14r3Vwayqbzvatn0nOjv6B1X
	uhzn5ik68qCyzmfTVmPzMWoTWSdmwesu9zyEV+t5hfMhDivKfQg1TOW8wZtr3/1ADd3mNZ
	jRK0GcyH9Resot8DUUyW3MfQebSz4FGVoR/FloEF2scA/VUQAhQFKbWnRQnAng==
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
Subject: [PATCH net 07/15] batman-adv: tp_meter: restrict number of unacked
 list entries
Date: Fri, 19 Jun 2026 09:00:37 +0200
Message-ID: <20260619070045.438101-8-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260619070045.438101-1-sw@simonwunderlich.de>
References: <20260619070045.438101-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: NNGDIBXTNZUIUTOIXSZ3VQ6LMR4Q562J
X-Message-ID-Hash: NNGDIBXTNZUIUTOIXSZ3VQ6LMR4Q562J
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/NNGDIBXTNZUIUTOIXSZ3VQ6LMR4Q562J/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Sven Eckelmann <sven@narfation.org>

When the unacked_list is unbound, an attacker could send messages with
small lengths and appropriated seqno + gaps to force the receiver to
allocate more and more unacked_list entries. And the end either causing an
out-of-memory situation or increase the management overhead for the (large)
list that significant portions of CPU cycles are wasted in searching
through the list.

When limiting the list to a specific number, it is important to still
correctly add a new entry to the list. But if the list became larger than
the limit, the last entry of the list (with the highest seqno) must be
dropped to still allow the earlier seqnos to finish and therefore to
continue the process. Otherwise, the process might get stuck with too high
seqnos which are not handled by batadv_tp_ack_unordered().

Cc: stable@kernel.org
Fixes: 33a3bb4a3345 ("batman-adv: throughput meter implementation")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/tp_meter.c | 23 ++++++++++++++++++++++-
 net/batman-adv/types.h    |  3 +++
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/net/batman-adv/tp_meter.c b/net/batman-adv/tp_meter.c
index 7e98cbfbbb70d..259ac8c307359 100644
--- a/net/batman-adv/tp_meter.c
+++ b/net/batman-adv/tp_meter.c
@@ -87,6 +87,11 @@
 #define BATADV_TP_PLEN (BATADV_TP_PACKET_LEN - ETH_HLEN - \
 			sizeof(struct batadv_unicast_packet))
 
+/**
+ * BATADV_TP_MAX_UNACKED - maximum number of packets a receiver didn't yet ack
+ */
+#define BATADV_TP_MAX_UNACKED 100
+
 static u8 batadv_tp_prerandom[4096] __read_mostly;
 
 /**
@@ -1303,6 +1308,7 @@ static void batadv_tp_receiver_shutdown(struct timer_list *t)
 	list_for_each_entry_safe(un, safe, &tp_vars->common.unacked_list, list) {
 		list_del(&un->list);
 		kfree(un);
+		tp_vars->common.unacked_count--;
 	}
 	spin_unlock_bh(&tp_vars->common.unacked_lock);
 
@@ -1416,6 +1422,7 @@ static bool batadv_tp_handle_out_of_order(struct batadv_tp_receiver *tp_vars,
 	/* if the list is empty immediately attach this new object */
 	if (list_empty(&tp_vars->common.unacked_list)) {
 		list_add(&new->list, &tp_vars->common.unacked_list);
+		tp_vars->common.unacked_count++;
 		goto out;
 	}
 
@@ -1446,12 +1453,24 @@ static bool batadv_tp_handle_out_of_order(struct batadv_tp_receiver *tp_vars,
 		 */
 		list_add(&new->list, &un->list);
 		added = true;
+		tp_vars->common.unacked_count++;
 		break;
 	}
 
 	/* received packet with smallest seqno out of order; add it to front */
-	if (!added)
+	if (!added) {
 		list_add(&new->list, &tp_vars->common.unacked_list);
+		tp_vars->common.unacked_count++;
+	}
+
+	/* remove the last (biggest) unacked seqno when list is too large */
+	if (tp_vars->common.unacked_count > BATADV_TP_MAX_UNACKED) {
+		un = list_last_entry(&tp_vars->common.unacked_list,
+				     struct batadv_tp_unacked, list);
+		list_del(&un->list);
+		kfree(un);
+		tp_vars->common.unacked_count--;
+	}
 
 out:
 	spin_unlock_bh(&tp_vars->common.unacked_lock);
@@ -1488,6 +1507,7 @@ static void batadv_tp_ack_unordered(struct batadv_tp_receiver *tp_vars)
 
 		list_del(&un->list);
 		kfree(un);
+		tp_vars->common.unacked_count--;
 	}
 	spin_unlock_bh(&tp_vars->common.unacked_lock);
 }
@@ -1537,6 +1557,7 @@ batadv_tp_init_recv(struct batadv_priv *bat_priv,
 
 	spin_lock_init(&tp_vars->common.unacked_lock);
 	INIT_LIST_HEAD(&tp_vars->common.unacked_list);
+	tp_vars->common.unacked_count = 0;
 
 	kref_get(&tp_vars->common.refcount);
 	timer_setup(&tp_vars->common.timer, batadv_tp_receiver_shutdown, 0);
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 5e81c93b8217d..9fa8e73ff6e59 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -1366,6 +1366,9 @@ struct batadv_tp_vars_common {
 	/** @unacked_lock: protect unacked_list */
 	spinlock_t unacked_lock;
 
+	/** @unacked_count: number of unacked entries */
+	size_t unacked_count;
+
 	/** @refcount: number of context where the object is used */
 	struct kref refcount;
 
-- 
2.47.3

