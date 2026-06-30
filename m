Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AB5DC43458
	for <batman-adv@archiver.kernel.org>; Tue, 30 Jun 2026 14:12:48 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 8C98C8414E
	for <batman-adv@archiver.kernel.org>; Tue, 30 Jun 2026 16:12:46 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1782828766;
 b=eqC2JvIutLRDZqa3giT7RfGw2mjQ2lnX3b/EJgEWTEY+6E/OGkAmzU2XXbwqiJvLXI3P4
 uv1Cf1vWvO/vnynbUJW35jpNoFbAhpxpg2wan4rPwPBLDLgnwcDpzUDthz1FSTIKpMvcq7L
 VmV8+tCcBTwbfz6L35Fa5F8OZxLq0K4=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1782828766; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=k1ZELRoiRhncnhMIWdvQ7ngTvJlPWJEpZajpuDkFiYU=;
 b=N8/ha9vavN4YuL4liaik0vAh2FmSB6PBpesuPfJBxYPUOaVpSLh8cZt3CgsK3aZ22EdNV
 RmG2hAWjKLwv2zvHo+2lhhFbGLHTtx2hcINBL1fM0+hxjZg6rEbrUfiew1HpyXejTpXdJTx
 zbDB+DYQ9Doc8gH0taaJDgYHNdB+YkA=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de
 [IPv6:2a01:4f8:c17:e8c0::1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id A60E481096
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 30 Jun 2026 16:06:32 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1782828392;
	b=3gR8eDu4Fnb9wsY/WC5o5Di0P6J8pgGH6SwbPy09oJmuvB6khIgJ5MVZx1Cy9s5XoAitEZ
	4aA09GaEPekf9pkjtRcUQxdqlyF0kspCdi2mC7IvDPsXo2QfK+LWX4m2pJJHmjzCMksHas
	+sCMhk/EGxEWPkbGYMJBFjhXQQd2ZVU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1782828392;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=k1ZELRoiRhncnhMIWdvQ7ngTvJlPWJEpZajpuDkFiYU=;
	b=boR8/RGOAFWCoze2JsYUkpD3IioA3tOMqI0qxmijRdmIedgHsurRJn6uEI6QXLHFwgBLCO
	My+xlBhe+bgiQIY2h0/BAyD5IOWFgMnlmlPe8LPtR/Z7xQH9FqQTU980Tw22phMH7KsZRj
	gK5dNW3Oj0GkHuI9a/UzQZ7Fzz6ca2E=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=hh07csOy;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 2a01:4f8:c17:e8c0::1 as permitted sender)
 smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1782828391;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k1ZELRoiRhncnhMIWdvQ7ngTvJlPWJEpZajpuDkFiYU=;
	b=hh07csOy2nL3ivGlk8Cxf30CmRD5xdl9Myk6ogk3v8NH5VfkV4y2XzOb1MdYisv1GKzcuB
	Ksb14e7qx5yvtwGK0oyeqgQ3FsZmWgq5bS+47z6n0sDornW56XIU8j8jUOASgjA/gRlVCh
	Bgo8UfdT9tOAEWV1hYK6vHF+GG55+Vd67w+SrJoCWaDSBJ39k7mwGwyo+Url3UDUawj9V0
	U443fjMywviDg74jB2QxnwgVqc+swxFeUWUempr5EPyVCF9XezWiRkMDlnMgLoaLotpSFN
	ivn/sZMh4FXmwSBqsYHqG78s5VaeN63nFexCYhQyEJ0+aYZzbr0Ppr5xrL57gg==
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
Subject: [PATCH net-next 09/15] batman-adv: iv: drop migration check for
 batadv_hard_iface
Date: Tue, 30 Jun 2026 16:06:17 +0200
Message-ID: <20260630140623.88431-10-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260630140623.88431-1-sw@simonwunderlich.de>
References: <20260630140623.88431-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: E7SP77FIJAD3MAUH6O4PFY5DOCLT4BFA
X-Message-ID-Hash: E7SP77FIJAD3MAUH6O4PFY5DOCLT4BFA
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/E7SP77FIJAD3MAUH6O4PFY5DOCLT4BFA/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Sven Eckelmann <sven@narfation.org>

With the immutability guarantee of batadv_hard_iface->mesh_iface, the check
for "changed" (or NULL) mesh_iface is no longer necessary because a
batadv_hard_iface can no longer migrate from one batadv_mesh_iface to
another one.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/bat_iv_ogm.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index 4514c51bba777..22622283f59b0 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -404,23 +404,14 @@ static void batadv_iv_ogm_send_to_if(struct batadv_forw_packet *forw_packet,
 /* send a batman ogm packet */
 static void batadv_iv_ogm_emit(struct batadv_forw_packet *forw_packet)
 {
-	struct net_device *mesh_iface;
-
 	if (!forw_packet->if_incoming) {
 		pr_err("Error - can't forward packet: incoming iface not specified\n");
 		return;
 	}
 
-	mesh_iface = forw_packet->if_incoming->mesh_iface;
-
 	if (WARN_ON(!forw_packet->if_outgoing))
 		return;
 
-	if (forw_packet->if_outgoing->mesh_iface != mesh_iface) {
-		pr_warn("%s: mesh interface switch for queued OGM\n", __func__);
-		return;
-	}
-
 	if (forw_packet->if_incoming->if_status != BATADV_IF_ACTIVE)
 		return;
 
-- 
2.47.3

