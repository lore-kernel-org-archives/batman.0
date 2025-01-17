Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E738EC02183
	for <batman-adv@archiver.kernel.org>; Fri, 17 Jan 2025 12:41:36 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 6A3C2844AD
	for <batman-adv@archiver.kernel.org>; Fri, 17 Jan 2025 13:41:35 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1737117695;
 b=dVjrw60VphLiNgRGXWedYx8vEh7T5/kld0XT3T98DoAJebhxTRIsZuwYnlHNWPK5dNctR
 pbrbHR00Amt4KG8rHXMDb8knDMFaNnTcP8NkTcPr53SOJoYN4WFHy5CRsA1SPhGk+hTANZ8
 O/rO1/q5C9T6cDxWDwN5r2VB6N8h5Rc=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1737117695; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=U2uVS2tBo3pNLl1pDLV5KRxQt3Sf8ug0aYonE2qsCu4=;
 b=OLHC1edpMtqqPKs+HRL0n/73yOnROZB4BzuXhzP3sh7Y4iZrY3BgFwavDvbyzYJlcZ3vo
 V6sw0XoAAAWGVe4ppksqdN2Oiwyyj486EenqJJSomssVfLXbbgPOynI5BDjExIld1HGdoPQ
 9c+0GN9thW2B1mv2akMF89CRex90aSs=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=fail;
  arc=pass;
  dmarc=fail (Used From Domain Record) header.from=simonwunderlich.de
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass;
 dmarc=fail (Used From Domain Record) header.from=simonwunderlich.de
 policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 3CAD283DF4
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 17 Jan 2025 13:39:33 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1737117573;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U2uVS2tBo3pNLl1pDLV5KRxQt3Sf8ug0aYonE2qsCu4=;
	b=myPYrqftEnJcmB3hxrfvDhZJOSHl0tF8SP8XnswM2UA2WsmUvIzpFi+GvI8QeMQjSHqNg7
	MxCqikW0uLWSQINkY2zvlUQfHJEXcoQcTC1sstGkO3WZaOjo9ERCcuH0pMCaQFhhVtgrdE
	6XOYVLETe45mGN+3RrqKey0tdXaLAXg=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 23.88.38.48 as permitted sender) smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1737117573; a=rsa-sha256;
	cv=none;
	b=Rrl2XqnGAS+w0AbwJGlAIkXB4q3R4dGybLRrbi3jeqHyhX0q4QsBLVMUfITNFpuRAILPyJ
	e3zniJnd+/ZoMfPj0xRbjNT3WckyF8HQPV1R+17UUBNzJbZqPPbb04MGBcHf3Lbx1NpTN8
	029XQ39Q8zTJVZ8X27CpFxTRW4lOnRI=
Received: from kero.packetmixer.de
 (p200300C5973C90D8A96DD71A2E03f697.dip0.t-ipconnect.de
 [IPv6:2003:c5:973c:90d8:a96d:d71a:2e03:f697])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id 6CE27FA365;
	Fri, 17 Jan 2025 13:39:32 +0100 (CET)
From: Simon Wunderlich <sw@simonwunderlich.de>
To: kuba@kernel.org,
	davem@davemloft.net
Cc: netdev@vger.kernel.org,
	b.a.t.m.a.n@lists.open-mesh.org,
	Remi Pommarel <repk@triplefau.lt>,
	Sven Eckelmann <sven@narfation.org>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 03/10] batman-adv: Remove atomic usage for tt.local_changes
Date: Fri, 17 Jan 2025 13:39:03 +0100
Message-Id: <20250117123910.219278-4-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250117123910.219278-1-sw@simonwunderlich.de>
References: <20250117123910.219278-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: E5XGRGFZYHMBHRNN5K76ZGUQSOVP3B35
X-Message-ID-Hash: E5XGRGFZYHMBHRNN5K76ZGUQSOVP3B35
X-MailFrom: sw@simonwunderlich.de
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/E5XGRGFZYHMBHRNN5K76ZGUQSOVP3B35/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Remi Pommarel <repk@triplefau.lt>

The tt.local_changes atomic is either written with tt.changes_list_lock
or close to it (see batadv_tt_local_event()). Thus the performance gain
using an atomic was limited (or because of atomic_read() impact even
negative). Using atomic also comes with the need to be wary of potential
negative tt.local_changes value.

Simplify the tt.local_changes usage by removing the atomic property and
modifying it only with tt.changes_list_lock held.

Signed-off-by: Remi Pommarel <repk@triplefau.lt>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/soft-interface.c    |  2 +-
 net/batman-adv/translation-table.c | 24 +++++++++++-------------
 net/batman-adv/types.h             |  4 ++--
 3 files changed, 14 insertions(+), 16 deletions(-)

diff --git a/net/batman-adv/soft-interface.c b/net/batman-adv/soft-interface.c
index 2758aba47a2f..5666c268cead 100644
--- a/net/batman-adv/soft-interface.c
+++ b/net/batman-adv/soft-interface.c
@@ -783,13 +783,13 @@ static int batadv_softif_init_late(struct net_device *dev)
 	atomic_set(&bat_priv->mesh_state, BATADV_MESH_INACTIVE);
 	atomic_set(&bat_priv->bcast_seqno, 1);
 	atomic_set(&bat_priv->tt.vn, 0);
