Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C09FE77188
	for <batman@archiver.kernel.org>; Sun,  5 Jan 2025 00:10:07 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id DA10D84217
	for <batman@archiver.kernel.org>; Sun,  5 Jan 2025 01:10:05 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1736035805;
 b=Cv4i5YY1/xbgdGOCBokqApHQdt3GYFr+m7p6ULKT9MT+1ZwEhUWInlmGOeQfvdLXon2cM
 zD6ymRYd6I8y2zGjLcyWRaJAVTvy21ljepfaJmv7Hf0wsb6+kfDT5CyGVP51R5v5ZX9nQm0
 6etDZti7CvZxQr3W+8kIBrYLq+Leoi8=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1736035805; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=knZLCcYL/LnX3Q5fennnLHJJhYZeYNXYM8Q3MXDpc70=;
 b=m1xVmggzti2h+yXNWUaZFWwgggAuV5WiP3/lZ9kEQ0NKyjVVq2cxn9pWNNai6EMmLA4jw
 3fq3qQpQvJygIClQlbgqbvw2nEBEGdAklvbXlVqe5EG70fTpNN41De9abYUYqH/oxWU9EiS
 1f50+93ARK52LN5wuWFDUJWkV0mFej4=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=pass header.d=gmail.com;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=gmail.com; arc=pass;
 dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Received: from mail-vk1-xa31.google.com (mail-vk1-xa31.google.com
 [IPv6:2607:f8b0:4864:20::a31])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 6675083F69
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun,  5 Jan 2025 01:09:22 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1736035762;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=knZLCcYL/LnX3Q5fennnLHJJhYZeYNXYM8Q3MXDpc70=;
	b=fLYd2eeB54yHsPRrPAX+fVLcKaI3pnpCQtoEqm5/ktSzVur3QSjnEsna1eucQH4l5iUXRq
	LseP+Sq1G8Jg7UdqV8JbQPnW+AB+vOgstbV/VBed9kPADKdaUvsofq23Py8RHm/0JQVUTQ
	LIXJmpQ6HeQK7Wy6xE9iYiEFroZV7ns=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=gmail.com header.s=20230601 header.b=iINaT3vy;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (diktynna.open-mesh.org: domain of noahbpeterson1997@gmail.com
 designates 2607:f8b0:4864:20::a31 as permitted sender)
 smtp.mailfrom=noahbpeterson1997@gmail.com
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1736035762; a=rsa-sha256;
	cv=none;
	b=2T3jIxhjqPgfw8BXcGPD0jqZFkQoq1dmRaxheroP0nKZLXkw4sp6MHyH/w/00zBufdxSGw
	HygJaMlCWWUW32scgGX6pHVL2LB/tIS4r29xBQAQxdhROfDvI/Ppjhg1ndP+EWwXdd6CMd
	K7p4OVvaDfUMh08rY5wR2VXEdUSaDqc=
Received: by mail-vk1-xa31.google.com with SMTP id
 71dfb90a1353d-5187f6f7bcaso4181693e0c.3
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Sat, 04 Jan 2025 16:09:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736035761; x=1736640561;
 darn=lists.open-mesh.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=knZLCcYL/LnX3Q5fennnLHJJhYZeYNXYM8Q3MXDpc70=;
        b=iINaT3vyTTC1EFf2JbLMc5GwSXZfc75nEXYBxGSqI68fjJZeUfgbjW8jDBoDTpaO5I
         d98TGe5B8MBioPYlywAHj3DPemZYR3NvMYjgGLed/OJyiyMcP04UUeblDc9aYrmWjiwJ
         KsUlbMRcrlZO9R8INJbbkQW1U0UWeB0I6amdE4t8lXpKSNYox3qMpXQJc2uotQ7Tzol4
         As08Df2Y9itlZ4PFg0Ts4gIEgaRHk9WOUccs9TzkbJgLRVDUURgmOwJeMMw+VeS64bRt
         cw1HoP1DtOvacjQtA701AeSKj9TO10Eys6QiWfOwVtpazoepW8nS2rMRGbIbCnADqRY+
         aPyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736035761; x=1736640561;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=knZLCcYL/LnX3Q5fennnLHJJhYZeYNXYM8Q3MXDpc70=;
        b=MqFS8pQPZVIop8n3R2DM96/XIEnSzUyx1X3f5faHT5UQtRUbRSH1XW0yibtN+++WjO
         zmUVTV7LCsfcigZ9lQ1AbHYhfrgnk48CnumVZOAKkok5gxF8HQsGpXl/pc2DARFxwelA
         emc7dR8vcdwEjpBmOXnwOCFGzbK/iqScB/peHyB/HvWSG2+wYb4LpYFutDnHCo71KgFR
         esFqDKNpYHhRcQAN6fpDVHx8vGjxlbj4zLlPuYwkqxGRKG+6kHkjPTaSTYqO439bIyeW
         TyJJwuFthjt8IaGE1aOu7Mdq8CyM+EEGMDJZFlfzXXP5v5LWKiv86PvDNYqC5XabvPt4
         uS9A==
