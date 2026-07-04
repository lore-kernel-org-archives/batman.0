Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C510FC43458
	for <batman-adv@archiver.kernel.org>; Sat,  4 Jul 2026 11:45:20 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 2015284000
	for <batman-adv@archiver.kernel.org>; Sat, 04 Jul 2026 13:45:19 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1783165519;
 b=Kji3b8oqwoCLtGAuHOrybkLETd9to6sdov+6BRqn65tSBQscq7Dge+OOK8/YCznfHnkMa
 2b5f8t3FAwAOvy2Qg7EQy09iUIJgQTF5GRcKiq6qnn8bP9BbyeSOfrwt9NpIdm6UFApU1+/
 QMWm2jDCbwgrPKzUED954Enf64fAfsM=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1783165519; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=nVJ2C5s3e1RVvw2+XDswv9hqfDBjQYACzs8fYLQofJA=;
 b=qIVcskAljMkpFOswccYK9vy60ue795cGbqYqlNHavR4LhzrtdDdhjEMgxZ2Ott3/m3zxs
 kJw+BciLWNXy4Bdt3yFQrcdPxwqy7ZZdFb2XjqgK9l+EQpHSw32upQprhbPe8iXo+oYfej4
 wlboIMKEmaqobyzKvsBydcI2WwTdDdA=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 8CB1281CDC
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sat, 04 Jul 2026 13:44:46 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1783165496;
	b=gLun30KJje11xRyqj2XkleCqx2XCNKKJdWzH6+m9OW/LeBmdbs5JDLgQvtW9fEdK+rZ9oy
	vft0YTZC/MV0+j47ZlLIP4LSUvPQ0G8AsIQHlBygNkaYQPca7esi5uO+w56jpBeCwixfXL
	HFvG0IMiXCtco9xZ1ssJxsdrtEaw+wM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1783165496;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=nVJ2C5s3e1RVvw2+XDswv9hqfDBjQYACzs8fYLQofJA=;
	b=l1JpD39kSTy7wSaGI3uV9aPRJ8YBvOH2XBB/fualtW2EEX7nu89/YF6OmJDW8KJjO/Hgmq
	SCwsU59Pr/8gqkHbLYIQG7AsrYweABbluQ1yudLEDfMXLf7FS5PDXkWfWCw8HLdbQPifDP
	/UbZNkqChHyV1ftg5iXpabws/KgS3gw=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=BLoSeWxd;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id CA54C1FECA;
	Sat, 04 Jul 2026 11:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1783165485;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nVJ2C5s3e1RVvw2+XDswv9hqfDBjQYACzs8fYLQofJA=;
	b=BLoSeWxdGDTQygMqnXSYedxM9e29GuG+fGDFIJbhhJbdZiM0PXXqaUbfHK3k2d0+/buOyc
	YBt4FbhMZ+a3EswFM9+lLS8I++HGDQKbWeDE85wyFBNz0Xm4KmP7Pa3FSdyFzCRBXWOHpz
	YPA7Hf/R74NvOi+opi2Yqo5q8BABLeA=
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 04 Jul 2026 13:44:29 +0200
Subject: [PATCH] batctl: dat_cache: fix multicast/unicast filter for MAC
 address
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260704-bugfixes-dat_cache-v1-1-beb52095f587@narfation.org>
X-B4-Tracking: v=1; b=H4sIABzySGoC/yXMQQqEMAyF4atI1lPoaFXwKjJI00aNC0eaKoJ4d
 6suP3j/O0AoMAk02QGBNhb+zwnfTwZutPNAin0y5DqvdK2NwnXoeSdR3sbOWTeSMr4usERjS6w
 ghUugZ5K69vdaVpzIxfsJzvMCcQQaNXYAAAA=
X-Change-ID: 20260704-bugfixes-dat_cache-4d73b5b4a5b6
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1359; i=sven@narfation.org;
 h=from:subject:message-id; bh=ReAwaDjYwZz8+HdzCkIGC0zJt3RmxQF5mZVQc+8QuVU=;
 b=kA0DAAoWTQ93K9MU9csByyZiAGpI8h3IPO33HkJRfLFwdI/CWzm64PgRB498tUgV9NumnlQEy
 4h1BAAWCgAdFiEEvNRvz7MH7R/zlvHFTQ93K9MU9csFAmpI8h0ACgkQTQ93K9MU9csoyAD/WZUl
 u4kIdOxyCnL0i/4KLaQ5q9yDa3WrJrAZUwtEQ2EA/1tKS74sSqqDzUZlOnYj5YvccaGMknooIah
 ulWvkKjsC
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: N4TIGHB67AD443VVQZVDUB7QDMR3V7HP
X-Message-ID-Hash: N4TIGHB67AD443VVQZVDUB7QDMR3V7HP
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/N4TIGHB67AD443VVQZVDUB7QDMR3V7HP/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

The -u/-m filters in the DAT cache callback test addr[0], but addr in this
callback is function is the text representation of the mac address - not
the binary representation like in all other functions. The binary check of
the multicast-bit will therefore not correctly identify multicast entries.

The kernel reply BATADV_ATTR_DAT_CACHE_HWADDRESS has to be checked instead.

Fixes: d8dd1ff1a0fe ("batctl: Use netlink to replace some of debugfs")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 dat_cache.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/dat_cache.c b/dat_cache.c
index 2dee27a..b8a9656 100644
--- a/dat_cache.c
+++ b/dat_cache.c
@@ -78,10 +78,10 @@ static int dat_cache_callback(struct nl_msg *msg, void *arg)
 	last_seen_msecs = last_seen_msecs % 60000;
 	last_seen_secs = last_seen_msecs / 1000;
 
-	if (opts->read_opt & MULTICAST_ONLY && !(addr[0] & 0x01))
+	if (opts->read_opt & MULTICAST_ONLY && !(hwaddr[0] & 0x01))
 		return NL_OK;
 
-	if (opts->read_opt & UNICAST_ONLY && (addr[0] & 0x01))
+	if (opts->read_opt & UNICAST_ONLY && (hwaddr[0] & 0x01))
 		return NL_OK;
 
 	printf(" * %15s ", addr);

---
base-commit: e93995999e80513db80eba200ea682b5b15556af
change-id: 20260704-bugfixes-dat_cache-4d73b5b4a5b6

Best regards,
--  
Sven Eckelmann <sven@narfation.org>

