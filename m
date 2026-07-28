Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40CD6C53219
	for <batman@archiver.kernel.org>; Tue, 28 Jul 2026 19:26:05 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 58128843C0
	for <batman@archiver.kernel.org>; Tue, 28 Jul 2026 21:25:59 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1785266759;
 b=bB72sAIm6KsHpCQtwZUvMJJtX00KJpSxs/GofYV8VAUKqmIb0pWNtXyjJhlvv94uoIsNY
 ZMAjU/5eXJvQppJpPPZhhUtRLGBuu+zKwJK0Y5bqo3XQlV4bNJ2IIQ1AETzx2QIT1foY4mx
 Yv6Qz7LRsuYZq/Di7vwocEu20hCAXjI=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1785266759; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=kSH2rfZOhLDewRpWgfzV3fnJkf8V21MuRbuC0yVJfQw=;
 b=BBfz7E56j5j7n4SSOTLt2MmNjPcALrrGgl5ouqoI2kw/FhFZLXTxsgWhS0gf72AyoNWrg
 LaajWidg76sBbd6+rzv4ShJVuzGZuRJT4d7YG91ZHM5l8Kn2V1byn1xC95Mc24U3qvIWlEa
 uqwtC153Ndk5LLY1fMWGOLEpE76rIKE=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 3231C846FC
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 28 Jul 2026 18:02:24 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1785254546;
	b=BDXQ2H5Sj2Xq7JKESWiKkI5ZWKjlgf956Nt6wH584d7WQhx1rkgWZet5Cbvm3UTVunvwoS
	X1gkQBcWZs+6QL/GTGDHrDGP0hG1ItD9GaDuxHnaRsAW6mPEujmYRlgCssYKdjfbQoY8N7
	Pb6tu4r7REfWyi82sYJyTXGURLW8co8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1785254546;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=kSH2rfZOhLDewRpWgfzV3fnJkf8V21MuRbuC0yVJfQw=;
	b=jyfo/CgTiJNo/PREuZmX1KuND8Npj3QY41D2TsoTEjIGNgf6rMcii5Mro1vQAwJ2j3T7RW
	tpnC0q905qsY/Qh+A4cZkhMTdtL/Crfh47sGpHhcbYzaTdSbpRNFSB95p8k/oYGDysPTNk
	eLu6JtBaxTt+cZM8wksUSwf8Gu7ueMQ=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b="lhU/FwVG";
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id B49CB204EB;
	Tue, 28 Jul 2026 16:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1785254539;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kSH2rfZOhLDewRpWgfzV3fnJkf8V21MuRbuC0yVJfQw=;
	b=lhU/FwVGYjbLVP8tntKOxwPWVwDfvOgi4aCQhZRaE9TfWIyRjpH50k5LT6hXDYBrb4E+LV
	yq3EUIgL7AgIdLAwRIF4VrVfmq2UXgM3SVUxkQtKVxdTYh4BOyOl4nN0aSqgHvQ/5ta9OI
	IRDcXHH50C+r4loDSUWGVbh/MJPe8Os=
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 28 Jul 2026 18:01:31 +0200
Subject: [PATCH 2/8] alfred: vis: keep interface names always in heap
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260728-bugfixes-vis-v1-2-2540447c8a67@narfation.org>
References: <20260728-bugfixes-vis-v1-0-2540447c8a67@narfation.org>
In-Reply-To: <20260728-bugfixes-vis-v1-0-2540447c8a67@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1919; i=sven@narfation.org;
 h=from:subject:message-id; bh=jPZv9x1hocHqmj9Z/eKK2YIbE4nB0GggD9EOgDCa55k=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFkZl2ImWdxWev+DRyF7/12NtSs4JvZeMf2aZbdcaNPBH
 5mbvl/e21HKwiDGxSArpsiy50r++c3sb+U/T/t4FGYOKxPIEAYuTgGYyNQ+Rob2mbnZ7onme+wy
 Rdos913i313bus/eY5fskqcP9+6o7I9j+Gc6seb/l9QIqb83F+RJl8xbazN/UlTd7xCDescm99l
 Pm1kB
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: JUOQ7YTQN23QPUJOPSVH5A34T2VQBWQB
X-Message-ID-Hash: JUOQ7YTQN23QPUJOPSVH5A34T2VQBWQB
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/JUOQ7YTQN23QPUJOPSVH5A34T2VQBWQB/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

The interface pointer in globals was used to store an address in .rodata or
in on the heap. This makes the handling of the allocation/deallocation
hard. At the same time, nothing checked for allocations problems. An
allocation error could cause an hard-to-debug problem later when trying to
calculate the ifindex.

Adjust the code to always allocate the string as an heap object to simplify
the handling.

Fixes: 2e3e312f7757 ("alfred: add vis")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 vis/vis.c | 12 +++++++++++-
 vis/vis.h |  2 +-
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/vis/vis.c b/vis/vis.c
index d635798..97c6093 100644
--- a/vis/vis.c
+++ b/vis/vis.c
@@ -1058,10 +1058,15 @@ static struct globals *vis_init(int argc, char *argv[])
 	memset(globals, 0, sizeof(*globals));
 
 	globals->opmode = OPMODE_CLIENT;
-	globals->interface = "bat0";
 	globals->vis_format = FORMAT_DOT;
 	globals->unix_path = ALFRED_SOCK_PATH_DEFAULT;
 
+	globals->interface = strdup("bat0");
+	if (!globals->interface) {
+		perror("strdup");
+		return NULL;
+	}
+
 	while ((opt = getopt_long(argc, argv, "shf:i:vu:", long_options,
 				  &opt_ind)) != -1) {
 		switch (opt) {
@@ -1081,7 +1086,12 @@ static struct globals *vis_init(int argc, char *argv[])
 			}
 			break;
 		case 'i':
+			free(globals->interface);
 			globals->interface = strdup(optarg);
+			if (!globals->interface) {
+				perror("strdup");
+				return NULL;
+			}
 			break;
 		case 'u':
 			globals->unix_path = optarg;
diff --git a/vis/vis.h b/vis/vis.h
index e257c45..d3486f9 100644
--- a/vis/vis.h
+++ b/vis/vis.h
@@ -73,7 +73,7 @@ struct vis_list_entry {
 	 (vis_data)->entries_n * sizeof(struct vis_entry))
 
 struct globals {
-	const char *interface;
+	char *interface;
 	enum opmode opmode;
 	enum vis_format vis_format;
 	uint8_t buf[65536];

-- 
2.47.3

