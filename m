Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99DFA606A31A
	for <batman@archiver.kernel.org>; Fri, 30 Oct 2026 13:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.a=rsa-sha256 header.s=09092022 header.b=TS7fKDiH
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 343A0844B4
	for <batman@archiver.kernel.org>; Fri, 30 Oct 2026 14:53:07 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1793368387;
 b=gPnCxMtriIWrnBW+IaCuuHhJeYi7Gysf3HvpFtCCmydwwcaQ1a7RHZJBq3VhnSjL/4ecx
 zqDsFp051X2EwTcDm608CarWdBslcZsBfNXZGu2N1uwlxb0kLtY+jTK5znz1zTdMnP0Eu3W
 zPidUcewL3/BY7NUlDabTh64GqGuegQ=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1793368387; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=X26JA/MFDFcPSUPChPCfILHIVeZni1u9oAU8sdS5v+w=;
 b=UcLm47z1Dja/O0WiyWSTTXUmODTq0raU+O/C0BBE+adcqRxV1K3S+gv0s16OO+OUQyyy9
 6PgCeUxQOkzysvCh0ziQiQTyNpu6/4SN6noAXH9Y5gct81AJ7gBtGOScDVzwd92S2bF8QOc
 WYYT/mBNOx08HVwvJKQuHDoKuB2HMzM=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de
 [IPv6:2a01:4f8:c17:e8c0::1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 3769483130
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 30 Oct 2026 14:51:11 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1793368281;
	b=UwyuiAeSRvbUA+3iBeDWzoZK/f2qpN55Asqcxo//E1NOucCRPIFYM/MHEj0DVZfH8y4sxg
	yzd2c2KAPOfM4E671gDTuy5ssKoleMRo8vnKAVi3x2iMl/xYCxkImxb2CcSA7I1FD3SZch
	SCguvtTqcUoWV4hKgATPLdBhwJV/gg4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1793368281;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=X26JA/MFDFcPSUPChPCfILHIVeZni1u9oAU8sdS5v+w=;
	b=l55RGthG30RkPz5Jkhd2DTEQ73BVPBs/NW6n02Db6L72II+0sfrdMbt5YbnRvzLSgFgv0l
	ONCpM7JTEa5ZyRB2fJWyVXMVhkcWeH3TBid+bCVTv1688mnDGaHvQyEkI0BHK8Fc0yz3ZG
	UK9p+LEH9vZs/+JGIru7D3RpCWn7MfI=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=TS7fKDiH;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 2a01:4f8:c17:e8c0::1 as permitted sender)
 smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
Received: from kero.packetmixer.de
 (p200300C597124Fd839580C360D3eD6F6.dip0.t-ipconnect.de
 [IPv6:2003:c5:9712:4fd8:3958:c36:d3e:d6f6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with UTF8SMTPSA id 2D12FFA093;
	Fri, 30 Oct 2026 14:51:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1793368270;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X26JA/MFDFcPSUPChPCfILHIVeZni1u9oAU8sdS5v+w=;
	b=TS7fKDiHF1ScreJ3I+cqnzV0iAfeyl0+hAM+AdpeX3RqwJnifQSXx0Z602jp7wmZHCxtL4
	NUhIS7aVA+RHyNBm3WF6Eb3PmpYPWVe59R2M8q0QIJbbDFzDpgB+oxzn/NdQGEcjXWTuog
	PLfM9x6qtcPGxR2PEDR/pSJDCRRy0A+Ba2yw6h4HB5sTtsH58y4/aiXFJkyKtFWJ2kj2zf
	MppZJzS3sZEXlTaz7/fSEgz16PseGshCm1+ThRKC/doCTueH+YruSPNSKdwzzjTpINUaIW
	OBu6c0Hj0XYGy2n3r+tSaTRJjKjCOEhRJM9K5gRflxCmTSwyzw6l+bz4fjGC1Q==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Kyle Zeng <kylebot@openai.com>,
	stable@vger.kernel.org,
	Sven Eckelmann <sven@narfation.org>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net 03/14] batman-adv: mcast: validate tracker padding before
 forwarding
Date: Fri, 30 Oct 2026 14:50:54 +0100
Message-ID: <20261030135105.2555887-4-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261030135105.2555887-1-sw@simonwunderlich.de>
References: <20261030135105.2555887-1-sw@simonwunderlich.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: FXT7TFVZIHETJG362NDZE4JHOJZAIAL5
X-Message-ID-Hash: FXT7TFVZIHETJG362NDZE4JHOJZAIAL5
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/FXT7TFVZIHETJG362NDZE4JHOJZAIAL5/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_NONE,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Kyle Zeng <kylebot@openai.com>

A multicast tracker with an even number of destinations needs two
padding bytes after its destination list. batadv_mcast_forw_packet()
currently only checks that the count field and the addresses fit in
the tracker TVLV.

If an unpadded even tracker is compacted to an odd number of
destinations, batadv_mcast_forw_shrink_update_headers() includes those
missing padding bytes in the amount to remove. The subsequent memmove
can then write two bytes past the old packet tail. With no tailroom,
this corrupts skb_shared_info.

Include the required padding in the existing tracker length check.
This rejects the malformed tracker before either received or locally
generated packets can reach the compactor.

Fixes: 2dfe644a1ce0 ("batman-adv: mcast: shrink tracker packet after scrubbing")
Cc: stable@vger.kernel.org
Signed-off-by: Kyle Zeng <kylebot@openai.com>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/multicast_forw.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/batman-adv/multicast_forw.c b/net/batman-adv/multicast_forw.c
index ac97cd8b81dc9..9ffed1f237b6b 100644
--- a/net/batman-adv/multicast_forw.c
+++ b/net/batman-adv/multicast_forw.c
@@ -950,8 +950,11 @@ static int batadv_mcast_forw_packet(struct batadv_priv *bat_priv,
 
 	dest = (u8 *)mcast_tracker + sizeof(*mcast_tracker);
 
-	/* check if full tracker tvlv is within skb length */
+	/* check if full tracker tvlv, including padding, is within skb length */
 	tvlv_len = sizeof(*mcast_tracker) + ETH_ALEN * num_dests;
+	if (!(num_dests % 2))
+		tvlv_len += 2;
+
 	if (tvlv_len > skb_network_header_len(skb))
 		return -EINVAL;
 
-- 
2.47.3

