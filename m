Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7632B606A322
	for <batman@archiver.kernel.org>; Mon, 16 Nov 2026 20:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.a=rsa-sha256 header.s=20121 header.b=tQ73ec0H
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 09F99807C6
	for <batman@archiver.kernel.org>; Mon, 16 Nov 2026 21:07:57 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1794859677;
 b=14mJu5B+kBSS4OLd1un7mL0RXqkTbueEQbqGpkJOmR6TdBu71So2u3+w86vJ7NFHXI5p3
 Epn1mwQqjIWM0PXRxixC/Z1IzBxK+esAby4qVryLQlTJ4zWE10Q+om3sqNXlCcQ/O+ofYY2
 5d1WVGiCZHVvl0B6SXG+mFXbevuTpf0=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1794859677; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=OXFRC0EACh6xSGOLi5a6MXivVIlF84PL0v3D2VMvpsY=;
 b=knf6LZNJYX0/ei4l6rGA2Q3BJg8hlhGLwUYEjj9AFnKZWu9cZngAALrMxK06TnXZFzazI
 BJzTp6BFVDkQalzyBIUiu4l8n2geN3OrHxN2HWlVZqgxWZdtMXJP2ZWok9Xo7IPdMd7KcF+
 S2kSkPN8LqcuHSFoB6+Dj7nvz1RrUgk=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id F3C0B8427B
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 16 Nov 2026 21:03:32 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1794859423;
	b=hUxapr2FumaBMRqk83F7X73wPCvfvNvHng06XuN2loFz+UxmiZXflrm8SZnheHEnI+/n3l
	Kz6gPsPQKYUF9HVVIODKvX1Z/uaCrAnQEO2yIYq9JeD8//ETStrkHEuFC+bqWxYE6fiGSw
	4S3W4fAPpdhwKtN0c2mePpoV3O6YUfk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1794859423;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=OXFRC0EACh6xSGOLi5a6MXivVIlF84PL0v3D2VMvpsY=;
	b=vERE2O0v4d01DRgzV49BXzah17RICwiZSqludnCP18dE9Il7olzCujdnS7kaAFMBHo6TP3
	3O2HLIZjIvLMr2DtT40MbROnSVfQIJGZXHfmNTaPE8KYVPCE7FrcMkPUjaHCECZPIHXtNH
	3mZP7xOZyfHkLvq9PbVNlcSv9YlGifI=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=tQ73ec0H;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org
Received: by dvalin.narfation.org (Postfix) id B8EEA2014F;
	Mon, 16 Nov 2026 20:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1794859412;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OXFRC0EACh6xSGOLi5a6MXivVIlF84PL0v3D2VMvpsY=;
	b=tQ73ec0HX5gSveFU4g4rCNl6F8imA64WlXdDiezcL13IppEXaZAfuTqz629YeJv+A42jta
	CQ+ctoH2ro7rI1WRMQpZUI1QDI2GxOgI122F+bwVkFsNZ+3QYhwJNfs5dslH2IWKhfg9cM
	p0Wz4yA57cqV+VD+NMEjm6zQtrOtFsw=
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 16 Nov 2026 21:03:08 +0100
Subject: [PATCH batadv v4 07/11] batman-adv: tt: requeue DEL of pending
 local entry after failed allocation
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-tt-avoid-unhashed-event-v4-7-42c6bb518123@narfation.org>
References: <20261116-tt-avoid-unhashed-event-v4-0-42c6bb518123@narfation.org>
In-Reply-To: 
 <20261116-tt-avoid-unhashed-event-v4-0-42c6bb518123@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7325; i=sven@narfation.org;
 h=from:subject:message-id; bh=Kd+IxXfijVDw5n88zVtMDL1dnyMiWNzzQv9PDrBzfBY=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFm/E+tun/VZ9NLIKVCH6fzmOQs9LjC8b0mpmJGk+F3FZ
 4rwhzyGjlIWBjEuBlkxRZY9V/LPb2Z/K/952sejMHNYmUCGMHBxCsBErvsw/HeKdZS8x7BQ9Yp3
 STEX27Uzk//0GTNOfHMjQPP70t8ljdqMDOt+B381Pln0ib8tdv/XbbPdH5zcVfzFMk435p4x+1k
 2HhYA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: YTPAKRGKOXGMIFMKIGKLWBHMBR57KDIN
