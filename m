Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4E73C001B0
	for <batman-adv@archiver.kernel.org>; Wed, 16 Aug 2023 16:34:38 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id E762F835A3
	for <batman-adv@archiver.kernel.org>; Wed, 16 Aug 2023 18:34:36 +0200 (CEST)
ARC-Seal: i=3; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1692203676;
 b=H/eU3Nl2OWVcBdRLlJ4uwJhQrT938llEg/9Of5yZLlcap8RXytEhiEvQ+gRSBfgqh/bU8
 koRapnpYxwlJ3xqKsDS8C2NjBLfJXX+FH19pg3g/TP1SyYyxBpjFRwVLS/cO4MSMy37yV5d
 RhhffEES3HaSTnhm6L1GTmQTbG5zt5c=
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1692203676; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=TDr4ApcYiSq7b1LH4pTlLUo+yJYCl799b+ZbteyLDqg=;
 b=25BJwzbODR9MyqYF+AQY6To4dzxK+ED7nSHrDLfxIT22q9HVuiSXeg6yrVnDMKfA1lsfa
 +VyXz4C8SfGoqAUcRzXD+UJjCj2J3qWG4w9cm8yghP1FN/7ZS0gRSq8UNlLDzJIZ3kMNX96
 Vjuy5TQseFHYfKJvmrQo9k7XFspcQJE=
ARC-Authentication-Results: i=3; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 13962814CF
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 16 Aug 2023 18:33:21 +0200 (CEST)
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1692203601;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=TDr4ApcYiSq7b1LH4pTlLUo+yJYCl799b+ZbteyLDqg=;
	b=UyNLBOcBidA7B6kiKr9DgR+L39TxSP2QNatoWoVRUYvDosZpTYQ8aXHIU4koYI3lc/P3pW
	T0CW/kULer7qieaiZo6Bm1FW0hxAD+J24LP9eZq+PyX/5S4lmO6pSVmLDicfe6Tg8umOeG
	hSO6l2eNEsoRrpvMQO8zCzKWSPt9h7I=
ARC-Authentication-Results: i=2;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=RNif1Elg;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 23.88.38.48 as permitted sender) smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de;
	arc=pass ("simonwunderlich.de:s=09092022:i=1")
ARC-Seal: i=2; s=20121; d=open-mesh.org; t=1692203601; a=rsa-sha256;
	cv=pass;
	b=bh4s3XR70FLtMtmMS1+5ZxEMfJUBBvJPiE1Pv7kyMwWgBF3tgiZnI4nPocgjpiNIYyKCLj
	4WMQ/HvGsiS1IRYNTfKg6DVWYBX1/L0VMNm1zFfjC/SjMmHomJv6+6g7q1XrRQbP8AkG0B
	GzX9ogFeSlmolX3hL2tunpBwDU7lyBM=
