Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C2E7E7718B
	for <batman@archiver.kernel.org>; Fri, 27 Dec 2024 17:58:29 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 66C6783F42
	for <batman@archiver.kernel.org>; Fri, 27 Dec 2024 18:58:27 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1735322307;
 b=nyT/Bk0N57oVLTf7zICuimgbPuILZoMr7DFIoNqvD3T/U9A0AhzzGStOUYYiVftwOJho9
 s2qTZ6S3E2gTs7hLLAMwUgSgjIRkmluI7+OAsbNEPj0H3DEU7FxflXDTnoUmm0mwSOAOT6F
 P09ke4EhCHOrTLKLI8BwptWOV+SzrUY=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1735322307; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=zY1Qv49/YjhwfFJsnewNGfwpGQgEovIc//G1ODeOx+k=;
 b=SWysiz3LLqOK0xLsLSN3Av7ylxsi735rpWdTTe6GUv9kc0jcFavQuPCav/dTBycM+XBhZ
 rYP7cSYc5k3x0EaMi570cV7wYfUjFwocXVAz2Y9/PgGfjwMXIxoFZGlDZPzeR4mxRy0g92N
 NO1/MuqDcZ797e6Eu2580Vjr+xAoLks=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=mailbox.org;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=mailbox.org
 policy.dmarc=reject
Authentication-Results: open-mesh.org; dkim=pass header.d=mailbox.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=mailbox.org policy.dmarc=reject
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 25BA380853
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 27 Dec 2024 10:19:24 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1735291164;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=zY1Qv49/YjhwfFJsnewNGfwpGQgEovIc//G1ODeOx+k=;
	b=zmOLtugaXatpO9kr1EciwDYofSnxlhJ6JwROC0cIo942/oaou91adBycKM41ipt8HEHBHs
	mr4vvHaLU3wXEzFnSHAw0sJCzS39uOprcAqyngr7v4m6gpvIW9PeSavkR3DaYiuRMRB+EB
	pmio3QbKnyIIqlENVOCxMQwpSw32qXo=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b="vA7T/cf3";
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=CG0zZZDf;
	dmarc=pass (policy=reject) header.from=mailbox.org;
	spf=pass (diktynna.open-mesh.org: domain of marek.lindner@mailbox.org
 designates 80.241.56.151 as permitted sender)
 smtp.mailfrom=marek.lindner@mailbox.org
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1735291164; a=rsa-sha256;
	cv=none;
	b=WRfMC5F2FQthwH3GazJOtxSdmwha8Gq+0eYauXNmn8aMudLT+QjH70cMzDpX2GmQuFGTR0
	vw+3FjrOpdrCwmJX/oy1fUzrazeB6mBqxL+NN+NDMONQHCVtaZBw3LfXDpotpJ8ELresJf
	5Kj9DJtSywd5mScEwha+uFp6KpLTr3s=
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4YKKgv5LJYz9snt
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 27 Dec 2024 10:19:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812;
	t=1735291163;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=zY1Qv49/YjhwfFJsnewNGfwpGQgEovIc//G1ODeOx+k=;
	b=vA7T/cf3oYgHFMcmJquG68eRmi+D8qjSnWaGb0TY+fxNwPOBYkrUiz3TCXaCOX8LIgpeIv
	CQpHKCbpnsO9UBEVRSuT+5/qcl3wpOBhMBiRnZeTdUq2vPtJzw2x8xM2gZEoj/2RB9wBx9
	W7VmthZj50/ZhI3yo2T3TvpTW19rUYC3twpxGv54N0Gh3xds8Ljwo1gDngS3gpWarHc78M
	k0/RGHt/rL/cJItRfyxsEqiRr42pnomj1wzCAxKrubQ6AlTmH/dK4qkiEJzdVnhL36vfce
	Jsepa/YqLQg0ZjzCp9uaFsUVH0TA3HYLLHEEfv5+qNT1F0YkHdl9luUlRrhjjw==
From: Marek Lindner <marek.lindner@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812;
	t=1735291161;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=zY1Qv49/YjhwfFJsnewNGfwpGQgEovIc//G1ODeOx+k=;
	b=CG0zZZDfd9z0FooxsMP8jl/gaNW/9cPprxYWWRcfmA+oC1QXBlEK9sFPJM24JSj3cDrnyh
	qcalH4E3PjCrnsCviJBPYbtfaQobMesoNcT3SQfyfLDkadoAmP7+E0LAvnYdDTo7COdSRq
	wDREC5U6tJ2ks3UINla2duuhwhX9mkeTY3jXQ/KXrgM81G/kcueNp4vJgnCM7qPsk9ubN7
	fyPC4brmvsEGGcOGRYfFr0be2gS8zUnL/ydwR1516Q4AXph7iOuz0bVRON55sipM3UnCIp
	4M+CyKmG3zW2FQlpQ5sFKalmFH/dOEOuTZfyIsey+DBqDwq9olJ1eubbPS/UnQ==
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Marek Lindner <marek.lindner@mailbox.org>
Subject: [PATCH] MAINTAINERS: update email address of Marek Linnder
Date: Fri, 27 Dec 2024 10:19:12 +0100
Message-ID: <20241227091912.2528930-1-marek.lindner@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: eb4871a083140b27915
X-MBO-RS-META: y4w5tpbfrw3goyq6og8psog39ucbqn85
X-Rspamd-Queue-Id: 4YKKgv5LJYz9snt
X-MailFrom: marek.lindner@mailbox.org
X-Mailman-Rule-Hits: member-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address
Message-ID-Hash: G3V5QO3SHU4WZRRM4XYTDM3J7YJHRHMC
X-Message-ID-Hash: G3V5QO3SHU4WZRRM4XYTDM3J7YJHRHMC
X-Mailman-Approved-At: Fri, 27 Dec 2024 18:58:07 +0100
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/G3V5QO3SHU4WZRRM4XYTDM3J7YJHRHMC/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Signed-off-by: Marek Lindner <marek.lindner@mailbox.org>
---
 MAINTAINERS           | 2 +-
 net/batman-adv/main.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1120a7d8..9ea7a1e4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1,5 +1,5 @@
 BATMAN ADVANCED
-M:	Marek Lindner <mareklindner@neomailbox.ch>
+M:	Marek Lindner <marek.lindner@mailbox.org>
 M:	Simon Wunderlich <sw@simonwunderlich.de>
 M:	Antonio Quartulli <a@unstable.cc>
 M:	Sven Eckelmann <sven@narfation.org>
diff --git a/net/batman-adv/main.h b/net/batman-adv/main.h
index 7d0e25ce..276e9421 100644
--- a/net/batman-adv/main.h
+++ b/net/batman-adv/main.h
@@ -7,7 +7,7 @@
 #ifndef _NET_BATMAN_ADV_MAIN_H_
 #define _NET_BATMAN_ADV_MAIN_H_
 
-#define BATADV_DRIVER_AUTHOR "Marek Lindner <mareklindner@neomailbox.ch>, " \
+#define BATADV_DRIVER_AUTHOR "Marek Lindner <marek.lindner@mailbox.org>, " \
 			     "Simon Wunderlich <sw@simonwunderlich.de>"
 #define BATADV_DRIVER_DESC   "B.A.T.M.A.N. advanced"
 #define BATADV_DRIVER_DEVICE "batman-adv"
-- 
2.45.2

