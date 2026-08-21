Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB568C5DF7D
	for <batman-adv@archiver.kernel.org>; Fri, 21 Aug 2026 09:53:08 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 2EFA4812AB
	for <batman-adv@archiver.kernel.org>; Fri, 21 Aug 2026 11:53:07 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1787305987;
 b=a404tTEYgPZtnfDc20q21v2R6h6mQ7ptvvqqA0Dilsk7UppolCpWBtl5QOAU7ShgvZEMh
 GLZukINcFetS/k4K406tGGbg2KaL9RyC4FjUDXNesBVJD/pbEhRcJXdKw4+4d8q4GI47bMX
 /re/ngcwK/SQviRCscNOj/CEPfD3llo=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1787305987; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=v6y9x0uCrXa3sY9+yBUvL0yvm51wQ3/TOz+Jazsp1Uk=;
 b=3We4CdnKcdQil9bziD1Gn/kTF5OeRgxHLtIZZA8j/BS2a2OZVW6Zuk/GR1IGNgVk3PBEX
 V5fTMEYwNg+z9PIAjO1NvFw5T3rc6GU3RtnZHZj+oUQwizH7dOUsgJD+3u9Ce+WOBP692Ko
 W77opoUAVwgto1fX872c6CXrQLnCTnY=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de
 [IPv6:2a01:4f8:c17:e8c0::1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id A6C5881271
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 21 Aug 2026 11:48:23 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1787305703;
	b=YcSa4Nil4lNWMoH4pC/0LFlarIbuXofQfIXycxbJkL4foCpwUet+e6vQFX5DIgn6Aw0h2e
	uiBEuKnWsZjXx4FU9lWUJG1kPE+pWbRC3MQlLfK6AOQgzPFjzNib8Qx30A6gU1KlCYU6GL
	/UcX71232EluSo58IIqCOiN24TADePU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1787305703;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=v6y9x0uCrXa3sY9+yBUvL0yvm51wQ3/TOz+Jazsp1Uk=;
	b=HH7HtiOvib52pVkEhXxtMePxu0odl7+OsmdLCsGa3nzMOx3i/LWQu4gIuWBWZbeOMf1nHF
	XgzaU5op+fJyd+GQWJJxBtzM0OnPo2ppn4H8QNe23hWhaJQrJ66FMEmR/O4hz1eAsWh3zt
	uMgaFXaPrDmtLtEx+w7b6N+KB2C7skw=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=UKJMB7IG;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 2a01:4f8:c17:e8c0::1 as permitted sender)
 smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
Received: from kero.packetmixer.de
 (p200300C59714FCd8eC8c87C354003feD.dip0.t-ipconnect.de
 [IPv6:2003:c5:9714:fcd8:ec8c:87c3:5400:3fed])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with UTF8SMTPSA id 51A33FA156;
	Fri, 21 Aug 2026 11:48:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1787305703;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v6y9x0uCrXa3sY9+yBUvL0yvm51wQ3/TOz+Jazsp1Uk=;
	b=UKJMB7IGfF6AmwWQsIXng5I1TOPcZTK/War9bQOj2Z0Ugy9NOS1d4e5XBbJE3imjrWPljU
	IpySa+M9LkAgrzPu6kUtMJeuRaZ7C/pj9G4izw7IcMoJzX0tXq1e0khtR+qhG0vQPd6XBa
	/CxfrGnvepSnay9NSBnfpQoyaOqUV/1d51IadA36sdD0REX51IGIbpa//gXyZdTaxTd3aU
	+8QNawzLW15/aDms2AnP38KI7wI9XovOFNeqb7VTH3JtCi6hlVsVVikfJS4ij0reIHu3vh
	kjBD6WIagVOKjlLu5O2H1QSYLO/vzfJE9DqN10YyiSzi35FhB5uugYfbiBZt1g==
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
Subject: [PATCH net 9/9] batman-adv: bla: fix freeing of claims on meshif
 deletion
Date: Fri, 21 Aug 2026 11:48:13 +0200
Message-ID: <20260821094813.201800-10-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260821094813.201800-1-sw@simonwunderlich.de>
References: <20260821094813.201800-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: 46NE5HSNJH6DPTJKSXKTGRLEZWRA7HKS
X-Message-ID-Hash: 46NE5HSNJH6DPTJKSXKTGRLEZWRA7HKS
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/46NE5HSNJH6DPTJKSXKTGRLEZWRA7HKS/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Sven Eckelmann <sven@narfation.org>

When the mesh interface is getting deleted, then
batadv_bla_del_backbone_claims() (via batadv_bla_purge_backbone_gw()) could
make sure that all claims gets removed. But this function is only executed
when bat_priv->bla.claim_hash is not NULL. And since batadv_bla_free() is
always setting it to NULL before it is (indirectly) called, it was never
actually executed.

But the batadv_bla_purge_claims() -> batadv_handle_unclaim() is at the
moment too fragile because the BLA code is not handling the rehashing in
batadv_bla_update_orig_address(). The stored backbone address doesn't have
to be the one actually used for the hash bucket selection during the
initial adding of the backbone. The batadv_handle_unclaim() can therefore
fail to find the respective backbone for the unclaim and then stop the
deletion.

But the actual backbone_gw object is not needed for the unclaim because all
relevant information is always provided by the caller. And the check for
the existence of the backbone_gw doesn't provide any additional security
check for the deletion of a claim.

Cc: stable@kernel.org
Fixes: 23721387c409 ("batman-adv: add basic bridge loop avoidance code")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/bridge_loop_avoidance.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
index 3194ccdbce607..f635da4b8ca65 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -950,26 +950,18 @@ static bool batadv_handle_unclaim(struct batadv_priv *bat_priv,
 				  const u8 *backbone_addr, const u8 *claim_addr,
 				  unsigned short vid)
 {
-	struct batadv_bla_backbone_gw *backbone_gw;
-
 	/* unclaim in any case if it is our own */
 	if (primary_if && batadv_compare_eth(backbone_addr,
 					     primary_if->net_dev->dev_addr))
 		batadv_bla_send_claim(bat_priv, claim_addr, vid,
 				      BATADV_CLAIM_TYPE_UNCLAIM);
 
-	backbone_gw = batadv_backbone_hash_find(bat_priv, backbone_addr, vid);
-
-	if (!backbone_gw)
-		return true;
-
 	/* this must be an UNCLAIM frame */
 	batadv_dbg(BATADV_DBG_BLA, bat_priv,
 		   "%s(): UNCLAIM %pM on vid %d (sent by %pM)...\n", __func__,
-		   claim_addr, batadv_print_vid(vid), backbone_gw->orig);
+		   claim_addr, batadv_print_vid(vid), backbone_addr);
 
 	batadv_bla_del_claim(bat_priv, claim_addr, vid);
-	batadv_backbone_gw_put(backbone_gw);
 	return true;
 }
 
-- 
2.47.3

