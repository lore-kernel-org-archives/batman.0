Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD41DC43458
	for <batman-adv@archiver.kernel.org>; Sun, 28 Jun 2026 15:13:05 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 5367A84481
	for <batman-adv@archiver.kernel.org>; Sun, 28 Jun 2026 17:13:04 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1782659584;
 b=VKxS5undE+LRIzERLlZ/1f3/GdICK5472pi/g+bi/W4f6STdTvyFA4X0vMXFpQxwFNLTt
 eUSvIRObret8OCCeRzZoOQG4o/UHMEFar35i5LsZ1IgtQsu3HqOg+srvCPpDa8NNeSmJELH
 osKuDVcr3awdacVvjkkVor8qDIHazCM=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1782659584; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=OxPOlYVJmj5Z3QjbN8syqSbQLwXD0KBDSTz3eVy7tto=;
 b=1Ks5mAmTTfpEl0EMSO244IIf69oe1gxydeCThj6lBWQMAOYIkGk9j+dGX3TTleYDoLaYK
 fEWtnMN45XMC1Wl7jwcQ7fWrl169/S2ZRPpVKAEANikbbXp7sYMDV4FBzSQbxgdbzvgNRoH
 y3vaZ0XJR9Y+vjmb5M7EHnhoqqWhphU=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=universe-factory.net;
 arc=pass;
 dmarc=none
Authentication-Results: open-mesh.org;
 dkim=pass header.d=universe-factory.net; arc=pass; dmarc=none
Received: from mail.universe-factory.net (osgiliath.universe-factory.net
 [141.95.161.142])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id BE6698051A
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 28 Jun 2026 17:08:07 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1782659287;
	b=s6MI+zarDfGTBSLISexD9uMCkDJQMpPLEfeHitneYhAuH3iXBhcfXblcwm6VRU8v78NoXt
	/ZN4y9hrfn0js3lIdGKRxNRFPYvR8BKNmCZ8+sGcYuslEyhdHa/8oGRjf8uoyOj7uuW4fZ
	6L4cC+WNRSbgHh46Xa0otmuwcXWiBwE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1782659287;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=OxPOlYVJmj5Z3QjbN8syqSbQLwXD0KBDSTz3eVy7tto=;
	b=3f9WbUBKxaFfmAixipuovV4jobbHwNC22h/UXGWWs1VdYAxyKunB1TggocFA+On8p6suPW
	zF4mH+Fu+woqETVYeicB6jDNvcBa4pefr1RKoo94Os0tWP/52UclsR9De3ZHFJiPq0e2s/
	rcsIF6FXMF/FXroQWTtxIdQ5Q3rWRlo=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=universe-factory.net header.s=dkim header.b=B4eai+4O;
	spf=pass (diktynna.open-mesh.org: domain of neocturne@universe-factory.net
 designates 141.95.161.142 as permitted sender)
 smtp.mailfrom=neocturne@universe-factory.net;
	dmarc=pass (policy=reject) header.from=universe-factory.net
From: Nora Schiffer <neocturne@universe-factory.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=universe-factory.net;
	s=dkim; t=1782659287;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OxPOlYVJmj5Z3QjbN8syqSbQLwXD0KBDSTz3eVy7tto=;
	b=B4eai+4OeQv8NKDai+zvq2AiibZ/3LBXZ2+kxtdEP4btCmTLggYPn46eDg9Op4j2PzhurJ
	WEIlyfP27/v+GzUcjTxOH3Mg/br1ISwfgCqFEJvXBUzCH9ZPsd9ueaEOCOl6dCUVyRk7Ck
	m4bswZR9Mbub0+RquQYerMEgy2PCmZGhT4vaSaq2Mg3lynxlSH7k/7E/7U5iimdPTPHoJW
	b2HUC6UfoS7dB7821822HfgRp3VC4ZMVmjv2x36bzcxFl385qp4P7hz40eJ/xmNsUqtQlw
	xG6AlzeDIiSH2Bqj3pnABU3p4zORG8S1k/uRkoUx0hWgfQZuFbn75d0S3vHX+g==
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: sven@narfation.org,
	Nora Schiffer <neocturne@universe-factory.net>
Subject: [PATCH batadv v5 6/6] batman-adv: drop unneeded goto and
 initialization from batadv_hardif_disable_interface()
Date: Sun, 28 Jun 2026 17:07:33 +0200
Message-ID: 
 <c0151a14d55f1d13f33b3770446edf86185c326f.1782658366.git.neocturne@universe-factory.net>
In-Reply-To: <cover.1782658366.git.neocturne@universe-factory.net>
References: <cover.1782658366.git.neocturne@universe-factory.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: -----
X-MailFrom: neocturne@universe-factory.net
X-Mailman-Rule-Hits: member-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-3; emergency
Message-ID-Hash: GYPMIXJDRFRNA3DA2K2JFONTGAO7RU44
X-Message-ID-Hash: GYPMIXJDRFRNA3DA2K2JFONTGAO7RU44
X-Mailman-Approved-At: Sun, 28 Jun 2026 17:11:17 +0200
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/GYPMIXJDRFRNA3DA2K2JFONTGAO7RU44/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

The only use of the label was too early for primary_if to be set
anyways.

Also move the put of primary_if further up to hold the reference only as
long as necessary, hopefully avoiding the need to re-introduce the goto
label with future code changes.

Signed-off-by: Nora Schiffer <neocturne@universe-factory.net>
---

v5: new patch


 net/batman-adv/hard-interface.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index 9b8108d464db..6fc49ad47fd8 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -835,14 +835,14 @@ int batadv_hardif_enable_interface(struct net_device *net_dev,
 void batadv_hardif_disable_interface(struct batadv_hard_iface *hard_iface)
 {
 	struct batadv_priv *bat_priv = netdev_priv(hard_iface->mesh_iface);
-	struct batadv_hard_iface *primary_if = NULL;
+	struct batadv_hard_iface *primary_if;
 
 	ASSERT_RTNL();
 
 	batadv_hardif_deactivate_interface(hard_iface);
 
 	if (hard_iface->if_status != BATADV_IF_INACTIVE)
-		goto out;
+		return;
 
 	batadv_info(hard_iface->mesh_iface, "Removing interface: %s\n",
 		    hard_iface->net_dev->name);
@@ -857,6 +857,7 @@ void batadv_hardif_disable_interface(struct batadv_hard_iface *hard_iface)
 
 		batadv_hardif_put(new_if);
 	}
+	batadv_hardif_put(primary_if);
 
 	bat_priv->algo_ops->iface.disable(hard_iface);
 	hard_iface->if_status = BATADV_IF_TO_BE_REMOVED;
@@ -874,9 +875,6 @@ void batadv_hardif_disable_interface(struct batadv_hard_iface *hard_iface)
 		batadv_gw_check_client_stop(bat_priv);
 
 	batadv_hardif_put(hard_iface);
-
-out:
-	batadv_hardif_put(primary_if);
 }
 
 /**
-- 
2.54.0

