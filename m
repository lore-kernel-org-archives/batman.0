Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B2DACA5FCE
	for <batman@archiver.kernel.org>; Sun,  4 Oct 2026 10:13:27 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 3BF6982241
	for <batman@archiver.kernel.org>; Sun, 04 Oct 2026 12:13:26 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1791108806;
 b=t5v6Y68AiqEkEJcd7DGKtUbGRyeKU0G5TRv587oxk6qCxJMWW86sEuTtMh2NHZodfd6dM
 K4XYMHhgVdak9ut9aoM6ESdo7WzmnfNdM+s9gzC6J9eWWlFrKhEIn/4xO0KstdQ0f5Evcrp
 QVBkzjBT43ShkgQ+2NkfujfTvaTc2io=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1791108806; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=SD8tqvywocxpiMdWwY/MVPCw/BUJ7KXO99ZYpykpboE=;
 b=Wlu/oohQOyC+op5fcsl6nBXv8zAmW4z+AJlfQOSgfKnAcYM1VbVB6d9aYKsFXNWe4Ktyt
 7zCJSA3ZF4rKpnzLryYP8GroY/xKcgd6jtoMz/xiDwnIR7kVzSFBz+KA4gk6EjLUzv8pK6D
 4YvWoDmzNfIXGD/rP16l3PCxZBXZCL0=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id F117C835AB
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 04 Oct 2026 12:09:16 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1791108567;
	b=VORkcIhPJTGZHlzQ6UQzDF8Zo5XjqDRSBrnsQ9iolJumOiFzOXFqe/nXCJoCLMVl1wiJEe
	jAqtp3B/dgmZDoAgXlRzE4WMiUyXSofO72aRNAzUsk47S70CRSwmiqOzJSPMYFUpQze32s
	M3rdzxr9YGLxdFYkMDkW9Rf5KYeLhWg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1791108567;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=SD8tqvywocxpiMdWwY/MVPCw/BUJ7KXO99ZYpykpboE=;
	b=kxgrrApwzpH8ho7b6lHbrZy43tFvWhYOGxccWOf+DKYvou40DBMUzihrT3z8iyQhgGqSEK
	rPwHyHdVlOI3DgdV6oveFMX4XZWFdDVR6csN1SmTFNO8u8LvgpCi5SwqLGSmF+30XlpM+9
	PfemOQ5w+y5wi59G+lIYyRLhDLj8PVg=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b="b/Jxnl9q";
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id A518A2046C;
	Sun, 04 Oct 2026 10:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1791108556;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SD8tqvywocxpiMdWwY/MVPCw/BUJ7KXO99ZYpykpboE=;
	b=b/Jxnl9qpaNVbxqpgAPDZH5vqmKk5la7tZsorOaP6GxB4sSJKougozK/6HnnuDy76OTlKV
	r7Vv/DBul/EbpCyw5dJSWiJzYTuZkx/camXKYcale6WKaGaMbt4SKiWlHmbzAN0lh6vkrw
	y4q1nkQWJzfCP6fkFXQdP4wdXebCFao=
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 04 Oct 2026 12:08:43 +0200
Subject: [PATCH batadv v2 8/9] batman-adv: tpmeter: avoid underflow in
 reported testtime
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261004-dat-last_update-once-v2-8-ab012a4b18ed@narfation.org>
References: <20261004-dat-last_update-once-v2-0-ab012a4b18ed@narfation.org>
In-Reply-To: <20261004-dat-last_update-once-v2-0-ab012a4b18ed@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=841; i=sven@narfation.org;
 h=from:subject:message-id; bh=U7LCgCMeXBDbARMTSGjE3R3Lwq4VGUOn9HMtPSmToHg=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFmHVLfy5fXzxfCInJqUED3N7ffiiU8nhKwub5tn8uvi0
 kV+69/FdZSyMIhxMciKKbLsuZJ/fjP7W/nP0z4ehZnDygQyhIGLUwAmss+VkeFRov42dvd/jnxt
 aw9dVOPjqrj0y/ryJJE1/x42rHhSXBHByLDtWNSm/defLnVpvfrsz6L6f5Wxcz8fXn37iMD65vP
 9M4WZAA==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: PDKEOBPF6R6AGPQVX7MCBOZ6DH3N4FXP
X-Message-ID-Hash: PDKEOBPF6R6AGPQVX7MCBOZ6DH3N4FXP
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/PDKEOBPF6R6AGPQVX7MCBOZ6DH3N4FXP/>
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

