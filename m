Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA55AE6916C
	for <batman-adv@archiver.kernel.org>; Fri, 22 Nov 2024 15:56:38 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 53D3984513
	for <batman-adv@archiver.kernel.org>; Fri, 22 Nov 2024 16:56:37 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1732290997;
 b=z6HgsKBmJkSCTZO80BS38bFaNp/6HQXZri59bUCF5lwfrLNBL21uniUzW1xaygOvSxViQ
 4nXmknFacVFuo8fKE86+vV17VN7rpX7aoKt9FgcHS4R5y+OvVJ0NM1Wgdlm49pm9LMXOmPQ
 KHP0kUXLAvTLL6bLPVnY3O+yBXJNzqo=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1732290997; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=VKvkWkmuG38R+omGcedcWNPtEBxKJ0cjy7RFLDK5D2U=;
 b=RqKd6STNTFtwyOz1UlmhgPoQpLTvEM+jKzsKJIEU28GEZNj07RxXvy1nkSo29eAFDBGbH
 P2Up9kNgxI9Q8ERYS+JFfL09s0tS2mtZ97meRwUmwe6O3vj7PixLAVl9m0A6wxlNdNguZ8o
 KJGvbSYg2lgPurAXc2dGhK+yIdd6hbk=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=fail header.d=smtpservice.net;
  arc=pass;
  dmarc=fail (Used From Domain Record) header.from=triplefau.lt
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=fail header.d=smtpservice.net;
 arc=pass;
 dmarc=fail (Used From Domain Record) header.from=triplefau.lt policy.dmarc=quarantine
Received: from e2i340.smtp2go.com (e2i340.smtp2go.com [103.2.141.84])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 2945283F76
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 22 Nov 2024 16:54:12 +0100 (CET)
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1732290852; a=rsa-sha256;
	cv=none;
	b=OlLEypXPra+zpsWdwguY43XLhasyHgeHPiqeHPbM1zq59IE9MfIDeOJw0p9/Gh6MlxUgha
	KCCRCWeC29w1F/YtOUsGEt/UXvHD1cjDz1N2O/yDyRnz8gyLQjUYxc2RaQeBEA1BrlOfsW
	GtCGlHd4lNjcUQQEYIEfcJCBs+YEDp8=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none ("invalid DKIM record") header.d=smtpservice.net
 header.s=maxzs0.a1-4.dyn header.b=WM7LuIQE;
	dkim=pass header.d=triplefau.lt header.s=s510616 header.b="BlcqH/dp";
	dmarc=pass (policy=quarantine) header.from=triplefau.lt;
	spf=pass (diktynna.open-mesh.org: domain of
 "bT.mhaxosk8qwnr4i0=hby2epvdei4e=ttqtuuutpjvd8q@em510616.triplefau.lt"
 designates 103.2.141.84 as permitted sender)
 smtp.mailfrom="bT.mhaxosk8qwnr4i0=hby2epvdei4e=ttqtuuutpjvd8q@em510616.triplefau.lt"
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1732290852;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=VKvkWkmuG38R+omGcedcWNPtEBxKJ0cjy7RFLDK5D2U=;
	b=N6M5wEZ47Evb4S2KaW/+PBaiv8BKGybJx5dzmEswCXcEhBR1nDgXLjGtEU25ynGLZlG01B
	jpBLVidZFfsLA8VizKwisoOPzWwSEiLTFFlpK16T7jNl/vlc1IhbpQN94A5shDbQlEadPH
	GBiSja4KymgElWw7k273PFplT7KcS2c=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=smtpservice.net; s=maxzs0.a1-4.dyn; x=1732291752; h=Feedback-ID:
	X-Smtpcorp-Track:Message-Id:Date:Subject:To:From:Reply-To:Sender:
	List-Unsubscribe:List-Unsubscribe-Post;
	bh=VKvkWkmuG38R+omGcedcWNPtEBxKJ0cjy7RFLDK5D2U=; b=WM7LuIQEQLeL76RJFpNzu/RRPf
	PWpPn3mRPGs4j7CkSMrllC5EHwqjzebafIDGn4KVv/5ywHirjKf2pFTcxp7A6mQaZ0NfTGIhwlJfQ
	1bBWIz9v1dTBh8gcL21aUjWEupe1k/b8xdghHN1EDlTBKrZ+dYpeno870BOXFXlgj0AE60PJOqCM7
	kAYk+O/ryfufXlFaaXpI+8J/vpLbaVG5ggb0YcDddt2856He3ImHKmADayZZRSGrbJK8t91S/Vgbg
	iFx24Nxo/hAxIKsjH01/bEwQ2blNNqsO7ljtvaPC6z2+cBIONfWAWYiPuivnYb4gYfTaSN8QwRp41
	tANE2Slg==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triplefau.lt;
 i=@triplefau.lt; q=dns/txt; s=s510616; t=1732290852; h=from : subject
 : to : message-id : date;
 bh=VKvkWkmuG38R+omGcedcWNPtEBxKJ0cjy7RFLDK5D2U=;
 b=BlcqH/dppdiiQ5Pp2yxQ2Q7Fz3+C6JgPXSt8BOYMAod3/i2Ba++5rjLtENs3Xx0deINz1
 LcWsibzHWVGtSTKb4ie2rzAxxcuPcgrDRckVCXogxQwH412zVk9xRIc6KUwr8FAE2PhXn1V
 pYA0FqEl8+2jFHM8XEL2XzsE4UF2X3luYC37Gyvv8b2cOwOu039tNWU5pbXQmT33Z9GkBoD
 s7y5diWvNuucFzTwY0AB4At6H/win06ydAtbFNUd6heZifMfuDpCwlp/JTtoAVmQWt0qAwa
 OeYZnl1ufpJGU6yle0Uvjv8sgs5ffp9FAhyttUXHjirUqWJ2tWJBGkQAk2Dw==
