Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5C96CA6007
	for <batman@archiver.kernel.org>; Thu,  8 Oct 2026 14:33:57 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 4625D842A6
	for <batman@archiver.kernel.org>; Thu, 08 Oct 2026 16:33:56 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1791470036;
 b=mP1uNqSmJQnyfydwJRJQp8ogrYmu4VZRvKt6x0CsiJnKBkmjaNWhFkg8yEU+rkhhUl8jc
 IU7PweNFXc5hrHYWKec/uM8U6ShrH8NPnoLZweQGqf57Ac9PxYdRv1q4vqgKZ4ENM1RZBpj
 430LLCbnhyN0qe0Kv9VYuSpxzq635qg=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1791470036; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=8xNrLuw14h2y0RW5h8MbNdTMqy8zOe5muR60v2T6uoI=;
 b=bWn8XQm/dZSsT9TgHiB4ssn/rIPdTdI96vGrZl83bLBgpu11EBvbkOsim0ZYvFk4Isdqa
 RJTyc9kn50YYSGhzJ+4EqPKqTC5ALnjZFpX5SzZZneZmPQS87eVdaSMDDXQrmJKYrehH+g3
 bEB3hndPEho9tZpSAo69a9gK+DsImWg=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 3544583F06
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 08 Oct 2026 16:30:53 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1791469853;
	b=1aQ4yqpSwTfT1UA6wYhmI+yt4jvxKmXrJmJwrBIUcBL0/2EvliasucFh5Y7EDDWzFg/I6j
	tsI3+ogCq8SmJn+BTJFm0ZYPqk5ILoQwyNJSroY/QVjyZi12M9GTpkUCsO5nUv4AfaaImm
	o5EU07ANYsJLC8yaVa7RDZjMqO1d7nw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1791469853;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=8xNrLuw14h2y0RW5h8MbNdTMqy8zOe5muR60v2T6uoI=;
	b=wxd2gA9C7KHNZe7aBfpZJoEpTE889+fdtGNDH441dH1Dqneo97x3/eXElV4zW25QC3y+/1
	ZLMId4hPMoWX0I538ARdCwtA3v185/+TtHmow+uqbFAXOMt+BhS98khi5pv9w1rF35lZB7
	HLtWlF9HOxM2KaNyYAoXQ+fliiDvuek=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=eIZBRDBE;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id EA0A4202AD;
	Thu, 08 Oct 2026 14:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1791469853;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8xNrLuw14h2y0RW5h8MbNdTMqy8zOe5muR60v2T6uoI=;
	b=eIZBRDBEI5al6ckbrZtp1ARzEVDk3WsUA22uFOJ9KoACfHsXtLVWbaMnLpmxZzO4s3En35
	wDvyP88LfBzT4drw/vm3P4c4Rps3ZBAY7OGjQZjgCL/C8Cyv6hwjM/moSKEYkXOMDe32l0
	UnBiHgQSOfKM6KvwOYJRFXWJWmrgY4w=
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 08 Oct 2026 16:30:12 +0200
Subject: [PATCH batadv v2 7/8] batman-adv: tt: avoid list_lock for
 unchanged local clients
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261008-tt-avoid-unhashed-event-v2-7-7c4eed81606d@narfation.org>
References: <20261008-tt-avoid-unhashed-event-v2-0-7c4eed81606d@narfation.org>
In-Reply-To: 
 <20261008-tt-avoid-unhashed-event-v2-0-7c4eed81606d@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5211; i=sven@narfation.org;
 h=from:subject:message-id; bh=ns2bmlg1rH1Fvo/NBn6WkQsMIzDwU1TlA76wnce+MDQ=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFnHV3zQ7jHdk3n0vPa/R+8uy/MJ8bCrJE1TZDFqWrWzQ
 GCZ45yNHaUsDGJcDLJiiix7ruSf38z+Vv7ztI9HYeawMoEMYeDiFICJ5Pkw/HeewLKXpcrtAefr
 m7PPlgXceRVd8b/j67TJK6PtRcO+TlFiZHj94rFO0/pzjRlFp5yvvrLd0nd5yrIWhQOv9eRXTzO
 SM+AAAA==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: 6VKYONJQZQPPFDLTQTNRZREK6QOMG2CZ
X-Message-ID-Hash: 6VKYONJQZQPPFDLTQTNRZREK6QOMG2CZ
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/6VKYONJQZQPPFDLTQTNRZREK6QOMG2CZ/>
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
index 3f1d6bea..f6b50abf 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -1000,6 +1000,72 @@ batadv_tt_local_create(struct net_device *mesh_iface, const u8 *addr,
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
@@ -1027,15 +1093,23 @@ batadv_tt_local_refresh(struct batadv_priv *bat_priv,
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
@@ -1076,21 +1150,8 @@ batadv_tt_local_refresh(struct batadv_priv *bat_priv,
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

