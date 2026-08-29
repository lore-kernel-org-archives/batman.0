Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5FD6C61DD6
	for <batman-adv@archiver.kernel.org>; Sat, 29 Aug 2026 06:20:05 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 2387E8058C
	for <batman-adv@archiver.kernel.org>; Sat, 29 Aug 2026 08:20:04 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1787984404;
 b=As8aIUNOFOTmFzET1eGF8f2JUjRfuTFGodLQjZoQHpAE2PEntN3uL8dHRMFkilKlOH8Aw
 4mzYdmCq76pfjtraRGNvTsU/JPaXk3sGak6ywYpWY1kdOS8CDifuohHWYQj/j1AcwRfYp+B
 mVEYW8i0EBOZA6g3mP08ilJ3KtbW+lg=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1787984404; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=DoXqyGjYO6P/x6hHU+rDpHoASagvUddV2iKCjam+N/o=;
 b=fTe05yRzvEJIlYiqi8RggCykBZZ00ApyW6mPW1YgPEpTuGB0mnCSdbWNQ2tvvTa9mSuvi
 MKqTwpQ8irsYp0HB3SZIFopugg5m5etdJcJSMNz82tHkooqUtAi32t+DhtDWMBydM7pExQ6
 f6tsdxZfxTahW5YLdd3xxJuePxeINaw=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id D2AC783E1F
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sat, 29 Aug 2026 08:18:58 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1787984348;
	b=NB42yLUJVl73iSz87qcyujlgnVSnWILlT/4h//QUW6QRihDdOusB4UCo/u0ksTfAuEGoS4
	UZt9k6g/XC1uv252opnFMa2iNKqYi7IZZFwoZR5hCGyBuWcWucJxJ+WPwoK4ie1ruMwje1
	FQgP8amcxd5H5C0Ppu3j9t1JbNOWB6s=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1787984348;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=DoXqyGjYO6P/x6hHU+rDpHoASagvUddV2iKCjam+N/o=;
	b=O4qdqb+aPB6rr+npdA8dOKNlkJjhMzHH29HCCn7vNRoGlFNpUdehF3dyAhsVOe+S70ZZFu
	lsSf4czFareILAB6G4FMb8oOGu/eLWhCwzQccL4FH0N8WW0pB9LXm/poew0ybIb+q0ZElv
	SdNgfjP8tHpFgUDhdllPoM/b4NhlG0E=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b="e/d1GlG7";
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 624901FE24;
	Sat, 29 Aug 2026 06:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1787984334;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DoXqyGjYO6P/x6hHU+rDpHoASagvUddV2iKCjam+N/o=;
	b=e/d1GlG7iJe0BsL4lLc6SzhKl6ODISj0ZiZeqVBnIz9MABODbBavSfVAeILzzN50LQWbP0
	DIovMOWCYBnhLI5zpCK/PvsvTGPdzpZ4c/1eVYZn9sTQm6/BNztThDiDYlSKrtDMVMfN4P
	W+83RFIrNpgFbJ8HSopPHp6T+dDNBnA=
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 29 Aug 2026 08:18:12 +0200
Subject: [PATCH batadv v5 01/20] batman-adv: tt: remove only the entry
 which was looked up from the hash
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260829-tt-fixes-v5-1-88fce8fd683d@narfation.org>
References: <20260829-tt-fixes-v5-0-88fce8fd683d@narfation.org>
In-Reply-To: <20260829-tt-fixes-v5-0-88fce8fd683d@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4770; i=sven@narfation.org;
 h=from:subject:message-id; bh=dPjXTJZtc1gQjLa1yuwZDIz0vROYJNuHkDZysEuPCbg=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFmTKldXfduwZvPbf+m/mtpymYsirBdOymszz9nc9npxc
 X5RVK9LRykLgxgXg6yYIsueK/nnN7O/lf887eNRmDmsTCBDGLg4BWAiyx8wMpxinCQTfGDudnfO
 WcFW8x5K56jfkDkrapcm/6o+dGreu0+MDA3H9y5NkVpwpC/9PHPM97ZKzejL6zVMXNszL7BnF97
 L5AIA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: X2CCDPXLFODGN4VV4T2NCFV3VY44ASCY
X-Message-ID-Hash: X2CCDPXLFODGN4VV4T2NCFV3VY44ASCY
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/X2CCDPXLFODGN4VV4T2NCFV3VY44ASCY/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

batadv_hash_remove() searches a bucket with a compare callback and unlinks
the first matching entry. batadv_compare_tt() matches any entry for the
same MAC address and VLAN, not the object which was passed in, and the
callers in batadv_tt_local_remove() and batadv_tt_global_free() are not
serialized against the rest of the translation table in any way.

