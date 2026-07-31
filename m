Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2004EC54F54
	for <batman@archiver.kernel.org>; Fri, 31 Jul 2026 07:41:46 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 740C78363A
	for <batman@archiver.kernel.org>; Fri, 31 Jul 2026 09:41:44 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1785483704;
 b=1dZlnHCcBoFGrg0A6uY1lrX6GP8jNPMmaNFOsK+8rHghic+jG/tkXEvVFtPQkVpmgYyJn
 9dqTjwAESavKGa95EvBWlX4nV4cqtYMR88YBrx0VSp8WJslRdudyr5SjRPAl57AijsoygJ+
 DFjlnjNV0SfTueojFJkvThoz0HiyA5M=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1785483704; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=Fls/zeUQgHo1K94+Li9NXPO0UIqEtYEn9aRdmnuRL/k=;
 b=VyJiZNqnCfWdyRax27JK/m0WvASBX6LOHAZmW5+UZtQZDNlfnM3yZ186tmGDISrqJVbc9
 JPdjiyiw8DrqxDhk64X/mIbrZbd8wVoWYNQaxb/Xf8viRI08LTGOp/eoi2KhCby9khdUNlg
 ExFefyRJ0giTmqSaRo0WdNRP2Rzvj28=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 91F3484008
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 31 Jul 2026 09:41:15 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1785483675;
	b=k5bFlQi4LfOdfJTfSDp6+bMSK72+UY4GdTl94TzUnESnVaWX2kX4u+5fy9QHI4lAeLkT3I
	JgdGohIOdRCkD50BLX+MaI6bVGrKwMC1dbhCFiEhBu8wZNyJH390UIk952egFi0aVNCU6Y
	YvEHKK3wZbk8rPsLH/DLeW4HTAuGPLg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1785483675;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=Fls/zeUQgHo1K94+Li9NXPO0UIqEtYEn9aRdmnuRL/k=;
	b=MfBFDuc0GOAVqpRlwG6dVWMEtbSJGSM52ZAKVbegFaJV51pgtXTG3U1pJ83J9n5nXot3UU
	WEubGlnMpIosavIDSv11lC4g12vRhBuJElNZB0cx5KgHC1JMdkzPgaNu6d7Z79YmopBboD
	YhrN3BFiPLqnXn6VRUtGi4sn1FfOK44=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=OC12wq5A;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 163FE203F3;
	Fri, 31 Jul 2026 07:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1785483671;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fls/zeUQgHo1K94+Li9NXPO0UIqEtYEn9aRdmnuRL/k=;
	b=OC12wq5ABejmH9Omc2kwTVl2mPO2K2zf7Q9P576v1cZOnKh+lXGaNw2lAMjrN8R6PUpmx8
	DFYPJIz1DbsWXjngQckxKHEGI573vHs1xu3T7RYvPN/01g65cO/0zaMK3IlJopKbroE8E6
	sIa5nOcgKlb/jl4uYZnS+e6Hr7Ybdww=
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 31 Jul 2026 09:40:14 +0200
Subject: [PATCH 2/4] alfred: avoid endless-loop when reading data from
 stdin fails
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-bugfixes-client-v1-2-83d8c7a26421@narfation.org>
References: <20260731-bugfixes-client-v1-0-83d8c7a26421@narfation.org>
In-Reply-To: <20260731-bugfixes-client-v1-0-83d8c7a26421@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1090; i=sven@narfation.org;
 h=from:subject:message-id; bh=R9msqo9nXyT/u+eAwlLR3ulMMnwzMKuemPtWpGJj8xA=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFk5gbHHFl+6yrq1blrcWacVPrMeTl/7pbHuZVSZg7eS6
 P8gP9f1HaUsDGJcDLJiiix7ruSf38z+Vv7ztI9HYeawMoEMYeDiFICJcN9n+F95Ttkm5mQ8i3RR
 m800m8Cdl2SL9P1UDma0djM+11rnH8/wz+7fyeozZdr+d5i3bBWoOfLp6lw/jT7t8u0RW9paN76
 9zgsA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: ZSVGETUJUIXTLMGB4YLIWDCJO734OJOC
X-Message-ID-Hash: ZSVGETUJUIXTLMGB4YLIWDCJO734OJOC
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/ZSVGETUJUIXTLMGB4YLIWDCJO734OJOC/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

alfred_client_set_data() read the dataset from stdin in a loop guarded only
by feof(). fread() returns 0 not only at end of file but also on a read
error. A persistent read error therefore made 'alfred -s' spin forever
without making progress.

Stop reading as soon as fread() cannot deliver any data, which covers both
end of file and read errors.

Fixes: 23359bbf72aa ("alfred: initial commit")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 client.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/client.c b/client.c
index 9fa9f00..1967f69 100644
--- a/client.c
+++ b/client.c
@@ -153,6 +153,17 @@ int alfred_client_set_data(struct globals *globals)
 	len = sizeof(*push) + sizeof(*data);
 	while (!feof(stdin)) {
 		ret = fread(&buf[len], 1, sizeof(buf) - len, stdin);
+		if (ret == 0) {
+			if (ferror(stdin)) {
+				fprintf(stderr, "%s: failed to read data from stdin\n",
+					__func__);
+				unix_sock_close(globals);
+				return -1;
+			}
+
+			break;
+		}
+
 		len += ret;
 
 		if (sizeof(buf) == len)

-- 
2.47.3

