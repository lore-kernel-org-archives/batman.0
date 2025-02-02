Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79315C0218F
	for <batman-adv@archiver.kernel.org>; Sun,  2 Feb 2025 09:47:44 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 937ED83F17
	for <batman-adv@archiver.kernel.org>; Sun,  2 Feb 2025 10:47:42 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1738489662;
 b=XMRdVJN7QDRZ0Jrxql/BDlMicT27g5iCIdsYsvMnT4MiZTF03Fss4wBVScfpyV0RczxE7
 6nvEUKahp45eaa0qX2stbLoJKiXPkr7ZGiWi8FX8D1j/jFJj9FGE78qk0B+Gvyg8XMwrLyq
 /mvjaCzAlICk1LjLSuvvcwIxyEp1OSw=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1738489662; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=G5qquneg3b4yMpLgPnrOj5R2hK481RGtZLqzhbtgjnk=;
 b=vBlBeNP1LlCpozZ4w5eGjrOGfII/T7LGaM5SC0Stu0JwIGe2BwpmqUIe8EokLqAiUQgoF
 w54UQBRQ4/91UYnecqd2vHipB5qz8G0mgfkpNYO1W9vi//o8/Ya9BdPhWCQyz+TkjpmmVLC
 MTXJ96/jVJRJ+uRr7aaPHHpkIj27KV0=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=narfation.org
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id A544182398
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun,  2 Feb 2025 10:47:30 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1738489651;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=G5qquneg3b4yMpLgPnrOj5R2hK481RGtZLqzhbtgjnk=;
	b=T5BZ5QFbIPFEcDUaIp6PJQFw49h4fnlYXw2PA/oOklowAo9yZ0IiyQQsVLB8QWDkd+aUYx
	2uPmmJD0dDZuJ6BVC/W2skpjexAzkjSWdskPJY8LH22PHbEG2uf0p4zKKVIgogaVQZBCnq
	nlkPHbIwKKP6c2v18dEpQnKn17N0OcQ=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=KJ0umSYF;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1738489651; a=rsa-sha256;
	cv=none;
	b=QZRFurjcsaJdDJHYeVqARCwZhObbbvT8EJPUGuVO3PBacq8GYm+T5SkwHUb01eYTvHkIQl
	j4iYEjSl/FrX0qD7SVgUOpifOjvAwRXqZOs9pIifuIqvheJNc7qNMDDv23H7XL6GVnnULM
	DYiIr84kiri9rYpybAewZ8DoTgOsY6E=
Received: from sven-desktop.home.narfation.org (unknown
 [IPv6:2a00:1ca0:1d86:2efc::8411])
	by dvalin.narfation.org (Postfix) with UTF8SMTPSA id A90FC2058A;
	Sun,  2 Feb 2025 09:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1738489649;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=G5qquneg3b4yMpLgPnrOj5R2hK481RGtZLqzhbtgjnk=;
	b=KJ0umSYFw+OVaeiEUjcb/UuPtd1a9K3HyGRIV88tqTstqQc0fCqpOmdd1Mz4kQ0/dwRJ+j
	0RvwLtOTbMn4pva3O55MkBcj1EECXeV2VQVWeTrB9/5gtuHEIl1OyDAi8oje67jExJbXub
	ZyDwcJ5l05xLZ4iyS6Ub5BH2la6EMDI=
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 02 Feb 2025 10:47:20 +0100
Subject: [PATCH] batman-adv: Drop batadv_priv_debug_log struct
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250202-unused_structs-v1-1-b87b5dc1efac@narfation.org>
X-B4-Tracking: v=1; b=H4sIACc/n2cC/x2MQQqAIBAAvxJ7TrBCwr4SEeGutRcLNyMQ/550G
 ZjDTAahyCQwNRkiPSx8hipd24A7trCTYqwOve6NrlApJCFc5Y7J3aLQ4DAaa6y3CDW6Inl+/+G
 8lPIBBKTSvWAAAAA=
X-Change-ID: 20250202-unused_structs-d5d375959f9d
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1824; i=sven@narfation.org;
 h=from:subject:message-id; bh=LfrIvwf0DyqHUHkV5SBnA55RbGje1NIeEZabKjPa6tU=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDOnz7TVdX3mK+igYTeC4yxqwa23Z1sQfjOnXzz5XCF6ko
 HbgkppJRykLgxgXg6yYIsueK/nnN7O/lf887eNRmDmsTCBDGLg4BWAi/hmMDIuTl1QJvs52kJxd
 UvLiSmZz5IufBbzyZ2scBK49Vtv2ho2R4UlJwfrsKSvKfnNu37yHofBquv3J9pXn2iQ2rtX78nb
 mQzYA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: J6U3VUWVD7YYAMIVQT6WNYE2K6POY2WJ
X-Message-ID-Hash: J6U3VUWVD7YYAMIVQT6WNYE2K6POY2WJ
X-MailFrom: sven@narfation.org
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/J6U3VUWVD7YYAMIVQT6WNYE2K6POY2WJ/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

The support for the batman-adv ring buffer for debug logs was dropped with
the removal of the debugfs filesystem. The structure storing this ring
buffer is therefore no longer needed since commit 2048931015ae
("batman-adv: Drop deprecated debugfs support")

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/types.h | 28 ----------------------------
 1 file changed, 28 deletions(-)

diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index fe89f08533fe694e137bf31594c60915d4783c7a..64a0cf4257ed4ba3ba264c4c54d05de026df017f 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -1137,29 +1137,6 @@ struct batadv_priv_bla {
 };
 #endif
 
-#ifdef CONFIG_BATMAN_ADV_DEBUG
-
-/**
- * struct batadv_priv_debug_log - debug logging data
- */
-struct batadv_priv_debug_log {
-	/** @log_buff: buffer holding the logs (ring buffer) */
-	char log_buff[BATADV_LOG_BUF_LEN];
-
-	/** @log_start: index of next character to read */
-	unsigned long log_start;
-
-	/** @log_end: index of next character to write */
-	unsigned long log_end;
-
-	/** @lock: lock protecting log_buff, log_start & log_end */
-	spinlock_t lock;
-
-	/** @queue_wait: log reader's wait queue */
-	wait_queue_head_t queue_wait;
-};
-#endif
-
 /**
  * struct batadv_priv_gw - per mesh interface gateway data
  */
@@ -1773,11 +1750,6 @@ struct batadv_priv {
 	struct batadv_priv_bla bla;
 #endif
 
-#ifdef CONFIG_BATMAN_ADV_DEBUG
-	/** @debug_log: holding debug logging relevant data */
-	struct batadv_priv_debug_log *debug_log;
-#endif
-
 	/** @gw: gateway data */
 	struct batadv_priv_gw gw;
 

---
base-commit: dfdce35d69c55b6b5d017a7e800e553089a26eb9
change-id: 20250202-unused_structs-d5d375959f9d

Best regards,
-- 
Sven Eckelmann <sven@narfation.org>

