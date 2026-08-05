Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AC79C55174
	for <batman-adv@archiver.kernel.org>; Wed,  5 Aug 2026 14:37:57 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id A72C681180
	for <batman-adv@archiver.kernel.org>; Wed, 05 Aug 2026 16:37:55 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1785940675;
 b=wL1IBrNDi9Uz0feBgcs+SzkUVKM3q4VF/JwHU8rGHlbfNBOxeD1u59Et1IefhSedB+1SO
 g7iHNEb8JroU5B8EawjqdswTXVX3rr7R+JaQ4A43xUqczppd51CSy8BbVtkI7sYD/qrb0RC
 WemJzPIxflwtT3hHNLbKty/8OBFKYjE=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1785940675; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=dV+yoa8pcMjmnzwq4i3jrAXYGKZ71UdYTICkAASchw8=;
 b=x2SAKdAWjSr/OWWiobinjB3Z6C0Z45hMWRfkw35cX3UZmofRCASnMZAyxEue6Z5j+kyUW
 GoBujCP7S8m8UtlbjdRJ4rxLFWl+5jaKM1miduLnaugUCq0W5+twCbzrifAHwh2jsBW+XvL
 3RSHS6axHHrsMlyPiFOv6moxnjuUx90=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 8A85A81226
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 05 Aug 2026 16:32:07 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1785940332;
	b=JDIkgh93kzkI6q+yu0V/GObWy82sR6HmaJvcEG3TE1/GI7YYsf0KqdTw/9NQOi5CMn4gMn
	24TjpwHBz+9CzHhiW+mRgjD0PCAHNdxbyJOcSukX4YBakPdPd6nymosfYUK63D3LB8qfeO
	7l84dllNhfhTbTrOYTjZfQA1J6yi8R4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1785940332;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=dV+yoa8pcMjmnzwq4i3jrAXYGKZ71UdYTICkAASchw8=;
	b=sCuXH6mk5amv/2KbjD+YK95L2ZafukWyEbruSJMsAh2lWvxyW/cxorlR5ZleX5a/iT5rtO
	GfeazavAmPb+ueaFYzc8ye0gl5LInvPBdSbq4ZRS56Ub+qGZZyOhvlcizBdQhbRw3SocLX
	M1HbLP/6pryHsNPUUBKStAEUF6ZyvfQ=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b="M/uZJkkQ";
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 23.88.38.48 as permitted sender) smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
Received: from kero.packetmixer.de
 (p200300c5970B56d88eEbaC4310d100aa.dip0.t-ipconnect.de
 [IPv6:2003:c5:970b:56d8:8eeb:ac43:10d1:aa])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id 98131FA1C9;
	Wed, 05 Aug 2026 16:32:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1785940326;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dV+yoa8pcMjmnzwq4i3jrAXYGKZ71UdYTICkAASchw8=;
	b=M/uZJkkQVDKWzFhbBjH/w2s83hc2aT+JtiaSbg29hIuLFrVadUCED36jvxIG8AlsG+UQx0
	a4av2B6jCzcFXtBLhprilcl8hs5aSveKDlw8e64TZSh9vEfWMF/mPkEVn35Bj76BxfJv0R
	8gT9rpN0IkcDWPPwZ49fK011aZNypdM5j2In6VQhVtN1XuaZk+TtpCnVUGOm4aOR93Hz/R
	vWm7yEmtW0hVMW77bsyHFlNayE4qoBigmxlcI6Hku2XLuPa+yEskBcf+Z5H8atMLUCJjb0
	N0BAfydy9kv18d8QZXgO/CC+H4C6HytW1xv+0cBLM+yXGr9F6TCqlMsVA2XxRg==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Sven Eckelmann <sven@narfation.org>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net-next 02/10] batman-adv: tvlv: handle negative tvlv
 processing return codes
Date: Wed,  5 Aug 2026 16:27:16 +0200
Message-ID: <20260805143200.722098-3-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260805143200.722098-1-sw@simonwunderlich.de>
References: <20260805143200.722098-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: A5CYEX7FVMLVTJKQRU57SVCBQHQ6EQOD
X-Message-ID-Hash: A5CYEX7FVMLVTJKQRU57SVCBQHQ6EQOD
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/A5CYEX7FVMLVTJKQRU57SVCBQHQ6EQOD/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Sven Eckelmann <sven@narfation.org>

batadv_tvlv_containers_process() was implemented with only two return codes
from the handlers in mind:

