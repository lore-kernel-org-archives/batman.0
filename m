Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0667AC9830E
	for <batman-adv@archiver.kernel.org>; Sun, 27 Sep 2026 16:22:29 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 2718F84160
	for <batman-adv@archiver.kernel.org>; Sun, 27 Sep 2026 18:22:28 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1790526148;
 b=WPWB5mme/AdUq7VH6kdpu/7vPk86ZB+m/n1sJnkKD3WNf5Ut5WLTuZnPvKH8Y7rG394IT
 Pg+kmO3vRI/kcNzdSrWRfIgUNiphGg9ssJ21Gg5gH4LwsPwJ6EMXtx/5i4Sm1ew3HVU9YWZ
 Fbkfz0QbQ2UoxfVCK6OrJ8E1Y24BMXA=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1790526148; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=DNron6Fy3jLYA41V5/HZVd8/hyn7Vas8fwkQ+9nf3gA=;
 b=kJK2Y98WzdqsHD73ucaxPHEPss/OHZl85H7iUUgfH/abVpunXjhRUUDwNAKG7Xw6YESFk
 bLsJDCSJ8eyptAlQTbbeuq5lsw6vqQm3FPbSDsZfDIXv/yd3oqBhhkUk6yJl/K0oecZTsVy
 W2jYbDNGpSQWEh92LaD2cASOQ0JMowI=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id CFF8581FD6
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 27 Sep 2026 18:21:38 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1790526108;
	b=TegndRXmAv6v4XBVkDLz/zciryYI0ZLb228ULp068VdB+ZJ7TKlFtvNC1bHPhUq9axcZcs
	jVIpNKeaDQkTGa1wNHJmHsCezCiuyJux8zEWf45fRkuSqmU2MntAaKuRoiU9dg0DJlWulk
	D1jmqbi1pt1QEkMuH7Q3cbCPWYbPhxs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1790526108;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=DNron6Fy3jLYA41V5/HZVd8/hyn7Vas8fwkQ+9nf3gA=;
	b=DspzWcSnOkybbHY8HFSkH7pGlJ2TsWNC2hhX6vPt5Puq20GpfzoiKXIEqHn5SjKf2fXzUW
	QIuevDs6wsJPTCUuFMjY9w4vWhIDtY17nvgUsYqfE3ITtZJAUHdr6DivpyIn4XHZZItnEo
	cdjOENfFzD7W4yuHBkYB0GanL1okUtI=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=L8y+Ddne;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org
Received: by dvalin.narfation.org (Postfix) id 637F9206E3;
	Sun, 27 Sep 2026 16:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1790526098;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DNron6Fy3jLYA41V5/HZVd8/hyn7Vas8fwkQ+9nf3gA=;
	b=L8y+DdneO86Z2kOwcyvLmgvc5lYic2Pt0Dd6qryxsglVO5qQ4kFJEMD4SVcIRYI2+Es8bN
	eggqx+jmygKcu3NDbnECAAKzfPHUXBc2cagr8tinfD4LQNqshg24wUtKW4SPtbu8f4jcCX
	etDiXYPNcU7uvHcrpHuM5V2LQqqojMI=
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 27 Sep 2026 18:21:28 +0200
Subject: [PATCH batadv v2 1/2] batman-adv: tt: queue local DEL event under
 bucket lock
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260927-tt-order-local_remove-v2-1-547d8de2e35d@narfation.org>
References: <20260927-tt-order-local_remove-v2-0-547d8de2e35d@narfation.org>
In-Reply-To: <20260927-tt-order-local_remove-v2-0-547d8de2e35d@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>, Sashiko <sashiko-bot@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6036; i=sven@narfation.org;
 h=from:subject:message-id; bh=xnH8xeoVMFRB4IAhTiO8aRzd0lgQ1lVji4doJ5m72ek=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFk7nXq+nVf0X9XMbrqoXO1Y07OF287Hcswq6d+VYtv4v
 Dhp/3e5jlIWBjEuBlkxRZY9V/LPb2Z/K/952sejMHNYmUCGMHBxCsBEfoow/I904dbfxVynlGO0
 MtpFbZrxlN3Tcg65n+OTOqXxN7WJW53hf+yCL9Prdvp+yXFgul9X/G+aGLPItfpbIpctZkY92iS
 2iwsA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: RK7PK6IILBWLXOYHOB7QFWYZA4F6IVMV
X-Message-ID-Hash: RK7PK6IILBWLXOYHOB7QFWYZA4F6IVMV
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/RK7PK6IILBWLXOYHOB7QFWYZA4F6IVMV/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

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

Fixes: ea5a8b4def29 ("batman-adv: tt: use protected flag modifications")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260831135117.574836-1-sw%40simonwunderlich.de?part=12
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/translation-table.c | 64 ++++++++++++++++++++++++++------------
 1 file changed, 44 insertions(+), 20 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index f2377ef6..4c71bf1c 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -1612,13 +1612,20 @@ int batadv_tt_local_dump(struct sk_buff *msg, struct netlink_callback *cb)
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
@@ -1628,20 +1635,37 @@ batadv_tt_local_set_pending_event(struct batadv_priv *bat_priv,
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
@@ -1659,6 +1683,17 @@ batadv_tt_local_mark_removed(struct batadv_tt_local_entry *tt_local_entry,
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
 
@@ -1717,28 +1752,17 @@ u16 batadv_tt_local_remove(struct batadv_priv *bat_priv, const u8 *addr,
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

