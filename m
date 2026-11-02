Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52785606D811
	for <batman@archiver.kernel.org>; Mon,  2 Nov 2026 21:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=narfation.org header.i=@narfation.org header.a=rsa-sha256 header.s=20121 header.b=JFDT9Aw1
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id EF505843B7
	for <batman@archiver.kernel.org>; Mon, 02 Nov 2026 22:16:59 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1793654219;
 b=AcOHKiV155fVv3fa23Fdf2MFgexAsA1Q2KxkwR0fXdQtsp7J3un9bzoFLkH8eiq33ri9v
 H2bEaToyozrU39jlhskEilettOQZiuiJidOHq8BEdJNod7gLAGTxAC5a3u1xmKBQr38vde0
 MH4/XGt13slEMBkLirEIrugiI1rEiNQ=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1793654219; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=B0hoA0LzQgDM7oEzk2/wd3u22oJfI3B+3Jpn1c/UeGU=;
 b=bM9WZWaPs1tQnnRJdFI/JLcxAFxowZgyaWU+AlJnXlmhs4DqRUMfd3Ddp/FIX7JbZ/2y4
 zeyby+jDX/Yj6YjEsRETjWaJowuy2MUCLmWaMIbT43zPrL+7AfITandC2SQtCsSgsULOHb1
 9IwuesGCsw01wIf50C6m4Ya5+qDunZ8=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id F1D37843C3
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 02 Nov 2026 22:15:28 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1793654139;
	b=xpK/j/2BPzaC01tsU4/OZCHeVRRhq/N35FWwK7Mm3dPHk+o+hxNhvtj0EU+/vjyWrYwcMO
	ERDrhjJici4533Du6masAo9+PIH/ZnhzZrDNLNswv/ccVPlzVSL6O3PfqpM2I7w4EgIdCj
	3yAUgYS8joqjrXKSusS4MLrOTI7S/sw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1793654139;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=B0hoA0LzQgDM7oEzk2/wd3u22oJfI3B+3Jpn1c/UeGU=;
	b=kiHRsBp4CqjtCGOkA5ymRNMDl/MbUKhaJ8/hRY1RvunSinsYVaqZYYasqT7RhfJUPz4EsX
	Pl1a3D+V/JqVVM/zSPz8qH/L4GK5NO0c98vX1+fs9XXosg3MiARwGc+T0Wxx9qLCVsHfIH
	L/U8QFcgZ2CcP+nB2xe+rLRWAx++7HE=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=JFDT9Aw1;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id B571122020;
	Mon, 02 Nov 2026 21:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1793654127;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B0hoA0LzQgDM7oEzk2/wd3u22oJfI3B+3Jpn1c/UeGU=;
	b=JFDT9Aw1rViaU/CiekOwsPC3cHJ7oJqbVJJ6IeTCvmbK1mbtRu26ZkbzoFuNxtkhBGTQwq
	KDAzL3VU/gDUD1UzPtUYTbYWYhMce/I1mOlnNdiaNZMrNqddLHMYifYZlW8Sub8aUVbsXi
	CzcVUE2zHLDLah7/yYO5UfnSKTZKru4=
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 02 Nov 2026 22:15:17 +0100
Subject: [PATCH batadv v3 2/3] batman-adv: tt: avoid list_lock for
 unchanged local clients
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-tt-avoid-unhashed-event-v3-2-f37f59c80b0d@narfation.org>
References: <20261102-tt-avoid-unhashed-event-v3-0-f37f59c80b0d@narfation.org>
In-Reply-To: 
 <20261102-tt-avoid-unhashed-event-v3-0-f37f59c80b0d@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5239; i=sven@narfation.org;
 h=from:subject:message-id; bh=o+/1tA7tPQw5hFcXttDzaKEB5/F1ij00PN0Gbjd2Rfg=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFkv/qYn9/aV3axxmudU1vm58+w14coKo39bJgRXsbAeD
 HBVzJXrKGVhEONikBVTZNlzJf/8Zva38p+nfTwKM4eVCWQIAxenAEzkKRMjQ8/mZ1wnzJObBCJY
 xdzPxGqY7A8/s8BkS/Am3g2P/omb32Bk+FW3bUOaqO4/2dg+e73FQlx3FOwsfYLWCjmIqUWt0dv
 KDAA=
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: QEEXGQADS2DZU5S72KJDANPM7RW3XQTS
X-Message-ID-Hash: QEEXGQADS2DZU5S72KJDANPM7RW3XQTS
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/QEEXGQADS2DZU5S72KJDANPM7RW3XQTS/>
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
 net/batman-adv/translation-table.c | 97 +++++++++++++++++++++++++++++++-------
 1 file changed, 79 insertions(+), 18 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 4573c467..ecbf50ea 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -1029,6 +1029,72 @@ batadv_tt_local_create(struct net_device *mesh_iface, const u8 *addr,
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
+	u16 flags = 0;
+	u32 match_mark;
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
  * batadv_tt_local_refresh() - refresh a local TT entry of an active client
  * @bat_priv: the bat priv with all the mesh interface information
@@ -1056,15 +1122,23 @@ batadv_tt_local_refresh(struct batadv_priv *bat_priv,
 	spinlock_t *list_lock; /* protects write access to the hash lists */
 	struct batadv_tt_common_entry *common = &tt_local->common;
 	struct batadv_hashtable *hash = bat_priv->tt.local_hash;
+	u16 dynamic_flags;
 	u8 remote_flags;
-	u32 match_mark;
 	u32 i;
 
+	dynamic_flags = batadv_tt_local_dynamic_flags(bat_priv, iif_is_wifi,
+						      mark);
+
+	WRITE_ONCE(tt_local->last_seen, jiffies);
+
+	/* fast path: nothing to modify or to announce */
+	if (!announce &&
+	    !batadv_tt_local_refresh_needed(tt_local, dynamic_flags))
+		return true;
+
 	i = batadv_choose_tt(&common->key, hash->size);
 	list_lock = &hash->list_locks[i];
 
-	WRITE_ONCE(tt_local->last_seen, jiffies);
-
 	spin_lock_bh(list_lock);
 
 	/* the entry was removed from the local table after it was looked up */
@@ -1107,21 +1181,8 @@ batadv_tt_local_refresh(struct batadv_priv *bat_priv,
 		 */
 		remote_flags = common->flags & BATADV_TT_REMOTE_MASK;
 
-		if (iif_is_wifi)
-			common->flags |= BATADV_TT_CLIENT_WIFI;
-		else
-			common->flags &= ~BATADV_TT_CLIENT_WIFI;
-
-		/* check the mark in the skb: if it's equal to the configured
-		 * isolation_mark, it means the packet is coming from an
-		 * isolated non-mesh client
-		 */
-		match_mark = (mark & bat_priv->isolation_mark_mask);
-		if (bat_priv->isolation_mark_mask &&
-		    match_mark == bat_priv->isolation_mark)
-			common->flags |= BATADV_TT_CLIENT_ISOLA;
-		else
-			common->flags &= ~BATADV_TT_CLIENT_ISOLA;
+		common->flags &= ~BATADV_TT_LOCAL_DYNAMIC_MASK;
+		common->flags |= dynamic_flags;
 
 		if (remote_flags ^ (common->flags & BATADV_TT_REMOTE_MASK))
 			announce = true;

-- 
2.47.3

