Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4F49E6F08E
	for <batman@archiver.kernel.org>; Fri,  1 Nov 2024 22:07:54 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 1F26083F65
	for <batman@archiver.kernel.org>; Fri,  1 Nov 2024 23:07:53 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1730498873;
 b=VvCtN1p0co3zCNGv49tMt3L8Xd/fDjX66ninX4tp5tpSEhGjdpvsj9qFc+DaZnUZ3C3am
 g7faxXn8w39scEyBmlfX/2pKzRg8ymqIpTf4BBjrLj3SIsTfrKizJ3EI0DZIi62dmlF45s8
 cUhApHIpi3qtkNVbbTInYjl/D/4mV3M=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1730498873; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=mRwwZcgXFXYl5sXx8boQulcaUR9D20rIPNRkwAyJKIk=;
 b=eu4cuNm3XY300LaZpp/xcKvdIKH5BKqJmav/4caTANgLS+pBsdGYQ0SzpcyR1BfB+S/G7
 47dElX3uxrkr3t9ZPf6Un4D6zvvRVTXBcCjNTeyQEDbVBxvWS2F7ALf9sRKDrFwF0UcNcri
 zzWogwLGe/tn0VrGIWV0+5JUiDbAQNo=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=fail header.d=smtpservice.net;
  arc=pass;
  dmarc=fail (Used From Domain Record) header.from=triplefau.lt
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=fail header.d=smtpservice.net;
 arc=pass;
 dmarc=fail (Used From Domain Record) header.from=triplefau.lt policy.dmarc=quarantine
Received: from e2i340.smtp2go.com (e2i340.smtp2go.com [103.2.141.84])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 2946F8176B
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri,  1 Nov 2024 23:05:43 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1730498743;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=mRwwZcgXFXYl5sXx8boQulcaUR9D20rIPNRkwAyJKIk=;
	b=oBMIs3JzQ9JwTbD47W9TiDfOPXGrywXhSnTYoNnMRFQzhwvnhjO4JbsS73DBLVsr9Np2VN
	Li5q/vowpHQ5wCsRE6RzHGU76PA7/l18nnBHnx8URWoE5zgLpIKBgDp7S0sfBhL5rBI77h
	52xcnQZtZk/2E4NpqLCqw2aGuEJsezg=
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1730498743; a=rsa-sha256;
	cv=none;
	b=m9XETN3sALHOfThpvq13ksdlkWvhSlao8iLMFo5pWts2NdSM4Rt7WwWOxYeXYGac18Cjc+
	5rZP4SlIo1Vr5ofPTVDxhKZqqBs0Gq8/pMeRogW+dcmkcYEpCcKX8rdQTrBSx4h76Lfc/V
	hlk4D403btO7BosM5hzN6KBi/RrjWxw=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none ("invalid DKIM record") header.d=smtpservice.net
 header.s=maxzs0.a1-4.dyn header.b=SPb0KFWf;
	dkim=pass header.d=triplefau.lt header.s=s510616 header.b=MvqboimW;
	spf=pass (diktynna.open-mesh.org: domain of
 "bT.n3fmj6chkhz6aa7=h6bm5ui6ip0a=0ayilt0w8clcsr@em510616.triplefau.lt"
 designates 103.2.141.84 as permitted sender)
 smtp.mailfrom="bT.n3fmj6chkhz6aa7=h6bm5ui6ip0a=0ayilt0w8clcsr@em510616.triplefau.lt";
	dmarc=pass (policy=quarantine) header.from=triplefau.lt
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=smtpservice.net; s=maxzs0.a1-4.dyn; x=1730499643; h=Feedback-ID:
	X-Smtpcorp-Track:Message-Id:Date:Subject:To:From:Reply-To:Sender:
	List-Unsubscribe:List-Unsubscribe-Post;
	bh=mRwwZcgXFXYl5sXx8boQulcaUR9D20rIPNRkwAyJKIk=; b=SPb0KFWfoc2TyYxYJL1EJ75B1p
	myZujnPdtTJnOqnHCv4KElqvzi3e/eC5VOLUzajkHrsNseZl3RsRBvnKN/bj7KOVXG/Rd4Ahj/BZg
	wGBDCiTmsXR6FZRE6bAWguqLPCYoQq3sFQ2catrSJIqkHdqL9MSRsfkZ+NkVNRuZYn+vL1DqSqWY4
	WhCqve4WRB5oL11qtC32KMB/ZYiNyrnjNRFHa7zkOdYqgWJaoNaq17hskLv2lVd43tsCSapa0TRzC
	8Yk33uTcg6GV3boQVxhjMDIQUuzCSPgk5pK5/+pXnbI+r/eq9gFlhoeGWjcpA1A9i9ifxWXvIxlU5
	pjq14NzQ==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triplefau.lt;
 i=@triplefau.lt; q=dns/txt; s=s510616; t=1730498743; h=from : subject
 : to : message-id : date;
 bh=mRwwZcgXFXYl5sXx8boQulcaUR9D20rIPNRkwAyJKIk=;
 b=MvqboimW7MY9lnOZjOUXyxEiNxBmWwgOVI7+otvmkldinSCmEimCU9ZVepGkTrx7CHZiB
 FaKTWWZe09Butra5xlKvkNz3UWfB7ChN3BdPH9gIM6qtJmljImJo+X21Ee3DcLAzi2xI8YY
 JKCGgHL/4QYFPZMm+vE29wiaRcze7M2HmgvSUYmTGBvYPeJJWNHE93XwVYjN5Jfr94O250e
 APM9cFGoX2NKY2K0fpTXTpcj1UaIF4zQlmpm4ms7cgTKBbajFcJfKJJpR4TarEWtlchm/4/
 q2muUqVYfCMTUzRjhZP5YuEhFW59hEpHeBkDeVd/PBDeBOcFruzPbLI4+Glw==
