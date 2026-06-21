Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44727CD98F2
	for <batman@archiver.kernel.org>; Sun, 21 Jun 2026 14:35:46 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id DBADD845EC
	for <batman@archiver.kernel.org>; Sun, 21 Jun 2026 16:35:44 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1782052544;
 b=YnPvQZHiNuqhQ3OooLU3NOMRa44PY5BDo6+Smm/AtePBMJ6Z79gvjIvo2pqd0Udy/NrZx
 t1ZOAWv8X0NmopDgZrp0aJKxqsieUytK8t3t3lchucVYj5t7GNjJzGNp+creIF99iiMeAFa
 d5fdzg1epJOaf0tiJz93yq0FWULMK9Y=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1782052544; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=yAwoQg23DciWt3DRTJS0gHg8GssqRICLukFPkHY/EZ8=;
 b=FCXKclsirVM4ifKZu02VFYdsUQaiLtckC/9ShZyWfD2qMkp6UQsCfEvoJhtoEGABeac1L
 k2V+2YnLWxaRtE5/y7S4rhfWkRSljEu5Gj5SP6BqfaQWcjtFgiVcdxm6T9p8BFLwYr64dVF
 cWR3nAoCunmTNzfOg+dXH3HfEfdg/pM=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id F23E484047
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 21 Jun 2026 16:25:14 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1782051915;
	b=Y0ORqpQfHKl6E2RtLlG0GnwQU9dTGP0oywwHPU5l7Sdi6LKI1c5/Fxb8pme8tzmMyDcRH+
	UawcNbTVqipSnjCaLPWevSW4kBfMhFgXOntWYveoq6/x/FxfF5y4Ew/mrBauebss/k7dTg
	/RBw7rFTjh2EFeceSozHJk47Z38Anu4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1782051915;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=yAwoQg23DciWt3DRTJS0gHg8GssqRICLukFPkHY/EZ8=;
	b=DWZkxp91elU6229BPgkCanarScoizdI9CJm0qjMWM0ADsK518thUrfJV6m9QqDDDsKYcnk
	1JiLnCWyD7zM0BfvYX//GExBryCWrU6YB97AGjpqX8DB1upnNujVyK9Gxyf3+gqk8lCoF1
	JdOE+lQqNJkxQW3D5YWaYGLgmqGDHQg=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=OGVqoQW9;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 92D2C200C4;
	Sun, 21 Jun 2026 14:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1782051914;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yAwoQg23DciWt3DRTJS0gHg8GssqRICLukFPkHY/EZ8=;
	b=OGVqoQW94tPtt1mBL4I8CCrYv1Qcbx/nC0/MCFQk/K7ZrpheI5n7Eb44+V7BBYz/ib7DLZ
	b4g/ZryJZy0jcn5p+WWLwCXMEfhXfzS2eJR05NGLeqN010ukzajGyIVZwAldlu0zwd1ARA
	FMIN+geSxwyt6KdgzwHjF76A5EwlWY0=
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 21 Jun 2026 16:24:05 +0200
Subject: [PATCH 15/28] batctl: tpmeter: fix Gbps output
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260621-bugfixes-v1-15-b09736288a4a@narfation.org>
References: <20260621-bugfixes-v1-0-b09736288a4a@narfation.org>
In-Reply-To: <20260621-bugfixes-v1-0-b09736288a4a@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1012; i=sven@narfation.org;
 h=from:subject:message-id; bh=lG6m0zu+m/+8MlW3NxvbOoGkrMtsIeQm/N9/GYT7gGo=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFnmX9iOVtUdX3DqVfpsflaNyj1zPKL3Cj/5uOqcvC9nX
 EK8+/yQjlIWBjEuBlkxRZY9V/LPb2Z/K/952sejMHNYmUCGMHBxCsBE9ocx/JW5axjHUt1gtnHa
 UbdIUxHGdRd93zfXOH+VV8qYwyggnMrIsDfo5tn8hr4Tt2fsffn/kHU9W3+UU2BJb8I51efzNfZ
 fZQcA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: CMDMMASNIKYP5V42L3XDK56J4IQKAKEJ
X-Message-ID-Hash: CMDMMASNIKYP5V42L3XDK56J4IQKAKEJ
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/CMDMMASNIKYP5V42L3XDK56J4IQKAKEJ/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

The formatter for the Gbps result should print 2 digits after the dot. But
the format specifier was different than in all other branches and didn't
specify the precision after the dot. Instead a minimal number of digits (or
spaces) before the dot was defined.

Fixes: f109b3473f86 ("batctl: introduce throughput meter support")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 throughputmeter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/throughputmeter.c b/throughputmeter.c
index d670c51..a45eb08 100644
--- a/throughputmeter.c
+++ b/throughputmeter.c
@@ -431,7 +431,7 @@ static int throughputmeter(struct state *state, int argc, char **argv)
 		if (throughput == UINT64_MAX)
 			printf("inf\n");
 		else if (throughput > (1UL << 30))
-			printf("%.2f GB/s (%2.f Gbps)\n",
+			printf("%.2f GB/s (%.2f Gbps)\n",
 			       (float)throughput / (1 << 30),
 			       (float)throughput * 8 / 1000000000);
 		else if (throughput > (1UL << 20))

-- 
2.47.3

