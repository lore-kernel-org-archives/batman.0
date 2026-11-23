Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8DCC606A31A
	for <batman@archiver.kernel.org>; Mon, 23 Nov 2026 17:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.a=rsa-sha256 header.s=09092022 header.b=FChvYkMm
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 2D10F85854
	for <batman@archiver.kernel.org>; Mon, 23 Nov 2026 18:23:48 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1795454628;
 b=m10IctkjTKjGbT+huiY2qvndRrOV6M/DdZyhUeYFXxhsAZL66/8G5ns7tRUoIteahx1Zh
 GuUqUHPvdGDKZzlAfvySQhrUsiigJih92IJUMHzLQTbOIrJgUTosWz5EzCOKYzOxA689ETD
 +elMxK8UCkpM4IVGl5YPrEDxYaBReSk=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1795454628; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=ux7RoI3q/q6IS/J7nuLk3xttccdt6yzu4InzHrHTg0Y=;
 b=xbg+g28pl3rNLHtXJ5R6ul8zveohiXWAT6zTeR4BYZ2CRshCRVAtomABwX1Yz3iHLzyEP
 2+AXJwzpyqf4r86b5NqLUWb7TvF/pl3b3NoX/sdUg4hL2tnQWB/+BTM2roAGL5h78iwcJM2
 YpzF8wkM6Op5B14xWiiSi+/HrBThPR4=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id EC7A684660
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 23 Nov 2026 18:18:42 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1795454333;
	b=PgPFZNEZ7sofXhA1yxYzbZCHpQ6nSranZ/6+D9Tdo+xgKF9BZz8BjEhIEw77PURPb6cpN5
	2vz4I3vPpATtZZ7bRaI+bCd2FBhjGeMXhohhwnCddiKrgF82tXub5V772U/1MGt9x5e7vc
	DK394NRvrH+OqHfIDefKyaoWk770Wrs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1795454333;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=ux7RoI3q/q6IS/J7nuLk3xttccdt6yzu4InzHrHTg0Y=;
	b=IArZuaRB/ziE9dOghi3MB+NmwJ3RctJEn1H9Q6ORG+d2CREgMOpEvaOIVqM3ii84u/lbYN
	m6XIdPvbYszoXvGGe8Wypw92Y38CMTDSDkOb7YW5jDo7lagYlubfUw1ixQ/PMUTTXgTaji
	Y5CklfBNwcBUInTglivvitz8veSkKJg=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=FChvYkMm;
	dmarc=pass (policy=none) header.from=simonwunderlich.de;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 23.88.38.48 as permitted sender) smtp.mailfrom=sw@simonwunderlich.de
Received: from kero.packetmixer.de
 (p200300C59714C2E05A704819B6ba2dB4.dip0.t-ipconnect.de
 [IPv6:2003:c5:9714:c2e0:5a70:4819:b6ba:2db4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with UTF8SMTPSA id 72826FA3DE;
	Mon, 23 Nov 2026 18:18:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1795454316;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ux7RoI3q/q6IS/J7nuLk3xttccdt6yzu4InzHrHTg0Y=;
	b=FChvYkMmWoxDrBiYh9wf1t1RdoKrAqrwPwMfTRtKWItX+tEkE6hvhaxkMlMV3gLiq/OeH6
	hLAB2zMg+XXpFo9CAEySSj4ulI5wgXU2N01diWF6WjUnjWSTDIxtBjOx1ahHlobcETnCAl
	wX2FtUOzVl/S7qR5akV51X/CDVC4xNvEKc6/oRbBKKBYd0OPTH8B8b+EP+0O+foctjcfO1
	PBN9VhtsLDp7FiuKwp4NeRbCQd45WJf4YQkcTIgL8RBmjHGtdLb5MrGMmQcuIy6Sh16xSx
	RGYQz4b75/DD5lC7ZxREaZJNrNbpMs9j7h7enBY7/15onbyCPPrAbP2C7IAbyw==
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
Subject: [PATCH net-next 05/15] batman-adv: tt: unhash local entries with
 hlist_del_init_rcu()
Date: Mon, 23 Nov 2026 18:18:17 +0100
Message-ID: <20261123171827.3294525-6-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261123171827.3294525-1-sw@simonwunderlich.de>
References: <20261123171827.3294525-1-sw@simonwunderlich.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: RHXO5QOUJHDEYRZ7ZEXQWA4FG5IQNG27
X-Message-ID-Hash: RHXO5QOUJHDEYRZ7ZEXQWA4FG5IQNG27
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/RHXO5QOUJHDEYRZ7ZEXQWA4FG5IQNG27/>
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
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/translation-table.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 1807a498d694..1c784a0e8c9b 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -1887,7 +1887,7 @@ static void batadv_tt_local_table_free(struct batadv_priv *bat_priv)
 		spin_lock_bh(list_lock);
 		hlist_for_each_entry_safe(tt_common_entry, node_tmp,
 					  head, hash_entry) {
-			hlist_del_rcu(&tt_common_entry->hash_entry);
+			hlist_del_init_rcu(&tt_common_entry->hash_entry);
 			tt_local = container_of(tt_common_entry,
 						struct batadv_tt_local_entry,
 						common);
@@ -4464,7 +4464,7 @@ static void batadv_tt_local_purge_pending_clients(struct batadv_priv *bat_priv)
 					   tt_common->key.addr,
 					   batadv_print_vid(tt_common->key.vid));
 
-				hlist_del_rcu(&tt_common->hash_entry);
+				hlist_del_init_rcu(&tt_common->hash_entry);
 				atomic_inc(&hash->generation);
 
 				/* An entry which still carries BATADV_TT_CLIENT_NEW was
-- 
2.47.3

