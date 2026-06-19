Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9701CCD98E6
	for <batman@archiver.kernel.org>; Fri, 19 Jun 2026 07:12:23 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 425CF85AF1
	for <batman@archiver.kernel.org>; Fri, 19 Jun 2026 09:12:22 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1781853142;
 b=boFY1IYhi0oOgiCk3Z06N4zeNNILcl+oDTetNuHTeNCkacNR6W5XXffvy08mwslGU0VUm
 gfjPkbqY3C1nFZh+nD+fcUScmvaMXS1on5kJqdMHTsYQGm8h0CurLFYnY3lIu9Wr6qgH8A6
 e7LVF0l6e3/onSDD6cBfUGDsfBQI5oM=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1781853142; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=txph5b6EzyWcZoZ25nYE+Zhi1YekIIHjAUHC8G/RctA=;
 b=FBOqiwU2l/1+6yPQneFyPTm2xnXcppazSxXdBkeHQzPrwIrEgES4PrCkjd/+csCP5Rly8
 1/o6wBz2QYMvtdMfYlD5dSZG5CGJ0Y5hr6gKBME4Neu9hdk9zMg07Stfz3Aru5aP6UsVVt8
 cvZ1R7bZIJgc0EbDxiOd7Hz1y76XcbI=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id DD77D83D5F
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 19 Jun 2026 09:00:57 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1781852457;
	b=TFbfmH7Z/msPFBL85z+tYEwby34cPjfZNTlJfeU57e4G9AWve77PCg8m1U/oPewdf0jKoj
	BgTSbW10mSf91K2Ty79tamh+gQJwBKicwIQ2XY9AmClvfA+FFnGykSMlPaVw3hL/EHm89w
	mQZcIxfxvBOx25pq3hx3hTbiYW9X+Do=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1781852457;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=txph5b6EzyWcZoZ25nYE+Zhi1YekIIHjAUHC8G/RctA=;
	b=VoDuG256U+rvGMEm89o8cmFSoJ9UmIlvjdST8ntxHgJY9I4QyUO0YiqDQSLDz994rQMWpn
	eNSvRKWj1TR2jFuEdecbAqYHbSzd79MdTb9zuNVu+Su3Bpj2yKgB97chYLPd8odcGi0Js8
	rAsVgeb682YWSsujoOtcHfVx1TY39tc=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=VZfdNlO1;
	dmarc=pass (policy=none) header.from=simonwunderlich.de;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 23.88.38.48 as permitted sender) smtp.mailfrom=sw@simonwunderlich.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1781852457;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=txph5b6EzyWcZoZ25nYE+Zhi1YekIIHjAUHC8G/RctA=;
	b=VZfdNlO1cGA75UOkcEhEK1GDxK1UE3LQxdD4Rntjk0girfh8htDCQPhV3BpylOacPGw77z
	Xadkeq6/0tnRld+dsWmE+dOtN5tuQpwYVAuZCTyTK2UYPcUD+C0JLXIisr+2M/EiDOdJDj
	i1AYbc8cIHfbCDJBcbD1JLjd/YmrXeJcGixJNM8UGN9JEk/pJ5kL9ysMtkEX3NYe3XKqcb
	enH8OZbPss/q6VVHEFtdR3zfK3DZUdixLD2VgdsQxt8ZBpo0OdvZwRWMbe+peAP/3ufz/2
	Yfv+zeeeNqo097DuWEpM/VZJinkY1WneKvKKj9oO6pLcwagLVIOLImhnS0JhWA==
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
Subject: [PATCH net 15/15] batman-adv: tvlv: avoid race of cifsnotfound
 handler state
Date: Fri, 19 Jun 2026 09:00:45 +0200
Message-ID: <20260619070045.438101-16-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260619070045.438101-1-sw@simonwunderlich.de>
References: <20260619070045.438101-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: WGRORE7ZDBJEFEBSZRTTK6WSCU2ZT3AU
X-Message-ID-Hash: WGRORE7ZDBJEFEBSZRTTK6WSCU2ZT3AU
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/WGRORE7ZDBJEFEBSZRTTK6WSCU2ZT3AU/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Sven Eckelmann <sven@narfation.org>

TVLV handlers can have the flag BATADV_TVLV_HANDLER_OGM_CIFNOTFND set to
signal that the OGM handler should be called (with NULL for data) when the
specific TVLV container was not found in the OGM. This is used by:

* DAT
* GW
* Multicast (OGM + Tracker)

The state whether the handler was executed was stored in the struct
batadv_tvlv_handler. But the TVLV processing is started without any lock.
Multiple parallel contexts processing TVLVs would therefore overwrite each
others BATADV_TVLV_HANDLER_OGM_CALLED flag in the shared
batadv_tvlv_handler.

Drop the shared BATADV_TVLV_HANDLER_OGM_CALLED flag and instead determine,
per TVLV buffer, whether a matching container was present by scanning the
packet's buffer.

Cc: stable@kernel.org
Fixes: ef26157747d4 ("batman-adv: tvlv - basic infrastructure")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/tvlv.c  | 63 ++++++++++++++++++++++++++++++++++++++----
 net/batman-adv/types.h |  7 -----
 2 files changed, 57 insertions(+), 13 deletions(-)

