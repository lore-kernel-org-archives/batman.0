Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6AA5CA5FB1
	for <batman-adv@archiver.kernel.org>; Wed, 30 Sep 2026 09:46:45 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 4F8A1841A9
	for <batman-adv@archiver.kernel.org>; Wed, 30 Sep 2026 11:46:44 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1790761604;
 b=fVdHRJIB6EjPngOAnX2b8O/Vvkk4SPS4XMaCpH9mdDN7BuFvTOCj8dneLHDjUrSSTcudP
 JjYHBCITBsdoLgYymznH8o3unRrguKjwTJUQtjkXLBSQb7PMw/8P4iBosi6vFOeweCXeNbJ
 hgKUqq41TUUtVu5x1BMGajxNi3U7Hec=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1790761604; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=Ckik62FEDM7SnJBf3jmn4RXxhxdn1SStuKJKv5O4BFE=;
 b=NpnLwGTa3q9RKH3908jjGCXgOgT3uUH95v3/2QLTy2FQaK/V9C+aaGeWY5JeQ5OXCslFp
 oT7FgKkeGgJRNliyvMOlKmHfuC1VxMbJWAak65CKxjTt9kt/3+gMbwQkIngqBEgsMxuiuSk
 uhpa/ROPdPL5HC0XsJlPsjsbz9Rnokg=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 04EA080BA6
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 30 Sep 2026 11:46:01 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1790761562;
	b=ImCzhxbmadXTH2vZkzG1PKbE5IRg/W3RoM6QkodIgTIh2txdr1iZBHZT7CuQc8XKhZKYpH
	IkPpyuxfEIqJ7ugKBLxZHcBqCPGt1dlyjA+WhqYCKrNCNwT7AWvS69Y8Q61zQnFlp4MFK4
	+A1+0pzyoZNFvU0O/IyfPuI4tgJDdgU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1790761562;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=Ckik62FEDM7SnJBf3jmn4RXxhxdn1SStuKJKv5O4BFE=;
	b=Ojay0Vghm87a6uKB8N6gJJ+Tt8tIL2CXjcAn5+/XQDrEdDOeyXmCcgVUIRbhi0o3R/yz1Z
	5doiioclhoRS+D1mePWK/4yKLT6OUljdhofC4oX4sobzuRD364GoPVijJnh/KQuj+KAbtP
	qZjooutEkaC3/LX2rFhUE8sL0t42WNc=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=msxMsA10;
	dmarc=pass (policy=none) header.from=simonwunderlich.de;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 23.88.38.48 as permitted sender) smtp.mailfrom=sw@simonwunderlich.de
Received: from kero.packetmixer.de
 (p200300C5970E81d8cf20e45a7328D917.dip0.t-ipconnect.de
 [IPv6:2003:c5:970e:81d8:cf20:e45a:7328:d917])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with UTF8SMTPSA id A8C1AFA010;
	Wed, 30 Sep 2026 11:46:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1790761560;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ckik62FEDM7SnJBf3jmn4RXxhxdn1SStuKJKv5O4BFE=;
	b=msxMsA108AqgIgdQsLRlEmSGcIxIyC40CTCyNa0+wTX5dIIns+WJHUFj2sKOBXxh7y6Wxl
	GMRVohWkB6MPyEHygS0u26vKN86aO5IxqHTt47MuB7zxOj3oESd7ALBJ5mVUMOs6/Bz5pD
	nF6LWZDvUcPtbBdMIE3b4p6obkfCMW20Pp1uiGCRZaWu+AzogtAAhQ+iJ0UkWv6eU+t/hN
	K6iukOAnaEVPhXBeTlbcAUr69Js07/es5/39IIwiFz7fYs4oSu2ZymeyN5C58sSvats+JS
	df1HrVVZt1xrUVxwqkfpmh0On/LlDj5wTR5Uh1WmLmyTr3FawrfRHj7fAk8blg==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Sven Eckelmann <sven@narfation.org>,
	Sashiko <sashiko-bot@kernel.org>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net-next 1/9] batman-adv: bla: avoid double free after failed
 backbone_hash alloc
Date: Wed, 30 Sep 2026 11:45:50 +0200
Message-ID: <20260930094558.3723766-2-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260930094558.3723766-1-sw@simonwunderlich.de>
References: <20260930094558.3723766-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: LCTMMVQLLYEYJ6SSKBLHWHISCKI6IQVI
X-Message-ID-Hash: LCTMMVQLLYEYJ6SSKBLHWHISCKI6IQVI
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/LCTMMVQLLYEYJ6SSKBLHWHISCKI6IQVI/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Sven Eckelmann <sven@narfation.org>

When batadv_bla_init() fails to initialize the backbone_hash, it is freeing
the (previously) allocated claim_hash. The initialization function will
then return an error and the net_device initialization will stop. The
destructor will be called instead and (indirectly via batadv_mesh_free() ->
batadv_bla_free()) will try to free the bat_priv->bla.claim_hash again.

The pointer must therefore be set to NULL after freeing it in the
initialization error path.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260831135117.574836-1-sw%40simonwunderlich.de?part=6
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/bridge_loop_avoidance.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
index ad6ab4a50658f..a96f269da8d37 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -1625,6 +1625,7 @@ int batadv_bla_init(struct batadv_priv *bat_priv)
 	bat_priv->bla.backbone_hash = batadv_hash_new(32);
 	if (!bat_priv->bla.backbone_hash) {
 		batadv_hash_destroy(bat_priv->bla.claim_hash);
+		bat_priv->bla.claim_hash = NULL;
 		return -ENOMEM;
 	}
 
-- 
2.47.3

