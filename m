Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6400FCD3436
	for <batman-adv@archiver.kernel.org>; Fri,  8 May 2026 15:44:27 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id E454285BBE
	for <batman-adv@archiver.kernel.org>; Fri, 08 May 2026 17:44:25 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1778255065;
 b=aqjCtg1NTktEcZCjwt/epbOcoiQcf80CCu8rqiA09s4Ahz3h57TGU09kywWoe/RYRegS3
 TXa1KH2so3aMP4yc8oyIKaarKmPNZT+g2gd3M7t8l593xZACUl+PfARPblhmdTrSfP5HeAq
 atWpHYOIYDzkqLSLZ+LE1votOQLtA1A=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1778255065; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=KIfU73idM0J1qzjECasosBqZBJk4pqnhj27Zo4ddO7U=;
 b=3FGpqgphs6PhNbrCT2HcMmivaDAnZUG4f+M+T3U4EpyKTzV+yeNpPlsW7OZGSm2KZWldu
 6od/I0jHptu3PqzSPCyCNOAnkYixpPyyyIRRhx/qKbbW4WLLMAPsVil6VE6m1wCTBgB0+3t
 aAkH+jgT1rvrziROiAq9ICPDxI42Ueg=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 037FE85471
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 08 May 2026 17:43:33 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1778255013;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=KIfU73idM0J1qzjECasosBqZBJk4pqnhj27Zo4ddO7U=;
	b=3zQoG2aO2qN8s3MR2aIcneI+Nrm9WNsP+rDW5BEbUy5Pu68doXn0na5otIDrDsu6AOVcdy
	6kDMb61XtoDehMHYDzfbfJC8W4+YgyzwIFM+cRdF77KSWpfueHbWCrtfqLvjDbT/ocSmUH
	mEYpQpuZX3YIFdUAFZJLpTmGRvdgJ2U=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=G+0CeM6p;
	dmarc=pass (policy=none) header.from=simonwunderlich.de;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 23.88.38.48 as permitted sender) smtp.mailfrom=sw@simonwunderlich.de
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1778255013;
	b=IP8Vxqs0QITQayCctwkxHd4XwuO6nOLeLLidVOXxKBn8GwXu5VgVN8rxkyyvT94QdaMdIj
	b6QLaMAnnZugd+PXzjiJ9mAg2c5W73laVIV7837IXtysPKYldo1K+UxUEvH0YzGOrv6JJI
	VDWy2XDB8jDX9vzL6+Rh+jpS6N7/xHo=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1778255011;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KIfU73idM0J1qzjECasosBqZBJk4pqnhj27Zo4ddO7U=;
	b=G+0CeM6plJnRHWOvUcmV4tCJpiTCzBilPRDg+jYUcTLI8svm4r88XQ1nd43WAmgMZo9TWc
	WReTRlx7SKD8fvnT0RTbJpiHkvQkyg3HuaUkuw3XDrspSMUNZFbqtgJ0L0PykFlzeWf16W
	QK2HJh0/JlsS3QsnsyljINvLBnQ3Se13MPz4HrYCb6JBrwq9NsET1koXulmhcYFtYteo6s
	YKK0O40DVDskc6N0Fo9ZguC2cj/lNHiHR5bdyZnfNMS50qsuGHn/7Fp33c66EYB7C9DIjh
	WV29BVMuiTXwJO0zJLbzA/flmnwBgkpAf7qQx+PQiqc+hoy0VVEiyFYc2KkEdA==
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
Subject: [PATCH net 5/8] batman-adv: tp_meter: fix tp_num leak on kmalloc
 failure
Date: Fri,  8 May 2026 17:43:11 +0200
Message-ID: <20260508154314.12817-6-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260508154314.12817-1-sw@simonwunderlich.de>
References: <20260508154314.12817-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: QPM4GT4DDGUMIB3COB4GTOBK2M57SU6P
X-Message-ID-Hash: QPM4GT4DDGUMIB3COB4GTOBK2M57SU6P
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/QPM4GT4DDGUMIB3COB4GTOBK2M57SU6P/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Sven Eckelmann <sven@narfation.org>

When batadv_tp_start() or batadv_tp_init_recv() fail to allocate a new
tp_vars object, the previously incremented bat_priv->tp_num counter is
never decremented. This causes tp_num to drift upward on each allocation
failure. Since only BATADV_TP_MAX_NUM sessions can be started and the count
is never reduced for these failed allocations, it causes to an exhaustion
of throughput meter sessions. In worst case, no new throughput meter
session can be started until the mesh interface is removed.

The error handling must decrement tp_num releasing the lock and aborting
the creation of an throughput meter session

Cc: stable@kernel.org
Fixes: 33a3bb4a3345 ("batman-adv: throughput meter implementation")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/tp_meter.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/batman-adv/tp_meter.c b/net/batman-adv/tp_meter.c
index 58ca59a2799ed..066c76113fc43 100644
--- a/net/batman-adv/tp_meter.c
+++ b/net/batman-adv/tp_meter.c
@@ -994,6 +994,7 @@ void batadv_tp_start(struct batadv_priv *bat_priv, const u8 *dst,
 
 	tp_vars = kmalloc_obj(*tp_vars, GFP_ATOMIC);
 	if (!tp_vars) {
+		atomic_dec(&bat_priv->tp_num);
 		spin_unlock_bh(&bat_priv->tp_list_lock);
 		batadv_dbg(BATADV_DBG_TP_METER, bat_priv,
 			   "Meter: %s cannot allocate list elements\n",
@@ -1366,8 +1367,10 @@ batadv_tp_init_recv(struct batadv_priv *bat_priv,
 	}
 
 	tp_vars = kmalloc_obj(*tp_vars, GFP_ATOMIC);
-	if (!tp_vars)
+	if (!tp_vars) {
+		atomic_dec(&bat_priv->tp_num);
 		goto out_unlock;
+	}
 
 	ether_addr_copy(tp_vars->other_end, icmp->orig);
 	tp_vars->role = BATADV_TP_RECEIVER;
-- 
2.47.3

