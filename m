Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82908C61DD9
	for <batman-adv@archiver.kernel.org>; Sun, 30 Aug 2026 15:32:13 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 2225A803CE
	for <batman-adv@archiver.kernel.org>; Sun, 30 Aug 2026 17:32:12 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1788103932;
 b=kktf+4SsQSYAHOgXOkrYcHLSTMMW3kMvjWTlAvNjR64mnqm1VxN6fC3f6nnpEfhfrXQ51
 iHI5pfG4zBebzm0WG8fY+I1RpKGpv4OiXEh4gDBQyMaHCzP4WS+HrDYpQQO9e4z4mR+SbG9
 uil1qhKR688uJEgn5KAENFkTLItyiNw=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1788103932; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=nlCBFpbL92zs+ZN2degIoUoAfkAxR9ACVAqcJyfBgt4=;
 b=foMQS0dJn3FXA377vDWlnUq5W6ub+lg1f0x44px1gAr/ZeBUEPEulv9bnLo4vTMEEPSms
 Obo/gkfrABxFYPYshtv479Xi0QhY50lvzV7/yPD276aCZLPOBQfvLpMg7/KxdD+i61NPqR1
 4mGjyOjf3lxMz0IYwsX4OHguOxFUxGY=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id ABFDD80562
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 30 Aug 2026 17:23:16 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1788103396;
	b=cpcxf6adihrIRUnKwy6D0UQLQHfAuBt0yQ4C+eYwELz+MJt7g1l+M2j6BDa1mQIubXgRL2
	Fg/3gIHfu8C23yUtnRdaiDOefYuiGZAh6G6Bl8Wj5+yrvJxQgxe/I/mhF1AnfEpYIal153
	xNFfkjF1R7Zzv40m6btn0Scd9HwEYr0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1788103396;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=nlCBFpbL92zs+ZN2degIoUoAfkAxR9ACVAqcJyfBgt4=;
	b=vIrSTiCH+bkPFsm96Fn35lN4FhQln7JpelvTi6HHWER621wR39+NZgHvBmXwOMkAGUYWXy
	OVUQc96gSTQYuBLrBh2zvCCxvRJmdv/T9Vh01ECOP/odmPE48cc5itCOobDgT7Qu2C1a0d
	sPNlol/z+pT7maBhj0vWrIX+aqjYWoU=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=KwXKuicI;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 4669A2083E;
	Sun, 30 Aug 2026 15:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1788103392;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nlCBFpbL92zs+ZN2degIoUoAfkAxR9ACVAqcJyfBgt4=;
	b=KwXKuicI2WEe6LJagNuEg6rg2FBhXHOKnqjieU9mbkFMc5YxENmyajKIidlyxA8UFiNE9c
	EySIVGJWxk6nctOV2yMIxRNAYHmiwdoe9kcsTFvZ5lhvAC0OfmZmB1s9Dz51LsoqVSTSDS
	sOrE2QSiTXd/4Yv+nl1tG4ddE04D09o=
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 30 Aug 2026 17:21:56 +0200
Subject: [PATCH batadv v6 19/20] batman-adv: tt: extract immediate purge of
 a local entry
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260830-tt-fixes-v6-19-a56568a15041@narfation.org>
References: <20260830-tt-fixes-v6-0-a56568a15041@narfation.org>
In-Reply-To: <20260830-tt-fixes-v6-0-a56568a15041@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3782; i=sven@narfation.org;
 h=from:subject:message-id; bh=NPFtFldsZYzXuNorhVL1x8p/6zksk5oTLiO7z6WEQ2k=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFlTvDoUDhfkWrG5fbvJsFLve5fI1ROhnlEZNV4qzMUiZ
 9fn+XR2lLIwiHExyIopsuy5kn9+M/tb+c/TPh6FmcPKBDKEgYtTACayeR/Db3a9C5HTHNqZ1O+d
 0Po9k29ejCUvx4tpltbSnnwTttwSa2T4X1rse/tqwvWnnYUL3q+KuMXsdG45w/YT2scsnPTVyxR
 /8AEA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: DOFH4RPGF6TMFOUZE4UNDQHMMHT2BARF
