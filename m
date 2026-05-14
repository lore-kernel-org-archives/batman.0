Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F165CD4F39
	for <batman@archiver.kernel.org>; Thu, 14 May 2026 17:42:30 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id A979985D5F
	for <batman@archiver.kernel.org>; Thu, 14 May 2026 19:42:28 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1778780548;
 b=lsMTTBi98NvrgjCUWA9q8FPttNs7zHM22YojuhrG4OsE8gxjbHbWPYRWI2hb+UaKEOvxe
 n3nOQJmG/0DoR1CV7z94ywoV1CmTT8F2cgJVneT7DnIQXOZAlBsFXjL856l7FbsaO6GrI+3
 tLfluIw4WtWKFIa8VlcJJgZxwGKSgo4=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1778780548; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=4a9Y0h/ZBiheyVkCkrbY4b+dniEGitki6h4/+xiVgiY=;
 b=KBC/DBqX8YbbNKPXzNi03B/OyrA0NOrD13Zf21rPBxTfXJC7Y35kvylD45f4/rQOFryjd
 VaVO30sWJOUVCDl6tDs/wFK42caHKoq4pIGS1D1yDyRDp+oFzyFZ/E2KxN1rNIzYmb17vdE
 jYhKQR3r9Y0l17T0yE3HogQ2X9VFx1E=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 775EE84436
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 14 May 2026 19:42:03 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1778780523;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=4a9Y0h/ZBiheyVkCkrbY4b+dniEGitki6h4/+xiVgiY=;
	b=iub0AVlDkSpn2KELKF9Z/slyBLQj4J62mdrPSVVvGAqCxpihHZOCd7x1itNnYET4KgnQsq
	vFdjLd9E9GkZY9RPVhZZgkdQFydVjvZxsIFf2rw9itQH2FzV3diSufsSZC99DB2HpBwuf4
	7Q9WtSGH6IzBxXny4VdwlP+QHENjWpY=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=MjDW2oTj;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1778780523;
	b=C5LgOEOPb7Dv0MXb/5f1/P5EwxjDqaQPPhUFspvFDMf79NMR1Vtu6QWKB4onH01c+NRB7o
	gazyDKivmW7xhn6MCJ7F4z04cggE9rSHFR10B3kJV8ej3maCKxOrmSvse9MRYEqfucXHHl
	7sMPcf6CA/UdRCbkI37L162fJgZwzeg=
Received: by dvalin.narfation.org (Postfix) id E223D218A8;
	Thu, 14 May 2026 17:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1778780522;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=4a9Y0h/ZBiheyVkCkrbY4b+dniEGitki6h4/+xiVgiY=;
	b=MjDW2oTjkBaqEsJgJf4gd9fVd4ZS7Y7uDTXBeIjP70NCDxK+T1dZo+sPMzJ/Iifj4KgvOH
	3pVMG1ILEIrY9bv2RM61Azxn2lJS0OmgcaX2XuAPr+Kgd7YLTGtdu11EXydGFNF2rXXAcd
	sp5PqFL8Uf8CVLs8bMhMPzamYmGtuhk=
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 14 May 2026 19:41:38 +0200
Subject: [PATCH RFC batadv] batman-adv: mcast: fix use-after-free in
 orig_node RCU release
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260514-mcast-rcu-list-free-v1-1-0e20f24faa61@narfation.org>
X-B4-Tracking: v=1; b=H4sIAFEJBmoC/yWMwQrCMBBEf6Xs2YUk1FC9Cn6AV+kh2W51Ratk0
 1Io/XdTvc2bYd4CyklY4VgtkHgSlfdQwO4qoHsYbozSFQZnnDd7W+OLgmZMNOJTSugTMza1sTE
 48v7QQHl+Evcy/6xXuJxPWxdDDt0E7X/WMT6Y8maGdf0CH30vR4YAAAA=
X-Change-ID: 20260514-mcast-rcu-list-free-8401ba2c6698
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: =?utf-8?q?Linus_L=C3=BCssing?= <linus.luessing@c0d3.blue>,
 Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1800; i=sven@narfation.org;
 h=from:subject:message-id; bh=wB8v2U+tB4Bpa3DUsz7meYFa8DGItK8IRZtj8IbREn8=;
 b=kA0DAAoWTQ93K9MU9csByyZiAGoGCVOhvstg7PKp7r4rAI32TuNS5CgHRFmLMSnaIHrgLWjfN
 Yh1BAAWCgAdFiEEvNRvz7MH7R/zlvHFTQ93K9MU9csFAmoGCVMACgkQTQ93K9MU9ctelQEA95U+
 zdDHCLE2jlq/1xu7R9IJ0ZZwHkTwDHUUCtTkimQA+wdeWAdo40K6ZKSJP8k2VFSFB3gARosBUm8
 uGMsV9VMN
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: DB774XRVN3NGWKF7NUIQEXFLJXU5PFMG
X-Message-ID-Hash: DB774XRVN3NGWKF7NUIQEXFLJXU5PFMG
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/DB774XRVN3NGWKF7NUIQEXFLJXU5PFMG/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

batadv_mcast_purge_orig() removes entries from RCU-protected hlists but
does not wait for an RCU grace period before returning. Concurrent RCU
readers may still accesses references to those entries at the point of
removal. RCU-protected readers trying to operate on entries like
orig->mcast_want_all_ipv6_node will then access already freed memory.

Fix this by moving batadv_mcast_purge_orig() to batadv_orig_node_release(),
just before the call_rcu() invocation. This ensures RCU readers that were
active at purge time have drained before the orig_node memory is reclaimed.

Fixes: 1c090349e2f6 ("batman-adv: Add IPv4 link-local/IPv6-ll-all-nodes multicast support")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
See
https://sashiko.dev/#/patchset/05bdee6e85c3514822f98afa8fb75826b3928dd0.1778671969.git.ruijieli51%40gmail.com
---
 net/batman-adv/originator.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
index b3468cca..ad4921b6 100644
--- a/net/batman-adv/originator.c
+++ b/net/batman-adv/originator.c
@@ -835,8 +835,6 @@ static void batadv_orig_node_free_rcu(struct rcu_head *rcu)
 
 	orig_node = container_of(rcu, struct batadv_orig_node, rcu);
 
-	batadv_mcast_purge_orig(orig_node);
-
 	batadv_frag_purge_orig(orig_node, NULL);
 
 	kfree(orig_node->tt_buff);
@@ -887,6 +885,8 @@ void batadv_orig_node_release(struct kref *ref)
 	}
 	spin_unlock_bh(&orig_node->vlan_list_lock);
 
+	batadv_mcast_purge_orig(orig_node);
+
 	call_rcu(&orig_node->rcu, batadv_orig_node_free_rcu);
 }
 

---
base-commit: 5e1068c577818529e2f7a7f5ccb9fe4a440198c7
change-id: 20260514-mcast-rcu-list-free-8401ba2c6698

Best regards,
--  
Sven Eckelmann <sven@narfation.org>