X-Gm-Message-State: AOJu0YyVb0BSWCn2f62AoXr9NNwznXi0dkoYqAdCM25tWNEkEZ5bYMv8
	q3GEEuUW9ebW0Legcr1fsGv1YawhQ5IOIQoHdWlXGomxPyj4FgnoMUqxBtOm
X-Gm-Gg: ASbGnctDDO8bgbuEIW37Pzn3uv7gyiie83KdV10QiI8sUgChxXWOgWHpFCohQNligIN
	WEniVfQSdl8Xqn4cFLfCvqw5q54dWumYsn39KrFMwWgW9gtgHxoykaoUzdzC+2CZs7nqmDqyPZ+
	VaPosU239rx6hRLkf+szojTLxZexjleOR6NpE14cAWOlFK47X+ag1OTN0QBJxK6A5tyhn6cJ6Jg
	D2CCzFO5SavIsdnqAVzXblmRZDdxPQvOIygfnQVk9RnsfIiLpyCaPuUjIaa08qAJTFFE59KTOw1
	THrrOWh+l+Vdj3oiQw==
X-Google-Smtp-Source: 
 AGHT+IFGM457TvcOIM9uvRA6KILjEaMKGPaWqlEW/XET6ZFFlJdFJDUJuSV/Gp0T89dFUExoSKyFSg==
X-Received: by 2002:a05:6102:d8f:b0:4b2:9f20:51d3 with SMTP id
 ada2fe7eead31-4b2cc116633mr48619604137.0.1736035760952;
        Sat, 04 Jan 2025 16:09:20 -0800 (PST)
Received: from localhost.localdomain ([190.113.102.112])
        by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-8610ac1d4bbsm6365126241.2.2025.01.04.16.09.18
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 04 Jan 2025 16:09:19 -0800 (PST)
From: Noah Peterson <noahbpeterson1997@gmail.com>
X-Google-Original-From: Noah Peterson <NoahBPeterson1997@gmail.com>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Noah Peterson <NoahBPeterson1997@gmail.com>,
	Noah Peterson <noahbpeterson1997@gmail.com>
Subject: [PATCH v5 1/1] batctl: ping: Add subsecond precision to ping interval
Date: Sat,  4 Jan 2025 18:09:08 -0600
Message-Id: <20250105000908.66343-2-NoahBPeterson1997@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250105000908.66343-1-NoahBPeterson1997@gmail.com>
References: <20250105000908.66343-1-NoahBPeterson1997@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: RWQDWIWBQHHUI4SXTT26YM6MTD5TGEHW
X-Message-ID-Hash: RWQDWIWBQHHUI4SXTT26YM6MTD5TGEHW
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/RWQDWIWBQHHUI4SXTT26YM6MTD5TGEHW/>
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
v5: Fixing whitespace misalignment, correcting changelogs, removing old
variable declaration, as noted by Sven <sven@narfation.org>
v4: Rebasing on latest commit, reformatting into reverse X-mas tree order based
on feedback from Sven <sven@narfation.org>
v3: Reformatting code based on comments by Sven
<sven@narfation.org>
v2: Fixing use-after-free, adding a missing header file, noted by Sven
<sven@narfation.org>
---
 ping.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/ping.c b/ping.c
index 14d9c21..6fd11b2 100644
--- a/ping.c
+++ b/ping.c
@@ -19,6 +19,7 @@
 #include <stdint.h>
 #include <sys/select.h>
 #include <sys/time.h>
+#include <time.h>
 #include <netinet/if_ether.h>
 
 #include "batadv_packet_compat.h"
@@ -58,18 +59,21 @@ static int ping(struct state *state, int argc, char **argv)
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
 	uint8_t last_rr_cur = 0;
 	int ret = EXIT_FAILURE;
-	int loop_interval = 0;
 	int loop_count = -1;
 	int found_args = 1;
 	size_t packet_len;
@@ -86,6 +90,7 @@ static int ping(struct state *state, int argc, char **argv)
 	int timeout = 1;
 	int optchar;
 	int rr = 0;
+	char *end;
 	int res;
 	int i;
 
@@ -101,9 +106,17 @@ static int ping(struct state *state, int argc, char **argv)
 			ping_usage();
 			return EXIT_SUCCESS;
 		case 'i':
-			loop_interval = strtol(optarg, NULL, 10);
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
 			found_args += ((*((char *)(optarg - 1)) == optchar) ? 1 : 2);
 			break;
 		case 't':
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
@@ -330,7 +343,7 @@ static int ping(struct state *state, int argc, char **argv)
 	printf("%u packets transmitted, %u received, %u%% packet loss\n",
 	       packets_out, packets_in, packets_loss);
 	printf("rtt min/avg/max/mdev = %.3f/%.3f/%.3f/%.3f ms\n",
-	       min, avg, max, mdev);
+		min, avg, max, mdev);
 
 	if (packets_in)
 		ret = EXIT_SUCCESS;
-- 
2.39.5 (Apple Git-154)

