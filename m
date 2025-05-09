Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43B27C3ABBC
	for <batman-adv@archiver.kernel.org>; Fri,  9 May 2025 09:12:35 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id CBA0284C00
	for <batman-adv@archiver.kernel.org>; Fri,  9 May 2025 11:12:33 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1746781953;
 b=rs3hAGC1DMMEdNYLatfDo+QXVhJA9BqZwNG++bMJ+1dSqp3B0tKiVk+nwkIztOf2dIV/T
 XfubJ2pq4457eFx1yJJc8POQLojPsLprVr90pvxxDAR3VKiQsKPyGTmhul+8TMV8CoHeuha
 JjRsASxiqW8EwoTW5CbIxk7ditgnzbY=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1746781953; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=MT2O5yuWlAWtL1w/i8VzuxR63yn0CLOKS04fenoXtgg=;
 b=chxMVX1Kqw24u/oPwq8jeuFBQhXZbMwbAmbuXNYh0Rg3uVxkpzof+SQQT6jT6GPrLKcg/
 nHHnaEQAIfVCFuG756YYYcElzV1lpBMKEwHpMsEXZ9/kQjkYGOU31/mXeltaA4AGMVelGCD
 4d1b+RvH1gPCqVS3WqWcY5/+b88vmKE=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=fail;
  arc=pass;
  dmarc=fail (Used From Domain Record) header.from=simonwunderlich.de
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass;
 dmarc=fail (Used From Domain Record) header.from=simonwunderlich.de
 policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de
 [IPv6:2a01:4f8:c17:e8c0::1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 9FA94840FB
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri,  9 May 2025 11:10:44 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1746781844;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MT2O5yuWlAWtL1w/i8VzuxR63yn0CLOKS04fenoXtgg=;
	b=cxlAhNpv5ARlWel8iAElRX2Jib0UUiEEE+VZl7XFVJLx4v3NFrFbIf6EHWyjVjQoTJK7MZ
	skKqNKqseAeB9NrM1C5BGIHINHWK8ogxJT0M4eTXwGypPQX51z3KDaSn7CGIuDEx1jjkMj
	OnVL6+6pNU0MHv0nql6y2PiWJn8BlYk=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 2a01:4f8:c17:e8c0::1 as permitted sender)
 smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1746781844; a=rsa-sha256;
	cv=none;
	b=JrI6nylH4On2EHF5WA2/K8ZqNyeJRyzHOkeDNv/8rrbHKNunbyEEjP9r2Kx6VlwFBOFX6M
	+yeRv68q1NGcAF2wAjma7jlbcHKuQDyLzCTVKjCHRSpmEllDpV20V0MQqEAYS8PV7f8CmP
	47POhsZazgu58oQ+QzTcRSo/0LfHdG0=
Received: from kero.packetmixer.de
 (p200300c59736C7d829705d90aB67a755.dip0.t-ipconnect.de
 [IPv6:2003:c5:9736:c7d8:2970:5d90:ab67:a755])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id 0D414FA361;
	Fri,  9 May 2025 11:10:44 +0200 (CEST)
From: Simon Wunderlich <sw@simonwunderlich.de>
To: kuba@kernel.org,
	davem@davemloft.net
Cc: netdev@vger.kernel.org,
	b.a.t.m.a.n@lists.open-mesh.org,
	Matthias Schiffer <mschiffer@universe-factory.net>,
	Sven Eckelmann <sven@narfation.org>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net-next 2/5] batman-adv: constify and move broadcast addr
 definition
Date: Fri,  9 May 2025 11:10:38 +0200
Message-Id: <20250509091041.108416-3-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250509091041.108416-1-sw@simonwunderlich.de>
References: <20250509091041.108416-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: WOUK6G5PWOUJJ5ZF2PMXYPUSDR6ITIKA
X-Message-ID-Hash: WOUK6G5PWOUJJ5ZF2PMXYPUSDR6ITIKA
X-MailFrom: sw@simonwunderlich.de
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/WOUK6G5PWOUJJ5ZF2PMXYPUSDR6ITIKA/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Matthias Schiffer <mschiffer@universe-factory.net>

The variable is used only once and is read-only. Make it a const local
variable.

Signed-off-by: Matthias Schiffer <mschiffer@universe-factory.net>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/main.c | 2 --
 net/batman-adv/main.h | 1 -
 net/batman-adv/send.c | 4 +++-
 3 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index a08132888a3d..e41f816f0887 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -69,8 +69,6 @@ unsigned int batadv_hardif_generation;
 static int (*batadv_rx_handler[256])(struct sk_buff *skb,
 				     struct batadv_hard_iface *recv_if);
 
-unsigned char batadv_broadcast_addr[] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
-
 struct workqueue_struct *batadv_event_workqueue;
 
 static void batadv_recv_handler_init(void);
diff --git a/net/batman-adv/main.h b/net/batman-adv/main.h
index 4b5ce8972848..692109be2210 100644
--- a/net/batman-adv/main.h
+++ b/net/batman-adv/main.h
@@ -235,7 +235,6 @@ static inline int batadv_print_vid(unsigned short vid)
 extern struct list_head batadv_hardif_list;
 extern unsigned int batadv_hardif_generation;
 
-extern unsigned char batadv_broadcast_addr[];
 extern struct workqueue_struct *batadv_event_workqueue;
 
 int batadv_mesh_init(struct net_device *mesh_iface);
diff --git a/net/batman-adv/send.c b/net/batman-adv/send.c
index 735ac8077821..9d72f4f15b3d 100644
--- a/net/batman-adv/send.c
+++ b/net/batman-adv/send.c
@@ -124,7 +124,9 @@ int batadv_send_skb_packet(struct sk_buff *skb,
 int batadv_send_broadcast_skb(struct sk_buff *skb,
 			      struct batadv_hard_iface *hard_iface)
 {
-	return batadv_send_skb_packet(skb, hard_iface, batadv_broadcast_addr);
+	static const u8 broadcast_addr[] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
+
+	return batadv_send_skb_packet(skb, hard_iface, broadcast_addr);
 }
 
 /**
-- 
2.39.5

