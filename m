Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF487CA0FFF
	for <batman-adv@archiver.kernel.org>; Mon,  1 Sep 2025 16:17:12 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 41E7584286
	for <batman-adv@archiver.kernel.org>; Mon, 01 Sep 2025 18:17:11 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1756743431;
 b=sEFG745OgU162WRTUUQoozibHKKPqB0DujhQABAZ6Oz5fPzLsFGLprtyHnt3aeaKf8/Gg
 X5wHPzjtNKrpTgGzWGVKdfxdt0u1aGdfWjgWndhAd1fL6WU37QmiXTssgRQ0XzeNmwRDxDq
 jRi6NtR1gLgiIW2+W+Gl0qq1bw6xudc=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1756743431; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=cED103PYAELfDk+plBrYQI2IXTpCscVry615cIeCq7M=;
 b=WoFvO+oklIP/Ld5j6oEk+RUtDVIUYf6VzyIhoygqrk518sfeotSpPxiHmFgj/UheOErnq
 YQtNN0xVfmR0z93S60m6vlr3yjcvPjfIPvUNC13prhn8C9z2pNM/4Kbb7VtFG5/YfYrbcm6
 wC9pbHYKNm7yWiYAApa5tMbD0fYdpdA=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=fail;
 arc=pass;
 dmarc=fail header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass;
 dmarc=fail (Used From Domain Record) header.from=simonwunderlich.de
 policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de
 [IPv6:2a01:4f8:c17:e8c0::1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 524F583CE0
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 01 Sep 2025 18:15:54 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1756743364;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cED103PYAELfDk+plBrYQI2IXTpCscVry615cIeCq7M=;
	b=DFsxaQ/To7on/C4/8PhfrIwksfWSlrRiZYobCtvP/mctRYj+T6iu38zm6wRslytebm6bnm
	QdKuPb9G3E268qwLRha215XYjJSQHmfsO7i9uIUUzXTh5FZaQTSC99g0ZqhON1/50SxHC/
	br75jbrKVSKE6bRaMMljfWwvv4R5JNE=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	dmarc=pass (policy=none) header.from=simonwunderlich.de;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 2a01:4f8:c17:e8c0::1 as permitted sender) smtp.mailfrom=sw@simonwunderlich.de
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1756743364; a=rsa-sha256;
	cv=none;
	b=J+WZ/o7Nwsz+SS7HNPYX5gPZiNz9GylpiCbVNebeB1hvMdeXIJHDJHDP5KpypQ5oN5BaFw
	huefiNHTPta6AtWFtp6XH0v7KRB01BGIUBEsz13/f+1uo0BmXrr0FDUZhvhvaItQur/WJM
	lfSebn/6VnWa0OEQ4SoZWTefS2FnAYA=
Received: from kero.packetmixer.de
 (p200300c59705aDD84F8b09d1D73c2e85.dip0.t-ipconnect.de
 [IPv6:2003:c5:9705:add8:4f8b:9d1:d73c:2e85])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id 51DDEFA130;
	Mon,  1 Sep 2025 18:15:53 +0200 (CEST)
From: Simon Wunderlich <sw@simonwunderlich.de>
To: davem@davemloft.net,
	kuba@kernel.org
Subject: [PATCH net 1/1] batman-adv: fix OOB read/write in network-coding
 decode
Date: Mon,  1 Sep 2025 18:15:46 +0200
Message-ID: <20250901161546.1463690-2-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250901161546.1463690-1-sw@simonwunderlich.de>
References: <20250901161546.1463690-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: NKW7XOUSQTPXUN6AQGTKK5EOWCCXNRYD
X-Message-ID-Hash: NKW7XOUSQTPXUN6AQGTKK5EOWCCXNRYD
X-MailFrom: sw@simonwunderlich.de
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
CC: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org,
 Stanislav Fort <stanislav.fort@aisle.com>, stable@vger.kernel.org,
 Stanislav Fort <disclosure@aisle.com>
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/NKW7XOUSQTPXUN6AQGTKK5EOWCCXNRYD/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Stanislav Fort <stanislav.fort@aisle.com>

batadv_nc_skb_decode_packet() trusts coded_len and checks only against
skb->len. XOR starts at sizeof(struct batadv_unicast_packet), reducing
payload headroom, and the source skb length is not verified, allowing an
out-of-bounds read and a small out-of-bounds write.

Validate that coded_len fits within the payload area of both destination
and source sk_buffs before XORing.

Fixes: 2df5278b0267 ("batman-adv: network coding - receive coded packets and decode them")
Cc: stable@vger.kernel.org
Reported-by: Stanislav Fort <disclosure@aisle.com>
Signed-off-by: Stanislav Fort <stanislav.fort@aisle.com>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/network-coding.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/batman-adv/network-coding.c b/net/batman-adv/network-coding.c
index 9f56308779cc3..af97d077369f9 100644
--- a/net/batman-adv/network-coding.c
+++ b/net/batman-adv/network-coding.c
@@ -1687,7 +1687,12 @@ batadv_nc_skb_decode_packet(struct batadv_priv *bat_priv, struct sk_buff *skb,
 
 	coding_len = ntohs(coded_packet_tmp.coded_len);
 
-	if (coding_len > skb->len)
+	/* ensure dst buffer is large enough (payload only) */
+	if (coding_len + h_size > skb->len)
+		return NULL;
+
+	/* ensure src buffer is large enough (payload only) */
+	if (coding_len + h_size > nc_packet->skb->len)
 		return NULL;
 
 	/* Here the magic is reversed:
-- 
2.47.2

