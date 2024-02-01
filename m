Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EBC7C47DDF
	for <batman@archiver.kernel.org>; Thu,  1 Feb 2024 11:02:03 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id AAA3583FFA
	for <batman@archiver.kernel.org>; Thu,  1 Feb 2024 12:02:01 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1706785321;
 b=h2H5gAKEEGrKMDtmi/B46LOsG3alghHT5c7mthkU8ms6IhCxiz3qDH/J0dxf12WjFbajX
 F3SoUx2W+4moYwJy3s+rdlngvWAC/MuPyU8+YSq0/HsDNxyJSudwJUJbGP+Lcd41o6AHJPF
 1UfX7Laia6RoMfTCeResNTHh49hjKiQ=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1706785321; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=O1H7X+oidt2pV6paErvMp7vsTUclC2MyD3Z8kBbr3gs=;
 b=F9Gr4leDxzSV4fqpUukqXFNglbxX6/jtGOLXfwkfo9Rqmp1BsL35bPzuSJNsVb1pJG1fO
 UbpBbDWo35CBrMpIlHaYANoUcDf8PzZAU+HAizSa9hu7OE0TlWm3cBbCCK9Dajjvgi+xwuy
 4V+7wQDQxCIOBfYqUGD053IiVqWZ5RI=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=fail;
  arc=pass;
  dmarc=fail (Used From Domain Record) header.from=simonwunderlich.de
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass;
 dmarc=fail (Used From Domain Record) header.from=simonwunderlich.de
 policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de
 [IPv6:2a01:4f8:c17:e8c0::1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id CD95F80B42
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu,  1 Feb 2024 12:01:16 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1706785276;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O1H7X+oidt2pV6paErvMp7vsTUclC2MyD3Z8kBbr3gs=;
	b=KRC0s2vBPwcJfqEfFR8f6x4ePhXtzqQ+C7YrF2cgoPaI964IDNdLL84IUvmgxBzPkhbd09
	vgA0aN0jXsbA298qZuGCptZnLolxEGjo+EFxVWLnQTEyWI1m1GqafO0agCHsmOgvD2C5BW
	Jccp2vpROjmuAivb6MvFyedwaQozw0I=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 2a01:4f8:c17:e8c0::1 as permitted sender)
 smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1706785276; a=rsa-sha256;
	cv=none;
	b=uJ4bECqMSOreeicR7pOfzByQwnPOO2XesaClLrXpkjvuco9J4A9NuVj4hLTEF2hNzP84T+
	ZB64QGFIQNcFjR3kz7aNeuEnRIBGVqE5QV+2jAOrMMq5QRtA9oOlp4MdbNw6VhQJSWr+WW
	TvMplQ/b0x5qwgGjGP1DVFS8Qh3IPdA=
Received: from kero.packetmixer.de
 (p200300c59712C7d8D89318FB9D63B559.dip0.t-ipconnect.de
 [IPv6:2003:c5:9712:c7d8:d893:18fb:9d63:b559])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits)
 server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id 7A811FA9A1;
	Thu,  1 Feb 2024 12:01:15 +0100 (CET)
From: Simon Wunderlich <sw@simonwunderlich.de>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: netdev@vger.kernel.org,
	b.a.t.m.a.n@lists.open-mesh.org,
	=?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>,
	Sven Eckelmann <sven@narfation.org>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 1/2] batman-adv: mcast: fix mcast packet type counter on
 timeouted nodes
Date: Thu,  1 Feb 2024 12:01:09 +0100
Message-Id: <20240201110110.29129-2-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240201110110.29129-1-sw@simonwunderlich.de>
References: <20240201110110.29129-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Message-ID-Hash: FZ7UU2F7AA5QRMQSZVMHOLLV3K625VJD
X-Message-ID-Hash: FZ7UU2F7AA5QRMQSZVMHOLLV3K625VJD
X-MailFrom: sw@simonwunderlich.de
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/FZ7UU2F7AA5QRMQSZVMHOLLV3K625VJD/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Linus Lüssing <linus.luessing@c0d3.blue>

When a node which does not have the new batman-adv multicast packet type
capability vanishes then the according, global counter erroneously would
not be reduced in response on other nodes. Which in turn leads to the mesh
never switching back to sending with the new multicast packet type.

Fix this by reducing the according counter when such a node times out.

Fixes: 90039133221e ("batman-adv: mcast: implement multicast packet generation")
Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/multicast.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/batman-adv/multicast.c b/net/batman-adv/multicast.c
index d982daea8329..b4f8b4af1722 100644
--- a/net/batman-adv/multicast.c
+++ b/net/batman-adv/multicast.c
@@ -2198,6 +2198,8 @@ void batadv_mcast_purge_orig(struct batadv_orig_node *orig)
 				      BATADV_MCAST_WANT_NO_RTR4);
 	batadv_mcast_want_rtr6_update(bat_priv, orig,
 				      BATADV_MCAST_WANT_NO_RTR6);
+	batadv_mcast_have_mc_ptype_update(bat_priv, orig,
+					  BATADV_MCAST_HAVE_MC_PTYPE_CAPA);
 
 	spin_unlock_bh(&orig->mcast_handler_lock);
 }
-- 
2.39.2