X-Message-ID-Hash: YTPAKRGKOXGMIFMKIGKLWBHMBR57KDIN
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/YTPAKRGKOXGMIFMKIGKLWBHMBR57KDIN/>
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

batadv_tt_local_set_pending() marks a local entry as
BATADV_TT_CLIENT_PENDING even when the DEL could not be queued because the
allocation of the change failed. The other nodes are then never informed
about the removal of the client. And nothing queues the DEL again because
an already pending entry is skipped by the purge.

The removal can also not simply be rejected. The callers of
batadv_tt_local_remove() don't retry it and a BATADV_TT_CLIENT_NOPURGE
entry would never be removed by the purge. And a roamed client must be
marked as BATADV_TT_CLIENT_ROAM right away to get its packets rerouted to
the new originator.

The entry is therefore still marked as before. But a pending entry whose
DEL could not be queued is now marked as del_unqueued:

* batadv_tt_local_purge_list() queues the DEL of such an entry again. This
  is retried every BATADV_TT_WORK_PERIOD until it succeeds.
* batadv_tt_local_purge_pending_clients() keeps such an entry in the local
  table until its DEL was queued. The local table then still matches the
  table which was announced to the other nodes.
* batadv_tt_local_refresh_locked() drops the mark when the client was
  detected again and the ADD for it was queued.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/translation-table.c | 60 +++++++++++++++++++++++++++++++-------
 net/batman-adv/types.h             |  7 +++++
 2 files changed, 56 insertions(+), 11 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 6fe04996..7767a03a 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -708,8 +708,10 @@ static u16 batadv_tt_flags_get(struct batadv_tt_common_entry *common)
  *
  * The other nodes only learn about the modification of a local entry through
  * the queued change. The caller must therefore not modify the entry in a way
- * which depends on this change (e.g. hash it as BATADV_TT_CLIENT_NEW or mark it
- * as BATADV_TT_CLIENT_PENDING) when the event could not be stored.
+ * which depends on this change (e.g. hash it as BATADV_TT_CLIENT_NEW) when the
+ * event could not be stored. The only exception is the DEL of
+ * batadv_tt_local_set_pending(). Its entry is marked as del_unqueued to get the
+ * DEL requeued by batadv_tt_local_purge_list().
  *
  * Return: true if the event was stored, false if the memory for it could not
  * be allocated.