Received: from [10.172.233.58] (helo=SmtpCorp) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2-S2G) (envelope-from <repk@triplefau.lt>)
 id 1tEVz1-TRjz4e-BJ; Fri, 22 Nov 2024 15:54:11 +0000
Received: from [10.12.239.196] (helo=localhost) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.97.1-S2G) (envelope-from <repk@triplefau.lt>)
 id 1tEVz1-FnQW0hPtFAB-kRvT; Fri, 22 Nov 2024 15:54:11 +0000
From: Remi Pommarel <repk@triplefau.lt>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Marek Lindner <mareklindner@neomailbox.ch>,
 Simon Wunderlich <sw@simonwunderlich.de>,
 Antonio Quartulli <a@unstable.cc>, Sven Eckelmann <sven@narfation.org>,
 Remi Pommarel <repk@triplefau.lt>
Subject: [PATCH v4 4/5] batman-adv: Remove atomic usage for tt.local_changes
Date: Fri, 22 Nov 2024 16:52:51 +0100
Message-Id: 
 <791771d927478ef15dfd4103dc4285648acafa2b.1732290614.git.repk@triplefau.lt>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <cover.1732290614.git.repk@triplefau.lt>
References: <cover.1732290614.git.repk@triplefau.lt>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Smtpcorp-Track: 3W2DcvhQ0n16.r6M1v73OQJrQ.AS53gQoX1E1
Feedback-ID: 510616m:510616apGKSTK:510616sHlluK3jC9
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>
Message-ID-Hash: WRYU6JL5I2LYYOIWSROSSRBROV5DIXL3
X-Message-ID-Hash: WRYU6JL5I2LYYOIWSROSSRBROV5DIXL3
X-MailFrom: 
 bT.mhaxosk8qwnr4i0=hby2epvdei4e=ttqtuuutpjvd8q@em510616.triplefau.lt
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/WRYU6JL5I2LYYOIWSROSSRBROV5DIXL3/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

The tt.local_changes atomic is either written with tt.changes_list_lock
or close to it (see batadv_tt_local_event()). Thus the performance gain
using an atomic was limited (or because of atomic_read() impact even
negative). Using atomic also comes with the need to be wary of potential
negative tt.local_changes value.

Simplify the tt.local_changes usage by removing the atomic property and
modifying it only with tt.changes_list_lock held.

Signed-off-by: Remi Pommarel <repk@triplefau.lt>
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
index 53dea8ae96e4..f7e894811e7f 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -463,8 +463,8 @@ static void batadv_tt_local_event(struct batadv_priv *bat_priv,
 	struct batadv_tt_change_node *tt_change_node, *entry, *safe;
 	struct batadv_tt_common_entry *common = &tt_local_entry->common;
 	u8 flags = common->flags | event_flags;
-	bool event_removed = false;
 	bool del_op_requested, del_op_entry;
+	size_t changes;
 
 	tt_change_node = kmem_cache_alloc(batadv_tt_change_cache, GFP_ATOMIC);
 	if (!tt_change_node)
@@ -480,6 +480,7 @@ static void batadv_tt_local_event(struct batadv_priv *bat_priv,
 
 	/* check for ADD+DEL or DEL+ADD events */
 	spin_lock_bh(&bat_priv->tt.changes_list_lock);
+	changes = READ_ONCE(bat_priv->tt.local_changes);
 	list_for_each_entry_safe(entry, safe, &bat_priv->tt.changes_list,
 				 list) {
 		if (!batadv_compare_eth(entry->change.addr, common->addr))
@@ -508,21 +509,18 @@ static void batadv_tt_local_event(struct batadv_priv *bat_priv,
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
@@ -994,7 +992,7 @@ static void batadv_tt_tvlv_container_update(struct batadv_priv *bat_priv)
 	size_t tt_extra_len = 0;
 	u16 tvlv_len;
 
-	tt_diff_entries_num = atomic_read(&bat_priv->tt.local_changes);
+	tt_diff_entries_num = READ_ONCE(bat_priv->tt.local_changes);
 	tt_diff_len = batadv_tt_len(tt_diff_entries_num);
 
 	/* if we have too many changes for one packet don't send any
@@ -1021,7 +1019,7 @@ static void batadv_tt_tvlv_container_update(struct batadv_priv *bat_priv)
 		goto container_register;
 
 	spin_lock_bh(&bat_priv->tt.changes_list_lock);
-	atomic_set(&bat_priv->tt.local_changes, 0);
+	WRITE_ONCE(bat_priv->tt.local_changes, 0);
 
 	list_for_each_entry_safe(entry, safe, &bat_priv->tt.changes_list,
 				 list) {
@@ -1437,7 +1435,7 @@ static void batadv_tt_changes_list_free(struct batadv_priv *bat_priv)
 		kmem_cache_free(batadv_tt_change_cache, entry);
 	}
 
-	atomic_set(&bat_priv->tt.local_changes, 0);
+	WRITE_ONCE(bat_priv->tt.local_changes, 0);
 	spin_unlock_bh(&bat_priv->tt.changes_list_lock);
 }
 
@@ -3707,7 +3705,7 @@ static void batadv_tt_local_commit_changes_nolock(struct batadv_priv *bat_priv)
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
2.40.0

