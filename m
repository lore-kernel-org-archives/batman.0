Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3680E77188
	for <batman@archiver.kernel.org>; Sat,  4 Jan 2025 01:28:22 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 58D3183F98
	for <batman@archiver.kernel.org>; Sat,  4 Jan 2025 02:28:20 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1735954100;
 b=3hRZnT7nTCFy4l/W3SygPpHkNWCWJg71lnA/B3IRYw2XJlK576ZXkXGxU+WfDoMIOpon2
 DVedPla1pjaJT8eJbo0hYtWnqX4zqq1jy+Aoq/+bdQR4dLzB9sUMwGhizJ4CgfrDCEQR2/e
 /rC9Sf0kEkBdFyR92bEnMfABbi/e1S0=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1735954100; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=thbhgAHpm+/8igOJzq3J35wotoai9NmsI9Um0UXnCLM=;
 b=IDvx11FEfOVr6uFokx3zMz6W5p+r4RCGmh/mn1cUa34RCN67JlfhK8vtYQEB6edNqbPa4
 05s7coS3KqQlSgJ0jcKdpxqh9dk9acrnjK07Cz7okcurBbjyPQq7aoYiOzl6ASG+Z8u5eLx
 WzCVSAvhEiNz0SXtHstztyVdkSArTds=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=pass header.d=gmail.com;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=gmail.com; arc=pass;
 dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com
 [IPv6:2607:f8b0:4864:20::e2f])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 7E20781663
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sat,  4 Jan 2025 02:28:00 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1735954080;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=thbhgAHpm+/8igOJzq3J35wotoai9NmsI9Um0UXnCLM=;
	b=bKN52GwCRZvqXcALH80SppVlhprDjXsTqFjg37bRx7op5vRdYyMYsuTTTH7P2IIVGHj4/n
	c4Q1YAt20Hc2Ao3GWrNmCc9IKCt9Su8LT/On3OLXSadwh5LAQDNrXq0NKzHwa4YJ2jAov/
	736c95rZsKiO7TeuywEx3o49xbj1ETM=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=gmail.com header.s=20230601 header.b="e/25Jzm6";
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (diktynna.open-mesh.org: domain of noahbpeterson1997@gmail.com
 designates 2607:f8b0:4864:20::e2f as permitted sender)
 smtp.mailfrom=noahbpeterson1997@gmail.com
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1735954080; a=rsa-sha256;
	cv=none;
	b=2dl9jXmu5gDdYe7wBsnxRR3f+MNn0nFYqzPV0p/Vde3YVACTdgXAw3YyhiY3lFL32+UPCT
	I456C6UIYuoS2PURRsEvesT7CY1h0dSvd5cC02XnieOVbHnMKiyH/h5SLZDrY6ezeL8HIU
	q8fVSEo81BHMi4WbT3xDVc/rPeneROI=
Received: by mail-vs1-xe2f.google.com with SMTP id
 ada2fe7eead31-4afd56903b7so3224480137.1
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Fri, 03 Jan 2025 17:28:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735954079; x=1736558879;
 darn=lists.open-mesh.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=thbhgAHpm+/8igOJzq3J35wotoai9NmsI9Um0UXnCLM=;
        b=e/25Jzm6USyOlr4uFMy0oKnApV4J9gaLgvN20JfBxl35QxotX6uMDbGVDfyl4rmS/n
         SqoL3z+5DSXPksdcd2pUsgc0qxKnW/VSVriks4O7TX3++nKSDJ2qunpWIWWY179G0qxA
         caJJDW4VYWAxs3mc7g93N46UVQwCc4NyDukY/PzAEtOfpECrX09EX49o9JXJfX6P5UZi
         /OlfrMbUq+CZEYaFoZ8GtvgX1cf1TsAPNQYdK6IoMMhnwhATFoKfxt55SA8SLvhZNOPS
         4JdlxyuHSq+vAtMlVyT2if5xuWluUzc9NJFCLumj9TIIv1C1gW7aRndauF2Yd2Uc0a1J
         dizQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735954079; x=1736558879;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=thbhgAHpm+/8igOJzq3J35wotoai9NmsI9Um0UXnCLM=;
        b=HswBvx38ek0LIdoRHkgnuACfJQi1snlxsjwqqS9CzbALelchgPDkDh82zFdL/Pd1dI
         ctuajVA1EjyzvVySqRNGV8MMyXPQqetDFwUa7kSQ3gliBfbdszn7DlGOXWX0BJGVQzrm
         rl7s1En4QcA20ypEhNYk3tmovekuVjPYmraPNaFyj6psIZ4/udyAg0FPxdl7rqylupzA
         JhbkwEjgr+fW7snsmYjmjm21G0NOmtUJbc3H+eOinJV476eB4+Uw8W2dpvb7lklQ3En8
         cJoFgmSgSqU5w4WVBlnjbcKKdG8jHAsOAVVx+JeUeAZz9kGsADGVLLtXBVQYywAVoE1n
         9TMw==
X-Gm-Message-State: AOJu0Yzw1LjwR8p8jdGbo8qVepAz8RkuVLrF30MEb7fzZbc4AD2NZSce
	RUPheAmupQESoYZs7l2qEl2nmldkHMlf44kwMEMkltn9A7Thh0PRJa0e7Qgy
