Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C791C43458
	for <batman-adv@archiver.kernel.org>; Sun,  5 Jul 2026 17:37:15 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id F2EFB84687
	for <batman-adv@archiver.kernel.org>; Sun, 05 Jul 2026 19:37:13 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1783273033;
 b=jAHnUAaZbCzSsL5DZ0zNJ4r/40xe1dW3ljTTSG7e7Uf+zCvqa5qTf0+433MHVdjSTf3is
 lKmE52o/KeQjWXdtsx/HzTpU4bFQVLbN4HO9IArpOpSJQr+VcZ2j055pqVmhLYOtWI03mXK
 Hj8A0yvJmmGOMvasWpfLHAzkP3lOP2E=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1783273033; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=wofGB+KRFcU90b+Onh8ATvCKEv8aVZfJw2Gb9HKaR4s=;
 b=ucRWvJLsmsllpGrppORtywaqAgHdX8cvcEBXBSGTrIYUOrb7bpJ2WNVVfENWdnolMqFxn
 8MqyAe0MMJbCft4jLGUz3i5RXP1rPw7xDtwuoYklRs3vZteMHYArB38ygnDa9UlWAmQxWbf
 USIk2YuugTCtAlcNHA9tJ1ogMA5KzaE=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 9A64382F09
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 05 Jul 2026 19:30:28 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1783272628;
	b=ei0yDgZUl4bLBV+HhUAhVp+NaFTIHDkCmu1+kWdGAWNr/CXE75+Lo8B2E2qNYlWGlh1Kp3
	8/mJXTturble2TjWPINuoNbnoG63TSAAABm9yluV5NxiSLjLzbNfNlDMTQyPccAhLZbdOz
	I8g18efaOIrgQ2354esvGAR7AaWqhCQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1783272628;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=wofGB+KRFcU90b+Onh8ATvCKEv8aVZfJw2Gb9HKaR4s=;
	b=B6UMo+hFMhull9aBIHQLMVQq4SAtbqLIY2LBSddNs81Sp3jq95XgxgCnEC94hG0wH2M9ly
	gB9GymTlVEfSEDelM6ZG0q35GsxLz/8p/57e3+CdURRogmPh9JrwF3O+Ku1SC7nat6rsTN
	5fBtc1M22nPKNo4reLOIbZBfJPgnIxQ=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=S4Q984zy;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 4094E1FEE6;
	Sun, 05 Jul 2026 17:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1783272628;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wofGB+KRFcU90b+Onh8ATvCKEv8aVZfJw2Gb9HKaR4s=;
	b=S4Q984zyKPmzS4DsOi+ZOstLLzzsJNgsyxv+v/nuwLoIgAi6Z1hHRcaELtu2RhZdvsiUZB
	be9NG3tQOLido9/oUVWx4rZYMGDOniP8ZqHH1GntrnauC2jGsYAsHsWfZzwgMoKhvzvP8F
	FjRdla0zcB1W8EIVuf3w3AgP4fPp+ks=
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 05 Jul 2026 19:30:12 +0200
Subject: [PATCH 9/9] batctl: tcpdump: fix source address selection for
 802.11 data frames
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260705-bugfixes-tcpdump-v1-9-c37f6f82eed1@narfation.org>
References: <20260705-bugfixes-tcpdump-v1-0-c37f6f82eed1@narfation.org>
In-Reply-To: <20260705-bugfixes-tcpdump-v1-0-c37f6f82eed1@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1182; i=sven@narfation.org;
 h=from:subject:message-id; bh=7UzXbjTQhRGdHYFFmRZHMv4Y772Q1NArsPi12/Cd3Xs=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFleU+brSZrlTOOZ+rLthqLZ6fSfN5+aaGpuUd88Mduts
 3j/dqb1HaUsDGJcDLJiiix7ruSf38z+Vv7ztI9HYeawMoEMYeDiFICJ6Dgx/HdjCWrxetnkuyac
 Sa3Ptlp6+s3TwUK/Hx9vmH3+rv3MTh1GhiWtKqxFim6ZN0y6JVg1uZltv95b+eWefLlXxWEt7V0
 n+QE=
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: RIN23B5SZTN7HT36LQIJKNKSSHDPNCR3
X-Message-ID-Hash: RIN23B5SZTN7HT36LQIJKNKSSHDPNCR3
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/RIN23B5SZTN7HT36LQIJKNKSSHDPNCR3/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

For non-AMSDU data frame, we need to select as source host:

* neither from/to DS: addr2
* from DS: addr3
* to DS: addr2
* from+to DS: addr4

But the code is actually selecting:

* neither from/to DS: addr2
* from DS: addr3
* to DS: addr4
* from+to DS: addr3

Instead of checking single bits, the special cases "from+to DS" and "from
DS" have to be checked separately.

Fixes: 5143e351a77b ("batctl: add raw wifi packet decapsulation support")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 tcpdump.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tcpdump.c b/tcpdump.c
index 48744ea..764b484 100644
--- a/tcpdump.c
+++ b/tcpdump.c
@@ -1369,10 +1369,10 @@ static void parse_wifi_hdr(unsigned char *packet_buff, ssize_t buff_len,
 		return;
 
 	shost = wifi_hdr->addr2;
-	if (fc & IEEE80211_FCTL_FROMDS)
-		shost = wifi_hdr->addr3;
-	else if (fc & IEEE80211_FCTL_TODS)
+	if ((fc & IEEE80211_FCTL_FROMDS) && (fc & IEEE80211_FCTL_TODS))
 		shost = wifi_hdr->addr4;
+	else if (fc & IEEE80211_FCTL_FROMDS)
+		shost = wifi_hdr->addr3;
 
 	dhost = wifi_hdr->addr1;
 	if (fc & IEEE80211_FCTL_TODS)

-- 
2.47.3

