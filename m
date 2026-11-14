Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C6E606A32D
	for <batman@archiver.kernel.org>; Sat, 14 Nov 2026 09:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.a=rsa-sha256 header.s=09092022 header.b=LjkpjWGo
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 96E28859EE
	for <batman@archiver.kernel.org>; Sat, 14 Nov 2026 10:21:01 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1794648061;
 b=lJdu5Y0GTBEXDXTh7wlijZ5V+grMwakDyp0mCH8sdLAykmXERCB1jh6WOF6rb5YCSsq2u
 BMfjlcFroSzznnbncs+NbWtt7zN0ItgGpq6KI6cJDHoYd5lI+3oJ8L2TokLJCewYqcIkfz9
 6IFLdqh2pIWjaKdLAq4kVxjfIr7e4HI=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1794648061; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=rMO8X19lP9V1R2hK/QJuYzFCrlgW/VHC0tz8dhP2jr4=;
 b=rBVKTimqqeGGhObcdFkm1qpBWYmnCq2Ar879+ZPfWCQsR2XQg+arrz5rivRYZ1NZjJqvo
 M4uM4+0Ty62MdoQm1j925xsuSvr7XIn8Mu7G6lS/V7MWuvMHN3QzbiTIlIkCvekBa6dzPCm
 Uk8buKBVKV8D1ZyhzfZw0m78JrjoAMA=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de
 [IPv6:2a01:4f8:c17:e8c0::1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 74FC184741
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sat, 14 Nov 2026 10:16:11 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1794647781;
	b=IhFv1FdwMaezC4edGQbipLJiA3RztTETMFgId1tE7RpxIVv+vrFyEbzp2PI8b4dIlP1ABD
	W1mXFFvDEggCLRFl84+dbpqH4uFrzn4GUZMZtgPRDg0qtrzpZW9nLSgyv/Ui+DQsnbNwpe
	QPnDn/UkpQjF/w/xEQhxus/oXVDUPow=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1794647781;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=rMO8X19lP9V1R2hK/QJuYzFCrlgW/VHC0tz8dhP2jr4=;
	b=FT5zkDK4sUWrNNOr78ilRrx5rPIaD6ihIYLLw0MAZVCUVqkELVED4hLhID4/7pHseQP+g3
	YlTULo2YHCRKHigSjxckZ9pdoCZHRr9yu5a8sE7RZKoLaifZ9YPWJT1CBz2fkwfL+Sq5mm
	BsNKqsx7bjPet1w8KFojN725CVt0nlw=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=LjkpjWGo;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 2a01:4f8:c17:e8c0::1 as permitted sender)
 smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
Received: from kero.packetmixer.de (unknown
 [IPv6:2a02:3037:6ed:dd6c:838:344b:3152:2d5e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with UTF8SMTPSA id 39807FA1B3;
	Sat, 14 Nov 2026 10:16:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1794647764;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rMO8X19lP9V1R2hK/QJuYzFCrlgW/VHC0tz8dhP2jr4=;
	b=LjkpjWGoOT9WGV/rrK5ehsavf9HbI+v976bkh4Ig5YHLpvY2PZDTtbqvTlFzpJMu7tz8yn
	NHwmj4qQlFWaTh5XBoNnmfBAfwPP6lnSRbwCot4QHNyzImbxJ/ltGhNO2p2pnxNl7zwkPx
	ow8LFsRJQD10rf7E3qHfqPZQjKCqdmi+wsHNAkLehWe6baT7PMWtLYfOBZEdZsIP9muZqz
	aKulfza1lN8mM7v2g0QlFohccpbQkzkSCt4UFGlHJHjeA2yVhST3cMD6jtIbd1CzUMZjeo
	t0yg6odFQRBvQ9Gh0s8/ptq6gilqs2fmzWmn6OUZnaYgzAhhPljdxsj/VDsmbA==
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
Subject: [PATCH net-next 06/15] batman-adv: hash: document key argument of
 hash operations
Date: Sat, 14 Nov 2026 10:15:47 +0100
Message-ID: <20261114091556.3336038-7-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261114091556.3336038-1-sw@simonwunderlich.de>
References: <20261114091556.3336038-1-sw@simonwunderlich.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: CBHYXBSAPIUMT4A5IBFMAQPKMZ46YGSJ
X-Message-ID-Hash: CBHYXBSAPIUMT4A5IBFMAQPKMZ46YGSJ
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/CBHYXBSAPIUMT4A5IBFMAQPKMZ46YGSJ/>
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

With all users converted, the data passed to batadv_hash_add(),
batadv_hash_remove() and the compare/choose callbacks is always the key
of the hash table, never a (partially initialized) element. The
kernel-doc of batadv_hash_remove() even still suggested to pass "the
structure you use with just the key filled".

Document the actual key contract.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/hash.h | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/net/batman-adv/hash.h b/net/batman-adv/hash.h
index 45a432cc15789..fca426c5e3c58 100644
--- a/net/batman-adv/hash.h
+++ b/net/batman-adv/hash.h
@@ -21,7 +21,7 @@
 /**
  * typedef batadv_hashdata_compare_cb - hash element comparison callback
  * @node: hlist node of the element currently stored in the bucket
- * @key: opaque payload to compare @node's key against
+ * @key: key to compare @node's key against
  *
  * Compare hash element by its keys.
  *
@@ -32,7 +32,7 @@ typedef bool (*batadv_hashdata_compare_cb)(const struct hlist_node *node,
 
 /**
  * typedef batadv_hashdata_choose_cb - hash bucket selection callback
- * @key: opaque payload whose key selects the bucket
+ * @key: key which selects the bucket
  * @size: number of buckets in the hash table
  *
  * Return: bucket index derived from the key in @key and the table @size.
@@ -80,7 +80,8 @@ void batadv_hash_destroy(struct batadv_hashtable *hash);
  *	@hash: storage hash table
  *	@compare: callback to determine if 2 hash elements are identical
  *	@choose: callback calculating the hash index
- *	@data: data passed to the aforementioned callbacks as argument
+ *	@data: key of the element to add (the key embedded in the element),
+ *	 passed to the aforementioned callbacks as argument
  *	@data_node: to be added element
  *
  *	Return: 0 on success, 1 if the element already is in the hash
@@ -132,10 +133,8 @@ static inline int batadv_hash_add(struct batadv_hashtable *hash,
  * @hash: hash table
  * @compare: callback to determine if 2 hash elements are identical
  * @choose: callback calculating the hash index
- * @data: data passed to the aforementioned callbacks as argument
- *
- * data could be the structure you use with just the key filled, we just need
- * the key for comparing.
+ * @data: key of the element to remove, passed to the aforementioned callbacks
+ *  as argument
  *
  * Return: returns pointer to hlist_node on success, so you can remove the used
  * structure yourself, or NULL on error
-- 
2.47.3

