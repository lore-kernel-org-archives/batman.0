Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7135D711D2
	for <batman-adv@archiver.kernel.org>; Wed, 20 Nov 2024 17:50:52 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 35B0E83F23
	for <batman-adv@archiver.kernel.org>; Wed, 20 Nov 2024 18:50:51 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1732125051;
 b=mZy1CaZTsMD6fqMu5uf0f2DtkdqmSK3vcDNMKXAj5lUKbmV5rOTN7xkfnw6iDmIDHx1tP
 BbWec9AsZdZ7qt85di/u67+Kyng2peNRnk6vC2wVl1uPCD9UJO/FWrGot3XqHLfqls0GIP0
 4oXOGNaxzuruCWYl/+zndCQ/1Hdl1hc=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1732125051; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=gRGXQPdTIGAlAMk6aVpuKgOTm6JMFCt3/6wY+EdOiVE=;
 b=OCQgnGlKawXZ3rJ1oXtrd9LrOQ5jydgZN11p0VMsPhQKIw9mnLwb5L0sXGMQ7AhVh4DHF
 Xghv1ZcCG3NwDXUWwYnmiXlsicKYiU7YwYbtHp0L00MVSpJjWLIVGCxxHN6+y5jWNm2nuG2
 hyvaam91xWAVSP6wQI73H+vURbFVO+8=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=fail header.d=smtpservice.net;
  arc=pass;
  dmarc=fail (Used From Domain Record) header.from=triplefau.lt
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=fail header.d=smtpservice.net;
 arc=pass;
 dmarc=fail (Used From Domain Record) header.from=triplefau.lt policy.dmarc=quarantine
Received: from e2i340.smtp2go.com (e2i340.smtp2go.com [103.2.141.84])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id EBF9083AEC
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 20 Nov 2024 18:48:36 +0100 (CET)
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1732124917; a=rsa-sha256;
	cv=none;
	b=zuP+gzx2fMd5BeS/RfLUSDUYtxvZPGLwRTHiI6jIjiGrFhrW0w7tDNGd/Xq72XcptuL2p4
	R57wI62Pc1q9hVlbggmyHUi33Y1JY8LRKCGF5KdY3xIh/Uian7zv0Dmsc1Sa9oxcyNplvS
	RWuUfWFqrGuolob1L3Kk10D0kSQDEx0=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none ("invalid DKIM record") header.d=smtpservice.net
 header.s=maxzs0.a1-4.dyn header.b="XpSrFq/Z";
	dkim=pass header.d=triplefau.lt header.s=s510616 header.b=Fubdwva8;
	dmarc=pass (policy=quarantine) header.from=triplefau.lt;
	spf=pass (diktynna.open-mesh.org: domain of
 "bT.s9akojf7w5rd107=2eiyp887nhm2=2r3mrhz60mv252@em510616.triplefau.lt"
 designates 103.2.141.84 as permitted sender)
 smtp.mailfrom="bT.s9akojf7w5rd107=2eiyp887nhm2=2r3mrhz60mv252@em510616.triplefau.lt"
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1732124917;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=gRGXQPdTIGAlAMk6aVpuKgOTm6JMFCt3/6wY+EdOiVE=;
	b=3480NCl+UTqT6+0bz26oY4PpTeEBNuEpmdokaJ82SUHYEc849cX/iTz7wEtdu59VoPLgfg
	KDOi+weKfRNpKfKYumVFuXpCfBRV1exS8vdUcH02EUQmxLn+PjNnVZ2e1CLlKU6+9YS0VC
	e2+54b2DaQY82m7XtmiSSJT52AhHtq0=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=smtpservice.net; s=maxzs0.a1-4.dyn; x=1732125816; h=Feedback-ID:
	X-Smtpcorp-Track:Message-Id:Date:Subject:To:From:Reply-To:Sender:
	List-Unsubscribe:List-Unsubscribe-Post;
	bh=gRGXQPdTIGAlAMk6aVpuKgOTm6JMFCt3/6wY+EdOiVE=; b=XpSrFq/ZAzZcxylNAPY12aoct8
	VsseUw5a1RVb7OBdLm2KzQeNdp3+NE1wM96Bb6VvJpTp4TuAsWP0lWxe7KrbRA0Ja+hBgdhNWngKl
	oZpRGa9sqD30sILMAgwa9ujJ5lSoqhkMrmRSu4o5ztDkCoSn3e0yGwG1RahJVw2ywyTWsDivhE9VS
	gLJt3Xb0yBsYJ4VRobJ88dbIZMGmsxeY2uxOS4Vx7m7fkrr/seQ2OFcb+HS+V+6nVcGyFeky71vOO
	KAQTrTGb1dEvSs5Z6BjNtxQp5eq00ZnZ2Zg+Vr1h1qrqjKFaIByhAAcTNrRLKEsHANoojrvRUm0Wy
	LszRFaAw==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triplefau.lt;
 i=@triplefau.lt; q=dns/txt; s=s510616; t=1732124916; h=from : subject
 : to : message-id : date;
 bh=gRGXQPdTIGAlAMk6aVpuKgOTm6JMFCt3/6wY+EdOiVE=;
 b=Fubdwva83CJlZ1xdqGkYLff9LHoeE8SNjAHQkvFOsL4vI70MagTebUARgx9aVTzN0tNft
 sPWM/LHziMeMEJ1T0UeLguf9D0CpZYmcejPUGjuHvVGq0odmbR3vC9+tGAI1wj4jLf50xYR
 vOA680806SfSlbQDYBV/rairuQNHF6IRQ+DPRIXUt7Dy3Zow0rcl9JBo02t4OiCcEq6wOwg
 /NB1GBJvxXUkQoAhHz6LUKnKatkUOp6Q4eqytdR5hbtxKU5q2Z6rruIU7Ad7cD7dzkiIUru
 DJxqqjg+sQDvIKlLf7N5Mw5oZyWGVYhqycmoBGB6eAm86sCWz096WcQ9jdlQ==
