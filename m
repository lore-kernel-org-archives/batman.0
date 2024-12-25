Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9F54E7718B
	for <batman@archiver.kernel.org>; Wed, 25 Dec 2024 03:27:58 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id E17D183F27
	for <batman@archiver.kernel.org>; Wed, 25 Dec 2024 04:27:56 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1735097276;
 b=V/M33UG5pOYEGu/9TW1peZ/94ZbYkmHHeayqi1stjQIcoroC1JsN15e2Rf6MIfxA2jQIf
 jtoBKHlAxmIE7fVyUDQvVgRtatOcNf86LEYwYUQxrcaFYJuJSELiQKcv4Xi9sDl+OzwmzQG
 ZO7MntVbdIutZRWAuBaKnBca82mjMs8=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1735097276; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=NvgZ92FSdkcPJBwYWIjRdNT6UkBT6gK6Zc4RTsuFvkw=;
 b=FvkrLHtEw6WWWa/NuMj+XOhHCi/sF4t1WN3ZyQOFYJiLp7tgjVftaU7llYE6TfINpEBIU
 1C1S/+O4iphxkthlW1gSM5pIr5dMiMeEmaHvpVAycOP6WUB3L77mBBHP/PpAZW6p/X3xnnJ
 Syx8XngKXcLhIvutfaYGYmpNHwCU+Zw=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=pass header.d=gmail.com;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=gmail.com; arc=pass;
 dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com
 [IPv6:2607:f8b0:4864:20::b32])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id A3F9A819B8
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 25 Dec 2024 04:27:33 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1735097253;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=NvgZ92FSdkcPJBwYWIjRdNT6UkBT6gK6Zc4RTsuFvkw=;
	b=UHSJfWDnXKMga8ZvrIBpJGAis826K3yDNftz1+thE4xOdRZoWUie0U5HcO+VXbdbk/WegY
	ARzPvS14xESYFGXpO14VODb7eZ1s4tBuGk5Pyqg0cgwqpRELcgk5K8ADiqKlvcw5ImYrP3
	fiEUj/1OkQGvHRAxC6Z/SOa+3SsIHHU=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=gmail.com header.s=20230601 header.b=m1UTZYSi;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (diktynna.open-mesh.org: domain of noahbpeterson1997@gmail.com
 designates 2607:f8b0:4864:20::b32 as permitted sender)
 smtp.mailfrom=noahbpeterson1997@gmail.com
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1735097253; a=rsa-sha256;
	cv=none;
	b=fGc1cztVtIVnK4EC4Wndoxzhy7qe+Wt380Z8Oqyy0PUasOZnQKRr0Vog8q7YKr8kLNWC0F
	Z0t6dx+I4DlFFEcrvek07RhwvDv+z0HKbI9+hewbfO41qTiX6SLj3y/QtCePlW+GqNVJhc
	TPetH8PMKQLyYw/5v2OfpPO1QFA5qCY=
Received: by mail-yb1-xb32.google.com with SMTP id
 3f1490d57ef6-e3a1cfeb711so4388648276.0
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Tue, 24 Dec 2024 19:27:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735097252; x=1735702052;
 darn=lists.open-mesh.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NvgZ92FSdkcPJBwYWIjRdNT6UkBT6gK6Zc4RTsuFvkw=;
        b=m1UTZYSiMWlEE547kbDCRyKgxOltChqB2LlLhcUNbASm2vqiC4cCC6gEMrZKk0N9Gp
         lK9ITOhnajsqzD8wnQBmjtYtDuAlvWl5nNAAKQSB40yhAsWpsSmGcVcZhQ2M9IzZrFSU
         Fmi/cmah5kzpm+1pl8gtnL0wH5Nivpo4pKrEuXKRAqZqZ1inWEj7mJz8LZyyLoE1gjkz
         TPCtb+TT2dYXzO7OrRWlIkDhlBNNZ0q/TFr7gSu6/LIN20JQ947Q1oCatvHyB9l/cRtr
         g18dMTPOBRTRhwMkP9dHZb5+A0m7/LPjT/pSwasWXhq+Ynr+JBIz7hiYMtMimDA1rK+0
         Fxog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735097252; x=1735702052;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NvgZ92FSdkcPJBwYWIjRdNT6UkBT6gK6Zc4RTsuFvkw=;
        b=b76DmOnn4gAB9w4t73DF0JnuTdUsG/hzCrRf2jCxHvu/0zfjuqGTiUcVwoo24EhEn8
         guM8Ioh7sD/qq1ns/QWTSeP3cFLa7neav0l2QKet1ub4gt7rnCPcXHBQO0JX80u+vFXn
         NwSaIJ/iHMLplL9X3NDfKBGj/VqcypHAoV8R01GmnCMxwELgSL6XuzYz1kjccBsVOTA+
         Wz0SUAG3UrgUunB69DI+6yN8q7wL+CH2dtkXUfjIF2KsipUpdq47U1i92QuIV1dmMv+b
         D2+o6o8XD74b4O5UvEMSfP2IJvaFZCgT9M4gL2nDtJJw4fviQx7XJ/CANZyb0ObVVdug
         Lnhw==
