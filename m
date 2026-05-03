Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4046ECD3424
	for <batman@archiver.kernel.org>; Sun,  3 May 2026 20:47:38 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 9DC0085AD8
	for <batman@archiver.kernel.org>; Sun, 03 May 2026 22:47:36 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1777841256;
 b=sinMuKqn0LPGkUdt6L10/5GMjwrMa91F52bH+q/J5gWE3MdHABGLwI5S6/1AXMSqZHNbi
 Fcb3mpv73gwfFSaIEJa9oF6kFlS5OhoxSCj2HuntbW9g3V2yWTGGnhTge/ijQUDxObmQlsa
 DqMv2PpdAU1n6crmdP5GvE/7A+8jlKk=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1777841256; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=Dl0H+IkG+2i7Cy1ZIJqnydcGqZNk/5PjSDN9apFgp58=;
 b=pFBXeOHJ8yRKHhPG/0AukmXJa7R33iF+z0gBhSIKQxO3npaXbQqAz/ytMF7zJedp+6mBV
 0RA6fJ72nbMkA5fd8BwwHEWApDvsHBeosxIJs1U9CFFyAyg1rkoHDoIxH4ncxWvw728h2hX
 ixOSXwCPht56u0d09CHUR/7rth4syN4=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 42BE185AB1
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 03 May 2026 22:47:04 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1777841224;
	b=oDAAdzj7NMNIEOV6Op3w30UTqDXrGVDI9ZAaO4NBo85zTJHfkGu3vOXvfQzYpWKRn6WKoN
	+DOHLAVF4CQpgdlOREkvM5B8HCoFwn+TbNcbuPyS2LfqjQIfl9TNVlaux5LO0CuerH2SWW
	TRkzj7yPhENmWKZ6P3El6CKG9mk+ed0=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=SMXlP74P;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1777841224;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=Dl0H+IkG+2i7Cy1ZIJqnydcGqZNk/5PjSDN9apFgp58=;
	b=EFWfTyCrG71wb4uHRb1c/aw0jLr7NvIMTmHZ6zfviXWK24uBd4LQgPx3AbZ7TDi5iV2iDh
	QDJ6X0uDnv6YICU/hsOaPxupIotHqPVcsUSR4zK9FlYAabgZLxZCP9t666Fykh5Y2lY68V
	mQZfZl5JWWdDUCCTIh1GQsGvXZLUbpI=
Received: by dvalin.narfation.org (Postfix) id 83BDC1FDD3;
	Sun, 03 May 2026 20:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1777841223;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Dl0H+IkG+2i7Cy1ZIJqnydcGqZNk/5PjSDN9apFgp58=;
	b=SMXlP74PdEHqMfxPIJJe/0taumyQBcdZrT5NMlXKijJH92XCWKQGUIatGjqZz3LGL0d+ZX
	LvLTj8ICic1o8XuQ5jlyXjH1OWdnu0rdeOhe4+ZJtlGo7HIUHp0mE0WFTnF9XJdk5/zEce
	j2+fiaH8PqnreNOPC/g8dDDptuJOy3U=
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 03 May 2026 22:46:14 +0200
Subject: [PATCH batadv-next 1/2] batman-adv: add missing includes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260503-post-fixes-cleanup-v1-1-9c5c0ff0fcb4@narfation.org>
References: <20260503-post-fixes-cleanup-v1-0-9c5c0ff0fcb4@narfation.org>
In-Reply-To: <20260503-post-fixes-cleanup-v1-0-9c5c0ff0fcb4@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3328; i=sven@narfation.org;
 h=from:subject:message-id; bh=i8jeUTkvUvqfGjUvIbd9cqsG6UBXtdKjqzaquZ32WcY=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDJnft0jUuh3Z9kHuVdq1r5fO7jmyo9hw96V9ug/bNuV0T
 X/cl1Ve0lHKwiDGxSArpsiy50r++c3sb+U/T/t4FGYOKxPIEAYuTgGYSGk0I8PBj93yf7vf3P1U
 3bC9+iJb9N7tx5zkI24s7vNmPnun+S4TI8PW36HPars/+l7ca8h85N2PK19WLa8wPqrT3LPwRf3
 knboMAA==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: BH5WZN4V3LRMK4EBZK4AA5JUAWEKAUJT
