Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E1F4C43458
	for <batman-adv@archiver.kernel.org>; Wed,  8 Jul 2026 20:09:49 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 16E4F85432
	for <batman-adv@archiver.kernel.org>; Wed, 08 Jul 2026 22:09:48 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1783541388;
 b=MPkDDNfmrj/DziDbnx3DQPCMn6Eaf9IHFeA3G9mkJi6HKX3GPjcNI2dCQ0nlScJKoGu9a
 W8BJlVczPpWiLpxOrWK/yGEzQgNDCn2816+V/MBih+tLsoRKPmqDbJY26fQjhxQJjmLDDEN
 SEmZlShmKL7rVfF8rOqUMRGoXoGgrlI=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1783541388; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=GIudDFBfeC1HBRJ/KM2Jh6N70Y9fbWX1vP1gUGrtZcM=;
 b=0h4LnX057Fvef694YS1kGVsw5jRBm7ygYv4unmPZO6Kw5TQJJ4Wg+zlsy1ThFloDUzMLj
 /WqkHKOrFetbDyFEAIlmLR/yiqprn6exJ3L7M8mJhhH0SmsT4j3XuO+0W+UirT3e6ZI9Onn
 TIPS3yhRPLwsTPPP6fklasAsIpAXtr4=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 202BB84924
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 08 Jul 2026 22:01:09 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1783540869;
	b=Vp+MOmI3WJwFC++e0yieBbGGxfJ2KJW8/Jih9mrmMrGkLFv3Tp/yyBJDwwDA9GRgO9Z0h8
	/rlc4PLUJApCxCjAlciO1/kY1x+OGu0c6SbFkvPVXK1psax6LgZKYu4iXJLHverFEs+7zk
	nEeGTQpVNSCwPkj6/o7QUe994D97Gtw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1783540869;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=GIudDFBfeC1HBRJ/KM2Jh6N70Y9fbWX1vP1gUGrtZcM=;
	b=01C6TSsJqcwBUVAgDpqrBfKQ+PXnMKguANP30cujzKmGnG2q+BpLPj4DCGPdOCT13cUOz3
	7UuoscIlmOnXO5Ebwf5j2lj0Ip4napFbn0R7x57o//HhmHXsAxMDO05dnGXH9W0USmpzIJ
	M3vKBVHrjAkRnbbWYpodPbqsp6XxCzs=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=hrPho1vx;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id B14CB20019;
	Wed, 08 Jul 2026 20:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1783540868;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GIudDFBfeC1HBRJ/KM2Jh6N70Y9fbWX1vP1gUGrtZcM=;
	b=hrPho1vxS4KalDHvNBCSmXKoOtHuspApbEGwUZWgeHzyWKmqONBf6Ba/DlgeUTy/EE2RUb
	WGPsbC25wD53wAeE8VRPizEpn/2Jkg61siAR7nwvX1F9f2lrRAQRXPzHT5P4B7Za/1BWO/
	KebzxtB5NPDGsvPKGtmp7aMV2WKX2OU=
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 08 Jul 2026 22:00:18 +0200
Subject: [PATCH 12/12] batctl: netlink: use kernel-style error codes for
 nl_recvmsgs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260708-bugfixes-netlink-v1-12-8ce03e37f17b@narfation.org>
References: <20260708-bugfixes-netlink-v1-0-8ce03e37f17b@narfation.org>
In-Reply-To: <20260708-bugfixes-netlink-v1-0-8ce03e37f17b@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1036; i=sven@narfation.org;
 h=from:subject:message-id; bh=PsgWJQdtuI2bLywGU9NclaXpYaNAchtX8Wpk3zDp+RM=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFl+azw7bxgVzZY4a8LuGNr25zyLy+3j21cLLM9cs2vV7
 zZd+YMVHaUsDGJcDLJiiix7ruSf38z+Vv7ztI9HYeawMoEMYeDiFICJeM5kZLhzLUOk3G8l327R
 qjCTU0ZFay2vcJ9K1GNsei5/1fuaqzHDf6d5wVUdrYxix3Uj9Gqy+Z89Ftg/oy02Ktvnb9mvdRs
 jeQA=
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: UQX2JBQDG6WCTPM4NYNXQFUGRYCTSJ33
X-Message-ID-Hash: UQX2JBQDG6WCTPM4NYNXQFUGRYCTSJ33
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/UQX2JBQDG6WCTPM4NYNXQFUGRYCTSJ33/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

When nl_recvmsgs() fails, it doesn't return a kernel/errno style error
codes. It is instead using negative NLE_* return codes. Since the rest of
the batctl code uses kernel style codes, just handle it as EIO error.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 functions.c | 2 +-
 netlink.c   | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/functions.c b/functions.c
index 213ba83..ba5ef83 100644
--- a/functions.c
+++ b/functions.c
@@ -565,7 +565,7 @@ int netlink_simple_request(struct nl_msg *msg)
 	err = 0;
 	ret = nl_recvmsgs(sock, cb);
 	if (ret < 0)
-		err = ret;
+		err = -EIO;
 
 err_free_cb:
 	nl_cb_put(cb);
diff --git a/netlink.c b/netlink.c
index 6e0d35a..fb6fdae 100644
--- a/netlink.c
+++ b/netlink.c
@@ -677,7 +677,8 @@ int netlink_query_common(struct state *state,
 
 	ret = nl_recvmsgs(state->sock, cb);
 	if (ret < 0) {
-		query_opts->err = ret;
+		if (query_opts->err == 0)
+			query_opts->err = -EIO;
 		goto err_free_cb;
 	}
 

-- 
2.47.3

