Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB47E606A329
	for <batman@archiver.kernel.org>; Sat, 14 Nov 2026 09:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.a=rsa-sha256 header.s=09092022 header.b=UctLexUT
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 739B180A4C
	for <batman@archiver.kernel.org>; Sat, 14 Nov 2026 10:22:02 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1794648122;
 b=IMffmdJJjTCCnljgYP+kh8Y/k5Lj1Vr1govshcW1jnBa3dQoqwnEuDujqSv3LtTEewTB2
 11ncpu9oA+sOd5WaDWkr23E6Jgl+D6sG2M4Qd2nInj2MBHimhfFrZDBMsEzpKUlagsVscPb
 2XWdcIpQG2WUwMxm95tFQWrKRdz5/Uo=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1794648122; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=lpwA1u59qouthY54ConAsgtyKnxGuTVoNhdbJJpeitk=;
 b=lqx1S3pJCYy05aONQezTxDC01mc8xGfZR4rUNaolwif4eh0GdOFmfKBrodt7QZ8TdXZSQ
 nyb0vcu1N1uFFJMvncoKMlCGIXHQlg4BzsE9Qa5ymlih0myAPRDuXFOKR5br82k2sUDGGgZ
 yRM8lPlZiEu74TBG+lNwtL75VAxnAAA=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de
 [IPv6:2a01:4f8:c17:e8c0::1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 6AE1F84735
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sat, 14 Nov 2026 10:16:11 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1794647781;
	b=t/9zVpFMrJ4EtSUjHDgSrrpwmn4bo/Y4fg+JUIK9Wr/kfuzOGeMkTNnad/rdXPec5OXooO
	Rb7pawGfOqmsepuYc6qrZ8S+TW422wEKPgzKVevLh9JtGhO3aOz8S6DEwpbyEjBLA5jOHz
	vf0uADEXoiJ9j49cQVNqFcNXkqgCzLo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1794647781;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=lpwA1u59qouthY54ConAsgtyKnxGuTVoNhdbJJpeitk=;
	b=p91xHzU9vQKM2MCLGMz0zUZB9tDjsxv2VZsEiUOLSsSulNooUhd2P/UM4jZm6nz45zlXNf
	SWhBoxZoulE4k+8VYiDS+inH7CcmvdbASqps4krIpPebhs8vntWuz+8FotXh2ny2z7DBO2
	GlRCqasG+kg7lLox4ylYptX2gJU/QLQ=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=UctLexUT;
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
	by mail.simonwunderlich.de (Postfix) with UTF8SMTPSA id 44DE0FA1B2;
	Sat, 14 Nov 2026 10:16:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1794647763;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lpwA1u59qouthY54ConAsgtyKnxGuTVoNhdbJJpeitk=;
	b=UctLexUT3uMFMjc2CCclKAFUs4ePn0l2Zm4l9SbVP7FhXYbWRLApfXTxGcn7rF3uOSv/Zo
	Y98gzVymDkSkPWq4poUnD4xR3TI8xHXwiKqY53fFp5AaAm71usMIHFQrzC/uCDOV5lSlpI
	ywDDFN9F0EjZBYMRnJ6sa7Wj4BaQ7SFGkIIE7dFPlpzt1kz/f0P+L7R/auunuzZpAxjRfK
	LY2N/3j8X28FGBxCM402DIiiXsZrnaoxG7KF3NheKNe06VoHEllokOHkc0G/dzMYSEc5ZP
	MqECFT/dATAG+a4Xn3oZzqL7byuWWS98y3b/xqhZPR7k2lPwHma+kKKBGZk/vQ==
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
Subject: [PATCH net-next 05/15] batman-adv: originator: pass explicit key to
 orig_hash
Date: Sat, 14 Nov 2026 10:15:46 +0100
Message-ID: <20261114091556.3336038-6-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261114091556.3336038-1-sw@simonwunderlich.de>
References: <20261114091556.3336038-1-sw@simonwunderlich.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: JRZY7OZURAYOVBRMLOJYNG5ZD5TB5KZE
X-Message-ID-Hash: JRZY7OZURAYOVBRMLOJYNG5ZD5TB5KZE
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/JRZY7OZURAYOVBRMLOJYNG5ZD5TB5KZE/>
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

The key of the orig_hash is the originator address. But batadv_hash_add()
was given the whole orig_node, while batadv_orig_hash_find() is given the
bare address, and batadv_compare_orig() and the lookup compare the
orig_node pointer itself against the address. This only works because
orig is the first member of struct batadv_orig_node.

Pass orig_node->orig as key to batadv_hash_add(), compare explicitly
against orig_node->orig in batadv_compare_orig(), use it for the lookup,
and let batadv_orig_hash_find() take a const u8 * address instead of an
untyped pointer.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/bat_iv_ogm.c |  2 +-
 net/batman-adv/bat_v_ogm.c  |  2 +-
 net/batman-adv/originator.c | 19 ++++++++++---------
 net/batman-adv/originator.h |  2 +-
 4 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index 0b2134a8f963a..376c0f80bcee9 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -155,7 +155,7 @@ batadv_iv_ogm_orig_get(struct batadv_priv *bat_priv, const u8 *addr)
 
 	kref_get(&orig_node->refcount);
 	hash_added = batadv_hash_add(bat_priv->orig_hash, batadv_compare_orig,
-				     batadv_choose_orig, orig_node,
+				     batadv_choose_orig, orig_node->orig,
 				     &orig_node->hash_entry);
 	if (hash_added != 0)
 		goto free_orig_node_hash;
diff --git a/net/batman-adv/bat_v_ogm.c b/net/batman-adv/bat_v_ogm.c
index cf3c1d22761b9..4abb4c871e8c5 100644
--- a/net/batman-adv/bat_v_ogm.c
+++ b/net/batman-adv/bat_v_ogm.c
@@ -68,7 +68,7 @@ struct batadv_orig_node *batadv_v_ogm_orig_get(struct batadv_priv *bat_priv,
 
 	kref_get(&orig_node->refcount);
 	hash_added = batadv_hash_add(bat_priv->orig_hash, batadv_compare_orig,
-				     batadv_choose_orig, orig_node,
+				     batadv_choose_orig, orig_node->orig,
 				     &orig_node->hash_entry);
 	if (hash_added != 0) {
 		/* remove refcnt for newly created orig_node and hash entry */
diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
index 1ac3e0ad66c79..391d97bc938b9 100644
--- a/net/batman-adv/originator.c
+++ b/net/batman-adv/originator.c
@@ -45,12 +45,12 @@ static struct lock_class_key batadv_orig_hash_lock_class_key;
 /**
  * batadv_orig_hash_find() - Find and return originator from orig_hash
  * @bat_priv: the bat priv with all the mesh interface information
- * @data: mac address of the originator
+ * @addr: mac address of the originator
  *
  * Return: orig_node (with increased refcnt), NULL on errors
  */
 struct batadv_orig_node *
-batadv_orig_hash_find(struct batadv_priv *bat_priv, const void *data)
+batadv_orig_hash_find(struct batadv_priv *bat_priv, const u8 *addr)
 {
 	struct batadv_hashtable *hash = bat_priv->orig_hash;
 	struct batadv_orig_node *orig_node_tmp = NULL;
@@ -61,12 +61,12 @@ batadv_orig_hash_find(struct batadv_priv *bat_priv, const void *data)
 	if (!hash)
 		return NULL;
 
-	index = batadv_choose_orig(data, hash->size);
+	index = batadv_choose_orig(addr, hash->size);
 	head = &hash->table[index];
 
 	rcu_read_lock();
 	hlist_for_each_entry_rcu(orig_node, head, hash_entry) {
-		if (!batadv_compare_eth(orig_node, data))
+		if (!batadv_compare_orig(&orig_node->hash_entry, addr))
 			continue;
 
 		if (!kref_get_unless_zero(&orig_node->refcount))
@@ -85,16 +85,17 @@ static void batadv_purge_orig(struct work_struct *work);
 /**
  * batadv_compare_orig() - comparing function used in the originator hash table
  * @node: node in the local table
- * @data2: second object to compare the node to
+ * @data2: mac address of the originator to compare the node to
  *
- * Return: true if they are the same originator
+ * Return: true if the node is the originator with the given address
  */
 bool batadv_compare_orig(const struct hlist_node *node, const void *data2)
 {
-	const void *data1 = container_of(node, struct batadv_orig_node,
-					 hash_entry);
+	const struct batadv_orig_node *orig_node;
 
-	return batadv_compare_eth(data1, data2);
+	orig_node = container_of(node, struct batadv_orig_node, hash_entry);
+
+	return batadv_compare_eth(orig_node->orig, data2);
 }
 
 /**
diff --git a/net/batman-adv/originator.h b/net/batman-adv/originator.h
index fabfc3e67c6eb..dff729ecf2df1 100644
--- a/net/batman-adv/originator.h
+++ b/net/batman-adv/originator.h
@@ -83,7 +83,7 @@ static inline u32 batadv_choose_orig(const void *data, u32 size)
 }
 
 struct batadv_orig_node *
-batadv_orig_hash_find(struct batadv_priv *bat_priv, const void *data);
+batadv_orig_hash_find(struct batadv_priv *bat_priv, const u8 *addr);
 
 /**
  * batadv_orig_node_vlan_put() - decrement the refcounter and possibly release
-- 
2.47.3

