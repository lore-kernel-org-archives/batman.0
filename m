Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B088CD8CA8
	for <batman-adv@archiver.kernel.org>; Fri, 12 Jun 2026 13:06:52 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 3ED5984432
	for <batman-adv@archiver.kernel.org>; Fri, 12 Jun 2026 15:06:51 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1781269611;
 b=lznK3fB9UJxyOw7WVR0PF9y20lsd3QJkfhXmt44aW+OzIIlAQyMA33X4YthvXpeZKJdWT
 4l7CfiFRDces4FK5Ig5XdBfg7NnO5oIkq5itxh2ZH4XAl8BXLG3pkW1Fywcc5BPdorYu5+E
 5yBvd0eZ/JqwVRQfX41ImQrgSlAg1mY=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1781269611; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=jEnOaz1AHfbcMz8D2JoaprZB5nwTIPFuu4Qoxx00SSc=;
 b=w8oH80ZozhFaxmaj/ZKoLveX2ClRsLeurW/HLzjoITUvXnS/AS9XrYU6rMDJIM1KbiPxf
 nwGxE02Kx4SfQjcS7Bta9ly/ictHG8gJtwx80YndBaFCUobwK8hHDsjklFJB2rMWlPKwYfi
 EdLkJQ9q8gs4egN3/PwhZ2n1u5p9/uY=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 67A5184228
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 12 Jun 2026 15:04:33 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1781269473;
	b=mGBouV01U7LCqcnQDiKhQV9zZfq8CVGCAmxMf2sGHxh+44Oae97rQrvMqfrQ5gtiNCCd2k
	zz75hyF7oTNjkYNmffq8FhsVY3ln8KwNANFy/QI6mvXLN8pIBjVPAkpExC3gw6DYeTa8LR
	EJ2ER4i60/ifVXyAkqOtTq7uiU/QagM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1781269473;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=jEnOaz1AHfbcMz8D2JoaprZB5nwTIPFuu4Qoxx00SSc=;
	b=mmeJK4Z1Jsg5JkE8ej0KNnGLS92+nP3I+Bag9WRtk7O5fXYhattqzi/q3TbG931lJC/OT2
	Hi0Ay9577nlw/vcCKEwL6JQLETILZDviuej9XlozAMwaA3LO+Hmcy4dB5FFtlFclbrncNm
	QZ28JI8zNsPjEIVtyz9RAoZLXOUfrZ0=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=fzun5LKa;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org
Received: by dvalin.narfation.org (Postfix) id 0ED9D200FB;
	Fri, 12 Jun 2026 13:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1781269473;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jEnOaz1AHfbcMz8D2JoaprZB5nwTIPFuu4Qoxx00SSc=;
	b=fzun5LKaRtrlKl5T5jFq0CTfgMQ/T9Y/s4vrB7h3Y6rsQuC1Epi036pEWvjNp/HDqBS92A
	dOf0xJDtgcQ4d3V2UCW+dRIUOIhO4vrZEdOmlKMWukAzAQ1joZEA8rgU9KyhqeC8In5Db3
	emBGteLbkX4BQIxTfo/0kM3BYXPx0zw=
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 12 Jun 2026 15:04:25 +0200
Subject: [PATCH batadv 3/3] batman-adv: correct batadv_recv_frag_packet()
 return kernel-doc
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260612-frag-ttl-v1-3-6b2f4dd9d5b6@narfation.org>
References: <20260612-frag-ttl-v1-0-6b2f4dd9d5b6@narfation.org>
In-Reply-To: <20260612-frag-ttl-v1-0-6b2f4dd9d5b6@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=977; i=sven@narfation.org;
 h=from:subject:message-id; bh=zOx+lP3PdTs3T7WQxsJz4GpkG/y4VGVIt6BmCkwA5tk=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFk6zDdDNW49/mhYeOroizOXPQ+G92+aEdJ/dJLTgq1rr
 v9dd2GKcEcpC4MYF4OsmCLLniv55zezv5X/PO3jUZg5rEwgQxi4OAVgIoZRjAzXu1fffK4nz2fD
 qrmk+7TClFNSa/ZydVwIuvZMJFPwg2YMw1/hqdL/ttuFuP+78LX34L03D/UWXjbfz9QUF1i4c4r
 weVFuAA==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: SCFMUCGNZFNR7GGX3OXMUXIHERAEPBPK
X-Message-ID-Hash: SCFMUCGNZFNR7GGX3OXMUXIHERAEPBPK
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/SCFMUCGNZFNR7GGX3OXMUXIHERAEPBPK/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

The function batadv_recv_frag_packet() is always consuming the skb. The
NET_RX_DROP is only indicating whether there was direct visible problem
while processing it.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/routing.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/routing.c b/net/batman-adv/routing.c
index 46ba1c47..b105f7b1 100644
--- a/net/batman-adv/routing.c
+++ b/net/batman-adv/routing.c
@@ -1091,7 +1091,7 @@ int batadv_recv_unicast_tvlv(struct sk_buff *skb,
  * the assembled packet will exceed our MTU; 2) Buffer fragment, if we still
  * lack further fragments; 3) Merge fragments, if we have all needed parts.
  *
- * Return: NET_RX_DROP if the skb is not consumed, NET_RX_SUCCESS otherwise.
+ * Return: NET_RX_SUCCESS on success or NET_RX_DROP in case of failure
  */
 int batadv_recv_frag_packet(struct sk_buff *skb,
 			    struct batadv_hard_iface *recv_if)

-- 
2.47.3

