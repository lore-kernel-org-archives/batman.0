Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1FD4C4332F
	for <batman@archiver.kernel.org>; Mon, 30 Oct 2023 14:59:09 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id C151280980
	for <batman@archiver.kernel.org>; Mon, 30 Oct 2023 15:59:07 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1698677947;
 b=xHgVoFY3CoXXdgDthotnKuoY34uUELoxR3qHCQ/JnAasoNNfzpPp3dpbplyZHKdYZugkY
 jzE2rvLJMm0rbsh3fE4BijeLk5qqtDdZlkKMFlL0mphk1g7CSDxTQZWATirPIMg9JwDAOhl
 KVDehyr2TRZIh4mBAwSso+J4hHNFIb4=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1698677947; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=EhRLJhQU0qVDvcNeZwurq534dKNVbnrTsBa+TLytE9Q=;
 b=uAZU3IPRhNdH6ROAIQ50KMgFBxblEqG7WxerhN/+/btSkoMpf4yBF4gzXcNi14J/PG9U1
 C5DIWBPafGPpOTLHP9oRVocHywaoE4nh4njlsrbaz8AFqwG/dAu7AOy7+PrIg01huHUoIWF
 IiN22Rcw+MSxef2DUSRmwZJYlMZH/jA=
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
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 103E580980
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 30 Oct 2023 15:59:02 +0100 (CET)
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1698677943; a=rsa-sha256;
	cv=none;
	b=pMfeKHVNWpsLRRlGKvuSnR/QoC4U3zKsArZUgjMtLJXk7FaTB++uRxfo2B85Ps3IwC/P+z
	V7Mjvqd0W8h2fJy4h4DdjX2+rHwLFAvgnZi78OmEMu5POLOvCZaIXXMfoGEuM5OiBe0MLn
	c9I0znb/IInevZwiWjWsAJMsmIPUL1E=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b="dYk/IUbT";
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1698677943;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=EhRLJhQU0qVDvcNeZwurq534dKNVbnrTsBa+TLytE9Q=;
	b=pLvUr3hr7/v5bUcRxDv8HStNmB5Eo1Uv9jH1CIfZ7xwtC2v53eu4wh1ym9K4nIy+MYSyij
	Y5mi16fizx4CahtELvJMNLO4I0ziVA49SLncjQWCbz7pAMJqnnmHJRGlasV8Rb95Gc4s9K
	Iwt+Q8vRG1ZwbDW4UUV4/+WZHwveWYw=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1698677942;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=EhRLJhQU0qVDvcNeZwurq534dKNVbnrTsBa+TLytE9Q=;
	b=dYk/IUbTKB39pV2YeuTV0CUFDQ8EmIY6XZLh7z/SvR62XHB8VQwZiS4wLDPxlPWRAr72Rt
	CH3DKquhu5/1HmifqCLPMVau4fKRyJHlAyzLdbzTEAmWUlpVd/x/0bACYKiOaPg9Wd8BN+
	QRGSFYfuRFn+GUDU/iTDDFOeGlVT2y0=
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 30 Oct 2023 15:58:35 +0100
Subject: [PATCH] batman-adv: Switch to linux/sprintf.h
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231030-sprintf_header-v1-1-2730d63953de@narfation.org>
X-B4-Tracking: v=1; b=H4sIAJrEP2UC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2NDA2MD3eKCosy8krT4jNTElNQiXRPzFDNTM2MzSxMzCyWgpoKi1LTMCrC
 B0bG1tQDITG9LYAAAAA==
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=2879; i=sven@narfation.org;
 h=from:subject:message-id; bh=SZX7A4K1YbV1mF7j76E0TlUetR80iwDVKADQCcYd1Mk=;
 b=owEBbQKS/ZANAwAKAV2HCgfBJntGAcsmYgBlP8Sqh9wqd9qXnEFPN/byXkuXvhxz0BYjeiUOT
 d9dEGxV/nyJAjMEAAEKAB0WIQQXXSuHYSVz3OMy4AJdhwoHwSZ7RgUCZT/EqgAKCRBdhwoHwSZ7
 RiMoD/wMfXt//dWUEicMVJNvQIEd9wGmETE8AmrCBZJm1Yh5HK0Ram6qqvhuhLiQIhd4TJz1/Lj
 DCPl7FVUJB8T4E4dsdQOY8nXdVSbQ8aCnjffdn5PgDrHd/YQKqWx8Glsr41vB0qYI3S+jXLgmRu
 IyO+NyRWzlhaZxMii+PxAQPGIZUp7mLmcV4qJazx0vBdUZgZS4+8pxdJmlWgCdDdpDD5j+E+ySY
 qNsECAnjCPpVEBm0Kxqo9jC0SCcxZUFJAeoiTPL82f0GuhDGQyJcPlZBAMljipejuzjts3LwPWw
 u4HsaMNKROCb5J9e4HQnZpR9Rhgx98W6xRng5nVh4p0PpOc3bkiXhhaS/C1LIC2taHutjPxLo5R
 dfdEbOGGClsp5ZCYejK9og8xhAl8xnd1F0Aj4NSOQkWqQIC+dn+YjdHXcaMkpsLfsSdXvSLM6gp
 aozMTPqVtJ35KIkkyeqjzlgn0mPIyCMlNyP07uWTw5JeVjrapo6YNJD3pCinoumr+2ab3darFWh
 KnT0zKMsHR1yE6QbBlv3hDmqrfmk/6tt/ZF+skc1QuAbl8QO1TtQgmDo67rDgM5r+T8HjbWscd3
 k+cwkl+sP8PbkdYxqoeVSAUdB+M8ln8HiLtRZeIzwIyzN1rG8jzppx8kuQxzQq4XOvLwJz4KfgV
 dtCjj0AmO60FPNQ==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: PWYGIB3HOAIYMLKZV2I4GLMHT7DHSSIF
