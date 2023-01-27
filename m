Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D568C54EAA
	for <batman-adv@archiver.kernel.org>; Fri, 27 Jan 2023 10:25:00 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id F2572846DB
	for <batman-adv@archiver.kernel.org>; Fri, 27 Jan 2023 11:24:58 +0100 (CET)
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [IPv6:2a01:4f8:c17:e8c0::1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 991AB84244
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 27 Jan 2023 11:21:38 +0100 (CET)
ARC-Seal: i=2; s=20121; d=open-mesh.org; t=1674814898; a=rsa-sha256;
	cv=fail;
	b=fd2aTZWnCKZ/cEHwuHb0j3LOwj4CWn9sRqiaAKrX8rbPaVCz1vmb2hTbe6OEHKFTz3DEIL
	Uhs1xd/z4AgCcfzw4oozLbWvLzuZtRA8oTfxO85kMMUsxStsHjHtgCrEI1hiLaka4Qo89H
	UkZ9FXUr1xAPXTYkd3sc8mcSZwUscGI=
ARC-Authentication-Results: i=2;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b="GBd6K/8R";
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates 2a01:4f8:c17:e8c0::1 as permitted sender) smtp.mailfrom=sw@simonwunderlich.de;
	arc=reject ("seal check failed: fail, {[1] = sig:simonwunderlich.de:reject}");
	dmarc=pass (policy=none) header.from=simonwunderlich.de
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1674814898;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=MK+d6FbIkx5s3HDyrJ2NgoLkQ+O/0R6/CLTiWhdeB6g=;
	b=rIKdKIDuVuhQ7YIDN/ZfNXlU3XXbFSVpWq7B4tCDNPdxYWo0RQ6ZBOCjjYs0hlJreljebC
	IuCG8U/7tbBQkoPDHppQFxVcXuuZMOGkrgvfi/+HK+cqpUTfkpCxae70bPaJ7Ia7ZZs+Uq
	8+rquyzcYsbXmnLg4dB/e+vUPxzFBUY=