@@ -1002,6 +1004,7 @@ batadv_tt_local_create(struct net_device *mesh_iface, const u8 *addr,
 	kref_init(&tt_local->common.refcount);
 	last_seen = jiffies;
 	WRITE_ONCE(tt_local->last_seen, last_seen);
+	tt_local->del_unqueued = false;
 	tt_local->common.added_at = last_seen;
 	tt_local->vlan = vlan;
 	spin_lock_init(&tt_local->common.flags_lock);
@@ -1123,6 +1126,12 @@ batadv_tt_local_refresh_locked(struct batadv_priv *bat_priv,
 			return false;
 
 		common->flags = flags;
+
+		/* the queued ADD replaces the DEL which still had to be
+		 * queued for the no longer pending entry
+		 */
+		if (readded)
+			tt_local->del_unqueued = false;
 	}
 
 	if (readded)
@@ -1809,6 +1818,11 @@ int batadv_tt_local_dump(struct sk_buff *msg, struct netlink_callback *cb)
  * entry. The entry is kept in the local table until the next TTVN increment
  * so that a consistency-check response can still be answered.
  *
+ * The entry is also marked as BATADV_TT_CLIENT_PENDING when the DEL could not
+ * be queued. The removal must not be lost because not all callers are able to
+ * retry it. Such an entry is marked as del_unqueued instead. It stays in the
+ * local table until batadv_tt_local_purge_list() was able to queue its DEL.
+ *
  * The caller must hold the flags_lock of @tt_local_entry and must not have
  * released it since it checked that the entry has to be removed. Both the
  * queue-then-mark order and this single flags_lock section are required.
@@ -1826,13 +1840,24 @@ batadv_tt_local_set_pending(struct batadv_priv *bat_priv,
 {
 	struct batadv_tt_common_entry *common = &tt_local_entry->common;
 	struct batadv_hashtable *hash = bat_priv->tt.local_hash;
+	bool queued;
 	u32 i;
 
 	i = batadv_choose_tt(&common->key, hash->size);
 	lockdep_assert_held(&hash->list_locks[i]);
 	lockdep_assert_held(&common->flags_lock);
 
-	__batadv_tt_local_event(bat_priv, common, common->flags | flags);
+	queued = __batadv_tt_local_event(bat_priv, common,
+					 common->flags | flags);
+
+	/* a failed attempt must not hide the still queued DEL of an already
+	 * pending entry
+	 */
+	if (queued)
+		tt_local_entry->del_unqueued = false;
+	else if (!(common->flags & BATADV_TT_CLIENT_PENDING))
+		tt_local_entry->del_unqueued = true;
+
 	common->flags |= BATADV_TT_CLIENT_PENDING;
 
 	batadv_dbg(BATADV_DBG_TT, bat_priv,
@@ -1958,11 +1983,18 @@ static void batadv_tt_local_purge_list(struct batadv_priv *bat_priv,
 					      common);
 
 		scoped_guard(spinlock_bh, &tt_local_entry->common.flags_lock) {
-			if (tt_local_entry->common.flags & BATADV_TT_CLIENT_NOPURGE)
-				break;
-
 			/* entry already marked for deletion */
-			if (tt_local_entry->common.flags & BATADV_TT_CLIENT_PENDING)
+			if (tt_local_entry->common.flags & BATADV_TT_CLIENT_PENDING) {
+				/* but its removal must still be announced */
+				if (tt_local_entry->del_unqueued)
+					batadv_tt_local_set_pending(bat_priv,
+								    tt_local_entry,
+								    BATADV_TT_CLIENT_DEL,
+								    "requeued");
+				break;
+			}
+
+			if (tt_local_entry->common.flags & BATADV_TT_CLIENT_NOPURGE)
 				break;
 
 			if (!batadv_has_timed_out(READ_ONCE(tt_local_entry->last_seen),
@@ -4595,12 +4627,22 @@ static void batadv_tt_local_purge_pending_clients(struct batadv_priv *bat_priv)
 					  hash_entry) {
 			bool cont = false;
 
+			tt_local = container_of(tt_common,
+						struct batadv_tt_local_entry,
+						common);
+
 			scoped_guard(spinlock_bh, &tt_common->flags_lock) {
 				if (!(tt_common->flags & BATADV_TT_CLIENT_PENDING)) {
 					cont = true;
 					break;
 				}
 
+				/* the removal must be announced first */
+				if (tt_local->del_unqueued) {
+					cont = true;
+					break;
+				}
+
 				batadv_dbg(BATADV_DBG_TT, bat_priv,
 					   "Deleting local tt entry (%pM, vid: %d): pending\n",
 					   tt_common->key.addr,
@@ -4619,10 +4661,6 @@ static void batadv_tt_local_purge_pending_clients(struct batadv_priv *bat_priv)
 			if (cont)
 				continue;
 
-			tt_local = container_of(tt_common,
-						struct batadv_tt_local_entry,
-						common);
-
 			batadv_tt_local_entry_put(tt_local);
 		}
 		spin_unlock_bh(list_lock);
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 8e590f19..d443143f 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -1939,6 +1939,13 @@ struct batadv_tt_local_entry {
 	/** @last_seen: timestamp used for purging stale tt local entries */
 	unsigned long last_seen;
 
+	/**
+	 * @del_unqueued: the DEL of this BATADV_TT_CLIENT_PENDING entry could
+	 *  not be queued and must be queued by the next purge. Protected by
+	 *  common.flags_lock
+	 */
+	bool del_unqueued;
+
 	/** @vlan: mesh-interface vlan of the entry */
 	struct batadv_meshif_vlan *vlan;
 };

-- 
2.47.3

