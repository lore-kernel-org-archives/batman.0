Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74FCCCD8CB2
	for <batman-adv@archiver.kernel.org>; Wed, 10 Jun 2026 12:56:28 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id ABDA783CE2
	for <batman-adv@archiver.kernel.org>; Wed, 10 Jun 2026 14:56:26 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1781096186;
 b=So/S14XvT5Oti45LOPUCYb5yEfFcfrHCTZKSqQ/DsYScDkCE/mxuw/Ioq2gqad32TIDtL
 M/AE9O8d7MV2Gql+bvPb0EkaoooHDm3+5EZ+BBC2BbqSD+wLueHDTzCa7nkbGB2Juj0d9Ln
 BLkGICaRD/zmM89zRudwFj631ObwJnU=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1781096186; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=3vTWZBAbpJObCyXGuWnVkQFNxPQlzKgm8QmerCPJ0RY=;
 b=O7qGPB0ZYejOVPXZVYWY2H56drs1Ahw2NpslKdsTENNntmgSKI2V5uZLPv6T7W9Ho+CvF
 9uh9wRO/Gdwf12v5M7rZ0A4TJGb0qtaoHypqGxWZRUnxY7ccXxTTWhUZm9wLtu2uIJZrUmQ
 /vsMUd8nBWNm4aG096vyP85X+eDgIVU=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id B836080C51
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 10 Jun 2026 14:56:10 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1781096175;
	b=OBlg88CnpMkFkhNQZuR3sEO2/JTDZsbRke9HfI8K/lg085nbxSjF33HYClpMA2b9qevWuy
	rTS6mqtPLxy3UEzSKmWrUYTxY2MmQHjoPqIRkBeuyjLOW8eOt7wBOjdHmrXtKIbw11uuhW
	MHzTaf++mUh+JVSNfv8KlS7ckLiav04=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1781096175;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=3vTWZBAbpJObCyXGuWnVkQFNxPQlzKgm8QmerCPJ0RY=;
	b=zMBoEH6jlGhBrX74rMoR8/mRMW6SJgXdtDzA09GQWOw3pqRVKX+4lBe5dFkSY7GfaiLP6C
	JjWYT0x080TKsw5nxw9BaAp7JCQ+cQpx4g65KRtJiXgn7fMhXkwHbXFMiL7ZkK5kPgHOZ6
	NrbT0L9Rvjw0wy/dhV79lWOmJDiE0ms=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=ipG0zmKm;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org
Received: by dvalin.narfation.org (Postfix) id DAF6120110;
	Wed, 10 Jun 2026 12:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1781096169;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3vTWZBAbpJObCyXGuWnVkQFNxPQlzKgm8QmerCPJ0RY=;
	b=ipG0zmKmMUrEGuQYBi5cGBTjapE9lLMbVlUVSHzYEhvGCYfbNiOnSyj3MqXrIJpMILWgW7
	NX4yPrjzMNqIVscdrOEaRdgLizmpAWycSFth1w3IiumWZqnCbj6h1oJdYR1g2r+xi/WCw1
	cP8wHqm6aZGrme9R6eaP/xvLkeff4LI=
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 10 Jun 2026 14:56:03 +0200
Subject: [PATCH batadv 1/2] batman-adv: ensure bcast is writable before
 modifying TTL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260610-ip_checksum-v1-1-0fd7f471dca3@narfation.org>
References: <20260610-ip_checksum-v1-0-0fd7f471dca3@narfation.org>
In-Reply-To: <20260610-ip_checksum-v1-0-0fd7f471dca3@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1342; i=sven@narfation.org;
 h=from:subject:message-id; bh=+nmN1JVKSpZzw36a0gKQ8nA3bEdw33DwzeN29J/7YXQ=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFmacY8j9WzdVvA+enEr2Xz20q8M0jJ5tqVJ/rdf36jIF
 Q9mPWvdUcrCIMbFICumyLLnSv75zexv5T9P+3gUZg4rE8gQBi5OAZjI/c2MDMfLD7qkqc5/U67e
 8TX3wWSmr0rJczJjuHmN1zhvruT53MXwP/N6b9N9tvksrad2ZZ70U91wZZVztGl+9z/JmF1aa1o
 lWQA=
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: KNDHFHTJX65SMJRYFQMEYQUDGTGJ6OSW
X-Message-ID-Hash: KNDHFHTJX65SMJRYFQMEYQUDGTGJ6OSW
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/KNDHFHTJX65SMJRYFQMEYQUDGTGJ6OSW/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Before batman-adv is allowed to write to an skb, it either has to have its
own copy of the skb or used skb_cow() to ensure that the data part is not
shared.

The old implementation used a shared queue and created copies before
attempting to write to it. But with the new implementation, the broadcast
packet is already modified when it gets received. Potentially writing to
shared buffers in this process.

Adding a skb_cow() right before this operation avoids this and can at the
same time prepare it for the modifications required to rebroadcast the
packet.

Fixes: 5e399a8a6b09 ("batman-adv: bcast: queue per interface, if needed")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/routing.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/batman-adv/routing.c b/net/batman-adv/routing.c
index cd4368b8..7b4acd1a 100644
--- a/net/batman-adv/routing.c
+++ b/net/batman-adv/routing.c
@@ -1191,6 +1191,12 @@ int batadv_recv_bcast_packet(struct sk_buff *skb,
 	if (batadv_is_my_mac(bat_priv, bcast_packet->orig))
 		goto free_skb;
 
+	/* create a copy of the skb, if needed, to modify it. */
+	if (skb_cow(skb, ETH_HLEN) < 0)
+		goto free_skb;
+
+	bcast_packet = (struct batadv_bcast_packet *)skb->data;
+
 	if (bcast_packet->ttl-- < 2)
 		goto free_skb;
 

-- 
2.47.3

