Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38D7EC43458
	for <batman-adv@archiver.kernel.org>; Tue, 30 Jun 2026 14:08:19 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id D68368188F
	for <batman-adv@archiver.kernel.org>; Tue, 30 Jun 2026 16:08:17 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1782828497;
 b=UY85ayEMV94c+lmSsJfKxt6dwT3Yx6WqmOM+CF+wGsCF8pZ41LUzsyLm/mz34H4N3sb6l
 VFeL0NWuespO/JESQ77bgc6kom4C/+2dnlZIwr1emyOhZf/yJuKTTlUDmoCC1YntRfN0k9c
 z0edjzMPC7mrHbR55K/aXO+QW84pE0c=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1782828497; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=u/E75sGSrVhdcsTOLdjoZhA5gMYxGIzTgWx95/1byPA=;
 b=IzoRMObM9aTx4amfueO6l1g0UgJPssYIRNBluaB9vJ4I46XeLcdeFLN17Khhw90S2y2Q0
 zT9uwKs69sm9M5Mx/Y8hbkCBnk0N4kGQ3U46u5oG1dyxzARnBaKe4ghA0IaBBboQDEiV05G
 Fz70KnqDCe7upk7dXyFqvJjzV9MRM9k=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 2AE3181097
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 30 Jun 2026 16:06:30 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1782828390;
	b=1tX0JXy6c173sCC3G9FlheLMp1T5oIIRTAY0qm53JXmOdZ42ZkQEp5vuQ11XwDc0RH2FI3
	MxrTz+XVh170aJ/+aNcQ2e7ZrhI+FMT/yrq1pN6CIJX+WcF5/y8+/SMnpG8sXCKIKR33QR
	xUBVsEs3pI9o3CZOzp1Q2whZwlayfws=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1782828390;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=u/E75sGSrVhdcsTOLdjoZhA5gMYxGIzTgWx95/1byPA=;
	b=HPSM22+kxCyhZSlzPV6XFf/l5gyVq2rAwmbbdPzKmdz0CSoc2WQUH8qL8sGxhafUIqGhte
	i+8/cIG34p9cjb9ciZTO/yNHPgu801MP5d52Al1dMd6l6ZrscNI7tHik1lS9AtFTHHsQEr
	zWK9PO8PwOfW0PWH2ZM8LDKnbDnparU=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=sdBbiJyr;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 23.88.38.48 as permitted sender) smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1782828389;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u/E75sGSrVhdcsTOLdjoZhA5gMYxGIzTgWx95/1byPA=;
	b=sdBbiJyrt0jRH8fPwdgBr5dJvLJW/9xy/3mzcxiXsVYj3Gc2NpJehao5UBCA/AelTEp49O
	ny/OgMsqjqpc05P92FK+mU9yaKMSteL+VfTVyWgT9AkGbgN4g0ec+8qduD2hlLVnKiPIhL
	vna+q24WW5nXME84s+4/mss7e+XfYPaa1tI/ZtO/I4HW6RM+13yK4VkcDpSpWY5ktSFSsR
	Ivlw13S8qeXA9VPr4y1filaTy8xGFWfO4tFTio2tFTK5M2oPdVPkRKpwe53kK9SBBf/FAJ
	HxNS/e0Hr379ezxynxdriGd0jUAia+ItxufgTTWkgnngiFSoPANqTd9YgjTGDA==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Nora Schiffer <neocturne@universe-factory.net>,
	Sven Eckelmann <sven@narfation.org>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net-next 06/15] batman-adv: drop unneeded goto and
 initialization from batadv_hardif_disable_interface()
Date: Tue, 30 Jun 2026 16:06:14 +0200
Message-ID: <20260630140623.88431-7-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260630140623.88431-1-sw@simonwunderlich.de>
References: <20260630140623.88431-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: REJUSXNOPES7CDAEAR75OVC3F3HV2PPX
X-Message-ID-Hash: REJUSXNOPES7CDAEAR75OVC3F3HV2PPX
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/REJUSXNOPES7CDAEAR75OVC3F3HV2PPX/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Nora Schiffer <neocturne@universe-factory.net>

The only use of the label was too early for primary_if to be set
anyways.

Also move the put of primary_if further up to hold the reference only as
long as necessary, hopefully avoiding the need to re-introduce the goto
label with future code changes.

Signed-off-by: Nora Schiffer <neocturne@universe-factory.net>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/hard-interface.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index 9b8108d464dbc..6fc49ad47fd87 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -835,14 +835,14 @@ int batadv_hardif_enable_interface(struct net_device *net_dev,
 void batadv_hardif_disable_interface(struct batadv_hard_iface *hard_iface)
 {
 	struct batadv_priv *bat_priv = netdev_priv(hard_iface->mesh_iface);
-	struct batadv_hard_iface *primary_if = NULL;
+	struct batadv_hard_iface *primary_if;
 
 	ASSERT_RTNL();
 
 	batadv_hardif_deactivate_interface(hard_iface);
 
 	if (hard_iface->if_status != BATADV_IF_INACTIVE)
-		goto out;
+		return;
 
 	batadv_info(hard_iface->mesh_iface, "Removing interface: %s\n",
 		    hard_iface->net_dev->name);
@@ -857,6 +857,7 @@ void batadv_hardif_disable_interface(struct batadv_hard_iface *hard_iface)
 
 		batadv_hardif_put(new_if);
 	}
+	batadv_hardif_put(primary_if);
 
 	bat_priv->algo_ops->iface.disable(hard_iface);
 	hard_iface->if_status = BATADV_IF_TO_BE_REMOVED;
@@ -874,9 +875,6 @@ void batadv_hardif_disable_interface(struct batadv_hard_iface *hard_iface)
 		batadv_gw_check_client_stop(bat_priv);
 
 	batadv_hardif_put(hard_iface);
-
-out:
-	batadv_hardif_put(primary_if);
 }
 
 /**
-- 
2.47.3

