Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 379F5C624A4
	for <batman-adv@archiver.kernel.org>; Mon, 31 Aug 2026 13:56:00 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id CA65C8281C
	for <batman-adv@archiver.kernel.org>; Mon, 31 Aug 2026 15:55:58 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1788184558;
 b=4FLnz54lebuJfIrAl8llgVw8Tn50PzOeg6Kom0wV1Qi+s3AzsTwzXNwZrYuPz9tmFW5pb
 eARwQmvrxZDWeriUZUOQ9MLv6C/u0xzpNezuyWzWcYdfuEzLuIPbH3iC/IElBQCxBTOOkWe
 nzTj7FbeRLrBTTcvFxWxGB4WV8+BxVc=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1788184558; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=/prk9mD3H+9HIMfDOj8RFswIOJ7B6P88+rB5ZHCRJN4=;
 b=1Zxzv+Mk1ZF7KCiPDJGmPrSD/6EuYystcpTzhQddKXf1m1F7dHrv6rlhTOKA3qtKxDNmL
 OTeC94GMNGOoFkNnV1QFx93Bh2n+T+6mLmLg6g1m7Ib/s93sHFmlDxktJ88u/ZUmg9YEGp7
 P/lN4WebZ5nLDZ7Wze7QnHVFKGevelA=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 1CCDF81958
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 31 Aug 2026 15:51:41 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1788184301;
	b=lRqPdKVlLXf/p96d8wqAY1E44lqKeBgbzRsZvlFt0gC9YT1tp2BItOrHdmTQeUJXOomo53
	W+SiyuelCEfCI+PMYQ0E/9Ik/vXwK0G16YUsToXpHVBIFkHTzS408Cur4aFTkSQC0Sk1YQ
	90A0bBcf9ZY/S1sNyQzzy46V+BmxgeQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1788184301;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=/prk9mD3H+9HIMfDOj8RFswIOJ7B6P88+rB5ZHCRJN4=;
	b=cy8owQSWQfafD/qLeu1kE6uc+tDfZ3i4DZoB7n4njpBUxtPhrdj1o6KaVdyU8R4ynRTqbW
	UmLS7SuL+NOf39MfiEH/X8vi706JvM0ZkZU2VbX9mwgClPaCRMJdnI6c8ng1ptF3Ecx0lR
	kaa98SrSQ2DBkRUQSyvJ/vxyjpQQ9dM=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=RAephEWo;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 23.88.38.48 as permitted sender) smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
Received: from kero.packetmixer.de
 (p200300C5970EeDd85F51f1FAa919d7a5.dip0.t-ipconnect.de
 [IPv6:2003:c5:970e:edd8:5f51:f1fa:a919:d7a5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with UTF8SMTPSA id 85807FA6BB;
	Mon, 31 Aug 2026 15:51:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1788184297;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/prk9mD3H+9HIMfDOj8RFswIOJ7B6P88+rB5ZHCRJN4=;
	b=RAephEWomQjz5Iqe6ynUSNV6lf/jH4KTen8T0nFrYuKfWHqARTKFLdgorJWqiIIAOwhvbM
	RyyGNVvC6Y6uoA8SK/42/S9VVca2MCT5f6nAY00eTCFMgvRUfd31Py4irkOkNRZfx4v3rH
	rbYTR/p+eZ1cBb8ORpxIe9fVTPYuzwmRdf/RnElTEhlAXq2wBSJCaxA4H999ROtbbQUvOT
	dRl2W7Iof73V6QKoi3UWMr9RgBt4zll+HhUfFzF/779W3QK40y9ta+k+D8xQorbzz6NZ79
	gN+V/LcYvCdvVGtQZFcQQdhhE672xHC6jLR8dR8q45kaDsHBSddVW1l8JKPkJQ==
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
Subject: [PATCH net-next 15/15] batman-adv: tt: decrement count for committed
 client on local_remove
Date: Mon, 31 Aug 2026 15:51:17 +0200
Message-ID: <20260831135117.574836-16-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260831135117.574836-1-sw@simonwunderlich.de>
References: <20260831135117.574836-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: G6NGWETIIH7KU245Y7FTMLYJYJV3EVYK
X-Message-ID-Hash: G6NGWETIIH7KU245Y7FTMLYJYJV3EVYK
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/G6NGWETIIH7KU245Y7FTMLYJYJV3EVYK/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Sven Eckelmann <sven@narfation.org>

Local TT entries which have the BATADV_TT_CLIENT_NEW no longer set are
committed. The batadv_tt_local_size_inc() was called for them and thus the
batadv_tt_local_size_dec() has to be called also when
batadv_tt_local_remove() is called for them when the BATADV_TT_CLIENT_NEW
wasn't consumed in the remove path.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/translation-table.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 794692170b611..44a8cf89382c6 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -352,7 +352,8 @@ static void batadv_tt_local_size_inc(struct batadv_priv *bat_priv,
  *
  * It must only be called after a batadv_tt_local_entry without NEW flag
  * was removed from bat_priv->tt.local_hash (under the specific
- * list_locks[i]).
+ * list_locks[i]) or when it is ensured that it is not accessible
+ * in this list.
  */
 static void batadv_tt_local_size_dec(struct batadv_priv *bat_priv,
 				     unsigned short vid)
@@ -1423,6 +1424,13 @@ u16 batadv_tt_local_remove(struct batadv_priv *bat_priv, const u8 *addr,
 	if (!tt_removed_node)
 		goto out;
 
+	/* batadv_tt_local_transition_new() may have committed the entry and
+	 * thus counted it in the local table size since the BATADV_TT_CLIENT_NEW
+	 * check above.
+	 */
+	if (!(batadv_tt_flags_get(&tt_local_entry->common) & BATADV_TT_CLIENT_NEW))
+		batadv_tt_local_size_dec(bat_priv, tt_local_entry->common.vid);
+
 	/* drop reference of remove hash entry */
 	batadv_tt_local_entry_put(tt_local_entry);
 
-- 
2.47.3

