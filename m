Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79463CD98F0
	for <batman@archiver.kernel.org>; Sun, 21 Jun 2026 14:25:19 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 0625280DE1
	for <batman@archiver.kernel.org>; Sun, 21 Jun 2026 16:25:18 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1782051918;
 b=mWkK3Xzj9ydPbxmWS63Wz3dfBCIy2SMKTWZm6RZplDjiFmvYii9V7jQj7gtBxlaI9hfMS
 6uQ08Z3rnPL62gdqG+W3xp3/FveUjcI2WqCy1aRTYD4bcKo4JB35JW1q0HziLjpmb2tKL0w
 UgGv9vkiyGq2c2S/jbyMW6t/tBo7EpI=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1782051918; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=3o4zArznFRQYqQ1IoWs5w2Ke/UAekbfT1oUeBE760YA=;
 b=qYBwbccphBYvVQfhVtl+p2MOAdmcfBoBj6VGLwRgA6xAK88HO2Yj5wfp3YJIW4dy1BkU+
 ln6T6UXPajjvMOZ+ci16dM+I0W8YADL4RXTAegLrMxpYdvf3A7LrbeyFVhlZNDdTdeQwIUi
 8SUzkNd50GRgY38hp805JT0y7ur/pVo=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 7A03380C85
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 21 Jun 2026 16:24:15 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1782051860;
	b=D+3V51/aAWTnV8gptLt5O4sGLH6EmXxAG2CrUkGLMH6Lll4twp4Bo/h8hns1DC6cMKzYoT
	NIV6QhwnDPcWaPLHDgxyFIiShsc4mil00AEcjRHfulSJt2Ixda8ofMXlByPftDSNw1BElf
	wpEB3XstWOSfTGRWZjYO1SE10Gm16Hk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1782051860;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=3o4zArznFRQYqQ1IoWs5w2Ke/UAekbfT1oUeBE760YA=;
	b=Oy3snTEXuDz64CVTh1ojIZeyhU34PEIJ9fVYeN+lIjnnW8Y6fhxyQmFL8uVAP9TamdZjP4
	TpiH8jtEujdwJUshZiiS3BBOUeaJiuSUY6H1Jcg2E6Y0Kg1MBYs1Rde5zyjAmkC8MbKVs1
	04n3oZP/B5bQNTZfGRg/9v1TLgio35E=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=d7DdHDB2;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id CC37320059;
	Sun, 21 Jun 2026 14:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1782051854;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3o4zArznFRQYqQ1IoWs5w2Ke/UAekbfT1oUeBE760YA=;
	b=d7DdHDB2yGJgMZH5yZY934qQlUvvIv0ai5bEK+zrjK8ucLXGiU487TWDjHCA9+kJz+P/E7
	aveu3oAnaHGybq75MtF1be6VcLdMzK8PrcEieIA/LhoPkMewOodqJiaArfR1b9JaWYupba
	Zk1oEEXmg6QDFOI+WnreGAiEi6TttAo=
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 21 Jun 2026 16:23:51 +0200
Subject: [PATCH 01/28] batctl: fix parsing of parameters with arguments
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260621-bugfixes-v1-1-b09736288a4a@narfation.org>
References: <20260621-bugfixes-v1-0-b09736288a4a@narfation.org>
In-Reply-To: <20260621-bugfixes-v1-0-b09736288a4a@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=9539; i=sven@narfation.org;
 h=from:subject:message-id; bh=xt91u1gnOOWU9Rv3+C6l0DNeJU0O3A/gPnbxuk0/H7I=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFnmX1jauxMu8tYbs/8NFj1WWcdiNyMoaImODLvIC7nz1
 tJmT6U7SlkYxLgYZMUUWfZcyT+/mf2t/OdpH4/CzGFlAhnCwMUpABNZU8fwh8csIzWPuf/ERJ9Z
 72rvrwwX5pj04/B5HTP/qKKN72I8Gxj+KSt//fKs6O6W0Fk6p1vD3QKYGDfIH5tXzyZyalvfb59
 8BgA=
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: CEM6DRUUJBF3M4MFAQ6C267F2FNGURM6
X-Message-ID-Hash: CEM6DRUUJBF3M4MFAQ6C267F2FNGURM6
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/CEM6DRUUJBF3M4MFAQ6C267F2FNGURM6/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

