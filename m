Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA8A3606A31A
	for <batman@archiver.kernel.org>; Mon, 23 Nov 2026 17:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.a=rsa-sha256 header.s=09092022 header.b=aSXbZnpz
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 66A6F84758
	for <batman@archiver.kernel.org>; Mon, 23 Nov 2026 18:20:26 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1795454426;
 b=bNgG97F4BcB0BFJ7BPpwq+j6hT5yrFHOS5PVZ3c+Y2cwSiFOR0R4BPH7X8olD22NQ7Zre
 wPrJUvSq+NTBNWyKcDq2GBzYTH8+UCIg6Qj3KEJjKhttbQIuKf4/OOZkfUeLXAnzB8wHwHt
 Tq7O3X+dYBcO6uWB7PKv61gebeDm66o=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1795454426; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=oJvHQFMgooA7UahwimsOb3OkFjRJ0W83iVe8uaAwcJo=;
 b=Mx4ylG5m61ST3As+UkgRpKYLx27ikMA7TkcNAlTjejeV+UNX6Aq1iRmKIAMOBkG9bjkcA
 lP/rn3RUKrvxJnAyPwKCoyHkqxOnJb49+fLSds5liO9UEzub7Ta7quYfmfrr0ZfWLyN4XtA
 C2f031o8/GUQ8KNVknu1RtjaNtL5lRo=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de
 [IPv6:2a01:4f8:c17:e8c0::1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 567D4830EF
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 23 Nov 2026 18:18:43 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1795454323;
	b=jAB/8Fxxu8jyutirJBrG/JFFPUKZBzfIGgYkdKELe3LI9zQsJ3Kj0pQTcrk+WhXHcTAoCN
	Gf9el4wQtP/XMAz6ylTw0GlDNdHDH6cASsTdDj0t+Xfpe5yVXBsftzYzYaaTZYNuw1Q7ze
	Lz1lT1/BVKtSrKCiUKkRvHfpTLhfe8k=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1795454323;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=oJvHQFMgooA7UahwimsOb3OkFjRJ0W83iVe8uaAwcJo=;
	b=Vr2cOOMzoyxTKGmnaWiyCLJ4vgckx/hCc6RINEnVymGaW1yHuJwH80QhCHWuau7g3XSKDk
	ALly0ECy8f57HTdFrDKUlIZ8c4+5b8MJ2i8v/x8VPqtxwdzdOc8Kdva1IsTRhxe/uKkaUS
	+JOesP1Hl4K9MA/z09T9DwhpPASjCq8=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=aSXbZnpz;
	dmarc=pass (policy=none) header.from=simonwunderlich.de;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 2a01:4f8:c17:e8c0::1 as permitted sender) smtp.mailfrom=sw@simonwunderlich.de
Received: from kero.packetmixer.de
 (p200300C59714C2e05a704819B6ba2dB4.dip0.t-ipconnect.de
 [IPv6:2003:c5:9714:c2e0:5a70:4819:b6ba:2db4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with UTF8SMTPSA id 61A1BFA3E2;
	Mon, 23 Nov 2026 18:18:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1795454321;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oJvHQFMgooA7UahwimsOb3OkFjRJ0W83iVe8uaAwcJo=;
	b=aSXbZnpzBuOvGm4Ekc6962RsfPVSRVOMkKFf24ZO4q1PKDwcYOvS3+01CtwP+Lp8C8UoED
	ZYfSRXARLYvs3+VlXrGZop48llPG22oU587wNC2iTE8VPJCkCnYacR26ZV0+B+RUvcnydh
	sjYoI1lGJcevePFeCfPgGvsLXGTMe9qGxY+7mu/FAVNzG8/6+4kJoE/WHcbvlNuBTPyzpu
	1DE93c+KzNlmptbMLNjHc6zz/B5qGsRVL9ydCj6RwQRkSedSCrAg6t05Cw/sFBCeRgDnGo
	7/gaqJ4/JUshZa8lHCMhzdVJIFccT8r8PmSCjxlu17mIH6UEl/cHrR677xgtRw==
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
Subject: [PATCH net-next 09/15] batman-adv: tt: remove unannounced local
 entries via pending state
Date: Mon, 23 Nov 2026 18:18:21 +0100
Message-ID: <20261123171827.3294525-10-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261123171827.3294525-1-sw@simonwunderlich.de>
References: <20261123171827.3294525-1-sw@simonwunderlich.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: 2UI6XW32A7PLL6YDIFVW6Q25R5WEIK2U
X-Message-ID-Hash: 2UI6XW32A7PLL6YDIFVW6Q25R5WEIK2U
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/2UI6XW32A7PLL6YDIFVW6Q25R5WEIK2U/>
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
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/translation-table.c | 35 +++++-------------------------
 1 file changed, 5 insertions(+), 30 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 2828e362640a..977f62c88da7 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -1745,13 +1745,11 @@ batadv_tt_local_set_pending(struct batadv_priv *bat_priv,
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
@@ -1770,7 +1768,6 @@ batadv_tt_local_remove_entry(struct batadv_priv *bat_priv,
 	spinlock_t *list_lock; /* protects write access to the hash lists */
 	struct batadv_tt_common_entry *common = &tt_local_entry->common;
 	struct batadv_hashtable *hash = bat_priv->tt.local_hash;
-	bool unhashed = false;
 	u16 flags;
 	u32 i;
 
@@ -1795,24 +1792,6 @@ batadv_tt_local_remove_entry(struct batadv_priv *bat_priv,
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
@@ -1822,10 +1801,6 @@ batadv_tt_local_remove_entry(struct batadv_priv *bat_priv,
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

