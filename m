Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B93B8C9830E
	for <batman-adv@archiver.kernel.org>; Sun, 27 Sep 2026 16:22:59 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 399D884271
	for <batman-adv@archiver.kernel.org>; Sun, 27 Sep 2026 18:22:58 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1790526178;
 b=qf8Rg3S9fYA7ZYJFQ7EmEjUN129HAD+lxsHi0b11JS8Rqy+EdHhym8WhnAb668uM3IsCX
 1dANHuwSKsLSw6jPAH4OfhwkrMkyOtxzXwoq34oR8U6QYUH/NabjCEMUZnKrWwgIBTHdeE1
 x6V/wP5Wo+lX4clz3KeaRneTBh8Q4MQ=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1790526178; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=5KQEaixoPiGBYQ6YjAFVWzAW0wqVDjBSV5I6APVUF6U=;
 b=z2MKII7k0Wh+TS67Q6G0EPsGAMPpdd5iSnUGmPfngEeHsKl6PsILgiB1AbZ/uAlSZrqoF
 ID0Ahg2hyJKHlQAD9LirAOLfTa1M6zphlbd+EHK4QezG2SZXGF1HG1P+o4fIMY0ibm/GROl
 blEp/xd/iwl2tIJbi/H3yZ/9JobyK1w=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id B847A83F06
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 27 Sep 2026 18:21:40 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1790526110;
	b=T5pvXDUDzH3B2xmXD+YQOdfwG/1QN8acTGEzkFy9YcLGsDZqQelECZV2Eq91H4m/Wz7tgw
	Tn8ro3CELBhzaMpz69PK8PlNicpGXjDV0NPhAomUCEZg/IUlprR1NybUS3qv2rfhTCNZDx
	hRKIF8xSqBAXD1A4X+8k2CZRAC+HExc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1790526110;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=5KQEaixoPiGBYQ6YjAFVWzAW0wqVDjBSV5I6APVUF6U=;
	b=uCYMfsnyHcTh/s38oqok3OD+o6jaZBEcrYhYL21/HDELov1jKNeiAS2UWY+/IRWEScvJpA
	3WmsdmAFP62pi+9DYhir/GPI8PAl0/wiCATRe/YaWF1yiDOoAF7xE+WY8S0roUbJpjfIvE
	0rtNjHcUEOZq6JpL3kDMYCUSQqXycZQ=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=K+F08xWG;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org
Received: by dvalin.narfation.org (Postfix) id 567BD207E6;
	Sun, 27 Sep 2026 16:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1790526100;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5KQEaixoPiGBYQ6YjAFVWzAW0wqVDjBSV5I6APVUF6U=;
	b=K+F08xWG4ukUWTn3dQPCQxoAE4CySNdbRlLABfE2EnWGj4gYwfhD67uHDUSoKBQD7tTsZv
	i3YZdqawcek/k61XOeK+jPQLjQNSx81krMxSOSD2xHr777Kt0gGJ+Gmkvxuh8Qo2YAQqLG
	XkXa1VwbrPhId0/u2evYS7VGWKEQ3/w=
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 27 Sep 2026 18:21:29 +0200
Subject: [PATCH batadv v2 2/2] batman-adv: tt: queue local DEL event before
 marking entry as pending
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260927-tt-order-local_remove-v2-2-547d8de2e35d@narfation.org>
References: <20260927-tt-order-local_remove-v2-0-547d8de2e35d@narfation.org>
In-Reply-To: <20260927-tt-order-local_remove-v2-0-547d8de2e35d@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>, Sashiko <sashiko-bot@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9672; i=sven@narfation.org;
 h=from:subject:message-id; bh=Zt7+41INysVL5luYDKOYP7Xa/Qb/rwJ8ScCpuqbFFHQ=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFk7nXrlyr+uOq3fvvqiXM6FvAA5zT0TXr7o+WJjdDWBZ
 W6Q2ELPjlIWBjEuBlkxRZY9V/LPb2Z/K/952sejMHNYmUCGMHBxCsBEjk5mZDj+Juxmf35e0vv4
 zrDq31dPu2sujS/ScWBd+zJhn4uqgRgjwwfNamn3C5s/br5i29XVw+V01HX5tXXaZ6duNmz9Ze1
 8iB0A
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: WRFW2TLUFEUCGYKDPCRSFNHD2I5SSBBX
X-Message-ID-Hash: WRFW2TLUFEUCGYKDPCRSFNHD2I5SSBBX
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/WRFW2TLUFEUCGYKDPCRSFNHD2I5SSBBX/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

batadv_tt_local_set_pending() originally queued the DEL change event and
only afterwards set BATADV_TT_CLIENT_PENDING on the local entry. Commit
ea5a8b4def29 ("batman-adv: tt: use protected flag modifications") inverted
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

Fixes: ea5a8b4def29 ("batman-adv: tt: use protected flag modifications")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260831135117.574836-1-sw%40simonwunderlich.de?part=12
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/translation-table.c | 102 ++++++++++++++++++++-----------------
 1 file changed, 55 insertions(+), 47 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 4c71bf1c..e46040fd 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -671,23 +671,21 @@ static u16 batadv_tt_flags_get(struct batadv_tt_common_entry *common)
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
@@ -698,8 +696,6 @@ static void batadv_tt_local_event(struct batadv_priv *bat_priv,
 	ether_addr_copy(tt_change_node->change.addr, common->addr);
 	tt_change_node->change.vid = htons(common->vid);
 
-	flags = batadv_tt_flags_get(common) | event_flags;
-
 	tt_change_node->change.flags = flags;
 	del_op_requested = flags & BATADV_TT_CLIENT_DEL;
 
@@ -747,6 +743,23 @@ static void batadv_tt_local_event(struct batadv_priv *bat_priv,
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
  * batadv_tt_entries() - compute the number of entries fitting in tt_len bytes
  * @tt_len: available space
@@ -1605,28 +1618,37 @@ int batadv_tt_local_dump(struct sk_buff *msg, struct netlink_callback *cb)
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
@@ -1645,7 +1667,8 @@ batadv_tt_local_set_pending_event(struct batadv_priv *bat_priv,
  * An already announced entry is marked as BATADV_TT_CLIENT_PENDING and the
  * (roamed) DEL change is queued. Both happen under the hash bucket list_lock
  * of the entry to prevent concurrent batadv_tt_local_purge_pending_clients()
- * from removing the entry.
+ * from removing the entry and batadv_tt_local_transition_new() from clearing
+ * BATADV_TT_CLIENT_NEW after it was checked.
  *
  * Return: true if the entry has to be kept in the local table until the next
  * ttvn increment, false if it can be purged immediately.
@@ -1677,19 +1700,16 @@ batadv_tt_local_mark_removed(struct batadv_priv *bat_priv,
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
@@ -1786,37 +1806,25 @@ static void batadv_tt_local_purge_list(struct batadv_priv *bat_priv,
 
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

