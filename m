Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAF71C624D3
	for <batman-adv@archiver.kernel.org>; Tue,  1 Sep 2026 16:37:57 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id F3AE481DE4
	for <batman-adv@archiver.kernel.org>; Tue, 01 Sep 2026 18:37:55 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1788280675;
 b=gzBg8Y7iJZ/G/4JImBmxvm69UVsJIaH3CIxfXE0qIbic11gpaVKmHzaJOlElXwwuZOe0k
 9LarViB3Uyhi3446+b6mrhad2kYT26dIEoFd4mvk6iXKGZWkbDnJHKsWpuBUQ4jG1xf0EpZ
 MzWVUun24nWLaEVvtT3iQdFDfjSVy0s=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1788280675; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=6Nh5AF1XYdyehhjEnf5+plXwFaiMDAjJsnRQmS74tJU=;
 b=nHf/7pzYmnAkhcGhXl3KUGaYXv2EZhFy6UrH1xU6MHdawl2SLT8XWXGZu6GgmSabvj37o
 8qRMKlCclo6PQC5B1uQpeMhhcZ43cXOP3GZPdnKP9kxyHn9Dr6nCqKWRS0tEGdiFuKUNn/C
 VFnXmM04ImWxurkUgvA0GezWhDfJkbg=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 91D09802F1
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 01 Sep 2026 18:37:47 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1788280667;
	b=288ihN8Z85M4yAUcqW1gmzJ+6fWdC30vC6uHLQnhZZkYfnK2YCmWE6TV5XJ20prXp7rLRN
	F4CMjvGf87nevZmT1XB/HIAHfFs8WjCXarIxzUOEzdTMqncRN+FsgYZBOmhD8c/dsmXR2+
	D5LkFmpyJ0lHIPyc4l4hRZaFLiXcdsg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1788280667;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=6Nh5AF1XYdyehhjEnf5+plXwFaiMDAjJsnRQmS74tJU=;
	b=vEqbsuhxnsMHxTB/GDOWEnK7y3418tbXnAM8o2f26TUYGQac6MwWutTXo8EmufL7hiLMFM
	+s1SlBmOVxosHrrCWZJQK9m5/mxR2yN7mY6o4viGyWs8Pfpuda/FRFIE9oBpu7WfhdeL0v
	9Q42HAiIyVkpRt2GLeGMQM3sNqMfEKY=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=eE7JlOk5;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 5960020514;
	Tue, 01 Sep 2026 16:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1788280662;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6Nh5AF1XYdyehhjEnf5+plXwFaiMDAjJsnRQmS74tJU=;
	b=eE7JlOk56GKmaZBvAuSvPQv6H5+SoZWMJ5dde1A5BxFAF/cl3z+vmWvhwq21YhwuNu4KY5
	Z6/3t7NsDl3f8K1XRCt43eOsT2t6ncte2UtDOxVMgst6QaJweW3T2jVL//dyTKvilHUfOM
	66R/kyYg25yd6H2PRwozjwSrb4481MY=
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 01 Sep 2026 18:37:38 +0200
Subject: [PATCH batadv] batman-adv: bla: avoid double free after failed
 backbone_hash alloc
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: 
 <20260901-claim-avoid-err-double-free-v1-1-6d6f081f5151@narfation.org>
X-B4-Tracking: v=1; b=H4sIAFH/lmoC/yXMSw7CMAwA0atUXmMpLaJ8roK6cGIHjEqDnDZCq
 np3AixnFm+FLKaS4dKsYFI0a5pqtLsGwp2mm6Bybehc17uzazGMpE+kkpRRzJDT4kfBaCJ4PJw
 CS4ye+z1U4WUS9f3Tr+BpJi4w/H9e/EPC/KVh2z4lKrpAhwAAAA==
X-Change-ID: 20260901-claim-avoid-err-double-free-758cdeffbd63
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sashiko <sashiko-bot@kernel.org>, Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1487; i=sven@narfation.org;
 h=from:subject:message-id; bh=GvpDMzV50mMFk1dPFuH51+ElVhw18Nny+fb0D8efNag=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFnT/geX9L9cn73l8eKt77j+OMQefjxl3lvHN6duBmY5m
 4ikBImHdpSyMIhxMciKKbLsuZJ/fjP7W/nP0z4ehZnDygQyhIGLUwAm0neAkeGKxO2Au0dPMEpV
 CcgoaB3d8NDpX8rG6IkG5tE1CQnCa64yMqzv/ioSMEnujLT8ndxdpvfNmTnvmz7I1lf+mZdk6bD
 GnAkA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: ZIK2UEGJRFYM57FWZVQEX2QUPBO2LKUG
X-Message-ID-Hash: ZIK2UEGJRFYM57FWZVQEX2QUPBO2LKUG
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/ZIK2UEGJRFYM57FWZVQEX2QUPBO2LKUG/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

When batadv_bla_init() fails to initialize the backbone_hash, it is freeing
the (previously) allocated claim_hash. The initialization function will
then return an error and the net_device initialization will stop. The
destructor will be called instead and (indirectly via batadv_mesh_free() ->
batadv_bla_free()) try to free the bat_priv->bla.claim_hash again.

The pointer must therefore be set to NULL after freeing it in the
initialization error path.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260831135117.574836-1-sw%40simonwunderlich.de?part=6
Fixes: 0631e0825c81 ("batman-adv: fix error handling")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/bridge_loop_avoidance.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
index ad6ab4a5..a96f269d 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -1625,6 +1625,7 @@ int batadv_bla_init(struct batadv_priv *bat_priv)
 	bat_priv->bla.backbone_hash = batadv_hash_new(32);
 	if (!bat_priv->bla.backbone_hash) {
 		batadv_hash_destroy(bat_priv->bla.claim_hash);
+		bat_priv->bla.claim_hash = NULL;
 		return -ENOMEM;
 	}
 

---
base-commit: bd881c94108e3fb3f3d9ef7186d74e51afe1e5a6
change-id: 20260901-claim-avoid-err-double-free-758cdeffbd63

Best regards,
--  
Sven Eckelmann <sven@narfation.org>

