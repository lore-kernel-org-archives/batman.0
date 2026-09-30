Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 044D5CA5FC1
	for <batman-adv@archiver.kernel.org>; Wed, 30 Sep 2026 09:49:56 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 69E3683BE2
	for <batman-adv@archiver.kernel.org>; Wed, 30 Sep 2026 11:49:54 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1790761794;
 b=taTmU8KcPKhXE4MGBZQAYzRQP/3UCxLQuHzDb9A/oB1I0iPq2G0+pmpoGgkx9ot0M4iVA
 O4kQlsV9KxfgtKhToR0ViLTT7FcWDjNw6+AxCgovGnmHKqdxIBabphNPg/NrXfmBCA2D0Ax
 iAADoaE74PkWjuub4Ao1eEVYHNA7fjY=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1790761794; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=4KijHBqujEiCmva7gP2FYY4DFFU9m83/MQ1MEy2EOsA=;
 b=jWGmvrid8Iwld6a381W9Z1JUZfDGyiDb21bfpZJdSy4Zvtjjdz/yN6ZqecDsK98Tvttd/
 AV1ww0Tz2fICagwsXrOI2FCX2pmsTKsFK5CeuylGSB9Yt2m3rhMMh4hwjIrbTcAzgsbftoE
 K/sPVOFf2Pu/v9/BnV1H7Nr8J6fEXHQ=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de
 [IPv6:2a01:4f8:c17:e8c0::1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 645F88258E
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 30 Sep 2026 11:46:06 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1790761566;
	b=kZ7nHu6D8oaZRxgVcJgP9HgMmjAKzsqWSCMbq9SmQcMrI9vNjzT3HH7SG6iE+HbnQJpJVa
	zVmIOR9LYhOtaPizkK3vL337jdWHImDo7ERlDv0Jlh7fTEcImVV+FEdmnar6E9FN3zm452
	xkHUWatrg/dzdcbRCpJDEnuPB+QYyPE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1790761566;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=4KijHBqujEiCmva7gP2FYY4DFFU9m83/MQ1MEy2EOsA=;
	b=o4nC2ToGYPE375n8r0IKAeJdgJkzTQjFjk6ieE9ADltimxfJKz/H6DFBEl/eWbWw/HZUCF
	TP6Dkfurwd7eTIjStvGm2ViNLA7pZvoahy7oGVn4RUNLZKfxhTROVfyz9bA7AgSfHe2BsT
	ElZhmOYGiU/ceKswbOD9GOaR9O5r1NQ=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=IFLsV1kp;
	dmarc=pass (policy=none) header.from=simonwunderlich.de;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 2a01:4f8:c17:e8c0::1 as permitted sender) smtp.mailfrom=sw@simonwunderlich.de
Received: from kero.packetmixer.de
 (p200300C5970E81D8CF20e45A7328D917.dip0.t-ipconnect.de
 [IPv6:2003:c5:970e:81d8:cf20:e45a:7328:d917])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with UTF8SMTPSA id AB4DFFA1B6;
	Wed, 30 Sep 2026 11:46:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1790761565;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4KijHBqujEiCmva7gP2FYY4DFFU9m83/MQ1MEy2EOsA=;
	b=IFLsV1kpm6tUDuZCBUAE1F8i1GL08p9iukg0+zVHCapPzUm9ekvJSjdyDtIgykxgh9SZyR
	b09ZWvpPe5GCfAjWHMYnHMmOmgqeUawpgJANu/+pGy8vtl+/Lxh3JEnEcLoFY0Rc/mx61T
	M71O6B0rDd5uArwNA8PdUYbhDPVs87n8+GE9Hy26K5P5CSKkTA/hLONTyg4ljLoDzLtt6/
	YT+q+ACiuo42yhbGEyGdP5YOn9s2v5owrBt60/8sxXzVAQ5oV7zbBo5yppav5pDYe+51Ko
	MsN4GdQP/zrlgacgQQH7JUHTr4FIu4HwoYBoJEjz1L9jzlllK/GxyraJqwn+lA==
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
Subject: [PATCH net-next 7/9] batman-adv: tt: queue local DEL event before
 marking entry as pending
Date: Wed, 30 Sep 2026 11:45:56 +0200
Message-ID: <20260930094558.3723766-8-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260930094558.3723766-1-sw@simonwunderlich.de>
References: <20260930094558.3723766-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: Y4HNH4QHUF2ITDIJYZ2FMNKNITARHYXR
X-Message-ID-Hash: Y4HNH4QHUF2ITDIJYZ2FMNKNITARHYXR
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/Y4HNH4QHUF2ITDIJYZ2FMNKNITARHYXR/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Sven Eckelmann <sven@narfation.org>

batadv_tt_local_set_pending() originally queued the DEL change event and
only afterwards set BATADV_TT_CLIENT_PENDING on the local entry. Commit
976b159b3c12 ("batman-adv: tt: use protected flag modifications") inverted
this order for batadv_tt_local_remove() and batadv_tt_local_purge_list().

