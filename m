Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F9FACD4851
	for <batman@archiver.kernel.org>; Fri, 15 May 2026 10:07:12 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 1057E85E22
	for <batman@archiver.kernel.org>; Fri, 15 May 2026 12:07:11 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1778839631;
 b=1Uy7nbtpCt7RbMEHn1RGKg9mQ5RIoUHTaHZ0wxX+HtElic+4msI5fT2lMXrUUyoV4ORs4
 fXiwBbrD6W0DazrovC+0kimbCd1SjHIBluzYf7mKh5hCjpc4wAdddrtjXv26a9ZwO95DTtP
 D2Ueu7DVNWb1Eu+7LxPKJ6lyCkYwQKY=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1778839631; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=pzeglsvftGQq2owmysdqGGIsVR2TLwY6CvuHqBqKR4I=;
 b=LsFEvpB6c39Qeav1ktQToajTqTobJeLJXsGuVWyCWJuNs+4GEFStyyJVMG/esJ63wPUJe
 WGiKyzGs6S/7YWRIeofD7hivSClib06O7l8j1xkDOs7d/3HDME5rdO/CeWmNGqBELd+7fLW
 CiEf+EYYf0Fx/4lHGQS83jfO1lBX6TQ=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 5585E85477
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 15 May 2026 11:55:59 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1778838959;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=pzeglsvftGQq2owmysdqGGIsVR2TLwY6CvuHqBqKR4I=;
	b=xmo55b2Hvjx1aFwazWbHB+5t/hHVdcb6CUB6kXU0QKdK9T1/gDVvfkf/HjDgBfDXJb/PDQ
	L/exXOb+NbQ41Q8nFjFc0EFJqdeygisJx4nJu3nFQqhHrf3b455KxysbiS37H2jAdn1cOX
	i6FaM7Adz6We+mYV+mck3jhkfSLfwmY=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=0ya06e57;
	dmarc=pass (policy=none) header.from=simonwunderlich.de;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 23.88.38.48 as permitted sender) smtp.mailfrom=sw@simonwunderlich.de
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1778838959;
	b=o9KqgYOTvsuaWZIbMew9QVLpiM/SJQD8zk9QZQZ5VStbFWzO7iOzAC8m0Y/3hNw6pARi69
	QmgV/rLnvajgtrEI3hx/vtdDInWY/ZWx3/0ZTWeYDw4SB5IlZ91HhLRek+waGJ3rIJpGCr
	dzLMlmQYTJf5D+V0BoThg14NOBzrVtM=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1778838958;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pzeglsvftGQq2owmysdqGGIsVR2TLwY6CvuHqBqKR4I=;
	b=0ya06e57/A7JDgPf04FnAYYR7CDbk/VtV2JfA7EO35HyddZ1cZ2HGzHwyqk+ISWSietKah
	QlK1xe38dXH+5ulPbVzGkZW2AntNg6YxiAYw6Creye08lPp1O92uyL7rjVnuIo8NJ5xi1J
	IzxSnC4VJtuGIXwsygPnaf3XRlpn+B5Qo6P47qwsusg2bcP5cGfNGkr+vxQZBI93t2H1Ma
	+uHpLovM6iUm6TCpPSUIv85DB5QRsONeSyRR3tJmN2ukhOtGaWCL+Fq0VXwwguoeQoRLkN
	cd47s8mgFTP6TM8QYCxyoc8kqczVJdjiyUFUQX41PdJS2gvsLSaypJGSmPT0Yw==
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
Subject: [PATCH net 14/14] batman-adv: tp_meter: directly shut down timer on
 cleanup
Date: Fri, 15 May 2026 11:55:39 +0200
Message-ID: <20260515095540.325586-15-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260515095540.325586-1-sw@simonwunderlich.de>
References: <20260515095540.325586-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: HSFZIAVSZBIMRMZUZ57YGNNAFW4HYHJC
X-Message-ID-Hash: HSFZIAVSZBIMRMZUZ57YGNNAFW4HYHJC
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/HSFZIAVSZBIMRMZUZ57YGNNAFW4HYHJC/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Sven Eckelmann <sven@narfation.org>

batadv_tp_sender_cleanup() was calling timer_delete_sync() followed by
timer_delete() to guard against the timer handler re-arming itself between
the two calls. This double-deletion hack relied on the sending status being
set to 0 to suppress re-arming.

Replace both calls with a single timer_shutdown_sync(). This function both
waits for any running timer callback to complete (like timer_delete_sync())
and permanently disarms the timer so it cannot be re-armed afterwards,
making re-arming prevention unconditional and self-documenting.

The re-arming property is also required because otherwise:

1. context 0 (batadv_tp_recv_ack()) checks in
   batadv_tp_reset_sender_timer() if sending is still 1 -> it is
2. context 1 changes in batadv_tp_sender_shutdown() sending to 0 and in
   this process forces the kthread to stop timer in
   batadv_tp_sender_cleanup()
3. context 0 continues in batadv_tp_reset_sender_timer() and rearms the
   timer -> but the reference for it is already gone

Cc: stable@kernel.org
Fixes: 33a3bb4a3345 ("batman-adv: throughput meter implementation")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/tp_meter.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/net/batman-adv/tp_meter.c b/net/batman-adv/tp_meter.c
index a3593d104caa5..1fd1526059d8a 100644
--- a/net/batman-adv/tp_meter.c
+++ b/net/batman-adv/tp_meter.c
@@ -401,13 +401,7 @@ static void batadv_tp_sender_cleanup(struct batadv_tp_vars *tp_vars)
 	batadv_tp_list_detach(tp_vars);
 
 	/* kill the timer and remove its reference */
-	timer_delete_sync(&tp_vars->timer);
-	/* the worker might have rearmed itself therefore we kill it again. Note
-	 * that if the worker should run again before invoking the following
-	 * timer_delete(), it would not re-arm itself once again because the status
-	 * is OFF now
-	 */
-	timer_delete(&tp_vars->timer);
+	timer_shutdown_sync(&tp_vars->timer);
 	batadv_tp_vars_put(tp_vars);
 }
 
-- 
2.47.3

