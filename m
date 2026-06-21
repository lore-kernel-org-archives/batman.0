Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1EA2CD98F2
	for <batman@archiver.kernel.org>; Sun, 21 Jun 2026 14:28:18 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 9C3C78036B
	for <batman@archiver.kernel.org>; Sun, 21 Jun 2026 16:28:17 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1782052097;
 b=lmAFKBabK37doZ8yPqWg2O2+EWse98uDj7arOtcyDdYxlBLRZTr5Mfgyc/bagzW03HeOL
 9NDMcWrE/egqF8EZO/jZoOd+TN0W7kqjSp7mJbtb8O4sC3wQZRlxucBWGmbkwnY/tO6PnhV
 GAh+FzmFGiW8RVh+yyHH1C41bJQ2zlQ=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1782052097; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=nvoiFkn/riz3ocyNSYyYcLnt2lF8TmoyFvg5wAGUOEg=;
 b=I2BN+BL/BIl9BZNHPJ5+5tCcocC62FDofT+MNwnRer3Vf/f3vWGh4vdplxM7vVydrLR9d
 ljn1HslDLwIt/nJg9ZwWYlbXyPnMP/ZzsX8AN5RmgJYSm7IxhbnGocKn7repdAZh7uxAa5w
 NSDabrWyO/3CLhuU2zvWBBamw3OCDdM=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 88C0083FC6
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 21 Jun 2026 16:24:40 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1782051880;
	b=TttzAxJ3reyhcBQObDhUq3bvP5h16LiddUUljIWo3Bx7CG3+5ThBjN7zGEe1w1lF3XdRTh
	EmX8+hOhsANFgXPrQo5dbFw3F0QilqCsLnasL+lXAh5JL+QiRXQcT/oj42S+Q9zFbbUx8j
	uASjCN3ydLpGKZEbh8UnyUC+oLm2LZs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1782051880;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=nvoiFkn/riz3ocyNSYyYcLnt2lF8TmoyFvg5wAGUOEg=;
	b=IIKRd+LuodvS6gJFu/MCTlPk+kAmEnBModbJyrGiDEf1oovSDgch1GPv3T1VZJhADUUQ9N
	d3PCYQvj9R4fJnEsXiI/SMVDXmiVVYUxucynsY1h1KQAO/FJ+sgnYnapoLpe9GjAnKIENF
	ET0cwaxI/yWb9j8ASI0MZgxTGTXe71g=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=NlyNAVXS;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 42865200C4;
	Sun, 21 Jun 2026 14:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1782051880;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nvoiFkn/riz3ocyNSYyYcLnt2lF8TmoyFvg5wAGUOEg=;
	b=NlyNAVXS6BoGPwulj0BOYoWg52u5m41dhKMSriEuSCtzT6WRCjO3IT7lVRDpIMA4hYo1/P
	/BUO2Dpv4EI9KlM9BBXS/6SiySE2K9RTCZ3eqaRSkOg4L3H+iuNxDr83o2HlSYCM2ujTUY
	83yBkT3LNPrVdcRd30fHhkKkuk92xDI=
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 21 Jun 2026 16:23:55 +0200
Subject: [PATCH 05/28] batctl: improve number parsing error handling
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260621-bugfixes-v1-5-b09736288a4a@narfation.org>
References: <20260621-bugfixes-v1-0-b09736288a4a@narfation.org>
In-Reply-To: <20260621-bugfixes-v1-0-b09736288a4a@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7367; i=sven@narfation.org;
 h=from:subject:message-id; bh=wyceQFjYUqLql+ehxK3QUliMYKmTSMAD2wl990OZfPI=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFnmX1jTHpz3vWSd2GCbLy09fa3sXn++PQF3H03Olmk7+
 tKPrai4o5SFQYyLQVZMkWXPlfzzm9nfyn+e9vEozBxWJpAhDFycAjARmUUM/wwN7yXc3mf2ckrn
 k4brF/Pnmm0yf/jovLsYT2r2ppZbdxYx/HcU3qC7JOf1xU4zHvHKbD+WZyz6887vKJhpE70z9t1
 yR04A
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: PAJ3LWO3OISW2YVQMJWP6CD6K7E7CHWW
X-Message-ID-Hash: PAJ3LWO3OISW2YVQMJWP6CD6K7E7CHWW
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/PAJ3LWO3OISW2YVQMJWP6CD6K7E7CHWW/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

The strtoul error handling is rather complicated and it is not only about
checking the return value. The possible error indicators are:

