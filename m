Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C29606A320
	for <batman@archiver.kernel.org>; Wed, 18 Nov 2026 11:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.a=rsa-sha256 header.s=20121 header.b=l60PWC+b
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id BAB84842DB
	for <batman@archiver.kernel.org>; Wed, 18 Nov 2026 12:46:31 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1795002391;
 b=XyAP74Zz8uUW9wV+aiAJJZ8AAxvPIDequrwKxSiWJE/F4s8O/inVLnLd1gPeXr0zH79Ny
 vnUe+Ma/jzWy1sevd59Xy5LQa6A5YYNth95AAzi041NyyvoL7nYBVdYSVCq1Bzd8HAJVjv0
 pN5k9UNoinXUHBjCTBnp327gJD8tpTg=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1795002391; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=2DwN4Bb5jrBboM2Mizgj/0D+su8V3a776SfLBqRUm1A=;
 b=mzVL5XXZJJEmvNqYoJydkv6eUssWH5BH+iNP6/lFNk4HfuwK2/s1HKpYJ+4SbDf+XgJ2s
 LrgXfHeP9MTU9mX77fVRo8vgpuHp+taokX0gr4b1zEKfyR2a13rlg45u/FuZuKr3rwIh4hM
 bbRB9qo18rlt2mICkvFmIDYscbX/1kk=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id CE8AE842C1
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 18 Nov 2026 12:42:17 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1795002137;
	b=A/pnF7v0VzyGHGxHfiRx+MWUbE0UQCG3IXz+zxlv7tkT7jD1q8+NS1Y1k3kmQ4u6WWig9L
	4oHX16rCpy3iMeJbrEOHzfdBfjk5SpNblIClV3gKPygByvzDcUk9pdDNxpGS5n40vHhRKG
	1vkd+MLiDTwlK6y96uZkPh1zdJtCctA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1795002137;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=2DwN4Bb5jrBboM2Mizgj/0D+su8V3a776SfLBqRUm1A=;
	b=ApfO/sqYLY8M3R3jWsvjW61T23myzGa+9YOHMy1KXtt26ufVXL9RiySpDzgDmg3xEeY4xI
	KpoEg4Ds2V9eECkDTUQh1rnbLU7dMkVmOZaX0aRqXDOYns0T26gJj8vCmgUaJNtRQzhEws
	rtmQhpGqL/s8NL5BEFq5Eny8ejLuZfM=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=l60PWC+b;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org
Received: by dvalin.narfation.org (Postfix) id 2A8B01FE9A;
	Wed, 18 Nov 2026 11:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1795002137;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2DwN4Bb5jrBboM2Mizgj/0D+su8V3a776SfLBqRUm1A=;
	b=l60PWC+bvNrl/cY6OD4AXbcc/6eO6lsoJFNMeQYaj6b6RC5F6zY5qOgUFn0Te5XmHiodP9
	UPtWigBEjlNsyzu7gt9J+9vhgEeMQnz280FzmnRWGRSO0B7r5L1RBIihB2XZqdnBmPwkcB
	iYYYWeeyAYRJM3YZIf7kmBFxr0AakHY=
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 18 Nov 2026 12:41:58 +0100
Subject: [PATCH batadv v5 08/11] batman-adv: tt: extract removal of pending
 local entry
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261118-tt-avoid-unhashed-event-v5-8-bce9ead803e6@narfation.org>
References: <20261118-tt-avoid-unhashed-event-v5-0-bce9ead803e6@narfation.org>
In-Reply-To: 
 <20261118-tt-avoid-unhashed-event-v5-0-bce9ead803e6@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5772; i=sven@narfation.org;
 h=from:subject:message-id; bh=X/zZzoznxrlLHyDYb5hNQIO3GZ38V59i4uZsikk9wk4=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFl/+1mCI+s71onEzFZiX68lbmW3T/jdl6MKufvdfUXOM
 86/2V/RUcrCIMbFICumyLLnSv75zexv5T9P+3gUZg4rE8gQBi5OAZjI0tWMDA/cD69k12bcn+/n
 t0fv1ev1YofMdj+YcSdcKsewmZ1jwwRGhic/XltMbq7yWFlTzfn7VnfLEoO3vSfUjvceWGY7/ZD
 ePG4A
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: 5YRHVZXZDQQFPK6VSLNRANQV2LPR636C
X-Message-ID-Hash: 5YRHVZXZDQQFPK6VSLNRANQV2LPR636C
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/5YRHVZXZDQQFPK6VSLNRANQV2LPR636C/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_NONE,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

batadv_tt_local_purge_pending_clients() removes the entries which are
marked as BATADV_TT_CLIENT_PENDING from the local table. The actual removal
of a single entry has to follow some rules: an entry whose DEL still has to
be queued must stay in the local table and an entry which still carries
BATADV_TT_CLIENT_NEW was never counted and must not be uncounted.

Move the removal of a single entry to batadv_tt_local_unhash_pending(). It
can then be shared with the upcoming code which removes only the entry of a
committed DEL. The actual unhash steps are placed in
batadv_tt_local_unhash() because they will also be needed for entries which
are removed without going through the pending state. There is no functional
change.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/translation-table.c | 108 +++++++++++++++++++++++++++----------
 1 file changed, 80 insertions(+), 28 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 674b5c38..89fed26b 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -1813,6 +1813,44 @@ int batadv_tt_local_dump(struct sk_buff *msg, struct netlink_callback *cb)
 	return ret;
 }
 
