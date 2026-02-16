Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 458E7E83823
	for <batman@archiver.kernel.org>; Mon, 16 Feb 2026 19:07:06 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 80141854E6
	for <batman@archiver.kernel.org>; Mon, 16 Feb 2026 20:07:04 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1771268824;
 b=bA7cfTFjyFKuAYwsHjRCGj8aK1VWZ2+olFFo/2IaPawqkLEm1Sao0RLEmRA8J8YZW4TMy
 6dcXFrRBdApMdazMLKZQ1PFcZmJlSbJPpymCfdNRF5byQX3d9os/x2rmZaXJaZXpTudPqge
 CsIo6wZFFb9GcyWHdOza88wV652EUdk=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1771268824; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=HtIaP6K/7agEe3Xuzmw4YLmICfp3WzqCZG4gTPFZBz4=;
 b=bRfYNC/Mzx2M5mPgOrgs3uGHVRA4LJql+Y+CsK4rn82wcL4uJy126WpSv/JhW6Tjrm61b
 EF8TGAABsGyFbvh70Ni/vBNJ8a+6Bd9zf42NtTnGFgknFQ1RONKhSvbGguWUsbod445Yix7
 CS1gsppKjbuhnpdWY2HmzNUXVV1lOZc=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 3275781F64
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 16 Feb 2026 20:06:56 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1771268817;
	b=aS3J58T6AIbPHA08zsXZk7lqYBFOUM/sWwSqO0RdpN0BXOK2hADTG4voapMGqFM/C8hNay
	Fe+DLvlnQmC+hmRlcqhNYWWjKkTBukEuEAo1bTBARopd9rdAh3OAOUoobW/v4sB8/+m00L
	N7MWqq+Oc20dcEUboRDxRbulCKrHqgI=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=1jF5cmIw;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1771268817;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=HtIaP6K/7agEe3Xuzmw4YLmICfp3WzqCZG4gTPFZBz4=;
	b=KNn1lqpQ09K6vdrZz/KoStJWocShv2sY+CORVDB5bGU6avc7KgpvjGfWdy6nM+kc6XCgaw
	d/9tKBXsW4tepI2CZl+4+It3atovFbbAlTY5KQ38lGICLmOWM2TBHO3qlfdaLVToQaX39A
	RXlXQvV4Z7p+JhfJlMgSsvrISX1yPBw=
Received: by dvalin.narfation.org (Postfix) id 1DD0E1FDF9;
	Mon, 16 Feb 2026 19:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1771268815;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=HtIaP6K/7agEe3Xuzmw4YLmICfp3WzqCZG4gTPFZBz4=;
	b=1jF5cmIw/FID8poHoyUF4OMO5g/BQcZYrFXA4EDJ5lOjaMTvhWqpRoKXQC9wnkPmU6Iyok
	iOoeJhr5zqqglgweNCpztZzv2HCSpYcvrWLTklZ2CMqxvUA0/4Rgk19X6ieg3OiPse9Ff9
	kTqAVwpvp+cTleXC6G0tDcuulgN6ag0=
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 16 Feb 2026 20:05:55 +0100
Subject: [PATCH] batman-adv: Avoid double-rtnl_lock ELP metric worker
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: 
 <20260216-double-rtnl-lock-throughput-v1-1-513f66d3b36e@narfation.org>
X-B4-Tracking: v=1; b=H4sIAJJqk2kC/x3MwQrDIAwA0F8pOS9QMxDWXyk7VJvVMNEStRRK/
 32y47u8CwqrcIFpuED5kCI5dZjHAD4saWOUtRtoJDuSsbjm5iKj1hQxZv/FGjS3LeytIhn3tM4
 vll4e+rArf+T87/P7vn8qouKSbQAAAA==
X-Change-ID: 20260216-double-rtnl-lock-throughput-21b36bca629c
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4255; i=sven@narfation.org;
 h=from:subject:message-id; bh=SR1r6Xq2J786PKLwji2pH5Yz1RFOuZgzuPD7sTVl4ns=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDJmTs2Yfj+20qnx207i8u/OSdlojZ676HkPnB66pdZ2qL
 1+JvE3oKGVhEONikBVTZNlzJf/8Zva38p+nfTwKM4eVCWQIAxenAEzkYjAjw5+VDxt+Ox6eW75+
 cnLKLvOZO0JOBNsHGQvJRKvaRs1q7GFkeJSsyy1/yZH7hrLi56NO9vzS192j7cN+/Lpx1OnajV1
 inAA=
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: MVI7PMSVFRAMDOUWNHJUL5PBMYQUV7TV
X-Message-ID-Hash: MVI7PMSVFRAMDOUWNHJUL5PBMYQUV7TV
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
Archived-At: <>
List-Archive: <>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

