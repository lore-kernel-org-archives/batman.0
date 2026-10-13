Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B33E4CA9ED2
	for <batman@archiver.kernel.org>; Tue, 13 Oct 2026 13:29:13 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id CB9608419A
	for <batman@archiver.kernel.org>; Tue, 13 Oct 2026 15:29:11 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1791898151;
 b=IyXYhejdkaDeJ7oBlqIni+I6YwXcaxDawD12QGPzCVhye4DtyDpxE1YlgSmYe2Ase8wYU
 oixBsAD2nIY3MKMuoMVH8LzYIlo7xBJtiuR74KNrvtvcYVBDuN6m8kDr82icNxoOxAtNqCk
 KrW0F6DIbudKrM+orxLF2ssUkGj6UZA=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1791898151; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=Ku57mCOPp4unf/KpXoyiUiy0l2qBfOW3iEZEqgviXGA=;
 b=CDjE9tas5wVpS0xVc7v5g2TpP0B7HCocN2rxKpvlbjiq/xhIDUMZpfM2Yf0ZlHa0+oDxr
 yPI1oB8U8kmm/moCTtnD0TJQ/DwlPNWufgGb0AAeUpI2XNZaecnlJ0z1M1UNQ032SROAv3n
 KEP5IKdaSQH74y4wGxIzMxja17B3kp8=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id EEE5481B08
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 13 Oct 2026 15:28:52 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1791898143;
	b=UpT4rlSi49rTgAch+IxL/JUQudmR0tRPBPCNkEcFikYjB3HA+LoiF+QBwuHGASl3SYunUN
	r/EKJbOvDxpa8rO82bDd6i15c2SIFPExWFucDjWhLU4CtrVIzZHwv0MSe6n6Rik+NDCL11
	Tv/OassGcEjMfWQbyRzKv3Rar4Hp2As=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1791898143;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=Ku57mCOPp4unf/KpXoyiUiy0l2qBfOW3iEZEqgviXGA=;
	b=vxHqnYzhpHXb8m8+hv3TQM/Be4l6/NRzHiQ39UHYMGB/YuKpPe1wfoueHQMq0VuPQFA/oP
	KGXZe82Iahyqzdus9rLrN6iVMr3Ntvv1Lxxy19U7XMzZ7+s9E4+hKdJWReqfhCb9N+bKvm
	WmU5kB6rRhvmYyY0a6C9Tiq55t7qnng=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=TDqGGrEz;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 639C02003A;
	Tue, 13 Oct 2026 13:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1791898131;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Ku57mCOPp4unf/KpXoyiUiy0l2qBfOW3iEZEqgviXGA=;
	b=TDqGGrEz3ASr57GlroVcO8Uw4TzJkd0os84RgrtGPUA4y+akePAOOanCwyvtzZjiXAnpOc
	7gANbtBt/Wb6H8XSXzDsdyKFZshG3Le2o2SbxF9AYDgA0h53c4EbCkXw9xdC+DrBuvgfWY
	ACrbnaTEws6LFVe+g2MvSZpM/DktitM=
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 13 Oct 2026 15:28:37 +0200
Subject: [PATCH batadv] batman-adv: fix skb leak when hard_iface is being
 released
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: 
 <20261013-fix-hardif-release-skb-leak-v1-1-3763e957e647@narfation.org>
X-B4-Tracking: v=1; b=H4sIAAQyzmoC/yWMQQ6CQAxFr0K6tskUhKhXMS46TJGKQdMiMSHcn
 UF3//28vAVcTMXhUixgMqvra8xAhwLanse7oKbMUIayoUAVdvrFni1phyZPYRf0IWJeAzKdjjV
 XVJ9DA7nwNsn6r36FyBOnGW7/3z/xIe20p2FdN9G6N4uHAAAA
X-Change-ID: 20261013-fix-hardif-release-skb-leak-a1845a315906
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1474; i=sven@narfation.org;
 h=from:subject:message-id; bh=tdkuGyLa4gRThYC6YikhYw4r//+7jZCBaYG7aRqJUzs=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFnnjHg5T8W9UJreMT/42zaJRPv7i+cxvOdYFR+92OiT4
 1/F4HnCHaUsDGJcDLJiiix7ruSf38z+Vv7ztI9HYeawMoEMYeDiFICJpP5hZLjd9yhMXDG/fkp+
 35yq0Gnx9ZfUKwJLbghe4P96x3Ltu8+MDD8viW7v+L0k8bKle1xiYW/jVN/bzH051v5clofy4pm
 vMgEA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: JKDEVMUQIMAHZQLTOZAMPVV4XD3UYVBV
X-Message-ID-Hash: JKDEVMUQIMAHZQLTOZAMPVV4XD3UYVBV
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/JKDEVMUQIMAHZQLTOZAMPVV4XD3UYVBV/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

batadv_batman_skb_recv() owns the skb it is given. When the hard_iface
refcount already dropped to zero, the function jumped to err_out, which
only returned NET_RX_DROP and skipped the kfree_skb() under err_free.

To avoid a leak, free the skb before returning in this case.

Fixes: fee73a8578d3 ("batman-adv: Check hard_iface refcnt when receiving skb")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/main.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index 6c54a8d4..ced76942 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -484,8 +484,10 @@ int batadv_batman_skb_recv(struct sk_buff *skb, struct net_device *dev,
 	 * shut down otherwise the packet may trigger de-reference errors
 	 * further down in the receive path.
 	 */
-	if (!kref_get_unless_zero(&hard_iface->refcount))
-		goto err_out;
+	if (!kref_get_unless_zero(&hard_iface->refcount)) {
+		kfree_skb(skb);
+		return NET_RX_DROP;
+	}
 
 	skb = skb_share_check(skb, GFP_ATOMIC);
 
@@ -541,7 +543,6 @@ int batadv_batman_skb_recv(struct sk_buff *skb, struct net_device *dev,
 	kfree_skb(skb);
 err_put:
 	batadv_hardif_put(hard_iface);
-err_out:
 	return NET_RX_DROP;
 }
 

---
base-commit: 0eaac0f4187bc9b69b41d90998fd7b93ab07e53e
change-id: 20261013-fix-hardif-release-skb-leak-a1845a315906

Best regards,
--  
Sven Eckelmann <sven@narfation.org>

