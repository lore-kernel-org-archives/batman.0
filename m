Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F439C3601E
	for <batman@archiver.kernel.org>; Thu, 10 Apr 2025 19:00:25 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 8688D84286
	for <batman@archiver.kernel.org>; Thu, 10 Apr 2025 21:00:23 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1744311623;
 b=QwE9pn2PzKwVVJUVjZTFRJ+Br/+IS0bT4oKGgyCxJFAj3BcHyIdRDXBQykcZ7uBqhodFW
 6zTb+aHmA8hjim2lQFCHhCgIW8IADT+ZUj+cywX3WakISTfRul/J4PyAsT7CTt447fmG2Px
 FetkPIYcvYP1haV4cbOZQIoKyY1fIMg=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1744311623; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=1vg3rWY75JJY4ec4wQ7CE1NNZAlolqmH7TapGgVLLek=;
 b=vFF1lHS1mUe4rADvW+4eaa4mTN6nf/Rezihls0HUB7K8kkfGkU9o8psBYuyeg2u1oVW0x
 Qge/l7QHug+upwmJgUfOvYSxPCxlrSDrV3O+PTQuulb0CT+k8MQRFoIvvziXptDM8Q+qTBC
 ai1XGoiC4Bc0D2AoIgUtpbUZOVE8v74=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=narfation.org
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 3C7EE81AFD
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 10 Apr 2025 20:59:56 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1744311606;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=1vg3rWY75JJY4ec4wQ7CE1NNZAlolqmH7TapGgVLLek=;
	b=Oklk8+3wKlit5XMB6RpJ8mnpvhrI+0t56a9Gpa2cwzrOWj6QxwZG6jz6aLo8uTriZ8Koi6
	hQO9DEpAjV5BiNC7RW5qiuKHijgh/sJNACBAsdBd3WFpZPK85ZvMdo8GiVKmtUkbVVVAxz
	n7Z8+cstNIIDitAQp/aRoDhrTKFMzEM=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=USdCPw8h;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1744311606; a=rsa-sha256;
	cv=none;
	b=Ndphw8XaulcFhIhdGUZ8dPuMdtnUM/TkW2yQ56AwDia+TBJDbZsfwo0t1hhD2Tg3B2RiKn
	LcvUMb3x/lvBokdQdHdQrfBICm2EKYa57itu2yFkvynis+OsMB95yl2xu5h/xK482cqAZl
	DOsUNpXcWExLkRC7RwLllF4Z4IHHZYM=
Received: from sven-desktop.home.narfation.org (unknown
 [IPv6:2a00:1ca0:1d86:99fc::ab85])
	by dvalin.narfation.org (Postfix) with UTF8SMTPSA id 91E7B20380;
	Thu, 10 Apr 2025 18:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1744311594;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1vg3rWY75JJY4ec4wQ7CE1NNZAlolqmH7TapGgVLLek=;
	b=USdCPw8hpaRcxdIOlovRYyIzmOqZPsFMzPu/Tw1qIg4OUX23hh9CsEgfsxPgjPw4VFhaPw
	6J7R45X67/7oEu9Gntkx8ShV1wntamz5OsTq46V+JRDU5Lt+gLbSfpgaSzo2yMDzpsaRo1
	iIg8bwuSDeoGDF68IYcK8DHY8y7M/+Q=
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 10 Apr 2025 20:58:51 +0200
Subject: [PATCH net v4] batman-adv: Fix double-hold of meshif when getting
 enabled
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250410-double_hold_fix-v4-1-2f606fe8c204@narfation.org>
X-B4-Tracking: v=1; b=H4sIAOoU+GcC/02OQQrCMBBFr1Jm7ZQ0NiR15T1ESjSTNlCTMolFK
 L27wZXL9+A//g6ZOFCGS7MD0xZySLFCf2rgOds4EQZXGaSQSvSdQJfej4XGOS1u9OGDxgtrtNf
 SugHqamWq+le8QaQC9yo9pxeWmcn+xcQg9FnJvlVKd2bADvNG8Rote1vqjTbxBMfxBf5BhvmjA
 AAA
X-Change-ID: 20250410-double_hold_fix-8f0a87f72ad9
To: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2158; i=sven@narfation.org;
 h=from:subject:message-id; bh=FOhVsMUz8Lp5Kj9QrzKl6yXio9mXHudXG/T2oelAxWQ=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDOk/RJV7pnUb7ouxVF6S+17MQnpvT6pe1Z8ZztekdY9wn
 FtaYejVUcrCIMbFICumyLLnSv75zexv5T9P+3gUZg4rE8gQBi5OAZhIEB8jwyrPELWXZ6QWCV6W
 T2nfJLzpgHHeS26JzNe7GXU5VF91ijD8Zpt1Y3X/waKc+T/0P9WYPl6xf1GQDsd5BbtzrycumLL
 bkh8A
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: YG2HFLKBE2OCIMWMNZG2664VCTNQ74JZ
X-Message-ID-Hash: YG2HFLKBE2OCIMWMNZG2664VCTNQ74JZ
X-MailFrom: sven@narfation.org
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/YG2HFLKBE2OCIMWMNZG2664VCTNQ74JZ/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

It was originally meant to replace the dev_hold with netdev_hold. But this
was missed in batadv_hardif_enable_interface(). As result, there was an
imbalance and a hang when trying to remove the mesh-interface with
(previously) active hard-interfaces:

  unregister_netdevice: waiting for batadv0 to become free. Usage count = 3

Fixes: 00b35530811f ("batman-adv: adopt netdev_hold() / netdev_put()")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
This patch is skipping Simon's normal PR submission to get this problem
fixed faster in Linus' tree. This currently creates quite a lot of wrong
bisect results for syzkaller and it would be better to have this fixed
sooner than later.
---
Changes in v4:
- added Suggested-by: Eric Dumazet <edumazet@google.com>
- added Reported-by: of various syzkaller reports which were affected (during
  bisecting) by this problem
- resubmission after 24h cooldown time
- added kernel message during hang to commit message
- Link to v3: https://lore.kernel.org/r/20250409073524.557189-1-sven@narfation.org
Changes in v3:
- fix submitter address
- Link to v2: https://lore.kernel.org/r/20250409073304.556841-1-sw@simonwunderlich.de
Changes in v2:
- add missing commit message
- Link to v1: https://lore.kernel.org/r/20250409073000.556263-1-sven@narfation.org
---
 net/batman-adv/hard-interface.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index f145f96626531053bbf8f58a31f28f625a9d80f9..7cd4bdcee43935b9e5fb7d1696430909b7af67b4 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -725,7 +725,6 @@ int batadv_hardif_enable_interface(struct batadv_hard_iface *hard_iface,
 
 	kref_get(&hard_iface->refcount);
 
-	dev_hold(mesh_iface);
 	netdev_hold(mesh_iface, &hard_iface->meshif_dev_tracker, GFP_ATOMIC);
 	hard_iface->mesh_iface = mesh_iface;
 	bat_priv = netdev_priv(hard_iface->mesh_iface);

---
base-commit: 61f96e684edd28ca40555ec49ea1555df31ba619
change-id: 20250410-double_hold_fix-8f0a87f72ad9

Best regards,
-- 
Sven Eckelmann <sven@narfation.org>

