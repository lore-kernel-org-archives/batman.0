Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74819CD98C5
	for <batman-adv@archiver.kernel.org>; Wed, 10 Jun 2026 21:04:50 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id CB9AF83D53
	for <batman-adv@archiver.kernel.org>; Wed, 10 Jun 2026 23:04:48 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1781125488;
 b=uebZinfHx55Btl8moBKckX/o5j5HsvNqEUfBVL31N2zZFYHf/l9++qT7VrONslkNMwCyu
 1X/qIxf+ul9FMON4ZBWCKAMuXxs6xYhGbPHrutgnKS9hQr2V99egeJdYP2ufOfR2uEUYkbe
 6zbVqR1YaZYeHcaedR5bVZWyp/kiWdM=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1781125488; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=AJldo0ZI4mX3oKPslhrWEycjGz6JHqF+PoHrav99ON8=;
 b=ZgbEbRHDxSEJtovx+TSoR1Utlx644XzUBQL1Gy34K8hBCnXDTWpZEl0Pii04oRik4+iqX
 7U/MRXBhoIM/hp1n833LiHotvGf++04Ic2OjuVFLCO0M99Cc/ElSXtPf70vJAR3BRh2fx9k
 rc9tsljPvPDJjMHfW1IaLQf/vg9uz/c=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 7C4F8808C7
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 10 Jun 2026 23:04:30 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1781125480;
	b=pMw37hYSyXcCb1iogGCv53zjDvGr9WrXFP+Fgwuw0fZB2lPdJQswhBemZfgLsj6bJOGVAM
	ZdxqwfRYlbO5yJoX1ZvD5DVF5YXWMDm/TxmqS/JZE0PH9g/XTzqZUzBA1cwRMAXCH7p90y
	bKJBUQ7TLbPL+ueCq/2o7i74RVVz/PU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1781125480;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=AJldo0ZI4mX3oKPslhrWEycjGz6JHqF+PoHrav99ON8=;
	b=fcWXOTENMyw1nPjdT1B4pD/TJFRjpFoTVvn9Aeyzf0zYlfuAsbTGFyN6Ua7uLTl1vRZyZg
	Cl/vGenx2PlsJCqhp/rKqL0SGqKkoGaNyYFXuHMP0NJD4PLcGzx9tl5Nrz7QPCBaiFERQD
	nl/kpune9K/PNygHwwsrEAYF5+B+lhY=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=YCHX0+cc;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org
Received: by dvalin.narfation.org (Postfix) id 5E02820280;
	Wed, 10 Jun 2026 21:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1781125469;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=AJldo0ZI4mX3oKPslhrWEycjGz6JHqF+PoHrav99ON8=;
	b=YCHX0+ccAzSPrYhGYSadysPJ+TKyg6kqaWq3YWG2t5upeVrsDvUbYahieJyZxHw/TiLbYP
	6TFvWF8uLQMYNCwM5G7sW/RXYwZRvXEpys9AX4tCTx304lHO+l46x16i6fyCGXH4QSAxv0
	1FV53oBU9bjDdYA5qJ0w9qWWlRhxfSM=
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 10 Jun 2026 23:04:21 +0200
Subject: [PATCH RFC batadv] batman-adv: tp_meter: restrict number of
 unacked list entries
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260610-tp-unacked-list-limited-v1-1-4ca0787e2fe1@narfation.org>
X-B4-Tracking: v=1; b=H4sIAFTRKWoC/yWMzQrCMBCEX6Xs2UASaESvgg/gVTxsk1XXn7Qk2
 yKUvrtbvQx8M8w3Q6XCVGHfzFBo4sp9VnCbBuId840MJ2Xw1gcbnDUymDFjfFIyL66i8WZRwHb
 rA7kdWd+CvodCV/78zGc4HQ9r16FgmuDyn+vYPSjKaodl+QLsQN3+igAAAA==
X-Change-ID: 20260610-tp-unacked-list-limited-a5726e19e025
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4209; i=sven@narfation.org;
 h=from:subject:message-id; bh=FpPoudMnXb/F3JLbfzgfnDRnfqVMxFACgDTMFJp+9Xc=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFmaFyP1Wp8EdZ05zB/3MjjSd4fPKsGd1hk84mVdM0Uit
 3dySSV0lLIwiHExyIopsuy5kn9+M/tb+c/TPh6FmcPKBDKEgYtTACYiW87w3/1l/KPuXZ6mTlfF
 VH96q0ov7+AV3dTncmT+TZ2cpUzxPxj+cOwNVtwxRy+i7HHRIQ3e4s6bxUUHc6w2fZ7PutP1kf0
 RPgA=
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: RO6OF44UG6TZXZYXHL5W2RMI6TEHFLNQ
X-Message-ID-Hash: RO6OF44UG6TZXZYXHL5W2RMI6TEHFLNQ
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/RO6OF44UG6TZXZYXHL5W2RMI6TEHFLNQ/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

When the unacked_list is unbound, an attacker could send messages with
small lengths and appropriated seqno + gaps to force the receiver to
allocate more and more unacked_list entries. And the end either causing an
out-of-memory situation or increase the management overhead for the (large)
list that significant portions of CPU cycles are wasted in searching
through the list.

When limiting the list to a specific number, it is important to still
correctly add a new entry to the list. But if the list became larger the
limit, the last entry of the list (with the highest seqno) must be dropped
to still allow the earlier seqnos to finish and therefore to continue the
process. Otherwise, the process might get stuck with too high seqnos which
are not handed by batadv_tp_ack_unordered().

Fixes: 98d7a766b645 ("batman-adv: throughput meter implementation")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/tp_meter.c | 23 ++++++++++++++++++++++-
 net/batman-adv/types.h    |  3 +++
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/net/batman-adv/tp_meter.c b/net/batman-adv/tp_meter.c
index 7e98cbfb..259ac8c3 100644
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
index 5fd5bd35..057c5e5d 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -1360,6 +1360,9 @@ struct batadv_tp_vars_common {
 	/** @unacked_lock: protect unacked_list */
 	spinlock_t unacked_lock;
 
+	/** @unacked_count: number of unacked entries */
+	size_t unacked_count;
+
 	/** @refcount: number of context where the object is used */
 	struct kref refcount;
 

---
base-commit: 385b248dd4e46c4ce022adeb1b13e547d1954901
change-id: 20260610-tp-unacked-list-limited-a5726e19e025

Best regards,
--  
Sven Eckelmann <sven@narfation.org>