* NET_RX_SUCCESS (0)
* NET_RX_DROP (1)

The multicast handlers broke this convention and are also returning
negative return codes. But the processing code was never updated to
correctly aggregate them.

To handle negative return codes for non-OGM(2) handlers, they are now
aggregated to:

* NET_RX_SUCCESS when no handlers returned a different return code
* the last negative return code when at least one handler returned a
  negative return code
* NET_RX_DROP otherwise

With the current callers, the old implementation is not triggering any
unexpected behavior. The behavior is only adjusted for new code which might
need more reliable return values.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/routing.c |  4 +++-
 net/batman-adv/tvlv.c    | 22 ++++++++++++++--------
 2 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/net/batman-adv/routing.c b/net/batman-adv/routing.c
index bbd40fe3a8e59..a9d657f2a831a 100644
--- a/net/batman-adv/routing.c
+++ b/net/batman-adv/routing.c
@@ -1334,7 +1334,9 @@ int batadv_recv_bcast_packet(struct sk_buff *skb,
  * contents of its TVLV forwards it and/or decapsulates it to hand it to the
  * mesh interface.
  *
- * Return: NET_RX_DROP if the skb is not consumed, NET_RX_SUCCESS otherwise.
+ * Return: NET_RX_SUCCESS if the skb was locally received, NET_RX_DROP otherwise
+ * or a negative errno code when the multicast tracker TVLV could not be
+ * processed
  */
 int batadv_recv_mcast_packet(struct sk_buff *skb,
 			     struct batadv_hard_iface *recv_if)
diff --git a/net/batman-adv/tvlv.c b/net/batman-adv/tvlv.c
index 49bf2ed9ecdc3..cc14a76582b5a 100644
--- a/net/batman-adv/tvlv.c
+++ b/net/batman-adv/tvlv.c
@@ -383,8 +383,9 @@ int batadv_tvlv_container_ogm_append(struct batadv_priv *bat_priv,
  * @tvlv_value: tvlv content
  * @tvlv_value_len: tvlv content length
  *
- * Return: success if the handler was not found or the return value of the
- * handler callback.
+ * Return: NET_RX_SUCCESS if the handler was not found or the return value of
+ * the handler callback. The latter is NET_RX_SUCCESS or NET_RX_DROP for the
+ * unicast handler and additionally a negative errno code for the mcast handler.
  */
 static int batadv_tvlv_call_handler(struct batadv_priv *bat_priv,
 				    struct batadv_tvlv_handler *tvlv_handler,
@@ -524,8 +525,9 @@ static bool batadv_tvlv_containers_contain(void *tvlv_value,
  * @tvlv_value: tvlv content
  * @tvlv_value_len: tvlv content length
  *
- * Return: success when processing an OGM or the return value of all called
- * handler callbacks.
+ * Return: NET_RX_SUCCESS when processing an OGM or the combined return value of
+ * all called handler callbacks. The latter is NET_RX_SUCCESS, NET_RX_DROP or,
+ * for BATADV_MCAST packets, a negative errno code.
  */
 int batadv_tvlv_containers_process(struct batadv_priv *bat_priv,
 				   u8 packet_type,
@@ -540,6 +542,7 @@ int batadv_tvlv_containers_process(struct batadv_priv *bat_priv,
 	u16 tvlv_value_cont_len;
 	u8 cifnotfound = BATADV_TVLV_HANDLER_OGM_CIFNOTFND;
 	int ret = NET_RX_SUCCESS;
+	int res;
 
 	while ((tvlv_hdr = batadv_tvlv_hdr_next(&tvlv_value, &tvlv_value_len))) {
 		tvlv_value_cont_len = ntohs(tvlv_hdr->len);
@@ -548,10 +551,13 @@ int batadv_tvlv_containers_process(struct batadv_priv *bat_priv,
 						       tvlv_hdr->type,
 						       tvlv_hdr->version);
 
-		ret |= batadv_tvlv_call_handler(bat_priv, tvlv_handler,
-						packet_type, orig_node, skb,
-						tvlv_hdr + 1,
-						tvlv_value_cont_len);
+		res = batadv_tvlv_call_handler(bat_priv, tvlv_handler,
+					       packet_type, orig_node, skb,
+					       tvlv_hdr + 1,
+					       tvlv_value_cont_len);
+		if (ret == NET_RX_SUCCESS || res < 0)
+			ret = res;
+
 		batadv_tvlv_handler_put(tvlv_handler);
 	}
 
-- 
2.47.3

