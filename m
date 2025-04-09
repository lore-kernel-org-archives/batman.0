Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65F93C36002
	for <batman@archiver.kernel.org>; Wed,  9 Apr 2025 18:24:42 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id AEF44841DC
	for <batman@archiver.kernel.org>; Wed,  9 Apr 2025 20:24:40 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1744223080;
 b=3Cww+hS3YjlEXU1S7I8iB0WoEonXcVGmOSBl+QVzs9EigByJN0S7YgbqI1uR726ykpSXF
 7otREXTmK57p9ABL8MmaJUQNQqil1XMKQ30fkVXX9XWevpTwbOOlOymm5wWIhnCpoXexLpf
 RfBV4yiwpWx2pTtNkvAFl6bCOIG+GkU=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1744223080; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=fmABFA67142xBv1sgjgdUjf2o65cAlIZeMq1xn621CA=;
 b=0dpAMjOKsgSh5nlaUbFBydyBTd8ITknO11mVx1z3xupaXbAh0ANYYzg7vuFdbLo2fDmZ0
 RWz6WoluLebR+XUgxLsNh33I69xHnKbLNwPHUkvecul2QQGpq8IPXlTen782EXCAbnRmz+k
 f26u5WRs1qDPnM3+40rtg47at7AKmQM=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=universe-factory.net;
  arc=pass;
  dmarc=none
Authentication-Results: open-mesh.org;
 dkim=pass header.d=universe-factory.net; arc=pass; dmarc=none
Received: from mail.universe-factory.net (osgiliath.universe-factory.net
 [141.95.161.142])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 49C3281AFD
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed,  9 Apr 2025 20:24:14 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1744223065;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=fmABFA67142xBv1sgjgdUjf2o65cAlIZeMq1xn621CA=;
	b=lc0jy2UK4mETK+7aq4CUQYcNDbWYMzYwKY7LhbR7K62GL9MduSGvsvLYmvxp5fij/d4ljV
	1vXLCLYZNzy4ysZVUfYj0XlSCBD/ySMcLGO1svqQiF2RLDlfo0DeBQtzuCiIF8JmgwnFX0
	XAaxix0D8i74f/0O5go0fUrB+PiVYqA=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=universe-factory.net header.s=dkim header.b=gHnL2QjX;
	spf=pass (diktynna.open-mesh.org: domain of mschiffer@universe-factory.net
 designates 141.95.161.142 as permitted sender)
 smtp.mailfrom=mschiffer@universe-factory.net;
	dmarc=pass (policy=reject) header.from=universe-factory.net
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1744223065; a=rsa-sha256;
	cv=none;
	b=B8sDpoqdtHgBBruM2evMTshnkdSf87/pV5n4RZNAY8sP4S5xFZ46YpSBhlnFmgt3aM4MEF
	Z8Y48t235yCm9GNDnbCHKUC6fvSwWRRLGzrSRsWZ7EZf2KSWAzTGaEU+xvWp9jnOsA4Qe5
	CRVrlxdZxcN9fx6MXuQ3hwjy6dv6FKU=
From: Matthias Schiffer <mschiffer@universe-factory.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=universe-factory.net;
	s=dkim; t=1744223052;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=fmABFA67142xBv1sgjgdUjf2o65cAlIZeMq1xn621CA=;
	b=gHnL2QjXlUiba817MP99GgwvD+VqveXBMAXrETnNZpEuehC0mRFrsV/q69rIsfWZYtXNJU
	ZQkhkwweDwOeVqV+tSKqX/18qKwN0tY1doaBVF4MLDc0yrp1OPdcZ2RhqCOXijSzj7EZmG
	qFsg6ILROzJ7dZHUlQBXxsztYQuQ3chjBYqGJnP4GCUwkE/VdOlqcDfklmLeR3nBWGZeMy
	WSvPtCP/9mx15hg7Q4PhHireQPQowQ13HmYWg8NmDmPeUr4s9B+b3sVZk2uj9vXPwpsWF8
	k2IJOtm38ff6C+3T8eOEZXHcdQsE72z6RIWgw4gbQJfSdapRTjQH4vqlAMVr3A==
To: Marek Lindner <marek.lindner@mailbox.org>,
	Simon Wunderlich <sw@simonwunderlich.de>,
	Antonio Quartulli <antonio@mandelbit.com>,
	Sven Eckelmann <sven@narfation.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Matthias Schiffer <mschiffer@universe-factory.net>
Subject: [PATCH net-next v2] batman-adv: constify and move broadcast addr
 definition
Date: Wed,  9 Apr 2025 20:23:37 +0200
Message-ID: 
 <c9d8fd3735ffe10d199ee658703766bcc0d02341.1744222963.git.mschiffer@universe-factory.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: -
Message-ID-Hash: QKAB6HOO2EGLT3FBFZXPFKCSBMFDJEKE
X-Message-ID-Hash: QKAB6HOO2EGLT3FBFZXPFKCSBMFDJEKE
X-MailFrom: mschiffer@universe-factory.net
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/QKAB6HOO2EGLT3FBFZXPFKCSBMFDJEKE/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

The variable is used only once and is read-only. Make it a const local
variable.

Signed-off-by: Matthias Schiffer <mschiffer@universe-factory.net>
---

v2:
- make variable static
- remove "net: " subject prefix to match other batman-adv commits


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
index 67af435ee04e..bfe90a888af4 100644
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
2.49.0

