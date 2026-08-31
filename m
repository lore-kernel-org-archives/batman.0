Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94CE9C624A4
	for <batman-adv@archiver.kernel.org>; Mon, 31 Aug 2026 13:58:40 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 0A03E853A4
	for <batman-adv@archiver.kernel.org>; Mon, 31 Aug 2026 15:58:39 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1788184719;
 b=bu2q2brIkrYfVO386GPtFjBXP/IRep97lihnCJv0dIoVfw4tWyWNRw7tp9uHbwfMheYDk
 NCLC3XLiYFhBZiVzluBdiZ+BwAM5EEQ4ovmGkldUElnJoltuGEcop+UyerZO6J4tU9PDOHq
 YGtsDxlF35gukKB8TZy57wExsfp9c2M=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1788184719; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=gx6gvnUZXx8GmIOlt/SIJMl285NPM/aaQjtCmRPzCb4=;
 b=WoFrwMwlhe1zHPMDXJFFiQZjq/GivsbJBoNlHHf9Z/IYYyDASYLvMNpj/wBwK3o2Z+wVi
 IYNzKvjR42KhaHZBY/iBlpAnqdjUQn+aH+xuZbxas2pMbLQLAZ1GdXLBehvzNzie6seSN3M
 qWtrM1JoyCpIMLERyMNKBL7CVu0DboM=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de
 [IPv6:2a01:4f8:c17:e8c0::1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 984DC8194C
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 31 Aug 2026 15:51:39 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1788184304;
	b=cemv855RDiBkDJQ2w7BvB4hblWVkGAcuIKVeWRJ/xDAiiZCcyX55wQS2NsNyqLPa7xM9aT
	iHSnapnit6zP+fXYpVyXn786Ob+CseqF422MJC1h0X0rpRfSpzs8Ks2fw6i83BXHSHp+KB
	V/j2rS84POrHLJDi5tQ13O6DJEB0vEw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1788184304;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=gx6gvnUZXx8GmIOlt/SIJMl285NPM/aaQjtCmRPzCb4=;
	b=BT33L07d2OuZmpbfR3qKJZ54kRIJjecPdYHQgv1lQvXyOfecuXy2WLjfs7L+x6PgOEb0c8
	Z9LSULLvGky78C1msc6MXGSsxT/Z4OjdFVU135b3Pkm7JWhSNQQR1EbfpI3S3xeS1emxsu
	qljHPLMFmV4sWox11l5AZVhqwuixoyc=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=OduXuEYU;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 2a01:4f8:c17:e8c0::1 as permitted sender)
 smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
Received: from kero.packetmixer.de
 (p200300C5970EeDd85F51f1FAa919d7a5.dip0.t-ipconnect.de
 [IPv6:2003:c5:970e:edd8:5f51:f1fa:a919:d7a5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with UTF8SMTPSA id 02B10FA039;
	Mon, 31 Aug 2026 15:51:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1788184289;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gx6gvnUZXx8GmIOlt/SIJMl285NPM/aaQjtCmRPzCb4=;
	b=OduXuEYUjVQH+Zfo81evgzUdLJFfvoO5es2SD0T6AkQziSLVAVvhEoREEiXrrU+ICNAI2q
	QKexYvp4akzFHMZmzVVeKeZCt/KhQTRTLo6LV+fSi3JBWfGKyu0HX64glP0ivcRi5YMNdP
	uJDWXgHX2VtAJzX3Q41mdP1h7rJpaQZhaCCfemw6ZWR5/cSdurozFFwTlPyyLTKzVmbXeH
	s3dYRYiiMGjUjLhV9AUecXpEFpimZSJTm8M6cjbNIvhhhSuk6937nJ2ErL6l0IrbnKIwc3
	3nGE/PGMdl7c91GNSIP+u0oga77IrLcGCnHRdsAzX77RBUP18jsXx5rT3qYm0Q==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Sven Eckelmann <sven@narfation.org>,
	Sashiko <sashiko-bot@kernel.org>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net-next 01/15] batman-adv: dat: fix printing of unknown 4addr
 subtype
Date: Mon, 31 Aug 2026 15:51:03 +0200
Message-ID: <20260831135117.574836-2-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260831135117.574836-1-sw@simonwunderlich.de>
References: <20260831135117.574836-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: 5KSEQOXYXTSZ7NXQ326WXE2BBVM3NYJR
X-Message-ID-Hash: 5KSEQOXYXTSZ7NXQ326WXE2BBVM3NYJR
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/5KSEQOXYXTSZ7NXQ326WXE2BBVM3NYJR/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Sven Eckelmann <sven@narfation.org>

If an unknown subtype of an unicast 4addr packets was detected in
batadv_dbg_arp(), it is printing the (known) packet_type instead of the
subtype. This must be switched to the subtype to have any kind of use for
the reader of the debug message.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/distributed-arp-table.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/distributed-arp-table.c b/net/batman-adv/distributed-arp-table.c
index 011cfdc47fab4..270f8d6e29545 100644
--- a/net/batman-adv/distributed-arp-table.c
+++ b/net/batman-adv/distributed-arp-table.c
@@ -548,7 +548,7 @@ static void batadv_dbg_arp(struct batadv_priv *bat_priv, struct sk_buff *skb,
 			break;
 		default:
 			batadv_dbg(BATADV_DBG_DAT, bat_priv, "* type: Unknown (%u)!\n",
-				   unicast_4addr_packet->u.packet_type);
+				   unicast_4addr_packet->subtype);
 		}
 		break;
 	case BATADV_BCAST:
-- 
2.47.3

