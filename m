Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846BF606A31A
	for <batman@archiver.kernel.org>; Mon, 23 Nov 2026 17:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.a=rsa-sha256 header.s=09092022 header.b=P/2fMsgk
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 0C09E854CA
	for <batman@archiver.kernel.org>; Mon, 23 Nov 2026 18:22:35 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1795454555;
 b=0onpL7QzsxkPVdhL+a+rFVtYeQzWGkxvDt0LEbdx1YRwSa7qhvHCC10xap+3t3KJ0jTfO
 mSMPiAfrITC3Q9+Bk3QeEgfTKTFPd/UbdsOMyZZaiRBk5zt/lRDl1ybZ+zg0AwyMSRXf1Xx
 EuOp5+s+OKTcMayjX52SzirnQqWoogs=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1795454555; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=ikTWj3OMaD8zV0VbfYNdcMbCpUWhH/Zoj/Xn+pSLTzw=;
 b=vUV9uGBmvYVe5wTgCklvDrg0HAFVjh5+gGSSUrW+HTAq5CA9pbd1P9JNlJtxdwr/LGC9b
 CzKrHzx3cTgOfEVmxz4EY7nDZBQgSesqG05jnj6uFY3oy4EAFyzLiIdGBAdA7/zduFq2pM8
 9ONk/bKq9jMONOCoqjUNQuar95ItRH4=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 5F0048454B
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 23 Nov 2026 18:18:45 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1795454325;
	b=h0JGkc5FyPLXLG0ocQAtkOm3bjTSxmZhgJBH2av2U9qMPpy3/WjfH8MZRGfvpfq+M5ApbM
	+fof3ojEFnveWrNdN3HvKw2dsFbFp9YvHTkYCc662q6/eLZBBeUdP1zqefsucqzT5cGy+x
	TPyrlnHufAhmNfS5+wLFkEt8K95ehZU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1795454325;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=ikTWj3OMaD8zV0VbfYNdcMbCpUWhH/Zoj/Xn+pSLTzw=;
	b=veYZ0gp3GhufQDG8rTq9AQYBkxq9mH6V93PGXZgNtromqAAjA6AmewGd+J+f3LPosBcBr/
	erQXwFSQ4ttuIuKT2+P2A1oIA4MsIkhZoHNRhfWlkHPAncAFKRRzyAQ7QMntqiKHDqZSvE
	yAbYCXprbwsKrw0PCV8xpfEWt/XQ2JY=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b="P/2fMsgk";
	dmarc=pass (policy=none) header.from=simonwunderlich.de;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 23.88.38.48 as permitted sender) smtp.mailfrom=sw@simonwunderlich.de
Received: from kero.packetmixer.de
 (p200300c59714c2E05A704819B6bA2DB4.dip0.t-ipconnect.de
 [IPv6:2003:c5:9714:c2e0:5a70:4819:b6ba:2db4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with UTF8SMTPSA id CAC4EFA3E5;
	Mon, 23 Nov 2026 18:18:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1795454324;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ikTWj3OMaD8zV0VbfYNdcMbCpUWhH/Zoj/Xn+pSLTzw=;
	b=P/2fMsgkn0PKxOfTX4wLZBqSkibt5SzHaIS/I0Y7Xly49Fvw1oLI0mNBlTGunPirml5xj5
	ggPD7/3l6O5NG4vPkVUJuZ+2pkWRIh6/kWU3mWNXgeQF2XF4IsQ9u1li5awLPFP38C/noH
	UyynXxABnisicy77qltsOTU0c6ALjA2H9F7rvemZV8ntsWt0+L2sWVlQalRJByW2vRvKHb
	KNNdvPsMg+nUR/khFs2pBYb7icQ++aEQnSe/rJyIzxuwRYJDnH+8mSMvO/trQYb+3NMP4K
	JKPDCPA6Xs3GIXQchvPTezVb2OyAFSZR6PH5tvMqZf13ye9NfJrzVMbBwTk3Ew==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Sven Eckelmann <sven@narfation.org>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net-next 12/15] batman-adv: tt: extract removal of pending
 local entry
Date: Mon, 23 Nov 2026 18:18:24 +0100
Message-ID: <20261123171827.3294525-13-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261123171827.3294525-1-sw@simonwunderlich.de>
References: <20261123171827.3294525-1-sw@simonwunderlich.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: 4D3PVZI2VCMOKPJZF7OBEORV3EAUJJY6
X-Message-ID-Hash: 4D3PVZI2VCMOKPJZF7OBEORV3EAUJJY6
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/4D3PVZI2VCMOKPJZF7OBEORV3EAUJJY6/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_NONE,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Sven Eckelmann <sven@narfation.org>

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
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/translation-table.c | 108 +++++++++++++++++++++--------
 1 file changed, 80 insertions(+), 28 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 0c5e21f3ba75..2a7f50de70fc 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -1760,6 +1760,44 @@ int batadv_tt_local_dump(struct sk_buff *msg, struct netlink_callback *cb)
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
@@ -4550,6 +4588,43 @@ static void batadv_tt_local_transition_new(struct batadv_priv *bat_priv)
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
@@ -4579,40 +4654,17 @@ static void batadv_tt_local_purge_pending_clients(struct batadv_priv *bat_priv)
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
-
-				/* the removal must be announced first */
-				if (tt_local->del_unqueued) {
-					cont = true;
-					break;
-				}
+			scoped_guard(spinlock_bh, &tt_common->flags_lock)
+				unhashed = batadv_tt_local_unhash_pending(bat_priv,
+									  tt_local);
 
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

