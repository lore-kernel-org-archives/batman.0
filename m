Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0970B606A334
	for <batman@archiver.kernel.org>; Mon, 16 Nov 2026 20:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.a=rsa-sha256 header.s=20121 header.b=dy2VSkpE
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 8BEBC84223
	for <batman@archiver.kernel.org>; Mon, 16 Nov 2026 21:06:50 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1794859610;
 b=h+tYepKVOHUAJxzRJb3pRF9UzouIrcQiNmkjWryyPV37Y11vpG9pPF24+Ct4hh/zLXgGE
 5nXD+J6AMo0ScHgH+0u6/TGSqriBERVwJSw9dmsz/1Swq/GbNwL6YffU4Oj2yOrEGLH5uBT
 mD/56E6+K5MchUV/s1OUzYOz20BUA1Q=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1794859610; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=hPplmwPxZPM+iEimfRg/Ggnp6DNibTGqcnVtfzscElE=;
 b=xnlsnzAY/NBEYX6Ba/o5tp2vNkULhJFX2AiEJE7glj2T0MFkCW7yce934TTI1Rz65s0Nk
 beAdwHRVJgjL52yJP9/YhtGkZ8Ttac9oPWm+FAXtxrFHeiUNxtoKLMlyDFgJKonAwQdqyr+
 8Qm/NzHsZXOo6Jj9WL4CfVWYCcXC0A4=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 64824840A2
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 16 Nov 2026 21:03:31 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1794859421;
	b=BMN7V5EciqfZ26UT7RQcikeNNqI1hrzFUmc68/Q0wEBvPhnNjQLGnXQJ7R8+MFZN/RDfRJ
	+7psQiAArGDRcytXGSz+2JlgmlW6BaaS9xswaHQCHOYvSEXB7PH1rv5PkLB98yJkiYHAb7
	t5eRB7+LBIq9crXVSzgygjPToKVWeO0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1794859421;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=hPplmwPxZPM+iEimfRg/Ggnp6DNibTGqcnVtfzscElE=;
	b=qRRZG4E0ohUfxpM4iV4PTVX67+hG1ZpvjAeHa77ee0bgoWk36XQ/QKPuQ49/ldMOMyuMTL
	L32BPCLjzEODTm8c239l9u2XR/LAemSLQ5FfO0pRwbCoeex40AvAuE8KoRKK3zDozmKXwt
	z/jOuwPVvmiM7d07h6NAEyPTOB5XwJg=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=dy2VSkpE;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org
Received: by dvalin.narfation.org (Postfix) id F330320FF9;
	Mon, 16 Nov 2026 20:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1794859409;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hPplmwPxZPM+iEimfRg/Ggnp6DNibTGqcnVtfzscElE=;
	b=dy2VSkpE2dWnhK1v9E+tGns/Gf6LzOwGCGaNy1t/92wxbj8NLw1WEC5N2m3+vFXuhrhNxp
	FM2oo0U4yAsmnj+qHgATvyAOKFwSGZIj4rAi2cCLFj65x+GDMmPTYLWSIbZUJn3RD01iTV
	NauHRAMqHH8XCFCdUP92CU6b5QjTkpE=
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 16 Nov 2026 21:03:06 +0100
Subject: [PATCH batadv v4 05/11] batman-adv: tt: remove unannounced local
 entries via pending state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-tt-avoid-unhashed-event-v4-5-42c6bb518123@narfation.org>
References: <20261116-tt-avoid-unhashed-event-v4-0-42c6bb518123@narfation.org>
In-Reply-To: 
 <20261116-tt-avoid-unhashed-event-v4-0-42c6bb518123@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3803; i=sven@narfation.org;
 h=from:subject:message-id; bh=2ZIVmcRYWEZ5FSFXhPvV89s8i28lloqAg3Lj5wejepg=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFm/E+ueTprnfrvbzWulauYP4537r/28N/eEa1vpAv1ze
 t32Li8SO0pZGMS4GGTFFFn2XMk/v5n9rfznaR+PwsxhZQIZwsDFKQATYZ/L8E/llNKt7btYqqaG
 mS2yupLdn7h8qUfcGgmdUJNFzdPELh5kZFirs+PcW8ftIeue/Q8Uer/ZYeIyWdc5z5hTN9gudv/
 8IoQRAA==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: KEWJLIVFD3DC3FL6LK6Y5WAR2NSKGLEL
