Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C34CFC43458
	for <batman-adv@archiver.kernel.org>; Sun, 28 Jun 2026 07:26:10 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 1C5A183F40
	for <batman-adv@archiver.kernel.org>; Sun, 28 Jun 2026 09:26:09 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1782631569;
 b=TeYnIg7An2YA9DlTSBxTcZ3u5cbcneY/+Cxz/Rjmp89x/liuxzndVhyyMGVAgRyc5EFXB
 b/koCG4b3CvD77hXNWNuvF+VZ2wptNTkuFQgJW4Nj+15z5kdt96nrU6lFRZwDRsollWXW/X
 IKu54VmYyaBbwy9Jf0UWQq7IOSf3rMY=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1782631569; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=php7rgFytlv/vXxlh47eWADpc6av7C+06VVSmhf4opg=;
 b=nk/2yEnvPEaVa2FmeP1PcrUJQBxLjdHt00r8or/25rmDIagZMW9O/cyTBHhsrc0tciy6C
 MD9ABrQyo1il9ScKJm8RJTHiOtwDxB6eW07zRPW0rJp2Z7RA6PAo+RpwsbRJDAePePUyGKo
 EGmrjTQawyN6ofBGA30o4CrE2ElYE24=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 3208A80D7D
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 28 Jun 2026 09:25:48 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1782631548;
	b=NymtA4Dhfg7lzsYB7h66EiKh7q1jKUZd84aQrtepfb4ACXmoSBkbKbfbTApCMuTB9AZHHK
	UM9x7By/JO2N27Kc2mTD2MXWZyfSLpIbV2w3wPS6Tw3MvBce+fZblw4lLH/4rKTJwq79gw
	zMaVro1ambVNdaKKoJwUe6C5WLyJX8A=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1782631548;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=php7rgFytlv/vXxlh47eWADpc6av7C+06VVSmhf4opg=;
	b=2Jb1oYzlWdCNVg9Lgtlhye5qprEH9n68Kew87IqyEEbKt7TLJ/AWJSruC3V/tO1fTGjOxH
	KOvhImTzTF+DJALBG6GvZ/KWb4mV65hSl1kEhxFgPjgH6xgvvmCAwH7oSRxHDX88yG1fRx
	67YLSuywUVBLQTpaDq93XtZMu42Gja8=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=feNIzB+a;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id A2A0920696;
	Sun, 28 Jun 2026 07:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1782631547;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=php7rgFytlv/vXxlh47eWADpc6av7C+06VVSmhf4opg=;
	b=feNIzB+acvbHl7ljd97IRSvaqNPBg53bjtdm/SHIn2TDAim7HAn5jlDWnfBoL59NoBH2J9
	gw+G1vup47l5flwoHUjOh4+j5qLbfPSUjieuNF7jqABq9Hw9/RWzjroggllLf06ZcQodYh
	EMGsySUiW+9u0PsHqkuu60rUvgM/lzw=
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 28 Jun 2026 09:25:36 +0200
Subject: [PATCH batadv v2 3/5] batman-adv: dat: acquire ARP hw source only
 after skb realloc
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260628-skb-post-realloc-v2-3-59a58f5a471b@narfation.org>
References: <20260628-skb-post-realloc-v2-0-59a58f5a471b@narfation.org>
In-Reply-To: <20260628-skb-post-realloc-v2-0-59a58f5a471b@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1403; i=sven@narfation.org;
 h=from:subject:message-id; bh=n7phrKtmgnnGG1CDRC1JaFcx4obapHIcSuBDrr6Onk4=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFkOZwri/vHs5lu6ZoGcgoH5C+WnWz4F1jcuWD1jvp8XC
 3/u0c2aHaUsDGJcDLJiiix7ruSf38z+Vv7ztI9HYeawMoEMYeDiFICJFM9i+CsQntGVclvWU/h2
 1FyB6323+J+XV28QecN4ceGRgu/xFy4x/E+JuHv+/GsBy0oZlcDni67t2y8itTrVo+Pq25ofK1M
 P6jABAA==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: U4BEHUDTRCNOIQWQ66PCY4R6QNINGPBL
X-Message-ID-Hash: U4BEHUDTRCNOIQWQ66PCY4R6QNINGPBL
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/U4BEHUDTRCNOIQWQ66PCY4R6QNINGPBL/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

The pskb_may_pull() called by batadv_get_vid() could reallocate the buffer
behind the skb. Variables which were pointing to the old buffer need to be
reassigned to avoid an use-after-free.

Fixes: 1fd1ce2d383f ("batman-adv: Snoop DHCPACKs for DAT")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/distributed-arp-table.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/batman-adv/distributed-arp-table.c b/net/batman-adv/distributed-arp-table.c
index 56400009..7221d569 100644
--- a/net/batman-adv/distributed-arp-table.c
+++ b/net/batman-adv/distributed-arp-table.c
@@ -1824,6 +1824,7 @@ void batadv_dat_snoop_incoming_dhcp_ack(struct batadv_priv *bat_priv,
 	u8 chaddr[BATADV_DHCP_CHADDR_LEN];
 	struct ethhdr *ethhdr;
 	unsigned short vid;
+	int hdr_size_tmp;
 	__be32 ip_src;
 	__be32 yiaddr;
 	__be16 proto;
@@ -1842,8 +1843,10 @@ void batadv_dat_snoop_incoming_dhcp_ack(struct batadv_priv *bat_priv,
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