The hash bucket list_lock held around both steps does not help against
batadv_tt_local_add_existing() because it is not holding it.

  CPU0                          CPU1
  flags |= ..._PENDING;
                                batadv_tt_local_add_existing()
                                  flags &= ~..._PENDING;
                                batadv_tt_local_event(ADD)
  batadv_tt_local_event(DEL)

If the ADD was already announced by a commit in between, the DEL is sent in
the next TTVN although the entry is no longer pending (after
batadv_tt_local_add_existing()) and the local entry was never purged. The
incorrect DEL will corrupt the CRC on neighbor nodes. A full table sync
request is therefore issued to resolve this problem.

When the DEL event is queued before the flag is set, a
batadv_tt_local_add_existing() which clears the flag afterwards queues its
ADD behind the DEL, and both cancel each other out.

But the check whether an entry has to be removed must not be separated (by
using two different critial flags_lock sections) from setting the flag (in
batadv_tt_local_event) either. Otherwise batadv_tt_local_add_existing()
could refresh the entry between both steps without queuing an ADD, and an
active client would be announced as removed and purged.

Fixes: 976b159b3c12 ("batman-adv: tt: use protected flag modifications")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260831135117.574836-1-sw%40simonwunderlich.de?part=12
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/translation-table.c | 102 ++++++++++++++++-------------
 1 file changed, 55 insertions(+), 47 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index c229c51cafa72..481dc6afaaba1 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -461,23 +461,21 @@ static u16 batadv_tt_flags_get(struct batadv_tt_common_entry *common)
 }
 
 /**
- * batadv_tt_local_event() - store a local TT event (ADD/DEL)
+ * __batadv_tt_local_event() - store a local TT event (ADD/DEL) with given flags
  * @bat_priv: the bat priv with all the mesh interface information
- * @tt_local_entry: the TT entry involved in the event
- * @event_flags: flags to store in the event structure
+ * @common: the TT entry involved in the event
+ * @flags: flags of the TT entry combined with the event flags
  */
