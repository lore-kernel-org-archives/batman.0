Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10393C36002
	for <batman@archiver.kernel.org>; Wed,  9 Apr 2025 07:33:31 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 56E5F83F41
	for <batman@archiver.kernel.org>; Wed,  9 Apr 2025 09:33:30 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1744184010;
 b=fUloQWfS89YsGNIDbgLY8iujB+UCkLX8NsV4rr3KQkgpXyrG3aO8/6Tx5NEYVY6v9zmxm
 kg+Wp0hknn6+zxK8/CvD7N0N6rKBqF8qty6E2ND81L50PI+F1hZPJWDg37lRdifVE7jvTZM
 1EUinPpWK2/J1oNOIDKKuTzupWOzdZM=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1744184010; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=qCIkEQQ1Rqgzg10w8W4QaIrL7cYcXD1HerE/5zsoDKo=;
 b=CgUTFCvTkrMzr5CgtuuQNw4aIf8T/eKBs2USC36V0EgANvg8g6MDJ2t1ZIxeO39cxe2/7
 Gjh0l25Tn8cAV+KsyHXndcX+Odyx4g8q7/qvqdw8mxUe7dxgWXLlyxOhhXqR9ID2sj+5rUa
 +bTMxo+b5hRQtBU0Ivqz4nnQT0o46yg=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=fail;
  arc=pass;
  dmarc=fail (Used From Domain Record) header.from=simonwunderlich.de
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass;
 dmarc=fail (Used From Domain Record) header.from=simonwunderlich.de
 policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 5005B80949
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed,  9 Apr 2025 09:33:15 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1744183995;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qCIkEQQ1Rqgzg10w8W4QaIrL7cYcXD1HerE/5zsoDKo=;
	b=L4nodvxoWmwBsBtyG9UBMwi1lm0OIYejD6h60pHeh0yzFm7G3f7bAb/N5kLGpeqkm0nEll
	/uQb5Vov4KBnlbP9ax2Ho2lKyjiBkzCwq0A0hgr4o812L5fjdAlJVLzh1sztz7UOpkOegK
	/N8pbC7xLLTxV8Ua5EbNgNCoNagVsS8=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=fail reason="SPF not aligned (relaxed),
 No valid DKIM" header.from=simonwunderlich.de (policy=none)
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1744183995; a=rsa-sha256;
	cv=none;
	b=hgZ+OTAZs4LPH0PSRqo3gS9dDwcM9QCo1B+274zSMQ+QTnSswaCjzGA2Kr5IxZq+WNeelz
	9IcTaLiON3e5PjIS2JThbLciJ8sR1IBLNND3ZxVOgKrikAD6EL/xWtCShDLSfUzSwQEJnj
	dRKECg5oLv7Fx0hegbhifsmI5WYfxmk=
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Sven Eckelmann <sven@narfation.org>
Subject: [PATCH net v2] batman-adv: Fix double-hold of meshif when getting
 enabled
Date: Wed,  9 Apr 2025 09:33:04 +0200
Message-Id: <20250409073304.556841-1-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: JPU3ETSMANVTL7EHGJ6JE2KZYHSLVHQS
X-Message-ID-Hash: JPU3ETSMANVTL7EHGJ6JE2KZYHSLVHQS
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/JPU3ETSMANVTL7EHGJ6JE2KZYHSLVHQS/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Sven Eckelmann <sven@narfation.org>

It was originally meant to replace the dev_hold with netdev_hold. But this
was missed in this place and thus there was an imbalance when trying to
remove the interfaces.

Fixes: 00b35530811f ("batman-adv: adopt netdev_hold() / netdev_put()")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/hard-interface.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index f145f9662653..7cd4bdcee439 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -725,7 +725,6 @@ int batadv_hardif_enable_interface(struct batadv_hard_iface *hard_iface,
 
 	kref_get(&hard_iface->refcount);
 
-	dev_hold(mesh_iface);
 	netdev_hold(mesh_iface, &hard_iface->meshif_dev_tracker, GFP_ATOMIC);
 	hard_iface->mesh_iface = mesh_iface;
 	bat_priv = netdev_priv(hard_iface->mesh_iface);
-- 
2.39.5

