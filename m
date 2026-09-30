Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2075CA5FB1
	for <batman-adv@archiver.kernel.org>; Wed, 30 Sep 2026 09:49:24 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 6FBF180BA6
	for <batman-adv@archiver.kernel.org>; Wed, 30 Sep 2026 11:49:23 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1790761763;
 b=SjyH72z30oc1AV/Rem3x/UYlMhi6GgkZxjH392LrR8pSkm8wLjyJqWXi8nnfTrtM7+d9z
 YqwVdlpJEwWrOvdi06eCwaar8NIICx1F9jQFy/QLLf4aiEeZLXsc/ifhS2VqWt0OJtt4KcG
 4bi/KjxtCCPUFLCMZ8r6A0E4hGv8W3Y=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1790761763; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=xpUDnDNr5EDr1Ex9CDNfROxOitPoJ2GkstzUeV1sj1o=;
 b=Zm0xqTHxHiwTvoCJw2goSlp8rY+l+it8JFvzUJ3RmLj/jf8j479vrlES8kB6a9JIbJAD7
 xTTsNstSwJ0z4Bvyt+p6HNULoZQioUL6q7IYj2lWXlJulKz1Q75xcQJNCwRH8xxOXkctyg5
 U4qlIMTeKhnLrgS/ItA+hCOLXi6ySBE=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 69FEE83AF6
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 30 Sep 2026 11:46:05 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1790761565;
	b=eydtK19aGRW03ju8hAfuBUcc1gz5edgCyXamNqOQf9SN5HSilaOaDnI3+Sv2pIrsvUa726
	1OP3FnVRMLGeWmtzL6muA/49hvmuI9Br2O26clsosuAMYqmSr5FyrXUfCitwobDOPjOy9E
	f0oYEYZHGzC2GyvXABSATJZAk7yRuNE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1790761565;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=xpUDnDNr5EDr1Ex9CDNfROxOitPoJ2GkstzUeV1sj1o=;
	b=WA3VBSCQzA3qkzkts4ZGgJ5aUmsgME4KjVPZcH9xHn8CICk0jDguwgWGtc/kLmfu/OIX9Y
	5jjwPBdCbSdhrT9CkMqTLHNE2DqZ8Xxzp8TulMxNKoHJlduL5kdf/Nzyx7PSrXfsIlhJmd
	InAmFObs/c8BKI1JIf7h3sGGLpLRnuQ=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=H1DfL4nj;
	dmarc=pass (policy=none) header.from=simonwunderlich.de;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 23.88.38.48 as permitted sender) smtp.mailfrom=sw@simonwunderlich.de
Received: from kero.packetmixer.de
 (p200300C5970E81D8cF20E45a7328D917.dip0.t-ipconnect.de
 [IPv6:2003:c5:970e:81d8:cf20:e45a:7328:d917])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with UTF8SMTPSA id 02DE6FA1B3;
	Wed, 30 Sep 2026 11:46:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1790761565;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xpUDnDNr5EDr1Ex9CDNfROxOitPoJ2GkstzUeV1sj1o=;
	b=H1DfL4nj/6nEmqXsf3vjoDMYNXkbfuJ5ZLQNpeNqGEwN0YjplS6ebsmNbNnM9j3/znrU6s
	TWD1W1YvacAfuEUPtauZzWdNRbp+ZCdJlCqh8R7amdIxCcNvZLhAYyuS01dOIVAhjeRDlv
	hWk2WR73IRuDC3VSyeQT3ZYgMuPGrnYBa1xbiJYakKDha3VOCmTi62RskGnBg3llXYnTBq
	x8iU/gddmf+seHafuVKju3PQvLdSR3GWzv4O/dfGjufft10iQVseGIf6AOAICDV4aXQ1k6
	6tUAj3F0ibQBXdE+RDd8VbpOIA4G4Kgd7AetsCHyUMzaQ3M2pnwYsLZN7QQzNA==
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
Subject: [PATCH net-next 6/9] batman-adv: tt: queue local DEL event under
 bucket lock
Date: Wed, 30 Sep 2026 11:45:55 +0200
Message-ID: <20260930094558.3723766-7-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260930094558.3723766-1-sw@simonwunderlich.de>
References: <20260930094558.3723766-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: LUR5MRMPTTYZFVD7D6WOU4CWPCCX3IOQ
X-Message-ID-Hash: LUR5MRMPTTYZFVD7D6WOU4CWPCCX3IOQ
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/LUR5MRMPTTYZFVD7D6WOU4CWPCCX3IOQ/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Sven Eckelmann <sven@narfation.org>

batadv_tt_local_remove() sets BATADV_TT_CLIENT_PENDING on an already
announced local entry and only afterwards queues the DEL change event. It
holds neither the hash bucket list_lock nor bat_priv->tt.commit_lock.

It can therefore be potentially interrupted in the middle:

  CPU0                          CPU1
  batadv_tt_local_remove()
    flags |= ..._PENDING;
                                batadv_tt_local_commit_changes()
                                  ..._purge_pending_clients()
                                    hlist_del_rcu(&...->hash_entry);
                                  batadv_tt_local_update_crc()
                                  atomic_inc(&bat_priv->tt.vn);
    batadv_tt_local_event()
    /* DEL queued only now */

The client then disappears from the local table and from the CRC of the new
TTVN after batadv_tt_local_commit_changes() without a DEL change being
announced for it. Neighbours receiving the new CRC without previously
seeing the DEL will try to recover via a full table request.