X-Message-ID-Hash: DOFH4RPGF6TMFOUZE4UNDQHMMHT2BARF
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/DOFH4RPGF6TMFOUZE4UNDQHMMHT2BARF/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

A client which was added after the last ttvn increment was never announced
and can be dropped from the local table right away. The code doing so is
the second half of batadv_tt_local_remove() and needed a goto to skip the
accounting when the entry was already gone from the hash.

Move it to batadv_tt_local_remove_now().

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/translation-table.c | 57 +++++++++++++++++++++++++-------------
 1 file changed, 37 insertions(+), 20 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 5ae47d6a..e5680da6 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -1528,6 +1528,42 @@ batadv_tt_local_mark_removed(struct batadv_tt_local_entry *tt_local_entry,
 	return pending;
 }
 
+/**
+ * batadv_tt_local_remove_now() - purge a local entry which was never announced
+ * @bat_priv: the bat priv with all the mesh interface information
+ * @tt_local_entry: local TT entry to purge
+ *
+ * A client which was added right after the last ttvn increment was never sent
+ * to the other nodes. It can therefore be dropped from the local table without
+ * waiting for the next ttvn increment.
+ */
+static void
+batadv_tt_local_remove_now(struct batadv_priv *bat_priv,
+			   struct batadv_tt_local_entry *tt_local_entry)
+{
+	struct batadv_tt_common_entry *common = &tt_local_entry->common;
+	struct hlist_node *tt_removed_node;
+
+	batadv_tt_local_event(bat_priv, tt_local_entry, BATADV_TT_CLIENT_DEL);
+
+	/* remove exactly this object when still present in hash */
+	tt_removed_node = batadv_hash_remove(bat_priv->tt.local_hash,
+					     batadv_compare_tt_entry,
+					     batadv_choose_tt, common);
+	if (!tt_removed_node)
+		return;
+
+	/* batadv_tt_local_transition_new() may have committed the entry and
+	 * thus counted it in the local table size since the
+	 * BATADV_TT_CLIENT_NEW check in batadv_tt_local_mark_removed().
+	 */
+	if (!(batadv_tt_flags_get(common) & BATADV_TT_CLIENT_NEW))
+		batadv_tt_local_size_dec(bat_priv, common->vid);
+
+	/* drop reference of remove hash entry */
+	batadv_tt_local_entry_put(tt_local_entry);
+}
+
 /**
  * batadv_tt_local_remove() - logically remove an entry from the local table
  * @bat_priv: the bat priv with all the mesh interface information
@@ -1543,7 +1579,6 @@ u16 batadv_tt_local_remove(struct batadv_priv *bat_priv, const u8 *addr,
 			   bool roaming)
 {
 	struct batadv_tt_local_entry *tt_local_entry;
-	struct hlist_node *tt_removed_node;
 	u16 curr_flags = BATADV_NO_FLAGS;
 	bool pending = false;
 	u16 flags;
@@ -1571,25 +1606,7 @@ u16 batadv_tt_local_remove(struct batadv_priv *bat_priv, const u8 *addr,
 	/* if this client has been added right now, it is possible to
 	 * immediately purge it
 	 */
-	batadv_tt_local_event(bat_priv, tt_local_entry, BATADV_TT_CLIENT_DEL);
-
-	/* remove exactly this object when still present in hash */
-	tt_removed_node = batadv_hash_remove(bat_priv->tt.local_hash,
-					     batadv_compare_tt_entry,
-					     batadv_choose_tt,
-					     &tt_local_entry->common);
-	if (!tt_removed_node)
-		goto out;
-
-	/* batadv_tt_local_transition_new() may have committed the entry and
-	 * thus counted it in the local table size since the BATADV_TT_CLIENT_NEW
-	 * check above.
-	 */
-	if (!(batadv_tt_flags_get(&tt_local_entry->common) & BATADV_TT_CLIENT_NEW))
-		batadv_tt_local_size_dec(bat_priv, tt_local_entry->common.vid);
-
-	/* drop reference of remove hash entry */
-	batadv_tt_local_entry_put(tt_local_entry);
+	batadv_tt_local_remove_now(bat_priv, tt_local_entry);
 
 out:
 	batadv_tt_local_entry_put(tt_local_entry);

-- 
2.47.3