-static void batadv_tt_local_event(struct batadv_priv *bat_priv,
-				  struct batadv_tt_local_entry *tt_local_entry,
-				  u8 event_flags)
+static void __batadv_tt_local_event(struct batadv_priv *bat_priv,
+				    const struct batadv_tt_common_entry *common,
+				    u8 flags)
 {
-	struct batadv_tt_common_entry *common = &tt_local_entry->common;
 	struct batadv_tt_change_node *tt_change_node;
 	struct batadv_tt_change_node *entry;
 	struct batadv_tt_change_node *safe;
 	bool del_op_requested;
 	bool del_op_entry;
 	size_t changes;
-	u8 flags;
 
 	tt_change_node = kmem_cache_alloc(batadv_tt_change_cache, GFP_ATOMIC);
 	if (!tt_change_node)
@@ -488,8 +486,6 @@ static void batadv_tt_local_event(struct batadv_priv *bat_priv,
 	ether_addr_copy(tt_change_node->change.addr, common->addr);
 	tt_change_node->change.vid = htons(common->vid);
 
-	flags = batadv_tt_flags_get(common) | event_flags;
-
 	tt_change_node->change.flags = flags;
 	del_op_requested = flags & BATADV_TT_CLIENT_DEL;
 
@@ -537,6 +533,23 @@ static void batadv_tt_local_event(struct batadv_priv *bat_priv,
 	spin_unlock_bh(&bat_priv->tt.changes_list_lock);
 }
 
+/**
+ * batadv_tt_local_event() - store a local TT event (ADD/DEL)
+ * @bat_priv: the bat priv with all the mesh interface information
+ * @tt_local_entry: the TT entry involved in the event
+ * @event_flags: flags to store in the event structure
+ */
+static void batadv_tt_local_event(struct batadv_priv *bat_priv,
+				  struct batadv_tt_local_entry *tt_local_entry,
+				  u8 event_flags)
+{
+	struct batadv_tt_common_entry *common = &tt_local_entry->common;
+	u8 flags;
+
+	flags = batadv_tt_flags_get(common) | event_flags;
+	__batadv_tt_local_event(bat_priv, common, flags);
+}
+
 /**
  * batadv_tt_len() - compute length in bytes of given number of tt changes
  * @changes_num: number of tt changes
@@ -1420,28 +1433,37 @@ int batadv_tt_local_dump(struct sk_buff *msg, struct netlink_callback *cb)
 }
 
 /**
- * batadv_tt_local_set_pending_event() - trigger events for TT pending removal
+ * batadv_tt_local_set_pending() - mark local TT entry as pending removal
  * @bat_priv: the bat priv with all the mesh interface information
- * @tt_local_entry: local TT entry which was marked as BATADV_TT_CLIENT_PENDING
+ * @tt_local_entry: local TT entry to mark as BATADV_TT_CLIENT_PENDING
  * @flags: TT change flags to announce together with the pending removal
  * @message: debug message describing the reason for the change
  *
- * Schedule the TT change announcement for the entry. The caller must already
- * have added BATADV_TT_CLIENT_PENDING to the @tt_local_entry and must hold the
- * hash bucket list_lock of @tt_local_entry since setting the flag.
+ * Schedule the TT change announcement and set BATADV_TT_CLIENT_PENDING on the
+ * entry. The entry is kept in the local table until the next TTVN increment
+ * so that a consistency-check response can still be answered.
+ *
+ * Next to the flags_lock of the entry, the caller must hold the hash bucket
+ * list_lock of @tt_local_entry. Otherwise
+ * batadv_tt_local_purge_pending_clients() could remove the entry before its
+ * change was queued.
  */
 static void
-batadv_tt_local_set_pending_event(struct batadv_priv *bat_priv,
-				  struct batadv_tt_local_entry *tt_local_entry,
-				  u16 flags, const char *message)
+batadv_tt_local_set_pending(struct batadv_priv *bat_priv,
+			    struct batadv_tt_local_entry *tt_local_entry,
+			    u16 flags, const char *message)
+	__must_hold(&tt_local_entry->common.flags_lock)
 {
+	struct batadv_tt_common_entry *common = &tt_local_entry->common;
 	struct batadv_hashtable *hash = bat_priv->tt.local_hash;
 	u32 i;
 
-	i = batadv_choose_tt(&tt_local_entry->common, hash->size);
+	i = batadv_choose_tt(common, hash->size);
 	lockdep_assert_held(&hash->list_locks[i]);
+	lockdep_assert_held(&common->flags_lock);
 
-	batadv_tt_local_event(bat_priv, tt_local_entry, flags);
+	__batadv_tt_local_event(bat_priv, common, common->flags | flags);
+	common->flags |= BATADV_TT_CLIENT_PENDING;
 
 	batadv_dbg(BATADV_DBG_TT, bat_priv,
 		   "Local tt entry (%pM, vid: %d) pending to be removed: %s\n",
@@ -1460,7 +1482,8 @@ batadv_tt_local_set_pending_event(struct batadv_priv *bat_priv,
  * An already announced entry is marked as BATADV_TT_CLIENT_PENDING and the
  * (roamed) DEL change is queued. Both happen under the hash bucket list_lock
  * of the entry to prevent concurrent batadv_tt_local_purge_pending_clients()
- * from removing the entry.
+ * from removing the entry and batadv_tt_local_transition_new() from clearing
+ * BATADV_TT_CLIENT_NEW after it was checked.
  *
  * Return: true if the entry has to be kept in the local table until the next
  * ttvn increment, false if it can be purged immediately.
@@ -1492,19 +1515,16 @@ batadv_tt_local_mark_removed(struct batadv_priv *bat_priv,
 		if (roaming)
 			common->flags |= BATADV_TT_CLIENT_ROAM;
 
-		if (!(common->flags & BATADV_TT_CLIENT_NEW)) {
-			common->flags |= BATADV_TT_CLIENT_PENDING;
-			pending = true;
-		}
-	}
+		if (common->flags & BATADV_TT_CLIENT_NEW)
+			break;
 
-	if (pending) {
 		flags = BATADV_TT_CLIENT_DEL;
 		if (roaming)
 			flags |= BATADV_TT_CLIENT_ROAM;
 
-		batadv_tt_local_set_pending_event(bat_priv, tt_local_entry,
-						  flags, message);
+		batadv_tt_local_set_pending(bat_priv, tt_local_entry, flags,
+					    message);
+		pending = true;
 	}
 
 	spin_unlock_bh(list_lock);
@@ -1601,37 +1621,25 @@ static void batadv_tt_local_purge_list(struct batadv_priv *bat_priv,
 
 	hlist_for_each_entry_safe(tt_common_entry, node_tmp, head,
 				  hash_entry) {
-		bool cont = false;
-
 		tt_local_entry = container_of(tt_common_entry,
 					      struct batadv_tt_local_entry,
 					      common);
 
 		scoped_guard(spinlock_bh, &tt_local_entry->common.flags_lock) {
-			if (tt_local_entry->common.flags & BATADV_TT_CLIENT_NOPURGE) {
-				cont = true;
+			if (tt_local_entry->common.flags & BATADV_TT_CLIENT_NOPURGE)
 				break;
-			}
 
 			/* entry already marked for deletion */
-			if (tt_local_entry->common.flags & BATADV_TT_CLIENT_PENDING) {
-				cont = true;
+			if (tt_local_entry->common.flags & BATADV_TT_CLIENT_PENDING)
 				break;
-			}
 
-			if (!batadv_has_timed_out(tt_local_entry->last_seen, timeout)) {
-				cont = true;
+			if (!batadv_has_timed_out(tt_local_entry->last_seen, timeout))
 				break;
-			}
 
-			tt_local_entry->common.flags |= BATADV_TT_CLIENT_PENDING;
+			batadv_tt_local_set_pending(bat_priv, tt_local_entry,
+						    BATADV_TT_CLIENT_DEL,
+						    "timed out");
 		}
-
-		if (cont)
-			continue;
-
-		batadv_tt_local_set_pending_event(bat_priv, tt_local_entry,
-						  BATADV_TT_CLIENT_DEL, "timed out");
 	}
 }
 
-- 
2.47.3

