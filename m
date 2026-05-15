Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6983CD343F
	for <batman@archiver.kernel.org>; Fri, 15 May 2026 10:01:43 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 454CA85DE0
	for <batman@archiver.kernel.org>; Fri, 15 May 2026 12:01:42 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1778839302;
 b=RXtMMu08yszR01EjGIjbaQoRs3gAWijF4pKTKbVh+0JQtcWgz5c99haE/Y11xgO4gozFA
 JuWlg9MY1JTLm2vgi7tawMTDqyBOeEQmfqVeSvnaojSxwMs5FhRlhbK+8fxOMxEEn7/5+7W
 UPQFU+o7q0PkBr0NyOEh83Y3601P0hE=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1778839302; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=mcS91IanzxL76e2zz0k5ZxQVn0ZNe3ObWJGVremRY+o=;
 b=0xBss0hUBkL/ruoF9khxF1PA8YgO/eEROOeYbjh6NiaQ1KdKF7d9/f3cAVDvDDsQ00h6I
 8BCIneb/PSUriYdGBnxnqk449INpnKfmNy/8kQhg1FnaQ71FHTXvPH9CPhewr4ul61qRQWm
 vWxw8sOVJPKEjSAT8CFtyjyyje7SUKE=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de
 [IPv6:2a01:4f8:c17:e8c0::1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 39E6281FDC
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 15 May 2026 11:55:49 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1778838954;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=mcS91IanzxL76e2zz0k5ZxQVn0ZNe3ObWJGVremRY+o=;
	b=N9/9MX6EhWak90X81qYCce91tBty/sm3LE4sfR9TR20Dd/Jvg5NtYuTTeaY5KD1qronWAH
	R/ZZrG4I4suv6Md/1ays37UfPythIzaYUdSMhFWUWaK9fNkwl5rk6xKplas6sG85ouCWbR
	y9cuj7BT5WNCtlxXMETGQuA3AaWjHDI=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=1oyXdCIh;
	dmarc=pass (policy=none) header.from=simonwunderlich.de;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 2a01:4f8:c17:e8c0::1 as permitted sender) smtp.mailfrom=sw@simonwunderlich.de
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1778838954;
	b=GXr8Q5+TgAE40ZzV++n2c/sbS60f5QIKKxsbecBBd6uGGdoV5wymHIYV21QfQak5ZCIeyP
	2DguSzMoXWg3nAXX3LeTyHUeHzKHp3Db5U3r01L18cCvHH1wWj//r2PDY792f+rQVH4gcY
	MFC2UFtuTFFsgoU4kLQvV/KFciOYqmI=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1778838947;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mcS91IanzxL76e2zz0k5ZxQVn0ZNe3ObWJGVremRY+o=;
	b=1oyXdCIhRmQi168h+T+5pDZ083RAdgAW43w3XyfFexdlnHUyYYMaBzlYp9NHr8vQscqYXn
	otvj1ib+xDOq5i+6TRiCa8OJXlvqIAe5IOG3nzwaH5zpaMly27WgSIKInv8pFw21wLiAlo
	PInb0ae9qZEr7nEl/7RMnLL5vywkqeoYv6wT8vpWJ0e5e+AcrKYVl7uI341emWz9PZn++u
	C+UrBHKEk0K5kGf3LMvhgBhsKsterqlsDusgvp0Rn6meisV3z9o0HIYaiHJttBGrnP9h1H
	NBOeSDR3CW9QVrUtDf2YSlwOACefjz2BIxZC5hGYVjSyeg4LXs3vE/s9YqO8Cw==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Luxiao Xu <rakukuip@gmail.com>,
	stable@kernel.org,
	Yuan Tan <yuantan098@gmail.com>,
	Yifan Wu <yifanwucs@gmail.com>,
	Juefei Pu <tomapufckgml@gmail.com>,
	Xin Liu <bird@lzu.edu.cn>,
	Ren Wei <n05ec@lzu.edu.cn>,
	Sven Eckelmann <sven@narfation.org>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net 01/14] batman-adv: fix tp_meter counter underflow during
 shutdown
Date: Fri, 15 May 2026 11:55:26 +0200
Message-ID: <20260515095540.325586-2-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260515095540.325586-1-sw@simonwunderlich.de>
References: <20260515095540.325586-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: ROWXFW2AGSUTTV5OSITCI46NRGFJQI4M
X-Message-ID-Hash: ROWXFW2AGSUTTV5OSITCI46NRGFJQI4M
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/ROWXFW2AGSUTTV5OSITCI46NRGFJQI4M/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Luxiao Xu <rakukuip@gmail.com>

batadv_tp_sender_shutdown() unconditionally decrements the "sending"
atomic counter. If multiple paths (e.g. timeout, user cancel, and
normal finish) call this function, the counter can underflow to -1.

Since the sender logic treats any non-zero value as "still sending",
a negative value causes the sender kthread to loop indefinitely.
This leads to a use-after-free when the interface is removed while
the zombie thread is still active.

Fix this by using atomic_xchg() to ensure the counter only transitions
from 1 to 0 once.

Fixes: 33a3bb4a3345 ("batman-adv: throughput meter implementation")
Cc: stable@kernel.org
Reported-by: Yuan Tan <yuantan098@gmail.com>
Reported-by: Yifan Wu <yifanwucs@gmail.com>
Reported-by: Juefei Pu <tomapufckgml@gmail.com>
Reported-by: Xin Liu <bird@lzu.edu.cn>
Signed-off-by: Luxiao Xu <rakukuip@gmail.com>
Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
[sven: added missing change in batadv_tp_send]
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/tp_meter.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/tp_meter.c b/net/batman-adv/tp_meter.c
index 066c76113fc43..a4397aa881dd4 100644
--- a/net/batman-adv/tp_meter.c
+++ b/net/batman-adv/tp_meter.c
@@ -451,7 +451,7 @@ static void batadv_tp_sender_end(struct batadv_priv *bat_priv,
 static void batadv_tp_sender_shutdown(struct batadv_tp_vars *tp_vars,
 				      enum batadv_tp_meter_reason reason)
 {
-	if (!atomic_dec_and_test(&tp_vars->sending))
+	if (atomic_xchg(&tp_vars->sending, 0) != 1)
 		return;
 
 	tp_vars->reason = reason;
@@ -885,7 +885,7 @@ static int batadv_tp_send(void *arg)
 				   "Meter: %s() cannot send packets (%d)\n",
 				   __func__, err);
 			/* ensure nobody else tries to stop the thread now */
-			if (atomic_dec_and_test(&tp_vars->sending))
+			if (atomic_xchg(&tp_vars->sending, 0) == 1)
 				tp_vars->reason = err;
 			break;
 		}
-- 
2.47.3

