Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68847CD6E4A
	for <batman-adv@archiver.kernel.org>; Thu,  4 Jun 2026 04:44:30 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 13A3580E2D
	for <batman-adv@archiver.kernel.org>; Thu, 04 Jun 2026 06:44:29 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1780548269;
 b=EZcftzqmq+uVIf47m7i2JNbQBybYADf+c78tLwRxeGhQ0BD62+MrfCtxWtx0EObSJkTjl
 GN6ATrcBCjltGYZ9mloEI5oij32ib1lVpKM3Wxajrcw1yX27dI/VxHtG+QHZROy+RokO9dm
 WdHFIZEG4kziMRK+AjVfSrLFJw7afCU=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1780548269; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=aBUrkYKBOKeUCTdi8P17orGA/ahfJlY04fpNJxMmR2Y=;
 b=XQAphVsEQy6bo7VlH3WEzf2mZaCLvx4+uvC03OKfqqwN5fnZBup6m7NbqApivn843pLna
 L2aJYschIXurja5Py1+vm0XRZU8JKfSyC1T2tOyi6GINXLyFOdIOCnVdi+xw/dyYIhGE0N4
 YChZDD6v+BMGRAztCrz88pLF9mwdnBw=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 28F868473F
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 04 Jun 2026 06:41:14 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1780548074;
	b=SMZvptkGBgcnxQ6HjoW8AKXo84mPAN+l4qhH/XjaEmD1y3ovyXN/PT7z2L5DK5N580Kv5I
	Frr0MGlNQhQzzn0rN3dNoXVLPHt2MKmzEsjh4WNvDTd5uTfrt0o3BLU86h9gpZE9mDxS92
	4s1grLLI4f9HjC/jrbXCu+/I//Mk90k=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=01u0B9ab;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1780548074;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=aBUrkYKBOKeUCTdi8P17orGA/ahfJlY04fpNJxMmR2Y=;
	b=ae+R+7A5NpltAmGcoUMYGbHSwGN7NQaldmS4iPiFPX6s+M1b57khFT0eN0bzeqHlchnSzq
	iQeoqroZA8grsQDSBfTZNLtjKEJfqCS/z2lIGcN0wLB9+wvyohT6mwWt9CJhjYi11iUMek
	LFMIbrDP8UhySOPhJJ2A+WYETYGdb/Y=
Received: by dvalin.narfation.org (Postfix) id D45411FEF0;
	Thu, 04 Jun 2026 04:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1780548073;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aBUrkYKBOKeUCTdi8P17orGA/ahfJlY04fpNJxMmR2Y=;
	b=01u0B9abkgsbDYyDpBfviW3cofcAWged0JPO7cJdD2fySH/O0z8lTXFpRZZENEj7mMrQe8
	C9n0e/6HhoI6yyQStj2Kif0XLKUjF7yVQjK2wiDm9vva70/4L9lGKNGJvHn1SYrCs33Chg
	Y9QTY5pCHGX2w0CFhHf96UHuU/B7Klo=
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 04 Jun 2026 06:40:50 +0200
Subject: [PATCH batadv v2 1/4] batman-adv: correct batadv_wifi_* kernel-doc
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260604-wifi-cache-cleanup-v2-1-c89d32c02471@narfation.org>
References: <20260604-wifi-cache-cleanup-v2-0-c89d32c02471@narfation.org>
In-Reply-To: <20260604-wifi-cache-cleanup-v2-0-c89d32c02471@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2559; i=sven@narfation.org;
 h=from:subject:message-id; bh=130HPFjYJb+egdE8B47+hXnQjkI48OUcSm8V18NPrGc=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFmKjJe7o/kmtq75Wcq1STu6eIrtvTvzTd0E9/yKuaTyf
 5n+yc2LOkpZGMS4GGTFFFn2XMk/v5n9rfznaR+PwsxhZQIZwsDFKQATMTzB8E+r4+uB+qdu5Us5
 OP++nJktz/BbbcX9nEk/Chef9/niV3CSkeHfZ+sn5/o5I0xn6rOqNGkdeX+yazXL44i99cInXB/
 v6GYFAA==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: BWDOTVFSEZ5LCPTSP5WZN3MPBILKXH6K
X-Message-ID-Hash: BWDOTVFSEZ5LCPTSP5WZN3MPBILKXH6K
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/BWDOTVFSEZ5LCPTSP5WZN3MPBILKXH6K/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

The original kernel documentation for the batadv_wifi_* functions contained
copy+paste errors. Correct them to make it easier understandable.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/hard-interface.c | 6 +++---
 net/batman-adv/hard-interface.h | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index 43ebf86e..d4a351b0 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -971,9 +971,9 @@ static int batadv_hard_if_event_meshif(unsigned long event,
 /**
  * batadv_wifi_net_device_insert() - save information about wifi net_device
  * @net_dev: net_device to add to batadv_wifi_net_devices
- * @wifi_flags: net_device which generated an event
+ * @wifi_flags: extracted batadv_hard_iface_wifi_flags of a net_device
  *
- * Return: 0 on result, negative value on error
+ * Return: 0 on success, negative value on error
  */
 static int
 batadv_wifi_net_device_insert(struct net_device *net_dev, u32 wifi_flags)
@@ -1007,7 +1007,7 @@ batadv_wifi_net_device_insert(struct net_device *net_dev, u32 wifi_flags)
 
 /**
  * batadv_wifi_net_device_remove() - remove information about wifi net_device
- * @device_state: wifi net_device state to remove from batadv_wifi_net_device_state
+ * @device_state: wifi net_device state to remove from batadv_wifi_net_devices
  */
 static void
 batadv_wifi_net_device_remove(struct batadv_wifi_net_device_state *device_state)
diff --git a/net/batman-adv/hard-interface.h b/net/batman-adv/hard-interface.h
index 822e7e37..af31696c 100644
--- a/net/batman-adv/hard-interface.h
+++ b/net/batman-adv/hard-interface.h
@@ -126,7 +126,7 @@ batadv_primary_if_get_selected(struct batadv_priv *bat_priv)
 /**
  * batadv_is_cfg80211() - check if the given hardif is a cfg80211
  *  wifi interface
- * @wifi_flags: extracted batadv_hard_iface_wifi_flagss of an net_device
+ * @wifi_flags: extracted batadv_hard_iface_wifi_flags of a net_device
  *
  * Return: true if the net device is a cfg80211 wireless device, false
  *  otherwise.
@@ -143,7 +143,7 @@ static inline bool batadv_is_cfg80211(u32 wifi_flags)
 
 /**
  * batadv_is_wifi() - check if flags belong to wifi interface
- * @wifi_flags: extracted batadv_hard_iface_wifi_flagss of an net_device
+ * @wifi_flags: extracted batadv_hard_iface_wifi_flags of a net_device
  *
  * Return: true if the net device is a 802.11 wireless device, false otherwise.
  */

-- 
2.47.3

