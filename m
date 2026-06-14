Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9DD1CD98D2
	for <batman-adv@archiver.kernel.org>; Sun, 14 Jun 2026 10:32:08 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 44A3084405
	for <batman-adv@archiver.kernel.org>; Sun, 14 Jun 2026 12:32:07 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1781433127;
 b=K7iiUvyYqdXg353bCgM+s8Rut0Gflx5eKPfosgCybpQd1FyagV6XX2SzofTKFpQ0BZhXG
 TLasJr8Qj9GL/5tOVsZyXwkmO4sxetytVQ/FtbxmlUvdR9uxFRYb1HiVQaaswCaA0URDPlS
 gbjb+W3iKblz6WYAQZDXQciaAd3+VOA=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1781433127; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=9D170Kkv03LJRDVjcfjmeSjHbQvICN9PzJO87FbHVK8=;
 b=m+o2SZvwb0C5EQwiSwfuq3oEBhR8pAQVcZuzLWq5eZB4eVObJQwIrIJGKw1PL8IJSQVLf
 HIqMw8EWQWBrGleGw0mN7HhgE16yV1oxylN7CP5dz9mKJ4jQyk9/roA69bzTzr+RxPvRtIU
 Q+TNfM6/nG5YvzOuBbaqNZp422yTGO8=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 870578273D
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 14 Jun 2026 12:30:56 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1781433061;
	b=Ke/uO62gTuMOKIrGjwA/WVsZ5KOt/ee2yu+uRtyFsZcYUTQ7P1uPpsliIZk2+BtaPAIiC+
	+cUVrYBe00iUdTac9JHJ/ehhiEsyEBeH63f4zCGPdSWmWq5y4ZeCzUg4C1jivd4SguKGd5
	UmNDl++ltwOxUXsnvMS0l0VIgLyLigA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1781433061;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=9D170Kkv03LJRDVjcfjmeSjHbQvICN9PzJO87FbHVK8=;
	b=cKwEA+lOBioFgeITxgfDq5idS2zWhk3pxNT+uANEZyTnHjMKXqO5GEzTWa1MHKEos4M1EW
	lRryD80UYNdHJ2MHUOPJfH4uVfV7Js6KxcGW7s8Jy+1J1+THOVxI0T7v7HUAAHU4EQW+9U
	/7wiUMLE/XtQhTVvDyts24GZXViStCE=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=MsjUizzN;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 2E560202D1;
	Sun, 14 Jun 2026 10:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1781433056;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9D170Kkv03LJRDVjcfjmeSjHbQvICN9PzJO87FbHVK8=;
	b=MsjUizzN3vWaGWybmG3M3EQLU0MTAyvmqIXykMpbmhCQGMT7b+3i6VrsC857I3QqCC1Y7a
	55pwfGUmg/TQzjY/386//df/CXOOG13hujBR7bV8O42Wi3XHuSAp1ujsJy2EnapHFyUEX3
	n0/i1vhR0Yctu5JO6z1GNvwXbx/YSEQ=
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 14 Jun 2026 12:30:41 +0200
Subject: [PATCH batadv 2/2] batman-adv: tvlv: extract tvlv header iterator
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260614-tvlv-non-const-flags-v1-2-251abea59176@narfation.org>
References: <20260614-tvlv-non-const-flags-v1-0-251abea59176@narfation.org>
In-Reply-To: <20260614-tvlv-non-const-flags-v1-0-251abea59176@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4553; i=sven@narfation.org;
 h=from:subject:message-id; bh=mNHGrGDY2KczlbhNajjuguzd+MHPZCzQEShfWpZEc40=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFl6TdezFn3KPsBZmdW+QWiu+T6tWVy3Gcu6l52yXX9SI
 vpB1xWrjlIWBjEuBlkxRZY9V/LPb2Z/K/952sejMHNYmUCGMHBxCsBEkjMYGbZ4PJ/wL/Xf4h/J
 k25F6C09k3iq01fq9ufbi+fsfy757dRRhn8WzjNEjnFLpy3XTjrocj32V+zXrMOqNXZiW7glkwU
 NNPkA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: EMZ44TT32PP24P3F63IIXXBRDCSA453F
X-Message-ID-Hash: EMZ44TT32PP24P3F63IIXXBRDCSA453F
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/EMZ44TT32PP24P3F63IIXXBRDCSA453F/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

batadv_tvlv_containers_contain() and batadv_tvlv_containers_process() are
using the same code to iterate through the TVLV containers. To simplify the
code, extract the shared portions of both functions.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/tvlv.c | 86 ++++++++++++++++++++++++++++++---------------------
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

