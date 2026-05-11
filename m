Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAD01CD4840
	for <batman@archiver.kernel.org>; Mon, 11 May 2026 16:52:51 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id F30F885ADB
	for <batman@archiver.kernel.org>; Mon, 11 May 2026 18:52:49 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1778518369;
 b=VJ8DwRCoUX3fD/eYjya44OAbpfVsG5+1HJmgI4I31pS/zC5lTs8JiGj+d+IhtMbCymGZ6
 tD2FIlThkOAM5I6YAWOh4EvIToE2BS85rcYihtxMGRhRQSKxlaPd0cwEzu4NPqFxCe10tFb
 fXKKS6f8ihxbyLntpWDGlKGgqkFosN8=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1778518369; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=UBN8/Zrxnrqa3VNCuWvDo1hiZHZ6LPzGLJD4oW8Mu/g=;
 b=YNTjH2EtrHyefFVoR2svqzy+20mkXS7Wc2HJuIsVE9WHkCAhRB22/twyHrVAxnWHRKfG3
 DeP4X4hO6wyKZBB1t+X083NpZcNmRv9O4MbLx6SbqtlNbo8j03I7ul13jEVD9XV6mm/idfL
 CkHnyUsLp98MAW3fAWxhLe51hdLkVdI=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id A7D6385297
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 11 May 2026 18:52:25 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1778518345;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=UBN8/Zrxnrqa3VNCuWvDo1hiZHZ6LPzGLJD4oW8Mu/g=;
	b=HGoVnDXBs1OBUXCDat09uSkpI8hL/4pKWDBjxbvKcXlqyhm4vdk7kHRsv1+zzhVJeVsCVC
	nhbUpj0EeLxDJwqfYayqQU8dYWMDBwBHf6yaZEwNtIfTq/SOZUFoq35ewTeSbKmebMTQnP
	pJnhtj4dwPmWJ6Gavfk7sY4Ap7lZn3U=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=j9Vkzxj0;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1778518345;
	b=flgc06XYPq+4efl4VlQ8YYy1IIx8ajO7a/PsS/+ePApNS62VtdROP3BfxXSclwuFOeUFeg
	rNR/vI6X2kiOb4Jvo12acgfGZFZpfezSeu72vMsC0L/iZvr4krwKj5oBV7hTuuTIk/MXKq
	p9BaWjyrih+jnX7YQKXeCwXMuQUWHwo=
Received: by dvalin.narfation.org (Postfix) id 366141FFD9;
	Mon, 11 May 2026 16:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1778518344;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=UBN8/Zrxnrqa3VNCuWvDo1hiZHZ6LPzGLJD4oW8Mu/g=;
	b=j9Vkzxj0y0SNDkIJlWlns3YOpIoPjVHQY4yJLP9N2B3vYwPCsQPCswXvMZCFqg0zBVf7FF
	AtIgJxbOgRKFyBMwqBdTSuV3zfzA/hdsmfGuH/WvY0FKUQufh74Yv/b59yn7tmKCoHDrVE
	+sl2/GlO7OvIeme+f5cT47RaFYsMJGs=
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 11 May 2026 18:52:09 +0200
Subject: [PATCH batadv v2] batman-adv: fix tp_meter counter underflow
 during shutdown
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: 
 <20260511-tp-sending-underflow-atomic-v2-1-894f7f45d3ca@narfation.org>
X-B4-Tracking: v=1; b=H4sIADkJAmoC/yWNy27DIBBFfyViXSzAD6ZZ9T+qLAYYnGlisAAnl
 aL8e510eY6uzn2ISoWpiuPhIQrduHJOO5iPg/BnTDNJDjsLo8ykRq1lW2WlFDjNckuBSrzmu8S
 WF/Zy7GHQaoToQxR7YS0U+fdd/xYOG4abOP37urkf8u2Vfi1jyYts50L4fgvR9jQp6wIqD4MzJ
 kxDABUBPYDVn8oMxmHstLWgNfSq72ZuXcHLdtl4/ZoX5Gvn8yKezz+p8+g25AAAAA==
X-Change-ID: 20260511-tp-sending-underflow-atomic-53841058fcdf
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Luxiao Xu <rakukuip@gmail.com>, stable@kernel.org,
 Yuan Tan <yuantan098@gmail.com>, Yifan Wu <yifanwucs@gmail.com>,
 Juefei Pu <tomapufckgml@gmail.com>, Xin Liu <bird@lzu.edu.cn>,
 Ren Wei <n05ec@lzu.edu.cn>, Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2348; i=sven@narfation.org;
 h=from:subject:message-id; bh=4oeboH3tKQ9wedwGjaUHwrTkgrMKytxz3IaQa969W3g=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFlMnK7lgaKNhdxXn66xkfv8pObWn4/TdU9NPTa7YtaE8
 OqHtz9IdJSyMIhxMciKKbLsuZJ/fjP7W/nP0z4ehZnDygQyhIGLUwAmMtOQ4Q/Xx2VvnI8vSZj+
 MHwaR1xTaLKarXHxtapFH8ICbbpFDzEy/DNJ3KPz3OF9+RzJlSEmHPVlZeu5WCSVmDUcz62r0TZ
 KZAYA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: 3ZNVXTQZ37WTRKUVIE5A57WVTCMKKWCU
X-Message-ID-Hash: 3ZNVXTQZ37WTRKUVIE5A57WVTCMKKWCU
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/3ZNVXTQZ37WTRKUVIE5A57WVTCMKKWCU/>
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
---
Changes in v2:
- added missing atomic_dec_and_test -> atomic_xchg change in batadv_tp_send
- Link to v1: https://patch.msgid.link/df73e607bda0c84b22d64d80f8ac887190242baf.1778118303.git.rakukuip@gmail.com
---
 net/batman-adv/tp_meter.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/tp_meter.c b/net/batman-adv/tp_meter.c
index 759ae923..ed9f7e98 100644
--- a/net/batman-adv/tp_meter.c
+++ b/net/batman-adv/tp_meter.c
@@ -452,7 +452,7 @@ static void batadv_tp_sender_end(struct batadv_priv *bat_priv,
 static void batadv_tp_sender_shutdown(struct batadv_tp_vars *tp_vars,
 				      enum batadv_tp_meter_reason reason)
 {
-	if (!atomic_dec_and_test(&tp_vars->sending))
+	if (atomic_xchg(&tp_vars->sending, 0) != 1)
 		return;
 
 	tp_vars->reason = reason;
@@ -886,7 +886,7 @@ static int batadv_tp_send(void *arg)
 				   "Meter: %s() cannot send packets (%d)\n",
 				   __func__, err);
 			/* ensure nobody else tries to stop the thread now */
-			if (atomic_dec_and_test(&tp_vars->sending))
+			if (atomic_xchg(&tp_vars->sending, 0) == 1)
 				tp_vars->reason = err;
 			break;
 		}

---
base-commit: f876964b732393119a036ff1ce7a1c94290b09ed
change-id: 20260511-tp-sending-underflow-atomic-53841058fcdf

Best regards,
--  
Sven Eckelmann <sven@narfation.org>

