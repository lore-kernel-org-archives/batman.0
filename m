Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 000D7CA5FE6
	for <batman@archiver.kernel.org>; Sun,  4 Oct 2026 08:22:13 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 6700880DAE
	for <batman@archiver.kernel.org>; Sun, 04 Oct 2026 10:22:12 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1791102132;
 b=l8Yr4LKG7qRkE7poEAouvucQ7kPcgggr8IUVIMWQ7neS3Xyx03T508t6L3BYUtCsxArVH
 tXRUX2Fn93NpMfE5bWWqvrRcybP4rXeU4+deX6m//QfFncc/xxce/kdn7d0fYmH/zYNrEwC
 HKffgmrY3Nie7YysbGtDlNVrUNcvHbs=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1791102132; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=ngOfYLC4uq7e7EY+frrh8BMD9o8mVfQhh0G8oirK6CI=;
 b=yWXdCBtKQaisizryPqnZJb2WgeejPeCSDWH+vzRgf921jQqGI1dQ+PwtRrXJjPG7U5LoC
 0mBkVYMgtRCUpZzb+Gkm27VJRrGWun2wGWMPLeh1pZxiBsms2fBZPkMrObHvR1dbChTmDg/
 g5cUdAoLcvQMhwkOu22x0COFYXbfMpw=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 5BEC880DAE
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 04 Oct 2026 10:22:03 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1791102123;
	b=iTr3O8XotJM8Fe4uYftHkIP687A9izR5Nj2gw1pA0X1i9GDgumb50jQixPQEgl4e3FYOeC
	cwmlSlAa0gdjHYwn4J27a0CqQuwXtlN68X1NBm+2SBDx3dUiLSP8WihVDOrM5hVGueTiiQ
	/4Q1l/UTnZzVPcjJ/BqMDKJiDHUHKGM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1791102123;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=ngOfYLC4uq7e7EY+frrh8BMD9o8mVfQhh0G8oirK6CI=;
	b=rxXHQHXMPLo/TAyZbHxK/aFkjETG1HvLhDuCocw0HiaJJR6swjd8/BWfXJJgNIg1/j6G5j
	AL/RoT8ZDoSkIGsf5uaEMouP28Y+NSv3z7d05rmyzPGKQqdElfAgJ0OhWeCB1eEuAtO6PY
	frmzEGzUMGKTwR5TnBoxeIi+GoLFFw8=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=I+zC2BCM;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 1CC3E1FFBB;
	Sun, 04 Oct 2026 08:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1791102122;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ngOfYLC4uq7e7EY+frrh8BMD9o8mVfQhh0G8oirK6CI=;
	b=I+zC2BCMY5A1AMVPjktLx2OqIJ1JwJeyJeaq6qbkiG0cTm/JW6KDftET7Bch+T0OetAu8u
	10A4/UHltT1pRnLEuel81XclgKL5ORmVARjzBdqS0x+mv8UYwSSddJC26007TzYCXKCugr
	IJmfrd/DRHq0f8brerOhp7CKC3V7Zxk=
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 04 Oct 2026 10:21:58 +0200
Subject: [PATCH batadv] batman-adv: dat: initialize purge work before hash
 allocation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: 
 <20261004-dat-uninitialized-worker-v1-1-c34745e83f1d@narfation.org>
X-B4-Tracking: v=1; b=H4sIAKUMwmoC/yWMQQ6CMBAAv0L27CYtoEG/Yjxs20VXTTHbggTC3
 616nElmVkiswglO1QrKkyQZYgG7q8DfKF4ZJRSG2tQHa0yLgTKOUaJkoacsHPA96IMVQ3NsfOf
 6rrV7KPlLuZf5tz6Do0xhgsvfp9Hd2efvF7btA758OTWEAAAA
X-Change-ID: 20261004-dat-uninitialized-worker-d393c8bf8415
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1496; i=sven@narfation.org;
 h=from:subject:message-id; bh=I/eAeZiWztK3FOXvk3EsoQnDA8prZMBv6DFv8kj4tZQ=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFmHeJa7Olb9SeA9u/SZxTxhx9S19w5VtSrFlgWv2BLic
 H7TgvkTO0pZGMS4GGTFFFn2XMk/v5n9rfznaR+PwsxhZQIZwsDFKQATmevEyNBi0HA9Y5luZrzV
 3MlRilbdubKr/Rfms+s8NPh/5aHLiiCG/4GNVsyufCk+OisajN6XC3ak3GI+/2y+znW5ax47ziV
 f5AIA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: W2PQ67ZPENL5CQM7GJUL22PDLL7WIHZS
X-Message-ID-Hash: W2PQ67ZPENL5CQM7GJUL22PDLL7WIHZS
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/W2PQ67ZPENL5CQM7GJUL22PDLL7WIHZS/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

batadv_dat_init() only initializes bat_priv->dat.work after the hash table
was allocated successfully. batadv_dat_free() unconditionally calls
disable_delayed_work_sync() on it.

This is currently not a problem: if batadv_mesh_init() fails,
batadv_dat_free() is never called. But as this might change in the future,
initialize the delayed work before anything in batadv_dat_init() can fail
to make sure that batadv_dat_free() always operates on an initialized work
item.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/distributed-arp-table.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/batman-adv/distributed-arp-table.c b/net/batman-adv/distributed-arp-table.c
index 74050bff..cd95ce19 100644
--- a/net/batman-adv/distributed-arp-table.c
+++ b/net/batman-adv/distributed-arp-table.c
@@ -894,12 +894,13 @@ int batadv_dat_init(struct batadv_priv *bat_priv)
 	if (bat_priv->dat.hash)
 		return 0;
 
+	INIT_DELAYED_WORK(&bat_priv->dat.work, batadv_dat_purge);
+
 	bat_priv->dat.hash = batadv_hash_new(1024);
 
 	if (!bat_priv->dat.hash)
 		return -ENOMEM;
 
-	INIT_DELAYED_WORK(&bat_priv->dat.work, batadv_dat_purge);
 	batadv_dat_start_timer(bat_priv);
 
 	batadv_tvlv_handler_register(bat_priv, batadv_dat_tvlv_ogm_handler_v1,

---
base-commit: 4fa5cbac90fa7b8936779b4313debb3d89701c59
change-id: 20261004-dat-uninitialized-worker-d393c8bf8415

Best regards,
--  
Sven Eckelmann <sven@narfation.org>