Received: from [10.172.233.58] (helo=SmtpCorp) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2-S2G) (envelope-from <repk@triplefau.lt>)
 id 1t6zm2-TRk4qV-BX; Fri, 01 Nov 2024 22:05:42 +0000
Received: from [10.12.239.196] (helo=localhost) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.97.1-S2G) (envelope-from <repk@triplefau.lt>)
 id 1t6zm1-FnQW0hQ0fcn-oA4w; Fri, 01 Nov 2024 22:05:42 +0000
From: Remi Pommarel <repk@triplefau.lt>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Marek Lindner <mareklindner@neomailbox.ch>,
 Simon Wunderlich <sw@simonwunderlich.de>,
 Sven Eckelmann <sven@narfation.org>, Remi Pommarel <repk@triplefau.lt>
Subject: [RFC PATCH 3/4] batman-adv: Remove atomic usage for tt.local_changes
Date: Fri,  1 Nov 2024 23:05:01 +0100
Message-Id: 
 <76a873bb36c47de9dfa5c9a028a6354341416e55.1730497875.git.repk@triplefau.lt>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <cover.1730497875.git.repk@triplefau.lt>
References: <cover.1730497875.git.repk@triplefau.lt>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Smtpcorp-Track: oee0yuRNAaks.cPS4KyLKlYUY.HebwRQzQ7VY
Feedback-ID: 510616m:510616apGKSTK:510616sbOVPCYDuJ
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>
Message-ID-Hash: THBOYIHKFEB4CTF2RIKKQ4RLTMFXJAH3
X-Message-ID-Hash: THBOYIHKFEB4CTF2RIKKQ4RLTMFXJAH3
X-MailFrom: 
 bT.n3fmj6chkhz6aa7=h6bm5ui6ip0a=0ayilt0w8clcsr@em510616.triplefau.lt
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/THBOYIHKFEB4CTF2RIKKQ4RLTMFXJAH3/>
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
 net/batman-adv/translation-table.c | 17 ++++++-----------
 net/batman-adv/types.h             |  4 ++--
 3 files changed, 9 insertions(+), 14 deletions(-)