X-Message-ID-Hash: KEWJLIVFD3DC3FL6LK6Y5WAR2NSKGLEL
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/KEWJLIVFD3DC3FL6LK6Y5WAR2NSKGLEL/>
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

batadv_tt_local_remove_entry() unhashes an entry which still carries
BATADV_TT_CLIENT_NEW immediately because it was not yet announced to the
other nodes. But the flag is only cleared at the end of the commit. The ADD
of the entry might therefore already have been taken for the next TTVN when
the flag is checked.

Handle such an entry like an already announced one: queue the DEL and mark
the entry as BATADV_TT_CLIENT_PENDING. It is then removed from the local
table when the pending entries are purged by the next commit.
batadv_tt_local_purge_pending_clients() already takes care of not
uncounting an entry which was never counted.

This also leaves the commit as the only place which finishes the removal of
a local entry. A follow-up change relies on this to apply exactly the
announced changes to the local table.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/translation-table.c | 35 +++++------------------------------
 1 file changed, 5 insertions(+), 30 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 6a3c207a..00e22c4c 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -1792,13 +1792,11 @@ batadv_tt_local_set_pending(struct batadv_priv *bat_priv,
  * @roaming: true if the deletion is due to a roaming event
  * @curr_flags: pointer to store the flags of the entry before it was removed
  *
- * For an already announced entry, the (roamed) DEL change is queued and the
- * entry is marked as BATADV_TT_CLIENT_PENDING by batadv_tt_local_set_pending().
- * It stays in the local table until the next ttvn increment.
- *
- * An entry which still carries BATADV_TT_CLIENT_NEW was added right after the
- * last ttvn increment and was not (yet) announced. It is therefore removed
- * from the local table immediately.
+ * The (roamed) DEL change is queued and the entry is marked as
+ * BATADV_TT_CLIENT_PENDING by batadv_tt_local_set_pending(). It stays in the
+ * local table until the DEL is committed with the next ttvn increment. This
+ * also applies to an entry which still carries BATADV_TT_CLIENT_NEW because its
+ * ADD might already have been taken for the next ttvn.
  *
  * An entry which was already removed from the local table after it was looked
  * up is ignored and BATADV_NO_FLAGS is stored in @curr_flags.
@@ -1817,7 +1815,6 @@ batadv_tt_local_remove_entry(struct batadv_priv *bat_priv,
 	spinlock_t *list_lock; /* protects write access to the hash lists */
 	struct batadv_tt_common_entry *common = &tt_local_entry->common;
 	struct batadv_hashtable *hash = bat_priv->tt.local_hash;
-	bool unhashed = false;
 	u16 flags;
 	u32 i;
 
@@ -1842,24 +1839,6 @@ batadv_tt_local_remove_entry(struct batadv_priv *bat_priv,
 		if (roaming)
 			common->flags |= BATADV_TT_CLIENT_ROAM;
 
-		if (common->flags & BATADV_TT_CLIENT_NEW) {
-			batadv_dbg(BATADV_DBG_TT, bat_priv,
-				   "Deleting local tt entry (%pM, vid: %d): %s\n",
-				   common->key.addr,
-				   batadv_print_vid(common->key.vid), message);
-
-			hlist_del_init_rcu(&common->hash_entry);
-			atomic_inc(&hash->generation);
-
-			/* The entry was never announced and was therefore
-			 * never counted in the local table size.
-			 */
-			__batadv_tt_local_event(bat_priv, common,
-						common->flags | BATADV_TT_CLIENT_DEL);
-			unhashed = true;
-			break;
-		}
-
 		flags = BATADV_TT_CLIENT_DEL;
 		if (roaming)
 			flags |= BATADV_TT_CLIENT_ROAM;
@@ -1869,10 +1848,6 @@ batadv_tt_local_remove_entry(struct batadv_priv *bat_priv,
 	}
 
 	spin_unlock_bh(list_lock);
-
-	/* drop reference of removed hash entry */
-	if (unhashed)
-		batadv_tt_local_entry_put(tt_local_entry);
 }
 
 /**

-- 
2.47.3

