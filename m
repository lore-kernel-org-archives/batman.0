Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AFECE77188
	for <batman@archiver.kernel.org>; Sat,  4 Jan 2025 01:37:12 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id A47F583FCA
	for <batman@archiver.kernel.org>; Sat,  4 Jan 2025 02:37:10 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1735954630;
 b=oTzv+OPqqRaj2Yzx3SJ1XXfQQhz/CuDGHhosyAFz78rl8jR41i9l6LLKkGMHK0KJAuuXZ
 KZIdqid10ddbe9Y6oEvS0Fxq3O/a9MacQAy6GJd9vsuDUxWv/am6jfApT3DjWT0+N2nhC91
 OqiF9399FdK8BWVVIkh1gnnbDjvra6o=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1735954630; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=Ye1ZAVN9b1cPYd9MYW8AUhsT+Jffk84SXFBkGxo6GPA=;
 b=Av26LHSTVcghaYuKQ+8Okx4gLVp2pTtB1qIka1sSxdN8YfqQSVjytN6p6a8VVgH+63gsh
 BUv9sld0WSIZjoCklo8v+HtQx9jD1p/BIgKzTjnV5hB5JyMrw6bYcw6v0e6yefqm0aswhRD
 sR3DkyzIztVroqy6PjvwSrwUYonIoUA=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=pass header.d=gmail.com;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=gmail.com; arc=pass;
 dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Received: from mail-vk1-xa2a.google.com (mail-vk1-xa2a.google.com
 [IPv6:2607:f8b0:4864:20::a2a])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 6312E8172F
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sat,  4 Jan 2025 02:36:53 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1735954613;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=Ye1ZAVN9b1cPYd9MYW8AUhsT+Jffk84SXFBkGxo6GPA=;
	b=vrvuU5m3HKJEzTUHEVBnn3wLLpgTbKgFefgx7HfFKDM4/PySMrrpWOxmxGVYWOQJJPn4J9
	RU0DHeO8XfgjmrwVRCpDVIdxbEL2q4fWQZ+4g7My1XoplEGK8MAGh1tBVv6tkZV524PWi8
	5C44r07Vf/OiRFE1LcwuGlvrAQaQBwU=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=gmail.com header.s=20230601 header.b=jltnsZvb;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (diktynna.open-mesh.org: domain of noahbpeterson1997@gmail.com
 designates 2607:f8b0:4864:20::a2a as permitted sender)
 smtp.mailfrom=noahbpeterson1997@gmail.com
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1735954613; a=rsa-sha256;
	cv=none;
	b=BOA1bSY44BJPDLqaOhDwxzVUwWIesQXglHpg5UiiHthKmfudMbCI9x6xj+ofBS+7chvJPo
	cVq0Ty2O+Nj5lMGXWV21h8dl732qLzVP5ZQ6HUX4huBbr8knqOXFqvzN9gUElje0fyM202
	DUHE7Bkmq/lMJ/8YbneVJsgC4Lpom0k=
Received: by mail-vk1-xa2a.google.com with SMTP id
 71dfb90a1353d-5187aa2c97dso4300452e0c.2
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Fri, 03 Jan 2025 17:36:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735954611; x=1736559411;
 darn=lists.open-mesh.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ye1ZAVN9b1cPYd9MYW8AUhsT+Jffk84SXFBkGxo6GPA=;
        b=jltnsZvbgyh0BAp/c8J0p1Zhd1gRmr4ODq4jQk/0ami7fxfexr9hOD/WudYRrPMDwR
         v0cqT2es9d7W0iigEacXvWcB8/1eTGj16KehFwMsTRh+5klYH2oG97/4MbP74CpBr/ZF
         sdu1cEpAzagiJfos7eoCRjrPBA+AYetN52gP9tlq7Ku6p6TN1/YoyI1/+pBGYZcJ/UDl
         9si3+1rQ6PPp0Hd6RnL484a4dWLpftfgPVyFk35EXAgIoilj4wOC8WnybLJyN2/fgjbv
         XvuLA/N2xKi8k7DLYcpI0YZWE/49Q72n29A/HdkNuAJpxKyHs8HLVIuJbZnu+WggyB+6
         bvQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735954611; x=1736559411;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ye1ZAVN9b1cPYd9MYW8AUhsT+Jffk84SXFBkGxo6GPA=;
        b=DWNdrfW5cdVFPSgVkTYD/Wcc8E+FM4yLuVAnj14wB4iHVwBCnZgdhD+5umqab8ZS7M
         xr7k3Ihu9anI71TuXrwiIUmnwKS/QbZqbO5CQ4y5dp6KwZB2+a+xbQLLCT47FUWI+IHE
         IItfRcZIrLtA9wd5ssRX6DLE6Q+sKnRzvsCHlOfPo3jPineNkXn6dbyujUaow09TTCeY
         YwZ+ztkrkfVAKWxd+Vnvo5XgGWLl65giNP/AgTXvdqkqo28C6JD6QrbNORkxZ1+xs/V9
         8m0zzTefgjgxMe2WJFofk2TE8mFlDWwHNEhDugZk/rgHYDzPJlzGlpQ/4glOCfaz8FwB
         nXig==
