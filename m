Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0304EC43458
	for <batman-adv@archiver.kernel.org>; Tue, 30 Jun 2026 13:47:48 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 99FB981551
	for <batman-adv@archiver.kernel.org>; Tue, 30 Jun 2026 15:47:47 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1782827267;
 b=1DcFLjyXYfnwctchsH9yKI3/jIXKykg4XRk53OwFt9S/eE8tlaoNq/xzX3e0g4fg4c2sq
 IVPqbjyUMRBi4AWd7cj0QmQRoqdS6q7knLSrw0o5iSKVMbwOBiNCv3HlHqgdPpinP5y7qEG
 I/ePHh38MMa9oziZKEx418fU2sftFKk=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1782827267; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=SiIK0ISh6k4aQjZejSleIeHh0c9JnPFk+A63O8+Yixs=;
 b=nRaVMR8kX2QO9YQJ1VQgKPZZTLk/YCFA3LeelfnZnsQtxq7rFgahQvLFD1+sSN7hvfA4c
 wb12acHmUnaqN6J92J13xBIcYEKp/zpX52TJA18H97nRl6ZJVzMgXFlFshngKdfoZWRRI9H
 OB4QiGIzN0bo0scMrMh7QX48xaGQTJI=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de
 [IPv6:2a01:4f8:c17:e8c0::1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 3A82483AC2
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 30 Jun 2026 15:44:36 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1782827076;
	b=mk3uAVleJXL9jGoGsbmCmmmdPtZYq0/6cw1HqR7pErT+lxpe72/wfEWLTezg2ZimXkwvax
	uY4yMtxh9BBKoxzK43NfEHmp1B7I7Gn5NIgK/u678I2LnOOPrgreQSQTGhiFTaBwvZNnf1
	SKQIajIK9cBXkrT/+r9MIRNC2y6u04I=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1782827076;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=SiIK0ISh6k4aQjZejSleIeHh0c9JnPFk+A63O8+Yixs=;
	b=JPCyNyR04D4pcOxqpQ0mfnsI1XNtZgrTnPZznihKGR7uUcw55cCCe+Jdsa74a0LtSimjnp
	dH79UW5FZ/8CMPMw/cWWe8TPYBK0StdHoMz3rLdJRCYOQToeVJd+TF0ZxCr7dSUdF5WQoo
	3OQOdiEVwt409G5E5eQqySP83STieQo=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=1CRTiOeA;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 2a01:4f8:c17:e8c0::1 as permitted sender)
 smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1782827074;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SiIK0ISh6k4aQjZejSleIeHh0c9JnPFk+A63O8+Yixs=;
	b=1CRTiOeAAZM8h6sEfcYh0sAkV+2Dt1H8ekbdwWd66z3t6SF/DCXLDasSEAYsLc4GBV3rV6
	olFVTPgZvt/WDmrkgFh2qt0t3ixGncqyOBQCToabMuv35cRys3n0fLNfheGmpSDXQWU1jI
	72tTym77n3PSOzHFFQ+lm9FeMQH6kY/BaD7chEglT+BqbtcphNOfKRMDlhf2iTaXlAXmaB
	NWqTu19ucBX1BlVKtg1C9mKJUfMkB4muXcLlKii1Kb86xjovtRjGfSQvL0ekMskPtjBS5T
	taILNb1ACCrGffX21stG7z0ZeMsGDH5pvb698H4unY+TIRV1JVXs3MEmuOO8kQ==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Sven Eckelmann <sven@narfation.org>,
	stable@vger.kernel.org,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net 4/6] batman-adv: dat: acquire ARP hw source only after skb
 realloc
Date: Tue, 30 Jun 2026 15:44:28 +0200
Message-ID: <20260630134430.85786-5-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260630134430.85786-1-sw@simonwunderlich.de>
References: <20260630134430.85786-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: YVFNTG45DR2DNGAHAJVXNOHLC432UHJV
X-Message-ID-Hash: YVFNTG45DR2DNGAHAJVXNOHLC432UHJV
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/YVFNTG45DR2DNGAHAJVXNOHLC432UHJV/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Sven Eckelmann <sven@narfation.org>

The pskb_may_pull() called by batadv_get_vid() could reallocate the buffer
behind the skb. Variables which were pointing to the old buffer need to be
reassigned to avoid an use-after-free.

Cc: stable@vger.kernel.org
Fixes: b61ec31c8575 ("batman-adv: Snoop DHCPACKs for DAT")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/distributed-arp-table.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/batman-adv/distributed-arp-table.c b/net/batman-adv/distributed-arp-table.c
index ae39ceaa2e29a..ead02c9e08484 100644
--- a/net/batman-adv/distributed-arp-table.c
+++ b/net/batman-adv/distributed-arp-table.c
@@ -1747,6 +1747,7 @@ void batadv_dat_snoop_incoming_dhcp_ack(struct batadv_priv *bat_priv,
 	struct ethhdr *ethhdr;
 	__be32 ip_src, yiaddr;
 	unsigned short vid;
+	int hdr_size_tmp;
 	__be16 proto;
 	u8 *hw_src;
 
@@ -1763,8 +1764,10 @@ void batadv_dat_snoop_incoming_dhcp_ack(struct batadv_priv *bat_priv,
 	if (!batadv_dat_check_dhcp_ack(skb, proto, &ip_src, chaddr, &yiaddr))
 		return;
 
+	hdr_size_tmp = hdr_size;
+	vid = batadv_dat_get_vid(skb, &hdr_size_tmp);
+	ethhdr = (struct ethhdr *)(skb->data + hdr_size);
 	hw_src = ethhdr->h_source;
-	vid = batadv_dat_get_vid(skb, &hdr_size);
 
 	batadv_dat_entry_add(bat_priv, yiaddr, chaddr, vid);
 	batadv_dat_entry_add(bat_priv, ip_src, hw_src, vid);
-- 
2.47.3

