Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DBD7CD98F6
	for <batman@archiver.kernel.org>; Fri, 19 Jun 2026 07:07:07 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id B080F85397
	for <batman@archiver.kernel.org>; Fri, 19 Jun 2026 09:07:05 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1781852825;
 b=a5aJrWj5ldIcXN3tLh/Do4YNLuUExDQUYgY6HRDrPI0FtR9VQAf3TSiS9Qoo0Q/kthvXl
 lE5KNR7/7rEUrVZt6jjSoTWc96NDVwMUN3j+tkBFdHpL8042at/gPYQ0sk089P21GO8/u+L
 3VVn5I1XLQBVsq3Sk0cmDxyj85EzIhE=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1781852825; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=dTo7HP3hlGc7rZ83ftkOmb/zYr3PlmAHJyPALL5z5tY=;
 b=KZdp28gGa+Qz9k9lJggZ/8Ei6sMSZT7hOLhaNANLSLBA4sB/7tyD6y8p7olQ+RLoFkmUo
 h9n9KxDZDzXURf+VmCflH0G9Kqvlr0lb2bOTJe9Vn0UeDAhfNbynwxtZ+NGrJsgikdZpiX1
 ja3Es7lfwKbqKur+NsO+Ee27WCZ0PjA=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 571F083258
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 19 Jun 2026 09:00:49 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1781852454;
	b=fAOUR0KwJzuGNwAuEgnwOeM8yq/ZqV9VhgH9DeF85J9lTOQVvY9U/eBPjIPEFr/jfcq+h/
	0FskJzMHyNA2MfA7W8AP0W9zNTmCpUe2zyJ5mQqO61RWv4Oj93pBPi08daWiglYuOZSIj1
	pQ9RqkWEIe+209FAwujEDY2mL5Qiozs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1781852454;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=dTo7HP3hlGc7rZ83ftkOmb/zYr3PlmAHJyPALL5z5tY=;
	b=KKYmwuTKUDwB0D6GCcX3JYefsi1WaU092TxHdMtna3yOESNStJWZlGDhiAXsVJhzUzMn9j
	qzsd5J+pZF8qSsAawQSbF016449OLUvR4YRJdWw5X/8U6ZaqcZfxH8vcIhDZWi0ucJ2mef
	aHxuRvirzSmBKCpHvAnGKKL4uriPds8=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=FIOOpDlp;
	dmarc=pass (policy=none) header.from=simonwunderlich.de;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 23.88.38.48 as permitted sender) smtp.mailfrom=sw@simonwunderlich.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1781852448;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dTo7HP3hlGc7rZ83ftkOmb/zYr3PlmAHJyPALL5z5tY=;
	b=FIOOpDlpkqTk6XP9L4L0d+M7DDT5UljVxuHwOZ10ok9fHkjWWDgh5N+zMHOi+PixRfmZxy
	X67YceFqMZawsFr5k+9vixqOW/8Ak8Otq0piMS2+JL3zaawW3az8NR3Z71RRB4m9PoerPH
	IX5GF2RyS5KW63Kp9mI6SfKBhmU8mNilIZjWeCpBb9Dd2Vk3RIMAcluPdHfkc4Jl52kCpn
	/63f42HXR8d6iZBFpsy6E8ISUwVk+2ddlnirl18j3EsTvn3yzH1FfHt0koeEryhUGGSnGO
	OIuQOCVMRQ9hgAGgFVHLliA/a0R2aCVb5pK9X/PpChM+sMSoKgJQKQWRd7ZfMA==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Sven Eckelmann <sven@narfation.org>,
	stable@kernel.org,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net 02/15] batman-adv: ensure bcast is writable before
 modifying TTL
Date: Fri, 19 Jun 2026 09:00:32 +0200
Message-ID: <20260619070045.438101-3-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260619070045.438101-1-sw@simonwunderlich.de>
References: <20260619070045.438101-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: ASCN7W4LPK44AFFTPRQJ73UVPWXLMP5J
X-Message-ID-Hash: ASCN7W4LPK44AFFTPRQJ73UVPWXLMP5J
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/ASCN7W4LPK44AFFTPRQJ73UVPWXLMP5J/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Sven Eckelmann <sven@narfation.org>

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

Cc: stable@kernel.org
Fixes: 3f69339068f9 ("batman-adv: bcast: queue per interface, if needed")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/routing.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/batman-adv/routing.c b/net/batman-adv/routing.c
index cd4368b846add..7b4acd1ad991a 100644
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

