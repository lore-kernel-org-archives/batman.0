Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83A8CC43458
	for <batman-adv@archiver.kernel.org>; Sun, 28 Jun 2026 15:16:07 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 17A9A84285
	for <batman-adv@archiver.kernel.org>; Sun, 28 Jun 2026 17:16:06 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1782659766;
 b=P8/m6EC8wJw24n9bd84k0tzTYeqyJPi0WJu/n//XKkoTns1qQBWjqUxMB5hxgyI9E+LBT
 sLAsbipttThMSM3EpkEQKVCZOrLgs9WmQMX2JgXIbxjn8F1Hg20d5Nu80tUZhQcWU0O7BlC
 BeUqTuVR6QdkHIBx2noWHOV1voej5dc=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1782659766; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=rZICpg8kLYNnmMO5w1063JJD2jv46o1GrMiOUtO5ecw=;
 b=E0avPH8RRR/jrHTYzwU8FVRK4b1qqoQCHiUEQ6vv/VSf5gbUMJK/onVIXLO3ikJnumoou
 l+v7Rf+lo9oi9DLfKPoUJhaeqn7TShO9mXQZY6HIiZfsL/JlXefKJgOqvpwz2k+R+ZF2Uj3
 mVssEnG573SK+J5KVgO8vqhq/UjvfIY=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=universe-factory.net;
 arc=pass;
 dmarc=none
Authentication-Results: open-mesh.org;
 dkim=pass header.d=universe-factory.net; arc=pass; dmarc=none
Received: from mail.universe-factory.net (osgiliath.universe-factory.net
 [141.95.161.142])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id DE28C83F44
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 28 Jun 2026 17:08:06 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1782659291;
	b=c7/MIT/GY78Tg8IQUwUsRefdWg+RKOOejeGQFru0+LvQrlys8D596+gWM/5FceJdg58KIK
	yJ1iuQM/+xM0qHU6h0aBJ4BEubFdf6T0DpVYY8GJeqchbcb8KZ3mMcg0TrYpym9gqUzZxA
	eYstKrBNHWuS/ehnWMqjDSGfb2EhQMc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1782659291;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=rZICpg8kLYNnmMO5w1063JJD2jv46o1GrMiOUtO5ecw=;
	b=Uy2Klm+fVWSpaVnLtycs4Z17ued8IDBmN3E5DVQM05RFAsqILBnw6s1OsJH4GJMyyFFcdF
	gHPbkylb6/OB04A8ETO3Mn9TixGjTCiiEnx9poVfbYrPLekElScsROpVyKg2tVduPsZXal
	Zv8L+T1h7+tc8ROFvglP6YZdhscC2Yw=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=universe-factory.net header.s=dkim header.b=YRUM7E2x;
	spf=pass (diktynna.open-mesh.org: domain of neocturne@universe-factory.net
 designates 141.95.161.142 as permitted sender)
 smtp.mailfrom=neocturne@universe-factory.net;
	dmarc=pass (policy=reject) header.from=universe-factory.net
From: Nora Schiffer <neocturne@universe-factory.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=universe-factory.net;
	s=dkim; t=1782659286;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rZICpg8kLYNnmMO5w1063JJD2jv46o1GrMiOUtO5ecw=;
	b=YRUM7E2xnIgdotFbmCIyn1qDtaMxSubjQWncFA0+RbSXDFp8W5D6kXjfL7jLY8QKWIXoum
	pMpw1mu0p5g9MkVAj8XShkFCMQyHzxwvHVaoRiqDwnlxiB8Hu3ON3XCks+unImRan+0Dm2
	YhWx2PElDyiFu77usjoiLfWfOGGt+rtGtZNt9ygxOT6tRl8WPwBAEOaAjiJA1mL++CJ4xV
	0DjDxdjBUFDm/EPViaMgl2aFEnUsJQdpAFvvSBj7CPcjc5RAuDdGr4X5uewFMpnfhZ3Vce
	HLzzb600XGZ/UBJj87Gm6nvsKkT5RXP5RUFufB9S3LdhRQ4P27STkDfB4QLOPA==
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: sven@narfation.org,
	Nora Schiffer <neocturne@universe-factory.net>
Subject: [PATCH batadv v5 3/6] batman-adv: make hard_iface->mesh_iface
 immutable
Date: Sun, 28 Jun 2026 17:07:30 +0200
Message-ID: 
 <99c8e0aadebe8764b6df3d8638448e99c13d2a73.1782658366.git.neocturne@universe-factory.net>
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
Message-ID-Hash: JIZSUBID35HWEE6DJIRRVICK74DEC452
X-Message-ID-Hash: JIZSUBID35HWEE6DJIRRVICK74DEC452
X-Mailman-Approved-At: Sun, 28 Jun 2026 17:11:17 +0200
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/JIZSUBID35HWEE6DJIRRVICK74DEC452/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

With the hard_iface now being created for a specific mesh_iface, it is
beneficial not to set mesh_iface to NULL when the interface is disabled,
but instead keeping it immutable after the initial setup of the
hard_iface. By also holding the reference to the mesh_iface until the
hard_iface is released, hard_ifaces iterated over under RCU will always
point to a valid mesh_iface.

Co-developed-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Nora Schiffer <neocturne@universe-factory.net>
---

v5:
- Move immutable mesh_iface change to a new patch

v2-v4 (by Sven Eckelmann):
- Rebase
- Introduce immutable mesh_iface as part of the "remove global hardif
  list" patch


 net/batman-adv/hard-interface.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index ace81348ddef..a0b8b06f9a64 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -63,6 +63,7 @@ void batadv_hardif_release(struct kref *ref)
 	struct batadv_hard_iface *hard_iface;
 
 	hard_iface = container_of(ref, struct batadv_hard_iface, refcount);
+	netdev_put(hard_iface->mesh_iface, &hard_iface->meshif_dev_tracker);
 	netdev_put(hard_iface->net_dev, &hard_iface->dev_tracker);
 
 	kfree_rcu(hard_iface, rcu);
@@ -829,8 +830,6 @@ int batadv_hardif_enable_interface(struct net_device *net_dev,
 err_upper:
 	netdev_upper_dev_unlink(hard_iface->net_dev, mesh_iface);
 err_dev:
-	hard_iface->mesh_iface = NULL;
-	netdev_put(mesh_iface, &hard_iface->meshif_dev_tracker);
 	batadv_hardif_put(hard_iface);
 	return ret;
 }
@@ -871,7 +870,6 @@ void batadv_hardif_disable_interface(struct batadv_hard_iface *hard_iface)
 	/* delete all references to this hard_iface */
 	batadv_purge_orig_ref(bat_priv);
 	batadv_purge_outstanding_packets(bat_priv, hard_iface);
-	netdev_put(hard_iface->mesh_iface, &hard_iface->meshif_dev_tracker);
 
 	batadv_hardif_generation++;
 	netdev_upper_dev_unlink(hard_iface->net_dev, hard_iface->mesh_iface);
@@ -881,7 +879,6 @@ void batadv_hardif_disable_interface(struct batadv_hard_iface *hard_iface)
 	if (list_empty(&hard_iface->mesh_iface->adj_list.lower))
 		batadv_gw_check_client_stop(bat_priv);
 
-	hard_iface->mesh_iface = NULL;
 	batadv_hardif_put(hard_iface);
 
 out:
-- 
2.54.0

