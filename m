Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58EFEC5AC67
	for <batman-adv@archiver.kernel.org>; Thu,  6 Aug 2026 20:00:14 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 74E74800FE
	for <batman-adv@archiver.kernel.org>; Thu, 06 Aug 2026 22:00:08 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1786046408;
 b=cvuzqaSe69MfQ5rbsG5LMYXOPpkilEe3ILoes/xqA2h1qsPgad/VczKiDHBfwJd3TfX4d
 /HZgCaJ6XMXYV9UKQplJvm+Vh8EEPZQ9CKDc+lDUVXI7Z1e3UAdBP+6GyfXkA1JN6W3PQJ2
 ujgWvmOs1OqXb62xNrrHEaeOnbUhEns=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1786046408; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=KTNInRYUtmSxn9/U16pVAgyx/ELaS1qxJaSVA29WiE0=;
 b=j6unfAJ6/uC8DGwHd3a5edD5KgmpZjR/9+G3kifyu+Y0CL/5RFfVjS34c/BmErQ7LPzrz
 q4TWiDy/DYSKTLG8ihkSnwsvlAGkksPunP6iMMdTXlNyptV0ipTRNAwg1hjoxlJSM76cxuf
 oedn8+SGnHebxggwdLuiqzxqgUqYyjk=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 9E6BD80267
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 06 Aug 2026 20:55:45 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1786042545;
	b=F3RQiL9WvRG24lzXhQkx7CqmCUGqvjN65HRZervsZGNRE5D8HO7fQqhBI7BJurtfv+yTVn
	2/+4cjQzJ/PTOhl5Q64QHGp7mMjOnESgdD219rMa3Z5w+LCgINQIpfLLgLysudK23oB2Dt
	uI+UmBOaTFqUzdVpNIroDKc6wFJMDJM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1786042545;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=KTNInRYUtmSxn9/U16pVAgyx/ELaS1qxJaSVA29WiE0=;
	b=dh0ehkXzhMWl8VZPwVPFJvCWqCvhyQsJr2YkCwdU164Q8a9CHw2I9WcmMrbrER/bvdqJn5
	YsC/QFirnBOUBO+WMlbFV2idVJHHDDGV7PSDW1UO1UtV4EGHJ6C47BTlu3AbAdCDuhDtiH
	2suOkjQugpCb+xc714MxjDetDVXRvAc=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=pPQfGEle;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 3322C20267;
	Thu, 06 Aug 2026 18:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1786042541;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KTNInRYUtmSxn9/U16pVAgyx/ELaS1qxJaSVA29WiE0=;
	b=pPQfGEleBikMm1JBeIo6aX35q2QH9mnx8zoTCRqgpr1ZNpg9kQrxMNQr2O8SP3omETQvtx
	6XBN+TzPgAIvXcB7RwkDaphHGJ/z82viSuhG+ipTtIHbZKTZWpOah/ZxrP/yiVokDR1pYo
	mMIA3Ou7Qeo1P7e5x0Eu+PYqjyKvVKk=
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 06 Aug 2026 20:54:55 +0200
Subject: [PATCH batadv 3/3] batman-adv: use more descriptive var names for
 is_similar_or_better
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260806-bat_v-sob-kdoc-v1-3-ba4d763de0da@narfation.org>
References: <20260806-bat_v-sob-kdoc-v1-0-ba4d763de0da@narfation.org>
In-Reply-To: <20260806-bat_v-sob-kdoc-v1-0-ba4d763de0da@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6311; i=sven@narfation.org;
 h=from:subject:message-id; bh=q6oVKRO6UkMUbkfG9SonXDBDa+wcIksb9B55Is53sDI=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFklN1r3XORRSuwRuP7rt8JK5rl8G7RfLtueVbL358vNy
 82rpbLfdZSyMIhxMciKKbLsuZJ/fjP7W/nP0z4ehZnDygQyhIGLUwAm0mDH8M80ZEPnujahiPcm
 xodnPatqNDKvvLvz4/9Tppo50gar72owMnR+eX5Q7XFhY8+Ctsw9LKdd2ZJTOp67Hv8sGxJUL38
 okgcA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: CZ3SCXPRGBIOUCWQ6IZ72SZQBPNJ5LAK
