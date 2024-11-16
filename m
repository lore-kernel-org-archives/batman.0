Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 718A3D68BF0
	for <batman@archiver.kernel.org>; Sat, 16 Nov 2024 21:36:26 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id EB77D840F4
	for <batman@archiver.kernel.org>; Sat, 16 Nov 2024 22:36:24 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1731792984;
 b=pS3bZkGBWGwRNNJuka3E3yciQLPwMBSnroh112en9JfI1Z8g9ukYz7PFQSs/yobBxHaks
 o+YnMSoGm24G1wDfqLdW7rqVA8ocfnM6nJMsr5/SNMvcdHY/KT0Y7mzhcsNzRcu19v+M1hr
 tamMICVMMyo4q6wYaUd1/2Serz5Xn8g=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1731792984; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=gRGXQPdTIGAlAMk6aVpuKgOTm6JMFCt3/6wY+EdOiVE=;
 b=ou6xSJ7j6+INJ20XZL2yx3eyDThRYv62tqWoqBBVw0OuOTamT+MwVjdugzujuG9zRWk9z
 pEW0v+wLbBiB/PqXGjsRP+0ttQuGgaPqeidSNvD9SGYPMgraQi7OwgmA9/E/khujpmB/JXP
 MAwQm7B5ql8GjvOdUHwv00auwxo5sDM=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=fail header.d=smtpservice.net;
  arc=pass;
  dmarc=fail (Used From Domain Record) header.from=triplefau.lt
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=fail header.d=smtpservice.net;
 arc=pass;
 dmarc=fail (Used From Domain Record) header.from=triplefau.lt policy.dmarc=quarantine
Received: from e2i340.smtp2go.com (e2i340.smtp2go.com [103.2.141.84])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 493F181CAE
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sat, 16 Nov 2024 22:33:18 +0100 (CET)
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1731792798; a=rsa-sha256;
	cv=none;
	b=k8yp1aFoo7xkqQUqxln/I03vBSPnL2JPstOCeIq/6lcilQ4D/QIm4K1mF4BsN0QwOvFe8j
	ZOw4VsE+SUp2l+Oyo0FazpsqsifAx+bf2G3jVfBiRBN4Gzvl+iE1SbhofV3aIIKuJbDLr+
	oDj932MoXsTuFTB0ZUNbqfao7k00WiA=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none ("invalid DKIM record") header.d=smtpservice.net
 header.s=maxzs0.a1-4.dyn header.b=ORaGa9Yl;
	dkim=pass header.d=triplefau.lt header.s=s510616 header.b=Rt7ST4BK;
	dmarc=pass (policy=quarantine) header.from=triplefau.lt;
	spf=pass (diktynna.open-mesh.org: domain of
 "bT.qvlkah60p9n7uf7=50cqxgof8a9n=7aqioyfw1y2pvz@em510616.triplefau.lt"
 designates 103.2.141.84 as permitted sender)
 smtp.mailfrom="bT.qvlkah60p9n7uf7=50cqxgof8a9n=7aqioyfw1y2pvz@em510616.triplefau.lt"
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1731792798;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=gRGXQPdTIGAlAMk6aVpuKgOTm6JMFCt3/6wY+EdOiVE=;
	b=zkarXQbbKLBtn5PF9Tjv6eEfzKDPGXFgs5Dgds1qXWbgdPitQUBUvs0Y1aVHie6GcV6+Fe
	kNOXJidyuHZMluGge3ihuTddMigW+Bja+kzKR0PAj7VesCUObsRZHCDtBk6XK/ceqt6ttB
	6xaB0r9Zb7CBAEeD1rOwfTzyYPI3/f8=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=smtpservice.net; s=maxzs0.a1-4.dyn; x=1731793698; h=Feedback-ID:
	X-Smtpcorp-Track:Message-Id:Date:Subject:To:From:Reply-To:Sender:
	List-Unsubscribe:List-Unsubscribe-Post;
	bh=gRGXQPdTIGAlAMk6aVpuKgOTm6JMFCt3/6wY+EdOiVE=; b=ORaGa9Yll5L/OXT0ZEJ8jGAtRT
	y1+aD4OvVoMmUQoSJ3WVD4OdaApOnOFfIz34ysAF7EljMxPlkvSveESeznaorqMuvN9QOCnVg+WhP
	mQc+Wgp86QXmKgkXQ/DV5ZJflksFAYLkdqFEr1F7rFVeaRuECgSCr4+Vy5KpFHfpQ9tiQ2NwoIOtM
	xIkbSe/GYT4+30hte/pqi8516GMkVSbA7COuOPI1qoQz9UzLOGd2pBQwIU4CZIezf184XJf3zHDcY
	rx9UgMCfORDi+kEIKr3SnBjyHGfUfuBOlzZkI3Ob58glTS0dugsj13M6Wb12uimOacYg7loV9AjXR
	n42kneTw==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triplefau.lt;
 i=@triplefau.lt; q=dns/txt; s=s510616; t=1731792798; h=from : subject
 : to : message-id : date;
 bh=gRGXQPdTIGAlAMk6aVpuKgOTm6JMFCt3/6wY+EdOiVE=;
 b=Rt7ST4BKPfS/c/+hR4aAHtJUsf/s4k5ybWeWwuXOuhvU3c2iiol/zsJiV0GIC4+VWK60p
 8ZnqSKAx1QKK++ADUwvh7Bzm2KR7jfYwtGYEJ9BPsAxevLSL6jpRmYafjOhRrsgv3y3NcBD
 Ndzyu8SKaXAJrQ8z8jVfa3KnU1IDDtg24CqGNTU29ry24riSbiZmZfXtg+RHw4qFF8K8jxL
 kXz7xy0lx6i7QmoJGiS2Xe65NJpef4M53s8aAKOTpY4JHxmo0HN1Ram6/CKNe8J/mO7PDHz
 JGBfcrOw/zmN+KEPW9ADqMnKwdDZyDLR58yNoaqMDhTk8BxOWW6HgNEZGq/A==
