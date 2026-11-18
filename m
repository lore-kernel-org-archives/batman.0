Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ADB3606A31C
	for <batman@archiver.kernel.org>; Wed, 18 Nov 2026 11:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.a=rsa-sha256 header.s=20121 header.b=KNlNgUAH
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 877BC84395
	for <batman@archiver.kernel.org>; Wed, 18 Nov 2026 12:44:53 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1795002293;
 b=mXaYZ0j7v7u1PbagwPuclAeU4xpsCCeZ6BSOLsCjjRXoWjsl4qUCDW9Zwy4kQ7xsJF31J
 iUfCZOV+0no9gqrk5cga7v2YTE347YcjxpuOSV8FV5RSi/9Uvao4eMuQ14l1pJP3LtsZ1Hc
 7lAeHV6RKW+b/SStzsRN+7s+rObOdxg=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1795002293; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=gUXeiwBh/dUD7Oeryb67ZgL3po3QyjVyPJW+z9PKL2Q=;
 b=kcAcYHees1Mne2H1x7fX4ZpxSsgXwFCjSqZAjFRgwo5P7IN/XohHV/buLUXzrIwa8Rknb
 xgTEwXfYcQbGL4rxLIlSlx4xVOppLv6okdUWHs0uQRP/HwH/cODU3KtBFRMSvSE1e3dI/T3
 AYcxhuhlF/flzh2LSvjTlm0ay86MMWk=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id CF4058428B
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 18 Nov 2026 12:42:11 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1795002131;
	b=RRpy/m15h94Hd7Fa+9R+VdIbBl27Zs4w440l6bcFKXooSmvrESIHtvfgNoppWm6YW6taTa
	e9gWT1vdkysXreJYLrMOXCYjdd/PkThVQr7l9dqGzCa9CIVU7O/tRWWjGSuyN0i1eIq/3t
	76nVfab533fx+Z9oAektqYefSJ77PYk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1795002131;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=gUXeiwBh/dUD7Oeryb67ZgL3po3QyjVyPJW+z9PKL2Q=;
	b=bGV9lbUaRhqs5ll6h+ku/R/UUi27XTs5rjQ5cZ77Nj7XwWwBmNZ2/ADHQoZ7uyG+Rugb67
	ZhYls888xI55yslianuhDHcnSP6LiFkXgm8+scjbMwh7g4p57QzCtazO4G78zx/FLI8JQ9
	CrNaH2TQs2CJNJNr7IFbC0TRALpWYEo=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=KNlNgUAH;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org
Received: by dvalin.narfation.org (Postfix) id 72C441FE9A;
	Wed, 18 Nov 2026 11:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1795002131;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gUXeiwBh/dUD7Oeryb67ZgL3po3QyjVyPJW+z9PKL2Q=;
	b=KNlNgUAH5YzjtYictYNjocLm4wCS2w2/qjBvrUdA59TwiY53uQCQ9EIo7trRFzgppEKADd
	U763iVP+bc5cFqf9ZK/E+wZSr62agUAgpoBKz5uxnXL4uFr8Z/ISB3fIUB7qtPVCUnwVcw
	znho4Vpt9xXDgjXvJeFaDqQeQpdeR9c=
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 18 Nov 2026 12:41:55 +0100
Subject: [PATCH batadv v5 05/11] batman-adv: tt: remove unannounced local
 entries via pending state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261118-tt-avoid-unhashed-event-v5-5-bce9ead803e6@narfation.org>
References: <20261118-tt-avoid-unhashed-event-v5-0-bce9ead803e6@narfation.org>
In-Reply-To: 
 <20261118-tt-avoid-unhashed-event-v5-0-bce9ead803e6@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3803; i=sven@narfation.org;
 h=from:subject:message-id; bh=TFetUHuJrY1sbAcq/nZ04vMyjzLG+g+/GnKP05oiImI=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFl/+1nWeCe91rD5cbtqv55EbRnvMV297Kcrd4fNLn9Yd
 H/LewXLjlIWBjEuBlkxRZY9V/LPb2Z/K/952sejMHNYmUCGMHBxCsBEGn4y/I/bMe+22/+MrK1f
 WD97lJZ5mU76OC1uz8Z5VWWnZfi6g/QYGY60xizcOKv2jZ+M371Tv53O/QxneeCvalDPuU5BUVc
 4iR8A
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: 54PFPEH65WRTID4RRXR73DEJAUNUOJDQ
X-Message-ID-Hash: 54PFPEH65WRTID4RRXR73DEJAUNUOJDQ
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/54PFPEH65WRTID4RRXR73DEJAUNUOJDQ/>
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
index a5b34095..ab8b9699 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -1798,13 +1798,11 @@ batadv_tt_local_set_pending(struct batadv_priv *bat_priv,
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
@@ -1823,7 +1821,6 @@ batadv_tt_local_remove_entry(struct batadv_priv *bat_priv,
 	spinlock_t *list_lock; /* protects write access to the hash lists */
 	struct batadv_tt_common_entry *common = &tt_local_entry->common;
 	struct batadv_hashtable *hash = bat_priv->tt.local_hash;
-	bool unhashed = false;
 	u16 flags;
 	u32 i;
 
@@ -1848,24 +1845,6 @@ batadv_tt_local_remove_entry(struct batadv_priv *bat_priv,
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
@@ -1875,10 +1854,6 @@ batadv_tt_local_remove_entry(struct batadv_priv *bat_priv,
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

