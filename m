Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 096D9C53219
	for <batman@archiver.kernel.org>; Tue, 28 Jul 2026 13:43:56 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 9848D84B86
	for <batman@archiver.kernel.org>; Tue, 28 Jul 2026 15:43:54 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1785246234;
 b=ldufuvGsbIQA0PaJpeoFSlUkLgOD/KfTAJFqmMmEA3UWmEydIXD31cNfXJ/E/bhco/K5l
 r2dQoXL2IEIWf/etk9a+FwQzp7JgKngCkQSqJ3RQ1RAtNYMQ+6SrAQWZJddLYzJzszsq/pK
 ff2zSoerKUVtMJ+VDxBmAf/phA98Zqk=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1785246234; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=qlGWbLUy89WAmmXZ/1xLRELWDvmfS/fkFJGA8kissPU=;
 b=I0FrDx8hRzWHTDZgDnGU3mpYCDoVngmdVvBJhJw7MufoiWas7VNv32o01bNaDgQOn1EqR
 HdsQy6H/pwJhAvzWNmLaDzGxkMFG/MqHbU4RIogLD9KjUMxMOGoCv40QOi/eC7JbJJyihUI
 +8Wm+rEgOnpODECScyx7XA1PVS+HJCc=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de
 [IPv6:2a01:4f8:c17:e8c0::1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 697A88462D
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 28 Jul 2026 15:39:24 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1785245964;
	b=C/7ENXQWvG4spOKRQHIVPnUavnMp3lVHD1uers2TnF0g+uhDWFCvBNqeUPTkDbtz3bgOWQ
	iOwsX3TfUIteHm9cYMIychdjypoEnGw5C4DOLtd4Pf+rTzdJ10+Cu4WkCIXXtYzDzw5jG1
	jH8ohhfiuN4wtEDSkK4dIRyjy2yO5bM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1785245964;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=qlGWbLUy89WAmmXZ/1xLRELWDvmfS/fkFJGA8kissPU=;
	b=OXgAjxEO+Do4o+1iZwHFCynBjvYqY7sMweSZaL4I6E2xsjSqRhAgR+Kd/4ukuSs9IS7o3R
	vYynfudxoom+BtFtsyQFSD9zzkUckt5F24KGx4W5F34tszzvAyPGbSP2I4AGZnEmRx3uts
	8W6qbLq+rtOxbz7AsQF3W9aYtqenks8=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=qwKKXFUd;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 2a01:4f8:c17:e8c0::1 as permitted sender)
 smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
Received: from kero.packetmixer.de
 (p200300c59717Ead808F168C97E5563a8.dip0.t-ipconnect.de
 [IPv6:2003:c5:9717:ead8:8f1:68c9:7e55:63a8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id B610EFA128;
	Tue, 28 Jul 2026 15:39:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1785245963;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qlGWbLUy89WAmmXZ/1xLRELWDvmfS/fkFJGA8kissPU=;
	b=qwKKXFUdwLmUwFIM0ggYjJm/vSNwKVL/NiFGiGiKHAZxfC7qpmUUuu+7YoEwzzFWiFs6cQ
	V+T2iMaWy5kponH6T28uQnenxhQ8Yi6/TBMxqO5p8NI9HP5i0sb8WujBAXCXgDyXDy/SAI
	b1O5LzLv7blGqbygLFgPsLehbPDPi2l/o/lKAcfZP2qbA5OfTOSPLGQgWgWC/NIW+RI0l9
	VlQ2b2oqo+GUE1iDcGFznlM0xI4hRE+AYOnhCJJGAbr1tnjKsLGLKVWNL1BkFWn1ezvWNv
	8B45bnWOQZddj/v0AxER3i7eEtL0JUqAFweZprVX3jyw+G6z50p8vwhrtuM9KQ==
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
Subject: [PATCH net-next 06/15] batman-adv: mcast: ensure unshared skb for
 multicast packets
Date: Tue, 28 Jul 2026 15:39:09 +0200
Message-ID: <20260728133918.643267-7-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260728133918.643267-1-sw@simonwunderlich.de>
References: <20260728133918.643267-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: 7AA2GIA3U6DN6YKFIJ3CPKXVFLZORCAR
X-Message-ID-Hash: 7AA2GIA3U6DN6YKFIJ3CPKXVFLZORCAR
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/7AA2GIA3U6DN6YKFIJ3CPKXVFLZORCAR/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Sven Eckelmann <sven@narfation.org>

When a packet is transmitted via a batman-adv interface and has already
enough room for the header then the nothing will make sure that the skbuff
is unshared. But it is now allowed to modify a currently shared skbuff.

Always make sure that the pskb_expand_head() is not only called for a too
small header but also for shared skbuffs.

Cc: stable@vger.kernel.org
Fixes: 90039133221e ("batman-adv: mcast: implement multicast packet generation")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/multicast_forw.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/batman-adv/multicast_forw.c b/net/batman-adv/multicast_forw.c
index 1404a3b7adfb1..240ed7380cb0f 100644
--- a/net/batman-adv/multicast_forw.c
+++ b/net/batman-adv/multicast_forw.c
@@ -1100,8 +1100,7 @@ static int batadv_mcast_forw_expand_head(struct batadv_priv *bat_priv,
 		return -EINVAL;
 	}
 
-	if (skb_headroom(skb) < hdr_size &&
-	    pskb_expand_head(skb, hdr_size, 0, GFP_ATOMIC) < 0)
+	if (skb_cow(skb, hdr_size) < 0)
 		return -ENOMEM;
 
 	return 0;
-- 
2.47.3