diff --git a/net/batman-adv/tvlv.c b/net/batman-adv/tvlv.c
index a957555d8958d..1c9fb21985f6a 100644
--- a/net/batman-adv/tvlv.c
+++ b/net/batman-adv/tvlv.c
@@ -411,7 +411,6 @@ static int batadv_tvlv_call_handler(struct batadv_priv *bat_priv,
 		tvlv_handler->ogm_handler(bat_priv, orig_node,
 					  BATADV_NO_FLAGS,
 					  tvlv_value, tvlv_value_len);
-		tvlv_handler->flags |= BATADV_TVLV_HANDLER_OGM_CALLED;
 		break;
 	case BATADV_UNICAST_TVLV:
 		if (!skb)
@@ -443,6 +442,48 @@ static int batadv_tvlv_call_handler(struct batadv_priv *bat_priv,
 	return NET_RX_SUCCESS;
 }
 
+/**
+ * batadv_tvlv_containers_contain() - check if a tvlv buffer holds a container
+ * @tvlv_value: tvlv content
+ * @tvlv_value_len: tvlv content length
+ * @type: tvlv container type to look for
+ * @version: tvlv container version to look for
+ *
+ * Return: true if a container of the given type and version is present in the
+ * tvlv buffer, false otherwise.
+ */
+static bool batadv_tvlv_containers_contain(void *tvlv_value,
+					   u16 tvlv_value_len, u8 type,
+					   u8 version)
+{
+	struct batadv_tvlv_hdr *tvlv_hdr;
+	u16 tvlv_value_cont_len;
+
+	while (tvlv_value_len >= sizeof(*tvlv_hdr)) {
+		tvlv_hdr = tvlv_value;
+		tvlv_value_cont_len = ntohs(tvlv_hdr->len);
+		tvlv_value = tvlv_hdr + 1;
+		tvlv_value_len -= sizeof(*tvlv_hdr);
+
+		if (tvlv_value_cont_len > tvlv_value_len)
+			break;
+
+		/* the next tvlv header is accessed assuming (at least) 2-byte
+		 * alignment, so it must start at an even offset.
+		 */
+		if (tvlv_value_cont_len & 1)
+			break;
+
+		if (tvlv_hdr->type == type && tvlv_hdr->version == version)
+			return true;
+
+		tvlv_value = (u8 *)tvlv_value + tvlv_value_cont_len;
+		tvlv_value_len -= tvlv_value_cont_len;
+	}
+
+	return false;
+}
+
 /**
  * batadv_tvlv_containers_process() - parse the given tvlv buffer to call the
  *  appropriate handlers
@@ -462,7 +503,9 @@ int batadv_tvlv_containers_process(struct batadv_priv *bat_priv,
 				   struct sk_buff *skb, void *tvlv_value,
 				   u16 tvlv_value_len)
 {
+	u16 tvlv_value_start_len = tvlv_value_len;
 	struct batadv_tvlv_handler *tvlv_handler;
+	void *tvlv_value_start = tvlv_value;
 	struct batadv_tvlv_hdr *tvlv_hdr;
 	u16 tvlv_value_cont_len;
 	u8 cifnotfound = BATADV_TVLV_HANDLER_OGM_CIFNOTFND;
@@ -506,12 +549,20 @@ int batadv_tvlv_containers_process(struct batadv_priv *bat_priv,
 		if (!tvlv_handler->ogm_handler)
 			continue;
 
-		if ((tvlv_handler->flags & BATADV_TVLV_HANDLER_OGM_CIFNOTFND) &&
-		    !(tvlv_handler->flags & BATADV_TVLV_HANDLER_OGM_CALLED))
-			tvlv_handler->ogm_handler(bat_priv, orig_node,
-						  cifnotfound, NULL, 0);
+		if (!(tvlv_handler->flags & BATADV_TVLV_HANDLER_OGM_CIFNOTFND))
+			continue;
 
-		tvlv_handler->flags &= ~BATADV_TVLV_HANDLER_OGM_CALLED;
+		/* if the corresponding container was present then the handler
+		 * was already called from the loop above
+		 */
+		if (batadv_tvlv_containers_contain(tvlv_value_start,
+						   tvlv_value_start_len,
+						   tvlv_handler->type,
+						   tvlv_handler->version))
+			continue;
+
+		tvlv_handler->ogm_handler(bat_priv, orig_node,
+					  cifnotfound, NULL, 0);
 	}
 	rcu_read_unlock();
 
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 3de3c1ac0244f..b1f9f8964c3fd 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -2294,13 +2294,6 @@ enum batadv_tvlv_handler_flags {
 	 *  will call this handler even if its type was not found (with no data)
 	 */
 	BATADV_TVLV_HANDLER_OGM_CIFNOTFND = BIT(1),
-
-	/**
-	 * @BATADV_TVLV_HANDLER_OGM_CALLED: interval tvlv handling flag - the
-	 *  API marks a handler as being called, so it won't be called if the
-	 *  BATADV_TVLV_HANDLER_OGM_CIFNOTFND flag was set
-	 */
-	BATADV_TVLV_HANDLER_OGM_CALLED = BIT(2),
 };
 
 #endif /* _NET_BATMAN_ADV_TYPES_H_ */
-- 
2.47.3