* endptr is NULL
* endptr is not pointing to end delimiter
* endptr is pointing at nptr (because it might have been an empty string)
* returned value is larger than the expected maximum value range

THe last two conditions were not checked even when it is a potential
problem for multiple places.

Fixes: df5c452a4469 ("batctl: Add elp_interval setting command")
Fixes: 74b6d3bd7763 ("batctl: Parse the arguments for gw_mode")
Fixes: cde0af829351 ("batctl: Add hop_penalty setting command")
Fixes: a319ec4dcbff ("batctl: Support generic netlink for isolation_mark command")
Fixes: 1ca604d5a0f2 ("batctl: add switch for setting multicast_fanout")
Fixes: c49893119205 ("batctl: Support generic netlink for orig_interval command")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 elp_interval.c     | 7 +++++--
 functions.c        | 2 +-
 gw_mode.c          | 8 ++++++--
 hop_penalty.c      | 7 +++++--
 isolation_mark.c   | 8 ++++----
 multicast_fanout.c | 7 +++++--
 orig_interval.c    | 7 +++++--
 7 files changed, 31 insertions(+), 15 deletions(-)

diff --git a/elp_interval.c b/elp_interval.c
index 7dcfa5f..71edf7f 100644
--- a/elp_interval.c
+++ b/elp_interval.c
@@ -22,6 +22,7 @@ static int parse_elp_interval(struct state *state, int argc, char *argv[])
 {
 	struct settings_data *settings = state->cmd->arg;
 	struct elp_interval_data *data = settings->data;
+	unsigned long elp_interval;
 	char *endptr;
 
 	if (argc != 2) {
@@ -29,12 +30,14 @@ static int parse_elp_interval(struct state *state, int argc, char *argv[])
 		return -EINVAL;
 	}
 
-	data->elp_interval = strtoul(argv[1], &endptr, 0);
-	if (!endptr || *endptr != '\0') {
+	elp_interval = strtoul(argv[1], &endptr, 0);
+	if (!endptr || *endptr != '\0' || endptr == argv[1] || elp_interval > UINT32_MAX) {
 		fprintf(stderr, "Error - the supplied argument is invalid: %s\n", argv[1]);
 		return -EINVAL;
 	}
 
+	data->elp_interval = elp_interval;
+
 	return 0;
 }
 
diff --git a/functions.c b/functions.c
index 5e1cb40..dc6bf75 100644
--- a/functions.c
+++ b/functions.c
@@ -970,7 +970,7 @@ bool parse_throughput(char *buff, const char *description, uint32_t *throughput)
 	}
 
 	lthroughput = strtoull(buff, &endptr, 10);