Move the event into batadv_tt_local_mark_removed() and hold the bucket
list_lock of the entry around both the flag change and the DEL event to
avoid this scenario.

Fixes: 976b159b3c12 ("batman-adv: tt: use protected flag modifications")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260831135117.574836-1-sw%40simonwunderlich.de?part=12
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/translation-table.c | 64 ++++++++++++++++++++----------
 1 file changed, 44 insertions(+), 20 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index c904d67791f8f..c229c51cafa72 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -1427,13 +1427,20 @@ int batadv_tt_local_dump(struct sk_buff *msg, struct netlink_callback *cb)
  * @message: debug message describing the reason for the change
  *
  * Schedule the TT change announcement for the entry. The caller must already
- * have added BATADV_TT_CLIENT_PENDING to the @tt_local_entry
+ * have added BATADV_TT_CLIENT_PENDING to the @tt_local_entry and must hold the
+ * hash bucket list_lock of @tt_local_entry since setting the flag.
  */
 static void
 batadv_tt_local_set_pending_event(struct batadv_priv *bat_priv,
 				  struct batadv_tt_local_entry *tt_local_entry,
 				  u16 flags, const char *message)
 {
+	struct batadv_hashtable *hash = bat_priv->tt.local_hash;
+	u32 i;
+
+	i = batadv_choose_tt(&tt_local_entry->common, hash->size);
+	lockdep_assert_held(&hash->list_locks[i]);
+
 	batadv_tt_local_event(bat_priv, tt_local_entry, flags);
 
 	batadv_dbg(BATADV_DBG_TT, bat_priv,
@@ -1443,20 +1450,37 @@ batadv_tt_local_set_pending_event(struct batadv_priv *bat_priv,
 }
 
 /**
- * batadv_tt_local_mark_removed() - mark a local entry as removed
+ * batadv_tt_local_mark_removed() - mark a local entry as removed and queue DEL
+ * @bat_priv: the bat priv with all the mesh interface information
  * @tt_local_entry: local TT entry to mark
+ * @message: message to append to the log on deletion
  * @roaming: true if the deletion is due to a roaming event
  * @curr_flags: pointer to store the flags of the entry before it was marked
  *
+ * An already announced entry is marked as BATADV_TT_CLIENT_PENDING and the
+ * (roamed) DEL change is queued. Both happen under the hash bucket list_lock
+ * of the entry to prevent concurrent batadv_tt_local_purge_pending_clients()
+ * from removing the entry.
+ *
  * Return: true if the entry has to be kept in the local table until the next
  * ttvn increment, false if it can be purged immediately.
  */
 static bool
-batadv_tt_local_mark_removed(struct batadv_tt_local_entry *tt_local_entry,
-			     bool roaming, u16 *curr_flags)
+batadv_tt_local_mark_removed(struct batadv_priv *bat_priv,
+			     struct batadv_tt_local_entry *tt_local_entry,
+			     const char *message, bool roaming, u16 *curr_flags)
 {
+	spinlock_t *list_lock; /* protects write access to the hash lists */
 	struct batadv_tt_common_entry *common = &tt_local_entry->common;
+	struct batadv_hashtable *hash = bat_priv->tt.local_hash;
 	bool pending = false;
+	u16 flags;
+	u32 i;
+
+	i = batadv_choose_tt(common, hash->size);
+	list_lock = &hash->list_locks[i];
+
+	spin_lock_bh(list_lock);
 
 	scoped_guard(spinlock_bh, &common->flags_lock) {
 		*curr_flags = common->flags;
@@ -1474,6 +1498,17 @@ batadv_tt_local_mark_removed(struct batadv_tt_local_entry *tt_local_entry,
 		}
 	}
 
+	if (pending) {
+		flags = BATADV_TT_CLIENT_DEL;
+		if (roaming)
+			flags |= BATADV_TT_CLIENT_ROAM;
+
+		batadv_tt_local_set_pending_event(bat_priv, tt_local_entry,
+						  flags, message);
+	}
+
+	spin_unlock_bh(list_lock);
+
 	return pending;
 }
 
@@ -1532,28 +1567,17 @@ u16 batadv_tt_local_remove(struct batadv_priv *bat_priv, const u8 *addr,
 {
 	struct batadv_tt_local_entry *tt_local_entry;
 	u16 curr_flags;
-	u16 flags;
 
 	tt_local_entry = batadv_tt_local_hash_find(bat_priv, addr, vid);
 	if (!tt_local_entry)
 		return BATADV_NO_FLAGS;
 
-	if (batadv_tt_local_mark_removed(tt_local_entry, roaming, &curr_flags)) {
-		/* queue (roamed) del event which was prepared by
-		 * batadv_tt_local_mark_removed()
-		 */
-		flags = BATADV_TT_CLIENT_DEL;
-		if (roaming)
-			flags |= BATADV_TT_CLIENT_ROAM;
-
-		batadv_tt_local_set_pending_event(bat_priv, tt_local_entry,
-						  flags, message);
-	} else {
-		/* if this client has been added right now, it is possible to
-		 * immediately purge it
-		 */
+	/* if this client has been added right now, it is possible to
+	 * immediately purge it
+	 */
+	if (!batadv_tt_local_mark_removed(bat_priv, tt_local_entry, message,
+					  roaming, &curr_flags))
 		batadv_tt_local_remove_now(bat_priv, tt_local_entry);
-	}
 
 	batadv_tt_local_entry_put(tt_local_entry);
 
-- 
2.47.3

