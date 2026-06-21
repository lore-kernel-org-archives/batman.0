Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE717CD98F2
	for <batman@archiver.kernel.org>; Sun, 21 Jun 2026 14:40:58 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 72947841A1
	for <batman@archiver.kernel.org>; Sun, 21 Jun 2026 16:40:57 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1782052857;
 b=Eg7B9ULQZIiUBrjOzUmnxRZEXNuaRJIQHjMhECV7NQQfIX6E5v/jbxwM+NKpq2ygfSYs4
 QsXHqTuCuaNyo4cBTulfLvc8hBnMV7Lg2aw+Ue+q1yxgXCojZd86xzNlME8ggj1XL91Cx8k
 x4vcE2IQP7vsQODsVugVUKhUgyTXAtw=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1782052857; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=t4hxBJyNxh0yPFCvx4ZMas5VgGxvvJnqfGrQKHkl+RI=;
 b=q4njDtzajVa8LfSdL/v+UVGlvuIksnlC0GlE4RL9EZXMZmLaBl9BFKE6yJgoKQvpO/+nQ
 HUrIrRCFbHF52PB90jIt+faCSVv6yss82rC1P7w6AcTh0tbvzrUOUk3qnw7ikBtQsWJOW84
 aaFbtFJt2Fa+33bh705jfhoqXXsayCM=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 90A0C8424F
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 21 Jun 2026 16:25:47 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1782051947;
	b=wWCf5F+OiAXOHfsiJ+zeox5jSWZ1WeLk6BitjmcdvkguTqthNdSZjhLK17rbCECBOp6VNu
	7rgQRbB4ILT8JBrLXWPAKWfK7ea7JFXkbOhV0bVWYBbYNOgIi2b9Jy/HABKHJeqs2ky8BJ
	4kI57+m8g5V/imrDO2tQKZTIEImTteI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1782051947;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=t4hxBJyNxh0yPFCvx4ZMas5VgGxvvJnqfGrQKHkl+RI=;
	b=g6Rb9VOhBZ/ufJgBpBI1UxQlkWMhvFSMlYvmuXwxa2e9RRminc4Hr5TB6EFm8B5ZmjNuK7
	+roBq27knAuGcMSAHa5AFeO2FudXmAcMReLpSHJ+HfdW9hq9cWy5+YVkFYeePi9dAgzshw
	MUJntyt1Hll4JK56Th3eX3iX+KlXt0Y=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=MfExY04P;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 3C3DD20131;
	Sun, 21 Jun 2026 14:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1782051947;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t4hxBJyNxh0yPFCvx4ZMas5VgGxvvJnqfGrQKHkl+RI=;
	b=MfExY04PkLxUVazNGG+GYJDDSqXUto1eMwRFPQsrMe4EGhbKBfAFVQ1z4Ar+guaDfx/we6
	F2686rJ3meSG6+Xa602smnIE8cRRyNaVwfPYlAvyga047QjUzfHhWQvh9oISmRRdKaQT+J
	jQdZ7l3wKRg615QtA1nyZXEi0NwqNbw=
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 21 Jun 2026 16:24:12 +0200
Subject: [PATCH 22/28] batct: bat-hosts: compare full path for
 deduplication
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260621-bugfixes-v1-22-b09736288a4a@narfation.org>
References: <20260621-bugfixes-v1-0-b09736288a4a@narfation.org>
In-Reply-To: <20260621-bugfixes-v1-0-b09736288a4a@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=932; i=sven@narfation.org;
 h=from:subject:message-id; bh=M0wbZ89pUmeemmITyv4jls9dm9qDDqFP4MUvauORKqU=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFnmX9jnLO05/PJvSESQud3MKYeND4W5cVveWrk3yEpfc
 YPZFrb5HaUsDGJcDLJiiix7ruSf38z+Vv7ztI9HYeawMoEMYeDiFICJbHFn+J+491DNJdaHEg7V
 wTeEt/V1hVusOyn8RUT/ZqJGhOHeVXUM/0u+Ls5bc6C5o2bj4YD9vySa3qhH+21TOMhvLjPN9UT
 /M24A
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: RJJ5VQCUWKBBNJ4V5SXSSOE53VQFY6XT
X-Message-ID-Hash: RJJ5VQCUWKBBNJ4V5SXSSOE53VQFY6XT
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/RJJ5VQCUWKBBNJ4V5SXSSOE53VQFY6XT/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

The deduplication code uses realpath to store the real path of a provided
configuration file. The code then tries to compare these paths but
accidentally only comparse only the first CONF_DIR_LEN (256) bytes of the
path.

The number of bytes must be set to the same length as the path size slot in
the normalized buffer.

Fixes: db97c2a77e81 ("batctl: fix crash in bat-hosts parser on embedded systems")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 bat-hosts.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bat-hosts.c b/bat-hosts.c
index 57e7d69..6ad8247 100644
--- a/bat-hosts.c
+++ b/bat-hosts.c
@@ -203,7 +203,7 @@ void bat_hosts_init(int read_opt)
 		for (j = 0; j < i; j++) {
 			if (strncmp(normalized + (i * PATH_MAX),
 				    normalized + (j * PATH_MAX),
-				    CONF_DIR_LEN) == 0) {
+				    PATH_MAX) == 0) {
 				parse = 0;
 				break;
 			}

-- 
2.47.3