+/**
+ * batadv_tt_local_unhash() - remove an entry from the local table
+ * @bat_priv: the bat priv with all the mesh interface information
+ * @tt_local: the local TT entry to remove
+ * @message: message to append to the log on deletion
+ *
+ * The caller must hold the hash bucket list_lock and the flags_lock of the
+ * entry. It must have checked that the entry is still part of the local table
+ * and has to drop the reference of the hash after it released the flags_lock.
+ */
+static void batadv_tt_local_unhash(struct batadv_priv *bat_priv,
+				   struct batadv_tt_local_entry *tt_local,
+				   const char *message)
+	__must_hold(&tt_local->common.flags_lock)
+{
+	struct batadv_tt_common_entry *tt_common = &tt_local->common;
+	struct batadv_hashtable *hash = bat_priv->tt.local_hash;
+	u32 i;
+
+	i = batadv_choose_tt(&tt_common->key, hash->size);
+	lockdep_assert_held(&hash->list_locks[i]);
+	lockdep_assert_held(&tt_common->flags_lock);
+
+	batadv_dbg(BATADV_DBG_TT, bat_priv,
+		   "Deleting local tt entry (%pM, vid: %d): %s\n",
+		   tt_common->key.addr, batadv_print_vid(tt_common->key.vid),
+		   message);
+
+	hlist_del_init_rcu(&tt_common->hash_entry);
+	atomic_inc(&hash->generation);
+
+	/* An entry which still carries BATADV_TT_CLIENT_NEW was never counted
+	 * and must not be uncounted here.
+	 */
+	if (!(tt_common->flags & BATADV_TT_CLIENT_NEW))
+		batadv_tt_local_size_dec(bat_priv, tt_common->key.vid);
+}
+
 /**
  * batadv_tt_local_set_pending() - mark local TT entry as pending removal
  * @bat_priv: the bat priv with all the mesh interface information
@@ -4603,6 +4641,43 @@ static void batadv_tt_local_transition_new(struct batadv_priv *bat_priv)
 	}
 }
 
+/**
+ * batadv_tt_local_unhash_pending() - remove a pending entry from the local table
+ * @bat_priv: the bat priv with all the mesh interface information
+ * @tt_local: the local TT entry to remove
+ *
+ * Only an entry which is marked as BATADV_TT_CLIENT_PENDING and whose DEL was
+ * queued is removed. An entry which still waits for its DEL (del_unqueued) must
+ * stay in the local table until batadv_tt_local_purge_list() was able to queue
+ * it.
+ *
+ * The caller must hold the hash bucket list_lock and the flags_lock of the
+ * entry.
+ *
+ * Return: true if the entry was unhashed and the caller has to drop the
+ * reference of the hash, false otherwise.
+ */
+static bool
+batadv_tt_local_unhash_pending(struct batadv_priv *bat_priv,
+			       struct batadv_tt_local_entry *tt_local)
+	__must_hold(&tt_local->common.flags_lock)
+{
+	struct batadv_tt_common_entry *tt_common = &tt_local->common;
+
+	lockdep_assert_held(&tt_common->flags_lock);
+
+	if (!(tt_common->flags & BATADV_TT_CLIENT_PENDING))
+		return false;
+
+	/* the removal must be announced first */
+	if (tt_local->del_unqueued)
+		return false;
+
+	batadv_tt_local_unhash(bat_priv, tt_local, "pending");
+
+	return true;
+}
+
 /**
  * batadv_tt_local_purge_pending_clients() - finalise removal of pending local
  *  clients
@@ -4632,40 +4707,17 @@ static void batadv_tt_local_purge_pending_clients(struct batadv_priv *bat_priv)
 		spin_lock_bh(list_lock);
 		hlist_for_each_entry_safe(tt_common, node_tmp, head,
 					  hash_entry) {
-			bool cont = false;
+			bool unhashed;
 
 			tt_local = container_of(tt_common,
 						struct batadv_tt_local_entry,
 						common);
 
-			scoped_guard(spinlock_bh, &tt_common->flags_lock) {
-				if (!(tt_common->flags & BATADV_TT_CLIENT_PENDING)) {
-					cont = true;
-					break;
-				}
+			scoped_guard(spinlock_bh, &tt_common->flags_lock)
+				unhashed = batadv_tt_local_unhash_pending(bat_priv,
+									  tt_local);
 
-				/* the removal must be announced first */
-				if (tt_local->del_unqueued) {
-					cont = true;
-					break;
-				}
-
-				batadv_dbg(BATADV_DBG_TT, bat_priv,
-					   "Deleting local tt entry (%pM, vid: %d): pending\n",
-					   tt_common->key.addr,
-					   batadv_print_vid(tt_common->key.vid));
-
-				hlist_del_init_rcu(&tt_common->hash_entry);
-				atomic_inc(&hash->generation);
-
-				/* An entry which still carries BATADV_TT_CLIENT_NEW was
-				 * never counted and must not be uncounted here.
-				 */
-				if (!(tt_common->flags & BATADV_TT_CLIENT_NEW))
-					batadv_tt_local_size_dec(bat_priv, tt_common->key.vid);
-			}
-
-			if (cont)
+			if (!unhashed)
 				continue;
 
 			batadv_tt_local_entry_put(tt_local);

-- 
2.47.3

