Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF38606A31E
	for <batman@archiver.kernel.org>; Mon, 23 Nov 2026 17:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.a=rsa-sha256 header.s=09092022 header.b=moUu8MGX
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 4348785B3D
	for <batman@archiver.kernel.org>; Mon, 23 Nov 2026 18:26:39 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1795454799;
 b=mK+VlrEtYdhxyqHLvHWDVBAnFuQ+0F4M2hSEZBcYVylURbqKF5H5XTIoA8E31vLLDXML5
 0EisEGRPRMFHQoIeq8RYE0Zyw24yUQl5aQC2OnQlGp/MVtRqfYP3tI83VLjHZUo6AEhzVSB
 rmTOFbyEiObPajXcODGGjm0PEG3klEc=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1795454799; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=QNQHQ5O4TWMLgh/nR3cvCkdwm53W/SDGuT90F6rmcCY=;
 b=CL3mJFGTTnI0ykFmnsXPM+696XzjuM1F6+DgSeO5CYN/HVMdPnVzjXFrytS0fQxft5UgH
 W0RLvmVd11fpNqVPInH+N+BaW1yVhoImXD8R4fMdZALEWSOVUlsormKt48UZ+tmlngu8rLU
 PflFyh3j5cSNR174Vmee8ee6X9Dazd0=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 981AE8465E
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 23 Nov 2026 18:18:47 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1795454337;
	b=Fa5s5mzdn2DCyeDSzdN82q58KxWJj7AngFHn2dXUhw23W9o3zBksTAb6MmxeBb8ChXI0TM
	5xQvxkfq3IHf1j9PiQsmgGHic/MwL2r+ROZEOqgwGQA9nMqXFUvexRZA+0cw+ZEPt4vpY2
	cBqn7OMp0SaYO1IeKskRVWG/prFjkLU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1795454337;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=QNQHQ5O4TWMLgh/nR3cvCkdwm53W/SDGuT90F6rmcCY=;
	b=gB4yGr8SwRKtoIW0jElBfbunzYU4xZBW3Tqmikbh2aJY3NHDC6hmbb4X490FlwsJbjhIhe
	OOFSqxZ7QaDy99hzuAdgvhQKQ8j9iOkhVU1FUrhNM3Dbl04XqcAMOqVqXJI4nX4/bhvfIq
	JVudDt3q9+Vdc2wx22WyjUcUpQHHoUc=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=moUu8MGX;
	dmarc=pass (policy=none) header.from=simonwunderlich.de;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 23.88.38.48 as permitted sender) smtp.mailfrom=sw@simonwunderlich.de
