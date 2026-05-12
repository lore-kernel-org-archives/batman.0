Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90BC7CD4F21
	for <batman@archiver.kernel.org>; Tue, 12 May 2026 19:58:35 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 1DF8885B30
	for <batman@archiver.kernel.org>; Tue, 12 May 2026 21:58:34 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1778615914;
 b=upHIMPAb42XTJ/PtlAVlvPkKizPh/E6LAL09UOO3Hg4dp0+PNmRlOJOZXqkGpGoSIk1qC
 YF3S/zCLoeLagrKTOoQ4egG0jwyupaSQfMpCPayVidIXTk2KOR3nqn5oDVtZNvltAGN7e2V
 kCCA9tZ/qR788ot/9pe1Nr+8rpTe+TE=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1778615914; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=0H1b30ZuINXc5HTj3gzjKl+MWSIFJa78qt6ftGAc3/c=;
 b=ZoQk1/65gHChowr3NJEdB6Ti4+N/wEPE5MqjFcvv3tbkwzBrsB45K3M2af3QSxx4LkcgW
 HrLJ329Lj4mCexqBUMJgCR7y953BUBVcgH93dsfkMgMlDcA18MgE0L0Gx8Cn61yV+NecUTD
 qEezLGm8DoaMxYwui0nbEHfsUyd17wU=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id C107785927
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 12 May 2026 21:53:43 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1778615623;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=0H1b30ZuINXc5HTj3gzjKl+MWSIFJa78qt6ftGAc3/c=;
	b=0AWSMYQdDq9Juzqs7pHVHF8UyC1MMgPgtp5E8lqBLN1Safv7pC29KR85diLUnaI1S/LWuw
	Z5G3PtPd09zFtEfKq9fpqh3L9xP20b4jnwH09dXibEmBBvG1kxm1GSFITWlt8Y9+C170n6
	GlAi/Go/qdpJFLTIaa6yK27cV8nM4uA=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=M78Vb8ED;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1778615623;
	b=a4moXTL4NRxtfjLyAcm2nTHPYccIRIoiyG0xYmEKpfhAUux+4vFuA6fn9LS7/6sUhOyWI/
	IqTxmoSZN4Rafs/v9ToQslg3eesBs9kRZ3idvc5iZDKve1Fjk26VeC5Q9MzvvpmyyFynlR
	9SdIwHVHJF0ecDxU7vAZUpAUaunEpPk=
Received: by dvalin.narfation.org (Postfix) id 8298C1FD98;
	Tue, 12 May 2026 19:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1778615623;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0H1b30ZuINXc5HTj3gzjKl+MWSIFJa78qt6ftGAc3/c=;
	b=M78Vb8EDqZSBnuJsd+7aPQxd/ns1/IaZW1cIs0DZyyAkklX6ougOJYVOa1AsisdK4NdC4B
	ubdfD16Hu9WuyMT1rd9KBi0pIaVPKXE/2Tt8UsC5yqDQpTgiS/7xdMt+4XvltPsFxiCoNU
	C5UOsuEiooEOscakuwnb8t6YnrQGzkA=
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 12 May 2026 21:53:11 +0200
Subject: [PATCH batadv 6/7] batman-adv: replace non-atomic last_ttvn with
 (READ|WRITE)_ONCE
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-atomic-to-write-once-v1-6-76a4272fac0d@narfation.org>
References: <20260512-atomic-to-write-once-v1-0-76a4272fac0d@narfation.org>
In-Reply-To: <20260512-atomic-to-write-once-v1-0-76a4272fac0d@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5818; i=sven@narfation.org;
 h=from:subject:message-id; bh=lcKZzWen6NcHHByVvmfYXwCUknRVt+sa+AeCSdYfeIk=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFnMrSqHV95U89SRymzu31wwe0LuEx5rAQa+hPUdbgyXY
 xbrnFHuKGVhEONikBVTZNlzJf/8Zva38p+nfTwKM4eVCWQIAxenAExE8Dwjw8cz88Xb1Y3yWJYq
 LfDdxjMnRfDUZ097TsG2m8sL7/Vf0GP4H1J/i8ul9cnGiefWpM8+fDt4xfVVgb7rQ14v79hpW67
 7kBsA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: FHHSKJ42CHUVFAVBTVHTZS26JSL6F5FX
