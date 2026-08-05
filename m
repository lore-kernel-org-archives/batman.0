Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 638F2C55174
	for <batman-adv@archiver.kernel.org>; Wed,  5 Aug 2026 14:36:54 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 020988413A
	for <batman-adv@archiver.kernel.org>; Wed, 05 Aug 2026 16:36:53 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1785940612;
 b=zu8UYjGszkAcG/MkXMHsNXtaTDYR/VeC9361whzZ3SGGrSCwD3J0UiutW20RMWaUh2JH4
 5Cej09YM6JjJ0BWWTL0MqoepNRFBvx1yRg5wpcHhocpKEuraW33fP8LgJTkEdL2iQR4+kmw
 djvbH7Jeu+p/ggGc+GSpkorIcQrSaIM=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1785940612; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=cbxbhQOvhhTdAU3fZ2FnZyfAODsoGSs5O9cRmBMxbAo=;
 b=hrOKgPSreeCNdozXPyGuZAo8AWigyKN82jguFWeetqIJZDevSa+6YtrxuOqaeVRYVwlog
 lzCGP/rvfQ1DJV9Tws0bENaL7ISAbPx2k2WkKn+RzSzT8Vgmg6eJnpGy37K4dDw4pfi3X9Q
 dT1Sj6JvR+nj6Ab8YCfywOIP1FcuZyI=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de
 [IPv6:2a01:4f8:c17:e8c0::1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id F3E0F8421A
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 05 Aug 2026 16:32:11 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1785940332;
	b=sGBUmzye+hsUYVXVrZqYLs+4VqQMbAy5c1Y02inUAfZtZXIBNEwB8t4tQgZKBnaB+lBUdp
	hMeRataxLYXoCqkCPKAkPzeXqhCrEd6KN2qt9mAYaUJNVb1HrGhep+q6WzG1BoI4Blsz5I
	yKupSOhXVIuWkLhyDs/13FqiV4IWVgU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1785940332;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=cbxbhQOvhhTdAU3fZ2FnZyfAODsoGSs5O9cRmBMxbAo=;
	b=OV5WqNJMHMc/ctT6uMcPn9hop0HQ2lt+MH6x00uBk6Ggr6gDRioLc0FzYHCGZ63DsZBDZb
	VQCaaF6jm0MeSwF/OM+rz6LIGbHL6zpgDHIEsKT3gpz3V8b8D/oMPL/sV1CJFOqrIuvqnr
	u5V3Bz/qDlGe5MsE+jXyssNNXFPMIZ8=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b="z/pcV47e";
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 2a01:4f8:c17:e8c0::1 as permitted sender)
 smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
Received: from kero.packetmixer.de
 (p200300c5970B56d88eEbaC4310d100aa.dip0.t-ipconnect.de
 [IPv6:2003:c5:970b:56d8:8eeb:ac43:10d1:aa])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id AA9E5FA26E;
	Wed, 05 Aug 2026 16:32:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1785940331;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cbxbhQOvhhTdAU3fZ2FnZyfAODsoGSs5O9cRmBMxbAo=;
	b=z/pcV47euLcXNVl2E3zmofoqTAbyiy7FZbmUz/vtMuQGfZDNWqSlbonoVcGWH82RlInFlb
	3s9hw0S1iToeXxSR/2vxMj4ve2Glxy/6/HRa38AEXJBBgKRE6D8ZfdRFogJoQMxOZjl67q
	5ywwUqH00/yIvUL9vR827ROJ5DZRY6U4m0XJeLEH96JZFiAZbC9vlQMoxjg2T2hfZ5olJv
	9Xjy3JTxYfA7yB3kF9qGTKPTyQFMiRR9u1eleLu9c9xb1gK5w6b5vaRRxQOZtb5SD5j5nL
	LSmt+i6eq/GtWCTdH0XPgbJOZlHaMlCLiGg/Yad4xK+6Uyoi6uzVRIuoVdIfKA==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Sven Eckelmann <sven@narfation.org>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net-next 10/10] batman-adv: remove negative returns for
 batadv_send_skb_unicast
Date: Wed,  5 Aug 2026 16:27:24 +0200
Message-ID: <20260805143200.722098-11-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260805143200.722098-1-sw@simonwunderlich.de>
References: <20260805143200.722098-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: 2RPDVIJQ467QYUSACY6J6GHTRIW24GSW
X-Message-ID-Hash: 2RPDVIJQ467QYUSACY6J6GHTRIW24GSW
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/2RPDVIJQ467QYUSACY6J6GHTRIW24GSW/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Sven Eckelmann <sven@narfation.org>

The kernel documentation for batadv_send_skb_unicast() states that only the
return values NET_XMIT_DROP and NET_XMIT_SUCCESS are valid. Functions like
batadv_dat_snoop_incoming_arp_request() are only checking if the return is
not NET_XMIT_DROP to check if send was successful or not. Negative values
were therefore also handled as success.

Similar functions are not returning the batadv_send_skb_to_orig() return
value directly but are checking if it is a direct success and only then
marking the return as such. This must also be adopted for
batadv_send_skb_unicast().

The callers of this function are mostly not affected. Only packet counting
in batadv_dat_snoop_incoming_arp_request() will now work as expected in
case of a negative return value from batadv_send_skb_to_orig().

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/send.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/batman-adv/send.c b/net/batman-adv/send.c
index 2122560c90e51..929b6dd34c107 100644
--- a/net/batman-adv/send.c
+++ b/net/batman-adv/send.c
@@ -324,6 +324,7 @@ int batadv_send_skb_unicast(struct batadv_priv *bat_priv,
 	struct batadv_unicast_packet *unicast_packet;
 	int ret = NET_XMIT_DROP;
 	struct ethhdr *ethhdr;
+	int res;
 
 	if (!orig_node)
 		goto out;
@@ -360,7 +361,10 @@ int batadv_send_skb_unicast(struct batadv_priv *bat_priv,
 	if (batadv_tt_global_client_is_roaming(bat_priv, ethhdr->h_dest, vid))
 		unicast_packet->ttvn = unicast_packet->ttvn - 1;
 
-	ret = batadv_send_skb_to_orig(skb, orig_node, NULL);
+	res = batadv_send_skb_to_orig(skb, orig_node, NULL);
+	if (res == NET_XMIT_SUCCESS)
+		ret = NET_XMIT_SUCCESS;
+
 	 /* skb was consumed */
 	skb = NULL;
 
-- 
2.47.3