-	if (!endptr || *endptr != '\0') {
+	if (!endptr || *endptr != '\0' || endptr == buff) {
 		fprintf(stderr, "Invalid throughput speed for %s: %s\n",
 			description, buff);
 		return false;
diff --git a/gw_mode.c b/gw_mode.c
index 767a7f8..a7cc9a0 100644
--- a/gw_mode.c
+++ b/gw_mode.c
@@ -90,6 +90,7 @@ static int parse_gw_limit(char *buff)
 
 static int parse_gw(struct state *state, int argc, char *argv[])
 {
+	unsigned long sel_class;
 	char buff[256];
 	char *endptr;
 	int ret;
@@ -131,13 +132,16 @@ static int parse_gw(struct state *state, int argc, char *argv[])
 					      &gw_globals.sel_class))
 				return -EINVAL;
 		} else {
-			gw_globals.sel_class = strtoul(buff, &endptr, 0);
-			if (!endptr || *endptr != '\0') {
+			sel_class = strtoul(buff, &endptr, 0);
+			if (!endptr || *endptr != '\0' || endptr == buff ||
+			    sel_class > UINT32_MAX) {
 				fprintf(stderr,
 					"Error - unexpected argument for mode \"client\": %s\n",
 					buff);
 				return -EINVAL;
 			}
+
+			gw_globals.sel_class = sel_class;
 		}
 
 		gw_globals.sel_class_found = 1;
diff --git a/hop_penalty.c b/hop_penalty.c
index f22d36c..db727ac 100644
--- a/hop_penalty.c
+++ b/hop_penalty.c
@@ -22,6 +22,7 @@ static int parse_hop_penalty(struct state *state, int argc, char *argv[])
 {
 	struct settings_data *settings = state->cmd->arg;
 	struct hop_penalty_data *data = settings->data;
+	unsigned long hop_penalty;
 	char *endptr;
 
 	if (argc != 2) {
@@ -29,12 +30,14 @@ static int parse_hop_penalty(struct state *state, int argc, char *argv[])
 		return -EINVAL;
 	}
 
-	data->hop_penalty = strtoul(argv[1], &endptr, 0);
-	if (!endptr || *endptr != '\0') {
+	hop_penalty = strtoul(argv[1], &endptr, 0);
+	if (!endptr || *endptr != '\0' || endptr == argv[1] || hop_penalty > UINT8_MAX) {
 		fprintf(stderr, "Error - the supplied argument is invalid: %s\n", argv[1]);
 		return -EINVAL;
 	}
 
+	data->hop_penalty = hop_penalty;
+
 	return 0;
 }
 
diff --git a/isolation_mark.c b/isolation_mark.c
index cef4de0..a13e3db 100644
--- a/isolation_mark.c
+++ b/isolation_mark.c
@@ -23,10 +23,10 @@ static int parse_isolation_mark(struct state *state, int argc, char *argv[])
 {
 	struct settings_data *settings = state->cmd->arg;
 	struct isolation_mark_data *data;
+	unsigned long mark;
+	unsigned long mask;
 	char *mask_ptr;
 	char buff[256];
-	uint32_t mark;
-	uint32_t mask;
 	char *endptr;
 
 	if (argc != 2) {
@@ -50,13 +50,13 @@ static int parse_isolation_mark(struct state *state, int argc, char *argv[])
 		 * bitmask and not a prefix length
 		 */
 		mask = strtoul(mask_ptr, &endptr, 16);
-		if (!endptr || *endptr != '\0')
+		if (!endptr || *endptr != '\0' || endptr == mask_ptr || mask > UINT32_MAX)
 			goto inval_format;
 	}
 
 	/* the mark can be entered in any base */
 	mark = strtoul(buff, &endptr, 0);
-	if (!endptr || *endptr != '\0')
+	if (!endptr || *endptr != '\0' || endptr == buff || mark > UINT32_MAX)
 		goto inval_format;
 
 	data = settings->data;
diff --git a/multicast_fanout.c b/multicast_fanout.c
index 97d5e0a..6894266 100644
--- a/multicast_fanout.c
+++ b/multicast_fanout.c
@@ -22,6 +22,7 @@ static int parse_multicast_fanout(struct state *state, int argc, char *argv[])
 {
 	struct settings_data *settings = state->cmd->arg;
 	struct multicast_fanout_data *data;
+	unsigned long multicast_fanout;
 	char *endptr;
 
 	if (argc != 2) {
@@ -30,12 +31,14 @@ static int parse_multicast_fanout(struct state *state, int argc, char *argv[])
 	}
 
 	data = settings->data;
-	data->multicast_fanout = strtoul(argv[1], &endptr, 0);
-	if (!endptr || *endptr != '\0') {
+	multicast_fanout = strtoul(argv[1], &endptr, 0);
+	if (!endptr || *endptr != '\0' || endptr == argv[1] || multicast_fanout > UINT32_MAX) {
 		fprintf(stderr, "Error - the supplied argument is invalid: %s\n", argv[1]);
 		return -EINVAL;
 	}
 
+	data->multicast_fanout = multicast_fanout;
+
 	return 0;
 }
 
diff --git a/orig_interval.c b/orig_interval.c
index 970c752..e678d34 100644
--- a/orig_interval.c
+++ b/orig_interval.c
@@ -22,6 +22,7 @@ static int parse_orig_interval(struct state *state, int argc, char *argv[])
 {
 	struct settings_data *settings = state->cmd->arg;
 	struct orig_interval_data *data = settings->data;
+	unsigned long orig_interval;
 	char *endptr;
 
 	if (argc != 2) {
@@ -29,12 +30,14 @@ static int parse_orig_interval(struct state *state, int argc, char *argv[])
 		return -EINVAL;
 	}
 
-	data->orig_interval = strtoul(argv[1], &endptr, 0);
-	if (!endptr || *endptr != '\0') {
+	orig_interval = strtoul(argv[1], &endptr, 0);
+	if (!endptr || *endptr != '\0' || endptr == argv[1] || orig_interval > UINT32_MAX) {
 		fprintf(stderr, "Error - the supplied argument is invalid: %s\n", argv[1]);
 		return -EINVAL;
 	}
 
+	data->orig_interval = orig_interval;
+
 	return 0;
 }
 

-- 
2.47.3

