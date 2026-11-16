Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB53606A32C
	for <batman@archiver.kernel.org>; Mon, 16 Nov 2026 20:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.a=rsa-sha256 header.s=20121 header.b=1/88+vV7
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id EDE568410E
	for <batman@archiver.kernel.org>; Mon, 16 Nov 2026 21:09:02 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1794859742;
 b=fWIb738ZsKR6McPpBy3kxsqEadEgl3dNaoRiR0S+jRwI6qqsiDRc0q5R2MCI1L9L+x+ag
 /7+PD3js8C5hD42l7sTf6UD/nLuhhKDtqZwMAshQkABKgu+3tbdf0SiWWyaZ1H8YljF2Fyc
 QkYwlgWFDPLItbATIv1xy/7wbwIAEoE=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1794859742; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=J26n6RSc5zblDHDQEiwuho+ktkz53DbXJHP3Twi4i9s=;
 b=nA1yxJA2fSPm1ltjeUu7QVX8Z+hOwzz2i3ITs7KJT4pz0ekQUzEKiyCvKxRCH+aocWwmp
 Fvq1VVOk8bbzrLZc5cbg5n5VJRYfWy+53iT8R5rsAn5Ib6lSyuMJgGdJsn2MhhWnZfURQwP
 7xMw8MY2jMAqTaApWBciTju/5Ntldqw=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id F09608429D
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 16 Nov 2026 21:03:38 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1794859429;
	b=bACg9F8T9pFAlDRTBM8aOXEksp7qI+TnihhqXJSMSGCU0ZbCx8ON8oUyXnOdAxp0JMiI1c
	usbdb04QPgBKLZX+ZHAXBs0fyhK0DzAPAYM0yQAE/Jn08YH9JLAQxS2kg3mB9K+1P0jZDt
	wF8Gi9mdvvdOKfvRHle+hVEzDNKVHGY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1794859429;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=J26n6RSc5zblDHDQEiwuho+ktkz53DbXJHP3Twi4i9s=;
	b=c34qdFhgqkV3JLRKbhEdvO/eHM1Y5lVnL+wxeRswHozkBP41/lyvb+A6G1XBFttyjoxB8n
	7TuUrqJmEuNeKpn/6DBt+bwtT7mOvPrhqdG7PwVmYbYVlh+LyWlGMtUulu2JShAvpXFU9J
	0IE3WhkFbnoZzrNPt1A0l4L1MfC4zcI=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b="1/88+vV7";
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org
Received: by dvalin.narfation.org (Postfix) id AA08420F6B;
	Mon, 16 Nov 2026 20:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1794859418;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J26n6RSc5zblDHDQEiwuho+ktkz53DbXJHP3Twi4i9s=;
	b=1/88+vV7Mm6kjvIT52QsSFZ2M8Vp4pNXgRypZgLX5qovqiwgDmT1rwiKnO0X2X00IQEysU
	80Kxx01niykm+MsJmbP3La3PpBU1NtPdsjHR9UI7oEnSUBhBxcaaHM+fdU2BbQhE5gBduI
	RhB7zsYfDrksFp0lh40rSdFD631Fs8M=
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 16 Nov 2026 21:03:11 +0100
Subject: [PATCH batadv v4 10/11] batman-adv: tt: avoid list_lock for
 unchanged local clients
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: 
 <20261116-tt-avoid-unhashed-event-v4-10-42c6bb518123@narfation.org>
References: <20261116-tt-avoid-unhashed-event-v4-0-42c6bb518123@narfation.org>
In-Reply-To: 
 <20261116-tt-avoid-unhashed-event-v4-0-42c6bb518123@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8042; i=sven@narfation.org;
 h=from:subject:message-id; bh=QS+UpmDUZaSGV8KaHTCr9tq06CjsEyK3mlckY0uAByQ=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFm/E+t7t4rtMinhb66f8MzEpCe6/9jxHeFMF6oUDZTTb
 0RvvSbYUcrCIMbFICumyLLnSv75zexv5T9P+3gUZg4rE8gQBi5OAbjILkaGAzKpYgIPl1q9+y6s
 smFKbuSM1QFmqmvzXv7tCDSfdmrbOYb/oV3SGpofVZfffSOZ3P2Dm79z9+cayfUca3lyLrspZz5
 lAAA=
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: ZH6KNKAUJ2Y5WXULTPYQG27DVL4JSRKT
X-Message-ID-Hash: ZH6KNKAUJ2Y5WXULTPYQG27DVL4JSRKT
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/ZH6KNKAUJ2Y5WXULTPYQG27DVL4JSRKT/>
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

