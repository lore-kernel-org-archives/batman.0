Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CF94CD8C88
	for <batman-adv@archiver.kernel.org>; Sun,  7 Jun 2026 12:58:02 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 7AD9F84436
	for <batman-adv@archiver.kernel.org>; Sun, 07 Jun 2026 14:58:00 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1780837080;
 b=WGJPPPW//JdtoDy9iLi87mHsKCCeLgntwLMUgyTqAQHDNE7SD86DKbYMpyegOzPTNyMPM
 +cSTlCnZvhjaj9SDK6U5V22VQBvkur8S9ia5XXDgRSNeVOo/H2xABrYMPyB43/sksLY9LbW
 T+J/EXVbTbgkeINkLgpzLzuuVr8IWBQ=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1780837080; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=dKVsmrIiNKQg7OUbqKc0MIF8eQSXOAgpwGRmPLkbQzk=;
 b=vkqs3bFYHkC4jQAjPCDiTwJcnH0XFo/g9V2LrBA1tq6eigc5ILvG7y0RIviDOIqrA3Cr2
 1ukyANwLFge7uYjo3BWG8RAU5+qpVoXCk9CAMfC7DQLN1YXSyE/phFuI/G3KYyTmZr0c8Zr
 Rm5Qjn+od9s0hkyxNVU3CqCMKS0jO6Q=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id C48438426A
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 07 Jun 2026 14:57:51 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1780837071;
	b=zbbbZxjYJBR2sdhGTz+A/k17BX9ygGkDNmtVS7NKjEnyiU39mHtdwyPlf+ogCj2c/CUG0p
	01ehn+J/GTyLNBtD+vpsMX/RK8T3um24giKxcHpWeGopLUyPuxhCh6O0Lw6hTEocmn85Kd
	4nvpRDc9D8zvUBmrH+NAYrrhlnuwbAA=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=zPbF4KOd;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1780837071;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=dKVsmrIiNKQg7OUbqKc0MIF8eQSXOAgpwGRmPLkbQzk=;
	b=bME+rUql0BgMvhlLSqK8pLoXt2kvfOE3/6MB6G2K7M+8sUaLxw1F7UjdAml+0bEN7mFs6p
	jtALuCZL6Za2b8NfFMbZ7K90ldV8kZcjJ9/Xtd7xPjTIk3MQyjH6r/8KL+CM7Vk3c6fR9I
	soDnW7RjiLauSgofCUSjPPIpi7dxrC4=
Received: by dvalin.narfation.org (Postfix) id 017181FE3B;
	Sun, 07 Jun 2026 12:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1780837070;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=dKVsmrIiNKQg7OUbqKc0MIF8eQSXOAgpwGRmPLkbQzk=;
	b=zPbF4KOdtKZdlJ/pB+iDq0XVs55jDovMkBXM3ZKaT4cNkF1lsqXT4C6HaKHo71qC0MpeHR
	RxzE73DTqeuPPfjtn0uH/XfSdDDMXVFOtE/DLLQO/9BDRDIZfYi4qVaYbyE82EUG9qHMFF
	LBw0h2GJDY2z/QRzU3CuHZz3XPYTHXY=
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 07 Jun 2026 14:57:44 +0200
Subject: [PATCH batadv] batman-adv: gw: don't deselect gateway with active
 hardif
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260607-gw-disable-check-v1-1-d156beb975ce@narfation.org>
X-B4-Tracking: v=1; b=H4sIAMdqJWoC/yWM0Q6CMAwAf4X02SaTEXT+ivGh6wpUDZoV0YTw7
 0x9vEvuFjDJKganaoEss5o+xgL7XQU80NgLaioMtatb17oD9m9MahTvgjwI37DzPnj21IRjgJI
 9s3T6+S3PEGmiNMPl7+0Vr8LT9wfrugHMkiptfAAAAA==
X-Change-ID: 20260607-gw-disable-check-f3393c3a4989
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Nora Schiffer <neocturne@universe-factory.net>,
 Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1819; i=sven@narfation.org;
 h=from:subject:message-id; bh=Kg8X/HNLxTWd1Gbr8Li6MqUkuMnba3XADsnOlPW4CwU=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFmqWSc3b7L4HW3Pt23d8Q/m3WcW3L2an+fg7HXhbemyx
 /K1N/NmdJSyMIhxMciKKbLsuZJ/fjP7W/nP0z4ehZnDygQyhIGLUwAmYrOJ4X+SXeC2xwG3P1yU
 cPPV26llXtzF6bL2NUMDf08KX0JbjRrDPy2NjtPOXyemRNfEHE1OKHZ1FDv14N+SDpZEh+aopfc
 4mAE=
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: B43LHP7W4QAJ3KHK2B6VFEOUWQJZ5LTT
X-Message-ID-Hash: B43LHP7W4QAJ3KHK2B6VFEOUWQJZ5LTT
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/B43LHP7W4QAJ3KHK2B6VFEOUWQJZ5LTT/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

The batadv_hardif_cnt() was previously checking if there is an
batadv_hard_iface->mesh_iface which is has the same mesh_iface. And since
batadv_hardif_disable_interface() was resetting the
batadv_hard_iface->mesh_iface after this check, it had to verify whether
*1* interface was still part of the mesh_iface before it started the
gateway deselection.

But after batadv_hardif_cnt() is now checking the lower interfaces of
mesh_iface and batadv_hardif_disable_interface() already removed the
interface via netdev_upper_dev_unlink() earlier in this function, the check
must now make sure that *0* interfaces can be found by batadv_hardif_cnt()
before selected gateway must be deselected. Otherwise the deselection would
already happen one batadv_hard_iface too early.

Fixes: 702c52a87eab ("batman-adv: store hard_iface as iflink private data")
Cc: Nora Schiffer <neocturne@universe-factory.net>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/hard-interface.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index 60cee2c2..ae19f144 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -879,7 +879,7 @@ void batadv_hardif_disable_interface(struct batadv_hard_iface *hard_iface)
 	batadv_hardif_recalc_extra_skbroom(hard_iface->mesh_iface);
 
 	/* nobody uses this interface anymore */
-	if (batadv_hardif_cnt(hard_iface->mesh_iface) <= 1)
+	if (batadv_hardif_cnt(hard_iface->mesh_iface) == 0)
 		batadv_gw_check_client_stop(bat_priv);
 
 	hard_iface->mesh_iface = NULL;

---
base-commit: 385b248dd4e46c4ce022adeb1b13e547d1954901
change-id: 20260607-gw-disable-check-f3393c3a4989

Best regards,
--  
Sven Eckelmann <sven@narfation.org>