batadv_v_elp_get_throughput() might be called when the RTNL lock is already
held. This could be problematic when the work queue item is canceled via
cancel_delayed_work_sync() in batadv_v_elp_iface_disable(). In this case,
an rtnl_lock() would cause a deadlock.

To avoid this, rtnl_trylock() was used in this function to skip the
retrieval of the ethtool information in case the RTNL lock was already
held.

But for cfg80211 interfaces, batadv_get_real_netdev() was called - which
also uses rtnl_lock(). The approach for __ethtool_get_link_ksettings() must
also be used instead and the lockless version __batadv_get_real_netdev()
has to called.

Fixes: 405d49a20a20 ("batman-adv: Drop unmanaged ELP metric worker")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/bat_v_elp.c      | 10 +++++++++-
 net/batman-adv/hard-interface.c |  8 ++++----
 net/batman-adv/hard-interface.h |  1 +
 3 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/net/batman-adv/bat_v_elp.c b/net/batman-adv/bat_v_elp.c
index cb16c1ed..fe832093 100644
--- a/net/batman-adv/bat_v_elp.c
+++ b/net/batman-adv/bat_v_elp.c
@@ -111,7 +111,15 @@ static bool batadv_v_elp_get_throughput(struct batadv_hardif_neigh_node *neigh,
 			/* unsupported WiFi driver version */
 			goto default_throughput;
 
-		real_netdev = batadv_get_real_netdev(hard_iface->net_dev);
+		/* only use rtnl_trylock because the elp worker will be cancelled while
+		 * the rntl_lock is held. the cancel_delayed_work_sync() would otherwise
+		 * wait forever when the elp work_item was started and it is then also
+		 * trying to rtnl_lock
+		 */
+		if (!rtnl_trylock())
+			return false;
+		real_netdev = __batadv_get_real_netdev(hard_iface->net_dev);
+		rtnl_unlock();
 		if (!real_netdev)
 			goto default_throughput;
 
diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index 5113f879..1c488049 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -204,7 +204,7 @@ static bool batadv_is_valid_iface(const struct net_device *net_dev)
 }
 
 /**
- * batadv_get_real_netdevice() - check if the given netdev struct is a virtual
+ * __batadv_get_real_netdev() - check if the given netdev struct is a virtual
  *  interface on top of another 'real' interface
  * @netdev: the device to check
  *
@@ -214,7 +214,7 @@ static bool batadv_is_valid_iface(const struct net_device *net_dev)
  * Return: the 'real' net device or the original net device and NULL in case
  *  of an error.
  */
-static struct net_device *batadv_get_real_netdevice(struct net_device *netdev)
+struct net_device *__batadv_get_real_netdev(struct net_device *netdev)
 {
 	struct batadv_hard_iface *hard_iface = NULL;
 	struct net_device *real_netdev = NULL;
@@ -267,7 +267,7 @@ struct net_device *batadv_get_real_netdev(struct net_device *net_device)
 	struct net_device *real_netdev;
 
 	rtnl_lock();
-	real_netdev = batadv_get_real_netdevice(net_device);
+	real_netdev = __batadv_get_real_netdev(net_device);
 	rtnl_unlock();
 
 	return real_netdev;
@@ -336,7 +336,7 @@ static u32 batadv_wifi_flags_evaluate(struct net_device *net_device)
 	if (batadv_is_cfg80211_netdev(net_device))
 		wifi_flags |= BATADV_HARDIF_WIFI_CFG80211_DIRECT;
 
-	real_netdev = batadv_get_real_netdevice(net_device);
+	real_netdev = __batadv_get_real_netdev(net_device);
 	if (!real_netdev)
 		return wifi_flags;
 
diff --git a/net/batman-adv/hard-interface.h b/net/batman-adv/hard-interface.h
index 9db8a310..9ba8fb2b 100644
--- a/net/batman-adv/hard-interface.h
+++ b/net/batman-adv/hard-interface.h
@@ -67,6 +67,7 @@ enum batadv_hard_if_bcast {
 
 extern struct notifier_block batadv_hard_if_notifier;
 
+struct net_device *__batadv_get_real_netdev(struct net_device *net_device);
 struct net_device *batadv_get_real_netdev(struct net_device *net_device);
 bool batadv_is_cfg80211_hardif(struct batadv_hard_iface *hard_iface);
 bool batadv_is_wifi_hardif(struct batadv_hard_iface *hard_iface);

---
base-commit: 35208d1234584c536db431441445ce82f09273f6
change-id: 20260216-double-rtnl-lock-throughput-21b36bca629c

Best regards,
-- 
Sven Eckelmann <sven@narfation.org>

