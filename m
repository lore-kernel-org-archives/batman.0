Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A06F4CD4851
	for <batman@archiver.kernel.org>; Fri, 15 May 2026 09:56:14 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 2B64885ABC
	for <batman@archiver.kernel.org>; Fri, 15 May 2026 11:56:13 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1778838973;
 b=EpyCCk5w5qbEqL/6lpaVA4QKi/k/WH7gIWIYE88FzG3M4TzTS6O7AhqIMvWiJ5a19RXbo
 8jz6SyMLMD2heCgKo+K7OHl/ul8JdHKVsl4P7yxI/HaJSSb5W2eR5I0+ZW1HWTipSdhljQn
 k/AAx2C50S7pXw7zkYiAqk3Y/G2jfaE=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1778838973; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=z/spqeaHa4lgN1IdgCg3OUKQveI8w5SpYJn4beTiC/A=;
 b=e3BCTteupJtQIPSrteaORRse/Zz5j56j4TTpKCkmdrGHdPoWwqcqv8UgU7OkRJxglusxZ
 U9RpqKelTa2ShCgT/g99HL0Zmk6AQMJxuS9c1i6vYKXsDyNqLlev+uBDXZQPzqdDTHp89lp
 ZAHVXv5nSjDGWtOZ6T3vjx2L0ygmnrQ=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 1342084C80
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 15 May 2026 11:55:51 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1778838951;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=z/spqeaHa4lgN1IdgCg3OUKQveI8w5SpYJn4beTiC/A=;
	b=fxXG4LU2OrAq/8MfUuvrHcXx8bF/mRj609eMEx5WJCkPiGJW425Pibrp25oVxRpVDpxqMi
	qpH6zikmH3jtVwZOCarY6eqTRDpSigw4Pvgnpd1sMYLPzFjXTZmMvGDs1qCikZar9UBXfU
	l1PmlKMhAql1DQ9L0NebkyzAoGMGNEk=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=NTXOFFco;
	dmarc=pass (policy=none) header.from=simonwunderlich.de;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 23.88.38.48 as permitted sender) smtp.mailfrom=sw@simonwunderlich.de
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1778838951;
	b=pJ8DPDcJmPBerEcqHwueYyFJ7gJzqIgzXATKF7VCXnZf6FdSeYiSydA6sjEJGNyBxBWPIy
	lQXZmEbs71pC7La+Epbs3zomGjjJjWpMK6Fcu8vVjKwYnQVHaEYt21hWpBduJ5LhG4XK4L
	qVbjBogZDMOT79xp4rKp83Mm+awGZGM=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1778838948;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z/spqeaHa4lgN1IdgCg3OUKQveI8w5SpYJn4beTiC/A=;
	b=NTXOFFco7w4G73JPwv3L2QIxpGEjVWgGcjnw+mtQ7rG51bb71IDmXZdMqokUyGFtu4Izpz
	F8InecqiI1WYoGxyWY4BTqDNav52h495JqPDwXLbUZBtOsvxWlfXoNbzTe+JHheT8Bi3PL
	fS83pQGEEqjq3tTrV1BjTCGdnlQ2d4OurQNWHLEAxLjcgTtTZ8OwwSITTmdB7/7QK3vqi3
	BWVWBXIrZk1/i/raOrbfkC4+epLb0qzynOj464WmU7O1AsmIiL5AwdXfk0xLsXmSJNBVHH
	OjtBS3O+26RCxPP8F2zWmXejzt3l/cgWiRVzNzOl/YrtR/u2FxwHtOTcyt7kpw==
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
Subject: [PATCH net 02/14] batman-adv: tp_meter: fix tp_vars reference leak in
 receiver shutdown
