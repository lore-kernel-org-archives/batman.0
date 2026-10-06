Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D96A9CA5FED
	for <batman@archiver.kernel.org>; Tue,  6 Oct 2026 16:52:22 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 7454E84430
	for <batman@archiver.kernel.org>; Tue, 06 Oct 2026 18:52:21 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1791305541;
 b=y0ydl4P9xVOUplfu2bDUImpJECLVdRlm+IheKrNNNKYBLD+hZMi0DL1vjUNqgwcggqPzo
 zJcnjeacPnE3NPQXqSY+n+7Ox5zqtS+AHBeG3XjUNMvTDotwxvZKhje+wvz7f2TNxXRz9gp
 soN8cVpZvEcuPPx5YWB5fqkxHSnUWvI=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1791305541; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=SD8tqvywocxpiMdWwY/MVPCw/BUJ7KXO99ZYpykpboE=;
 b=OPYCJ4170JfuHenyUOqt0Ynil2mVv7cY7zmZ1mbNLTnPcRbhbZEO8yrGNEPMo5V1dQKdC
 ppJ9YhyJX8epzV+kC+PU0CBP8XNpZdySsZ8Us0LPWRnTv8QhYEHxzfBllwTOwPIEytVLeFI
 DUR/qPJAxZALBerREDYqkVjeYpiOb68=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 665D58425B
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 06 Oct 2026 18:48:47 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1791305327;
	b=kpTaaU68/27MlKP+duAN3bXrHPqv/f8oH+dIsUE0V7gIgj1L2kz6MRTfOV5Q0ymM4x4eTj
	R08nTqqTLZr6f0h6VntkmgUQTwp/jF6l0xyVZD+H6nYpPcb5dxT5sTkPjzmxblzrC5Dbb4
	06+gjzoSWpzC0pDw+kS709jFR1rl0So=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1791305327;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=SD8tqvywocxpiMdWwY/MVPCw/BUJ7KXO99ZYpykpboE=;
	b=iHJR2iRKviRUig3DXjiIKbWEL/X+uWGuizYHtKR+9zxwZI2pR0lkEFluuKQnHN5xq4426N
	YinmXV7mdQFppCWHcYLm8f2xEu0Y5EzpuU/qDV2srG6JkvkmTmytlPCQN24t8eoeOkY5y4
	nVQJUJ5MBhTWAOzP433qK533/2QNxb0=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=NOB9lAGP;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 052481FE24;
	Tue, 06 Oct 2026 16:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1791305327;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SD8tqvywocxpiMdWwY/MVPCw/BUJ7KXO99ZYpykpboE=;
	b=NOB9lAGPn/ru8JhGcg8epjKT8TgUpolTbPIysPakcoEtaR1ZctmFwxCXDDEL456K++zU/X
	aID8ywWNeNiFy/bGiGnl3J8tTJ/HvJPKmzgTD+brS/9yVheqEYp6BAma1uUwybiOC/bhl8
	zyUwrY3ecdKgfvBGspMYTDhzMZGv7wM=
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 06 Oct 2026 18:47:10 +0200
Subject: [PATCH batadv v3 8/9] batman-adv: tpmeter: avoid underflow in
 reported testtime
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261006-dat-last_update-once-v3-8-316aefdd5f5f@narfation.org>
References: <20261006-dat-last_update-once-v3-0-316aefdd5f5f@narfation.org>
In-Reply-To: <20261006-dat-last_update-once-v3-0-316aefdd5f5f@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=841; i=sven@narfation.org;
 h=from:subject:message-id; bh=U7LCgCMeXBDbARMTSGjE3R3Lwq4VGUOn9HMtPSmToHg=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFlH1bhnb14Z6C327LHNb491VbuNe91XJgjMKinSeXldL
 0eua0JLRykLgxgXg6yYIsueK/nnN7O/lf887eNRmDmsTCBDGLg4BWAiomUM/7NeLHN25f0bZti7
 k3XNFo+Ecy/Oc2qVGzuqTIyQ+CQmJ8fI0PuQq9Mu6fud6H0iX0oEA65uyhWfGB/ze1vQ3xslf+M
 vcAIA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: 4HKRSS433DICTXWZOWCC6G7OYDIVWFAG
X-Message-ID-Hash: 4HKRSS433DICTXWZOWCC6G7OYDIVWFAG
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/4HKRSS433DICTXWZOWCC6G7OYDIVWFAG/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

To avoid an underflow due to an non-strict order read of jffies vs
start_time, use jiffies_delta_to_msecs instead of jiffies_to_msecs to
evaluate the delta.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/tp_meter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/tp_meter.c b/net/batman-adv/tp_meter.c
index 022eb13e..7d4d84ad 100644
--- a/net/batman-adv/tp_meter.c
+++ b/net/batman-adv/tp_meter.c
@@ -227,7 +227,7 @@ static void batadv_tp_batctl_notify(enum batadv_tp_meter_reason reason,
 
 	if (!batadv_tp_is_error(reason)) {
 		result = BATADV_TP_REASON_COMPLETE;
-		test_time = jiffies_to_msecs(jiffies - start_time);
+		test_time = jiffies_delta_to_msecs(jiffies - start_time);
 		total_bytes = total_sent;
 	} else {
 		result = reason;

-- 
2.47.3