So when the looked up entry was already unlinked by another context and a
new entry for the same client was added in the meantime, these two
functions unlink that new entry instead.

Add batadv_compare_tt_entry(), which matches the very object which is
searched for, and use it for both removals. Nothing is unlinked when the
entry is gone already, batadv_hash_remove() then simply returns NULL and
only the reference of the calling context is dropped.

As a side effect the returned hlist_node can no longer belong to a
different object, so both functions can operate on the entry they were
given.

Fixes: af912d77181f ("batman-adv: protect tt_local_entry from concurrent delete events")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/translation-table.c | 38 ++++++++++++++++++++++++++------------
 1 file changed, 26 insertions(+), 12 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 4f47c97b..af40ff81 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -136,6 +136,26 @@ static bool batadv_compare_tt(const struct hlist_node *node, const void *data2)
 	return (tt1->vid == tt2->vid) && batadv_compare_eth(data1, data2);
 }
 
+/**
+ * batadv_compare_tt_entry() - check if a hash node is a specific TT entry
+ * @node: the list element pointer of the TT entry stored in the bucket
+ * @data2: pointer to the tt_common_entry which is looked for
+ *
+ * Unlike batadv_compare_tt(), this only matches the very object which is
+ * passed as @data2 and not just any entry for the same TT client. It is meant
+ * for batadv_hash_remove() callers which must not unlink an entry they did not
+ * look up themselves.
+ *
+ * Return: true if @node belongs to @data2, false otherwise
+ */
+static bool batadv_compare_tt_entry(const struct hlist_node *node,
+				    const void *data2)
+{
+	const struct batadv_tt_common_entry *tt = data2;
+
+	return node == &tt->hash_entry;
+}
+
 /**
  * batadv_choose_tt() - return the index of the tt entry in the hash table
  * @data: pointer to the tt_common_entry object to map
@@ -628,7 +648,6 @@ static void batadv_tt_global_free(struct batadv_priv *bat_priv,
 				  struct batadv_tt_global_entry *tt_global,
 				  const char *message)
 {
-	struct batadv_tt_global_entry *tt_removed_entry;
 	struct hlist_node *tt_removed_node;
 
 	batadv_dbg(BATADV_DBG_TT, bat_priv,
@@ -636,18 +655,16 @@ static void batadv_tt_global_free(struct batadv_priv *bat_priv,
 		   tt_global->common.addr,
 		   batadv_print_vid(tt_global->common.vid), message);
 
+	/* remove exactly this object when still present in hash */
 	tt_removed_node = batadv_hash_remove(bat_priv->tt.global_hash,
-					     batadv_compare_tt,
+					     batadv_compare_tt_entry,
 					     batadv_choose_tt,
 					     &tt_global->common);
 	if (!tt_removed_node)
 		return;
 
 	/* drop reference of remove hash entry */
-	tt_removed_entry = hlist_entry(tt_removed_node,
-				       struct batadv_tt_global_entry,
-				       common.hash_entry);
-	batadv_tt_global_entry_put(tt_removed_entry);
+	batadv_tt_global_entry_put(tt_global);
 }
 
 /**
@@ -1345,7 +1362,6 @@ u16 batadv_tt_local_remove(struct batadv_priv *bat_priv, const u8 *addr,
 			   unsigned short vid, const char *message,
 			   bool roaming)
 {
-	struct batadv_tt_local_entry *tt_removed_entry;
 	struct batadv_tt_local_entry *tt_local_entry;
 	struct hlist_node *tt_removed_node;
 	u16 curr_flags = BATADV_NO_FLAGS;
@@ -1378,18 +1394,16 @@ u16 batadv_tt_local_remove(struct batadv_priv *bat_priv, const u8 *addr,
 	 */
 	batadv_tt_local_event(bat_priv, tt_local_entry, BATADV_TT_CLIENT_DEL);
 
+	/* remove exactly this object when still present in hash */
 	tt_removed_node = batadv_hash_remove(bat_priv->tt.local_hash,
-					     batadv_compare_tt,
+					     batadv_compare_tt_entry,
 					     batadv_choose_tt,
 					     &tt_local_entry->common);
 	if (!tt_removed_node)
 		goto out;
 
 	/* drop reference of remove hash entry */
-	tt_removed_entry = hlist_entry(tt_removed_node,
-				       struct batadv_tt_local_entry,
-				       common.hash_entry);
-	batadv_tt_local_entry_put(tt_removed_entry);
+	batadv_tt_local_entry_put(tt_local_entry);
 
 out:
 	batadv_tt_local_entry_put(tt_local_entry);

-- 
2.47.3

