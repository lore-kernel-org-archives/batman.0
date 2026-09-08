Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A1DDC79F82
	for <batman-adv@archiver.kernel.org>; Tue,  8 Sep 2026 17:25:04 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 0136D84033
	for <batman-adv@archiver.kernel.org>; Tue, 08 Sep 2026 19:25:03 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1788888302;
 b=knjrxlBCQRZ3HxzleSlLBFag/CFMr08IxorOHalov4yIOnnYCvSkrLKKq8H0JhzOwBLRl
 w0jE2lII4b42V+lDPr5iHS6rm9DZ+W3VqBPeO3aT+83PKxaIuYkKlGqtrG/4fawzO7WftHD
 K2O6bY6cLWtxTzYr0y8bTRe1mUNNJv4=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1788888302; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=HD1jt5U25IWO930ABD/JK7dAcgaT7HV0p5mpyQXwBS0=;
 b=NOvNknYmaL9ddrKECHli0rFYGL/SLDbrQCNXppgpUxOuNqBXhBWLbfGpBsH+cTnGz5pMJ
 CoTiLEO+ZeJ/xsf6AB9R3HK0VwXLRn86D6ZHfMQ8CiclhUsrpx6kmXjYcLhNbmoHTrGnyZF
 KyLA/zGUYlF7inWxQ+R3i2Bqk2cQQXY=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 7DBE7833D0
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 08 Sep 2026 19:23:48 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1788888233;
	b=nWNM4ThjnzM1ct/x/Syfgbsyb8EpsQSe6L2hpdu2VPl9/f3Jn5lu84rxfWfugGuZZIgCIL
	yzS1h08QsSwqc4sMLdnS/8n6mW1zwRo8H1OOrvkWWpCX3wwL0I4vnBOlRdB74+YFBLraM/
	FSjFf3EyLxaOFAxuJiDWlCrMFIeFLpo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1788888233;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=HD1jt5U25IWO930ABD/JK7dAcgaT7HV0p5mpyQXwBS0=;
	b=WUZRtvd72A9NZb/8vtbZ7HNorManFWpXK7wMm2zzICM7Ud8Fw64deU2srPGCHq4hBM8oXn
	VcEpRpGgoaCBY6uTuuANCXQGRHli0KD8MPpz5B1+0pBcJCMxyK6d0jonm/EQ5ccRcqxaOh
	NtEI+4fpM3NcQEZrxsLpXgzxGVWHiF0=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b="l1V/t/cu";
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 198CC20462;
	Tue, 08 Sep 2026 17:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1788888228;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HD1jt5U25IWO930ABD/JK7dAcgaT7HV0p5mpyQXwBS0=;
	b=l1V/t/cuOyFFABEYRfcqwN8v4IF/whC4bSW1/zjzgOP7ftKE9nGGlETF+q5KfJOH4iFVoZ
	eerPsSlghMJ0UPhrILIsYh3HHu8L0/9sKSpi9JnjAf3DqXvxPQB2hMvaVKSJmL6dT5eiNR
	VSObioiimrWKYXN1Etaam42DzQ69tmw=
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 08 Sep 2026 19:23:36 +0200
Subject: [PATCH batadv 2/3] batman-adv: tt: clarify responsibility for roam
 flag during removal
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260908-sashiko-kdoc-v1-2-535b498f2519@narfation.org>
References: <20260908-sashiko-kdoc-v1-0-535b498f2519@narfation.org>
In-Reply-To: <20260908-sashiko-kdoc-v1-0-535b498f2519@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>, Sashiko <sashiko-bot@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2420; i=sven@narfation.org;
 h=from:subject:message-id; bh=ObKi9B4gvWLPLUs7LUONJb30J58d0KTPXC+lzF+BjBA=;
 b=kA0DAAoWTQ93K9MU9csByyZiAGqgRJ2jlQYMeGtQnwi2buISUM5KPnN3sH6Uo0Sq+FX1JMcri
 Yh1BAAWCgAdFiEEvNRvz7MH7R/zlvHFTQ93K9MU9csFAmqgRJ0ACgkQTQ93K9MU9cu9NwEA26C6
 NW2CWLR1tQEYZyVuIrrxLUxWTI8vsG09/vVX52kBAPN26fC3M2MpoVCtNiIGWKTE5+quVMWq/MB
 /i0N2lmgJ
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: LQL4MLNKO6GWIFNQVSHNGLC4ERYG4TPZ
X-Message-ID-Hash: LQL4MLNKO6GWIFNQVSHNGLC4ERYG4TPZ
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/LQL4MLNKO6GWIFNQVSHNGLC4ERYG4TPZ/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

If an local client gets removed due to an roam, then the local entry must
be marked as "roamed" to handle the rerouting correctly. But this is not
done by batadv_tt_local_remove() directly but by the new helper
batadv_tt_local_mark_removed(). The former will only create similar flags
for the roaming event.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260907081824.2474040-1-sw%40simonwunderlich.de?part=10
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/translation-table.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index b3b9ac59..c0e84ee4 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -1514,7 +1514,10 @@ batadv_tt_local_mark_removed(struct batadv_tt_local_entry *tt_local_entry,
 	scoped_guard(spinlock_bh, &common->flags_lock) {
 		*curr_flags = common->flags;
 
-		/* mark the local client as ROAMed */
+		/* if this global entry addition is due to a roaming, the node
+		 * has to mark the local entry as "roamed" in order to
+		 * correctly reroute packets later
+		 */
 		if (roaming)
 			common->flags |= BATADV_TT_CLIENT_ROAM;
 
@@ -1585,22 +1588,22 @@ u16 batadv_tt_local_remove(struct batadv_priv *bat_priv, const u8 *addr,
 	if (!tt_local_entry)
 		return BATADV_NO_FLAGS;
 
-	flags = BATADV_TT_CLIENT_DEL;
-	/* if this global entry addition is due to a roaming, the node has to
-	 * mark the local entry as "roamed" in order to correctly reroute
-	 * packets later
-	 */
-	if (roaming)
-		flags |= BATADV_TT_CLIENT_ROAM;
+	if (batadv_tt_local_mark_removed(tt_local_entry, roaming, &curr_flags)) {
+		/* queue (roamed) del event which was prepared by
+		 * batadv_tt_local_mark_removed()
+		 */
+		flags = BATADV_TT_CLIENT_DEL;
+		if (roaming)
+			flags |= BATADV_TT_CLIENT_ROAM;
 
-	if (batadv_tt_local_mark_removed(tt_local_entry, roaming, &curr_flags))
 		batadv_tt_local_set_pending_event(bat_priv, tt_local_entry,
 						  flags, message);
-	else
+	} else {
 		/* if this client has been added right now, it is possible to
 		 * immediately purge it
 		 */
 		batadv_tt_local_remove_now(bat_priv, tt_local_entry);
+	}
 
 	batadv_tt_local_entry_put(tt_local_entry);
 

-- 
2.47.3

