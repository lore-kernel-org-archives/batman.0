Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 814D5CCF2C9
	for <batman@archiver.kernel.org>; Sun, 18 Oct 2026 16:43:08 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 9CF31845CF
	for <batman@archiver.kernel.org>; Sun, 18 Oct 2026 18:43:06 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1792341786;
 b=gB1XuWMiLhXoIA14Wl0ZZrLYzqCOFG8p9uq9HGOLAr+n/u7wyvdtsXjBAOdYgI6Cb3XnK
 tZN06snlqYUMYeMNJW+d6Ir5cQlfImPW/tyJZpXpmRjys8xAKLYOpJaqzO0pk5mEEmHnc19
 QMNcpDJykoi6BBPOS8JRTc7jofDdBB0=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1792341786; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=l+AAjF5isX2LBbg9Ogrny17BQRYnYYl4ZsV+b9Tb/3o=;
 b=NVeQKlrHvJOWAMhX045NkEKS3vt9NDvYAiqVZLen1ZnOO+gvvAXs3URvIoJbZKK9dW7sP
 RMlYn+CxdeUb/rJPs2U4O1J6TwieoT/KbPdG7URT64iL3XDoz8BeM6KD0YPC+8qIqu7hza9
 Avqm9CBieGf9ffpqoJuUBABb4YAFzvs=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id B5A53805A5
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 18 Oct 2026 18:42:45 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1792341775;
	b=R54WbiJvc0XLBGfMpGlTS2fuJHgkuYUZLl34eQOF18j134/RTbq9BREW+D40nuAtXREhTs
	wOOb189hw6xXRdjijdGWjDu9na+Sdq1/3vSpe71oYwsk5PJoZ/iRYozcTf3hoJunNCzDNk
	iwaw9e7fdJW64gjDPLvmyplhBTN5kYk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1792341775;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=l+AAjF5isX2LBbg9Ogrny17BQRYnYYl4ZsV+b9Tb/3o=;
	b=GHlcnp7MMXcjLKTwKv7Hsw7N2akYYuX96x1jPmyuWQSyBDCEs2pSVklF5fOZ6Jv5F5ROYT
	EpXi05ZE7q0hia4kuXxYvCUKJD2XvMR7eOtRxDlo6lnHVFsPQFa6VnckjMMNMOC4RukKeH
	7yvXeQv8IKugDmyqJk2tCT/CxZZhnFU=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=2hVBH55L;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id E6BED20320;
	Sun, 18 Oct 2026 16:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1792341764;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=l+AAjF5isX2LBbg9Ogrny17BQRYnYYl4ZsV+b9Tb/3o=;
	b=2hVBH55LoArtv+3OU/BeXG9YUBBDUcATRYqn4rKJf6zc5TjJh5HX6UgpxAwQTWvGc1eN51
	FTyNyG4U2n8wuh9CqX7yJGFhdAlouGG9dHJ45xF9bZwXLfAwfNQLyLhX4PTNxfjQ917kE7
	nLXxg0vvD1eFoAPbONwOodzWo5HQmLc=
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 18 Oct 2026 18:42:40 +0200
Subject: [PATCH batadv] batman-adv: compat: use netns_immutable in Linux
 6.12.114
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261018-stable-netns_immutable-v1-1-73785e05954a@narfation.org>
X-B4-Tracking: v=1; b=H4sIAP/21GoC/yXMUQrCMBCE4auUfTawKWiLVxGRbDPqio2STYtQe
 nejffwG5l/IkBVGx2ahjFlNX6nC7xoa7iHd4DRWU8vtwbPvnZUgT7iEkuyi4zht7tAxR7Dspad
 6fmdc9fMPn0hCCXGm87bbJA8M5Veldf0CNuRP1oIAAAA=
X-Change-ID: 20261018-stable-netns_immutable-7e700de0b5b8
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1905; i=sven@narfation.org;
 h=from:subject:message-id; bh=EPSyACxorPHGwasOQQ766Cxx6L0ITj8VG3bwZ4X5dm4=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFlXvjPeayoOfbU09K/123Kx+GI74fnZT6oiNqfHOPNM9
 W7N2NjSUcrCIMbFICumyLLnSv75zexv5T9P+3gUZg4rE8gQBi5OAZiImiMjQ4vv9qNnD0Q/ZLDy
 +xWxvF5SwV/wWv+H3S0tG76W3FY+JsnIcKG7cHrli4P9gvK8oRy7g0sYSlYcuamzXrXf/NWEWxX
 nuQE=
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: LWBF7FGZXLU5RPBBYHMB6OVAFKXBRZ4Y
X-Message-ID-Hash: LWBF7FGZXLU5RPBBYHMB6OVAFKXBRZ4Y
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/LWBF7FGZXLU5RPBBYHMB6OVAFKXBRZ4Y/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

The commit 0c493da86374 ("net: rename netns_local to netns_immutable") was
backported back to Linux 6.12.114. batman-adv must therefore stop to use
netns_local for newer 6.12.y kernels.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 compat-include/linux/netdevice.h | 7 +++++++
 net/batman-adv/mesh-interface.c  | 7 ++-----
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/compat-include/linux/netdevice.h b/compat-include/linux/netdevice.h
index 45df743e..992f1dcf 100644
--- a/compat-include/linux/netdevice.h
+++ b/compat-include/linux/netdevice.h
@@ -16,4 +16,11 @@
 
 #endif /* LINUX_VERSION_IS_LESS(6, 0, 0) */
 
+#if LINUX_VERSION_IS_LESS(6, 15, 0) && \
+    !(LINUX_VERSION_IS_GEQ(6, 12, 114) && LINUX_VERSION_IS_LESS(6, 13, 0))
+
+#define netns_immutable netns_local
+
+#endif /* LINUX_VERSION_IS_LESS(6, 15, 0) */
+
 #endif	/* _NET_BATMAN_ADV_COMPAT_LINUX_NETDEVICE_H_ */
diff --git a/net/batman-adv/mesh-interface.c b/net/batman-adv/mesh-interface.c
index 41d14863..d1263c77 100644
--- a/net/batman-adv/mesh-interface.c
+++ b/net/batman-adv/mesh-interface.c
@@ -1090,13 +1090,10 @@ static void batadv_meshif_init_early(struct net_device *dev)
 	dev->priv_destructor = batadv_meshif_free;
 	dev->features |= NETIF_F_HW_VLAN_CTAG_FILTER;
 	dev->priv_flags |= IFF_NO_QUEUE;
-#if LINUX_VERSION_IS_GEQ(6, 15, 0) // UGLY_HACK_NEW
+#if LINUX_VERSION_IS_GEQ(6, 12, 0) // UGLY_HACK_NEW
 	dev->lltx = true;
 	dev->netns_immutable = true;
-#elif LINUX_VERSION_IS_GEQ(6, 12, 0) // UGLY_HACK_OLD
-	dev->lltx = true;
-	dev->netns_local = true;
-#else
+#else // UGLY_HACK_OLD
 	dev->features |= NETIF_F_LLTX | NETIF_F_NETNS_LOCAL;
 #endif // UGLY_HACK_STOP
 

---
base-commit: c1d440f3d066942932a55866a5f69bd4d486a5b7
change-id: 20261018-stable-netns_immutable-7e700de0b5b8

Best regards,
--  
Sven Eckelmann <sven@narfation.org>

