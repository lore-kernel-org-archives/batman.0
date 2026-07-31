Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB936C54F54
	for <batman@archiver.kernel.org>; Fri, 31 Jul 2026 11:47:03 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 0665D8039D
	for <batman@archiver.kernel.org>; Fri, 31 Jul 2026 13:47:02 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1785498422;
 b=tPQmoI0KvYYBHUDd1Pwao3qtNv9IXI1+sz6pKdtSEDVnm4J+8kUJw7N7T9h1aczx93qV7
 3nG4BCRraZRj2Hbkws/TvAIa9KqXRjDOghKf8N5O3g74pWM6KGP82gRSn7611PNG1lcDhMZ
 mL6ktG14ES+zfHSvKFSDTVx9sAPFTHg=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1785498422; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=Jk+t1gbTn0vIzHA+Pji8f3oF59n152fxSvng3tx8PxA=;
 b=OItE01Dkjbqwb6XNUVYeH0Bu5lXosRiTAj2NSzA4rbUXVzb02L2DljT1IX4WQEUPQW4va
 LH90n4BheutiB3YAqA+GHc4yOMlMy/QwGWyU2BdrFLzHZscArHhlnQJvLvGMnKaSQ4eOKnj
 XIU01CeAO+bKaDisPnVTTWka2wL6Xuc=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 8D72084028
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 31 Jul 2026 13:45:43 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1785498343;
	b=J30frdYSoRNnsJDblVJHphjNjVLgKO4ZizUlARqbDBijpwyj3i/TY3r+GAKc4t9kkd4TLn
	XaSZv0+q6ICFGn3u6QGiz+Xi37wT4RazkkC5sbUMf3qL/faLDlwhSnDcsy5tQ2rdPrczYh
	q+TA7NSfizZDyBjXWa1/Zmj87P1g24M=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1785498343;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=Jk+t1gbTn0vIzHA+Pji8f3oF59n152fxSvng3tx8PxA=;
	b=BeIPYXe/IdL3OpEatlmpbboRKUEn3tji6GKFvsoBrrMkwnXfC+w/+HWXXVtbR1IK9rB+X5
	7LOrv4Q8//zNTj+3zG35e6CN2uUqd95PkJjBNIa+NwvbScRXZ9gzTbCjDkRaNogNK3MyTD
	n+7jX234FBTRQVGd7M/LsZG2RKMP17Y=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=XUjjEmAd;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 20B1820CB8;
	Fri, 31 Jul 2026 11:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1785498339;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jk+t1gbTn0vIzHA+Pji8f3oF59n152fxSvng3tx8PxA=;
	b=XUjjEmAdo/aPaqE+asJJ0krYZOjZyJiHbnF5eZ0VNp0resrXqs86jpow7sI3afnRlgrgFG
	lgoRjwbUwg1NssGf4qJk+TkwuMTrr17VnBN/4wGvD9r9idePtUGomiXrO9tLW3GlAQ3Edz
	XvmMmyHPilXw61FP8KplnJWfC/fNP1A=
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 31 Jul 2026 13:44:52 +0200
Subject: [PATCH 3/6] alfred: don't drop the mesh interface name on OOM
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-bugfixes-interfaces-v1-3-a148ca2f6688@narfation.org>
References: <20260731-bugfixes-interfaces-v1-0-a148ca2f6688@narfation.org>
In-Reply-To: <20260731-bugfixes-interfaces-v1-0-a148ca2f6688@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1452; i=sven@narfation.org;
 h=from:subject:message-id; bh=pRSFE5xka0j9wRzHmGUSeCZg1hDEOl+PF96paoCXyFo=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFk5XZsyrp4Pn3HnQou378qv6d+iz+/5FbTkbQVr9eGT/
 Ev4Zzzf21HKwiDGxSArpsiy50r++c3sb+U/T/t4FGYOKxPIEAYuTgGYSOFKhn82GhMZbu5Sf5Z/
 kKE4XW3u9zLfSyZq294ciDG/l7J8nU8Kw282pukrWNIKuZnFr8lYfEpvV4tLZRPYeG5j5mt3dof
 S2ewA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: 3LPJAJJY2JN2ROVENWVSMI3LQMYR3REY
X-Message-ID-Hash: 3LPJAJJY2JN2ROVENWVSMI3LQMYR3REY
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/3LPJAJJY2JN2ROVENWVSMI3LQMYR3REY/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

unix_sock_change_bat_iface() freed the old mesh_iface and then assigned
the result of strdup() directly to globals->mesh_iface. When strdup()
failed the old name was already gone and mesh_iface was left NULL. But it
still reported a success success.

Duplicate the name into a temporary first and only replace the stored
pointer once the allocation succeeded.

Fixes: b96cc742ef3e ("alfred: introduce 'change batman-adv interface' IPC call")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 unix_sock.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/unix_sock.c b/unix_sock.c
index 64fde70..417b380 100644
--- a/unix_sock.c
+++ b/unix_sock.c
@@ -404,6 +404,7 @@ unix_sock_change_bat_iface(struct globals *globals,
 			   struct alfred_change_bat_iface_v0 *change_bat_iface,
 			   int client_sock)
 {
+	char *mesh_iface;
 	int ret = -1;
 	int len;
 
@@ -412,9 +413,13 @@ unix_sock_change_bat_iface(struct globals *globals,
 	if (len < (int)(sizeof(*change_bat_iface) - sizeof(change_bat_iface->header)))
 		goto err;
 
-	free(globals->mesh_iface);
 	change_bat_iface->bat_iface[sizeof(change_bat_iface->bat_iface) - 1] = '\0';
-	globals->mesh_iface = strdup(change_bat_iface->bat_iface);
+	mesh_iface = strdup(change_bat_iface->bat_iface);
+	if (!mesh_iface)
+		goto err;
+
+	free(globals->mesh_iface);
+	globals->mesh_iface = mesh_iface;
 
 	ret = 0;
 err:

-- 
2.47.3