X-Message-ID-Hash: PWYGIB3HOAIYMLKZV2I4GLMHT7DHSSIF
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/PWYGIB3HOAIYMLKZV2I4GLMHT7DHSSIF/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

The commit 39ced19b9e60 ("lib/vsprintf: split out sprintf() and friends")
introduced a new header for the sprintf related functions which were
previously exposed via linux/kernel.h.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/bridge_loop_avoidance.c | 2 +-
 net/batman-adv/gateway_client.c        | 2 +-
 net/batman-adv/main.c                  | 1 +
 net/batman-adv/multicast.c             | 2 +-
 4 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
index 37ce6cfb..5f46ca3d 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -20,7 +20,6 @@
 #include <linux/if_vlan.h>
 #include <linux/jhash.h>
 #include <linux/jiffies.h>
-#include <linux/kernel.h>
 #include <linux/kref.h>
 #include <linux/list.h>
 #include <linux/lockdep.h>
@@ -31,6 +30,7 @@
 #include <linux/skbuff.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
+#include <linux/sprintf.h>
 #include <linux/stddef.h>
 #include <linux/string.h>
 #include <linux/workqueue.h>
diff --git a/net/batman-adv/gateway_client.c b/net/batman-adv/gateway_client.c
index d26124bc..0ddd8b4b 100644
--- a/net/batman-adv/gateway_client.c
+++ b/net/batman-adv/gateway_client.c
@@ -18,7 +18,6 @@
 #include <linux/in.h>
 #include <linux/ip.h>
 #include <linux/ipv6.h>
-#include <linux/kernel.h>
 #include <linux/kref.h>
 #include <linux/list.h>
 #include <linux/lockdep.h>
@@ -29,6 +28,7 @@
 #include <linux/skbuff.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
+#include <linux/sprintf.h>
 #include <linux/stddef.h>
 #include <linux/udp.h>
 #include <net/sock.h>
diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index e8a44991..928c78a5 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -33,6 +33,7 @@
 #include <linux/skbuff.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
+#include <linux/sprintf.h>
 #include <linux/stddef.h>
 #include <linux/string.h>
 #include <linux/workqueue.h>
diff --git a/net/batman-adv/multicast.c b/net/batman-adv/multicast.c
index 27511a06..7686caef 100644
--- a/net/batman-adv/multicast.c
+++ b/net/batman-adv/multicast.c
@@ -25,7 +25,6 @@
 #include <linux/ip.h>
 #include <linux/ipv6.h>
 #include <linux/jiffies.h>
-#include <linux/kernel.h>
 #include <linux/list.h>
 #include <linux/lockdep.h>
 #include <linux/netdevice.h>
@@ -36,6 +35,7 @@
 #include <linux/skbuff.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
+#include <linux/sprintf.h>
 #include <linux/stddef.h>
 #include <linux/string.h>
 #include <linux/types.h>

---
base-commit: 5fecd4a389cea1b9719e9ec480d7257887e0dfdf
change-id: 20231030-sprintf_header-47d656369468

Best regards,
-- 
Sven Eckelmann <sven@narfation.org>