Received: from [10.139.162.187] (helo=SmtpCorp) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2-S2G) (envelope-from <repk@triplefau.lt>)
 id 1tDooe-TRk3Ay-5J; Wed, 20 Nov 2024 17:48:36 +0000
Received: from [10.12.239.196] (helo=localhost) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.97.1-S2G) (envelope-from <repk@triplefau.lt>)
 id 1tDood-4o5NDgrjBs6-nUSU; Wed, 20 Nov 2024 17:48:35 +0000
From: Remi Pommarel <repk@triplefau.lt>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Marek Lindner <mareklindner@neomailbox.ch>,
 Simon Wunderlich <sw@simonwunderlich.de>,
 Antonio Quartulli <a@unstable.cc>, Sven Eckelmann <sven@narfation.org>,
 Remi Pommarel <repk@triplefau.lt>
Subject: [PATCH v3 4/5] batman-adv: Remove atomic usage for tt.local_changes
Date: Wed, 20 Nov 2024 18:47:17 +0100
Message-Id: 
 <8f60847b19a3646e13fd9eaa13cf8bca488b45f9.1732124716.git.repk@triplefau.lt>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <cover.1732124716.git.repk@triplefau.lt>
References: <cover.1732124716.git.repk@triplefau.lt>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Smtpcorp-Track: mg2-HAMiPs_3.oP_2io7rUqpN.vk6o2A1OHka
Feedback-ID: 510616m:510616apGKSTK:510616sO_9Ck_ObP
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>
Message-ID-Hash: DICRDUGNDPMLCTES6QWQVGPZTFBJMHQ7
X-Message-ID-Hash: DICRDUGNDPMLCTES6QWQVGPZTFBJMHQ7
X-MailFrom: 
 bT.s9akojf7w5rd107=2eiyp887nhm2=2r3mrhz60mv252@em510616.triplefau.lt
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/DICRDUGNDPMLCTES6QWQVGPZTFBJMHQ7/>
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