Date: Fri, 15 May 2026 11:55:27 +0200
Message-ID: <20260515095540.325586-3-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260515095540.325586-1-sw@simonwunderlich.de>
References: <20260515095540.325586-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: MEHWVDVRDCJ6ITOCOIZFIARB2FA7Y7BV
X-Message-ID-Hash: MEHWVDVRDCJ6ITOCOIZFIARB2FA7Y7BV
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/MEHWVDVRDCJ6ITOCOIZFIARB2FA7Y7BV/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Sven Eckelmann <sven@narfation.org>

The receiver shutdown timer handler, batadv_tp_receiver_shutdown(), is
responsible for releasing the tp_vars reference it holds. However, the
existing logic for coordinating this release with batadv_tp_stop_all() was
flawed.

timer_shutdown_sync() guarantees the timer will not fire again after it
returns, but it returns non-zero only when the timer was pending at the
time of the call. If the timer had already expired (and
batadv_tp_stop_all() would unsucessfully try to  rearm itself),
batadv_tp_stop_all() skips its batadv_tp_vars_put(), and
batadv_tp_receiver_shutdown() fails to put its own reference as well.

Fix this by introducing a new atomic variable receiving that is set to 1
when the receiver is initialized and cleared atomically with atomic_xchg()
by whichever side claims it first. Only the side that observes the
transition from 1 to 0 is responsible for releasing the tp_vars timer
reference, eliminating the uncertainty.

Cc: stable@kernel.org
Fixes: 3d3cf6a7314a ("batman-adv: stop tp_meter sessions during mesh teardown")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/tp_meter.c | 13 +++++++++++--
 net/batman-adv/types.h    |  3 +++
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/tp_meter.c b/net/batman-adv/tp_meter.c
index a4397aa881dd4..ca6c3f6374bc5 100644
--- a/net/batman-adv/tp_meter.c
+++ b/net/batman-adv/tp_meter.c
@@ -8,6 +8,7 @@
 #include "main.h"
 
 #include <linux/atomic.h>
+#include <linux/bug.h>
 #include <linux/build_bug.h>
 #include <linux/byteorder/generic.h>
 #include <linux/cache.h>
@@ -1156,6 +1157,9 @@ static void batadv_tp_receiver_shutdown(struct timer_list *t)
 	spin_unlock_bh(&tp_vars->unacked_lock);
 
 	/* drop reference of timer */
+	if (WARN_ON(atomic_xchg(&tp_vars->receiving, 0) != 1))
+		return;
+
 	batadv_tp_vars_put(tp_vars);
 }
 
@@ -1374,6 +1378,7 @@ batadv_tp_init_recv(struct batadv_priv *bat_priv,
 
 	ether_addr_copy(tp_vars->other_end, icmp->orig);
 	tp_vars->role = BATADV_TP_RECEIVER;
+	atomic_set(&tp_vars->receiving, 1);
 	memcpy(tp_vars->session, icmp->session, sizeof(tp_vars->session));
 	tp_vars->last_recv = BATADV_TP_FIRST_SEQ;
 	tp_vars->bat_priv = bat_priv;
@@ -1546,8 +1551,12 @@ void batadv_tp_stop_all(struct batadv_priv *bat_priv)
 			break;
 		case BATADV_TP_RECEIVER:
 			batadv_tp_list_detach(tp_var);
-			if (timer_shutdown_sync(&tp_var->timer))
-				batadv_tp_vars_put(tp_var);
+			timer_shutdown_sync(&tp_var->timer);
+
+			if (atomic_xchg(&tp_var->receiving, 0) != 1)
+				break;
+
+			batadv_tp_vars_put(tp_var);
 			break;
 		}
 
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index daa06f4211542..b9c0b77791226 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -1323,6 +1323,9 @@ struct batadv_tp_vars {
 	/** @sending: sending binary semaphore: 1 if sending, 0 is not */
 	atomic_t sending;
 
+	/** @receiving: receiving binary semaphore: 1 if receiving, 0 is not */
+	atomic_t receiving;
+
 	/** @reason: reason for a stopped session */
 	enum batadv_tp_meter_reason reason;
 
-- 
2.47.3