If using a getopt argument with an argument, it can be supplied via:

* -m asd
* -m=asd
* -masd

Only the first version is correctly handled by the found_args
implementation (without causing undefined behavior). But it can be instead
simplified and fixed at the same time by directly using the optind variable
from getopt.

Fixes: 87ade2869cf3 ("add interval and loop count options")
Fixes: 3bdfc388e74b ("implement simple tcpdump, first only batman packets")
Fixes: ece05e1c4c1f ("[batctl] bisect (a tool to analyze logfiles) added")
Fixes: f3c9cf9e730e ("source out calculation of round trip time to functions.c add abbreviation for modules, example ping = p add traceroute module, not complete")
Fixes: f109b3473f86 ("batctl: introduce throughput meter support")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 bisect_iv.c       | 15 ++++-----------
 main.c            |  2 +-
 ping.c            | 10 ++--------
 tcpdump.c         | 13 ++++---------
 throughputmeter.c |  7 ++-----
 traceroute.c      |  7 ++-----
 6 files changed, 15 insertions(+), 39 deletions(-)

diff --git a/bisect_iv.c b/bisect_iv.c
index d4d507a..5da5bf1 100644
--- a/bisect_iv.c
+++ b/bisect_iv.c
@@ -1495,7 +1495,6 @@ static int bisect_iv(struct state *state __maybe_unused, int argc, char **argv)
 	int num_parsed_files;
 	long long tmp_seqno;
 	char orig[NAME_LEN];
-	int found_args = 1;
 	char *dash_ptr;
 	int optchar;
 	int res;
@@ -1510,19 +1509,15 @@ static int bisect_iv(struct state *state __maybe_unused, int argc, char **argv)
 			return EXIT_SUCCESS;
 		case 'l':
 			loop_orig_ptr = optarg;
-			found_args += ((*((char *)(optarg - 1)) == optchar) ? 1 : 2);
 			break;
 		case 'n':
 			read_opt &= ~USE_BAT_HOSTS;
-			found_args += 1;
 			break;
 		case 'o':
 			filter_orig_ptr = optarg;
-			found_args += ((*((char *)(optarg - 1)) == optchar) ? 1 : 2);
 			break;
 		case 'r':
 			rt_orig_ptr = optarg;
-			found_args += ((*((char *)(optarg - 1)) == optchar) ? 1 : 2);
 			break;
 		case 's':
 			dash_ptr = strchr(optarg, '-');
@@ -1549,11 +1544,9 @@ static int bisect_iv(struct state *state __maybe_unused, int argc, char **argv)
 				*dash_ptr = '-';
 			}
 
-			found_args += ((*((char *)(optarg - 1)) == optchar) ? 1 : 2);
 			break;
 		case 't':
 			trace_orig_ptr = optarg;
-			found_args += ((*((char *)(optarg - 1)) == optchar) ? 1 : 2);
 			break;
 		default:
 			bisect_iv_usage();
@@ -1561,7 +1554,7 @@ static int bisect_iv(struct state *state __maybe_unused, int argc, char **argv)
 		}
 	}
 