-	atomic_set(&bat_priv->tt.local_changes, 0);
 	atomic_set(&bat_priv->tt.ogm_append_cnt, 0);
 #ifdef CONFIG_BATMAN_ADV_BLA
 	atomic_set(&bat_priv->bla.num_requests, 0);
 #endif
 	atomic_set(&bat_priv->tp_num, 0);
 
+	WRITE_ONCE(bat_priv->tt.local_changes, 0);
 	bat_priv->tt.last_changeset = NULL;
 	bat_priv->tt.last_changeset_len = 0;
 	bat_priv->isolation_mark = 0;
diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index b44c382226a1..6e0345b91ece 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -423,8 +423,8 @@ static void batadv_tt_local_event(struct batadv_priv *bat_priv,
 	struct batadv_tt_change_node *tt_change_node, *entry, *safe;
 	struct batadv_tt_common_entry *common = &tt_local_entry->common;
 	u8 flags = common->flags | event_flags;
-	bool event_removed = false;
 	bool del_op_requested, del_op_entry;
+	size_t changes;
 
 	tt_change_node = kmem_cache_alloc(batadv_tt_change_cache, GFP_ATOMIC);
 	if (!tt_change_node)
@@ -440,6 +440,7 @@ static void batadv_tt_local_event(struct batadv_priv *bat_priv,
 
 	/* check for ADD+DEL or DEL+ADD events */
 	spin_lock_bh(&bat_priv->tt.changes_list_lock);
+	changes = READ_ONCE(bat_priv->tt.local_changes);
 	list_for_each_entry_safe(entry, safe, &bat_priv->tt.changes_list,
 				 list) {
 		if (!batadv_compare_eth(entry->change.addr, common->addr))
@@ -468,21 +469,18 @@ static void batadv_tt_local_event(struct batadv_priv *bat_priv,
 del:
 		list_del(&entry->list);
 		kmem_cache_free(batadv_tt_change_cache, entry);
+		changes--;
 		kmem_cache_free(batadv_tt_change_cache, tt_change_node);
-		event_removed = true;
-		goto unlock;
+		goto update_changes;
 	}
 
 	/* track the change in the OGMinterval list */
 	list_add_tail(&tt_change_node->list, &bat_priv->tt.changes_list);
+	changes++;
 
-unlock:
+update_changes:
+	WRITE_ONCE(bat_priv->tt.local_changes, changes);
 	spin_unlock_bh(&bat_priv->tt.changes_list_lock);
-
-	if (event_removed)
-		atomic_dec(&bat_priv->tt.local_changes);
-	else
-		atomic_inc(&bat_priv->tt.local_changes);
 }
 
 /**
@@ -950,7 +948,7 @@ static void batadv_tt_tvlv_container_update(struct batadv_priv *bat_priv)
 	int tt_diff_entries_count = 0;
 	u16 tvlv_len;
 
-	tt_diff_entries_num = atomic_read(&bat_priv->tt.local_changes);
+	tt_diff_entries_num = READ_ONCE(bat_priv->tt.local_changes);
 	tt_diff_len = batadv_tt_len(tt_diff_entries_num);
 
 	/* if we have too many changes for one packet don't send any
@@ -970,7 +968,7 @@ static void batadv_tt_tvlv_container_update(struct batadv_priv *bat_priv)
 		goto container_register;
 
 	spin_lock_bh(&bat_priv->tt.changes_list_lock);
-	atomic_set(&bat_priv->tt.local_changes, 0);
+	WRITE_ONCE(bat_priv->tt.local_changes, 0);
 
 	list_for_each_entry_safe(entry, safe, &bat_priv->tt.changes_list,
 				 list) {
@@ -1380,7 +1378,7 @@ static void batadv_tt_changes_list_free(struct batadv_priv *bat_priv)
 		kmem_cache_free(batadv_tt_change_cache, entry);
 	}
 
-	atomic_set(&bat_priv->tt.local_changes, 0);
+	WRITE_ONCE(bat_priv->tt.local_changes, 0);
 	spin_unlock_bh(&bat_priv->tt.changes_list_lock);
 }
 
@@ -3634,7 +3632,7 @@ static void batadv_tt_local_commit_changes_nolock(struct batadv_priv *bat_priv)
 {
 	lockdep_assert_held(&bat_priv->tt.commit_lock);
 
-	if (atomic_read(&bat_priv->tt.local_changes) < 1) {
+	if (READ_ONCE(bat_priv->tt.local_changes) == 0) {
 		if (!batadv_atomic_dec_not_zero(&bat_priv->tt.ogm_append_cnt))
 			batadv_tt_tvlv_container_update(bat_priv);
 		return;
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 04f6398b3a40..f491bff8c51b 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -1022,7 +1022,7 @@ struct batadv_priv_tt {
 	atomic_t ogm_append_cnt;
 
 	/** @local_changes: changes registered in an originator interval */
-	atomic_t local_changes;
+	size_t local_changes;
 
 	/**
 	 * @changes_list: tracks tt local changes within an originator interval
@@ -1044,7 +1044,7 @@ struct batadv_priv_tt {
 	 */
 	struct list_head roam_list;
 
-	/** @changes_list_lock: lock protecting changes_list */
+	/** @changes_list_lock: lock protecting changes_list & local_changes */
 	spinlock_t changes_list_lock;
 
 	/** @req_list_lock: lock protecting req_list */
-- 
2.39.5

