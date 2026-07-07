Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FE3DC43602
	for <batman-adv@archiver.kernel.org>; Tue,  7 Jul 2026 18:53:47 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 218BF8460E
	for <batman-adv@archiver.kernel.org>; Tue, 07 Jul 2026 20:53:46 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1783450426;
 b=chHyfgwg/nRQhwTrQZtbIvUt076m1id6L/PRzd5q3RYqwaO6Si9GLHGIXV1oD+u2NKkHQ
 qC24+r/DkkNhI44GVjJwMYTjRoQy/GBmyvmq7x5Ss4cP4GPMWS4p+95zthYw/5f8tB32tT2
 tks+Y2MmxWR1RMbE8wC94u13dd6oWyQ=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1783450426; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=/f/dqzzCMHKYC+3m6cMyn5t0XMbE5d0u+7A7X9DXolc=;
 b=2jfJN7XzDNrt/3Q3RIWULrnNAtu6yNrF9mRcMlXddvJzFT3WTrJDfDjoa7gIBN5+9LTgd
 8StabZcBH+NPNBb7rsFxvVQmwGi30P7cjggqDmgLLT4ud0U2rLwz92j9TQbBf7hTvAqj+dJ
 FrhtYtA7HYeME6HyRqsrEOoGArUnrbY=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id D025384173
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 07 Jul 2026 20:47:11 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1783450031;
	b=B6sm2Sufzd3cchslHpYDM+cGOqVUXV/gcd6k8a8x+BGOynjlbW8W0jQ29n66/Xc+GCM6fH
	0YvABT19XNSLPj46+eF+OutfZqkkiSG9YhOY4Hfe867CupHhLJyQLkx0mYT0qM6pqKvLzi
	1ETXYKM9mu2kW4n7eirLdk9eH/FhFcY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1783450031;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=/f/dqzzCMHKYC+3m6cMyn5t0XMbE5d0u+7A7X9DXolc=;
	b=WrgpohWcvLaNb2R8qUVD8JwDnp/IIaEHKKGBpayG5kti0nV8GGXRg9KbhUPTqykBUUB8gr
	0YwwlkrfgaiaEPntsuuwTuP/HGl9j8OCw3p+shpLLnrDoGNxeIMJXWeOyPL3J/tcdwNPSa
	3RQ0OOc0RzVgcXTwwtyZZ4O+aZWSpoY=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b="E6e/yvKE";
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 5DC09202D1;
	Tue, 07 Jul 2026 18:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1783450031;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/f/dqzzCMHKYC+3m6cMyn5t0XMbE5d0u+7A7X9DXolc=;
	b=E6e/yvKEsi+228dFiOF16FJD+gmkG3yzHbg5Uy8qMKxDHi3emmyDCkC0OCVVwmZ6aDFdfT
	4Os9vQ+HcIIKWZR4k5NkaFXaBO6IO62cwioCcjqHgofMqFPUnVunzBciPY7rVBz/9JhAZk
	CLZpEnGiQj5vIUoTWyBnUqWcHJNfv98=
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 07 Jul 2026 20:46:51 +0200
Subject: [PATCH 09/11] batctl: ping: fix rtt minimum tracking when a sample
 is 0.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-bugfixes-icmp-v1-9-ee563a984acf@narfation.org>
References: <20260707-bugfixes-icmp-v1-0-ee563a984acf@narfation.org>
In-Reply-To: <20260707-bugfixes-icmp-v1-0-ee563a984acf@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1057; i=sven@narfation.org;
 h=from:subject:message-id; bh=jFUGDTXYADQlyjdW8+BL40h7zA1w+rd9Ly0JSai0+yE=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFm+ntP+zPPqFd2wLk22Zjujj63gioodmz6nnvvtffC9w
 /Y5T3IZOkpZGMS4GGTFFFn2XMk/v5n9rfznaR+PwsxhZQIZwsDFKQATebCI4Z+2f8ABWRnnJydf
 77BOkRXYOW/9O5mTn9mOfZuXck70/p4Whn8mD/a+nbpb8Ubq3G2Lrp2vf/fU+XrmxkMvfU9wv1p
 5dVsEIwA=
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: LI7ZMF7CCJNRRYOY6A6PKHJDYRI2MHIN
X-Message-ID-Hash: LI7ZMF7CCJNRRYOY6A6PKHJDYRI2MHIN
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/LI7ZMF7CCJNRRYOY6A6PKHJDYRI2MHIN/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

The rtt minimum is tracked with "if (time_delta < min || min == 0.0)",
using min's initial value of 0.0 as a "not set yet" sentinel. But 0.0 is
also a valid measurement which must be accepted as minimum.

packets_in is still 0 while the first reply is processed (it is incremented
afterwards), so use it to detect the first sample instead of overloading
min == 0.0.

Fixes: 2474249a6312 ("[batctl] ping utility updated to latest batman adv")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 ping.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/ping.c b/ping.c
index 7ba872a..b5c641b 100644
--- a/ping.c
+++ b/ping.c
@@ -300,10 +300,14 @@ static int ping(struct state *state, int argc, char **argv)
 
 			printf("\n");
 
-			if (time_delta < min || min == 0.0)
+			if (packets_in == 0)
 				min = time_delta;
+
+			min = fmin(time_delta, min);
+
 			if (time_delta > max)
 				max = time_delta;
+
 			avg += time_delta;
 			mdev += time_delta * time_delta;
 			packets_in++;

-- 
2.47.3

