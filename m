Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82BE2CA9ED1
	for <batman@archiver.kernel.org>; Mon, 12 Oct 2026 11:49:03 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id ABC1380CC7
	for <batman@archiver.kernel.org>; Mon, 12 Oct 2026 13:49:01 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1791805741;
 b=iGGGMAoXy5OTpP0+o9j2jCisSq89vFbnVkf1LkrDZTZABk93irAAV0Pm28cLJ3uDTg6uv
 FcJLiSNBOwW12Re8QfNxUQhfJnnP8PJOZ0dk68kJMdLYPLt/+X+6/lJ6L4msZ1GGOX3k7Ha
 vI0tx/A1ZiKX9Zmgzd0b/qNTmlU7Y0w=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1791805741; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=LAIjHZVIXeK/cDsO//pANG+9pNhQqEoa7DxTzFckhlQ=;
 b=2LN8ncne7hNWgJZEYULOoGBANnxcPbSHaMaT5VYgVS/gMkCt2o7vdy09tcOMXSeKEdfB9
 1zbzHk5tjPc5zt2j89oim77WGNXuFK8r+nRl9dT4lB9JpcjOjdMxqTnWnDQfsBua/O7CG8s
 spmeSg8GOLz1plpZ9wZyXWaqkaUcCgM=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 9D4EC80CC7
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 12 Oct 2026 13:48:42 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1791805732;
	b=hc9MXJBh1R60lminWSbaqqZia7Qltb8oecZYD/w7QdxEuZo5pOc6oNWV8q0GMj1PHLc/Eu
	19J0eb/FBRqkZlFD6imDM/4BgNlt6quXim/oCHumKh3KLYP6D5QNlQIOVrKKZKnoWtFRyO
	gzlUeXwW8S7alAowOiX6rywo+xsW88s=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1791805732;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=LAIjHZVIXeK/cDsO//pANG+9pNhQqEoa7DxTzFckhlQ=;
	b=4DWsNppXbVspAjgQMSABtxlUAAqirioC9KLrGRGffOvYavtRa2gENHUJvxM6UtsWTEbkCT
	kQkiItLGbMS1qW2lA2T5voVkBSn5cxBh3o49KCdfP3vaDdY+rJ+2XAcYvtUtxjrlna0KKY
	GHlZHvTWTa/XR6lTsGF6wxGr4NsVoFw=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=UQlwPczZ;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id C879B20131;
	Mon, 12 Oct 2026 11:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1791805721;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LAIjHZVIXeK/cDsO//pANG+9pNhQqEoa7DxTzFckhlQ=;
	b=UQlwPczZZm+B+vJuFidJArg0bwO1nQpMS9sLvviQMjLrbwODAVOMsg1G94YOiXUOuOOjCt
	aUHdxBnC0YrQXi/1Af6D5GI9FUZQPLQpUGbYqpoZdXqudxiT9fdUt/zeFw7Llxpnvy56yf
	0avpSrZG5nE1EM5WFwcawxiRl083MIA=
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 12 Oct 2026 13:48:37 +0200
Subject: [PATCH batadv] batman-adv: mcast: explicitly initialize
 mcast.num_want_all_rtr{4,6)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-mcast_atomic_init-v1-1-eb8d129802bf@narfation.org>
X-B4-Tracking: v=1; b=H4sIABTJzGoC/yWM0QrCMAwAf2Xk2UJTx0B/RWRkbaYR1kmTDWHs3
 63u8Q7uNlAuwgrXZoPCq6jMuQKeGohPyg92kipD8KFDj8FNkdR6snmS2EsWc579pUvYYmrPULt
 34VE+/+cNBjJKK9wPr8vw4mi/Iez7F5uELo19AAAA
X-Change-ID: 20261012-mcast_atomic_init-0e096d141d43
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sashiko <sashiko-bot@kernel.org>, Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1509; i=sven@narfation.org;
 h=from:subject:message-id; bh=gMN2NzYE/+SRR50K6NI/Rr9/dMQgDCo33q5T4eZBQOs=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFlnTooXTli6ysruykwjnsXqsjrslmISr1dPO89u+Hw18
 /qPmZbbOkpZGMS4GGTFFFn2XMk/v5n9rfznaR+PwsxhZQIZwsDFKQATmZrJ8M+wIjX+kozfYp9N
 4qniMRHLWP/t3JVlO9H21HvPNcy52y8wMvw5qpEVvVP755f1X5j65vCcCflb92iS9QlmO4aVf62
 2LmMDAA==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: 3AU47YO4632YYIGBWP5MB6EPM45PITCH
X-Message-ID-Hash: 3AU47YO4632YYIGBWP5MB6EPM45PITCH
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/3AU47YO4632YYIGBWP5MB6EPM45PITCH/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

All mcast.num_want_all_* are initialized in batadv_mesh_init_late() - with
the exception of mcast.num_want_all_rtr4 + mcast.num_want_all_rtr6. At the
moment, it works because atomic_set just initializes it to 0 and the netdev
private data is already set to 0 before being passed to .ndo_init.

For consistency purposes, also initialize mcast.num_want_all_rtr4 +
mcast.num_want_all_rtr6 explicitly.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/bug/linux-9dbe5dec-31ae-49eb-838a-b4b92ced4ace
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/mesh-interface.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/batman-adv/mesh-interface.c b/net/batman-adv/mesh-interface.c
index 41d14863..dd624a97 100644
--- a/net/batman-adv/mesh-interface.c
+++ b/net/batman-adv/mesh-interface.c
@@ -833,6 +833,8 @@ static int batadv_meshif_init_late(struct net_device *dev)
 	atomic_set(&bat_priv->mcast.num_want_all_unsnoopables, 0);
 	atomic_set(&bat_priv->mcast.num_want_all_ipv4, 0);
 	atomic_set(&bat_priv->mcast.num_want_all_ipv6, 0);
+	atomic_set(&bat_priv->mcast.num_want_all_rtr4, 0);
+	atomic_set(&bat_priv->mcast.num_want_all_rtr6, 0);
 	atomic_set(&bat_priv->mcast.num_no_mc_ptype_capa, 0);
 #endif
 	WRITE_ONCE(bat_priv->gw.mode, BATADV_GW_MODE_OFF);

---
base-commit: 0eaac0f4187bc9b69b41d90998fd7b93ab07e53e
change-id: 20261012-mcast_atomic_init-0e096d141d43

Best regards,
--  
Sven Eckelmann <sven@narfation.org>

