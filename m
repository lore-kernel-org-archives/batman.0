Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E70B3C282DE
	for <batman-adv@archiver.kernel.org>; Thu, 13 Mar 2025 16:46:38 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 4A91284394
	for <batman-adv@archiver.kernel.org>; Thu, 13 Mar 2025 17:46:37 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1741884397;
 b=ZCls8exXx+VFSa5x43o1dopYzPtS9E3ERkX+yBpsvN1+lkpsJmBeJTh+CjrOhBoIsY4oP
 iaYq9rpvkJRvQlhroTg3Hcl7eKvN9XQhi05VGZ0QQACmiMo0P1qwgrrQCEgEXGq2K7ksRLC
 NIKarjGv8DD8zhQRkzCGWWj3l6BaQwI=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1741884397; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=m2jWoz6226VBLOi1IgPc64xFo8Tth5HlVlnhmL+lVnE=;
 b=HG6z4wah8UICaDm4pBcSrl4P4gT9IfBWfe6rBZke2S9oDhdfLPV3zeW11eQ55x1qRMAAR
 YgnSUaYdZo+kRGMhFjliG/tG870tn0D/tHj+tBPUg3P7uozwW+XOHgAJhGN5ReXP/Kp4c+f
 f8Uhv5j8EQfL4nhkajdhAWdzpZCrjPo=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=fail;
  arc=pass;
  dmarc=fail (Used From Domain Record) header.from=simonwunderlich.de
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass;
 dmarc=fail (Used From Domain Record) header.from=simonwunderlich.de
 policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de
 [IPv6:2a01:4f8:c17:e8c0::1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 04F3182398
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 13 Mar 2025 17:45:24 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1741884325;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m2jWoz6226VBLOi1IgPc64xFo8Tth5HlVlnhmL+lVnE=;
	b=q/0fkPi175zNB8jx8antWtRDKGVm0qgCenfPRrutbkwtYI2FmNy2C+Fw+N9Hffu3KOn4uo
	llH2pggfkeGIn6OAWxX/GCELwqPScQ88orjBiAkjgbGqFtRy+e9TYyl9wHelpxKy/WwrgD
	aD64StrjXgYxR5Hmkz5bWrudj0I14z0=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	dmarc=pass (policy=none) header.from=simonwunderlich.de;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 2a01:4f8:c17:e8c0::1 as permitted sender) smtp.mailfrom=sw@simonwunderlich.de
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1741884325; a=rsa-sha256;
	cv=none;
	b=tN7p8gUQQjLiI+f18o91fuZ660Ax4jl9FvaIAA/2gUv/fiNIl4tvqwqAYgLVOGnt5j3nXh
	4tbGn3c88FFI+PjnT15MDAQp/n+MSx5Zn5T7GhJp3x6kyxVckIptubDg+EosH8cPAN9JlE
	zYjsRHcZpTfPSGgmwVUa9mQWX04o4Ag=
Received: from kero.packetmixer.de
 (p200300Fa272413901A38A4BC9c0De305.dip0.t-ipconnect.de
 [IPv6:2003:fa:2724:1390:1a38:a4bc:9c0d:e305])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id 2F53FFA14B;
	Thu, 13 Mar 2025 17:45:24 +0100 (CET)
From: Simon Wunderlich <sw@simonwunderlich.de>
To: kuba@kernel.org,
	davem@davemloft.net
Cc: netdev@vger.kernel.org,
	b.a.t.m.a.n@lists.open-mesh.org,
	Sven Eckelmann <sven@narfation.org>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 02/10] batman-adv: Drop batadv_priv_debug_log struct
Date: Thu, 13 Mar 2025 17:45:11 +0100
Message-Id: <20250313164519.72808-3-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250313164519.72808-1-sw@simonwunderlich.de>
References: <20250313164519.72808-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: W5LQZKDPZGBGU5LP57FNVOOU7WUHWL6B
X-Message-ID-Hash: W5LQZKDPZGBGU5LP57FNVOOU7WUHWL6B
X-MailFrom: sw@simonwunderlich.de
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/W5LQZKDPZGBGU5LP57FNVOOU7WUHWL6B/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Sven Eckelmann <sven@narfation.org>

The support for the batman-adv ring buffer for debug logs was dropped with
the removal of the debugfs filesystem. The structure storing this ring
buffer is therefore no longer needed since commit aff6f5a68b92
("batman-adv: Drop deprecated debugfs support")

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/types.h | 28 ----------------------------
 1 file changed, 28 deletions(-)

diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index fe89f08533fe..64a0cf4257ed 100644
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
 
-- 
2.39.5

