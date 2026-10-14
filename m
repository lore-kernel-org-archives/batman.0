Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 547AACC6B1A
	for <batman@archiver.kernel.org>; Wed, 14 Oct 2026 07:48:57 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 7D72A8424E
	for <batman@archiver.kernel.org>; Wed, 14 Oct 2026 09:48:55 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1791964135;
 b=aawIV0UA9wJCgb2eNN9SGFnDXA/N3P+ifq7QOY/z0JJv91i8AmMdTWAJzkpHRTCV8UO/b
 9qp3ln+Sh4IixaEHuNPLA0oFmNgt6r0Ka+7w/eoK0Xr/C6mq62PIvp6802IudpX9GcxExxJ
 zmecISGEEp2oYEe8AsTMwCdRbdvL+8E=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1791964135; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=2scXpSaOwVtDFSo4Em4mUw/fuU+xwcqjxQB5mWbuYVM=;
 b=IhSibtoPJepmCYtBgAeGP+yb8DHKXtbzP7rxKStoFuVAWp/aqXOjpRzPuI7ny6X9DC/V7
 q1uwzD2cs8L0K0nckZiHnomaW2qsg4qOZKc8tkE2O6Mo94BT6QBuq6DzSgamA0o2lrkniO+
 9XrTH2f4wdLNUj/SA5IKGcqJTzbdl/8=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 7019A8425E
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 14 Oct 2026 09:46:37 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1791963997;
	b=E1F6xY5guhfrn7E77eQdChmNSg7ul39VCPAsPjoQInlbV19swzG9wFpZwKaqXcB3TIml3M
	sN6tBb2wsXajjXa8DwSxzzptAxvxq4nNli/Xr1ICOeqo7WlSzqokVKYw79wN6WU8tf6jdk
	QHhEpiFuoL8pWIFzg3dMfR8iMH2sRrk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1791963997;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=2scXpSaOwVtDFSo4Em4mUw/fuU+xwcqjxQB5mWbuYVM=;
	b=potBEoQX4lT78dSOHRZpiOBJuffbjwxKzhrRQH6ZaLj3ES1OO8UEEduLk/TUI9YFigJpLs
	eTM+n83y3QQqyAoeY5hRDKvtfZVHyxzcCp1b89svdnr8EWfWGTKsLaSaXUS2wqxx1/XjK6
	WpReepxpjqeTZwLrxFoVC+yamjO9WsM=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=HiZ0nwHO;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 02A0F20EF2;
	Wed, 14 Oct 2026 07:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1791963997;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2scXpSaOwVtDFSo4Em4mUw/fuU+xwcqjxQB5mWbuYVM=;
	b=HiZ0nwHOJhreh70YsfnOmmBKhWpJVg/vZgdSf2vmqZ5pEeWGe94cQH3idQ8hcNFsOEfPkz
	HHPIfLvxSRST39QXi3kbj4W4NO/2mZ3Qy2tV3+9PnjuBsKtmNoykx5NtkExcblk3lIcIsC
	W+zWYuMXKScGSP77VRvm2s2I1chsvxY=
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 14 Oct 2026 09:46:05 +0200
Subject: [PATCH batadv v2 6/6] batman-adv: hash: document key argument of
 hash operations
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-hash-key-v2-6-7cb91c7df2cb@narfation.org>
References: <20261014-hash-key-v2-0-7cb91c7df2cb@narfation.org>
In-Reply-To: <20261014-hash-key-v2-0-7cb91c7df2cb@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2578; i=sven@narfation.org;
 h=from:subject:message-id; bh=xEF8KD7l04jf7tij2UvCUEO3IoOKAuL6rrLcrCSKv+8=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFnnjT0FGffKBv20sxMx5X6kNlP082+3uX4b3wqdLGRpX
 No2oaS+o5SFQYyLQVZMkWXPlfzzm9nfyn+e9vEozBxWJpAhDFycAjCRWgmGP1w766O8gqZ+m3f9
 raPsJBl+nk63wnXf59ydHHe7aZaYZBPDH95v3B79bDscHx0R+NvEJBdzpTS4an+e5MVJIebLhFS
 buAE=
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: ATJXVBF5F7A2YYCIQJNTQI4FE5QBODSL
X-Message-ID-Hash: ATJXVBF5F7A2YYCIQJNTQI4FE5QBODSL
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/ATJXVBF5F7A2YYCIQJNTQI4FE5QBODSL/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

With all users converted, the data passed to batadv_hash_add(),
batadv_hash_remove() and the compare/choose callbacks is always the key
of the hash table, never a (partially initialized) element. The
kernel-doc of batadv_hash_remove() even still suggested to pass "the
structure you use with just the key filled".

Document the actual key contract.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
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