X-Message-ID-Hash: CZ3SCXPRGBIOUCWQ6IZ72SZQBPNJ5LAK
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/CZ3SCXPRGBIOUCWQ6IZ72SZQBPNJ5LAK/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

neigh1 and neigh2 is not really helpful when looking at a code which needs
to judge the metric similarity between a candidate and a reference. This
already caused an implementation error in the B.A.T.M.A.N. V bonding code.
Simply using "reference" and "candidate" for the neighbors is a lot more
descriptive and makes it easier to understand the code.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/bat_iv_ogm.c | 25 +++++++++++++------------
 net/batman-adv/bat_v.c      | 42 +++++++++++++++++++++---------------------
 net/batman-adv/types.h      | 12 ++++++------
 3 files changed, 40 insertions(+), 39 deletions(-)

diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index 53fbdbbe..3fe09b4c 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -2424,25 +2424,26 @@ static int batadv_iv_ogm_neigh_cmp(struct batadv_neigh_node *neigh1,
 /**
  * batadv_iv_ogm_neigh_is_sob() - check if neigh1 is similarly good or better
  *  than neigh2 from the metric prospective
- * @neigh1: the first neighbor object of the comparison
- * @if_outgoing1: outgoing interface for the first neighbor
- * @neigh2: the second neighbor object of the comparison
- * @if_outgoing2: outgoing interface for the second neighbor
+ * @candidate: the first neighbor object of the comparison
+ * @if_outgoing_cand: outgoing interface for the @candidate neighbor
+ * @reference: the second neighbor object of the comparison
+ * @if_outgoing_ref: outgoing interface for the @reference neighbor
  *
- * Return: true if the metric via neigh1 is equally good or better than
- * the metric via neigh2, false otherwise.
+ * Return: true if the metric via @candidate is equally good or better than
+ * the metric via @reference, false otherwise.
  */
 static bool
-batadv_iv_ogm_neigh_is_sob(struct batadv_neigh_node *neigh1,
-			   struct batadv_hard_iface *if_outgoing1,
-			   struct batadv_neigh_node *neigh2,
-			   struct batadv_hard_iface *if_outgoing2)
+batadv_iv_ogm_neigh_is_sob(struct batadv_neigh_node *candidate,
+			   struct batadv_hard_iface *if_outgoing_cand,
+			   struct batadv_neigh_node *reference,
+			   struct batadv_hard_iface *if_outgoing_ref)
 {
 	bool ret;
 	int diff;
 
-	ret = batadv_iv_ogm_neigh_diff(neigh1, if_outgoing1, neigh2,
-				       if_outgoing2, &diff);
+	ret = batadv_iv_ogm_neigh_diff(candidate, if_outgoing_cand,
+				       reference, if_outgoing_ref,
+				       &diff);
 	if (!ret)
 		return false;
 
diff --git a/net/batman-adv/bat_v.c b/net/batman-adv/bat_v.c
index 0d0a226c..596889b3 100644
--- a/net/batman-adv/bat_v.c
+++ b/net/batman-adv/bat_v.c
@@ -514,40 +514,40 @@ static int batadv_v_neigh_cmp(struct batadv_neigh_node *neigh1,
 /**
  * batadv_v_neigh_is_sob() - check whether two B.A.T.M.A.N. V neighbours have
  *  a similar or better throughput
- * @neigh1: first neighbour to compare
- * @if_outgoing1: outgoing interface to use for @neigh1
- * @neigh2: second neighbour to compare
- * @if_outgoing2: outgoing interface to use for @neigh2
+ * @candidate: the first neighbor object of the comparison
+ * @if_outgoing_cand: outgoing interface for the @candidate neighbor
+ * @reference: the second neighbor object of the comparison
+ * @if_outgoing_ref: outgoing interface for the @reference neighbor
  *
- * Return: true if the throughput of @neigh1 is more than 3/4 of the
- *  @neigh2 throughput
+ * Return: true if the throughput of @candidate is more than 3/4 of the
+ *  @reference throughput
  */
-static bool batadv_v_neigh_is_sob(struct batadv_neigh_node *neigh1,
-				  struct batadv_hard_iface *if_outgoing1,
-				  struct batadv_neigh_node *neigh2,
-				  struct batadv_hard_iface *if_outgoing2)
+static bool batadv_v_neigh_is_sob(struct batadv_neigh_node *candidate,
+				  struct batadv_hard_iface *if_outgoing_cand,
+				  struct batadv_neigh_node *reference,
+				  struct batadv_hard_iface *if_outgoing_ref)
 {
-	struct batadv_neigh_ifinfo *ifinfo1;
-	struct batadv_neigh_ifinfo *ifinfo2;
+	struct batadv_neigh_ifinfo *ifinfo_cand;
+	struct batadv_neigh_ifinfo *ifinfo_ref;
 	bool ret = false;
 	u32 threshold;
 
-	ifinfo1 = batadv_neigh_ifinfo_get(neigh1, if_outgoing1);
-	if (!ifinfo1)
+	ifinfo_cand = batadv_neigh_ifinfo_get(candidate, if_outgoing_cand);
+	if (!ifinfo_cand)
 		goto err_ifinfo1;
 
-	ifinfo2 = batadv_neigh_ifinfo_get(neigh2, if_outgoing2);
-	if (!ifinfo2)
+	ifinfo_ref = batadv_neigh_ifinfo_get(reference, if_outgoing_ref);
+	if (!ifinfo_ref)
 		goto err_ifinfo2;
 
-	threshold = ifinfo2->bat_v.throughput / 4;
-	threshold = ifinfo2->bat_v.throughput - threshold;
+	threshold = ifinfo_ref->bat_v.throughput / 4;
+	threshold = ifinfo_ref->bat_v.throughput - threshold;
 
-	ret = ifinfo1->bat_v.throughput > threshold;
+	ret = ifinfo_cand->bat_v.throughput > threshold;
 
-	batadv_neigh_ifinfo_put(ifinfo2);
+	batadv_neigh_ifinfo_put(ifinfo_ref);
 err_ifinfo2:
-	batadv_neigh_ifinfo_put(ifinfo1);
+	batadv_neigh_ifinfo_put(ifinfo_cand);
 err_ifinfo1:
 	return ret;
 }
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 9bdc5a3e..99667f63 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -2087,14 +2087,14 @@ struct batadv_algo_neigh_ops {
 		   struct batadv_hard_iface *if_outgoing2);
 
 	/**
-	 * @is_similar_or_better: check if neigh1 is equally similar or better
-	 *  than neigh2 for their respective outgoing interface from the metric
+	 * @is_similar_or_better: check if @candidate is equally similar or better
+	 *  than @reference for their respective outgoing interface from the metric
 	 *  prospective
 	 */
-	bool (*is_similar_or_better)(struct batadv_neigh_node *neigh1,
-				     struct batadv_hard_iface *if_outgoing1,
-				     struct batadv_neigh_node *neigh2,
-				     struct batadv_hard_iface *if_outgoing2);
+	bool (*is_similar_or_better)(struct batadv_neigh_node *candidate,
+				     struct batadv_hard_iface *if_outgoing_cand,
+				     struct batadv_neigh_node *reference,
+				     struct batadv_hard_iface *if_outgoing_ref);
 
 	/** @dump: dump neighbors to a netlink socket (optional) */
 	void (*dump)(struct sk_buff *msg, struct netlink_callback *cb,

-- 
2.47.3

