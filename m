Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 314EECD3427
	for <batman@archiver.kernel.org>; Sun, 10 May 2026 09:35:31 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id BC3D985CAC
	for <batman@archiver.kernel.org>; Sun, 10 May 2026 11:35:29 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1778405729;
 b=C4Ms8n0JKsnA2Enyo46AkJv53Nyfh8Wnh+hh3OgBp2SKONeTTjh8xTVrqlxrOCSVd1BAM
 rBc1tVipS/co7Jl4iozJ5+MSFa9V/o3WNtslHvgOLjerseyephGFoCaXUnbmkXEVgis1T3P
 y97iz8bjglzmz0KhkDIyvjXd7IhclT4=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1778405729; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=TcQLngwNsKG/JrkNVA+jRacmX62sp4zj/3eg/EPm07M=;
 b=EMJR76WBeScGVlWKronMT4Hlbb7XhKYLa12kGKbhRfQtuUv4ZQhVbj+bRdGdm6oLgs8BW
 X/+95c1BIIn4XGS+OR/HRXi7bAHG+0lso2DcTQ5xULFsZqNy2gD22HVxEy9EILOJ3GMwENc
 MM+/PE1JN3fqawDF33bD5J5Ryed+3eo=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id B842985AD0
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 10 May 2026 11:31:18 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1778405478;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=TcQLngwNsKG/JrkNVA+jRacmX62sp4zj/3eg/EPm07M=;
	b=yM65VB27lq/TFyQnTIdF43Eu/c2I/43UEPVrWlUW0sgAbF9grT3Ozy0O4hHHuqb3cEP3zA
	nDMDAKspU9ZTMXXML3WzabXJ2BoqcmDWLF4142BpZsSBrtvXhxcGl1Xb2O3iJ8Q4sbLZ6h
	wJ4AwwD6GxCx+NGeTwemSNkCz5yodq0=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=RCUxS5NN;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1778405478;
	b=CUKJXWukSzxUrSYLcs1SATgJ+UJsC0BbGOgaytlfTOUMDxidRJzFHbfDX9ttVe17S2y2JX
	KrtnvtWi/GQt3WZrxYt/BP6fZISrY5RKMm70NcnEnTzVVrp2ucXBA4LVMn/Q8nIixEXcui
	WoFXflCMJP2F9BbSrnCzlSlTjWU68/w=
Received: by dvalin.narfation.org (Postfix) id F29EC201FE;
	Sun, 10 May 2026 09:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1778405478;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TcQLngwNsKG/JrkNVA+jRacmX62sp4zj/3eg/EPm07M=;
	b=RCUxS5NNOPE/O6E8xbRXyDj3daOZ4VbDGG2Kmsj0CT4NX7/I3GKWmnmg587xLlsoMF8x58
	SjdnnrN+2n6c3YGy1w3FNbedlv09LcyxOEIpNYq+Ne/x2jpaXDWNWnabfDdiGvUBAcVxUp
	iFKPKp236dotjfUgWbWwOQVirDsTASQ=
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 10 May 2026 11:31:01 +0200
Subject: [PATCH batadv v3 5/7] batman-adv: tt: avoid empty VLAN responses
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260510-fixes-followup-v3-5-1079a93bc964@narfation.org>
References: <20260510-fixes-followup-v3-0-1079a93bc964@narfation.org>
In-Reply-To: <20260510-fixes-followup-v3-0-1079a93bc964@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2657; i=sven@narfation.org;
 h=from:subject:message-id; bh=OxE8+jtuQz3Ko7vMp1x7b+dHkLQ2GSJtSpFMzdGmbyk=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFkMASF7fpuxuEys7ntxTFhEdtlscY3Jwjtybt9umjPps
 bO2xlq2jlIWBjEuBlkxRZY9V/LPb2Z/K/952sejMHNYmUCGMHBxCsBEpp1i+MmYb8ebrOrzMH7N
 C6um9uRZrB++NBln6mY9Lu10Ydp3cw8jQ0/kDBOhyo1pS47++F6u/rLCdZrP9He77xutjEh1/e4
 4lQ8A
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: 54N4KZQIG755GNTEBH2GBM6TUNNZFIUS
X-Message-ID-Hash: 54N4KZQIG755GNTEBH2GBM6TUNNZFIUS
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/54N4KZQIG755GNTEBH2GBM6TUNNZFIUS/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

The commit e4687b4be274 ("batman-adv: prevent TT request storms by not
sending inconsistent TT TLVLs") added checks to the local (direct) TT
response code. But the response can also be done indirectly by another node
using the global TT state. To avoid such inconsistency states reported in
the original fix, also avoid sending empty VLANs for replies from the
global TT state.

Fixes: 21a57f6e7a3b ("batman-adv: make the TT CRC logic VLAN specific")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/translation-table.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 23e06cc4..66c2bf3d 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -837,24 +837,26 @@ batadv_tt_prepare_tvlv_global_data(struct batadv_orig_node *orig_node,
 				   s32 *tt_len)
 {
 	u16 num_vlan = 0;
-	u16 num_entries = 0;
 	u16 tvlv_len = 0;
 	unsigned int change_offset;
 	struct batadv_tvlv_tt_vlan_data *tt_vlan;
 	struct batadv_orig_node_vlan *vlan;
+	u16 total_entries = 0;
 	u8 *tt_change_ptr;
+	int vlan_entries;
 
 	spin_lock_bh(&orig_node->vlan_list_lock);
 	hlist_for_each_entry(vlan, &orig_node->vlan_list, list) {
+		vlan_entries = atomic_read(&vlan->tt.num_entries);
+		total_entries += vlan_entries;
 		num_vlan++;
-		num_entries += atomic_read(&vlan->tt.num_entries);
 	}
 
 	change_offset = struct_size(*tt_data, vlan_data, num_vlan);
 
 	/* if tt_len is negative, allocate the space needed by the full table */
 	if (*tt_len < 0)
-		*tt_len = batadv_tt_len(num_entries);
+		*tt_len = batadv_tt_len(total_entries);
 
 	if (change_offset > U16_MAX || *tt_len > U16_MAX - change_offset) {
 		*tt_len = 0;
@@ -875,14 +877,26 @@ batadv_tt_prepare_tvlv_global_data(struct batadv_orig_node *orig_node,
 	(*tt_data)->num_vlan = htons(num_vlan);
 
 	tt_vlan = (*tt_data)->vlan_data;
+	num_vlan = 0;
 	hlist_for_each_entry(vlan, &orig_node->vlan_list, list) {
+		vlan_entries = atomic_read(&vlan->tt.num_entries);
+		if (vlan_entries < 1)
+			continue;
+
 		tt_vlan->vid = htons(vlan->vid);
 		tt_vlan->crc = htonl(vlan->tt.crc);
 		tt_vlan->reserved = 0;
 
 		tt_vlan++;
+		num_vlan++;
 	}
 
+	/* recalculate in case number of VLANs reduced */
+	change_offset = struct_size(*tt_data, vlan_data, num_vlan);
+	tvlv_len = *tt_len + change_offset;
+
+	(*tt_data)->num_vlan = htons(num_vlan);
+
 	tt_change_ptr = (u8 *)*tt_data + change_offset;
 	*tt_change = (struct batadv_tvlv_tt_change *)tt_change_ptr;
 

-- 
2.47.3

