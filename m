Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3DA9606A335
	for <batman@archiver.kernel.org>; Mon, 16 Nov 2026 20:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.a=rsa-sha256 header.s=20121 header.b=ykTUizy1
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 5744D83CA1
	for <batman@archiver.kernel.org>; Mon, 16 Nov 2026 21:04:11 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1794859451;
 b=aejilw0hRoWIZB4c7XgXdt59DujbAyNg99O2Wvvq6TEi+S84Px02kRfZufb9WUjM7Yu5H
 a8rNahqTfKiFLDG5C8ZxM6soitLdLylMjmx+/FjKN5VcMVpONviQQ0nJcPX9y8g8xcj3Jjj
 o2anMiXMr5TezQ4IkPGioMKZNgAcwI0=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1794859451; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=caVCv5vHJvq6VQi3L0aDhP2CEuphKAwT5ixfbXlHYKA=;
 b=j+D1VauKpe5l3Z7t6oJ/ClrT4WCTCaFzm/KUd0fTeRqmCFFgXQmAB0HxSNOkVuEAjMNEX
 u0Ny8M2Dp8Je3yTxxLiW+b8N2FykvrvrsFlZPZ5bRo6APBon1BRpDem6EwdWD+SbTf6SJWW
 XDe4jPBCCyqhsScbC0RIkoTUkAv58S8=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 503B38040B
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 16 Nov 2026 21:03:21 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1794859411;
	b=D2w5O5LdSU2gAQ/8PYcjc66vfeC4bAlHpu1rUvK+Rtn7l3sk1EwE8dpVkda0jmw6GppHW1
	kSKH5yy0YGTNGBindXjt2vZjh2Hh2HseeIDGl0cy1oOg+rr2lV7zBMC5CDk1x7QOGOpZLy
	HK0YOzyACDSE0bakNCz75f12OSQFb4Q=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1794859411;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=caVCv5vHJvq6VQi3L0aDhP2CEuphKAwT5ixfbXlHYKA=;
	b=UxVi4w1UiyUEkkWpxuVnswW6LFzYGIJ2EWEmrZhKWFYKca0U4Z85N+Osb2P+3ST7/eoR4f
	rcuzpfpTaXMqk6IH0I7hW5NZKlpNwc5MdPMBOiy4xzHZliyBc5V+AQ5Y+PU64uF1uDyJu9
	v/GbWMOQzclK2sC+d5eIUe9wfMuX8IM=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=ykTUizy1;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org
Received: by dvalin.narfation.org (Postfix) id ECB3820ECB;
	Mon, 16 Nov 2026 20:03:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1794859401;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=caVCv5vHJvq6VQi3L0aDhP2CEuphKAwT5ixfbXlHYKA=;
	b=ykTUizy1Lga4p6Bq4AFhEYZk8tjPoKM5wTGfG4sS7Pw+KGzP9jbzNPapPTsN+hVSqbU4ZT
	2/OfkVSmTPkWcId8/pS0HEqdCCBVM8ZH+Qcp5namMJsyE2hU1PfBnGZP+imKvNh2oVxeVB
	FYInI4KNFEacMfR6UIYXfo4Xu3+FLG4=
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 16 Nov 2026 21:03:02 +0100
Subject: [PATCH batadv v4 01/11] batman-adv: tt: unhash local entries with
 hlist_del_init_rcu()
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-tt-avoid-unhashed-event-v4-1-42c6bb518123@narfation.org>
References: <20261116-tt-avoid-unhashed-event-v4-0-42c6bb518123@narfation.org>
In-Reply-To: 
 <20261116-tt-avoid-unhashed-event-v4-0-42c6bb518123@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1849; i=sven@narfation.org;
 h=from:subject:message-id; bh=m8vo6aAoIy2P9ah5p4RwgKQpk7oMqctZkieOcHN8fLA=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFm/E2uPVr7tvXXwDOscmZjIBTlOxd+Wxqr8Fp2suETQi
 Vno6UqDjlIWBjEuBlkxRZY9V/LPb2Z/K/952sejMHNYmUCGMHBxCsBEHjowMnRNPbn5ceKPuSb/
 WyoPb0m/dECB6dsLLf5HCgeNikUOOQoxMjyfz3kx1sfb5VX7x6kO1TNKs2b5KC/LU+y4fXGJYeB
 8AwYA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: MM4FBSWR2RBDLZNNJHDTOS63HYBHHBHA
X-Message-ID-Hash: MM4FBSWR2RBDLZNNJHDTOS63HYBHHBHA
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/MM4FBSWR2RBDLZNNJHDTOS63HYBHHBHA/>
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

A context which looked up a local TT entry via RCU has no way to find out
whether the entry was removed from the local hash in the meantime.
hlist_del_rcu() leaves the pprev pointer of the node untouched and
hlist_unhashed() therefore still reports the entry as hashed.

Use hlist_del_init_rcu() when a local entry is unhashed by
batadv_tt_local_purge_pending_clients() and batadv_tt_local_table_free().
hlist_unhashed() can then be used under the hash bucket list_lock to check
whether an entry is still part of the local table.

batadv_tt_local_remove_now() still unhashes via batadv_hash_remove(). It is
converted when it is merged into the locked removal path.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/translation-table.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index b9407ad5..fabc4879 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -1940,7 +1940,7 @@ static void batadv_tt_local_table_free(struct batadv_priv *bat_priv)
 		spin_lock_bh(list_lock);
 		hlist_for_each_entry_safe(tt_common_entry, node_tmp,
 					  head, hash_entry) {
-			hlist_del_rcu(&tt_common_entry->hash_entry);
+			hlist_del_init_rcu(&tt_common_entry->hash_entry);
 			tt_local = container_of(tt_common_entry,
 						struct batadv_tt_local_entry,
 						common);
@@ -4517,7 +4517,7 @@ static void batadv_tt_local_purge_pending_clients(struct batadv_priv *bat_priv)
 					   tt_common->key.addr,
 					   batadv_print_vid(tt_common->key.vid));
 
-				hlist_del_rcu(&tt_common->hash_entry);
+				hlist_del_init_rcu(&tt_common->hash_entry);
 				atomic_inc(&hash->generation);
 
 				/* An entry which still carries BATADV_TT_CLIENT_NEW was

-- 
2.47.3

