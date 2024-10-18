Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3187D3F2AA
	for <batman@archiver.kernel.org>; Fri, 18 Oct 2024 21:48:09 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id E157C83D58
	for <batman@archiver.kernel.org>; Fri, 18 Oct 2024 23:48:07 +0200 (CEST)
ARC-Seal: i=2; cv=fail; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1729288087;
 b=dVyHIrBpc7Hvbo2d6CDPJXkeNvcBVAxZBqDbSOj6AucpkfgsVosAS+vATAZeIeNxErsEK
 MRR+t1vJuo8cGbo+VyK5oDmgr8f6vx5AvlUdyUThRlP+bzKbNFpo7RszcmmEYfBZj5RyqM2
 nQLoETc7KwnMpge6yOEbVYOfpCK1krA=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1729288087; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=YygBWUIMPaz6Sv2U/Xgt6TEtidulS3Ndn6JLhLxgN9o=;
 b=IH/XGfqqFX4riDhOo7GKD+09jLJyW9kwTGFrx4HPVmf9rLco9B0UCFYN1pPgFdXnwX7dc
 k2zHmAULu38Jyy/B+u5GJ2egr7kxABal96uEwFFosebtChQZLAh9LBhPETM49r6E2eu1Sy0
 D/qwKhX45HjgjWUoqDdYO0KKULX/2tw=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=pass header.d=gmail.com;
  arc=fail (ARC-Seal[1] did not validate);
  dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=gmail.com;
 arc=fail (ARC-Seal[1] did not validate);
 dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com
 [IPv6:2607:f8b0:4864:20::b2a])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 5880883BDA
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 18 Oct 2024 23:47:23 +0200 (CEST)
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1729288043; a=rsa-sha256;
	cv=none;
	b=2WRsEXIWF/U+EYUayrQq0wMu6UYChHNv4ww2xsiv2hNargxRzNIq9yHZP94MrWuLRLIm+w
	M24500u79iCDcOPfQ7gGQdSoGPKlPErXN6fmHd+4ekzYnoQQ6Hhia9+8sO2gOutk8tYbYg
	OsAdUO6h4RRByNZILXQKO/1zxQvUQrw=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=gmail.com header.s=20230601 header.b=hAHkpT1y;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (diktynna.open-mesh.org: domain of noahbpeterson1997@gmail.com
 designates 2607:f8b0:4864:20::b2a as permitted sender)
 smtp.mailfrom=noahbpeterson1997@gmail.com
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1729288043;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=YygBWUIMPaz6Sv2U/Xgt6TEtidulS3Ndn6JLhLxgN9o=;
	b=A1rk89Nh8HV3vYkN9Uwx4LRAr3TaBFTiyUAIMDWB+OxYUhk5D9V9JQLVec46azEe1xRmcW
	wkOohvKTUJFUU1/6B6bwNnRyG6kE/I2ad2+1FyqodLE+4DWaEhSEYB+bcFCk4nmP2ehhFH
	IFl9eksazUEWk1jKV4UhwGz1SqNFZAs=
Received: by mail-yb1-xb2a.google.com with SMTP id
 3f1490d57ef6-e2908e8d45eso2395089276.2
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Fri, 18 Oct 2024 14:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729288042; x=1729892842;
 darn=lists.open-mesh.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YygBWUIMPaz6Sv2U/Xgt6TEtidulS3Ndn6JLhLxgN9o=;
        b=hAHkpT1yw4EOZQa+uKoTGe6zzpYeApd+dAvdJIkdOTPcu/z6g8GyK6wH8Ebzdzr9Rs
         KA3Htjfomo8r0AiWvZYq9Es5qXhnkBKaD6pX6WXSPRm6Ws69eImr1o8CnJGUnje+RknI
         cQeYcYHzbLTzJuDQu2fEsoVgAb51BpqkaLEsf/cVQXugLW8wVyKHPrF5cOk+WPUHuSjG
         wIS3LQh0wR8VFRgYNk7KJHAcijsNLk9Ra4hiyjvVLCEkG/Y1fA8f4YTN4a6JzhwrkdRe
         dlma/uQC+knfLlPVWxn3tYUDSIqr/nAOlIPoCmibOkJOYtyviJgToqmLsHCvpFq9HuUm
         vZ1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729288042; x=1729892842;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YygBWUIMPaz6Sv2U/Xgt6TEtidulS3Ndn6JLhLxgN9o=;
        b=A0fOXwnh//xcwBWvYftTbwnAsMDVw6iH7K6NSup88py2pqE++X/JXPZLyKRDYXBVOE
         uSYsTJINXS41AMo219+v4k8tRmvBgrmF5Q2fjHNXmCzchEg68+pZX+4omVxjZPKqpzcb
         1C0ds/DmJgNwl+85PFlkwknEakx+KoiezgD9WZMLHObssKA3FvDuBhRrGUPyBtg7bmpl
         ZAwh3UZ5S/VnYAihL67O/6Sbeuao1VHVlk7xz2522E7H4XKUTSdHS0IcVAUg8oZZZ1DK
         67ERpNEO+VlVU9x3D48NqWYPmQ457i16sPd8y8uNBFoYlOWpdFKlAfdCpvy9Lk97KmTh
         KwEw==
X-Gm-Message-State: AOJu0Ywg7W7n51p6BjboIHsZ1Ccjxxhf0nkLq+voQiOGrNC06UDObXaJ
	YX48TQodykGVeaz7HwuOdwluWgTTukCzUrelUUMJUZ9N6Ph+PsrGqxavBkj1itQ=
