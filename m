Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D069CA5FB1
	for <batman-adv@archiver.kernel.org>; Wed, 30 Sep 2026 09:48:17 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 0952981ED2
	for <batman-adv@archiver.kernel.org>; Wed, 30 Sep 2026 11:48:16 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1790761696;
 b=F7ebPSMvDo6VPDr+bxfG9XT7dH1XuiG3Gts5+MqSvdpvHjcmPzgksoY6hgZvroh8ofs4o
 zOrG4Eu2dUuH8dYHLfvWKYQpXLxv8ZDebZV0NFKv8IvT+XFWVbx1aM705BbQOfHyWTPyP26
 rzxjiHnQ3mnZi/ioaMmrweeUp/34z94=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1790761696; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=5s65kUEIQ6lts0wP4b/pMJdL00+yeUg9JgdP+cJ2r+E=;
 b=JJofWWafphMmgygzBWHXxsR6v9ilP4oRaNBAFHg38VQ/j+9fyX9JbBVHEgACfpBYa+IXG
 ClNJL3Zlj18BfbLD8GUqkKqWLq4eZJo3pGtvk/cOlk7yYdYKiKMPTuSri279/vPSp3F//ua
 KKyGkfS7VbsgHYFDKkOY1U9bdTkx+P8=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de
 [IPv6:2a01:4f8:c17:e8c0::1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 6635781CD4
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 30 Sep 2026 11:46:04 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1790761564;
	b=GEC1gNrnPuAwoYaYQtbFCWdQoVVicr7roIiJmZvDR4uibEswO+hT9O6bnKJn6t3Tgsz3Vr
	DHHVztAV57/dEyqXUgydO2pb3y69fsr/n6UawgD2rJ+TJbtnj63JyA5QmbWCbAB1MbdtQT
	46CgjjX5YU6rBwNDyz7kXXVQlWdS818=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1790761564;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=5s65kUEIQ6lts0wP4b/pMJdL00+yeUg9JgdP+cJ2r+E=;
	b=DOUCeHnBOucv7J1TrEOWyns0RRg6Q5h6pCs7xr2PiQqsPYFuWOFVv+09v1agYMhg6LSSIU
	L19aJGZBcVIJARnhxe/P/UtQMyuRGVbaUGtmZ2MHS6mytkKSe2WgHaSNih3Q0zifs9Ctq3
	DOrlyeZPL755INtAg7CKuBdzV7tjFqU=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=e4KWLpEr;
	dmarc=pass (policy=none) header.from=simonwunderlich.de;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 2a01:4f8:c17:e8c0::1 as permitted sender) smtp.mailfrom=sw@simonwunderlich.de
Received: from kero.packetmixer.de
 (p200300C5970e81d8CF20e45A7328d917.dip0.t-ipconnect.de
 [IPv6:2003:c5:970e:81d8:cf20:e45a:7328:d917])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with UTF8SMTPSA id 5E3F6FA1B1;
	Wed, 30 Sep 2026 11:46:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1790761563;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5s65kUEIQ6lts0wP4b/pMJdL00+yeUg9JgdP+cJ2r+E=;
	b=e4KWLpErfZYR/+NkF+SFWZab7WqucmE9TZeA/3WQVN2ePjceeZXLuryDHaFTETg/IMSoUi
	hCrhPU23qL1VO+kubijT2OhFLpVlO27V4doIMwibnCqxIdrYb5lqAcQzCI/Qd0xS6/mRMH
	R83SQsE2dWB2MFsQloLIgjL9GrI1dIoIpZH8V5NlFl26DFAmNRWzYOpKut/Fagee5iZdl0
	SeETHjy+f+T0EOJf1H409fXp6IvYzx2Hasl8N9HJ8Mo8jCEreSqIWCiZQRePqgYTCgJvkC
	wBF6gD7zdUr0lC/nsMX1wS44F52o9ksBORX5NK2OvBqdwPhrKHeDMC0SURYXZQ==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Sven Eckelmann <sven@narfation.org>,
	Sashiko <sashiko-bot@kernel.org>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net-next 4/9] batman-adv: tt: soften kernel-doc for
 batadv_tt_local_remove_now()
Date: Wed, 30 Sep 2026 11:45:53 +0200
Message-ID: <20260930094558.3723766-5-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260930094558.3723766-1-sw@simonwunderlich.de>
References: <20260930094558.3723766-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: ALVZBEEDD6X76QSAPM3G75IWBLIBSPTU
X-Message-ID-Hash: ALVZBEEDD6X76QSAPM3G75IWBLIBSPTU
X-MailFrom: sw@simonwunderlich.de
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/ALVZBEEDD6X76QSAPM3G75IWBLIBSPTU/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Sven Eckelmann <sven@narfation.org>

The "never announced" statement is too harsh for an entry which could have
been actually be announced by a different context while the
batadv_tt_local_remove_now() is in the process of being called. "not yet"
might be more appropriate.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260907081824.2474040-1-sw%40simonwunderlich.de?part=11
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/translation-table.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 78f032c9ad65c..354d9416c1b75 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -1478,13 +1478,16 @@ batadv_tt_local_mark_removed(struct batadv_tt_local_entry *tt_local_entry,
 }
 
 /**
- * batadv_tt_local_remove_now() - purge a local entry which was never announced
+ * batadv_tt_local_remove_now() - purge a local entry which was not (yet) announced
  * @bat_priv: the bat priv with all the mesh interface information
  * @tt_local_entry: local TT entry to purge
  *
- * A client which was added right after the last ttvn increment was never sent
- * to the other nodes. It can therefore be dropped from the local table without
- * waiting for the next ttvn increment.
+ * A client which was added right after the last ttvn increment was not (yet)
+ * sent to the other nodes. It can therefore be dropped from the local table
+ * without waiting for the next ttvn increment.
+ *
+ * If it was still announced by a parallel context before it was removed from
+ * the hash, then the local TT size adjustment will be handled automatically.
  */
 static void
 batadv_tt_local_remove_now(struct batadv_priv *bat_priv,
-- 
2.47.3