diff --git a/net/batman-adv/soft-interface.c b/net/batman-adv/soft-interface.c
index 2758aba47a2f..2575f13992d2 100644
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
 
+	bat_priv->tt.local_changes = 0;
 	bat_priv->tt.last_changeset = NULL;
 	bat_priv->tt.last_changeset_len = 0;
 	bat_priv->isolation_mark = 0;
diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 50af82e7b50a..a22029511eb2 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -463,7 +463,6 @@ static void batadv_tt_local_event(struct batadv_priv *bat_priv,
 	struct batadv_tt_change_node *tt_change_node, *entry, *safe;
 	struct batadv_tt_common_entry *common = &tt_local_entry->common;
 	u8 flags = common->flags | event_flags;
-	bool event_removed = false;
 	bool del_op_requested, del_op_entry;
 
 	tt_change_node = kmem_cache_alloc(batadv_tt_change_cache, GFP_ATOMIC);
@@ -508,21 +507,17 @@ static void batadv_tt_local_event(struct batadv_priv *bat_priv,
 del:
 		list_del(&entry->list);
 		kmem_cache_free(batadv_tt_change_cache, entry);
+		bat_priv->tt.local_changes--;
 		kmem_cache_free(batadv_tt_change_cache, tt_change_node);
-		event_removed = true;
 		goto unlock;
 	}
 
 	/* track the change in the OGMinterval list */
 	list_add_tail(&tt_change_node->list, &bat_priv->tt.changes_list);
+	bat_priv->tt.local_changes++;
 
 unlock:
 	spin_unlock_bh(&bat_priv->tt.changes_list_lock);
-
-	if (event_removed)
-		atomic_dec(&bat_priv->tt.local_changes);
-	else
-		atomic_inc(&bat_priv->tt.local_changes);
 }
 
 /**
@@ -994,7 +989,7 @@ static void batadv_tt_tvlv_container_update(struct batadv_priv *bat_priv)
 	size_t tt_extra_len = 0;
 	u16 tvlv_len;
 
-	tt_diff_entries_num = atomic_read(&bat_priv->tt.local_changes);
+	tt_diff_entries_num = READ_ONCE(bat_priv->tt.local_changes);
 	tt_diff_len = batadv_tt_len(tt_diff_entries_num);
 
 	/* if we have too many changes for one packet don't send any
@@ -1022,7 +1017,7 @@ static void batadv_tt_tvlv_container_update(struct batadv_priv *bat_priv)
 	tt_data->flags = BATADV_TT_OGM_DIFF;
 
 	spin_lock_bh(&bat_priv->tt.changes_list_lock);
-	atomic_set(&bat_priv->tt.local_changes, 0);
+	bat_priv->tt.local_changes = 0;
 
 	list_for_each_entry_safe(entry, safe, &bat_priv->tt.changes_list,
 				 list) {
@@ -1438,7 +1433,7 @@ static void batadv_tt_changes_list_free(struct batadv_priv *bat_priv)
 		kmem_cache_free(batadv_tt_change_cache, entry);
 	}
 
-	atomic_set(&bat_priv->tt.local_changes, 0);
+	bat_priv->tt.local_changes = 0;
 	spin_unlock_bh(&bat_priv->tt.changes_list_lock);
 }
 
@@ -3701,7 +3696,7 @@ static void batadv_tt_local_commit_changes_nolock(struct batadv_priv *bat_priv)
 {
 	lockdep_assert_held(&bat_priv->tt.commit_lock);
 
-	if (atomic_read(&bat_priv->tt.local_changes) < 1) {
+	if (READ_ONCE(bat_priv->tt.local_changes) < 1) {
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

