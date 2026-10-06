Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F0EFCA5FED
	for <batman@archiver.kernel.org>; Tue,  6 Oct 2026 16:52:58 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 3355B83C2A
	for <batman@archiver.kernel.org>; Tue, 06 Oct 2026 18:52:57 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1791305577;
 b=WAwNYn2EKlOlFK+5aL2kXeMWB9ASisETtNIY/KruC7HBHOncpj38dvOLiKJhxvay7TeDJ
 pfhtgxAGzgGIwrVBmYycfHYtm+wiEQLVaIIyCXezCbnU2Qg7yiGzTo2vEDP7YAeCNRmFkQx
 Z+5Tixu7U8vMMYsfuCjr7Y911yog2gY=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1791305577; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=ls/WoSxzPA6uAbWm76rznxXVXDqIWint9oY79/K8Uxk=;
 b=NtNjuYy3OBVfQkz6PCQ6gz566UjuesdPcHN7qMFaX6+OaDB8Yxbez9cwNs00BzdvK7x3y
 P0E0wS7Fs/rfD1Aoc9Qwn4mNiyBKAirUIbxXmBi8hSdFT1981USIOdRO2LvzUz98h9k+EIl
 7vye6CgPf9aqmFC6qYq6cZ9wnzz0PNI=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 59A898425B
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 06 Oct 2026 18:48:49 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1791305329;
	b=xI0E3DcvQwoCuznxfoW6ED6/OOXQhDpWJFV7eXna5jeWX1+btDwwtLQdgSe1a4AWjhzZnq
	BxsO3lTMc3gfD8bff2hwRXBZja5YfMBWTx4eGms+Jl9Xrf2EO2WVZX0Evcj6h/fVktOG1i
	Rj3tZYOR/BSPMXNkf017KpngTkRhhoM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1791305329;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=ls/WoSxzPA6uAbWm76rznxXVXDqIWint9oY79/K8Uxk=;
	b=c/8NroTaHoRpiqvXEIQsC08scZN4Wpf3lc7Lw1QWR+YH9lkhXIdqNobsOewxMbapWPQj3x
	7GPkFdIyma5mozJ1wJP4SoZO1q2uqS/z+Il7am0CjkRmxnQw3/KmLmAGa4erHnQhNWgC7E
	NofIqeWD1CNcpaK3s7pTulq+g/xGCUQ=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=gHukrrAF;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 18FCF1FE24;
	Tue, 06 Oct 2026 16:48:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1791305329;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ls/WoSxzPA6uAbWm76rznxXVXDqIWint9oY79/K8Uxk=;
	b=gHukrrAFTaZmD5nuvkH6FJ6C1x80ujStVoehkEWgwyyUuzFzGSvFmgKMorbn0JqoSIny3k
	0LaYgIVoEU2OP4RVkau/9tBuA6OYSHnEtJRADcQipTWn7W1D1eUbAyee3FhwxtGaQxKobW
	EkfcWGAPIDKeFsuf19xDppRYpRz/6rw=
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 06 Oct 2026 18:47:11 +0200
Subject: [PATCH batadv v3 9/9] batman-adv: tpmeter: avoid underflow in rtt
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261006-dat-last_update-once-v3-9-316aefdd5f5f@narfation.org>
References: <20261006-dat-last_update-once-v3-0-316aefdd5f5f@narfation.org>
In-Reply-To: <20261006-dat-last_update-once-v3-0-316aefdd5f5f@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=861; i=sven@narfation.org;
 h=from:subject:message-id; bh=jhklif6OJDYCAzila98PUZQA9QDgkAjj9NO1HoDm7Sk=;
 b=kA0DAAoWTQ93K9MU9csByyZiAGrFJguglmeAuBPp5HgmwxiLnYcYkSAHE2jIo1tnOljPkv0tz
 oh1BAAWCgAdFiEEvNRvz7MH7R/zlvHFTQ93K9MU9csFAmrFJgsACgkQTQ93K9MU9csdYAD+MoR+
 DzZeTWeHHOvU6mgiQ68kU+F4YADIPBitE0JmXewA/RpjD8oUXMxRTdTCpcXHX0QVrm6SuSYRuuT
 3nzq+WBUO
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: Q3XOTDZOLKYIHQBQ7NFYOG34GP2N4YB4
X-Message-ID-Hash: Q3XOTDZOLKYIHQBQ7NFYOG34GP2N4YB4
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/Q3XOTDZOLKYIHQBQ7NFYOG34GP2N4YB4/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

To avoid an underflow due to an non-strict order read of jffies vs
timestamp, use jiffies_delta_to_msecs instead of jiffies_to_msecs to
evaluate the delta.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/tp_meter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/tp_meter.c b/net/batman-adv/tp_meter.c
index 7d4d84ad..3fdc7f67 100644
--- a/net/batman-adv/tp_meter.c
+++ b/net/batman-adv/tp_meter.c
@@ -822,7 +822,7 @@ static void batadv_tp_recv_ack(struct batadv_priv *bat_priv,
 
 	spin_lock_bh(&tp_vars->cc_lock);
 	/* update RTO with the new sampled RTT, if any */
-	rtt = jiffies_to_msecs(jiffies) - ntohl(icmp->timestamp);
+	rtt = jiffies_delta_to_msecs(jiffies) - ntohl(icmp->timestamp);
 	if (icmp->timestamp && rtt)
 		batadv_tp_update_rto(tp_vars, rtt);
 

-- 
2.47.3

