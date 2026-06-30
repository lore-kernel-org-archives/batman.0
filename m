Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99DD0C43327
	for <batman-adv@archiver.kernel.org>; Tue, 30 Jun 2026 14:14:21 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 3F06684064
	for <batman-adv@archiver.kernel.org>; Tue, 30 Jun 2026 16:14:20 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1782828860;
 b=lnghmrVphLAU2TNkmPhPF4c/gt/gi1MeVcVj0PQm93JulyPdqCQRcRpfbhvu1bVedF6l8
 EUBYqdzj9sTpKs9UAR0q5cgyaX6U4L91VYpYxX+TOE5q00XRzL69VjrmtCBsN584RKIiEoD
 jMz/oVAXb6Tl/bsVpDOo5Mt2z/bC39I=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1782828860; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=q3ZGFfO0pQVo955cy4QHxZ8eqU7mZNLw3Z/Xfs0q5Gs=;
 b=3ewtZbYSw3k486+vmhJxJa7GGiKAMjHBETzJ1KNqQ+M81/lZrBq5ftEBxiufqsvpCWPG4
 vq4hs683UOcEEhYcUqyaJWtK9M6ZJxT936nMq85Rux3uzxsTH7KdWqKIG+KAJhXFzcId9Xl
 SSzCCcX9hH1dCwK/ZdZbJD+oCxj3aLE=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de
 [IPv6:2a01:4f8:c17:e8c0::1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 3DDE58110E
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 30 Jun 2026 16:06:33 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1782828393;
	b=qJuDU7ZtTuby7Hd0fUl1Mtc6kGAtBS+6DTJhUXbtfUgwAL6d2EvWDdFnlj33lo4qL9cR66
	FuRCuW2cpfyGFbwKOEjnv3LMiIZ0p71XGjCvx24pDIXXfjgWkqDSjz+zLc7SelLhHcjfVT
	qRzMu6mdSZTaTV+cCyA5rgokL3n8hMQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1782828393;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=q3ZGFfO0pQVo955cy4QHxZ8eqU7mZNLw3Z/Xfs0q5Gs=;
	b=NKnsbk17ONvQcKpKkO1g9qlRc7FAEga6Kc9uwm52yIlkLEc9Z13kfQNIEVMuk130FQhyFo
	B+KY4Wb9kYILJeVx2Ndv2WY1ZukIEoyXUhslwxpk7jVPaotS01rpCsJjEIws0WlRlyqbwD
	Co8rOgJYNXlqF++Za3F1o6ptJm0aeRk=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=F1SjhFgo;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 2a01:4f8:c17:e8c0::1 as permitted sender)
 smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1782828392;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q3ZGFfO0pQVo955cy4QHxZ8eqU7mZNLw3Z/Xfs0q5Gs=;
	b=F1SjhFgorajQuLw1hBE/7t6k8QR1AH1GMD1zBCegXqAddqVw20wPiQ0s1cZENV+mdzuavJ
	pzFCBWFAJtgNnk+aZJcXzHHMFW+/QiX4VMlYsTiGLrv6V0wwBqsoqJMtrFxazHOcRU8Med
	41WHxV6P+Lcb9hV6HK0Bx6OL4TG1cxfzeO/T1cHDQxzBkjSSAUd7LT1JmqnY6lSs5QAOtk
	PKPQ23+dDEKx4VZVGGnDqc0dZpk5EVJ6J3ShD41t7dEZLa61Orrsaiy2vSYIqdKfr7KOlK
	6lqYEMnpqcLPYXbJFU8Tuh38IfgaCtLobqMDICvH0TCJ06QXNQa2v2VTyC9Fhg==
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
Subject: [PATCH net-next 10/15] batman-adv: tvlv: extract tvlv header iterator
Date: Tue, 30 Jun 2026 16:06:18 +0200
Message-ID: <20260630140623.88431-11-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260630140623.88431-1-sw@simonwunderlich.de>
References: <20260630140623.88431-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: VCO6MKTSJZSONOZZ5EYYMZSOWV2BJGJT
X-Message-ID-Hash: VCO6MKTSJZSONOZZ5EYYMZSOWV2BJGJT
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/VCO6MKTSJZSONOZZ5EYYMZSOWV2BJGJT/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Sven Eckelmann <sven@narfation.org>

batadv_tvlv_containers_contain() and batadv_tvlv_containers_process() are
using the same code to iterate through the TVLV containers. To simplify the
code, extract the shared portions of both functions.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/tvlv.c | 86 +++++++++++++++++++++++++------------------
 1 file changed, 51 insertions(+), 35 deletions(-)

diff --git a/net/batman-adv/tvlv.c b/net/batman-adv/tvlv.c
index 1c9fb21985f6a..49bf2ed9ecdc3 100644
--- a/net/batman-adv/tvlv.c
+++ b/net/batman-adv/tvlv.c
@@ -442,6 +442,54 @@ static int batadv_tvlv_call_handler(struct batadv_priv *bat_priv,
 	return NET_RX_SUCCESS;
 }
 