batadv_tt_local_add() is called for every packet transmitted by a local
client. batadv_tt_local_refresh() takes the hash bucket list_lock for each
of them, although this lock is shared by all entries of the bucket and is
only needed when the entry has to be modified or announced.

For the common case, the entry is neither BATADV_TT_CLIENT_PENDING nor
BATADV_TT_CLIENT_ROAM, the dynamic flags (BATADV_TT_CLIENT_WIFI and
BATADV_TT_CLIENT_ISOLA) are unchanged and the entry is still hashed. Only
last_seen has to be refreshed then.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/translation-table.c | 117 ++++++++++++++++++++++++++++---------
 1 file changed, 90 insertions(+), 27 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index aac62f9b..218e3d26 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -1025,13 +1025,77 @@ batadv_tt_local_create(struct net_device *mesh_iface, const u8 *addr,
 	return tt_local;
 }
 
+/* flags of a local TT entry which depend on the packets of the client */
+#define BATADV_TT_LOCAL_DYNAMIC_MASK \
+	(BATADV_TT_CLIENT_WIFI | BATADV_TT_CLIENT_ISOLA)
+
+/**
+ * batadv_tt_local_dynamic_flags() - get the dynamic flags of a local client
+ * @bat_priv: the bat priv with all the mesh interface information
+ * @iif_is_wifi: whether the client is connected via a wifi interface
+ * @mark: the value contained in the skb->mark field of the received packet (if
+ *  any)
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
 /**
  * batadv_tt_local_refresh_locked() - refresh a local TT entry
  * @bat_priv: the bat priv with all the mesh interface information
  * @tt_local: the local TT entry to refresh
- * @iif_is_wifi: whether the client is connected via a wifi interface
- * @mark: the value contained in the skb->mark field of the received packet (if
- *  any)
+ * @dynamic_flags: the dynamic flags the entry has to carry
  * @announce: whether an ADD event has to be queued even when no announced
  *  flag was modified
  * @roamed_back: set to true when the client returned to its original location
@@ -1055,7 +1119,7 @@ batadv_tt_local_create(struct net_device *mesh_iface, const u8 *addr,
 static bool
 batadv_tt_local_refresh_locked(struct batadv_priv *bat_priv,
 			       struct batadv_tt_local_entry *tt_local,
-			       bool iif_is_wifi, u32 mark, bool announce,
+			       u16 dynamic_flags, bool announce,
 			       bool *roamed_back)
 {
 	struct batadv_tt_common_entry *common = &tt_local->common;
@@ -1063,7 +1127,6 @@ batadv_tt_local_refresh_locked(struct batadv_priv *bat_priv,
 	bool readded = false;
 	bool roamed = false;
 	u8 remote_flags;
-	u32 match_mark;
 	u16 flags;
 	u32 i;
 
@@ -1099,21 +1162,8 @@ batadv_tt_local_refresh_locked(struct batadv_priv *bat_priv,
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
@@ -1160,7 +1210,8 @@ batadv_tt_local_refresh_locked(struct batadv_priv *bat_priv,
  *  any)
  * @roamed_back: set to true when the client returned to its original location
  *
- * See batadv_tt_local_refresh_locked() for the actual refresh.
+ * See batadv_tt_local_refresh_locked() for the actual refresh. The hash bucket
+ * list_lock is only taken when the entry has to be modified or announced.
  *
  * An entry whose modification could not be announced stays in its previous
  * state. The refresh is then retried with the next packet of the client.
@@ -1176,14 +1227,22 @@ batadv_tt_local_refresh(struct batadv_priv *bat_priv,
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
@@ -1192,8 +1251,8 @@ batadv_tt_local_refresh(struct batadv_priv *bat_priv,
 		return -ENOENT;
 	}
 
-	if (!batadv_tt_local_refresh_locked(bat_priv, tt_local, iif_is_wifi,
-					    mark, false, roamed_back))
+	if (!batadv_tt_local_refresh_locked(bat_priv, tt_local, dynamic_flags,
+					    false, roamed_back))
 		ret = -ENOMEM;
 
 	spin_unlock_bh(list_lock);
@@ -1232,8 +1291,12 @@ static bool batadv_tt_local_insert(struct batadv_priv *bat_priv,
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
@@ -1249,8 +1312,8 @@ static bool batadv_tt_local_insert(struct batadv_priv *bat_priv,
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