Received: from kero.packetmixer.de
 (p200300FA272a67000Bb2D6DcAf57d46E.dip0.t-ipconnect.de
 [IPv6:2003:fa:272a:6700:bb2:d6dc:af57:d46e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits)
 server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id C0A49FB5B1;
	Wed, 16 Aug 2023 18:33:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1692203600;
 h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TDr4ApcYiSq7b1LH4pTlLUo+yJYCl799b+ZbteyLDqg=;
	b=RNif1ElgLtX1XNgo34EMgkPcO5bvSJuM3smEAG7H32FxEb7chYcIVrae2OLivrI+qGX9K+
	qhSu5jlg0SDB3jzGGv9zQVtIF6d9PZn2Mb4pumvvyy32Q0GeE8z1pnHZD7z0fVSRRD2NuX
	boI/Cw6s1v3WsJgag07VuUl8bem2UYV1m9BbNEbtmiXHyHeyeSCvmmEtl53aYo6wE5JSnv
	HxyAsX+rYBmHMmDPMhUyxSRJxDUQGZFLh2ZZEljSTNna3a0TsSZRWKzWotkPSxe7t3zjhO
	1vheyMFebETNMepkbK1hCgtPedUky5vA0eR/oAcMXHRPYuimJs4LCRaV2iG62w==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: davem@davemloft.net,
	kuba@kernel.org
Subject: [PATCH 1/5] batman-adv: Trigger events for auto adjusted MTU
Date: Wed, 16 Aug 2023 18:33:14 +0200
Message-Id: <20230816163318.189996-2-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230816163318.189996-1-sw@simonwunderlich.de>
References: <20230816163318.189996-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
	d=simonwunderlich.de; s=09092022; t=1692203600;
	h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TDr4ApcYiSq7b1LH4pTlLUo+yJYCl799b+ZbteyLDqg=;
	b=lY2tZcU3Oc7gr3m4vR+VbFmStW3bKrvzjD0zoTvWkAJrLM9sXyA9lelui69YIzNxgIvv5a
	AWbZE4XLalZWSaM7KMvwVHaCFbSkh6u6D0MdzaAmnGKAOjR232tmJuV5bIFZAOvZ+Sa1Df
	nAYThj5auLs8M2WQb3nsyLajr9pPMPFYPd7Wsyfbm+hJGi2fRixPa2RuWQVkLHGs2OLugc
	THblU1YavYRkhedX9cGacj54kZtNhEEQ5CPMEmeJwz68si3mlYO41oG+Aods3gTMXcuZ2c
	iMTIp6k0zW5hCQB9hnPL5J+F/3LH0jJJHH2Sglx6LdnXucAiQMPBnWxagEg98Q==
ARC-Seal: i=1; s=09092022; d=simonwunderlich.de; t=1692203600; a=rsa-sha256;
	cv=none;
	b=gi3BxAgYdVgaF7/GAmc3riqNqKa2RKe2eKZHU5kqbFwPdZ40JQlzZ+5RwZPzpr8HdHVhB3meZJ770phCT883HX7Z0rWSmrBTJAGLwq1ik7J4J6i3Q8Qzcj1LLdM6Q6lBwvYMALicQUDE221CxwCBteT7gZyLXA5xdb9Eekol5eOKRVMy8txqUFfQ61CvH4rqxxz637Ity0pdrY4M9lt/tWYzsOm2IBcifqr65LJoCWfkKSnBoCXaQGTXOnmArH/3P2gIMi4oMWJyOgNDwPJvGhgcUfTkR/x6jAP6invWK+fhJMxl0IvEA+vIBFrUCndlmlrQUl1c08KAl/SIKI9jDQ==
ARC-Authentication-Results: i=1;
	mail.simonwunderlich.de;
	auth=pass smtp.auth=sw@simonwunderlich.de smtp.mailfrom=sw@simonwunderlich.de
Message-ID-Hash: OEQIZIMAEIB6SJESQPL2OVN7UDNZUNMV
X-Message-ID-Hash: OEQIZIMAEIB6SJESQPL2OVN7UDNZUNMV
X-MailFrom: sw@simonwunderlich.de
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
CC: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org,
 stable@vger.kernel.org
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/OEQIZIMAEIB6SJESQPL2OVN7UDNZUNMV/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Sven Eckelmann <sven@narfation.org>

If an interface changes the MTU, it is expected that an NETDEV_PRECHANGEMTU
and NETDEV_CHANGEMTU notification events is triggered. This worked fine for
.ndo_change_mtu based changes because core networking code took care of it.
But for auto-adjustments after hard-interfaces changes, these events were
simply missing.

Due to this problem, non-batman-adv components weren't aware of MTU changes
and thus couldn't perform their own tasks correctly.

Fixes: c6c8fea29769 ("net: Add batman-adv meshing protocol")
Cc: stable@vger.kernel.org
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/hard-interface.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index 41c1ad33d009..ae5762af0146 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -630,7 +630,7 @@ int batadv_hardif_min_mtu(struct net_device *soft_iface)
  */
 void batadv_update_min_mtu(struct net_device *soft_iface)
 {
-	soft_iface->mtu = batadv_hardif_min_mtu(soft_iface);
+	dev_set_mtu(soft_iface, batadv_hardif_min_mtu(soft_iface));
 
 	/* Check if the local translate table should be cleaned up to match a
 	 * new (and smaller) MTU.
-- 
2.39.2

