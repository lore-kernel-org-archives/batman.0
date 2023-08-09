Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 858EDC04A6A
	for <batman-adv@archiver.kernel.org>; Wed,  9 Aug 2023 15:35:11 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id A2A0B830E9
	for <batman-adv@archiver.kernel.org>; Wed,  9 Aug 2023 17:35:09 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1691595309;
 b=GR9nkeS7LwTBIWhCTBFcSLVySKbKouKP1cJCTu/2H+SUEWLV6cdxGqGL926tPHkneQFx4
 LWag4IqR70i79tOOOhZPfXqU/k5zxpxetWQ5LkzsuUyhamihfmGfBFuiWPkwEZJZu3wSe7i
 YRMMRAqgNYbyi5TYZ5VZYG82p7ZVM6Q=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1691595309; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=JjbqZMZcF7SvDfZFLqUbMSSV7FMRWiQrPnMyUknpIKo=;
 b=XLhINgnuniel3XQNQbRZZ6N+uYug3550CvwTImKrm2hFw51rDQQh1c5wh2yBOeeP6TwW7
 KOmJYm1CvH5rmd+xZ3qm2jxLi591H6FuXrGoLMQ89VfcBvgoBq3hFMjoybuihaeBef+NciU
 Uf4DaS01FebjQsU3xJcTOZDQhoIENN8=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=fail;
  arc=pass;
  dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass; dmarc=none
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net
 [IPv6:2001:4b98:dc4:8::224])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 848FC80457
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed,  9 Aug 2023 17:28:12 +0200 (CEST)
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1691594892; a=rsa-sha256;
	cv=none;
	b=TXCDQN13WRPhzImahZu3+N3hkyf9u8A3rKusVZOa5eMzGSq1y5QOwwlzdi2AUr15BlIq8Y
	2KgT06BpCKH9w6M56WuXStWlUdZIMIIUW5KAx+JXLefywYia60+6dY0vD3LXUTXXNMB6aw
	rW6kjfDWwZV8dcN84LBfxlxcQVa1irw=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	dmarc=none;
	spf=pass (diktynna.open-mesh.org: domain of repk@triplefau.lt designates
 2001:4b98:dc4:8::224 as permitted sender) smtp.mailfrom=repk@triplefau.lt
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1691594892;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=JjbqZMZcF7SvDfZFLqUbMSSV7FMRWiQrPnMyUknpIKo=;
	b=qc9fn8zucfA2aTimvtbRDQWY5OZaiT2kPADj4RLOj2Upk/81xUKoc+dwJRkU1w2ASTTUjA
	CiBB5V2jZC1aJZvj0YN/Y/IXcXJYgjeG4WZT0wbk+UPdRTYi1XFWe6BQy8R0C0oGitMfPu
	uchbfKdfdLvIIhusaQuD0XypTphqfB8=
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7382CE000B;
	Wed,  9 Aug 2023 15:28:10 +0000 (UTC)
From: Remi Pommarel <repk@triplefau.lt>
To: Marek Lindner <mareklindner@neomailbox.ch>,
	Simon Wunderlich <sw@simonwunderlich.de>,
	Antonio Quartulli <a@unstable.cc>,
	Sven Eckelmann <sven@narfation.org>
Subject: [PATCH net] batman-adv: Fix batadv_v_ogm_aggr_send memory leak
Date: Wed,  9 Aug 2023 17:29:13 +0200
Message-Id: <20230809152913.27218-1-repk@triplefau.lt>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: repk@triplefau.lt
X-MailFrom: repk@triplefau.lt
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1
Message-ID-Hash: 7PMIL2NY4DTR5IMLFBAFOSPSZXAIQ6Y4
X-Message-ID-Hash: 7PMIL2NY4DTR5IMLFBAFOSPSZXAIQ6Y4
X-Mailman-Approved-At: Wed, 09 Aug 2023 17:34:08 +0200
CC: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, b.a.t.m.a.n@lists.open-mesh.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Remi Pommarel <repk@triplefau.lt>, stable@vger.kernel.org
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/7PMIL2NY4DTR5IMLFBAFOSPSZXAIQ6Y4/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

When batadv_v_ogm_aggr_send is called for an inactive interface, the skb
is silently dropped by batadv_v_ogm_send_to_if() but never freed causing
the following memory leak:

  unreferenced object 0xffff00000c164800 (size 512):
    comm "kworker/u8:1", pid 2648, jiffies 4295122303 (age 97.656s)
    hex dump (first 32 bytes):
      00 80 af 09 00 00 ff ff e1 09 00 00 75 01 60 83  ............u.`.
      1f 00 00 00 b8 00 00 00 15 00 05 00 da e3 d3 64  ...............d
    backtrace:
      [<0000000007ad20f6>] __kmalloc_track_caller+0x1a8/0x310
      [<00000000d1029e55>] kmalloc_reserve.constprop.0+0x70/0x13c
      [<000000008b9d4183>] __alloc_skb+0xec/0x1fc
      [<00000000c7af5051>] __netdev_alloc_skb+0x48/0x23c
      [<00000000642ee5f5>] batadv_v_ogm_aggr_send+0x50/0x36c
      [<0000000088660bd7>] batadv_v_ogm_aggr_work+0x24/0x40
      [<0000000042fc2606>] process_one_work+0x3b0/0x610
      [<000000002f2a0b1c>] worker_thread+0xa0/0x690
      [<0000000059fae5d4>] kthread+0x1fc/0x210
      [<000000000c587d3a>] ret_from_fork+0x10/0x20

Free the skb in that case to fix this leak.

Cc: stable@vger.kernel.org
Fixes: 0da0035942d4 ("batman-adv: OGMv2 - add basic infrastructure")
Signed-off-by: Remi Pommarel <repk@triplefau.lt>
---
 net/batman-adv/bat_v_ogm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/batman-adv/bat_v_ogm.c b/net/batman-adv/bat_v_ogm.c
index e710e9afe78f..445b06fc0d90 100644
--- a/net/batman-adv/bat_v_ogm.c
+++ b/net/batman-adv/bat_v_ogm.c
@@ -123,8 +123,10 @@ static void batadv_v_ogm_send_to_if(struct sk_buff *skb,
 {
 	struct batadv_priv *bat_priv = netdev_priv(hard_iface->soft_iface);
 
-	if (hard_iface->if_status != BATADV_IF_ACTIVE)
+	if (hard_iface->if_status != BATADV_IF_ACTIVE) {
+		kfree_skb(skb);
 		return;
+	}
 
 	batadv_inc_counter(bat_priv, BATADV_CNT_MGMT_TX);
 	batadv_add_counter(bat_priv, BATADV_CNT_MGMT_TX_BYTES,
-- 
2.40.0

