Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8357FC61DE1
	for <batman-adv@archiver.kernel.org>; Sun, 30 Aug 2026 15:32:49 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id E9D2A802F0
	for <batman-adv@archiver.kernel.org>; Sun, 30 Aug 2026 17:32:47 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1788103967;
 b=LJ9vAGQYGRtMu8Vs5Mw3RHWgcmsZII1FweFE6MxLuWt3P8l1Ut/Ve8303H2yPlgdiQvG5
 v5vvilBxNYvDrL6mW1/Is0fgNVpHYsEg4i495ZqssR7Fu1YVpO2LpwjKJeP6QYBhNIpFJ4+
 9qtr+4b306OhszGXUF1f3ApUW6VZMOs=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1788103967; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=WHL4Xbm/6Dow9m6fIJl0V8dyq6FJRJ4VYME1QD/cEns=;
 b=jjijQPNepnajAngvuK4KxyLjNCLi7oH6BOwc+3vXG536HiObePzAlaa+dx7aXuEmlicfQ
 7SmNOsp/YZYDGR0/bIDa1eHLE3LARs5+KGZ9rj/SUaocyuqXMFsXMjXab2hXplEOMGv9f02
 IY69nWZ+/xf6ok6whGtW1aUQ3gr/+rQ=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 5D4C5803EA
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 30 Aug 2026 17:23:21 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1788103401;
	b=SPHXz4RfU06lJY6tV6HgRmed4AsbT0I1iqPCcDqbFVgUVkDv/gvGYfyJUc/HZDOPH875L0
	VOkyQBY7thZepe0ss9L5g8Me3qKqnCgbdDQzxPuG2fTOVsjVtUoOpUlHGkAw4WuQhXE6ek
	YPCRqyev1YJ1VZ8H0bYusbE69svtwhU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1788103401;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=WHL4Xbm/6Dow9m6fIJl0V8dyq6FJRJ4VYME1QD/cEns=;
	b=2CgWBP5sNjvw89Id8vomqc/6XLl6VTS2En83Y36QUeM7j7gyngJJV2d0Y7OM+Ta/47Bk1t
	H0CHUyInfAOaC7jQxRU1cwzFVU+rW/DUGCa+q/dwQ4v9d8iP89pA4RgUp5I/Gdwlz58DNp
	40DkfG5T6DzliVVJxkDhl/dXyPNVvEg=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=iWhXG+I0;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id E46292083E;
	Sun, 30 Aug 2026 15:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1788103397;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WHL4Xbm/6Dow9m6fIJl0V8dyq6FJRJ4VYME1QD/cEns=;
	b=iWhXG+I0FTe595aoVA1GF4XcrLSuEoBJp3D8+wpLSWg71/6HeapN9pFDIrbiS4i5QfOgwe
	OTn1t4jsAWJN+fc/UJ9N+i0T59fCnsouEhnCgLsiiacD1ZDrnMWLCgCsfa8hsipE19PQiL
	ARGWKH93HI4q/RTx7o7KB+yyykL6TDs=
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 30 Aug 2026 17:21:57 +0200
Subject: [PATCH batadv v6 20/20] batman-adv: tt: drop the cleanup label
 from batadv_tt_local_remove()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260830-tt-fixes-v6-20-a56568a15041@narfation.org>
References: <20260830-tt-fixes-v6-0-a56568a15041@narfation.org>
In-Reply-To: <20260830-tt-fixes-v6-0-a56568a15041@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2227; i=sven@narfation.org;
 h=from:subject:message-id; bh=nOnYh8MUSFXeHsobEEjTvQsYiFgUSmvQ9DYyoYbTPFs=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFlTvDq0l6iV264veP/9UXSYTyav+2bN8+rT9au5VXKPi
 yvnV3R1lLIwiHExyIopsuy5kn9+M/tb+c/TPh6FmcPKBDKEgYtTACbC/oyRYWrM6aWzK1dU+Cay
 c10wsIwXs+58ZXA22ez7tNiPfsKfvjP80w2/+WPZU90F12bK2Z674coh+fobH+MDYcGq7p3SrCt
 lOQA=
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: NXEYAET74YVLPAU45BP5JZJGGWRMLWYZ
X-Message-ID-Hash: NXEYAET74YVLPAU45BP5JZJGGWRMLWYZ
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/NXEYAET74YVLPAU45BP5JZJGGWRMLWYZ/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

With both locked sections moved to their own helpers, the only thing left
in the cleanup section is the reference of the looked up entry. The "out"
label is therefore only reached with a valid entry, except for the lookup
failure at the very beginning.

Return BATADV_NO_FLAGS directly when there is no entry and let the two
remaining cases be an if/else.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/translation-table.c | 26 ++++++++++----------------
 1 file changed, 10 insertions(+), 16 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index e5680da6..1a98b98c 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -1579,13 +1579,12 @@ u16 batadv_tt_local_remove(struct batadv_priv *bat_priv, const u8 *addr,
 			   bool roaming)
 {
 	struct batadv_tt_local_entry *tt_local_entry;
-	u16 curr_flags = BATADV_NO_FLAGS;
-	bool pending = false;
+	u16 curr_flags;
 	u16 flags;
 
 	tt_local_entry = batadv_tt_local_hash_find(bat_priv, addr, vid);
 	if (!tt_local_entry)
-		goto out;
+		return BATADV_NO_FLAGS;
 
 	flags = BATADV_TT_CLIENT_DEL;
 	/* if this global entry addition is due to a roaming, the node has to
@@ -1595,20 +1594,15 @@ u16 batadv_tt_local_remove(struct batadv_priv *bat_priv, const u8 *addr,
 	if (roaming)
 		flags |= BATADV_TT_CLIENT_ROAM;
 
-	pending = batadv_tt_local_mark_removed(tt_local_entry, roaming,
-					       &curr_flags);
-	if (pending) {
-		batadv_tt_local_set_pending_event(bat_priv, tt_local_entry, flags,
-						  message);
-		goto out;
-	}
+	if (batadv_tt_local_mark_removed(tt_local_entry, roaming, &curr_flags))
+		batadv_tt_local_set_pending_event(bat_priv, tt_local_entry,
+						  flags, message);
+	else
+		/* if this client has been added right now, it is possible to
+		 * immediately purge it
+		 */
+		batadv_tt_local_remove_now(bat_priv, tt_local_entry);
 
-	/* if this client has been added right now, it is possible to
-	 * immediately purge it
-	 */
-	batadv_tt_local_remove_now(bat_priv, tt_local_entry);
-
-out:
 	batadv_tt_local_entry_put(tt_local_entry);
 
 	return curr_flags;

-- 
2.47.3