X-Gm-Message-State: AOJu0Yx6p/bBvWX8/gd4zVE5DH4ttVDT2qVpAbTrZkjYrUwuQ49jlyfm
	hCjeb2jsO+IMMMHBzWRVBGPtll9g7R5SNu5meULDDC2eRZ6X9iFLAT/zAHiF
X-Gm-Gg: ASbGncvxXW3TfrKRiVbSL9PJJZ2HLeloewhtrzgVOUcgBlHkEBrzHr5QtiFvjcuqJPi
	7pJpjyBPMzDsHuR3TGC0xzmv9HGS9ToAQr+eWk6cwHaBDzm8iZVJ8DoQH9XxsSogabuPimgSHx7
	m77Yv65TzVrjqIX2YuoiZyOoGVEJ8NI7YJbWgMJXuwqcEj7M7CE9LZaeURmzJOuIjQiovrAJP/5
	VkUpPnX5o+2ExTSuRGUdUELtuP51FUV+w1++eIenUqqUtG2gX6+7cOTWMxrnRdE4e+yWZqCrChe
	Cbr/+fVCAIsprIn9uA==
X-Google-Smtp-Source: 
 AGHT+IFCKnTNUpdGav9y3yNOIL2epU5hZSlOF/PaBnttT+oUMrS2bW6ApCHPqpnZ35R4NprFQm2BKA==
X-Received: by 2002:a05:6102:41a5:b0:4af:fa1b:d8f9 with SMTP id
 ada2fe7eead31-4b2cc35dd44mr43113264137.7.1735954611166;
        Fri, 03 Jan 2025 17:36:51 -0800 (PST)
Received: from localhost.localdomain ([190.113.102.112])
        by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-4b2bf9aed62sm5804889137.12.2025.01.03.17.36.48
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 03 Jan 2025 17:36:50 -0800 (PST)
From: Noah Peterson <noahbpeterson1997@gmail.com>
X-Google-Original-From: Noah Peterson <NoahBPeterson1997@gmail.com>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Noah Peterson <NoahBPeterson1997@gmail.com>,
	Noah Peterson <noahbpeterson1997@gmail.com>
Subject: [PATCH] batctl: ping: Add subsecond precision to ping interval
Date: Fri,  3 Jan 2025 19:36:45 -0600
Message-Id: <20250104013645.53012-1-NoahBPeterson1997@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: QRLNK5FMPFADPKHJVQOYD7XGRRLY42SH
X-Message-ID-Hash: QRLNK5FMPFADPKHJVQOYD7XGRRLY42SH
X-MailFrom: noahbpeterson1997@gmail.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/QRLNK5FMPFADPKHJVQOYD7XGRRLY42SH/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Modify the batctl ping utility to accept both integer and floating-point
values for the interval between sending pings. This enhancement allows
specifying intervals with subsecond precision.

For example:
`sudo batctl ping aa:bb:cc:dd:ee:ff -i 0.5`

Signed-off-by: Noah Peterson <noahbpeterson1997@gmail.com>
---
v4: Rebasing on latest commit, reformatting into reverse X-mas tree order based
on feedback from Sven <sven@narfation.org>
v3: Rebasing on latest commit, reformatting code based on comments by Sven
<sven@narfation.org>
v2: Fixing use-after-free, adding a missing header file, noted by Sven
<sven@narfation.org>
---
 ping.c | 41 +++++++++++++++++++++++++++--------------
 1 file changed, 27 insertions(+), 14 deletions(-)

diff --git a/ping.c b/ping.c
index 14d9c21..f7ef210 100644
--- a/ping.c
+++ b/ping.c
@@ -19,6 +19,7 @@
 #include <stdint.h>
 #include <sys/select.h>
 #include <sys/time.h>
+#include <time.h>
 #include <netinet/if_ether.h>
 
 #include "batadv_packet_compat.h"
