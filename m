Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE245CA5FC1
	for <batman-adv@archiver.kernel.org>; Wed, 30 Sep 2026 09:47:46 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 8AEE683FBD
	for <batman-adv@archiver.kernel.org>; Wed, 30 Sep 2026 11:47:45 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1790761665;
 b=TvLC2sgi7fq8KWcHBZ7yYSWg2C+VVvfKKB1oLw4jB84h0XIn7bCD+hIaYtcIuCLFjj0as
 OyEWQBOv2y2WDqlUsTv5d9BRq4ghbb1z3sYp3UoUqsZQtGHd3guITO64ejtfgSURnaP9CmG
 1nXOyOyL3nZnBL+szEmo0vHqvzRsJ/4=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1790761665; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=VXNKA4chhRAf3l6+DCaQ64fVBwcgFd1YVsVFhuwWxXU=;
 b=D7EsQlACtrgjx4o5YSjTiU2NVzTdP3GHpKXiAo/Ejpa4SVm7TUX9JsuV6XNhV2cJEox3c
 1NE2Z+woi5s3h0CbhoYXjIzr4zf7VqT2mS1FNK6QhWe0AH+Qs8Kq6pyke+x477Jfrp5C825
 B041JK2jbApFB1hZOQUGmVOzuOl0A6w=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de
 [IPv6:2a01:4f8:c17:e8c0::1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id E02F880BA6
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 30 Sep 2026 11:46:02 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1790761562;
	b=YnWAqXR+6xBvmd/vMhtpOhJ4y4jHc+5NbD8rH2pVl/BTul7V1XXRsLGMJvZmu4q26FruG5
	cwtMzzpf03vsh9mDEvayWtCAOrzdYF3cQyAcYd4iiPXTYZdRPpShPosAzXUGVg/JDfC+uG
	zQ63Zl1QURRsNwnjAsgBMC2Of7ST1JI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1790761562;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=VXNKA4chhRAf3l6+DCaQ64fVBwcgFd1YVsVFhuwWxXU=;
	b=x79SHLR3lp8qHyybwj1ICJi3TDQDMPfhDQUmfIyGVr7Z7N0FswBT1BbZiEnjoftgJwNMUk
	ZUAK7+CyjprSiClPlJl3CiXiRaFPHr6lWSZGmRJOMKKERUMfN8ZIBGvhGUwx5q1sxs7OQi
	xZk5i0gdrQdC/dgZJfnsOk8p97nmBkw=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=mUO13suY;
	dmarc=pass (policy=none) header.from=simonwunderlich.de;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 2a01:4f8:c17:e8c0::1 as permitted sender) smtp.mailfrom=sw@simonwunderlich.de
Received: from kero.packetmixer.de
 (p200300C5970e81d8Cf20E45A7328d917.dip0.t-ipconnect.de
 [IPv6:2003:c5:970e:81d8:cf20:e45a:7328:d917])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with UTF8SMTPSA id 127CFFA1B0;
	Wed, 30 Sep 2026 11:46:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1790761562;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VXNKA4chhRAf3l6+DCaQ64fVBwcgFd1YVsVFhuwWxXU=;
	b=mUO13suY66lRcQGOhkzd2hN4o0eS/vy7z7w9nrxR23UPnoaqm5f9A+UoTjnXEBHVYfu67I
	+ASbwyok4QK7mJ1ucVhi+SoIu3NBqIu9OuTXZpOGluFq2jCQJjlnEr8ttrXilOIMcgw3xb
	gNBORMcPBMf72CBMfe2KCGji4guaviXzCNtxJOruk2aRk5XHFbRhd6sWhNi+BgLZgUXE6U
	28w3+n6g3Hja7JIfCq0Gc76Nt4I/3jbfoyRr4rivH4TQLeshOKG/cP85+WVMR3gOK/qCtL
	e3edR323tYwcwaztjgF0icsYXgiBcsEYlitwjEjBQ0gCrnFKxAs9NkOoLSaJwg==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Sven Eckelmann <sven@narfation.org>,
	Sashiko <sashiko-bot@kernel.org>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net-next 3/9] batman-adv: tt: clarify responsibility for roam
 flag during removal
Date: Wed, 30 Sep 2026 11:45:52 +0200
Message-ID: <20260930094558.3723766-4-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260930094558.3723766-1-sw@simonwunderlich.de>
References: <20260930094558.3723766-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: S3HSBQFXH36L3E57YWIYVPCZV5TIIAYK
X-Message-ID-Hash: S3HSBQFXH36L3E57YWIYVPCZV5TIIAYK
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/S3HSBQFXH36L3E57YWIYVPCZV5TIIAYK/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Sven Eckelmann <sven@narfation.org>

If an local client gets removed due to an roam, then the local entry must
be marked as "roamed" to handle the rerouting correctly. But this is not
done by batadv_tt_local_remove() directly but by the new helper
batadv_tt_local_mark_removed(). The former will only create similar flags
for the roaming event.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260907081824.2474040-1-sw%40simonwunderlich.de?part=10
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/translation-table.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 6d8fa6d28fee8..78f032c9ad65c 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -1461,7 +1461,10 @@ batadv_tt_local_mark_removed(struct batadv_tt_local_entry *tt_local_entry,
 	scoped_guard(spinlock_bh, &common->flags_lock) {
 		*curr_flags = common->flags;
 
-		/* mark the local client as ROAMed */
+		/* if this global entry addition is due to a roaming, the node
+		 * has to mark the local entry as "roamed" in order to
+		 * correctly reroute packets later
+		 */
 		if (roaming)
 			common->flags |= BATADV_TT_CLIENT_ROAM;
 
@@ -1532,22 +1535,22 @@ u16 batadv_tt_local_remove(struct batadv_priv *bat_priv, const u8 *addr,
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

