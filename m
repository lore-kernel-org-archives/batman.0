Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3B9CC02183
	for <batman-adv@archiver.kernel.org>; Fri, 17 Jan 2025 12:42:17 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 3EBD983FB3
	for <batman-adv@archiver.kernel.org>; Fri, 17 Jan 2025 13:42:16 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1737117736;
 b=4Bmq1aGEirvVD6c6qUY0QGYT9Zia3T9U/Uic6gp1Boga63Y1xMBTEzbyM+sHfxXzUEBdb
 5vkZh+f8DVox9LC2DUWqonoQKznDnvq9V1RTcoe3BRCy8vyhQIXuYtRwUeH5lwaLPVPg937
 zg4V1CWBCdnSbjSELY299RZh60NfCA8=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1737117736; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=0oqPvgJsaAt29bxQ8joByFtcS0KdDVlCuXFru7DUizA=;
 b=UcH8buNJlmpI4o5JB6K+Y3SukM9Ekj7r/1c38BpgUjPKCHvH/QMiKFkBTY8j0LfCFfFTf
 lc8Nv8BVKF+N6rYocYXJ4YVVSd6Hnf15YGykVRi/tRo5k0TDjdxwm8HfDQwqW6hhWWpZw4Z
 ZTw5w3RomZ6q82QpMcCV3X+qGFlBN58=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=fail;
  arc=pass;
  dmarc=fail (Used From Domain Record) header.from=simonwunderlich.de
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass;
 dmarc=fail (Used From Domain Record) header.from=simonwunderlich.de
 policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 9A2A383F21
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 17 Jan 2025 13:39:33 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1737117573;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0oqPvgJsaAt29bxQ8joByFtcS0KdDVlCuXFru7DUizA=;
	b=ZzvVaJTyvdNnFoycSHjdU9il/p3WAgzKM0sINit7qtZt9zNbOGlkSZbBMJ4GFzXWywAgUK
	1QKqzajVa9NYHpqhyOdKPCyBhweE6Gn1WF7RyWhFrjB2kpvJCWhbRFMMKu0i3fwq6Jubsd
	eZGMXE7qE4DSuPWaovEqN7xQRyCz8Qg=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 23.88.38.48 as permitted sender) smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1737117573; a=rsa-sha256;
	cv=none;
	b=kYGLLE8ti3KBNwqw7WGlEqgATO0YDtlWtTZE2gf3z4XFY0zSSWIW3/d0fDyP7A6tFDsVUw
	Fm2MmHPqpBFNlF24Hcr6pgB/UcTX+ZuiXdOzb31eMzWnZIZfGeiOId1+NAEiEEhWqhTffn
	2lBB0i5D21XNpthgj9IN3RBGCcIX9RA=
Received: from kero.packetmixer.de
 (p200300C5973C90D8A96DD71A2E03f697.dip0.t-ipconnect.de
 [IPv6:2003:c5:973c:90d8:a96d:d71a:2e03:f697])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id 3B2D1FA366;
	Fri, 17 Jan 2025 13:39:33 +0100 (CET)
From: Simon Wunderlich <sw@simonwunderlich.de>
To: kuba@kernel.org,
	davem@davemloft.net
Cc: netdev@vger.kernel.org,
	b.a.t.m.a.n@lists.open-mesh.org,
	Remi Pommarel <repk@triplefau.lt>,
	Sven Eckelmann <sven@narfation.org>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 04/10] batman-adv: Don't keep redundant TT change events
Date: Fri, 17 Jan 2025 13:39:04 +0100
Message-Id: <20250117123910.219278-5-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250117123910.219278-1-sw@simonwunderlich.de>
References: <20250117123910.219278-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: XRUECHYU5CPZXAKBARH4OQV2AUU2BVP3
X-Message-ID-Hash: XRUECHYU5CPZXAKBARH4OQV2AUU2BVP3
X-MailFrom: sw@simonwunderlich.de
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/XRUECHYU5CPZXAKBARH4OQV2AUU2BVP3/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Remi Pommarel <repk@triplefau.lt>

When adding a local TT twice within the same OGM interval (e.g. happens
when flag get updated), the flags of the first TT change entry is updated
with the second one and both change events is added to the change list.
This leads to having the same ADD change entry twice. Similarly, a
DEL+DEL scenario is also creating twice the same event.

Deduplicate ADD+ADD or DEL+DEL scenarios to reduce the TT change events
that need to be sent in both OGM and TT response.

Signed-off-by: Remi Pommarel <repk@triplefau.lt>
Co-developed-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/translation-table.c | 40 ++++++++++++++----------------
 1 file changed, 18 insertions(+), 22 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 6e0345b91ece..76d5517bb507 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -438,7 +438,7 @@ static void batadv_tt_local_event(struct batadv_priv *bat_priv,
 
 	del_op_requested = flags & BATADV_TT_CLIENT_DEL;
 
-	/* check for ADD+DEL or DEL+ADD events */
+	/* check for ADD+DEL, DEL+ADD, ADD+ADD or DEL+DEL events */
 	spin_lock_bh(&bat_priv->tt.changes_list_lock);
 	changes = READ_ONCE(bat_priv->tt.local_changes);
 	list_for_each_entry_safe(entry, safe, &bat_priv->tt.changes_list,
@@ -446,30 +446,26 @@ static void batadv_tt_local_event(struct batadv_priv *bat_priv,
 		if (!batadv_compare_eth(entry->change.addr, common->addr))
 			continue;
 
-		/* DEL+ADD in the same orig interval have no effect and can be
-		 * removed to avoid silly behaviour on the receiver side. The
-		 * other way around (ADD+DEL) can happen in case of roaming of
-		 * a client still in the NEW state. Roaming of NEW clients is
-		 * now possible due to automatically recognition of "temporary"
-		 * clients
-		 */
 		del_op_entry = entry->change.flags & BATADV_TT_CLIENT_DEL;
-		if (!del_op_requested && del_op_entry)
-			goto del;
-		if (del_op_requested && !del_op_entry)
-			goto del;
-
-		/* this is a second add in the same originator interval. It
-		 * means that flags have been changed: update them!
-		 */
-		if (!del_op_requested && !del_op_entry)
+		if (del_op_requested != del_op_entry) {
+			/* DEL+ADD in the same orig interval have no effect and
+			 * can be removed to avoid silly behaviour on the
+			 * receiver side. The  other way around (ADD+DEL) can
+			 * happen in case of roaming of  a client still in the
+			 * NEW state. Roaming of NEW clients is now possible due
+			 * to automatically recognition of "temporary" clients
+			 */
+			list_del(&entry->list);
+			kmem_cache_free(batadv_tt_change_cache, entry);
+			changes--;
+		} else {
+			/* this is a second add or del in the same originator
+			 * interval. It could mean that flags have been changed
+			 * (e.g. double add): update them
+			 */
 			entry->change.flags = flags;
+		}
 
-		continue;
-del:
-		list_del(&entry->list);
-		kmem_cache_free(batadv_tt_change_cache, entry);
-		changes--;
 		kmem_cache_free(batadv_tt_change_cache, tt_change_node);
 		goto update_changes;
 	}
-- 
2.39.5

