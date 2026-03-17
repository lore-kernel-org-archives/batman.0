Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9955AFED9E4
	for <batman-adv@archiver.kernel.org>; Tue, 17 Mar 2026 16:01:29 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 3BC45859E4
	for <batman-adv@archiver.kernel.org>; Tue, 17 Mar 2026 17:01:28 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1773763288;
 b=RTOInWD5u7JbHWNMpqKdyCJ0ZVQtrvHAl41dtoUGi64WCxtlP6X8wBT2r3CkjXKiWUZtz
 0SU7aWfvdtli+KhKGmqO9Myps1+igyy6DyIp8PKmE7ZGzyLYCoYJSrsQSXv45bXtFPSqVhs
 APFDSIunB6vydoOum1CUZ3KwZeRGL6E=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1773763288; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=9xx7mjI2MofOxW6iU5Fob/w9bvKDeUmPtcm6wJ652Ow=;
 b=N2OX5SWfKGzR/FxWnSjI+TGDIEqabM47SO2WuEd0rs4mahzen8WuyhGVSNJ0nLNs0dr/g
 3AuDU/Qbrc+zy8wwC4haDW/I/rQP3bqx7mKfv9S805z+niij/RDrEdkYt4Dx91UiSIvWZyu
 2xzr4va8MAjXdYYQD22cMwvkpVbnCHY=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 18117849FB
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 17 Mar 2026 17:00:07 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1773763217;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=9xx7mjI2MofOxW6iU5Fob/w9bvKDeUmPtcm6wJ652Ow=;
	b=Myx65LSkYM8U+wzUGR4Jff1A2YDVA6cwdlUNdGTNspf0gkOzm0w+dUH+AjIwt7X8YJYB2K
	uBGsyif/M9abbmHagJzQFjIuvWUAP8dqlZamStp1AEz2r6geuKHnTQp4oHiahup6dUcbW2
	T2AfAXS3R3BqI0srU2itbLgIT+0gsKc=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=gcYa9d+H;
	dmarc=pass (policy=none) header.from=simonwunderlich.de;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 23.88.38.48 as permitted sender) smtp.mailfrom=sw@simonwunderlich.de
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1773763217;
	b=ya6POuHtE7CCXwNaUGOpO1f1Yt+WSvnF9il9XI7vGr8Aa/WX+/V4nnpo/C6i3yi8pE97lJ
	mXN5yEhBxmKhlNFzO7WRxlwgaoHtiEfe6Y2pQe8j4xKzg6OTKn0Jrvp9nPncczktzcIvLk
	syd2FPqOmnLZ1BF97XGZVmeymzPe+wo=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1773763204;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9xx7mjI2MofOxW6iU5Fob/w9bvKDeUmPtcm6wJ652Ow=;
	b=gcYa9d+HZBCXiDYZTLSwbEcTys8KHFnDaShmRPpIlHNKm+lWIyTeCxvvGE2O2Oxl5o60QB
	9BwxhlW2xJwZiAcLsdUl4tMCuxMZ3Q4LS1LOGp3W32GCi2lA1dgBe6llcRhKUs9csM8Fib
	7hVRmtNLKEruKiG2tcv2rdXH1c0KQ+1NNIZQ0ZYqMkiLHAvgr1+GBLrmBGmosy6kmmmvRe
	Fk+jr5nD8X+i1yvkq/HmmxalTD7/FWpNoBn0K1H2GkRjCYoU1TGWcwFVoNoLvS9cDJ6GHx
	wcDijEtQKYYnGbGIms9+f1ZNtnwhbzq10gahJsQmp2Humcb7sShsIaDPuf8DsA==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: netdev@vger.kernel.org,
	b.a.t.m.a.n@lists.open-mesh.org,
	Yang Yang <n05ec@lzu.edu.cn>,
	stable@vger.kernel.org,
	Yifan Wu <yifanwucs@gmail.com>,
	Juefei Pu <tomapufckgml@gmail.com>,
	Yuan Tan <tanyuan98@outlook.com>,
	Xin Liu <bird@lzu.edu.cn>,
	Sven Eckelmann <sven@narfation.org>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net 1/1] batman-adv: avoid OGM aggregation when skb tailroom
 is insufficient
Date: Tue, 17 Mar 2026 17:00:02 +0100
Message-ID: <20260317160002.1869478-2-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260317160002.1869478-1-sw@simonwunderlich.de>
References: <20260317160002.1869478-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: MEE7WPKSJMLN3J2GGCZ5LMACKSGSUBGA
X-Message-ID-Hash: MEE7WPKSJMLN3J2GGCZ5LMACKSGSUBGA
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/MEE7WPKSJMLN3J2GGCZ5LMACKSGSUBGA/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Yang Yang <n05ec@lzu.edu.cn>

When OGM aggregation state is toggled at runtime, an existing forwarded
packet may have been allocated with only packet_len bytes, while a later
packet can still be selected for aggregation. Appending in this case can
hit skb_put overflow conditions.

Reject aggregation when the target skb tailroom cannot accommodate the new
packet. The caller then falls back to creating a new forward packet
instead of appending.

Fixes: c6c8fea29769 ("net: Add batman-adv meshing protocol")
Cc: stable@vger.kernel.org
Reported-by: Yifan Wu <yifanwucs@gmail.com>
Reported-by: Juefei Pu <tomapufckgml@gmail.com>
Signed-off-by: Yuan Tan <tanyuan98@outlook.com>
Signed-off-by: Xin Liu <bird@lzu.edu.cn>
Signed-off-by: Ao Zhou <n05ec@lzu.edu.cn>
Signed-off-by: Yang Yang <n05ec@lzu.edu.cn>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/bat_iv_ogm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index b75c2228e69a6..f28e9cbf8ad5f 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -473,6 +473,9 @@ batadv_iv_ogm_can_aggregate(const struct batadv_ogm_packet *new_bat_ogm_packet,
 	if (aggregated_bytes > max_bytes)
 		return false;
 
+	if (skb_tailroom(forw_packet->skb) < packet_len)
+		return false;
+
 	if (packet_num >= BATADV_MAX_AGGREGATION_PACKETS)
 		return false;
 
-- 
2.47.3