-	if (argc <= found_args + 1) {
+	if (argc <= optind + 1) {
 		fprintf(stderr, "Error - need at least 2 log files to compare\n");
 		bisect_iv_usage();
 		goto err;
@@ -1624,13 +1617,13 @@ static int bisect_iv(struct state *state __maybe_unused, int argc, char **argv)
 			goto err;
 	}
 
-	while (argc > found_args) {
-		res = parse_log_file(argv[found_args]);
+	while (argc > optind) {
+		res = parse_log_file(argv[optind]);
 
 		if (res > 0)
 			num_parsed_files++;
 
-		found_args++;
+		optind++;
 	}
 
 	if (num_parsed_files < 2) {
diff --git a/main.c b/main.c
index da4cbb6..79ed4ef 100644
--- a/main.c
+++ b/main.c
@@ -357,7 +357,7 @@ int main(int argc, char **argv)
 			fprintf(stderr,
 				"Warning - option -m was deprecated and will be removed in the future\n");
 
-			state.arg_iface = argv[2];
+			state.arg_iface = optarg;
 			break;
 		case 'v':
 			version();
diff --git a/ping.c b/ping.c
index b61bca4..4dbbada 100644
--- a/ping.c
+++ b/ping.c
@@ -75,7 +75,6 @@ static int ping(struct state *state, int argc, char **argv)
 	uint8_t last_rr_cur = 0;
 	int ret = EXIT_FAILURE;
 	int loop_count = -1;
-	int found_args = 1;
 	size_t packet_len;
 	struct timeval tv;
 	double time_delta;
@@ -100,7 +99,6 @@ static int ping(struct state *state, int argc, char **argv)
 			loop_count = strtol(optarg, NULL, 10);
 			if (loop_count < 1)
 				loop_count = -1;
-			found_args += ((*((char *)(optarg - 1)) == optchar) ? 1 : 2);
 			break;
 		case 'h':
 			ping_usage();
@@ -117,21 +115,17 @@ static int ping(struct state *state, int argc, char **argv)
 			fractional_part = modf(ping_interval, &integral_part);
 			loop_interval.tv_sec = (time_t)integral_part;
 			loop_interval.tv_nsec = (long)(fractional_part * 1000000000l);
-			found_args += ((*((char *)(optarg - 1)) == optchar) ? 1 : 2);
 			break;
 		case 't':
 			timeout = strtol(optarg, NULL, 10);
 			if (timeout < 1)
 				timeout = 1;
-			found_args += ((*((char *)(optarg - 1)) == optchar) ? 1 : 2);
 			break;
 		case 'R':
 			rr = 1;
-			found_args++;
 			break;
 		case 'T':
 			disable_translate_mac = 1;
-			found_args += 1;
 			break;
 		default:
 			ping_usage();
@@ -139,13 +133,13 @@ static int ping(struct state *state, int argc, char **argv)
 		}
 	}
 
-	if (argc <= found_args) {
+	if (optind >= argc) {
 		fprintf(stderr, "Error - target mac address or bat-host name not specified\n");
 		ping_usage();
 		return EXIT_FAILURE;
 	}
 
-	dst_string = argv[found_args];
+	dst_string = argv[optind];
 	bat_hosts_init(0);
 	bat_host = bat_hosts_find_by_name(dst_string);
 
diff --git a/tcpdump.c b/tcpdump.c
index eb7524e..3409e59 100644
--- a/tcpdump.c
+++ b/tcpdump.c
@@ -1493,7 +1493,6 @@ static int tcpdump(struct state *state __maybe_unused, int argc, char **argv)
 	fd_set tmp_wait_sockets;
 	int ret = EXIT_FAILURE;
 	fd_set wait_sockets;
-	int found_args = 1;
 	struct timeval tv;
 	int max_sock = 0;
 	ssize_t read_len;
@@ -1507,26 +1506,22 @@ static int tcpdump(struct state *state __maybe_unused, int argc, char **argv)
 		switch (optchar) {
 		case 'c':
 			read_opt |= COMPAT_FILTER;
-			found_args += 1;
 			break;
 		case 'h':
 			tcpdump_usage();
 			return EXIT_SUCCESS;
 		case 'n':
 			read_opt &= ~USE_BAT_HOSTS;
-			found_args += 1;
 			break;
 		case 'p':
 			tmp = strtol(optarg, NULL, 10);
 			if (tmp > 0 && tmp <= dump_level_all)
 				dump_level = tmp;
-			found_args += ((*((char *)(optarg - 1)) == optchar) ? 1 : 2);
 			break;
 		case 'x':
 			tmp = strtol(optarg, NULL, 10);
 			if (tmp > 0 && tmp <= dump_level_all)
 				dump_level &= ~tmp;
-			found_args += ((*((char *)(optarg - 1)) == optchar) ? 1 : 2);
 			break;
 		default:
 			tcpdump_usage();
@@ -1534,7 +1529,7 @@ static int tcpdump(struct state *state __maybe_unused, int argc, char **argv)
 		}
 	}
 
-	if (argc <= found_args) {
+	if (optind >= argc) {
 		fprintf(stderr, "Error - target interface not specified\n");
 		tcpdump_usage();
 		return EXIT_FAILURE;
@@ -1549,8 +1544,8 @@ static int tcpdump(struct state *state __maybe_unused, int argc, char **argv)
 	INIT_LIST_HEAD(&dump_if_list);
 	FD_ZERO(&wait_sockets);
 
-	while (argc > found_args) {
-		dump_if = create_dump_interface(argv[found_args]);
+	while (optind < argc) {
+		dump_if = create_dump_interface(argv[optind]);
 		if (!dump_if)
 			goto out;
 
@@ -1559,7 +1554,7 @@ static int tcpdump(struct state *state __maybe_unused, int argc, char **argv)
 
 		FD_SET(dump_if->raw_sock, &wait_sockets);
 		list_add_tail(&dump_if->list, &dump_if_list);
-		found_args++;
+		optind++;
 	}
 
 	while (!is_aborted) {
diff --git a/throughputmeter.c b/throughputmeter.c
index bfd59a5..d670c51 100644
--- a/throughputmeter.c
+++ b/throughputmeter.c
@@ -326,7 +326,6 @@ static int throughputmeter(struct state *state, int argc, char **argv)
 	struct bat_host *bat_host;
 	int ret = EXIT_FAILURE;
 	uint64_t throughput;
-	int found_args = 1;
 	uint32_t time = 0;
 	char *dst_string;
 	int optchar;
@@ -334,12 +333,10 @@ static int throughputmeter(struct state *state, int argc, char **argv)
 	while ((optchar = getopt(argc, argv, "t:n")) != -1) {
 		switch (optchar) {
 		case 't':
-			found_args += 2;
 			time = strtoul(optarg, NULL, 10);
 			break;
 		case 'n':
 			read_opt &= ~USE_BAT_HOSTS;
-			found_args += 1;
 			break;
 		default:
 			tp_meter_usage();
@@ -347,12 +344,12 @@ static int throughputmeter(struct state *state, int argc, char **argv)
 		}
 	}
 
-	if (argc <= found_args) {
+	if (optind >= argc) {
 		tp_meter_usage();
 		return EXIT_FAILURE;
 	}
 
-	dst_string = argv[found_args];
+	dst_string = argv[optind];
 	bat_hosts_init(read_opt);
 	bat_host = bat_hosts_find_by_name(dst_string);
 
diff --git a/traceroute.c b/traceroute.c
index a0fb925..8f23128 100644
--- a/traceroute.c
+++ b/traceroute.c
@@ -48,7 +48,6 @@ static int traceroute(struct state *state, int argc, char **argv)
 	int ret = EXIT_FAILURE;
 	char dst_reached = 0;
 	int seq_counter = 0;
-	int found_args = 1;
 	struct timeval tv;
 	ssize_t read_len;
 	char *dst_string;
@@ -65,11 +64,9 @@ static int traceroute(struct state *state, int argc, char **argv)
 			return EXIT_SUCCESS;
 		case 'n':
 			read_opt &= ~USE_BAT_HOSTS;
-			found_args += 1;
 			break;
 		case 'T':
 			disable_translate_mac = 1;
-			found_args += 1;
 			break;
 		default:
 			traceroute_usage();
@@ -77,13 +74,13 @@ static int traceroute(struct state *state, int argc, char **argv)
 		}
 	}
 
-	if (argc <= found_args) {
+	if (optind >= argc) {
 		fprintf(stderr, "Error - target mac address or bat-host name not specified\n");
 		traceroute_usage();
 		return EXIT_FAILURE;
 	}
 
-	dst_string = argv[found_args];
+	dst_string = argv[optind];
 	bat_hosts_init(read_opt);
 	bat_host = bat_hosts_find_by_name(dst_string);
 

-- 
2.47.3

