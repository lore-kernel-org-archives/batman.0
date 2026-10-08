Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDA12CA600B
	for <batman@archiver.kernel.org>; Thu,  8 Oct 2026 14:32:18 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 2BD5884197
	for <batman@archiver.kernel.org>; Thu, 08 Oct 2026 16:32:17 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1791469937;
 b=TZztcKCayaV+7cG+F77SAzVj1RVFdMxeyGQz6/nfBFYjW6b/dPCQKDkYdQPHX9/j9qVZU
 q0BIN0HemGQPrk8tJ+u/rR7dzgseaGqKYfJZlfuOGf1YNzli9bxB4Td41EtCfDgDwJYUKO6
 TBYDHnPkvkcFAixJyIGIFjLkkEhDi9g=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1791469937; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=UxOrJrxBynLRvSpSKISYg6Tx6jpZETApZrzTnwgHvg4=;
 b=2LPVw3B5kpvko4v50rJ1cjGmh2Dss9LilJXGvPu1xoqnJyY6cd5UMPFtpNBRm8XYynRDp
 WSwDIge72S+pd7jP0tOwbOhc+ZuyXsjoIlNfYTbUYW/YZlHiFiOzI4WOomedttNRHlAEmTT
 fd6q2xeGSFreH/lxsQD0QxT63WyrLt8=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id DFB86841C6
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 08 Oct 2026 16:30:29 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1791469839;
	b=NbZY9C70dMvuTU/aNVh7/U0vHGtpvbWA7uBChhDdyWn4sdNJK7GRjEXhzcIZbVTR6GEpiN
	x7apimU1ufXiUbhW6wmFFmDkdxk6LMpjwkq6HnbVP5rFHRUm/IhQ3vKhm8SWyxEWGrlbCG
	iTQhWp0+YsfMkn3t5H7hg2kdAtThkcE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1791469839;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=UxOrJrxBynLRvSpSKISYg6Tx6jpZETApZrzTnwgHvg4=;
	b=WDHh8jvhswX76iN/R9Gh8oGG56n2yFxPBCyvQhk0AlcTzoU/5D0SoeKOy9zZ0yKrwBEp9Z
	xHrSwF0wO/zmWOXC/AD4PALdhwAtbBYauu6jYZ7UDadbcMyS7aHvvgyusdbgfKAgQpcLeU
	uhM2H4VLJd8M5PFqQS4IWxYeav+RpAA=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=eN8XtoWI;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 3FB7B20558;
	Thu, 08 Oct 2026 14:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1791469829;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UxOrJrxBynLRvSpSKISYg6Tx6jpZETApZrzTnwgHvg4=;
	b=eN8XtoWIT/9ny1QVRYHh3IP9W4FzK4ZE7FhDy77P6meW4v/j0J7lsoD1qsi04KE9nD/22J
	YdBTlwVvsFfQYru5LVzwC+ORDqzM40J6MJTms90ir/osoZra6hNsTQFVEGJewJZURldCVU
	CiMBtmPosOmNaO1Sob/DRrrZXmbYPzY=
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 08 Oct 2026 16:30:07 +0200
Subject: [PATCH batadv v2 2/8] batman-adv: tt: clear ROAM flag when
 re-adding a pending local client
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261008-tt-avoid-unhashed-event-v2-2-7c4eed81606d@narfation.org>
References: <20261008-tt-avoid-unhashed-event-v2-0-7c4eed81606d@narfation.org>
In-Reply-To: 
 <20261008-tt-avoid-unhashed-event-v2-0-7c4eed81606d@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2003; i=sven@narfation.org;
 h=from:subject:message-id; bh=MEpxLzFQDNlLT9k8me+ghBkmb19agsMmc/NrICYrnd8=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFnHV3xgvJVRfmVBnU2t/prtKnMvh9+yS6zfY62/qP55o
 PV2z4cRHaUsDGJcDLJiiix7ruSf38z+Vv7ztI9HYeawMoEMYeDiFICJuM1iZFhWZzb9IluDusJm
 6cBfJ48f2JLInTL3t8Pfg8mL+RWvR5gy/C/Ruz3p8oRL/+aYqidnvprx5rPUk5UNIU9muiyf/Vx
 umg83AA==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: GJV53WOWFFASPKG3TDDSJ3O5RFYQUH2D
X-Message-ID-Hash: GJV53WOWFFASPKG3TDDSJ3O5RFYQUH2D
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/GJV53WOWFFASPKG3TDDSJ3O5RFYQUH2D/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

When a ROAMING_ADV is received for an announced local client,
batadv_tt_local_mark_removed() sets BATADV_TT_CLIENT_ROAM, queues a
DEL|ROAM change and marks the entry as BATADV_TT_CLIENT_PENDING. If the
client sends a frame again before the next TTVN commit,
batadv_tt_local_add_existing() only clears the PENDING flag and returns
early. The ADD cancels the queued DEL, but the entry keeps the ROAM flag:

* batadv_is_my_client() reports the client as not served by this node
* batadv_tt_local_client_is_roaming() reroutes unicast frames for it to
  the node which sent the ROAMING_ADV

The ROAM flag is only removed with the next frame of the client.

Since BATADV_TT_CLIENT_ROAM is set together with BATADV_TT_CLIENT_PENDING,
it has to be cleared also at the same time with BATADV_TT_CLIENT_PENDING
when the client roamed back.

Fixes: 2443ba383c7d ("batman-adv: roaming handling mechanism redesign")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/translation-table.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 40f2138e..2ead3643 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -947,6 +947,7 @@ static bool batadv_tt_local_add_existing(struct batadv_priv *bat_priv,
 					 bool *roamed_back)
 {
 	struct batadv_tt_common_entry *common = &tt_local->common;
+	bool readded = false;
 
 	tt_local->last_seen = jiffies;
 
@@ -961,8 +962,7 @@ static bool batadv_tt_local_add_existing(struct batadv_priv *bat_priv,
 			 * flag can be reset like it was never enqueued
 			 */
 			common->flags &= ~BATADV_TT_CLIENT_PENDING;
-
-			return true;
+			readded = true;
 		}
 
 		if (common->flags & BATADV_TT_CLIENT_ROAM) {
@@ -979,7 +979,7 @@ static bool batadv_tt_local_add_existing(struct batadv_priv *bat_priv,
 		}
 	}
 
-	return false;
+	return readded;
 }
 
 /**

-- 
2.47.3

