Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DED7CC6B1D
	for <batman@archiver.kernel.org>; Tue, 13 Oct 2026 18:50:51 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 097B980C33
	for <batman@archiver.kernel.org>; Tue, 13 Oct 2026 20:50:50 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1791917450;
 b=hAg7l/Eprk8toAPTscoEO48BSG62dsIjPVoJunLmzdmnmF+fUvVi+UVjSYgvY4iPuB3R5
 nukYR6PpZ/HJdJAkR+oyJSwKo3NYbGiVAMnothk9S9IXZL6QbT7zu+kTmu5EY4B/kqG2uud
 2K6aim+z2FN8QgvBqiSkEaAo/DCfcqw=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1791917450; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=yy6Mt9RrdvS5OKftmK5zdIOsKRoMKbLRJxVina3fNbE=;
 b=Y/fTWDWCUacNhA45ZN9KBfLMlpSqzRNOp4AToGBNgbun/KsB0zCLXamkdc+kYGAyEB2rz
 Q/1GHNL3L4m4tDqy4Xdr9pMLJ6fsdiPWhmvuaXf0HDZj8+X8U2pyXi4Nevujez+obHe6nhO
 hiLP12Gt/NQ+wA7wnLTIlJTgB9sMvhw=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 8C69F8429F
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 13 Oct 2026 20:47:48 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1791917278;
	b=VIiRRBSVwptIPr52pFPkEuzwL3976eN1+qC4hElroZFUPzCozhwEKQXy477imvrTTkWlBH
	t/aoiwTUSHeIMVHom0afr78Yb6Ckbkuad/osdyumsqvquX+6wZcHJsZGeO3/RFe5iol01I
	n3nlUNd/hmMICfZ7S28kF+czzLX+low=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1791917278;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=yy6Mt9RrdvS5OKftmK5zdIOsKRoMKbLRJxVina3fNbE=;
	b=h6WUscpWmWRn/59XlTFYRsoJI0pItAwc193tqkUxNscuu2oc9mPuoZZjFmIAEFHkhc4oRP
	VhkhELtnbSF4Fz8iaJzNqsraatrNdX8v2xxwo3xrZBOk5/fbEoD2RpOvwLESc91Z8icOaD
	xZHqKwPM2LS+hpUF+rfj9NuMLGHQUno=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=IN8ZdK3f;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id BC24A1FE82;
	Tue, 13 Oct 2026 18:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1791917266;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yy6Mt9RrdvS5OKftmK5zdIOsKRoMKbLRJxVina3fNbE=;
	b=IN8ZdK3f/+cfiv/N4vEumlh1J7XPZOU5RdizykctWmpUh2iM/OE0gcHi2cNpTHjsY2Oh5e
	iKmY6E5KV0xAdnCjye0qO2ijNcOgQb+S8WXpYUZu7Gdiwa6cTFlyT4ovqIuymjXn8O+RSE
	SWvtjPo1dB3Mb1GOrvRoFOeg/wdnLVY=
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 13 Oct 2026 20:47:33 +0200
Subject: [PATCH batadv 5/6] batman-adv: originator: pass explicit key to
 orig_hash
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261013-hash-key-v1-5-0370efdd8cd0@narfation.org>
References: <20261013-hash-key-v1-0-0370efdd8cd0@narfation.org>
In-Reply-To: <20261013-hash-key-v1-0-0370efdd8cd0@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4771; i=sven@narfation.org;
 h=from:subject:message-id; bh=3zbSmiSGUVcd0ZkgpOg448fHn/G3qeX7vjLj3vFsqXA=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFnnag5d5J2hkM9nWfzoesBnxUrGxAwXmfh82fMLEx9K9
 Sz7e9mqo5SFQYyLQVZMkWXPlfzzm9nfyn+e9vEozBxWJpAhDFycAjAR4WSGf4oyuwITfZ6mHSgu
 4Snt9dTUksqrZLm38WfJ7XkFc7q6TRkZ3p0I2lNr+See2/bXh7ldDO7ufi6t9h1pLt667351bfH
 lAgA=
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: VKPHJ7BNHPHOK2NWYXNLTH6KWATJOIST
X-Message-ID-Hash: VKPHJ7BNHPHOK2NWYXNLTH6KWATJOIST
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/VKPHJ7BNHPHOK2NWYXNLTH6KWATJOIST/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

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
---
 net/batman-adv/bat_iv_ogm.c |  2 +-
 net/batman-adv/bat_v_ogm.c  |  2 +-
 net/batman-adv/originator.c | 19 ++++++++++---------
 net/batman-adv/originator.h |  2 +-
 4 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index 85e99506..9ffa3c8c 100644
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
index 70846c99..bc96d162 100644
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
index f06583ef..b46014dc 100644
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
index db0c5512..5ca55292 100644
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

