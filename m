Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA721CD6E6B
	for <batman-adv@archiver.kernel.org>; Fri,  5 Jun 2026 07:21:08 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 59AA7810E8
	for <batman-adv@archiver.kernel.org>; Fri, 05 Jun 2026 09:21:07 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1780644067;
 b=ecwatUSn5RIRVz4PThfdNrtrq5gBLxXpVxvlIMLhtkSDzTB/s5erlx/t9peZf754o5IWb
 mMOHQZJUEP+aclDBSxw4/F2jQCPvFuiP3GzpVHrjqQqSbZUlxwXH8/uvHY+u87N0BT8He4N
 fpI1N07pHN0hZ32BJ2A+oSXBDNBDIxE=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1780644067; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=pdWoGEypLT0hA4oET8XmjqY81On+S12Bc4UStp9tjaE=;
 b=ck4Tg3kpQvLhpUYE/L/qg70qY6/u8JYy7cP9ISp6QYmdwRujpD7zWJpQ0si+UYLqmAdYf
 p9R2oLjSP99o7Wcc4MH6StcCrr+byjfGy0BCO4HeKEH8h1a6rXvm9dzocCJ4C+1gKe3uYV1
 AKsjZ33BYbtC8QMlT5DDhdBOC04RDdc=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id E0F258026D
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 05 Jun 2026 09:20:14 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1780644014;
	b=yWCflH1LqHPKFRgh5rEGIfGLP/63Ohx9g2i6zUApLxLL0R8LHP231xSbImeEjaiJ3bPOv5
	ChGY+0UhkjtSo609DW93HL0zzYoXUf6nUht85OrsDKGJwmpdwLlpsrS33+PlNl8SX44lO6
	vXhfYhx3Aa/95khvUQLx+ubub1sjZ9A=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b="gS2LJBm/";
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 23.88.38.48 as permitted sender) smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1780644014;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=pdWoGEypLT0hA4oET8XmjqY81On+S12Bc4UStp9tjaE=;
	b=F/k+Sp3Nt8DC9BHkaPyQ//8ddd7yOxH0BLlyN/9nnU+uIguW/UgRnGtZQ13OfAyrUBsyfy
	oKZEZ0wPm/+q9X3DQbBU4DKTiUazA1gKanQsksHCARjypA+Tqxn81XFHntFr8zRpn6THGS
	Q7AbpEQKKMVn0OocUwmppVWyTcCZszo=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1780644013;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pdWoGEypLT0hA4oET8XmjqY81On+S12Bc4UStp9tjaE=;
	b=gS2LJBm/VjTOKGxFoTLo1ffpyMs5uutNlKIeDzb5eUDOyKUpABtuoNt61FC2shV3GMoag1
	56ncRJtsezrEuJw890ipKzVO0sa1aAPJloagU2iYU3LYgIQ0ZQFwI1q+TCtsxV5JAa3tUm
	KxIOd5l4iEkIxTiMe+8NxYpDg9t8wUCqk1pbdlTy0cPLYyvudQN/jKfbk3IagbwYWo/8We
	wljn19pDaT1sZTsdBmh/82go/dGrlz9bCGS5bz9Tq2uR5cLr5Fp14HLwyFB+QX3RpZSUwY
	CJWkkUdPAEtSudGILXV5YwJ34cPHHVrpDLumIItPhUjvI+UTGGpAkiWqjxq/aA==
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
Subject: [PATCH net-next 04/11] batman-adv: use GFP_KERNEL allocations for the
 wifi detection cache
Date: Fri,  5 Jun 2026 09:19:58 +0200
Message-ID: <20260605072005.490368-5-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260605072005.490368-1-sw@simonwunderlich.de>
References: <20260605072005.490368-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: XY3XMLJH5QRFB5OAM5XOTJXFJ34J4LQ3
X-Message-ID-Hash: XY3XMLJH5QRFB5OAM5XOTJXFJ34J4LQ3
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/XY3XMLJH5QRFB5OAM5XOTJXFJ34J4LQ3/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Sven Eckelmann <sven@narfation.org>

The batadv_wifi_net_device_insert() is called with ASSERT_RTNL() held, but
not inside a spinlock or another context which prevents "might_sleep"
functions. To relax the requirements for the allocator, use GFP_KERNEL.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/hard-interface.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index 96b8130375a3a..04b227ec80525 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -983,11 +983,11 @@ batadv_wifi_net_device_insert(struct net_device *net_dev, u32 wifi_flags)
 
 	ASSERT_RTNL();
 
-	device_state = kzalloc_obj(*device_state, GFP_ATOMIC);
+	device_state = kzalloc_obj(*device_state, GFP_KERNEL);
 	if (!device_state)
 		return -ENOMEM;
 
-	netdev_hold(net_dev, &device_state->dev_tracker, GFP_ATOMIC);
+	netdev_hold(net_dev, &device_state->dev_tracker, GFP_KERNEL);
 	device_state->netdev = net_dev;
 	WRITE_ONCE(device_state->wifi_flags, wifi_flags);
 
-- 
2.47.3

