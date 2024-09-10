Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DF5DEDE9AB
	for <batman@archiver.kernel.org>; Tue, 10 Sep 2024 19:05:55 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id C2B4183DF1
	for <batman@archiver.kernel.org>; Tue, 10 Sep 2024 21:05:53 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1725995153;
 b=fZC43gYcLjlfxV86tre/k54IOmiI4wjN7N5TPAN2D1tfQN/w6q6VQQCAy/D6IYyotZUIR
 P39HYbrqVPlbHjmsNKTbFUZOj/rKjIH81voDbqbyyNYTYUZL/aMwWaCI8XlFyksxLEhZFD8
 yoTxjbUP4V20RtLzK6R1+Kmu6/zgbKo=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1725995153; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=VyF1Axz3Qa6sl4mLPAhPrQYmrTs4J/PV8i8ji8rH024=;
 b=MRt15Tj9XlC8OvZhhMqrbGfk0P+e+4em9v7RulXu7tTkftIwi2adUHaAW9wJX7JX/Ltai
 85DyPfuZPLYg1/F/KI0AOKtCE0qYGmoVwJxQoHHZMDgguxTtVWy1dSFwSdUSRtOzPvCffgs
 2xYOwfiLuSZhEfvAyxP/rblk9lkR8/A=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=pass header.d=gmail.com;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=gmail.com; arc=pass;
 dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com
 [IPv6:2607:f8b0:4864:20::112a])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 2A06180401
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 10 Sep 2024 21:05:13 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1725995113;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=VyF1Axz3Qa6sl4mLPAhPrQYmrTs4J/PV8i8ji8rH024=;
	b=eSa+H4byjG63ySYH8ErMVNHstVFegScjYq9GOF01HoD0t5ktIrNqLrdN7MuKqsGse7osqM
	4d5zUfH73R06/vce9xyZ5xd+nGpYUbEZullTlJz31bJEvCCmuLB7GG4K/bhWOp4EjNRmWU
	fU3rDLfoNxInMxFfZrgnbXrs4ZYSqAY=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=gmail.com header.s=20230601 header.b=TPTjkpUJ;
	spf=pass (diktynna.open-mesh.org: domain of noahbpeterson1997@gmail.com
 designates 2607:f8b0:4864:20::112a as permitted sender)
 smtp.mailfrom=noahbpeterson1997@gmail.com;
	dmarc=pass (policy=none) header.from=gmail.com
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1725995113; a=rsa-sha256;
	cv=none;
	b=SBFhd0j+ANFF2rpPSaV1zRQy6YlGzUq7vgxZeKFFAMQqtUZrzZ+J5yYbIq45ssUE/eXb7j
	qhpOKGRpKcv1vt3inL1Ffr3unu8zDqcankZ8pP4YlQJMPTrgaBPpSyuHZSzb7+3V/zpELZ
	a6N0SsEkF77XvWJ0LZoxLkVbKtlq/Gw=
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-6db67400db4so33599807b3.1
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Tue, 10 Sep 2024 12:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725995111; x=1726599911;
 darn=lists.open-mesh.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VyF1Axz3Qa6sl4mLPAhPrQYmrTs4J/PV8i8ji8rH024=;
        b=TPTjkpUJ7MkxLxythc/D3ADs0copcaCu6WL0ZDz4SFkqnyT2eHYf7glTdMVjTJhWKM
         EYNiGc25u8QCWjk6kKVw2I5InU5MQn45Y9s5DjYyfCd4c3a3RRVr90wwukqAdeZuOyun
         Mz+ktvypdUcVfl2o9FQ/KnDOzvvV1i6NhkUUt0hGjOUjEwErYnC1lQDAkFg1qZhFULK/
         1IJir0gTyknwas2l5ar3wJthdKGpNjhcmv3VmACgqCgKyxi/Q8RnLG91G1byaMOroOTo
         2VBkYBkGqCJVJgOsVWXffWUJ1rk4EguQgiz2QFRNtKoHiO5c/NfbzpQQxcqR5ZQ0ptxz
         iECA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725995111; x=1726599911;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VyF1Axz3Qa6sl4mLPAhPrQYmrTs4J/PV8i8ji8rH024=;
        b=HDU9m1eMgWvKtH0Y/p6EwTehAU0XDlA787ey8SCigSQ/BKQTLZB12MJD0RLJwEtROx
         UmiHI2BZL31XwfvuKEfoTnjcAj6VkEijL/9+jiYcB9UBOGJewGd1dduBbndaZXxDgzWT
         C29PjmxXD1Ws2llOmgeEgqgnMkSYy59nrJZPNIxL3AZ1sH9LYY0TKlCDzEuR62tJyayJ
         05NyvTUaLURFnUJMSmGgHkOpalLhSyImdvSzlmtrAoBlDFdA+gs/X4O2zc+eKdKiU9Rh
         Pa8DnSLxE4fTOmw93Ei2J09vMesCbvYmK2mzIQyAsDR+pxwByRhkTE/eme4QTYxhnRcc
         jAHw==
