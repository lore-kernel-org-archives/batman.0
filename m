Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B974CD4979E
	for <batman@archiver.kernel.org>; Mon,  2 Dec 2024 05:38:01 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 19817841E5
	for <batman@archiver.kernel.org>; Mon,  2 Dec 2024 06:38:00 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1733117880;
 b=Iz4ne+o9ZGUPS3/Vs24MVzbk+2YQ+8QX9sUA4uFfdrsITof1k108kurC/0lqXVIt2RT/Y
 bgmeW78D+mDY9qujkxbPYBBmfJW63xOW5DKhSJCztD0NEFQO2qb/ZdfDemdgZJtP599iTJ6
 XggW4G30xQn2CYp2eahTFlDKIavvF1o=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1733117880; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=+zbkL+0a+p5KxOrsos7HeAPMA6VAfsNwNEoVrIv5mhY=;
 b=JihgZOR0nBnwp5ScfT16c7gB2V1+OIbPCiteA8RusaIaDuC6sJPIO/x23lBJjTs1mVHl8
 MtrRlGREuWWqo1tYcBpeT9EQCDpD8z7BbA//x3dgJuwGX+bfIYDtUeEblkX8RUtHMoGq711
 jtzJWkiLpqbXbpLrydCDYkXNJX72BVY=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=fail;
  arc=pass;
  dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass; dmarc=none
Received: from mail.aperture-lab.de (mail.aperture-lab.de
 [IPv6:2a01:4f8:c2c:665b::1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id EE61C83C01
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon,  2 Dec 2024 06:35:23 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1733117724;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+zbkL+0a+p5KxOrsos7HeAPMA6VAfsNwNEoVrIv5mhY=;
	b=sMfrjaJKK7XpgksSr/B6N+dgp1SPw4XJ0bItWCwtVpaKWAmImS1ELvNKdEch0DomHgeM6z
	b54VBJoU8tSDhYDS86wuwOHlsycWwM2tJp2EQYt3lMpygLhe11jk2eEjH4ynsS+BFrZ2wl
	l/FBHJSaZDECxISGFKo7v5uvpHDNNDk=
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1733117724; a=rsa-sha256;
	cv=none;
	b=FH17utuVNOoloRAVh+Aksf8yOFGmovEv5NRHFHbJrk0ANEocux/QWjMocgravHA8B5aAqV
	deI7P7LeDS4Rvh5W7fKWkU1m9l5VVyR5kwOdp8/UwNlwTIrEd9KS1lnUQqdSRWF8RNeikY
	dSppmTh6uVsQqV895ZtdMeuiN4i9TXY=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	spf=pass (diktynna.open-mesh.org: domain of linus.luessing@c0d3.blue
 designates 2a01:4f8:c2c:665b::1 as permitted sender)
 smtp.mailfrom=linus.luessing@c0d3.blue;
	dmarc=none
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 96038541073;
	Mon,  2 Dec 2024 06:35:23 +0100 (CET)
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Subject: [PATCH v3 3/3] batman-adv: avoid adding VLAN IDs 0 + 1 through kernel
 events
Date: Mon,  2 Dec 2024 06:05:22 +0100
Message-ID: <20241202053511.326-4-linus.luessing@c0d3.blue>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241202053511.326-1-linus.luessing@c0d3.blue>
References: <20241202053511.326-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
Message-ID-Hash: ORZPIX2BQQNHZEIY6R3AFRK3RVICONTC
X-Message-ID-Hash: ORZPIX2BQQNHZEIY6R3AFRK3RVICONTC
X-MailFrom: linus.luessing@c0d3.blue
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/ORZPIX2BQQNHZEIY6R3AFRK3RVICONTC/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Currently the 8021q module always registers VLAN ID 0 and the Linux
bridge always registers VLAN ID 1 if bat0 is added to a bridge
(probably as a quirk for hardware network/switch device drivers).
Even though we might not actually use them over the mesh.
The issue is that any extra VLAN currently increases our own
OGM protocol overhead quite a bit, so we want to avoid that
by only adding VLANs that we are sure someone will be using.
So only add VLAN IDs 0 and 1 through snooping of actual, VLAN tagged
traffic, not through kernel internal network events.

Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
---
 net/batman-adv/soft-interface.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/net/batman-adv/soft-interface.c b/net/batman-adv/soft-interface.c
index d08f5e99f39f..7a6287575505 100644
--- a/net/batman-adv/soft-interface.c
+++ b/net/batman-adv/soft-interface.c
@@ -699,6 +699,20 @@ static int batadv_interface_add_vid(struct net_device *dev, __be16 proto,
 	if (proto != htons(ETH_P_8021Q))
 		return -EINVAL;
 
+	/*
+	 * Currently the 8021q module always registers VLAN ID 0 and the Linux
+	 * bridge always registers VLAN ID 1 if bat0 is added to a bridge
+	 * (probably as a quirk for hardware network/switch device drivers).
+	 * Even though we might not actually use them over the mesh.
+	 * The issue is that any extra VLAN currently increases our own
+	 * OGM protocol overhead quite a bit, so we want to avoid that
+	 * by only adding VLANs that we are sure someone will be using.
+	 * So only add VLAN IDs 0 and 1 through snooping of actual, VLAN tagged
+	 * traffic, not through kernel internal network events.
+	 */
+	if (vid == 0 || vid == 1)
+		return 0;
+
 	vid |= BATADV_VLAN_HAS_TAG;
 
 	return batadv_softif_create_vlan_own(bat_priv, vid);
@@ -727,6 +741,9 @@ static int batadv_interface_kill_vid(struct net_device *dev, __be16 proto,
 	if (proto != htons(ETH_P_8021Q))
 		return -EINVAL;
 
+	if (vid == 0 || vid == 1)
+		return 0;
+
 	batadv_softif_destroy_vlan_own(bat_priv, vid | BATADV_VLAN_HAS_TAG);
 	return 0;
 }
-- 
2.45.2

