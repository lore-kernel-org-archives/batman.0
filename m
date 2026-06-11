Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71F00CD98CE
	for <batman-adv@archiver.kernel.org>; Thu, 11 Jun 2026 17:25:23 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 0D1D484004
	for <batman-adv@archiver.kernel.org>; Thu, 11 Jun 2026 19:25:22 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1781198722;
 b=uqzMJhkXf8ddK6GqjnYfsSPtJRWh7JOUFdUaqEoBe10kJtZ9T+IQz99sUqumAhIKCAwrw
 gbA19ySOyHM/U81SUfJwdgRP6K81zcSWx8dllF/4EvOdYDhfoqQ7bhTqsMQCiJfYWysHJF0
 66mXhpsLooKKq+IUOjxQiDtgUDqeCjo=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1781198722; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=T3VdOBep0+/t5UoOSo2DRIH02vUpSxZ8VwonMBKDNV4=;
 b=ZniHGgRAQV8Q4AwKRUiHuW3Y6PzZuLRZBQjvvFaQeMNFz+oZYUr4V28OTaaL/beQIcGki
 RkK7WmLgFz1RxhqjnfaAd0u6u578oNIP5ey85HfHAGPk0Zr/ja5HnvtveiPNFA0LcziQHpq
 UvoYAd9ToCGgcu7wqYYBVtpcLuhXs6g=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 20E5283E3A
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 11 Jun 2026 19:24:30 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1781198675;
	b=NAeSesq2z+1g356B5bYXV3yqThby47oOg5OaEWdCEb+CL6vFu6a22IOFifKLrHERYvNeXl
	h1I4/54iBUbqLnzuAan4SBbodAB2sw06dypKI8Qtr8q9kBeme4Rn1M1o+nthZyQvdVjDE4
	LpQUvEeWktFPcmDZrBzBN1dnY7NXyBE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1781198675;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=T3VdOBep0+/t5UoOSo2DRIH02vUpSxZ8VwonMBKDNV4=;
	b=Hwrvcd7zVpSzEr28XscL1BA4epBCKYQ0Cg5XYxyChkapRTnfOLKOmCI+GcVLH3ZPzaVUze
	3dUXAKY3Y9BsNOvqVmG1p7NcGmBMGwsd+QSSGsldoEZba1JDON7TB9fLBjNBcDczUefvF7
	6RdU1nXfiFhN1LOzNM7i7f/KKtZ5rU0=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=Q6uIoayK;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org
Received: by dvalin.narfation.org (Postfix) id 62E2A20019;
	Thu, 11 Jun 2026 17:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1781198669;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T3VdOBep0+/t5UoOSo2DRIH02vUpSxZ8VwonMBKDNV4=;
	b=Q6uIoayKxjm8F5rF8oazjF37CUFvQEzLUBzXoM6hWzFZfwWVQeu7GQ6I6IWT7ve85pokBd
	y3L4EDwS1DWRXzaCRQFU2x9ElDjFP8iV3cKSdLlU4UafHQqm15C2TZ4cr52tpnp/iUTQh4
	RbcCNjqvEOC5FndDDjxnxbLwuQtpdQw=
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 11 Jun 2026 19:24:06 +0200
Subject: [PATCH batadv v2 1/9] batman-adv: tp_meter: restrict number of
 unacked list entries
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260611-tp-unacked-list-v2-1-47389466c5c1@narfation.org>
References: <20260611-tp-unacked-list-v2-0-47389466c5c1@narfation.org>
In-Reply-To: <20260611-tp-unacked-list-v2-0-47389466c5c1@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4050; i=sven@narfation.org;
 h=from:subject:message-id; bh=lmZlS4549nIwElkslJe2kGQdkg3DjOI3ExyzvGDLjlM=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFla762aJHqEHF1nOS+fa7NDwp97xtTLDcGeiVLXnz+I1
 G1068zvKGVhEONikBVTZNlzJf/8Zva38p+nfTwKM4eVCWQIAxenAExEvp7hr8Cf6x0bT19TeXXy
 +ENR2yIL2ftS1ooKkw3k+QKeuUw3L2T4X3ROee2mDYGPFvp9Y7j/u8SSa1U6i13niSNKe79ua/Z
 KYAUA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: 5BDYQ5ON6BCOKGRE37IBGLDZSVKPBMMW
X-Message-ID-Hash: 5BDYQ5ON6BCOKGRE37IBGLDZSVKPBMMW
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/5BDYQ5ON6BCOKGRE37IBGLDZSVKPBMMW/>
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
correctly add a new entry to the list. But if the list became larger than
the limit, the last entry of the list (with the highest seqno) must be
dropped to still allow the earlier seqnos to finish and therefore to
continue the process. Otherwise, the process might get stuck with too high
seqnos which are not handled by batadv_tp_ack_unordered().

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
 

-- 
2.47.3

