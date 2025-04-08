Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FA10C369A2
	for <batman@archiver.kernel.org>; Tue,  8 Apr 2025 15:54:49 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 6EA8A83D1F
	for <batman@archiver.kernel.org>; Tue,  8 Apr 2025 17:54:47 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1744127687;
 b=EhU3xyPBnIyb9YTHq2EXp1yH6osXCn2Yu9C+7UVmgn0MEHhD6q8NG0D0/dKSFF7UZyDAZ
 pNiiXrQI91omBLJmjA13kyhJB3F2ACoQevw6CwwmbeuIvYrvzbbUcVyh5jqiImk+cWd0ARN
 uap9RroxlQhxk6Fa4IfiOYWQvz5f+Tk=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1744127687; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=OHKKJGQMaL8g2OEp8XjLpUph+kOsUS2Z1oSy6oV7E8M=;
 b=Hv6KohDP3YXAxW3SEGoaA+VGc1yT5H6+6voSd2riNXyHrOjqzFkVwt8kWpI/tAagLwcdd
 jQsdLxVfP/SjMvvS6AuqezgLLVfHIlBjmnBmWk8RUk7FrHN43z/M4DWdSoDU7aeTKOMuXM5
 qnyHoTA+eaMFjNZtsyNKqA3KMJ7aTj4=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=universe-factory.net;
  arc=pass;
  dmarc=none
Authentication-Results: open-mesh.org;
 dkim=pass header.d=universe-factory.net; arc=pass; dmarc=none
Received: from mail.universe-factory.net (osgiliath.universe-factory.net
 [141.95.161.142])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id A8CE78090D
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue,  8 Apr 2025 17:54:20 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1744127670;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=OHKKJGQMaL8g2OEp8XjLpUph+kOsUS2Z1oSy6oV7E8M=;
	b=ro37ZSnDkyt6SujX8rcJc7DmMTjUYEQ/jxyDf8y9ZcIqPsNhJKLpa0TlhMXUfzEi2oT07U
	ppw19g2RAUDrPFxrQR20dL3MDI3uYMSQTu+xbNVMqjKYZGeqUfDIYaYVG/NYsn0Ufg42eP
	cCCBc0l0T2CNxBLEz8Amhz7RzTnm3K4=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=universe-factory.net header.s=dkim header.b=XtdI8usb;
	spf=pass (diktynna.open-mesh.org: domain of mschiffer@universe-factory.net
 designates 141.95.161.142 as permitted sender)
 smtp.mailfrom=mschiffer@universe-factory.net;
	dmarc=pass (policy=reject) header.from=universe-factory.net
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1744127670; a=rsa-sha256;
	cv=none;
	b=ARVSChatbdFmbvLIJUy1DE3gggtKd0kMYErHrJ+KHzRx8GfN603qwyZhg0ZdBcT4mDK7L+
	k5mFkyW97QED/UWgoiVftkt9lcv52UWh427SKkeDa2mlW0S27GbOmp5prAA7Ys290WW26N
	6axuo3u/LAVxnlpwYgOoekLXKWOVEqQ=
From: Matthias Schiffer <mschiffer@universe-factory.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=universe-factory.net;
	s=dkim; t=1744127659;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=OHKKJGQMaL8g2OEp8XjLpUph+kOsUS2Z1oSy6oV7E8M=;
	b=XtdI8usbHZnsiMYM/CuWz+HhhoMcnD7SUR5y6FaCvqjcXjLBeoFej06tEvVnDqWJ4kNGWe
	/zqBNWDxyAccMn2Lr1YpqTyoUYt6P9Ge2eNbQEKSG8uLTf7BjZ3VYGIFHVJ7YRTr6BzZZ8
	+nmlF43ygqk4t4dUSynNLy8LekNx/S5eWKWdnH4S7PYJl7JJ4gnMuTgFhxM/2QyFgBZSSv
	z3gUIHmliWGMkUdDnpvKNKRhqlmqx/liBezQEHtf+rYLwocXlfwPQN8h9/D3znJNBtbf+S
	t15V41d86qPHcLzFFyO06Jcyy3GY6lORzauxc4+Q9hr1t9q8+dkh5dqUVjRDFA==
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
Subject: [PATCH net-next] net: batman-adv: constify and move broadcast addr
 definition
Date: Tue,  8 Apr 2025 17:53:36 +0200
Message-ID: 
 <c5f3e04813ff92aca8dddc7e1966fe45fca63e56.1744127239.git.mschiffer@universe-factory.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: -
Message-ID-Hash: 5HI2TZ3GDIN477BLJOWENMXPZG7S4C56
X-Message-ID-Hash: 5HI2TZ3GDIN477BLJOWENMXPZG7S4C56
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/5HI2TZ3GDIN477BLJOWENMXPZG7S4C56/>
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
index 735ac8077821..90356b622a48 100644
--- a/net/batman-adv/send.c
+++ b/net/batman-adv/send.c
@@ -124,7 +124,9 @@ int batadv_send_skb_packet(struct sk_buff *skb,
 int batadv_send_broadcast_skb(struct sk_buff *skb,
 			      struct batadv_hard_iface *hard_iface)
 {
-	return batadv_send_skb_packet(skb, hard_iface, batadv_broadcast_addr);
+	const u8 broadcast_addr[] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
+
+	return batadv_send_skb_packet(skb, hard_iface, broadcast_addr);
 }
 
 /**
-- 
2.49.0

