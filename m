Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E6ADCD37B6
	for <batman@archiver.kernel.org>; Wed, 13 May 2026 08:44:40 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 7854C859D3
	for <batman@archiver.kernel.org>; Wed, 13 May 2026 10:44:38 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1778661878;
 b=TbeHTaNk6Amw8noYtMi2d5Sbs4vGJkHqZ3+vkyp4tM/Dx09kD5I0qFZoFrXd2PE0yPSNw
 fxXMT/1rL3UhbP+3T67dRU9Vs4Q6x7PUVDZeI2Ug2CjOEsqvur21fAGxTinyCIv0UOMdK/s
 Qa0b+8VbWLIN0ZGiKsmYPTc3v5FQDvQ=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1778661878; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=pC44xmObWAdQVYkDuZ9iW8v5zzxJa87vZywkn5SDdlY=;
 b=1ROWjsyRiMvyBDtclR4KdcPpEWhwO8Kj+O9qJhNj3IftYi5dqo9MG/oAZ8HrqAcwp8yJH
 kvuKKsaP5uhQTPvO1GzJEOFkn7w2k1VkEUuLMqTwiqBf1Ls11jwrzk9GjvqZc9EgdQCrFXA
 2AlUWrhJFKEEEW01dOjtM5Nx/J+6xng=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 0DAE6825F5
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 13 May 2026 10:44:05 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1778661855;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=pC44xmObWAdQVYkDuZ9iW8v5zzxJa87vZywkn5SDdlY=;
	b=hsoH6MZqrSzRDvCtmocBhvVH8r7078xKOVADS157FcpSGxjtp8bSWi1y01Y9On8qWc/NTH
	La7Tq+wjnxrDDn3XGMjtMZDECArsLhjaEsa7nvNIzKIbRV7nAqU3IXD0ak4clDDnsA63Kz
	P8adbGDyOpFrJFTAdtF1qln70jlZepc=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=pYX6lzWK;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1778661855;
	b=hV4x9ncwYsU+dDKdJkZ4vrwIzHJOiH5NtEOMlA2naLQf7HWRi+9ALSG+t5YjixNnTuuyLO
	dRWG+ZrAZJyGC0QN+J2zSlp+Ea891uCbtYln5y03MGEdrn2f+ih+cVh33ZsidiQMxKRhQg
	H63vGDQOhkqB9C3WspYr+jVE3E5KUAo=
Received: by dvalin.narfation.org (Postfix) id 1D481200D8;
	Wed, 13 May 2026 08:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1778661839;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=pC44xmObWAdQVYkDuZ9iW8v5zzxJa87vZywkn5SDdlY=;
	b=pYX6lzWKK9b6GPqod4DCWTvWkEhMMngT/z+G7Hy/ucabIC5+Oo3t0IWD3EB2pk1RtUAAPK
	SpBzoW6mAkhovsJvYOOSYov60ADOIH9yARjtNPPFgQ+BcAI+vsSZh7LS3aE1IOm1ND2/iK
	F3vBiD53NEBYcFJX1EPMonvxf8V5OUc=
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 13 May 2026 10:43:54 +0200
Subject: [PATCH batadv v2] batman-adv: tp_meter: directly shut down timer
 on cleanup
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260513-tp-shutdown-v2-1-fe4082fec691@narfation.org>
X-B4-Tracking: v=1; b=H4sIAMk5BGoC/1WOQQ6CMBREr0L+2pq2CBVW3sO4+NBfqIktaQuaE
 O5u0Y0u32TmZVaIFCxFaIsVAi02Wu8yyEMB/YhuIGZ1ZpBc1rwSJUsTi+OctH861pyxq2SpRK9
 qyIspkLGvj+0KHSbUC9y+eZy7O/VpV+1NE/yDpTEQ/tr5n30RTDCluJGo5Ylkc3EYDKb88OjDA
 Nv2Bm1+DM6+AAAA
X-Change-ID: 20260513-tp-shutdown-98ab52371c76
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2315; i=sven@narfation.org;
 h=from:subject:message-id; bh=Yy4WcpeaM9m0NyEEfHtEVcYFh+QfFm8pzLIgN9ZqtDM=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFkslmeS9b7Gvmt/6PhdV/P1JsaCVo0Hh0OWx07PPpL9L
 7W12Meuo5SFQYyLQVZMkWXPlfzzm9nfyn+e9vEozBxWJpAhDFycAjCR6kOMDOvW79jjuLw5sJmL
 6ZC65ZPuf0EbN58x1S1+u9Wn9+FcU26G/9F35jZvUps9Wc//yv+zd9/bn2l4NXFd3kGhxjNr/pr
 3OzIBAA==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: QBPIUHCXQ7UMV5MLDZ6JLEUGTK6Y3LF7
X-Message-ID-Hash: QBPIUHCXQ7UMV5MLDZ6JLEUGTK6Y3LF7
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/QBPIUHCXQ7UMV5MLDZ6JLEUGTK6Y3LF7/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

batadv_tp_sender_cleanup() was calling timer_delete_sync() followed by
timer_delete() to guard against the timer handler re-arming itself between
the two calls. This double-deletion hack relied on the sending status being
set to 0 to suppress re-arming.

Replace both calls with a single timer_shutdown_sync(). This function both
waits for any running timer callback to complete (like timer_delete_sync())
and permanently disarms the timer so it cannot be re-armed afterwards,
making re-arming prevention unconditional and self-documenting.

The re-arming property is also required because otherwise:

1. context 0 (batadv_tp_recv_ack()) checks in
   batadv_tp_reset_sender_timer() if sending is still 1 -> it is
2. context 1 changes in batadv_tp_sender_shutdown() sending to 0 and in
   this process forces the kthread to stop timer in
   batadv_tp_sender_cleanup()
3. context 0 continues in batadv_tp_reset_sender_timer() and rearms the
   timer -> but the reference for it is already gone

Fixes: 98d7a766b645 ("batman-adv: throughput meter implementation")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
Changes in v2:
- modified commit message to make clear it is a fix
- Link to v1: https://patch.msgid.link/20260510-tp-shutdown-v1-1-770f2ad24e29@narfation.org
---
 net/batman-adv/tp_meter.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/net/batman-adv/tp_meter.c b/net/batman-adv/tp_meter.c
index ca6c3f63..345e5b35 100644
--- a/net/batman-adv/tp_meter.c
+++ b/net/batman-adv/tp_meter.c
@@ -401,13 +401,7 @@ static void batadv_tp_sender_cleanup(struct batadv_tp_vars *tp_vars)
 	batadv_tp_list_detach(tp_vars);
 
 	/* kill the timer and remove its reference */
-	timer_delete_sync(&tp_vars->timer);
-	/* the worker might have rearmed itself therefore we kill it again. Note
-	 * that if the worker should run again before invoking the following
-	 * timer_delete(), it would not re-arm itself once again because the status
-	 * is OFF now
-	 */
-	timer_delete(&tp_vars->timer);
+	timer_shutdown_sync(&tp_vars->timer);
 	batadv_tp_vars_put(tp_vars);
 }
 

---
base-commit: 57c6af492c1948145db835bb3ea2980472558298
change-id: 20260513-tp-shutdown-98ab52371c76

Best regards,
--  
Sven Eckelmann <sven@narfation.org>