@@ -58,12 +59,16 @@ static int ping(struct state *state, int argc, char **argv)
 	struct batadv_icmp_packet_rr icmp_packet_out;
 	struct batadv_icmp_packet_rr icmp_packet_in;
 	uint8_t last_rr[BATADV_RR_LEN][ETH_ALEN];
+	struct timespec loop_interval = {0, 0};
 	struct ether_addr *dst_mac = NULL;
 	struct ether_addr *rr_mac = NULL;
 	int disable_translate_mac = 0;
+	double fractional_part = 0.0;
 	unsigned int seq_counter = 0;
 	unsigned int packets_out = 0;
 	unsigned int packets_in = 0;
+	double ping_interval = 0.0;
+	double integral_part = 0.0;
 	unsigned int packets_loss;
 	struct bat_host *bat_host;
 	struct bat_host *rr_host;
@@ -101,10 +106,18 @@ static int ping(struct state *state, int argc, char **argv)
 			ping_usage();
 			return EXIT_SUCCESS;
 		case 'i':
-			loop_interval = strtol(optarg, NULL, 10);
-			if (loop_interval < 1)
-				loop_interval = 1;
-			found_args += ((*((char *)(optarg - 1)) == optchar) ? 1 : 2);
+			errno = 0;
+			ping_interval = strtod(optarg, &end);
+			if (errno) {
+				fprintf(stderr, "Error - invalid ping interval '%s'\n", optarg);
+				goto out;
+			} else {
+				ping_interval = fmax(ping_interval, 0.001);
+			}
+			fractional_part = modf(ping_interval, &integral_part);
+			loop_interval.tv_sec = (time_t)integral_part;
+			loop_interval.tv_nsec = (long)(fractional_part * 1000000000l);
+			found_args += ((*((char*)(optarg - 1)) == optchar ) ? 1 : 2);
 			break;
 		case 't':
 			timeout = strtol(optarg, NULL, 10);
@@ -178,7 +191,7 @@ static int ping(struct state *state, int argc, char **argv)
 	}
 
 	printf("PING %s (%s) %zu(%zu) bytes of data\n", dst_string, mac_string,
-	       packet_len, packet_len + 28);
+		packet_len, packet_len + 28);
 
 	while (!is_aborted) {
 		tv.tv_sec = timeout;
@@ -224,7 +237,7 @@ static int ping(struct state *state, int argc, char **argv)
 
 		if ((size_t)read_len < packet_len) {
 			printf("Warning - dropping received packet as it is smaller than expected (%zu): %zd\n",
-			       packet_len, read_len);
+				packet_len, read_len);
 			goto sleep;
 		}
 
@@ -236,10 +249,10 @@ static int ping(struct state *state, int argc, char **argv)
 		case BATADV_ECHO_REPLY:
 			time_delta = end_timer();
 			printf("%zd bytes from %s icmp_seq=%hu ttl=%d time=%.2f ms",
-			       read_len, dst_string,
-			       ntohs(icmp_packet_in.seqno),
-			       icmp_packet_in.ttl,
-			       time_delta);
+					read_len, dst_string,
+					ntohs(icmp_packet_in.seqno),
+					icmp_packet_in.ttl,
+					time_delta);
 
 			if (read_len == sizeof(struct batadv_icmp_packet_rr)) {
 				if (last_rr_cur == icmp_packet_in.rr_cur &&
@@ -302,8 +315,8 @@ static int ping(struct state *state, int argc, char **argv)
 		if (loop_count == 0)
 			continue;
 
-		if (loop_interval > 0)
-			sleep(loop_interval);
+		if (loop_interval.tv_sec > 0 || loop_interval.tv_nsec > 0)
+			nanosleep(&loop_interval, NULL);
 		else if ((tv.tv_sec != 0) || (tv.tv_usec != 0))
 			select(0, NULL, NULL, NULL, &tv);
 	}
@@ -328,9 +341,9 @@ static int ping(struct state *state, int argc, char **argv)
 
 	printf("--- %s ping statistics ---\n", dst_string);
 	printf("%u packets transmitted, %u received, %u%% packet loss\n",
-	       packets_out, packets_in, packets_loss);
+		packets_out, packets_in, packets_loss);
 	printf("rtt min/avg/max/mdev = %.3f/%.3f/%.3f/%.3f ms\n",
-	       min, avg, max, mdev);
+		min, avg, max, mdev);
 
 	if (packets_in)
 		ret = EXIT_SUCCESS;
-- 
2.39.5 (Apple Git-154)