X-Google-Smtp-Source: 
 AGHT+IE3XtKWWSq0Rln27nW87jAXU9yNKUCEjC2uL5maaRB7/vpxkG9LxOweBQLBFwRwjUL/F0L6GQ==
X-Received: by 2002:a05:6902:1029:b0:e28:f054:a2bc with SMTP id
 3f1490d57ef6-e2bb11de592mr3963119276.8.1729288041831;
        Fri, 18 Oct 2024 14:47:21 -0700 (PDT)
Received: from localhost.localdomain ([2800:860:71ac:7d8e:75c1:2f63:585:5dac])
        by smtp.gmail.com with ESMTPSA id
 3f1490d57ef6-e2bc8e28380sm107773276.28.2024.10.18.14.47.20
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 18 Oct 2024 14:47:21 -0700 (PDT)
From: Noah Peterson <noahbpeterson1997@gmail.com>
X-Google-Original-From: Noah Peterson <NoahBPeterson1997@gmail.com>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Noah Peterson <NoahBPeterson1997@gmail.com>,
	Noah Peterson <noahbpeterson1997@gmail.com>
Subject: [1/1 PATCH] batctl: ping: Add millisecond precision to ping interval
Date: Fri, 18 Oct 2024 15:47:13 -0600
Message-Id: <20241018214713.91598-2-NoahBPeterson1997@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241018214713.91598-1-NoahBPeterson1997@gmail.com>
References: <20241018214713.91598-1-NoahBPeterson1997@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: JG53IY4YADAHUZZAKMR4YLW2Z2WJBNC4
X-Message-ID-Hash: JG53IY4YADAHUZZAKMR4YLW2Z2WJBNC4
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/JG53IY4YADAHUZZAKMR4YLW2Z2WJBNC4/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Modify the batctl ping utility to accept both integer and floating-point
values for the interval between sending pings. This enhancement allows
specifying intervals with millisecond precision.

For example:
`sudo batctl ping aa:bb:cc:dd:ee:ff -i 0.5`

Also, improve error handling for invalid interval arguments.

Signed-off-by: Noah Peterson <noahbpeterson1997@gmail.com>
---
 ping.c | 35 +++++++++++++++++++++++++++--------
 1 file changed, 27 insertions(+), 8 deletions(-)

diff --git a/ping.c b/ping.c
index 3681e7e..104b17c 100644
--- a/ping.c
+++ b/ping.c
@@ -16,6 +16,7 @@
 #include <signal.h>
 #include <fcntl.h>
 #include <string.h>
+#include <limits.h>
 #include <math.h>
 #include <stddef.h>
 #include <stdint.h>
@@ -65,14 +66,15 @@ static int ping(struct state *state, int argc, char **argv)
 	struct bat_host *bat_host, *rr_host;
 	ssize_t read_len;
 	int ret = EXIT_FAILURE, res, optchar, found_args = 1;
-	int loop_count = -1, loop_interval = 0, timeout = 1, rr = 0, i;
+	int loop_count = -1, timeout = 1, rr = 0, i;
 	unsigned int seq_counter = 0, packets_out = 0, packets_in = 0, packets_loss;
-	char *dst_string, *mac_string, *rr_string;
-	double time_delta;
+	char *dst_string, *mac_string, *rr_string, *end, *loop_interval = NULL;
+	double time_delta, ping_interval = 0.0;
 	float min = 0.0, max = 0.0, avg = 0.0, mdev = 0.0;
 	uint8_t last_rr_cur = 0, last_rr[BATADV_RR_LEN][ETH_ALEN];
 	size_t packet_len;
 	int disable_translate_mac = 0;
+	struct timespec req;
 
 	while ((optchar = getopt(argc, argv, "hc:i:t:RT")) != -1) {
 		switch (optchar) {
@@ -86,9 +88,7 @@ static int ping(struct state *state, int argc, char **argv)
 			ping_usage();
 			return EXIT_SUCCESS;
 		case 'i':
-			loop_interval = strtol(optarg, NULL , 10);
-			if (loop_interval < 1)
-				loop_interval = 1;
+			loop_interval = strdup(optarg);
 			found_args += ((*((char*)(optarg - 1)) == optchar ) ? 1 : 2);
 			break;
 		case 't':
@@ -135,6 +135,25 @@ static int ping(struct state *state, int argc, char **argv)
 		}
 	}
 
+	if (loop_interval) {
+		errno = 0;
+		ping_interval = strtod(loop_interval, &end);
+		free(loop_interval);
+
+		if (errno || end != (loop_interval + strlen(loop_interval))) {
+			fprintf(stderr, "Error - invalid ping interval '%s'\n", (ULONG_MAX / 1000000 - 1.0));
+			goto out;
+		} else if (ping_interval >= (ULONG_MAX / 1000000 - 1.0)) {
+			fprintf(stderr, "Error - ping interval too large\n");
+			goto out;
+		} else {
+			ping_interval = fmax(ping_interval, 0.001);
+		}
+
+		req.tv_sec = (long) (ping_interval);
+		req.tv_nsec = fmod(ping_interval, 1.0) * 1000000000l;
+	}
+
 	if (!disable_translate_mac)
 		dst_mac = translate_mac(state, dst_mac);
 
@@ -286,8 +305,8 @@ static int ping(struct state *state, int argc, char **argv)
 		if (loop_count == 0)
 			continue;
 
-		if (loop_interval > 0)
-			sleep(loop_interval);
+		if (ping_interval > 0.0)
+			nanosleep(&req, NULL);
 		else if ((tv.tv_sec != 0) || (tv.tv_usec != 0))
 			select(0, NULL, NULL, NULL, &tv);
 	}
-- 
2.39.5 (Apple Git-154)

