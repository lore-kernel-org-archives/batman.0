Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09ABFCA6007
	for <batman@archiver.kernel.org>; Thu,  8 Oct 2026 14:31:17 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 351CC83EB0
	for <batman@archiver.kernel.org>; Thu, 08 Oct 2026 16:31:16 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1791469876;
 b=fKbD7Rlc6vbxV2/1HkO0SP/OfjLH2qWLDe9eqKYl+cn1stSIQZIPv5gC20H36H/4gGrqS
 EapnTy6toF0qI2C6ypx5XPKF4hxxW7vOS67vx6ylxEkqkquf9G5EdZG+5t/Ulwyxfh+7n6O
 G9UuJ13hEARDDzNR4uRcSGjli1kkBd0=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1791469876; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=dYpJ/WTL9ve9l+DzsykNt58Ew/WW7dve30kyJncqHvU=;
 b=lJwRbPh9/qo7uXnHBUPOaWMEV1CHwHx5DDToUeprxFFWb6wPU0lwvv9uj/bLXYlivcoPY
 h88gkSVj+niuUWZ5YOl/KaS1t4ETmIfCICqzOhJsmeXeAp4lHzk8lH59AJDKdMBwdNap5Ln
 CFFYd2icxMmPli9S4Su+4DPtrwh+ml4=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 5E7C081E84
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 08 Oct 2026 16:30:36 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1791469836;
	b=YForX/EdWEuvbUjqftYV8mh1eXVVwx02q6BJl0LoX0dnKF/QYRPS49rx/SGi32ksjb6GEA
	tFHZYlndiGs7TJCQdiYn8Bm1qmAxmpewB0FB8qg59pekGkSiFyQD00QwtTWYh6vdbH5z9a
	m6JNEtnqB2c3VSBSQefkmWWpRc4D0fE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1791469836;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=dYpJ/WTL9ve9l+DzsykNt58Ew/WW7dve30kyJncqHvU=;
	b=Nh68jdeRjvy6Z3mhnANZCDllII5NswMVmCsrmcxbbjW33PFb7U1uS7sppAF7Y8l78p/Lf7
	tRu/XZIQciV0+0cq7Df8Je2hyBAFaikL+pTr2/T3RFWPhI7qRSanfczlM2RdIFZvukgNHu
	jVk+LeoCbP1Gxdk234/5myczZ8swxJY=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=h3X6o0tU;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 19ED11FEA4;
	Thu, 08 Oct 2026 14:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1791469836;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dYpJ/WTL9ve9l+DzsykNt58Ew/WW7dve30kyJncqHvU=;
	b=h3X6o0tUF72Yw4jTy20e8dqAwY3YQDBgjD5r+fJIYP+9tY5FJv6IZQAv5IAGPUw9uH8Qw2
	IA32k06L9oP7JWCUo4x1ZkGeTRc8rXhjIDHdrevddrcDq8eEjkMyltIKloW3xbw41B7xQF
	BvqVcdvf5GNjr05NfC4mk8XmtUfAg/A=
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 08 Oct 2026 16:30:10 +0200
Subject: [PATCH batadv v2 5/8] batman-adv: tt: only update flags for TT
 events
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261008-tt-avoid-unhashed-event-v2-5-7c4eed81606d@narfation.org>
References: <20261008-tt-avoid-unhashed-event-v2-0-7c4eed81606d@narfation.org>
In-Reply-To: 
 <20261008-tt-avoid-unhashed-event-v2-0-7c4eed81606d@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4241; i=sven@narfation.org;
 h=from:subject:message-id; bh=Qp4J3WllAXwQ183XrkKb//MVyZfMsGWcMKAAIzprA+4=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFnHV3wwsZxdGqVzVfS9YYOZ/W/N1oasNbMcdVatW8K5K
 un7qeUKHaUsDGJcDLJiiix7ruSf38z+Vv7ztI9HYeawMoEMYeDiFICJbNVj+O/9eu4VcbF532om
 OpxfmVbIUrxqrn2s4X2+pLyFt3ST50gw/DPLlMhIPvtVzes3y6rVpif9S5dEfj8q4xYeGfr+y43
 sAh4A
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: OZD5YMC4DSSBASDB4MIZODXZ26ABKFJR
X-Message-ID-Hash: OZD5YMC4DSSBASDB4MIZODXZ26ABKFJR
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/OZD5YMC4DSSBASDB4MIZODXZ26ABKFJR/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

