Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C535C5516D
	for <batman@archiver.kernel.org>; Thu, 30 Jul 2026 19:34:33 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id A84A4806CB
	for <batman@archiver.kernel.org>; Thu, 30 Jul 2026 21:34:31 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1785440071;
 b=wMd+Ct5ofBmIU4YFrT0O70kjWNoggzSlZwvm06w/qnv5m0+OFK6zj7f8/2K8GOjfzhC/8
 UQgSbJGVUM5PVOLRHI6aVnhZETGbpHz/5VvtDGpUYNIQ5Y1aXsstEC0ju2TF/lgmQ5Fcrp8
 GoegcwqnOGjsnqgK901eqzsWoOwDNoo=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1785440071; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=UH280/apm/DdGdTMK9idzQhyL2rF7CKvmvoVawSr3W8=;
 b=KO2lLIlQygtXQZ4eyvHnzwTPNaVxPH0i2vWTmhuD0RCTX74Ms/SOrPJKMHGW6/5jOoKZm
 D43B18tFJvnnBMnJ5g3HEYOcxwHr2cns4tm9SLtLQZhCjHXqQIRoKsfkCUXuba14LZ/aa42
 Wv5S31sBZKfi9vo49NRhNrO7icTINy0=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 4898F835FB
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 30 Jul 2026 21:33:03 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1785439983;
	b=M4ctp8YlFuQFiBR7nr7RYL2NAa5GzkFPBWAWMUckeu5c9za34ZKYrTIhFcWaCDY2P7BWcn
	4Sa5w4Q9Tp4VA3qshw9IyAqmOA/TPqjMEX56c/zX+YmZV4JpkC7pdJ70QfbNL4esBLYFfH
	kXEG9JSZ05tZVFBrRzHP2AfC5zitQ1o=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1785439983;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=UH280/apm/DdGdTMK9idzQhyL2rF7CKvmvoVawSr3W8=;
	b=XsDWN2cCgLvDPfhwgm72f8n4No8QtN+dOtZmaEJ4/KFUnRurjMUnbrlYquKhpdPLqD9HVO
	IOC/lNVy2hJXi4TdrkT642TVBBET5klWybZlW/lEE4LymP18MwUofuz8sdDtDPibbLPafN
	G/moGf4WNaMWPzsrKmc43Bvj91WpU0A=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=zEkh7Q0i;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id DC3DF203F6;
	Thu, 30 Jul 2026 19:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1785439978;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UH280/apm/DdGdTMK9idzQhyL2rF7CKvmvoVawSr3W8=;
	b=zEkh7Q0iee1OSyoBcwhJWpQrFXummwJ4F/VjtNzV0OOfW6xzCTvntQlS8bK0hFf8xwDgY/
	TTw+5Ws8diHoNdaUJfxvLktQru64SDbCneTjoTjSYJRzCyueMISDx3VcfTGI5p3fO0fnJp
	EJvL56TKxMryKdR4iigyBBly4djhWQE=
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 30 Jul 2026 21:31:58 +0200
Subject: [PATCH 4/6] alfred: reject invalid synchronization periods
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260730-bugfixes-parsing-v1-4-c0f2ce4764bd@narfation.org>
References: <20260730-bugfixes-parsing-v1-0-c0f2ce4764bd@narfation.org>
In-Reply-To: <20260730-bugfixes-parsing-v1-0-c0f2ce4764bd@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2804; i=sven@narfation.org;
 h=from:subject:message-id; bh=v2VZwEti5idfoAckaE3Zk9LMErffTCeFILqhJFgri8E=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFnZy9Y6PJk9I/7nytmPTr/qPd59aEfsm96MvBuK1WrFm
 W/W7eFT6yhlYRDjYpAVU2TZcyX//Gb2t/Kfp308CjOHlQlkCAMXpwBM5M4thv9ht5SvXit+n5+T
 b8ZdttM7PqeOuYDB6oVljvXjnJOx2v8ZGY586TKLXbzZtcfr/utMYeMpgt3vllwKE9v2kfv95S8
 /rdgB
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: JEALLK5MZ3566SLU3FQAVIASXE7KEGSH
X-Message-ID-Hash: JEALLK5MZ3566SLU3FQAVIASXE7KEGSH
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/JEALLK5MZ3566SLU3FQAVIASXE7KEGSH/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

The -p option argument was parsed with strtod() without any validation. An
unparsable argument yields 0.0 and a zero it_value disarms a timerfd
instead of arming it. 'alfred -p 0' or a mistyped period therefore started
a daemon whose periodic timer never fired - no primary announcements, no
data synchronization and no purging of stale data - while everything looked
fine at startup.

Reject non-finite, zero and negative synchronization periods. And also
reject parse errors.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 Makefile |  2 +-
 main.c   | 25 ++++++++++++++++++++++++-
 2 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index d71f41f..66b3a10 100755
--- a/Makefile
+++ b/Makefile
@@ -25,7 +25,7 @@ MANPAGE = man/alfred.8
 # alfred flags and options
 CFLAGS += -pedantic -Wall -W -std=gnu99 -fno-strict-aliasing -MD -MP
 CPPFLAGS += -D_GNU_SOURCE
-LDLIBS += -lrt
+LDLIBS += -lrt -lm
 
 # Turn on alfred capability dropping by default - set this to n if you don't want/need it
 export CONFIG_ALFRED_CAPABILITIES=y
diff --git a/main.c b/main.c
index baedbd2..6372ec8 100644
--- a/main.c
+++ b/main.c
@@ -7,7 +7,10 @@
  */
 
 #include <arpa/inet.h>
+#include <errno.h>
 #include <getopt.h>
+#include <limits.h>
+#include <math.h>
 #include <signal.h>
 #include <stdbool.h>
 #include <stdio.h>
@@ -172,6 +175,7 @@ static struct globals *alfred_init(int argc, char *argv[])
 	};
 	double sync_period = 0.0;
 	struct globals *globals;
+	char *endptr;
 	int opt_ind;
 	int opt;
 	int ret;
@@ -298,9 +302,28 @@ static struct globals *alfred_init(int argc, char *argv[])
 			printf("A.L.F.R.E.D. - Almighty Lightweight Remote Fact Exchange Daemon\n");
 			return NULL;
 		case 'p':
-			sync_period = strtod(optarg, NULL);
+			errno = 0;
+			sync_period = strtod(optarg, &endptr);
+			if (errno || *endptr != '\0' || endptr == optarg ||
+			    !isfinite(sync_period) || sync_period <= 0 ||
+			    sync_period > (double)INT_MAX) {
+				fprintf(stderr, "bad sync period argument\n");
+				return NULL;
+			}
+
 			globals->sync_period.tv_sec = (int)sync_period;
 			globals->sync_period.tv_nsec = (double)(sync_period - (int)sync_period) * 1e9;
+
+			/* a period which rounds down to an all zero timespec
+			 * would disarm the timer in timerfd_settime() instead
+			 * of triggering it
+			 */
+			if (globals->sync_period.tv_sec == 0 &&
+			    globals->sync_period.tv_nsec == 0) {
+				fprintf(stderr, "sync period argument too small\n");
+				return NULL;
+			}
+
 			printf(" ** Setting sync interval to: %.9f seconds (%lld.%09u)\n", sync_period,
 			       (long long)globals->sync_period.tv_sec,
 			       (unsigned int)globals->sync_period.tv_nsec);

-- 
2.47.3

