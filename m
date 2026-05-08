Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FCB3CD3445
	for <batman-adv@archiver.kernel.org>; Fri,  8 May 2026 15:49:01 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id B199F85CCB
	for <batman-adv@archiver.kernel.org>; Fri, 08 May 2026 17:48:59 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1778255339;
 b=OXcxfTPBK3/Vi4lpDcWEMY6fLE+FsIqf9RKEByTbX9fQk3p6BnRwhnXxid0OF2YSNFJmD
 1c9w3rvl+Qj35nllVGCkk8S3oIRoa+OEIx/KSTrbo7p31oxHqU/EE8eXTzxMVYNV/sKeT31
 IQZ+7KR/En2/kUC6byeoEdJ0zI+24vk=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1778255339; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=t2WVnKodF7OA43BNZg/AbdNpLnEVxLugYisgg7uXA3A=;
 b=zfDj9wsU2NtakCc/kfx5amSfC5za3xJixH/2/GCAAhj12P6HITNI0K9Ea0XZp4q+tqblz
 mNkv0I/g0rhUTtc4aW5+CLKCGFxoG38VSFbrxeTmzU3znJ22e5jYXigvtjBDvXEY8es3NoA
 WMY3Syxd9dja6IqTzbe99pDb5FpY/4o=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 5EBC485A9E
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 08 May 2026 17:43:35 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1778255015;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=t2WVnKodF7OA43BNZg/AbdNpLnEVxLugYisgg7uXA3A=;
	b=SSEWz/MS2QmDpBAEJpzrXOSb7hzHO6lVR4JO1fZBwb6pgnyXx72oD5ilYV1g64GrjkLAgp
	obbamhiLeBuULyEh5Ov97KCzY1ShgpbuaFx9u2qZq/xaSDLvxfKR5W8pp8n0DYfF/W5lMS
	jB3h0UHML4fbiGYVKVTUSVPOji38f/E=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=HekLV+e3;
	dmarc=pass (policy=none) header.from=simonwunderlich.de;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 23.88.38.48 as permitted sender) smtp.mailfrom=sw@simonwunderlich.de
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1778255015;
	b=Tjvv2oDW7KqHAM7DWl4k8uXdkSF83kySB5Ef/t9FWkDyHg8glXUAncOIAQHkxVeync+D5J
	RWlKObdxi8w61VTvLGOkCKI82E/LzqPZblUEgG9weFUNd6lCFE+FqeW8kCVJtoDPWuBCB/
	gQbUCi8rhomv5GCzC5r36ldeEXKtxwk=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1778255014;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t2WVnKodF7OA43BNZg/AbdNpLnEVxLugYisgg7uXA3A=;
	b=HekLV+e3twos4FvXcDO/PZmGKBhyVJ5u+/IWhNtiWCQeyYwvIYa6Bya9gdOVId7tQ3ZFMW
	HibHj3QhsCoq2OpA19T7ED93XQuJbrTiiYIFaRv4TA3SaIOiFKKEsUqY53yrkzKuRSkCAL
	CAxgIg+tCpM+31PzcQ8LfvIAr0VqnjUl8xGxmfwubFMKc1rGE1Gwx7RPqAPK2E/ShpUYx+
	pjIYgJ/ZadC+RfWwEtPsJkyvZOuQQ2wpBgMoVpy7B25Y8X03fYbSYHaF4rG6Vd5qT5i2I3
	7RzMIv6AncAu1KKdUy2/TeIk7LqVECu71CRaa2un37U+oviBx/K8Eq3UQpVzvw==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Sven Eckelmann <sven@narfation.org>,
	stable@kernel.org,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net 8/8] batman-adv: bla: put backbone reference on failed
 claim hash insert
Date: Fri,  8 May 2026 17:43:14 +0200
Message-ID: <20260508154314.12817-9-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260508154314.12817-1-sw@simonwunderlich.de>
References: <20260508154314.12817-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: 3DIBTN3K7NNN6VHB3KSFZAY2QWXOSIMJ
X-Message-ID-Hash: 3DIBTN3K7NNN6VHB3KSFZAY2QWXOSIMJ
X-MailFrom: sw@simonwunderlich.de
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/3DIBTN3K7NNN6VHB3KSFZAY2QWXOSIMJ/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Sven Eckelmann <sven@narfation.org>

When batadv_bla_add_claim() fails to insert a new claim into the hash, it
leaked a reference to the backbone_gw for which the claim was intended.
Call batadv_backbone_gw_put() on the error path to release the reference
and avoid leaking the backbone_gw object.

Cc: stable@kernel.org
Fixes: 3db0decf1185 ("batman-adv: Fix non-atomic bla_claim::backbone_gw access")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/bridge_loop_avoidance.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
index 879ab043d57a9..cec11f1251d66 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -723,6 +723,7 @@ static void batadv_bla_add_claim(struct batadv_priv *bat_priv,
 
 		if (unlikely(hash_added != 0)) {
 			/* only local changes happened. */
+			batadv_backbone_gw_put(backbone_gw);
 			kfree(claim);
 			return;
 		}
-- 
2.47.3