In the first implementation of the translation table events, it was only
possible to announce:

* ADD: new locally detected client
* DEL: disappeared local client

If an ADD event was queued and then a DEL event was queued in the same
timeslot, it is valid to destroy both events because nothing actually
changed for remode nodes

But with commit e0eb5f8df352 ("batman-adv: improve the TT component to
support runtime flag changes") and subsequent changes, it could also happen
that there are extra ADD events:

* ADD: _NEW_ locally detected client
* ADD: already existing client with new flags
* DEL: disappeared local client

The first and the last type of event could in theory still be removed
together from the (to be announced) events queue. But if the "update flags"
ADD is dropped together with the DEL, it would still leave global
translation table of a remote node in the incorrect state - believing that
the client didn't disappear.

If a detected client was previously announced, a DEL event must only
overwrite the "update flags" ADD but the DEL itself must still continue to
exist in the (to be anounced) events queue. For now, adjustment of the
announced flags is used for everything instead of dropping already queued
up events completely.

Similarly, a DEL followed by an ADD caused both entries to be deleted. But
the new ADD could announce flags changes which were not yet present for the
client before it was marked for DELetion. The new ADD must therefore only
overwrite the DEL - but still be kept.

Fixes: e0eb5f8df352 ("batman-adv: improve the TT component to support runtime flag changes")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/translation-table.c | 29 +++++++++--------------------
 1 file changed, 9 insertions(+), 20 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 2792617c..c6c4df57 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -675,6 +675,9 @@ static u16 batadv_tt_flags_get(struct batadv_tt_common_entry *common)
  * @bat_priv: the bat priv with all the mesh interface information
  * @common: the TT entry involved in the event
  * @flags: flags of the TT entry combined with the event flags
+ *
+ * Only a single change per client is queued. It describes the latest state of
+ * the client and a new event therefore replaces an already queued one.
  */
 static void __batadv_tt_local_event(struct batadv_priv *bat_priv,
 				    const struct batadv_tt_common_entry *common,
@@ -684,7 +687,6 @@ static void __batadv_tt_local_event(struct batadv_priv *bat_priv,
 	struct batadv_tt_change_node *entry;
 	struct batadv_tt_change_node *safe;
 	bool del_op_requested;
-	bool del_op_entry;
 	size_t changes;
 
 	tt_change_node = kmem_cache_alloc(batadv_tt_change_cache, GFP_ATOMIC);
@@ -718,25 +720,12 @@ static void __batadv_tt_local_event(struct batadv_priv *bat_priv,
 		if (entry->change.vid != tt_change_node->change.vid)
 			continue;
 
-		del_op_entry = entry->change.flags & BATADV_TT_CLIENT_DEL;
-		if (del_op_requested != del_op_entry) {
-			/* DEL+ADD in the same orig interval have no effect and
-			 * can be removed to avoid silly behaviour on the
-			 * receiver side. The  other way around (ADD+DEL) can
-			 * happen in case of roaming of  a client still in the
-			 * NEW state. Roaming of NEW clients is now possible due
-			 * to automatically recognition of "temporary" clients
-			 */
-			list_del(&entry->list);
-			kmem_cache_free(batadv_tt_change_cache, entry);
-			changes--;
-		} else {
-			/* this is a second add or del in the same originator
-			 * interval. It could mean that flags have been changed
-			 * (e.g. double add): update them
-			 */
-			entry->change.flags = flags;
-		}
+		/* the other nodes may know the client with different
+		 * flags. A DEL+ADD must therefore still announce the
+		 * current flags and an ADD+DEL must still remove the
+		 * client. ADD+ADD and DEL+DEL only update the flags
+		 */
+		entry->change.flags = flags;
 
 		kmem_cache_free(batadv_tt_change_cache, tt_change_node);
 		goto update_changes;

-- 
2.47.3

