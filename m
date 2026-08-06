Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00B84C56207
	for <batman-adv@archiver.kernel.org>; Thu,  6 Aug 2026 15:03:09 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 89E338425F
	for <batman-adv@archiver.kernel.org>; Thu, 06 Aug 2026 17:03:08 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1786028588;
 b=hS9fd13AyU/ej68o1c/WYwNHIGyy/QgU6HWJWoRsgXVChbViq6HCDLmqG89oXLQCl2PYt
 0ZbQgaxeM05GVwLOOvAwD3hiEa5w8NDUbgQU5BELhefksHpdhY1PwcUGAjncDw1foCUidRM
 pU7YBlKvry8cPltIcglsCh2ul7zB77E=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1786028588; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=+ZHWkAEgT30OfPM0REVrekDug59Bs3R/BzIMfrSd1pM=;
 b=zuHEnghP4jhGk+wm2HlW2FFtp78TF6K1hb1On5jnP3rN764dSS+JiQM7pqniOusMVMWZN
 AINR/aaZkRboUgA2hNoVDlORfF3Yp6sj/+nSPmaWqkC0sdBe7C70LkFfZqfWk6RphQXl6IM
 1B36DltJorqS5DIWHo1HsM7a3RxmyD8=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 096E9802A6
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 06 Aug 2026 17:02:51 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1786028572;
	b=V2e3dIrCOYTNfIneiHyMsEgP1PzUZDh6XK3QwHgtEnj+kn7KvWZ203N2+OELh1vmx1bGwA
	qwrQBiq9xjdy1SO5Lq2bHEYoTDmv7Li6xO1v7ONN7Cm6HFnkbutJOFUglEUXkO1zC12Xn1
	ue6frCsYkVdvzfu6QosQVVtAl70KnfY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1786028572;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=+ZHWkAEgT30OfPM0REVrekDug59Bs3R/BzIMfrSd1pM=;
	b=VfgRjF1A3gjGPtjOIPhTzJ0waFslzE9YHa23ujKPrU+ZpmonTdjWs/iq3BKh0vEAurHYqe
	RVZlGEf7BX4THKt7rII3BIgSGB9m6inFbFoAutcuSzMLZ3lpAfeUyS9vM4ucnpEonWpfpL
	WEOXKvLz6BnogEmeQ49VCTTX5RUiUmc=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=Xoy127wu;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 59D0A2049B;
	Thu, 06 Aug 2026 15:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1786028567;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+ZHWkAEgT30OfPM0REVrekDug59Bs3R/BzIMfrSd1pM=;
	b=Xoy127wu3UG92iPQQQZ3Qp7REPMNkSnQcGiQuamA9S+bRXcVcEGm0T9RN35fCM7nDs3UpF
	ubpWA32obO07Szv8NRAELZW92BfvGAOzfX19QPVAWBLXdOOH7boKnFeO2crrg6XafB5oc9
	vpaITiW7JjfxCMRVT+2Uma9yU0cQotE=
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 06 Aug 2026 17:02:32 +0200
Subject: [PATCH batadv] batman-adv: dat: fix printing of unknown 4addr
 subtype
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: 
 <20260806-4addr-unknown-subtype-print-v1-1-e906357a5895@narfation.org>
X-B4-Tracking: v=1; b=H4sIAAeidGoC/yXM0Q6CMAyF4VchvbbJRghBX8V4UVjRalKWbqCE8
 O5MvfxPcr4NEptwgku1gfEiSSYt4U8VDA/SO6OE0lC7unWda7GhEAxnfen0Vkxzn9fIGE00I3s
 6jxTIU9dAEaLxKJ+ffoWeMoUFbv+9HJ885C8N+34AdlpyrIcAAAA=
X-Change-ID: 20260806-4addr-unknown-subtype-print-e1a9fada1a84
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sashiko <sashiko-bot@kernel.org>, Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1178; i=sven@narfation.org;
 h=from:subject:message-id; bh=dgeI7fFqhp6jsG34exT+DcsFXSgKMhGgSyvmD2SZuaM=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFklizhvyjw2Oh5yqSjN2dyN0/XvCzbdC0YtlRW+fvzuj
 AUNOss7SlkYxLgYZMUUWfZcyT+/mf2t/OdpH4/CzGFlAhnCwMUpABOxNmL4w3WSQ7hmvfTPfc4W
 2+/18vQ+e3G7fyHfbF/5FLOj6Y+v9jP8T5ib0c13n7vDWuP0PK+JX2ZbFBx5l3Z0vXFhmi3butw
 sHgA=
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: M2CMDKTJAVZ7HFS4K6YOWMBZ6N3355UZ
X-Message-ID-Hash: M2CMDKTJAVZ7HFS4K6YOWMBZ6N3355UZ
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/M2CMDKTJAVZ7HFS4K6YOWMBZ6N3355UZ/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

If an unknown subtype of an unicast 4addr packets was detected in
batadv_dbg_arp(), it is printing the (known) packet_type instead of the
subtype. This must be switched to the subtype to have any kind of use for
the reader of the debug message.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/distributed-arp-table.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/distributed-arp-table.c b/net/batman-adv/distributed-arp-table.c
index 011cfdc4..00903b79 100644
--- a/net/batman-adv/distributed-arp-table.c
+++ b/net/batman-adv/distributed-arp-table.c
@@ -548,7 +548,7 @@ static void batadv_dbg_arp(struct batadv_priv *bat_priv, struct sk_buff *skb,
 			break;
 		default:
 			batadv_dbg(BATADV_DBG_DAT, bat_priv, "* type: Unknown (%u)!\n",
-				   unicast_4addr_packet->u.packet_type);
+				   unicast_4addr_packet->u.subtype);
 		}
 		break;
 	case BATADV_BCAST:

---
base-commit: 979765fe212e92b34a1627998820a9c3aaea6424
change-id: 20260806-4addr-unknown-subtype-print-e1a9fada1a84

Best regards,
--  
Sven Eckelmann <sven@narfation.org>