X-Message-ID-Hash: BH5WZN4V3LRMK4EBZK4AA5JUAWEKAUJT
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/BH5WZN4V3LRMK4EBZK4AA5JUAWEKAUJT/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Some of the recent fixes required features from new header files. There is
currently build problem because transitive includes take care of it. But
the batman-adv source code tries to avoid the dependency to
transitive/implicite includes because it has no control over them and they
might get removed at some point.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/bat_v_ogm.c         | 1 +
 net/batman-adv/fragmentation.c     | 1 +
 net/batman-adv/gateway_client.c    | 1 +
 net/batman-adv/hard-interface.c    | 1 +
 net/batman-adv/tp_meter.c          | 1 +
 net/batman-adv/translation-table.c | 1 +
 net/batman-adv/tvlv.c              | 1 +
 7 files changed, 7 insertions(+)

diff --git a/net/batman-adv/bat_v_ogm.c b/net/batman-adv/bat_v_ogm.c
index e3870492..9914346a 100644
--- a/net/batman-adv/bat_v_ogm.c
+++ b/net/batman-adv/bat_v_ogm.c
@@ -8,6 +8,7 @@
 #include "main.h"
 
 #include <linux/atomic.h>
+#include <linux/bug.h>
 #include <linux/byteorder/generic.h>
 #include <linux/container_of.h>
 #include <linux/errno.h>
diff --git a/net/batman-adv/fragmentation.c b/net/batman-adv/fragmentation.c
index f4e45cc2..068d8b41 100644
--- a/net/batman-adv/fragmentation.c
+++ b/net/batman-adv/fragmentation.c
@@ -8,6 +8,7 @@
 #include "main.h"
 
 #include <linux/atomic.h>
+#include <linux/bug.h>
 #include <linux/byteorder/generic.h>
 #include <linux/errno.h>
 #include <linux/etherdevice.h>
diff --git a/net/batman-adv/gateway_client.c b/net/batman-adv/gateway_client.c
index 51e9c081..a4ab3d44 100644
--- a/net/batman-adv/gateway_client.c
+++ b/net/batman-adv/gateway_client.c
@@ -8,6 +8,7 @@
 #include "main.h"
 
 #include <linux/atomic.h>
+#include <linux/bug.h>
 #include <linux/byteorder/generic.h>
 #include <linux/container_of.h>
 #include <linux/err.h>
diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index d6732c34..4b3804ef 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -8,6 +8,7 @@
 #include "main.h"
 
 #include <linux/atomic.h>
+#include <linux/bug.h>
 #include <linux/byteorder/generic.h>
 #include <linux/compiler.h>
 #include <linux/container_of.h>
diff --git a/net/batman-adv/tp_meter.c b/net/batman-adv/tp_meter.c
index 58ca59a2..5e556024 100644
--- a/net/batman-adv/tp_meter.c
+++ b/net/batman-adv/tp_meter.c
@@ -8,6 +8,7 @@
 #include "main.h"
 
 #include <linux/atomic.h>
+#include <linux/bug.h>
 #include <linux/build_bug.h>
 #include <linux/byteorder/generic.h>
 #include <linux/cache.h>
diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index d39332ea..8ab93458 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -9,6 +9,7 @@
 
 #include <linux/atomic.h>
 #include <linux/bitops.h>
+#include <linux/bug.h>
 #include <linux/build_bug.h>
 #include <linux/byteorder/generic.h>
 #include <linux/cache.h>
diff --git a/net/batman-adv/tvlv.c b/net/batman-adv/tvlv.c
index 8129a3f9..328636c4 100644
--- a/net/batman-adv/tvlv.c
+++ b/net/batman-adv/tvlv.c
@@ -6,6 +6,7 @@
 
 #include "main.h"
 
+#include <linux/bug.h>
 #include <linux/byteorder/generic.h>
 #include <linux/container_of.h>
 #include <linux/etherdevice.h>

-- 
2.47.3