Received: from kero.packetmixer.de
 (p200300C59714C2E05A704819B6BA2DB4.dip0.t-ipconnect.de
 [IPv6:2003:c5:9714:c2e0:5a70:4819:b6ba:2db4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with UTF8SMTPSA id 0F616FA3E6;
	Mon, 23 Nov 2026 18:18:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1795454327;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QNQHQ5O4TWMLgh/nR3cvCkdwm53W/SDGuT90F6rmcCY=;
	b=moUu8MGXz+/fpaPMIDzUVqBWvsc7rGNBflMnHLv/zAx+REPwG5FTZDSWqy+bs4t4cm7hEE
	S3Stv9Izs0jJMfEo8LYCTRAOlwcI6c2Xf5y+XIqnZtPUbVJmoLBgd+05lvYo5uQ2Czu6dg
	q3K/dnP2XE9MG0TscXNM8G070zqfYQFY90A56aPwbbHz6ELMNlwiQ0VF3lFeoUA6DijcHY
	/Tr4DQ1vKBXQnSquoJ0Xjn9KC+/cIDCb5qh6xNNQilEUQX5H3T0ZrRuRwe9NHJ18sR1wZj
	VRc0hzDtxqWwNrhrnYt2lAweSBaZqrOTGmuWevLDO0ER4aBcNBLQYw8GnNJLeQ==
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
Subject: [PATCH net-next 14/15] batman-adv: tt: avoid list_lock for unchanged
 local clients
Date: Mon, 23 Nov 2026 18:18:26 +0100
Message-ID: <20261123171827.3294525-15-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261123171827.3294525-1-sw@simonwunderlich.de>
References: <20261123171827.3294525-1-sw@simonwunderlich.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: 3FWE62Z7B5ZVFOTRZTC6JKCA3TAN2V7P
X-Message-ID-Hash: 3FWE62Z7B5ZVFOTRZTC6JKCA3TAN2V7P
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/3FWE62Z7B5ZVFOTRZTC6JKCA3TAN2V7P/>
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

batadv_tt_local_add() is called for every packet transmitted by a local
client. batadv_tt_local_refresh() takes the hash bucket list_lock for each
of them, although this lock is shared by all entries of the bucket and is
only needed when the entry has to be modified or announced.

For the common case, the entry is neither BATADV_TT_CLIENT_PENDING nor
BATADV_TT_CLIENT_ROAM, the dynamic flags (BATADV_TT_CLIENT_WIFI and
BATADV_TT_CLIENT_ISOLA) are unchanged and the entry is still hashed. Only
last_seen has to be refreshed then.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/translation-table.c | 115 ++++++++++++++++++++++-------
 1 file changed, 89 insertions(+), 26 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index b03d6c74732f..998c7f285e1d 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -984,13 +984,77 @@ batadv_tt_local_create(struct net_device *mesh_iface, const u8 *addr,
 	return tt_local;
 }
 
+/* flags of a local TT entry which depend on the packets of the client */
+#define BATADV_TT_LOCAL_DYNAMIC_MASK \
+	(BATADV_TT_CLIENT_WIFI | BATADV_TT_CLIENT_ISOLA)
+
 /**
- * batadv_tt_local_refresh_locked() - refresh a local TT entry
+ * batadv_tt_local_dynamic_flags() - get the dynamic flags of a local client
  * @bat_priv: the bat priv with all the mesh interface information
- * @tt_local: the local TT entry to refresh
  * @iif_is_wifi: whether the client is connected via a wifi interface
  * @mark: the value contained in the skb->mark field of the received packet (if
  *  any)
+ *
+ * Return: the BATADV_TT_CLIENT_WIFI and BATADV_TT_CLIENT_ISOLA flags which the
+ * local entry of the client has to carry.
+ */
+static u16 batadv_tt_local_dynamic_flags(struct batadv_priv *bat_priv,
+					 bool iif_is_wifi, u32 mark)
+{
+	u32 match_mark;
+	u16 flags = 0;
+
+	if (iif_is_wifi)
+		flags |= BATADV_TT_CLIENT_WIFI;
+
+	/* check the mark in the skb: if it's equal to the configured
+	 * isolation_mark, it means the packet is coming from an
+	 * isolated non-mesh client
+	 */
+	match_mark = (mark & bat_priv->isolation_mark_mask);
+	if (bat_priv->isolation_mark_mask &&
+	    match_mark == bat_priv->isolation_mark)
+		flags |= BATADV_TT_CLIENT_ISOLA;
+
+	return flags;
+}
+
+/**
+ * batadv_tt_local_refresh_needed() - check if a local entry has to be modified
+ * @tt_local: the local TT entry to check
+ * @dynamic_flags: the dynamic flags the entry has to carry
+ *
+ * The bucket list_lock which is shared by many entries is only needed when
+ * the entry has to be modified or announced. For the common case of an
+ * already announced client with unchanged flags, it is enough to refresh the
+ * last_seen timestamp.
+ *
+ * Return: true if the slow path of batadv_tt_local_refresh() is required,
+ * false otherwise.
+ */
+static bool
+batadv_tt_local_refresh_needed(struct batadv_tt_local_entry *tt_local,
+			       u16 dynamic_flags)
+{
+	struct batadv_tt_common_entry *common = &tt_local->common;
+	u16 flags;
+
+	flags = batadv_tt_flags_get(common);
+
+	if (flags & (BATADV_TT_CLIENT_PENDING | BATADV_TT_CLIENT_ROAM))
+		return true;
+
+	if ((flags & BATADV_TT_LOCAL_DYNAMIC_MASK) != dynamic_flags)
+		return true;
+
+	return hlist_unhashed_lockless(&common->hash_entry);
+}
+
+/**
+ * batadv_tt_local_refresh_locked() - refresh a local TT entry
+ * @bat_priv: the bat priv with all the mesh interface information
+ * @tt_local: the local TT entry to refresh
+ * @dynamic_flags: the dynamic flags the entry has to carry
  * @announce: whether an ADD event has to be queued even when no announced
  *  flag was modified
  * @roamed_back: set to true when the client returned to its original location
@@ -1014,7 +1078,7 @@ batadv_tt_local_create(struct net_device *mesh_iface, const u8 *addr,
 static bool
 batadv_tt_local_refresh_locked(struct batadv_priv *bat_priv,
 			       struct batadv_tt_local_entry *tt_local,
-			       bool iif_is_wifi, u32 mark, bool announce,
+			       u16 dynamic_flags, bool announce,
 			       bool *roamed_back)
 {
 	struct batadv_tt_common_entry *common = &tt_local->common;
@@ -1022,7 +1086,6 @@ batadv_tt_local_refresh_locked(struct batadv_priv *bat_priv,
 	bool readded = false;
 	bool roamed = false;
 	u8 remote_flags;
-	u32 match_mark;
 	u16 flags;
 	u32 i;
 
@@ -1058,21 +1121,8 @@ batadv_tt_local_refresh_locked(struct batadv_priv *bat_priv,
 		 */
 		remote_flags = flags & BATADV_TT_REMOTE_MASK;
 
-		if (iif_is_wifi)
-			flags |= BATADV_TT_CLIENT_WIFI;
-		else
-			flags &= ~BATADV_TT_CLIENT_WIFI;
-
-		/* check the mark in the skb: if it's equal to the configured
-		 * isolation_mark, it means the packet is coming from an
-		 * isolated non-mesh client
-		 */
-		match_mark = (mark & bat_priv->isolation_mark_mask);
-		if (bat_priv->isolation_mark_mask &&
-		    match_mark == bat_priv->isolation_mark)
-			flags |= BATADV_TT_CLIENT_ISOLA;
-		else
-			flags &= ~BATADV_TT_CLIENT_ISOLA;
+		flags &= ~BATADV_TT_LOCAL_DYNAMIC_MASK;
+		flags |= dynamic_flags;
 
 		if (remote_flags ^ (flags & BATADV_TT_REMOTE_MASK))
 			announce = true;
@@ -1119,7 +1169,8 @@ batadv_tt_local_refresh_locked(struct batadv_priv *bat_priv,
  *  any)
  * @roamed_back: set to true when the client returned to its original location
  *
- * See batadv_tt_local_refresh_locked() for the actual refresh.
+ * See batadv_tt_local_refresh_locked() for the actual refresh. The hash bucket
+ * list_lock is only taken when the entry has to be modified or announced.
  *
  * An entry whose modification could not be announced stays in its previous
  * state. The refresh is then retried with the next packet of the client.
@@ -1135,14 +1186,22 @@ batadv_tt_local_refresh(struct batadv_priv *bat_priv,
 	spinlock_t *list_lock; /* protects write access to the hash lists */
 	struct batadv_tt_common_entry *common = &tt_local->common;
 	struct batadv_hashtable *hash = bat_priv->tt.local_hash;
+	u16 dynamic_flags;
 	int ret = 0;
 	u32 i;
 
-	i = batadv_choose_tt(&common->key, hash->size);
-	list_lock = &hash->list_locks[i];
+	dynamic_flags = batadv_tt_local_dynamic_flags(bat_priv, iif_is_wifi,
+						      mark);
 
 	WRITE_ONCE(tt_local->last_seen, jiffies);
 
+	/* fast path: nothing to modify or to announce */
+	if (!batadv_tt_local_refresh_needed(tt_local, dynamic_flags))
+		return 0;
+
+	i = batadv_choose_tt(&common->key, hash->size);
+	list_lock = &hash->list_locks[i];
+
 	spin_lock_bh(list_lock);
 
 	/* the entry was removed from the local table after it was looked up */
@@ -1151,8 +1210,8 @@ batadv_tt_local_refresh(struct batadv_priv *bat_priv,
 		return -ENOENT;
 	}
 
-	if (!batadv_tt_local_refresh_locked(bat_priv, tt_local, iif_is_wifi,
-					    mark, false, roamed_back))
+	if (!batadv_tt_local_refresh_locked(bat_priv, tt_local, dynamic_flags,
+					    false, roamed_back))
 		ret = -ENOMEM;
 
 	spin_unlock_bh(list_lock);
@@ -1191,8 +1250,12 @@ static bool batadv_tt_local_insert(struct batadv_priv *bat_priv,
 	struct batadv_hashtable *hash = bat_priv->tt.local_hash;
 	struct hlist_head *head;
 	struct hlist_node *node;
+	u16 dynamic_flags;
 	u32 i;
 
+	dynamic_flags = batadv_tt_local_dynamic_flags(bat_priv, iif_is_wifi,
+						      mark);
+
 	i = batadv_choose_tt(&common->key, hash->size);
 	head = &hash->table[i];
 	list_lock = &hash->list_locks[i];
@@ -1208,8 +1271,8 @@ static bool batadv_tt_local_insert(struct batadv_priv *bat_priv,
 	}
 
 	/* announce the added client to the mesh */
-	if (!batadv_tt_local_refresh_locked(bat_priv, tt_local, iif_is_wifi,
-					    mark, true, roamed_back)) {
+	if (!batadv_tt_local_refresh_locked(bat_priv, tt_local, dynamic_flags,
+					    true, roamed_back)) {
 		spin_unlock_bh(list_lock);
 		return false;
 	}
-- 
2.47.3