Received: from kero.packetmixer.de (p200300c5973eAEd8832e80845eB11F67.dip0.t-ipconnect.de [IPv6:2003:c5:973e:aed8:832e:8084:5eb1:1f67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id 079BFFAFDF;
	Fri, 27 Jan 2023 11:21:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1674814898; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MK+d6FbIkx5s3HDyrJ2NgoLkQ+O/0R6/CLTiWhdeB6g=;
	b=GBd6K/8Rcw81AvdM5GNzn3NeyjtDCC1+Gd1vz/WZ185lBGIr45CpTyqeqx0DP+vvEGOXfa
	aXhsIAmOgbZL6Z5KkuCBU2QGWB3WhU+rY9SKd9hCJ9W3roohAMjLtUi8gV9vxtDin5elQ4
	8ewaBMv4GbZBzFaY4fQL01GY9Vk99raxrc7Svc0sw80+tTp+0GdSIqgiLXMf3xzV6Me/P9
	ZNKEYQ7n/1z+i9sNIZCNevQm7kjfM7r5cbBMUfG9CBE0X0F4ejApkKz3U0wsr7qpBZ4oHL
	drRCfz4mWe0xXYJVNKuPuvIr3j4u8oOeRxZ2tyhUUfAGlM2k6awDrQ6DJX7xCg==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: kuba@kernel.org,
	davem@davemloft.net
Subject: [PATCH 5/5] batman-adv: tvlv: prepare for tvlv enabled multicast packet type
Date: Fri, 27 Jan 2023 11:21:33 +0100
Message-Id: <20230127102133.700173-6-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230127102133.700173-1-sw@simonwunderlich.de>
References: <20230127102133.700173-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
	d=simonwunderlich.de; s=09092022; t=1674814898;
	h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MK+d6FbIkx5s3HDyrJ2NgoLkQ+O/0R6/CLTiWhdeB6g=;
	b=Mnxkb75BCgQzMmW1g+uOlnH065FHMvpiX7rUz2ViTEet+QenOoGInNPvEBw/ORf+8S28di
	IOxf4+cufA5YBpx94lBno2DfeMR4i/6g2p+pWwYWAeuUDvk6mpe+chNWCdxHqv1vs7caGp
	Iik5SUniKtQ+GVNW5I2YOXH0oMZJTaqHl2BgYJcu2wmOnDRNbiiwdgp6KKpJjMGSxEVFVJ
	mRu2hoQW5MrtcyVgWOFRT+yIvj/42Ic/sFjLwc0FFrC4zwsn0QYDYEYT13sWsH6urmyauK
	ugRZlsvGhc+X2oXLNxCyAKZrF1ztcq7WJCA/Aeu3Wvpm/9sB/5cpnxNh/Ep3hA==
ARC-Seal: i=1; s=09092022; d=simonwunderlich.de; t=1674814898; a=rsa-sha256;
	cv=none;
	b=xtTwoDH7Vz4bhvvqnsEgpBqkrpK9j87Brgy7O0vU+oyU2lwgFNOsUF5ipe0HcyBLo/U9BAkSiS5HkKUR1e3j4805jEVMXCfUz/OsE8UZdDwLZXcxrDtJ7ub/8ewXvn9vXnUkj/EqTKSgm2cIhzwEGiXQ2NdChywvzYLbrLE4EVHFWAnvo6OSG5kR6axUQoPYwh62qNS5ICmTKUiSjzux40K3D44zP9jjxlEPwQqFLM2pZvRqEpRO5VP1GGI6vjms3DBaimJkoG4sJNDjKPXk+uM0Rhgj3wff4BYrfqOESU780s0tgsw/aTha646D9up5xQVCFPnslzBP3TzFMJ/1yg==
ARC-Authentication-Results: i=1;
	mail.simonwunderlich.de;
	auth=pass smtp.auth=sw@simonwunderlich.de smtp.mailfrom=sw@simonwunderlich.de
Content-Transfer-Encoding: quoted-printable
Message-ID-Hash: JPJB3GMWK5VFXC2QE52NHLVZKDQCZZBA
X-Message-ID-Hash: JPJB3GMWK5VFXC2QE52NHLVZKDQCZZBA
X-MailFrom: sw@simonwunderlich.de
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-b.a.t.m.a.n.lists.open-mesh.org-0; header-match-b.a.t.m.a.n.lists.open-mesh.org-1; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org
X-Mailman-Version: 3.2.1
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/JPJB3GMWK5VFXC2QE52NHLVZKDQCZZBA/>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Linus L=C3=BCssing <linus.luessing@c0d3.blue>

Prepare TVLV infrastructure for more packet types, in particular the
upcoming batman-adv multicast packet type.

For that swap the OGM vs. unicast-tvlv packet boolean indicator to an
explicit unsigned integer packet type variable. And provide the skb
to a call to batadv_tvlv_containers_process(), as later the multicast
packet's TVLV handler will need to have access not only to the TVLV but
the full skb for forwarding. Forwarding will be invoked from the
multicast packet's TVLVs' contents later.

Signed-off-by: Linus L=C3=BCssing <linus.luessing@c0d3.blue>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 include/uapi/linux/batadv_packet.h     |  2 +
 net/batman-adv/bat_v_ogm.c             |  4 +-
 net/batman-adv/distributed-arp-table.c |  2 +-
 net/batman-adv/gateway_common.c        |  2 +-
 net/batman-adv/multicast.c             |  2 +-
 net/batman-adv/network-coding.c        |  2 +-
 net/batman-adv/routing.c               |  7 ++-
 net/batman-adv/translation-table.c     |  4 +-
 net/batman-adv/tvlv.c                  | 71 ++++++++++++++++++--------
 net/batman-adv/tvlv.h                  |  9 ++--
 net/batman-adv/types.h                 |  6 +++
 11 files changed, 74 insertions(+), 37 deletions(-)

diff --git a/include/uapi/linux/batadv_packet.h b/include/uapi/linux/bata=
dv_packet.h
index ea4692c339ce..9204e4494b25 100644
--- a/include/uapi/linux/batadv_packet.h
+++ b/include/uapi/linux/batadv_packet.h
@@ -26,6 +26,7 @@
  * @BATADV_CODED: network coded packets
  * @BATADV_ELP: echo location packets for B.A.T.M.A.N. V
  * @BATADV_OGM2: originator messages for B.A.T.M.A.N. V
+ * @BATADV_MCAST: multicast packet with multiple destination addresses
  *
  * @BATADV_UNICAST: unicast packets carrying unicast payload traffic
  * @BATADV_UNICAST_FRAG: unicast packets carrying a fragment of the orig=
inal
@@ -42,6 +43,7 @@ enum batadv_packettype {
 	BATADV_CODED            =3D 0x02,
 	BATADV_ELP		=3D 0x03,
 	BATADV_OGM2		=3D 0x04,
+	BATADV_MCAST            =3D 0x05,
 	/* 0x40 - 0x7f: unicast */
 #define BATADV_UNICAST_MIN     0x40
 	BATADV_UNICAST          =3D 0x40,
diff --git a/net/batman-adv/bat_v_ogm.c b/net/batman-adv/bat_v_ogm.c
index 96e027364ddd..e710e9afe78f 100644
--- a/net/batman-adv/bat_v_ogm.c
+++ b/net/batman-adv/bat_v_ogm.c
@@ -799,8 +799,8 @@ batadv_v_ogm_process_per_outif(struct batadv_priv *ba=
t_priv,
=20
 	/* only unknown & newer OGMs contain TVLVs we are interested in */
 	if (seqno_age > 0 && if_outgoing =3D=3D BATADV_IF_DEFAULT)
-		batadv_tvlv_containers_process(bat_priv, true, orig_node,
-					       NULL, NULL,
+		batadv_tvlv_containers_process(bat_priv, BATADV_OGM2, orig_node,
+					       NULL,
 					       (unsigned char *)(ogm2 + 1),
 					       ntohs(ogm2->tvlv_len));
=20
diff --git a/net/batman-adv/distributed-arp-table.c b/net/batman-adv/dist=
ributed-arp-table.c
index fefb51a5f606..6968e55eb971 100644
--- a/net/batman-adv/distributed-arp-table.c
+++ b/net/batman-adv/distributed-arp-table.c
@@ -822,7 +822,7 @@ int batadv_dat_init(struct batadv_priv *bat_priv)
 	batadv_dat_start_timer(bat_priv);
=20
 	batadv_tvlv_handler_register(bat_priv, batadv_dat_tvlv_ogm_handler_v1,
-				     NULL, BATADV_TVLV_DAT, 1,
+				     NULL, NULL, BATADV_TVLV_DAT, 1,
 				     BATADV_TVLV_HANDLER_OGM_CIFNOTFND);
 	batadv_dat_tvlv_container_update(bat_priv);
 	return 0;
diff --git a/net/batman-adv/gateway_common.c b/net/batman-adv/gateway_com=
mon.c
index 9349c76f30c5..6a964a773f57 100644
--- a/net/batman-adv/gateway_common.c
+++ b/net/batman-adv/gateway_common.c
@@ -259,7 +259,7 @@ void batadv_gw_init(struct batadv_priv *bat_priv)
 		atomic_set(&bat_priv->gw.sel_class, 1);
=20
 	batadv_tvlv_handler_register(bat_priv, batadv_gw_tvlv_ogm_handler_v1,
-				     NULL, BATADV_TVLV_GW, 1,
+				     NULL, NULL, BATADV_TVLV_GW, 1,
 				     BATADV_TVLV_HANDLER_OGM_CIFNOTFND);
 }
=20
diff --git a/net/batman-adv/multicast.c b/net/batman-adv/multicast.c
index 7e2822c01e00..315394f12c55 100644
--- a/net/batman-adv/multicast.c
+++ b/net/batman-adv/multicast.c
@@ -1818,7 +1818,7 @@ static void batadv_mcast_tvlv_ogm_handler(struct ba=
tadv_priv *bat_priv,
 void batadv_mcast_init(struct batadv_priv *bat_priv)
 {
 	batadv_tvlv_handler_register(bat_priv, batadv_mcast_tvlv_ogm_handler,
-				     NULL, BATADV_TVLV_MCAST, 2,
+				     NULL, NULL, BATADV_TVLV_MCAST, 2,
 				     BATADV_TVLV_HANDLER_OGM_CIFNOTFND);
=20
 	INIT_DELAYED_WORK(&bat_priv->mcast.work, batadv_mcast_mla_update);
diff --git a/net/batman-adv/network-coding.c b/net/batman-adv/network-cod=
ing.c
index ecd871abda34..71ebd0284f95 100644
--- a/net/batman-adv/network-coding.c
+++ b/net/batman-adv/network-coding.c
@@ -160,7 +160,7 @@ int batadv_nc_mesh_init(struct batadv_priv *bat_priv)
 	batadv_nc_start_timer(bat_priv);
=20
 	batadv_tvlv_handler_register(bat_priv, batadv_nc_tvlv_ogm_handler_v1,
-				     NULL, BATADV_TVLV_NC, 1,
+				     NULL, NULL, BATADV_TVLV_NC, 1,
 				     BATADV_TVLV_HANDLER_OGM_CIFNOTFND);
 	batadv_nc_tvlv_container_update(bat_priv);
 	return 0;
diff --git a/net/batman-adv/routing.c b/net/batman-adv/routing.c
index 83f31494ea4d..163cd43c4821 100644
--- a/net/batman-adv/routing.c
+++ b/net/batman-adv/routing.c
@@ -1073,10 +1073,9 @@ int batadv_recv_unicast_tvlv(struct sk_buff *skb,
 	if (tvlv_buff_len > skb->len - hdr_size)
 		goto free_skb;
=20
-	ret =3D batadv_tvlv_containers_process(bat_priv, false, NULL,
-					     unicast_tvlv_packet->src,
-					     unicast_tvlv_packet->dst,
-					     tvlv_buff, tvlv_buff_len);
+	ret =3D batadv_tvlv_containers_process(bat_priv, BATADV_UNICAST_TVLV,
+					     NULL, skb, tvlv_buff,
+					     tvlv_buff_len);
=20
 	if (ret !=3D NET_RX_SUCCESS) {
 		ret =3D batadv_route_unicast_packet(skb, recv_if);
diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translat=
ion-table.c
index 01d30c1e412c..36ca31252a73 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -4168,11 +4168,11 @@ int batadv_tt_init(struct batadv_priv *bat_priv)
 	}
=20
 	batadv_tvlv_handler_register(bat_priv, batadv_tt_tvlv_ogm_handler_v1,
-				     batadv_tt_tvlv_unicast_handler_v1,
+				     batadv_tt_tvlv_unicast_handler_v1, NULL,
 				     BATADV_TVLV_TT, 1, BATADV_NO_FLAGS);
=20
 	batadv_tvlv_handler_register(bat_priv, NULL,
-				     batadv_roam_tvlv_unicast_handler_v1,
+				     batadv_roam_tvlv_unicast_handler_v1, NULL,
 				     BATADV_TVLV_ROAM, 1, BATADV_NO_FLAGS);
=20
 	INIT_DELAYED_WORK(&bat_priv->tt.work, batadv_tt_purge);
diff --git a/net/batman-adv/tvlv.c b/net/batman-adv/tvlv.c
index 7ec2e2343884..2a583215d439 100644
--- a/net/batman-adv/tvlv.c
+++ b/net/batman-adv/tvlv.c
@@ -352,10 +352,9 @@ u16 batadv_tvlv_container_ogm_append(struct batadv_p=
riv *bat_priv,
  *  appropriate handlers
  * @bat_priv: the bat priv with all the soft interface information
  * @tvlv_handler: tvlv callback function handling the tvlv content
- * @ogm_source: flag indicating whether the tvlv is an ogm or a unicast =
packet
+ * @packet_type: indicates for which packet type the TVLV handler is cal=
led
  * @orig_node: orig node emitting the ogm packet
- * @src: source mac address of the unicast packet
- * @dst: destination mac address of the unicast packet
+ * @skb: the skb the TVLV handler is called for
  * @tvlv_value: tvlv content
  * @tvlv_value_len: tvlv content length
  *
@@ -364,15 +363,20 @@ u16 batadv_tvlv_container_ogm_append(struct batadv_=
priv *bat_priv,
  */
 static int batadv_tvlv_call_handler(struct batadv_priv *bat_priv,
 				    struct batadv_tvlv_handler *tvlv_handler,
-				    bool ogm_source,
+				    u8 packet_type,
 				    struct batadv_orig_node *orig_node,
-				    u8 *src, u8 *dst,
-				    void *tvlv_value, u16 tvlv_value_len)
+				    struct sk_buff *skb, void *tvlv_value,
+				    u16 tvlv_value_len)
 {
+	unsigned int tvlv_offset;
+	u8 *src, *dst;
+
 	if (!tvlv_handler)
 		return NET_RX_SUCCESS;
=20
-	if (ogm_source) {
+	switch (packet_type) {
+	case BATADV_IV_OGM:
+	case BATADV_OGM2:
 		if (!tvlv_handler->ogm_handler)
 			return NET_RX_SUCCESS;
=20
@@ -383,19 +387,32 @@ static int batadv_tvlv_call_handler(struct batadv_p=
riv *bat_priv,
 					  BATADV_NO_FLAGS,
 					  tvlv_value, tvlv_value_len);
 		tvlv_handler->flags |=3D BATADV_TVLV_HANDLER_OGM_CALLED;
-	} else {
-		if (!src)
-			return NET_RX_SUCCESS;
-
-		if (!dst)
+		break;
+	case BATADV_UNICAST_TVLV:
+		if (!skb)
 			return NET_RX_SUCCESS;
=20
 		if (!tvlv_handler->unicast_handler)
 			return NET_RX_SUCCESS;
=20
+		src =3D ((struct batadv_unicast_tvlv_packet *)skb->data)->src;
+		dst =3D ((struct batadv_unicast_tvlv_packet *)skb->data)->dst;
+
 		return tvlv_handler->unicast_handler(bat_priv, src,
 						     dst, tvlv_value,
 						     tvlv_value_len);
+	case BATADV_MCAST:
+		if (!skb)
+			return NET_RX_SUCCESS;
+
+		if (!tvlv_handler->mcast_handler)
+			return NET_RX_SUCCESS;
+
+		tvlv_offset =3D (unsigned char *)tvlv_value - skb->data;
+		skb_set_network_header(skb, tvlv_offset);
+		skb_set_transport_header(skb, tvlv_offset + tvlv_value_len);
+
+		return tvlv_handler->mcast_handler(bat_priv, skb);
 	}
=20
 	return NET_RX_SUCCESS;
@@ -405,10 +422,9 @@ static int batadv_tvlv_call_handler(struct batadv_pr=
iv *bat_priv,
  * batadv_tvlv_containers_process() - parse the given tvlv buffer to cal=
l the
  *  appropriate handlers
  * @bat_priv: the bat priv with all the soft interface information
- * @ogm_source: flag indicating whether the tvlv is an ogm or a unicast =
packet
+ * @packet_type: indicates for which packet type the TVLV handler is cal=
led
  * @orig_node: orig node emitting the ogm packet
- * @src: source mac address of the unicast packet
- * @dst: destination mac address of the unicast packet
+ * @skb: the skb the TVLV handler is called for
  * @tvlv_value: tvlv content
  * @tvlv_value_len: tvlv content length
  *
@@ -416,10 +432,10 @@ static int batadv_tvlv_call_handler(struct batadv_p=
riv *bat_priv,
  * handler callbacks.
  */
 int batadv_tvlv_containers_process(struct batadv_priv *bat_priv,
-				   bool ogm_source,
+				   u8 packet_type,
 				   struct batadv_orig_node *orig_node,
-				   u8 *src, u8 *dst,
-				   void *tvlv_value, u16 tvlv_value_len)
+				   struct sk_buff *skb, void *tvlv_value,
+				   u16 tvlv_value_len)
 {
 	struct batadv_tvlv_handler *tvlv_handler;
 	struct batadv_tvlv_hdr *tvlv_hdr;
@@ -441,20 +457,24 @@ int batadv_tvlv_containers_process(struct batadv_pr=
iv *bat_priv,
 						       tvlv_hdr->version);
=20
 		ret |=3D batadv_tvlv_call_handler(bat_priv, tvlv_handler,
-						ogm_source, orig_node,
-						src, dst, tvlv_value,
+						packet_type, orig_node, skb,
+						tvlv_value,
 						tvlv_value_cont_len);
 		batadv_tvlv_handler_put(tvlv_handler);
 		tvlv_value =3D (u8 *)tvlv_value + tvlv_value_cont_len;
 		tvlv_value_len -=3D tvlv_value_cont_len;
 	}
=20
-	if (!ogm_source)
+	if (packet_type !=3D BATADV_IV_OGM &&
+	    packet_type !=3D BATADV_OGM2)
 		return ret;
=20
 	rcu_read_lock();
 	hlist_for_each_entry_rcu(tvlv_handler,
 				 &bat_priv->tvlv.handler_list, list) {
+		if (!tvlv_handler->ogm_handler)
+			continue;
+
 		if ((tvlv_handler->flags & BATADV_TVLV_HANDLER_OGM_CIFNOTFND) &&
 		    !(tvlv_handler->flags & BATADV_TVLV_HANDLER_OGM_CALLED))
 			tvlv_handler->ogm_handler(bat_priv, orig_node,
@@ -490,7 +510,7 @@ void batadv_tvlv_ogm_receive(struct batadv_priv *bat_=
priv,
=20
 	tvlv_value =3D batadv_ogm_packet + 1;
=20
-	batadv_tvlv_containers_process(bat_priv, true, orig_node, NULL, NULL,
+	batadv_tvlv_containers_process(bat_priv, BATADV_IV_OGM, orig_node, NULL=
,
 				       tvlv_value, tvlv_value_len);
 }
=20
@@ -504,6 +524,10 @@ void batadv_tvlv_ogm_receive(struct batadv_priv *bat=
_priv,
  * @uptr: unicast tvlv handler callback function. This function receives=
 the
  *  source & destination of the unicast packet as well as the tvlv conte=
nt
  *  to process.
+ * @mptr: multicast packet tvlv handler callback function. This function
+ *  receives the full skb to process, with the skb network header pointi=
ng
+ *  to the current tvlv and the skb transport header pointing to the fir=
st
+ *  byte after the current tvlv.
  * @type: tvlv handler type to be registered
  * @version: tvlv handler version to be registered
  * @flags: flags to enable or disable TVLV API behavior
@@ -518,6 +542,8 @@ void batadv_tvlv_handler_register(struct batadv_priv =
*bat_priv,
 					      u8 *src, u8 *dst,
 					      void *tvlv_value,
 					      u16 tvlv_value_len),
+				  int (*mptr)(struct batadv_priv *bat_priv,
+					      struct sk_buff *skb),
 				  u8 type, u8 version, u8 flags)
 {
 	struct batadv_tvlv_handler *tvlv_handler;
@@ -539,6 +565,7 @@ void batadv_tvlv_handler_register(struct batadv_priv =
*bat_priv,
=20
 	tvlv_handler->ogm_handler =3D optr;
 	tvlv_handler->unicast_handler =3D uptr;
+	tvlv_handler->mcast_handler =3D mptr;
 	tvlv_handler->type =3D type;
 	tvlv_handler->version =3D version;
 	tvlv_handler->flags =3D flags;
diff --git a/net/batman-adv/tvlv.h b/net/batman-adv/tvlv.h
index 4cf8af00fc11..e5697230d991 100644
--- a/net/batman-adv/tvlv.h
+++ b/net/batman-adv/tvlv.h
@@ -9,6 +9,7 @@
=20
 #include "main.h"
=20
+#include <linux/skbuff.h>
 #include <linux/types.h>
 #include <uapi/linux/batadv_packet.h>
=20
@@ -34,14 +35,16 @@ void batadv_tvlv_handler_register(struct batadv_priv =
*bat_priv,
 					      u8 *src, u8 *dst,
 					      void *tvlv_value,
 					      u16 tvlv_value_len),
+				  int (*mptr)(struct batadv_priv *bat_priv,
+					      struct sk_buff *skb),
 				  u8 type, u8 version, u8 flags);
 void batadv_tvlv_handler_unregister(struct batadv_priv *bat_priv,
 				    u8 type, u8 version);
 int batadv_tvlv_containers_process(struct batadv_priv *bat_priv,
-				   bool ogm_source,
+				   u8 packet_type,
 				   struct batadv_orig_node *orig_node,
-				   u8 *src, u8 *dst,
-				   void *tvlv_buff, u16 tvlv_buff_len);
+				   struct sk_buff *skb, void *tvlv_buff,
+				   u16 tvlv_buff_len);
 void batadv_tvlv_unicast_send(struct batadv_priv *bat_priv, const u8 *sr=
c,
 			      const u8 *dst, u8 type, u8 version,
 			      void *tvlv_value, u16 tvlv_value_len);
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 758cd797a063..ca9449ec9836 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -2335,6 +2335,12 @@ struct batadv_tvlv_handler {
 			       u8 *src, u8 *dst,
 			       void *tvlv_value, u16 tvlv_value_len);
=20
+	/**
+	 * @mcast_handler: handler callback which is given the tvlv payload to
+	 *  process on incoming mcast packet
+	 */
+	int (*mcast_handler)(struct batadv_priv *bat_priv, struct sk_buff *skb)=
;
+
 	/** @type: tvlv type this handler feels responsible for */
 	u8 type;
=20
--=20
2.30.2