X-Gm-Gg: ASbGncu2CWxOp4y5bV19lFj6aVIOEnFL2fX79J6PQygi5p96s/jF3HwA/FFl1wFkw9d
	+olzAAJvYlxgudc7l0cMaQLZRtkiq35lvGtuniL0chUW5289Bch4Hrb5tWCMzaAF88KR6nArZJT
	TTNowsXLLeo2X3a8yd64nVrvKt7d29iUN/m2UuYX13GJwLovXzs3p4iNTxu0i5Ema6gsQwmg+o6
	MPq8zGFvF3qYCb7/FBET0JEw2s+RAt/8jxo/NUOgXIHaU7jpGrtIylOLB1XxvbVZr+HOh9U8H2n
	R1poHSlHslfrh126OQ==
X-Google-Smtp-Source: 
 AGHT+IFOLkQIOQUzk1X9nWVW5MHvFQPHJCa9bmzhIuFRykLulG7QQrfoq5p0ivrezS4giY3CcgFH7A==
X-Received: by 2002:a05:6102:548f:b0:4b1:1a11:95f8 with SMTP id
 ada2fe7eead31-4b2cc3785ccmr43666381137.11.1735954078821;
        Fri, 03 Jan 2025 17:27:58 -0800 (PST)
Received: from localhost.localdomain ([190.113.102.112])
        by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-4b2bfa8d62fsm6010894137.22.2025.01.03.17.27.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 03 Jan 2025 17:27:57 -0800 (PST)
From: Noah Peterson <noahbpeterson1997@gmail.com>
X-Google-Original-From: Noah Peterson <NoahBPeterson1997@gmail.com>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Noah Peterson <NoahBPeterson1997@gmail.com>,
	Noah Peterson <noahbpeterson1997@gmail.com>
Subject: [PATCH] batctl: ping: Add subsecond precision to ping interval
Date: Fri,  3 Jan 2025 19:27:50 -0600
Message-Id: <20250104012750.52056-1-NoahBPeterson1997@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: ONYLCJUI6BYEJV5UVR7QCWYL44BME6Q7
X-Message-ID-Hash: ONYLCJUI6BYEJV5UVR7QCWYL44BME6Q7
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/ONYLCJUI6BYEJV5UVR7QCWYL44BME6Q7/>
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
v3: Rebasing on latest commit, reformatting code based on comments by Sven
<sven@narfation.org>
v2: Fixing use-after-free, adding a missing header file, noted by Sven
<sven@narfation.org>
---
 ping.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/ping.c b/ping.c
index 52bce4d..9142a5a 100644
--- a/ping.c
+++ b/ping.c
@@ -21,6 +21,7 @@
 #include <stdint.h>
 #include <sys/select.h>
 #include <sys/time.h>
+#include <time.h>
 #include <netinet/if_ether.h>
 
 #include "batadv_packet_compat.h"
@@ -65,14 +66,19 @@ static int ping(struct state *state, int argc, char **argv)
 	struct bat_host *bat_host, *rr_host;
 	ssize_t read_len;
 	int ret = EXIT_FAILURE, res, optchar, found_args = 1;
-	int loop_count = -1, loop_interval = 0, timeout = 1, rr = 0, i;
+	int loop_count = -1, timeout = 1, rr = 0, i;
 	unsigned int seq_counter = 0, packets_out = 0, packets_in = 0, packets_loss;
 	char *dst_string, *mac_string, *rr_string;
+	char *end = NULL;
 	double time_delta;
+	double ping_interval = 0.0;
+	double integral_part = 0.0;
+	double fractional_part = 0.0;
 	float min = 0.0, max = 0.0, avg = 0.0, mdev = 0.0;
 	uint8_t last_rr_cur = 0, last_rr[BATADV_RR_LEN][ETH_ALEN];
 	size_t packet_len;
 	int disable_translate_mac = 0;
+	struct timespec loop_interval = {0, 0};
 
 	while ((optchar = getopt(argc, argv, "hc:i:t:RT")) != -1) {
 		switch (optchar) {
@@ -86,9 +92,17 @@ static int ping(struct state *state, int argc, char **argv)
 			ping_usage();
 			return EXIT_SUCCESS;
 		case 'i':
-			loop_interval = strtol(optarg, NULL , 10);
-			if (loop_interval < 1)
-				loop_interval = 1;
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
 			found_args += ((*((char*)(optarg - 1)) == optchar ) ? 1 : 2);
 			break;
 		case 't':
@@ -285,9 +299,8 @@ static int ping(struct state *state, int argc, char **argv)
 		/* skip last sleep in case no more packets will be sent out */
 		if (loop_count == 0)
 			continue;
-
-		if (loop_interval > 0)
-			sleep(loop_interval);
+		if (loop_interval.tv_sec > 0 || loop_interval.tv_nsec > 0)
+			nanosleep(&loop_interval, NULL);
 		else if ((tv.tv_sec != 0) || (tv.tv_usec != 0))
 			select(0, NULL, NULL, NULL, &tv);
 	}
-- 
2.39.5 (Apple Git-154)

