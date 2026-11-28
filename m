Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FDD1606A31C
	for <batman@archiver.kernel.org>; Sat, 28 Nov 2026 11:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.a=rsa-sha256 header.s=20121 header.b=c4pEUqwH
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 9C2E384289
	for <batman@archiver.kernel.org>; Sat, 28 Nov 2026 12:14:34 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1795864474;
 b=RbIu3L8mfpIAKyWjAypazzGUOsQh1DJdqo4BDD2wx2hqxBk1WCpbFSrDK/jXj0/6QnUEg
 8/Pc0cAENNHfRljNVPd2jw5F60QQZ62hiPmlUEaJ238ul/DM1K1/siPE7AAPdeXE3hGR3XK
 +OFYwk1oE4J3/+JdnFlVijBQ/64Gy3w=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1795864474; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=NYKCYqIcp2M3riJpZNByjEIMe6MYluMz4Ci9fCQsfcg=;
 b=cV05ZArUmmGdkC6BKX0sM8iONOy4WqoxeEwbtHWaH0Nu45D6zsKf2JKY0jK8XFjo1YGoh
 GdMRagbNXfrR4oWZEDKbq/8lhZpT53AmjexqUmXzZiMJS0UkSdIC4x4UayVbfh4TtPAOYfk
 1RMsPfl1Shiyy9mLblYE3cx9PEjqtCQ=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id BF3B4803F9
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sat, 28 Nov 2026 12:14:26 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1795864467;
	b=JqOaE/D5Hz1M04m6NKdwMTUfPvS8K4BdRELomI0HjzVnbhqySfSm3ppRWgB8gRHVEBYXDF
	pqxFNi9aIP7HEV6waFqhN0tzVfh0Lo2l8GvgKoQt9M1WMrjvSBM/dO5ek/XXLs1hYndkdZ
	jjGIqWr/LL/JSnn/AZPD/hgjPryTYp8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1795864467;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=NYKCYqIcp2M3riJpZNByjEIMe6MYluMz4Ci9fCQsfcg=;
	b=hxkIwEzbLNIZoZZl75aEUPLfU+B+pZqlysqzdS8QlN/YHCkSY7kZdcLGGn8ds7gInR3JKI
	bTT5nLdTbNm/rjB3qDsIz6JFcRwvZnEaahUWovctCgvm0IoPBFYnJkBSNPv/zwEe0k2Fpg
	h89tSw2CQ2ElIMgtSmo1vzupUYOwSZg=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=c4pEUqwH;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 1AF8E202C1;
	Sat, 28 Nov 2026 11:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1795864466;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=NYKCYqIcp2M3riJpZNByjEIMe6MYluMz4Ci9fCQsfcg=;
	b=c4pEUqwHFS1Rc60RcHW84jifsjW8CPuyffRDoXW5Xre9yu6b/ilmbQK0oQeJhdFNrsSTnR
	BfV3LrM2r5gCnVCPNc/HWqfMK9aeaComhbjgmzDXuGutXYZ08wBZVx78uyAeQ+NbCTjPDI
	KCTzIxnpfU4mKMBMcXv+zjHYWXnYFpU=
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 28 Nov 2026 12:14:23 +0100
Subject: [PATCH batadv] batman-adv: remove unused debug log setup
 declarations
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261128-unused-log-helper-v1-1-e43ca94fbf92@narfation.org>
X-B4-Tracking: v=1; b=H4sIAI63CmsC/yWMQQqDMBAAvyJ77oJZaJB+pfQQk41ukShZI4L49
 0Z7nIGZA5SzsMKrOSDzJipzqmAeDfjRpYFRQmWglqwx1GFJRTngNA848rRwRh+jI3ra1sYOard
 kjrLfzzf0bnVhg8/fa+m/7NdrCOf5AwF4MXV9AAAA
X-Change-ID: 20261128-unused-log-helper-cffa225606f8
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1245; i=sven@narfation.org;
 h=from:subject:message-id; bh=TyDH3hXZwv2NNMR/v7eGl8Soto3lpvYU29s1pc1ok0g=;
 b=kA0DAAoWTQ93K9MU9csByyZiAGsKt4+gKOTAuJw/UTa49UdFpUWN1joyPl0z5IXeKoHZNJGHW
 oh1BAAWCgAdFiEEvNRvz7MH7R/zlvHFTQ93K9MU9csFAmsKt48ACgkQTQ93K9MU9csrJQEAhj0O
 /0ZysfWVJ9VyszLQPeBSLKp7KuMsjsR/wz0tJP4A/2bwf/XoI2T3Vwy/6jUklUh/issUuP1m4ID
 BeFjlflwK
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: ZOGQ6A47QHSCLH775WWBF5ADAZXVPTJN
X-Message-ID-Hash: ZOGQ6A47QHSCLH775WWBF5ADAZXVPTJN
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/ZOGQ6A47QHSCLH775WWBF5ADAZXVPTJN/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_NONE,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The commit 2048931015ae ("batman-adv: Drop deprecated debugfs support")
removed batadv_debug_log_setup() and batadv_debug_log_cleanup(). Their
declarations and the inline stubs for !CONFIG_BATMAN_ADV_DEBUG were kept
in log.h. Nothing uses them anymore. Remove them.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/log.h | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/net/batman-adv/log.h b/net/batman-adv/log.h
index 9f3aed82..03a48d9e 100644
--- a/net/batman-adv/log.h
+++ b/net/batman-adv/log.h
@@ -14,24 +14,6 @@
 #include <linux/compiler.h>
 #include <linux/printk.h>
 
-#ifdef CONFIG_BATMAN_ADV_DEBUG
-
-int batadv_debug_log_setup(struct batadv_priv *bat_priv);
-void batadv_debug_log_cleanup(struct batadv_priv *bat_priv);
-
-#else
-
-static inline int batadv_debug_log_setup(struct batadv_priv *bat_priv)
-{
-	return 0;
-}
-
-static inline void batadv_debug_log_cleanup(struct batadv_priv *bat_priv)
-{
-}
-
-#endif
-
 /**
  * enum batadv_dbg_level - available log levels
  */

---
base-commit: 11431b38d0cd787a2e988416e7086dc1cf225055
change-id: 20261128-unused-log-helper-cffa225606f8

Best regards,
--  
Sven Eckelmann <sven@narfation.org>