X-Gm-Message-State: AOJu0Yz4gt0YmfxzR9LtUbsvKJOkB16r7qUvPDR661Z1grhbbc5yFAUt
	86CJDjeIZrQLt5+IsHxv15dda7jr1ucBwpMcAwUbu8b0eRZJ7pDEI7SaTiEA1G4=
X-Gm-Gg: ASbGncsfaBhwq4yNQKWDaQlpZJgDYz6Rz7+Glxx4Q+iXg9FkkEi+5cXAkHtFONAQ0zR
	6syihJB4mTJrUY/wERUHuWyvjAD3RGwdK3y/9NekvFuglDD2x1eOUgBnBREJ5+J7WABBpBOiORQ
	AHkWJj9NMA3eThazAYvcTPqwJ2QRAmg0N0OuboIphVKUrWVYnDWqJ6kbaMcm0JMjksd2vP0waRY
	/aozg+U9yQ5GQCXzln8HssEiHraVW6SNo6ZgmTlewb9wiFxh2esD6ohaeN6DMINUNDUzBJ1gus8
	DoZaxm3D6B14
X-Google-Smtp-Source: 
 AGHT+IHwRC9Gm3D+0q71uhZgu5OG3zbuALxFWIkhU3KV1aM5HRjWUSfR8PpmhmHsZStV5leW4uRQPw==
X-Received: by 2002:a05:690c:c1e:b0:6ef:522a:1c41 with SMTP id
 00721157ae682-6f3f811073emr148407677b3.13.1735097251632;
        Tue, 24 Dec 2024 19:27:31 -0800 (PST)
Received: from localhost.localdomain ([24.143.14.92])
        by smtp.gmail.com with ESMTPSA id
 00721157ae682-6f3e77ed619sm31817877b3.86.2024.12.24.19.27.29
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 24 Dec 2024 19:27:30 -0800 (PST)
From: Noah Peterson <noahbpeterson1997@gmail.com>
X-Google-Original-From: Noah Peterson <NoahBPeterson1997@gmail.com>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Noah Peterson <NoahBPeterson1997@gmail.com>,
	Noah Peterson <noahbpeterson1997@gmail.com>
Subject: [PATCH v2] batctl: ping: Add subsecond precision to ping interval
Date: Tue, 24 Dec 2024 21:27:24 -0600
Message-Id: <20241225032724.29814-1-NoahBPeterson1997@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: G3XE2YX62YS7NZGL6KGZQ4BMAOJWIAEE
X-Message-ID-Hash: G3XE2YX62YS7NZGL6KGZQ4BMAOJWIAEE
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/G3XE2YX62YS7NZGL6KGZQ4BMAOJWIAEE/>
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
v2: Fixing use-after-free, adding a missing header file, noted by Sven
<sven@narfation.org>
---
 ping.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/ping.c b/ping.c
index 52bce4d..a69b6ac 100644
--- a/ping.c
+++ b/ping.c
@@ -21,6 +21,7 @@
 #include <stdint.h>
 #include <sys/select.h>
 #include <sys/time.h>
+#include <time.h>
 #include <netinet/if_ether.h>
 
 #include "batadv_packet_compat.h"
@@ -65,14 +66,15 @@ static int ping(struct state *state, int argc, char **argv)
 	struct bat_host *bat_host, *rr_host;
 	ssize_t read_len;
 	int ret = EXIT_FAILURE, res, optchar, found_args = 1;
-	int loop_count = -1, loop_interval = 0, timeout = 1, rr = 0, i;
+	int loop_count = -1, timeout = 1, rr = 0, i;
 	unsigned int seq_counter = 0, packets_out = 0, packets_in = 0, packets_loss;
-	char *dst_string, *mac_string, *rr_string;
-	double time_delta;
+	char *dst_string, *mac_string, *rr_string, *end = NULL;
+	double time_delta, ping_interval, integral_part, fractional_part = 0.0;
 	float min = 0.0, max = 0.0, avg = 0.0, mdev = 0.0;
 	uint8_t last_rr_cur = 0, last_rr[BATADV_RR_LEN][ETH_ALEN];
 	size_t packet_len;
 	int disable_translate_mac = 0;
+	struct timespec loop_interval = {0, 0};
 
 	while ((optchar = getopt(argc, argv, "hc:i:t:RT")) != -1) {
 		switch (optchar) {
@@ -86,9 +88,17 @@ static int ping(struct state *state, int argc, char **argv)
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
@@ -285,9 +295,8 @@ static int ping(struct state *state, int argc, char **argv)
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