X-Message-ID-Hash: FHHSKJ42CHUVFAVBTVHTZS26JSL6F5FX
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/FHHSKJ42CHUVFAVBTVHTZS26JSL6F5FX/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

The last TT version number of an meshif is only accessed as plain
loads/stores and does not require full atomic_t semantics. Convert to an
native integer and replace its users with READ_ONCE()/WRITE_ONCE() to avoid
load/store tearing.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/originator.c        |  2 +-
 net/batman-adv/routing.c           |  4 ++--
 net/batman-adv/send.c              |  2 +-
 net/batman-adv/translation-table.c | 16 ++++++++--------
 net/batman-adv/types.h             |  2 +-
 5 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
index 5a5cb277..84dfb4fd 100644
--- a/net/batman-adv/originator.c
+++ b/net/batman-adv/originator.c
@@ -965,7 +965,7 @@ struct batadv_orig_node *batadv_orig_node_new(struct batadv_priv *bat_priv,
 	orig_node->bat_priv = bat_priv;
 	ether_addr_copy(orig_node->orig, addr);
 	batadv_dat_init_orig_node_addr(orig_node);
-	atomic_set(&orig_node->last_ttvn, 0);
+	WRITE_ONCE(orig_node->last_ttvn, 0);
 	orig_node->tt_buff = NULL;
 	orig_node->tt_buff_len = 0;
 	orig_node->last_seen = jiffies;
diff --git a/net/batman-adv/routing.c b/net/batman-adv/routing.c
index 1dd295d9..cd4368b8 100644
--- a/net/batman-adv/routing.c
+++ b/net/batman-adv/routing.c
@@ -765,7 +765,7 @@ batadv_reroute_unicast_packet(struct batadv_priv *bat_priv, struct sk_buff *skb,
 			goto out;
 
 		orig_addr = orig_node->orig;
-		orig_ttvn = (u8)atomic_read(&orig_node->last_ttvn);
+		orig_ttvn = READ_ONCE(orig_node->last_ttvn);
 	}
 
 	/* update the packet header */
@@ -845,7 +845,7 @@ static bool batadv_check_unicast_ttvn(struct batadv_priv *bat_priv,
 		if (!orig_node)
 			return false;
 
-		curr_ttvn = (u8)atomic_read(&orig_node->last_ttvn);
+		curr_ttvn = READ_ONCE(orig_node->last_ttvn);
 		batadv_orig_node_put(orig_node);
 	}
 
diff --git a/net/batman-adv/send.c b/net/batman-adv/send.c
index c7e86c83..5f9da360 100644
--- a/net/batman-adv/send.c
+++ b/net/batman-adv/send.c
@@ -222,7 +222,7 @@ batadv_send_skb_push_fill_unicast(struct sk_buff *skb, int hdr_size,
 				  struct batadv_orig_node *orig_node)
 {
 	struct batadv_unicast_packet *unicast_packet;
-	u8 ttvn = (u8)atomic_read(&orig_node->last_ttvn);
+	u8 ttvn = READ_ONCE(orig_node->last_ttvn);
 
 	if (batadv_skb_head_push(skb, hdr_size) < 0)
 		return false;
diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index e5bf5a43..25acbb34 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -878,7 +878,7 @@ batadv_tt_prepare_tvlv_global_data(struct batadv_orig_node *orig_node,
 	}
 
 	(*tt_data)->flags = BATADV_NO_FLAGS;
-	(*tt_data)->ttvn = atomic_read(&orig_node->last_ttvn);
+	(*tt_data)->ttvn = READ_ONCE(orig_node->last_ttvn);
 	(*tt_data)->num_vlan = htons(num_vlan);
 
 	tt_vlan = (*tt_data)->vlan_data;
@@ -1859,7 +1859,7 @@ batadv_tt_global_dump_subentry(struct sk_buff *msg, u32 portid, u32 seq,
 	if (!hdr)
 		return -ENOBUFS;
 
-	last_ttvn = atomic_read(&orig->orig_node->last_ttvn);
+	last_ttvn = READ_ONCE(orig->orig_node->last_ttvn);
 
 	if (nla_put(msg, BATADV_ATTR_TT_ADDRESS, ETH_ALEN, common->addr) ||
 	    nla_put(msg, BATADV_ATTR_ORIG_ADDRESS, ETH_ALEN,
@@ -3050,7 +3050,7 @@ static bool batadv_send_other_tt_response(struct batadv_priv *bat_priv,
 	if (!res_dst_orig_node)
 		goto out;
 
-	orig_ttvn = (u8)atomic_read(&req_dst_orig_node->last_ttvn);
+	orig_ttvn = READ_ONCE(req_dst_orig_node->last_ttvn);
 	req_ttvn = tt_data->ttvn;
 
 	/* this node doesn't have the requested data */
@@ -3337,7 +3337,7 @@ static void batadv_tt_fill_gtable(struct batadv_priv *bat_priv,
 	orig_node->tt_buff = NULL;
 	spin_unlock_bh(&orig_node->tt_buff_lock);
 
-	atomic_set(&orig_node->last_ttvn, ttvn);
+	WRITE_ONCE(orig_node->last_ttvn, ttvn);
 
 out:
 	batadv_orig_node_put(orig_node);
@@ -3353,7 +3353,7 @@ static void batadv_tt_update_changes(struct batadv_priv *bat_priv,
 
 	batadv_tt_save_orig_buffer(bat_priv, orig_node, tt_change,
 				   batadv_tt_len(tt_num_changes));
-	atomic_set(&orig_node->last_ttvn, ttvn);
+	WRITE_ONCE(orig_node->last_ttvn, ttvn);
 }
 
 /**
@@ -3806,7 +3806,7 @@ static void batadv_tt_update_orig(struct batadv_priv *bat_priv,
 				  struct batadv_tvlv_tt_change *tt_change,
 				  u16 tt_num_changes, u8 ttvn)
 {
-	u8 orig_ttvn = (u8)atomic_read(&orig_node->last_ttvn);
+	u8 orig_ttvn = READ_ONCE(orig_node->last_ttvn);
 	struct batadv_tvlv_tt_vlan_data *tt_vlan;
 	bool full_table = true;
 	bool has_tt_init;
@@ -3948,7 +3948,7 @@ bool batadv_tt_add_temporary_global_entry(struct batadv_priv *bat_priv,
 
 	if (!batadv_tt_global_add(bat_priv, orig_node, addr, vid,
 				  BATADV_TT_CLIENT_TEMP,
-				  atomic_read(&orig_node->last_ttvn)))
+				  READ_ONCE(orig_node->last_ttvn)))
 		return false;
 
 	batadv_dbg(BATADV_DBG_TT, bat_priv,
@@ -4162,7 +4162,7 @@ static int batadv_roam_tvlv_unicast_handler_v1(struct batadv_priv *bat_priv,
 
 	batadv_tt_global_add(bat_priv, orig_node, roaming_adv->client,
 			     ntohs(roaming_adv->vid), BATADV_TT_CLIENT_ROAM,
-			     atomic_read(&orig_node->last_ttvn) + 1);
+			     READ_ONCE(orig_node->last_ttvn) + 1);
 
 out:
 	batadv_orig_node_put(orig_node);
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 913273ce..e1f405f6 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -443,7 +443,7 @@ struct batadv_orig_node {
 	unsigned long capa_initialized;
 
 	/** @last_ttvn: last seen translation table version number */
-	atomic_t last_ttvn;
+	u8 last_ttvn;
 
 	/** @tt_buff: last tt changeset this node received from the orig node */
 	unsigned char *tt_buff;

-- 
2.47.3