X-Gm-Message-State: AOJu0YwaHooxX7iIyO3/8yCP+SoPJ9IJKSz5Ej0OqQSF10D32r4RzOPv
	05keHw95XxlVIDww1tDrXC+2E+ed+PENYS8vgZic0/zlYbDIQfcSmboY+9wjk8KbjQ==
X-Google-Smtp-Source: 
 AGHT+IEJKmKcABJX+VBG63ZnG+46Qja1gQbVsD3vd3sD0Zi2fY7MgMDhYEku5sS+do8MNSH9YUFajw==
X-Received: by 2002:a05:690c:f01:b0:6b3:a6ff:76a7 with SMTP id
 00721157ae682-6db44a612ebmr200399207b3.0.1725995111375;
        Tue, 10 Sep 2024 12:05:11 -0700 (PDT)
Received: from localhost.localdomain
 ([2800:860:71ac:81ad:39dd:aadf:88a2:f660])
        by smtp.gmail.com with ESMTPSA id
 00721157ae682-6db9642913dsm4027177b3.22.2024.09.10.12.05.10
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 10 Sep 2024 12:05:10 -0700 (PDT)
From: Noah Peterson <noahbpeterson1997@gmail.com>
X-Google-Original-From: Noah Peterson
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Noah Peterson <NoahBPeterson1997@gmail.com>,
	Noah Peterson <noahbpeterson1997@gmail.com>
Subject: [PATCH v3] alfred: add more verbose error message
Date: Tue, 10 Sep 2024 13:05:04 -0600
Message-Id: <20240910190504.12181-1-NoahBPeterson1997@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: UK4EF33GQQ4NJVTSWGR5CC27WBB7OGZ5
X-Message-ID-Hash: UK4EF33GQQ4NJVTSWGR5CC27WBB7OGZ5
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/UK4EF33GQQ4NJVTSWGR5CC27WBB7OGZ5/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Noah Peterson <NoahBPeterson1997@gmail.com>

There is an issue with some Linux distributions where network interfaces
are up and active, but do not have the correct link-local address. This
condition is now checked and output to stderr to better help users
troubleshoot this issue.

Signed-off-by: Noah Peterson <noahbpeterson1997@gmail.com>
---
v3: Add changelog, change newlines, noted by Sven <sven@narfation.org>
v2: Fixed IPv6 address string, noted by Sven <sven@narfation.org>
---
 netsock.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/netsock.c b/netsock.c
index feed21d..95dbf5e 100644
--- a/netsock.c
+++ b/netsock.c
@@ -21,6 +21,7 @@
 #include <sys/types.h>
 #include <stdlib.h>
 #include <sys/epoll.h>
+#include <arpa/inet.h>
 #ifdef CONFIG_ALFRED_CAPABILITIES
 #include <sys/capability.h>
 #endif
@@ -322,7 +323,19 @@ static int netsock_open(struct globals *globals, struct interface *interface)
 	enable_raw_bind_capability(0);
 
 	if (bind(sock, (struct sockaddr *)&sin6, sizeof(sin6)) < 0) {
-		perror("can't bind");
+		char ipstr_buf[INET6_ADDRSTRLEN];
+		const char *ipstr;
+
+		ipstr = inet_ntop(AF_INET6, &interface->address.ipv6.s6_addr,
+				  ipstr_buf, INET6_ADDRSTRLEN);
+
+		if (errno == EADDRNOTAVAIL)
+			fprintf(stderr, "can't bind to interface %s; "
+				"expected ipv6 address not found: %s\n",
+				interface->interface,
+				ipstr);
+		else
+			perror("can't bind");
 		goto err;
 	}
 
-- 
2.39.3 (Apple Git-146)

