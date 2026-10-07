Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE5F4CA5FF1
	for <batman@archiver.kernel.org>; Wed,  7 Oct 2026 10:32:29 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 2B9D984441
	for <batman@archiver.kernel.org>; Wed, 07 Oct 2026 12:32:28 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1791369148;
 b=yA8rs35vfm1tnkzLFJ6u4UFPxfQHVqVY/GRSiAoodfvmkIpAqSv85+j7Xjf6A5wt7liQX
 qaSeSxY9zSyFc0VxCtbPr2uOFKQGGTE0WPfF7fwvjtZ2E32s8fKRfsAnRjPJq7Re62jk1Gi
 u2uQeWVpE6Ro+eOnEBnBDJO5xSHCl4c=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1791369148; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=aenx85PlDuyBivIvAMMpWUqbZeDnMCuPnxUKQT8K9+k=;
 b=fbkxdzyGobtN3cU7Sue96wHGlFgK5oAURobVxKWFmWyGEBF55x+mqgNpl4l5owUTM7RhO
 a+YonosnF3kwLxFgQNCGxduORvosaBXYa+OxP3eBE+2e9OLlfM7MPUo3VS6t2xxIC/L5t+M
 Y8yKZtE2MvgYdfWeEB5kyR0VgYiIPvw=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id CFB6684115
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 07 Oct 2026 12:30:34 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1791369044;
	b=QNdBQxJ0JBlPuvsKDacHxUinVCduamXDlyMagrzust1PKuUlnSBMi7xvt77gkx6KahOqgZ
	TEpp/dBHBODAYICRTL7dUbIvGfcJWPBShkapoYkLuPr8jXB4dyY7zD2Zi9CU9qlecPlTvZ
	4o830uLQZ2I2WOejX/j8TLt3FdnZJBY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1791369044;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=aenx85PlDuyBivIvAMMpWUqbZeDnMCuPnxUKQT8K9+k=;
	b=s51OgKy94FDbRJxZwkeUgKnZlVoAaYQkiS9apYqb7mY00CTT/QcR3AZ7Q7u8x0DcOlr4UD
	0rVATrJghyxHq5BrM83cxcOIhFwmsbGwlQt0vE/Io5RHMp2ddcimKN0s951+dN7UKpIvlx
	vErrgHdt8MqmZo88+Xu+BLumayFKQcM=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=c6nhVgSq;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 71C4F206D6;
	Wed, 07 Oct 2026 10:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1791369034;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aenx85PlDuyBivIvAMMpWUqbZeDnMCuPnxUKQT8K9+k=;
	b=c6nhVgSqayn9Jt27YEYlVK0BfLUhjPXssWRsWcB7zahO1nqiFA+9m0s8QD921O7nk1e9v9
	w4NLtlUkIngGfMjM+gLLlKUZ0cMXcQ8Y7LHqr8MFCA806Bgkfzado7fXKySNz9BQ7LvvPB
	KfbpgWPEWNRAO6IAeY2SthH3hXT6uiQ=
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 07 Oct 2026 12:29:47 +0200
Subject: [PATCH batadv 3/4] batman-adv: tt: avoid list_lock for unchanged
 local clients
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261007-tt-avoid-unhashed-event-v1-3-01c763657916@narfation.org>
References: <20261007-tt-avoid-unhashed-event-v1-0-01c763657916@narfation.org>
In-Reply-To: 
 <20261007-tt-avoid-unhashed-event-v1-0-01c763657916@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5229; i=sven@narfation.org;
 h=from:subject:message-id; bh=bABv0YU28kO2Cx2jSOpvJDNaiYTIE1eQEZ3Kl3hsNGI=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFnH5FUspa33bLOKSfpxi/P7uStdK11yM+8+v3f2BIPHY
 fbfqkV+HaUsDGJcDLJiiix7ruSf38z+Vv7ztI9HYeawMoEMYeDiFICJqAcyMhxV+CZxI2rZAtOL
 0Y2sNypamyfv2b2N92/LMd04uSsCVSKMDPs/CksoTDgicOCI4UVBreCMLKEsztDfbs6siU6Ouwp
 l+QE=
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: GZPSRY6ZVU7ZY3TNCV7PGEDCAUFY27CE
X-Message-ID-Hash: GZPSRY6ZVU7ZY3TNCV7PGEDCAUFY27CE
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/GZPSRY6ZVU7ZY3TNCV7PGEDCAUFY27CE/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

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
index a10345a1..e8b0de51 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -983,6 +983,72 @@ batadv_tt_local_create(struct net_device *mesh_iface, const u8 *addr,
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
@@ -1010,16 +1076,24 @@ batadv_tt_local_refresh(struct batadv_priv *bat_priv,
 	spinlock_t *list_lock; /* protects write access to the hash lists */
 	struct batadv_tt_common_entry *common = &tt_local->common;
 	struct batadv_hashtable *hash = bat_priv->tt.local_hash;
+	u16 dynamic_flags;
 	u16 event_flags;
 	u8 remote_flags;
-	u32 match_mark;
 	u32 i;
 
+	dynamic_flags = batadv_tt_local_dynamic_flags(bat_priv, iif_is_wifi,
+						      mark);
+
+	tt_local->last_seen = jiffies;
+
+	/* fast path: nothing to modify or to announce */
+	if (!announce &&
+	    !batadv_tt_local_refresh_needed(tt_local, dynamic_flags))
+		return true;
+
 	i = batadv_choose_tt(common, hash->size);
 	list_lock = &hash->list_locks[i];
 
-	tt_local->last_seen = jiffies;
-
 	spin_lock_bh(list_lock);
 
 	/* the entry was removed from the local table after it was looked up */
@@ -1058,21 +1132,8 @@ batadv_tt_local_refresh(struct batadv_priv *bat_priv,
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

