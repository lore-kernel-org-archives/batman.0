Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E8DACD4F3C
	for <batman-adv@archiver.kernel.org>; Wed, 20 May 2026 11:58:25 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 3242F83E7D
	for <batman-adv@archiver.kernel.org>; Wed, 20 May 2026 13:58:24 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1779278304;
 b=A6OTg61qmfGBxCHPx3rik3a2F2NHDVJqUeqd1HkGhNLRXlzaFL3Kla6fMr9cmdx0QBGta
 xuqmPvNSJUI2huiQ1CNdmSI91NgvewptfHzgrIkZlVDwPjPSo+RO0bzGt8k01pozzx1QrOD
 Q34MUVF+7FanX3MJrjw2DktGj/tSe2w=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1779278304; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=KoLdXuK8L7KjFwX63mbZu2/GYyTKYsP6WvpL4UCAN5g=;
 b=lsOf4AyF52L2miz5e8/RqhyQtUcRMmZ6mZ/zsbX14Uitg9nShzx3eds+9ht2+Ox629n6K
 bxQtZVqTeK4HUdNTxZ48F15nxDMc0At3Vyif2yS0wQd5miIWbV2acKjOwFqCCDnMxS+PTu0
 /mdw2njYUzYyZQQsBAkYV/3blClZ8A0=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de
 [IPv6:2a01:4f8:c17:e8c0::1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id CA36E820D6
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 20 May 2026 13:54:43 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1779278083;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=KoLdXuK8L7KjFwX63mbZu2/GYyTKYsP6WvpL4UCAN5g=;
	b=p5cm3PTZgMpIjf6khIRm+QDw3Av3R8sEJiIm0hrpDitdGX+B75Z1bGDh8P199ApNswo052
	8E9VUH56S2+aCR8ItxQD5ZLFNICriwdL1NztWtq/xejYARx3EjoRNKzvPhszIHr7llH44i
	O6xcDbQYginbF5Yd74Q3nMdtDWIv+fk=
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1779278083;
	b=CqKdJUdQaEnVznzTTBsi8LImsa8OrtjzLLiRfKNWXAZdYWDkTeEWEERnC7yI3ejMQI9WvF
	YZLv/+Ft7WYwfbGjx2JIiGer2zIFmFQApCiJ4gYkEkLFCLJ+4nMK/5b00TGSHk9k1h5koq
	fJgkQWSGd365ytvVI1qgYbTR80yj6gQ=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=TkV5rQXk;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 2a01:4f8:c17:e8c0::1 as permitted sender)
 smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1779278083;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KoLdXuK8L7KjFwX63mbZu2/GYyTKYsP6WvpL4UCAN5g=;
	b=TkV5rQXk/0hSzBCRMCuYL+entTXOxHaoTfg/wbTKEASbBzbEVwFWBtgu7s2lLBvDZ76hoI
	qq0v4KrzL2aLZX/oLrTOcfRaBX20+Au9sFNScOnqK8ILAi87qwhQ/WSPQemsA9YkUNGhqi
	dxZE1SOu7SGKIKh+Hx0QcpB1ppTSF4b5jySCwo8NEWEkkXc6MIgo87vpbb9dfSDSmgnx7d
	IFtgv8+B1gedLtuWkEWs5mCsz8CAQ+WAjJ+Ms5+MYgS8w/6SpduqM5SI6AuIeOTE8YHzX9
	QRkg8I/n1FANNpdAPhMAQx6aMBEV0Ya0dPZaliycVf7C2KmHqNhE3hqhcCWhnw==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Sven Eckelmann <sven@narfation.org>,
	stable@kernel.org,
	=?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net 07/11] batman-adv: mcast: fix use-after-free in orig_node
 RCU release
Date: Wed, 20 May 2026 13:54:18 +0200
Message-ID: <20260520115422.53552-8-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260520115422.53552-1-sw@simonwunderlich.de>
References: <20260520115422.53552-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Message-ID-Hash: OIYBA6ANMNXTJDI6SMPRP4PSDSNT2ZZT
X-Message-ID-Hash: OIYBA6ANMNXTJDI6SMPRP4PSDSNT2ZZT
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/OIYBA6ANMNXTJDI6SMPRP4PSDSNT2ZZT/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Sven Eckelmann <sven@narfation.org>

batadv_mcast_purge_orig() removes entries from RCU-protected hlists but
does not wait for an RCU grace period before returning. Concurrent RCU
readers may still accesses references to those entries at the point of
removal. RCU-protected readers trying to operate on entries like
orig->mcast_want_all_ipv6_node will then access already freed memory.

Fix this by moving batadv_mcast_purge_orig() to batadv_orig_node_release(),
just before the call_rcu() invocation. This ensures RCU readers that were
active at purge time have drained before the orig_node memory is reclaimed.

Cc: stable@kernel.org
Fixes: ab49886e3da7 ("batman-adv: Add IPv4 link-local/IPv6-ll-all-nodes multicast support")
Acked-by: Linus Lüssing <linus.luessing@c0d3.blue>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/originator.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
index b3468ccab5354..ad4921b659d9d 100644
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
 
-- 
2.47.3