+/**
+ * batadv_tvlv_hdr_next() - move a tvlv buffer cursor to the next container
+ * @tvlv_value: cursor into the tvlv buffer, advanced past the returned
+ *  container's content on success
+ * @tvlv_value_len: remaining length of the tvlv buffer, reduced by the returned
+ *  container's size on success
+ *
+ * Parses a single container header at the current cursor position and, if a
+ * complete container is available, advances the cursor and remaining length
+ * past it. The returned header stays valid; its content is located at
+ * (returned header + 1) and is ntohs(hdr->len) bytes long.
+ *
+ * Return: pointer to the next tvlv container header, or NULL if no further
+ * complete container is present in the buffer.
+ */
+static struct batadv_tvlv_hdr *batadv_tvlv_hdr_next(void **tvlv_value, u16 *tvlv_value_len)
+{
+	struct batadv_tvlv_hdr *tvlv_hdr;
+	u16 tvlv_value_cont_len;
+	void *tvlv_value_cont;
+	u16 tvlv_len;
+
+	tvlv_value_cont = *tvlv_value;
+	tvlv_len = *tvlv_value_len;
+
+	if (tvlv_len < sizeof(*tvlv_hdr))
+		return NULL;
+
+	tvlv_hdr = tvlv_value_cont;
+	tvlv_value_cont_len = ntohs(tvlv_hdr->len);
+	tvlv_value_cont = tvlv_hdr + 1;
+	tvlv_len -= sizeof(*tvlv_hdr);
+
+	if (tvlv_value_cont_len > tvlv_len)
+		return NULL;
+
+	/* the next tvlv header is accessed assuming (at least) 2-byte
+	 * alignment, so it must start at an even offset.
+	 */
+	if (tvlv_value_cont_len & 1)
+		return NULL;
+
+	*tvlv_value = (u8 *)tvlv_value_cont + tvlv_value_cont_len;
+	*tvlv_value_len = tvlv_len - tvlv_value_cont_len;
+
+	return tvlv_hdr;
+}
+
 /**
  * batadv_tvlv_containers_contain() - check if a tvlv buffer holds a container
  * @tvlv_value: tvlv content
@@ -457,28 +505,10 @@ static bool batadv_tvlv_containers_contain(void *tvlv_value,
 					   u8 version)
 {
 	struct batadv_tvlv_hdr *tvlv_hdr;
-	u16 tvlv_value_cont_len;
-
-	while (tvlv_value_len >= sizeof(*tvlv_hdr)) {
-		tvlv_hdr = tvlv_value;
-		tvlv_value_cont_len = ntohs(tvlv_hdr->len);
-		tvlv_value = tvlv_hdr + 1;
-		tvlv_value_len -= sizeof(*tvlv_hdr);
-
-		if (tvlv_value_cont_len > tvlv_value_len)
-			break;
-
-		/* the next tvlv header is accessed assuming (at least) 2-byte
-		 * alignment, so it must start at an even offset.
-		 */
-		if (tvlv_value_cont_len & 1)
-			break;
 
+	while ((tvlv_hdr = batadv_tvlv_hdr_next(&tvlv_value, &tvlv_value_len))) {
 		if (tvlv_hdr->type == type && tvlv_hdr->version == version)
 			return true;
-
-		tvlv_value = (u8 *)tvlv_value + tvlv_value_cont_len;
-		tvlv_value_len -= tvlv_value_cont_len;
 	}
 
 	return false;
@@ -511,20 +541,8 @@ int batadv_tvlv_containers_process(struct batadv_priv *bat_priv,
 	u8 cifnotfound = BATADV_TVLV_HANDLER_OGM_CIFNOTFND;
 	int ret = NET_RX_SUCCESS;
 
-	while (tvlv_value_len >= sizeof(*tvlv_hdr)) {
-		tvlv_hdr = tvlv_value;
+	while ((tvlv_hdr = batadv_tvlv_hdr_next(&tvlv_value, &tvlv_value_len))) {
 		tvlv_value_cont_len = ntohs(tvlv_hdr->len);
-		tvlv_value = tvlv_hdr + 1;
-		tvlv_value_len -= sizeof(*tvlv_hdr);
-
-		if (tvlv_value_cont_len > tvlv_value_len)
-			break;
-
-		/* the next tvlv header is accessed assuming (at least) 2-byte
-		 * alignment, so it must start at an even offset.
-		 */
-		if (tvlv_value_cont_len & 1)
-			break;
 
 		tvlv_handler = batadv_tvlv_handler_get(bat_priv,
 						       tvlv_hdr->type,
@@ -532,11 +550,9 @@ int batadv_tvlv_containers_process(struct batadv_priv *bat_priv,
 
 		ret |= batadv_tvlv_call_handler(bat_priv, tvlv_handler,
 						packet_type, orig_node, skb,
-						tvlv_value,
+						tvlv_hdr + 1,
 						tvlv_value_cont_len);
 		batadv_tvlv_handler_put(tvlv_handler);
-		tvlv_value = (u8 *)tvlv_value + tvlv_value_cont_len;
-		tvlv_value_len -= tvlv_value_cont_len;
 	}
 
 	if (packet_type != BATADV_IV_OGM &&
-- 
2.47.3