Received: from [10.139.162.187] (helo=SmtpCorp) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2-S2G) (envelope-from <repk@triplefau.lt>)
 id 1tCQPt-TRk4JG-G3; Sat, 16 Nov 2024 21:33:17 +0000
Received: from [10.12.239.196] (helo=localhost) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.97.1-S2G) (envelope-from <repk@triplefau.lt>)
 id 1tCQPt-4o5NDgrnRnT-kQOb; Sat, 16 Nov 2024 21:33:17 +0000
From: Remi Pommarel <repk@triplefau.lt>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Marek Lindner <mareklindner@neomailbox.ch>,
 Simon Wunderlich <sw@simonwunderlich.de>,
 Antonio Quartulli <a@unstable.cc>, Sven Eckelmann <sven@narfation.org>,
 Remi Pommarel <repk@triplefau.lt>
Subject: [PATCH v2 4/5] batman-adv: Remove atomic usage for tt.local_changes
Date: Sat, 16 Nov 2024 22:32:08 +0100
Message-Id: 
 <15b37f540888d50f068da096e4f46be033394efe.1731792497.git.repk@triplefau.lt>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <cover.1731792497.git.repk@triplefau.lt>
References: <cover.1731792497.git.repk@triplefau.lt>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Smtpcorp-Track: pjHTmeJgKlco.IgtiDssVValm.Y5zCewj8NbC
Feedback-ID: 510616m:510616apGKSTK:510616sMK70FM1WB
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>
Message-ID-Hash: Z6TGQTM4ULUIX53STNF474PMPIWLHENA
X-Message-ID-Hash: Z6TGQTM4ULUIX53STNF474PMPIWLHENA
X-MailFrom: 
 bT.qvlkah60p9n7uf7=50cqxgof8a9n=7aqioyfw1y2pvz@em510616.triplefau.lt
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/Z6TGQTM4ULUIX53STNF474PMPIWLHENA/>
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
index d7b43868b624..39704af81169 100644
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
 
@@ -3708,7 +3703,7 @@ static void batadv_tt_local_commit_changes_nolock(struct batadv_priv *bat_priv)
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

