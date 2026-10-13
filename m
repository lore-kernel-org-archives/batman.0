Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD3F0CC6B12
	for <batman@archiver.kernel.org>; Tue, 13 Oct 2026 18:51:21 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 5F9C684578
	for <batman@archiver.kernel.org>; Tue, 13 Oct 2026 20:51:20 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1791917480;
 b=g2OaTTlgn801HBJbFbd5rAVsYrGV7A41flGxh4X16AnXRNf/BxkeokshUM6Pk1Ha0SFB2
 X0Yx/l+M5BicjYur2bzX9xNUO9+gNgIZmkZbB1jjazG67yfNGav2tYzQvmMkQvl1jaSpN/9
 2zsQIH876HMkRAbUtsf1409Kl9g8toc=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1791917480; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=zd7wdkiVkj1oBHDrhVBg6453MTG3ohQnGhmNjfDId38=;
 b=R4hRCqBK9iZsIbrBRuibGuHsXJ4Z3WVcc+Tw6v1KRih5sCxTrbtPWsfy2DJ3KJwPnK+ru
 TSDEjbWYC7VinajZ70aypXDO/abL5OCri8EcthH3sIczIEtGcTNdaGF/iUjL1kWHV9LEoF+
 hU7GMEJzQ/33rv4Cr0rKq24RoHFfBUo=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 154A384230
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 13 Oct 2026 20:47:49 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1791917279;
	b=OsduyBkry6Ul+HENYcfudePyiwDcGmMmqp/Z4Z7dhHPBUy/BHernOVTDa+iT/obYFaWKGU
	y+L1QGHOvAEl2xWBP7m+r5xzT3J9Sa7p64OxkRKmIy0JfHK7udyRvHke0VEc550YqtmfS6
	8C4MfUms/lX+njSDDqeTpNnEfV1LVrM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1791917279;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=zd7wdkiVkj1oBHDrhVBg6453MTG3ohQnGhmNjfDId38=;
	b=wC7Ocht6VTSrZDb4+j8svaILt8no7s2ADCrPNWwozV6YkcpGy7aiSYP4G8r++PvImgT0C7
	XXkYJUYD1A9dvMs3Loeq9VHPlL3Vj5DMJQ9H/v/VJQtiUVIR8gRuu9RYa47tmehxWZb5L2
	sGCMs+LP/zDOj/bBdK7bh3OS2Gy71fs=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=UrxY3AIM;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 9274520281;
	Tue, 13 Oct 2026 18:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1791917268;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zd7wdkiVkj1oBHDrhVBg6453MTG3ohQnGhmNjfDId38=;
	b=UrxY3AIMhPuXPZmsCS4EWaM6b4epQgB+YIFsV/VNx0NAHZv9Wc3V9IN9L+8JqfEmTl+/O4
	EpSR37MVh22OcLF5vmp4lzBUDBRTHlpGm49v8MvbStHxqfmCWtzsEYkmevlIlSygUfmsDq
	NQmYLo3RKgQanx3z3sCtxgYR67YdsNY=
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 13 Oct 2026 20:47:34 +0200
Subject: [PATCH batadv 6/6] batman-adv: hash: document key argument of hash
 operations
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261013-hash-key-v1-6-0370efdd8cd0@narfation.org>
References: <20261013-hash-key-v1-0-0370efdd8cd0@narfation.org>
In-Reply-To: <20261013-hash-key-v1-0-0370efdd8cd0@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2568; i=sven@narfation.org;
 h=from:subject:message-id; bh=cAtKgx/OXA/2dQaY5VMjDPaLdcBAn1Xg7OKET06x9O4=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFnnag6vFkzp2Pc2/ghjmKGQxZRNO1cZ2v3cqfD01gbFo
 tij/409O0pZGMS4GGTFFFn2XMk/v5n9rfznaR+PwsxhZQIZwsDFKQATKZ7F8D+R0Wkme6HVodVL
 p3v0lZw+19Z8Pc/kR9RDv0eCLi9dlu5m+O82Id55S/+c/7/8numd0A04nsuxVfw1z+Vtpx++1Ov
 8bssAAA==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: RFTYB5Q4FS67SZHERADYBSQ7BALF2RVW
X-Message-ID-Hash: RFTYB5Q4FS67SZHERADYBSQ7BALF2RVW
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/RFTYB5Q4FS67SZHERADYBSQ7BALF2RVW/>
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
index 45a432cc..fca426c5 100644
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

