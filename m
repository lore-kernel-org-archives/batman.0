Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1AD2CD343F
	for <batman@archiver.kernel.org>; Fri, 15 May 2026 10:06:27 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 5F48B85F03
	for <batman@archiver.kernel.org>; Fri, 15 May 2026 12:06:26 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1778839586;
 b=m9TWUA9YJVRK1t3fZ1Nogdh6+4fQW2Mq8UlYLMM+PAX/QAheIGirt0/57QeoOhgLxGVHU
 8doodV2pQmJSHH5UUXalXnZpjjoSHsBgafzfvmYSHFlm0lN3O1a3/7d1u9SSiddLm/ZM+Mb
 SR9JmOsiVaMXvZR87gMHSruaMXhm7ds=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1778839586; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=FhfNjkuMbZpr2ack+ilUXPWHeaOvldZUmgcoY4j+Ous=;
 b=pPlhbQIODh05kFnnRY+hiVnmyQit2pa+79Uaqa/YdFfmpUEpW27XL+IVDiSbquYsADxDN
 9U7N1xMT12vBJOBQJ/Tl9bacgSz6DXl7X7sB/e/BOUnMLCP7pHNkg9AJwR8lUFdbrTfjPh6
 h+8I0qfdRGNMyCJU1wimrzOjvvSEmzY=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de
 [IPv6:2a01:4f8:c17:e8c0::1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id B772285423
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 15 May 2026 11:55:58 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1778838958;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=FhfNjkuMbZpr2ack+ilUXPWHeaOvldZUmgcoY4j+Ous=;
	b=AeHLmNFAKSnX+zX9guv+aKd83+0zQiYQ34aFYH1HeoLW8Kq2cia/d0g1ZuO64rrGtBmqeE
	EhYUc5tYE4K8YhJi4yBo4EF7cNIjiaeWNd2GGDQY9Ys8Q/ebXptnGgEyi2llWdkAyjZ5uL
	TzXkDk/swwObtp2D4c9o7/jx0sTSg/4=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=KzdBiR9d;
	dmarc=pass (policy=none) header.from=simonwunderlich.de;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 2a01:4f8:c17:e8c0::1 as permitted sender) smtp.mailfrom=sw@simonwunderlich.de
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1778838958;
	b=I3T3MqFAQp8ekMdg0t1ymE11030cSrOQRUDsgtF0b+6f/jh1JT9tWDhVZfrLeI1+o96EvP
	RvhHwunm/98hMNDuh/HU4ahMNdH1IZz+GaOOQEblx7ow87uN5ka0FrKXg5dKsq26QiZ6ei
	KdMZc5mEdGXDFpt4SmfEjhawo2acDgc=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1778838957;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FhfNjkuMbZpr2ack+ilUXPWHeaOvldZUmgcoY4j+Ous=;
	b=KzdBiR9dK3q3KNFqxvVPUJJ9mvASjFeyFmJxgXi3Pl7WwzY7hkSYJqy5DDsAJjXwig7dcE
	luK2JPVw63+x43YGA+5SziXHLvYtg69FX67mkOH+U06saSO969F3OcFHkPN8s4BalosU+W
	kQlG/yuiBxkMHU39dyax4Qkdh/OCMlJGbZW6mEOAAtZ8u0deSbx4CZGr2eADYstc9cd2C/
	rBAuEhV8MW7kx+RnOrlIpc9yOME11s6h2vqlICRDo3qkoiW7xv+aVVYY4UOvFx2DP7FH2x
	LSdSbWhbG+D0gu/e5wEOSlASAe2WdulE8ZVtgK5Fey4Zv7DvK+VTw9B87ePk+w==
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
	Yuan Tan <yuantan098@gmail.com>,
	Yifan Wu <yifanwucs@gmail.com>,
	Juefei Pu <tomapufckgml@gmail.com>,
	Xin Liu <bird@lzu.edu.cn>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net 13/14] batman-adv: frag: disallow unicast fragment in
 fragment
Date: Fri, 15 May 2026 11:55:38 +0200
Message-ID: <20260515095540.325586-14-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260515095540.325586-1-sw@simonwunderlich.de>
References: <20260515095540.325586-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: N7T4ERDFKPERBH2ZQ5UV35O4Q5H7HP3O
X-Message-ID-Hash: N7T4ERDFKPERBH2ZQ5UV35O4Q5H7HP3O
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/N7T4ERDFKPERBH2ZQ5UV35O4Q5H7HP3O/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Sven Eckelmann <sven@narfation.org>

batadv_frag_skb_buffer() is called by batadv_batman_skb_recv() when a
BATADV_UNICAST_FRAG packet is received. Once all fragments are collected
and the packet is reassembled, batadv_recv_frag_packet() calls
batadv_batman_skb_recv() again to process the defragmented payload.

A malicious sender can craft a BATADV_UNICAST_FRAG packet whose reassembled
payload is itself a BATADV_UNICAST_FRAG packet (matryoshka-style nesting).
Each nesting level recurses through batadv_batman_skb_recv() without bound,
growing the kernel stack until it is exhausted.

Since refragmentation or fragments in fragments are not actually allowed,
discard all packets which are still BATADV_UNICAST_FRAG packets after the
defragmentation process.

Cc: stable@kernel.org
Fixes: 610bfc6bc99b ("batman-adv: Receive fragmented packets and merge")
Reported-by: Yuan Tan <yuantan098@gmail.com>
Reported-by: Yifan Wu <yifanwucs@gmail.com>
Reported-by: Juefei Pu <tomapufckgml@gmail.com>
Reported-by: Xin Liu <bird@lzu.edu.cn>
Reviewed-by: Yuan Tan <yuantan098@gmail.com>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/fragmentation.c | 35 ++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/net/batman-adv/fragmentation.c b/net/batman-adv/fragmentation.c
index 1152c2ce0c1ea..4a594aa2ebf66 100644
--- a/net/batman-adv/fragmentation.c
+++ b/net/batman-adv/fragmentation.c
@@ -304,6 +304,31 @@ batadv_frag_merge_packets(struct hlist_head *chain)
 	return skb_out;
 }
 
+/**
+ * batadv_skb_is_frag() - check if newly merged skb is gain a unicast packet
+ * @skb: newly merged skb
+ *
+ * Return: if newly skb is of type BATADV_UNICAST_FRAG
+ */
+static bool batadv_skb_is_frag(struct sk_buff *skb)
+{
+	struct batadv_ogm_packet *batadv_ogm_packet;
+
+	/* packet should hold at least type and version */
+	if (unlikely(!pskb_may_pull(skb, 2)))
+		return false;
+
+	batadv_ogm_packet = (struct batadv_ogm_packet *)skb->data;
+
+	if (batadv_ogm_packet->version != BATADV_COMPAT_VERSION)
+		return false;
+
+	if (batadv_ogm_packet->packet_type != BATADV_UNICAST_FRAG)
+		return false;
+
+	return true;
+}
+
 /**
  * batadv_frag_skb_buffer() - buffer fragment for later merge
  * @skb: skb to buffer
@@ -337,6 +362,16 @@ bool batadv_frag_skb_buffer(struct sk_buff **skb,
 	if (!skb_out)
 		goto out_err;
 
+	/* fragment in fragment is not allowed. otherwise it is possible
+	 * to exhaust the stack when receiving a matryoshka-style
+	 * "fragments in a fragment packet"
+	 */
+	if (batadv_skb_is_frag(skb_out)) {
+		kfree_skb(skb_out);
+		skb_out = NULL;
+		goto out_err;
+	}
+
 out:
 	ret = true;
 out_err:
-- 
2.47.3

