Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C295CD37AF
	for <batman@archiver.kernel.org>; Sun, 10 May 2026 09:37:09 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 9E21585D0D
	for <batman@archiver.kernel.org>; Sun, 10 May 2026 11:37:07 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1778405827;
 b=pDkmee7Vnxzu5IwBWd9qTdqsjEb8q+gnpFF/C6favcR24yMY099GiHbkgRgIwE7vfoSwc
 cdHO+Yhv7yPUU1dwJ/MJ0JcrExGCC3fE013x2Xelsagep5OlaFAielYQKp20FfJ4CC9i2ID
 ZeyuBZVG7Z59WGslm27FGJDPHNc37dE=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1778405827; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=Y45aNJzCtGVotV8xytx1AAqe8yNDYRCbMkRS8jpMCU8=;
 b=a87UCMZWiEBm5cFrBTUfflMugxlRTloLQK7DX+wPp3zprczrGai37VkJyTGJsQESO1Qkv
 ta+MWv68hqrM17g/uocBEL2+IInLQIxmkBbdHo0IzdnUIHrTHo32XvuxxaK5N5QnNWUk/QX
 YlIXM8qm61yYJ3uMydSQX42EsxehSxw=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 43E6C85AD0
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 10 May 2026 11:31:23 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1778405483;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=Y45aNJzCtGVotV8xytx1AAqe8yNDYRCbMkRS8jpMCU8=;
	b=lOzmGqKa4JREutc8RxkBO46yKzsC4Jl+AsMdx9uTiFEswpa9Zz6SGqmY6DKrsgZnYttGcu
	h8fdQfe/yMMe9zkmtVgHpOZQd0x8Ikl9TdFy0LsydfYCsR0+C/GuAgQfv+JxR3HesfhQ0U
	/d0wMjBlulsZG68HzPwG8C0nlgVBAvA=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=KNKWlHI7;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1778405483;
	b=TlykS402jPoQqWLqoWYzvZe5lM9sVJnE7lXR4WCCjlav2cpazklPPWlh0WEcgEIgNS5a8E
	62g8luMtW01dhDPyXkTv3guwPt1VVY2frcjtG0sTyO4XTiO5H7Qm80HRMjqe3YZrgsVkBA
	ZbMZWpxbR3gSWA7zWc3qnYhmjb473Wc=
Received: by dvalin.narfation.org (Postfix) id 049B0201FE;
	Sun, 10 May 2026 09:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1778405483;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y45aNJzCtGVotV8xytx1AAqe8yNDYRCbMkRS8jpMCU8=;
	b=KNKWlHI7+40dg/MRmCujnS2futHtnwDBk7d/Z/bxlxoL0Upc9sbco6Lnq/5mImhv0X8/vn
	RAarBoFcapPHX98S+laeTH66SNisi19UJG5o72FvYdm/xz1RSVTkB7Eg6kuOy9ZjcjFrhu
	knnRmsExam6/ZJTjZhroEq/vgiZCHcM=
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 10 May 2026 11:31:03 +0200
Subject: [PATCH batadv v3 7/7] batman-adv: tp_meter: fix tp_vars reference
 leak in receiver shutdown
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260510-fixes-followup-v3-7-1079a93bc964@narfation.org>
References: <20260510-fixes-followup-v3-0-1079a93bc964@narfation.org>
In-Reply-To: <20260510-fixes-followup-v3-0-1079a93bc964@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3126; i=sven@narfation.org;
 h=from:subject:message-id; bh=AigBjQ6hOlbf/QoDp113zRB8MtaDNQkdvctkhUf56hg=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFkMASE/FFSTOqYfDdXLnHSgnuvTJi0Dj9zZXY+cUuZoL
 LqRNGltRykLgxgXg6yYIsueK/nnN7O/lf887eNRmDmsTCBDGLg4BWAisxcx/M9/tL2RMdN1/g7B
 PR8n9pfuvqQlIDNxTkGXNHfFd6eK/ecY/inudNfetaOHw+pJR8nbSu1v/JN+3T/hfe9xz/O1xVW
 LnnIBAA==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: GAFPJ7SV466XMGZUXZYI55J3RRG5734R
X-Message-ID-Hash: GAFPJ7SV466XMGZUXZYI55J3RRG5734R
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/GAFPJ7SV466XMGZUXZYI55J3RRG5734R/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

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

Fixes: 13f49ae89725 ("batman-adv: stop tp_meter sessions during mesh teardown")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/tp_meter.c | 13 +++++++++++--
 net/batman-adv/types.h    |  3 +++
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/tp_meter.c b/net/batman-adv/tp_meter.c
index 066c7611..f1c11777 100644
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
index 179b90c1..739439e2 100644
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

