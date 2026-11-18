Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5165D606A31C
	for <batman@archiver.kernel.org>; Wed, 18 Nov 2026 11:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=narfation.org header.i=@narfation.org header.a=rsa-sha256 header.s=20121 header.b=Xk6s4ODI
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 9D8168427B
	for <batman@archiver.kernel.org>; Wed, 18 Nov 2026 12:42:11 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1795002131;
 b=1dUrNhX+k91NxJ6n8H/Lje5eiX6xEnOJ9vFxo0Zh6TD5T1WjRoXtrzCrrURkFm2en9sQh
 WzIKeCv99sVgkp22+LMYZH7E8VQx+pQGmVKszqkTnq6Wp69i6Au1tT+aYhMjTb4d+Y2eKFc
 6XVNVmbeLk54dRtmJ/Gc13/q1bwd5nw=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1795002131; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=caVCv5vHJvq6VQi3L0aDhP2CEuphKAwT5ixfbXlHYKA=;
 b=bysm2RH5NowqaDnzgPzeat8OhK33NrMJAVjqQk81rp+wjqkreptCsgJtR+vNAjA2abv57
 rHUo+lVZDZ/f2vE1pwpXbouVvNV2IjJRiUrw0J9oOMDd+1A9lXSEtUGB5qlRSbGhDuFtFwa
 ZeH936xoMKrObUFfWrhx9obzMDvzz8o=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id CC4A88269F
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 18 Nov 2026 12:42:03 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1795002123;
	b=M8ZUpVxm77fseSGElfa/pbEf2ElE1nJh7d4KnquW48XL73o8JN6uoCrsTZH2P9T55UG9tW
	YTAjs1FpBS/fag9M5gXKH0VFLBrmNoCt7gfdW78ZSpTVj9giRJjRR2y867pZFcHe2LDawS
	a5FNDpwEKmieDQkABzrE+pv6mJexwS4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1795002123;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=caVCv5vHJvq6VQi3L0aDhP2CEuphKAwT5ixfbXlHYKA=;
	b=gotnucqc6Il9f7o3whE0yBWpMLUWCNKSDCl60gd0y9shPn+zRsCN8Y0/zSG/to7ZUzcGzc
	0y6eYCyWXs3GkS57uA/4IEY50WBP4lK31BxEyBkMvNpWjecxVRYrnoGj0n1m7B71ct/FxK
	91ticMduhwfBOaQkJyaaxhtsIS9Qfic=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=Xk6s4ODI;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org
Received: by dvalin.narfation.org (Postfix) id 71D1D20EAD;
	Wed, 18 Nov 2026 11:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1795002123;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=caVCv5vHJvq6VQi3L0aDhP2CEuphKAwT5ixfbXlHYKA=;
	b=Xk6s4ODIFrhusOOUgHGcriG+Nix5Enty8yAbjrVODJ57zeQDsfCaT4MiMIUUIEQ2+wN8Km
	CnsTiUGDCWbIM+AgAmPPyEjJTbY3ge+W7DQHGCQuYcwxIxn+IyznMiDGDaBbKj2AVKP8YE
	ciok9wLCzM6kvMA+1HJa+kMzNSkiHEs=
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 18 Nov 2026 12:41:51 +0100
Subject: [PATCH batadv v5 01/11] batman-adv: tt: unhash local entries with
 hlist_del_init_rcu()
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261118-tt-avoid-unhashed-event-v5-1-bce9ead803e6@narfation.org>
References: <20261118-tt-avoid-unhashed-event-v5-0-bce9ead803e6@narfation.org>
In-Reply-To: 
 <20261118-tt-avoid-unhashed-event-v5-0-bce9ead803e6@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1849; i=sven@narfation.org;
 h=from:subject:message-id; bh=m8vo6aAoIy2P9ah5p4RwgKQpk7oMqctZkieOcHN8fLA=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFl/+5lTFK4znAxunpz9dmKPpOZMv2WiyuKLLopcPhXyV
 NFLZV9hRykLgxgXg6yYIsueK/nnN7O/lf887eNRmDmsTCBDGLg4BWAi02MY/vB9O3u3Yt+X1Bmx
 1eHPd614+ydoVl0nY89u0RVTJ2nzmPIz/HfSD0txdnfgDZlY9/LuJZ/NSe0s9xeznd4TVyQld85
 mBhcA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: DYWDAJVKM4UJHUU5KIJF4DQQNUS75SLL
X-Message-ID-Hash: DYWDAJVKM4UJHUU5KIJF4DQQNUS75SLL
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/DYWDAJVKM4UJHUU5KIJF4DQQNUS75SLL/>
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

