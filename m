Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DA8EC43458
	for <batman-adv@archiver.kernel.org>; Sun,  5 Jul 2026 15:56:03 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id B00B884262
	for <batman-adv@archiver.kernel.org>; Sun, 05 Jul 2026 17:56:01 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1783266961;
 b=KD2XuPtVxa9PJ+q+ZY5EimYPzogS1rukcqyKn5SrhV38aupqzroWxNUNEDQf/hEXVmp1k
 u3gMmSyI0MEe3r40QjTLxbUOk4sr+fkTNZBxogpNimcmCWAypEl2qsBOwjsKsVseSAYnR/h
 8ShdC4pTwzfCfNq5hA8ilZOi5CpxYuU=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1783266961; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=+e0i0Q4P9hsh1O4boWFK9ee/E5ii4nnSuCnfoflUHXw=;
 b=AUdhNWhp7Dj93fUwYbJYZcefmJb/KxLwFQFRZnV7v+8482t48m6MzfyyHEws7ilvUP4Nm
 IsIYGPUAft3S8+QFiTSL28/x5bKr6O03GOX99XKHUj7G8RNMedim/3fe6qhag0NbsQu5GWs
 IjpKEt69bTq9GTXc36pfFL1RdzEfJHA=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id A4F5B819E6
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 05 Jul 2026 17:54:15 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1783266855;
	b=ghPhY8MQb0X7zvhRxyFc330U2O3wUlTWx0jr6l7G89Z3fCqeK44Qsl2zr5a5bkO2iVC1al
	e0Q9nRg+MjFvCSqYq7gDMhrxrx42/4B8PKZwC7aH7Zu41UIgHoWivDnS6NLsQDpIA2j/W1
	F5u6p6vTxIsp6Ew77ko0a95pAR5/Rr0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1783266855;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=+e0i0Q4P9hsh1O4boWFK9ee/E5ii4nnSuCnfoflUHXw=;
	b=D5791vE8U+ZN4h+w4OSFTJv6BzTxTAdqP+LhkjDrp3s9kSZr4zfnXiVm+3a29fYP5sKZbO
	3WzfYtkDB7IAsfbCLSeRUBoIYqesmSYPYM6hFSZdjiOWbe9W85n87ZtDkY/NomUTLP8E51
	gAZvlUReLYfgQWCucuuGNDVucelbY6s=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=wcKX11Jr;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 5900020539;
	Sun, 05 Jul 2026 15:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1783266855;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+e0i0Q4P9hsh1O4boWFK9ee/E5ii4nnSuCnfoflUHXw=;
	b=wcKX11JroIkAPFQ7AkYepK8A6s0/d00sBUeCa4QiUYSV6HFJLfvUhbUcLE2zRsY267KZe6
	FoYHOoO6tb+wCRk4vnE4u7ZdIXDh5OoncDaznCtUHXmGbv6vAKvETeh2BxTg9+J9rt9csI
	4mPmA+66OjTcgbYzpHDcIoS2yx2CVFM=
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 05 Jul 2026 17:53:38 +0200
Subject: [PATCH 4/5] batctl: genl_json: escape non-printable characters as
 valid JSON
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260705-bugfixes-genl_json-v1-4-8cc79129012c@narfation.org>
References: <20260705-bugfixes-genl_json-v1-0-8cc79129012c@narfation.org>
In-Reply-To: <20260705-bugfixes-genl_json-v1-0-8cc79129012c@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=782; i=sven@narfation.org;
 h=from:subject:message-id; bh=alJ8AlcKw9Hr3WMix/Q6/JwQrnKipFY95at3HbEmi2Y=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFledfyyvaFPTQKFak/5FRQe+W6U9cvrxTyJxjitoG3yb
 vz3I9w7SlkYxLgYZMUUWfZcyT+/mf2t/OdpH4/CzGFlAhnCwMUpABPpimH4p3lk8TvOZQoBDL86
 /Q09Z/fqTxVdtvlUmLrmWcVH+/lEehj+aTSJq3O85Xfs3cdh3f7zYqyjwmYmjYUTdPfFP/wx4f0
 hPgA=
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: PTTB5FHXBWKQSOWJSJFG3WI7FKDEDHAE
X-Message-ID-Hash: PTTB5FHXBWKQSOWJSJFG3WI7FKDEDHAE
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/PTTB5FHXBWKQSOWJSJFG3WI7FKDEDHAE/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

sanitize_string() emits non-printable bytes as \xNN inside JSON string
values. JSON only allows the escape sequences \" \\ \/ \b \f \n \r \t and
\uXXXX. The latter is the correct option for printing arbitrary character
values.

Fixes: ae1a3d3f0bb7 ("batctl: genl_json: Add generic JSON interface")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 genl_json.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/genl_json.c b/genl_json.c
index 917b255..bb32cab 100644
--- a/genl_json.c
+++ b/genl_json.c
@@ -40,7 +40,7 @@ static void sanitize_string(const char *str)
 			putchar('\\');
 			putchar(*c);
 		} else if (!isprint(*c)) {
-			printf("\\x%02x", *c);
+			printf("\\u%04x", *c);
 		} else {
 			putchar(*c);
 		}

-- 
2.47.3

