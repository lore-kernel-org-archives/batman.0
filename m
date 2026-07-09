Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1FF2C43458
	for <batman-adv@archiver.kernel.org>; Thu,  9 Jul 2026 19:46:54 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id E4D47841D8
	for <batman-adv@archiver.kernel.org>; Thu, 09 Jul 2026 21:46:52 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1783626412;
 b=MdSo57hr4tBkq2LDUMkqP35uS4evZ4CrMoLU83HlX8qv5G27gj8FbCxtTn7H/KEkVnnSb
 Ri94zdrfG5uM2HoDK90RI0F3MQ/RsX30URiQCCJ9W0awhUHhWpqX8QNAIgdtmXl0I/Azosi
 o0W5PYUAfauUDT1Gx6QFA3uSkCh3bQg=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1783626412; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=+Pd7siZNQttYgtwNfylG/g6MOvey4Wt0dvkyGMo0LBI=;
 b=vXh+E4rEKfroC2RkoiLL9gytJgS4tZLqlSsCUOtoYyQd/Hs3XAEv3s+kenmLDG59i2Zez
 CFOTviljfCxapfdBiD4df1XceU/AtQEa7xTmAaet9ERIObLkvossYq1OD74WPgPbyV42l3C
 nmwKo8pZgY7/dOtcIhpX7OGW9SZ3cec=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 48C1A83E95
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 09 Jul 2026 21:46:17 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1783626383;
	b=UPVGdiv31Vy5elztnE1Q/ehAC6/lIgdZOZC0/AMt9b7/aA1Ufu3u28Gn6zYMi6gvOJazjG
	Tm16DpWQRYg2tZlCJPqLEiDgnsNhO69E0bSF7pFCfHbN3gmFdYGTqr6ir3w9/bf40YIpBF
	HBkVgegW8LUVvCUeBPc2NpwT8/VoBw0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1783626383;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=+Pd7siZNQttYgtwNfylG/g6MOvey4Wt0dvkyGMo0LBI=;
	b=IeBjWsI7X7t8zpx22pF6ncdR8cl2zDillwJ/5lTPgmfIsSoBrThFqs9p7BRasV5gjT5Tfy
	sKEp3w8ZRg1jLe6lxTAJiz4IQ/qv7NP0gxdlaeqqSukXueMlJo0aGEy4iZdhPIAjkAYKg4
	qhqOFPhmGNqbNaBtE4yQyr7dpdeUqH8=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=Sc3f0I9y;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 7C3B82052D;
	Thu, 09 Jul 2026 19:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1783626377;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+Pd7siZNQttYgtwNfylG/g6MOvey4Wt0dvkyGMo0LBI=;
	b=Sc3f0I9yaNo2DvI3xOnSCgo/d2KBtZ1mc4VzcKVSJdpn2ObcN9G7o4YT4D7/KyVOkHGHSU
	ZNb4iItZebBeWqx0+lRO19xDT0woaH+AN9/qB67gXa+k82xQf0roWK7SG87bcGSRWf/UFh
	FMD0I/lKj+UmwH1X0DjcRDu7PN2qbng=
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 09 Jul 2026 21:45:55 +0200
Subject: [PATCH batadv 1/3] batman-adv: fix TX priority extraction for
 BATADV_FORW_MCAST
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: 
 <20260709-mcast-header-generation-bugs-v1-1-c7c111fa45b6@narfation.org>
References: 
 <20260709-mcast-header-generation-bugs-v1-0-c7c111fa45b6@narfation.org>
In-Reply-To: 
 <20260709-mcast-header-generation-bugs-v1-0-c7c111fa45b6@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1901; i=sven@narfation.org;
 h=from:subject:message-id; bh=2cUZAvVE4i4/sPDy3k4WENqil0KhFCKgAZXH4XOaXuQ=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFn+v0rX55b8ML7M0DF/wYrEPe9C6g4Ynpl8cs2vjXIMZ
 b932x7c2VHKwiDGxSArpsiy50r++c3sb+U/T/t4FGYOKxPIEAYuTgGYyLfPDP/jJCOPan1gP7La
 QFlU7/3Znyuv1TbJb439znjziP/Gff+VGf5K8Pat+xmpk377v/CM24IRhma2Ev87GLId1utJbpp
 02IQPAA==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: AHIQ7QCCGNTAPLHDV5WI4FLWKRL5MB7C
X-Message-ID-Hash: AHIQ7QCCGNTAPLHDV5WI4FLWKRL5MB7C
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/AHIQ7QCCGNTAPLHDV5WI4FLWKRL5MB7C/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

batadv_mcast_forw_mode_by_count() pushs the skb->data for BATADV_FORW_MCAST
forwarding via batadv_mcast_forw_mcsend(). But the
batadv_skb_set_priority() expects the ethernet header directly before
(skb->data + offset). With the moved skb->data, just some random data would
be accessed to get the priority data.

Move the batadv_skb_set_priority() before the decision about the handling
multicast packets and potential header modifications.

Fixes: be9b0169c840 ("batman-adv: mcast: implement multicast packet generation")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/mesh-interface.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/mesh-interface.c b/net/batman-adv/mesh-interface.c
index b2c8febe..20582fe0 100644
--- a/net/batman-adv/mesh-interface.c
+++ b/net/batman-adv/mesh-interface.c
@@ -300,6 +300,8 @@ static netdev_tx_t batadv_interface_tx(struct sk_buff *skb,
 	if (batadv_compare_eth(ethhdr->h_dest, ectp_addr))
 		goto dropped;
 
+	batadv_skb_set_priority(skb, 0);
+
 	gw_mode = READ_ONCE(bat_priv->gw.mode);
 	if (is_multicast_ether_addr(ethhdr->h_dest)) {
 		/* if gw mode is off, broadcast every packet */
@@ -333,6 +335,9 @@ static netdev_tx_t batadv_interface_tx(struct sk_buff *skb,
 
 send:
 		if (do_bcast && !is_broadcast_ether_addr(ethhdr->h_dest)) {
+			/* WARNING batadv_mcast_forw_mode might add more headers
+			 * in front of the skb. and might even reallocate the skb
+			 */
 			forw_mode = batadv_mcast_forw_mode(bat_priv, skb, vid,
 							   &mcast_is_routable);
 			switch (forw_mode) {
@@ -350,8 +355,6 @@ static netdev_tx_t batadv_interface_tx(struct sk_buff *skb,
 		}
 	}
 
-	batadv_skb_set_priority(skb, 0);
-
 	/* ethernet packet should be broadcasted */
 	if (do_bcast) {
 		primary_if = batadv_primary_if_get_selected(bat_priv);

-- 
2.47.3

