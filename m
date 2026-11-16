Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97DFE606A330
	for <batman@archiver.kernel.org>; Mon, 16 Nov 2026 20:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.a=rsa-sha256 header.s=20121 header.b=oGt4P+bu
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 271F382740
	for <batman@archiver.kernel.org>; Mon, 16 Nov 2026 21:08:27 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1794859707;
 b=RDDCaYIMFK/9Oo1GXz1885iuBEqL0EZlvHcyRhECwrVX8cz2EcqbYYiWpnI8xmHjIP4X1
 MvJalQYRdMdL+0Vm122fsFRxRTJgBkwlEy1c2ko8UP8zGTPaHh+v3e3QiHx+UqxDL4wx7Nv
 FsZHSZqQYKfx2Bv7A5nZtftxXKWGs4s=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1794859707; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=D0p3W2v2032ireeoUeTdxgMbjeAHfZBghJNr6uuLWzY=;
 b=oIJW/c/zqNLf4kbCNpjvnmtZJ+ly+wA/MxuM/czoPrDkblRYu1hALweSPUuYGFTSdLSLl
 g/ZVNjjSCQHwovZOLZT/s9moBhLfFEh66B89AduTZds3MlX9AV6q93wzbo9S1SVjGNfF3XU
 TN0RJ55sAKmHXrsFuAk519PadMR0FR0=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 054C284260
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 16 Nov 2026 21:03:35 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1794859425;
	b=Lw7+8WgTjz/aGunU2G9DjAyIyDgG2u2pf9TTVEAt0GjGX+33YvOjyfAgJunr2F7ktdAgFW
	BSqdcjxBmFCEiANnPXdS0VZB35i7Y+nPEtFKB5HoRRwh6ppwgxyaLFKYdKz+98F70Q/IeH
	khfNyvNuykmjietM9efUzYXoG0Rji6g=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1794859425;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=D0p3W2v2032ireeoUeTdxgMbjeAHfZBghJNr6uuLWzY=;
	b=r9ruf4It8J0npj+5Y1j8J4VHBo0w+s4XSXwPldqpNdd0LdKEPf5kA2tpxngqB+vkgS7vvo
	etis1cDjWLdkWIP4PX7m1UAfpzbv+H1XA/eQ7Hx8IuOwTTtaeLYc/u0HNc4FFqBZAoxMEL
	P+gN0zGVis2TXk7e/EjUO5/qEajfy2Q=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=oGt4P+bu;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org
Received: by dvalin.narfation.org (Postfix) id 7DE5120ECB;
	Mon, 16 Nov 2026 20:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1794859414;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D0p3W2v2032ireeoUeTdxgMbjeAHfZBghJNr6uuLWzY=;
	b=oGt4P+buQOmOF99KDf7RUUHZNn51XQx5A59ZY03wAFPC0wFEO+xeEumX/zUyDZnzPUmMAy
	yex7EkCCY2WAI1Pq4cwOeWxVwqPm89wVIKTRJM8oZtpMZXvQFBHH/PSOBoIYkbX1b2JAQk
	Wvbx1yvdrJbEP9GqM1rwRGPb0CD8kso=
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 16 Nov 2026 21:03:09 +0100
Subject: [PATCH batadv v4 08/11] batman-adv: tt: extract removal of pending
 local entry
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-tt-avoid-unhashed-event-v4-8-42c6bb518123@narfation.org>
References: <20261116-tt-avoid-unhashed-event-v4-0-42c6bb518123@narfation.org>
In-Reply-To: 
 <20261116-tt-avoid-unhashed-event-v4-0-42c6bb518123@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4406; i=sven@narfation.org;
 h=from:subject:message-id; bh=mBlGGaozyF0kD0SDQMw6eU0bMWxoDNApgW6i2Pc8WIs=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFm/E+t2Nht039XNtNvkm920KUq9PHO59uR3ga6LWGQce
 Gbu22jXUcrCIMbFICumyLLnSv75zexv5T9P+3gUZg4rE8gQBi5OAZiIsQQjw8me5ph11nd3KD57
 8tzuZa1Ur68TX0ywM/9e2eVTFU6z1TIy/NXYlf7AakOffHrcu8dfK+ttVmR5O2+cqz/3+q0Zbw5
 kMAIA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: FE26CUUUAP5UDBUMTBF2HAYVL7CAXIC4
X-Message-ID-Hash: FE26CUUUAP5UDBUMTBF2HAYVL7CAXIC4
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/FE26CUUUAP5UDBUMTBF2HAYVL7CAXIC4/>
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
committed DEL. There is no functional change.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/translation-table.c | 85 +++++++++++++++++++++++++-------------
 1 file changed, 57 insertions(+), 28 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 7767a03a..2366de0e 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -4597,6 +4597,58 @@ static void batadv_tt_local_transition_new(struct batadv_priv *bat_priv)
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
+{
+	struct batadv_tt_common_entry *tt_common = &tt_local->common;
+	struct batadv_hashtable *hash = bat_priv->tt.local_hash;
+	u32 i;
+
+	i = batadv_choose_tt(&tt_common->key, hash->size);
+	lockdep_assert_held(&hash->list_locks[i]);
+	lockdep_assert_held(&tt_common->flags_lock);
+
+	if (!(tt_common->flags & BATADV_TT_CLIENT_PENDING))
+		return false;
+
+	/* the removal must be announced first */
+	if (tt_local->del_unqueued)
+		return false;
+
+	batadv_dbg(BATADV_DBG_TT, bat_priv,
+		   "Deleting local tt entry (%pM, vid: %d): pending\n",
+		   tt_common->key.addr,
+		   batadv_print_vid(tt_common->key.vid));
+
+	hlist_del_init_rcu(&tt_common->hash_entry);
+	atomic_inc(&hash->generation);
+
+	/* An entry which still carries BATADV_TT_CLIENT_NEW was never counted
+	 * and must not be uncounted here.
+	 */
+	if (!(tt_common->flags & BATADV_TT_CLIENT_NEW))
+		batadv_tt_local_size_dec(bat_priv, tt_common->key.vid);
+
+	return true;
+}
+
 /**
  * batadv_tt_local_purge_pending_clients() - finalise removal of pending local
  *  clients
@@ -4625,40 +4677,17 @@ static void batadv_tt_local_purge_pending_clients(struct batadv_priv *bat_priv)
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

