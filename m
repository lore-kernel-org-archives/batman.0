Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03913C43458
	for <batman-adv@archiver.kernel.org>; Wed,  8 Jul 2026 09:19:57 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 8ADFD846A1
	for <batman-adv@archiver.kernel.org>; Wed, 08 Jul 2026 11:19:55 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1783502395;
 b=aIWl6f766SKrO9vuG5ABRcjWWAC6qU2rKVgnTvNbl+O460Ck+1rUxrAXn0ThivM0vsFYy
 kGSeZCOTwRO3CdiQylquldJqoPsx2WERBBBsqhwru50K22AQJtJ+SzeS7Pc2CJ5bwvJCOpP
 zkEtzMbN2uO28+lpRDao3GOfdFuoYWM=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1783502395; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=GKgYyF6RXM0vULAsGu0pR6G/eWYQjyyVfdhlWFhcPgw=;
 b=ENnfOiUiN9tWKtvd6UFibnw7xksx3bZMVrVVBG9X5NW0WQJIKfJpcASv6+0p+J091gocB
 wgtFIeU0uRDiho7i/D/lsU06GISHhPTXwovSxYuutTbOLk5DJz27aT2QFZXqfcaCqrQH3Ef
 HjsvyaIiLYk+zu07gbKiqTd9768LS1I=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 7422C83174
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 08 Jul 2026 11:18:44 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1783502324;
	b=RlCKiButc6moPQ8Z5XFPKgN57Fc+cIVjJsx+cIAb1CpTQ4PM61QKPYJ23b0cJWa433SULL
	S44/gk8RFjqDfqyb2IP2M82E3F1/0slMoLNnfZHkOVWqeCS2aTARa9go/POaVrUJb635bV
	vcku3gNk54Wf6QHpAS7JrDdnirRVz6k=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1783502324;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=GKgYyF6RXM0vULAsGu0pR6G/eWYQjyyVfdhlWFhcPgw=;
	b=VGX2pJC/g+oM0zbHcDkc3Ul9eStuzbzwFn9d+f2IVgWfGxg3yhjscTaTevhfq8KezwAfke
	mavkQach7t3+uXAIsxhY3lcmSRRJNFpGC5XiMGPYgoTarl6quMWWvj51t0NgyAZqTSNne4
	9N2einSnSi7ik37h18eCa9sbzptB7Rw=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=HUkddEM8;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 23.88.38.48 as permitted sender) smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1783502322;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GKgYyF6RXM0vULAsGu0pR6G/eWYQjyyVfdhlWFhcPgw=;
	b=HUkddEM8pEutJmcLkpywE8+mpQeIi/PvNIrVE8Upos6kAjOAWvwWfatriY4PCC8kdqNOak
	V56lj8QMFitkVs/13GOAPIdB6wUcNidS9EZAmH1LR8XLuIEKukrqShJEM37iCqihTCcrOB
	PgrtdFlGRVAeu8qrefZv+FOorz7FiGM3sFtfki5fOoTHOunJRVDxV0ZInahNR5xyJHXCT9
	pBXyk4KgZ0gRDf8vXymiZ5L3CFn9E3wvwyx3RsbMoGseGq5RJhk9JJwN7cwQjFxcNoPp88
	IoTAsX4AIDx9WIaPY7PvG39LUiGssE2ihF3MXQVWLv/f/352pe6xL784l/lurQ==
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
Subject: [PATCH net 6/9] batman-adv: frag: free unfragmentable packet
Date: Wed,  8 Jul 2026 11:18:18 +0200
Message-ID: <20260708091821.314516-7-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260708091821.314516-1-sw@simonwunderlich.de>
References: <20260708091821.314516-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: QQ2TSLNAZ5VI3G6PVEVPIW7MCUBPDUHK
X-Message-ID-Hash: QQ2TSLNAZ5VI3G6PVEVPIW7MCUBPDUHK
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/QQ2TSLNAZ5VI3G6PVEVPIW7MCUBPDUHK/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Sven Eckelmann <sven@narfation.org>

The caller of batadv_frag_send_packet() assume that the skb provided to the
function are always consumed. But the pre-check for an empty payload or the
zero fragment size returned an error without any further actions.

A failed pre-check must use the same error handling code as the rest of the
function.

Cc: stable@vger.kernel.org
Fixes: ee75ed88879a ("batman-adv: Fragment and send skbs larger than mtu")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/fragmentation.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/fragmentation.c b/net/batman-adv/fragmentation.c
index 8a006a0473a87..13d4689d332dc 100644
--- a/net/batman-adv/fragmentation.c
+++ b/net/batman-adv/fragmentation.c
@@ -518,8 +518,10 @@ int batadv_frag_send_packet(struct sk_buff *skb,
 	mtu = min_t(unsigned int, mtu, BATADV_FRAG_MAX_FRAG_SIZE);
 	max_fragment_size = mtu - header_size;
 
-	if (skb->len == 0 || max_fragment_size == 0)
-		return -EINVAL;
+	if (skb->len == 0 || max_fragment_size == 0) {
+		ret = -EINVAL;
+		goto free_skb;
+	}
 
 	num_fragments = (skb->len - 1) / max_fragment_size + 1;
 	max_fragment_size = (skb->len - 1) / num_fragments + 1;
-- 
2.47.3

