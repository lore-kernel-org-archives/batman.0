Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7D4FCD3439
	for <batman-adv@archiver.kernel.org>; Wed,  6 May 2026 20:30:18 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 3AFF684578
	for <batman-adv@archiver.kernel.org>; Wed, 06 May 2026 22:30:17 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1778099417;
 b=q8V+Af44A/EoSVp/Bn2jWWf0Jn9A8GoVjkKKvGPevMegqgzFsWkGK8Vn5sm2LReRuBYqK
 M8HFPZ5ayYK2c7TmryfVVq5OEMy5x7mle7qyH9z1zFFzM8MnWmhGvCvNoN0w6LJyb95eaL2
 XN+KMzl7VAPyaPgyo0N1q4EO+Ifu93Q=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1778099417; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=BuZvFWw1MbKJMcgf8OOAeF/pAwjRrYLsKUqU3J2KTpY=;
 b=Q/80O3SMJOjGLdimieWMo9T1yFem4pIPlX5C0KAsgHPT642UjqRIUJdTom3oCGL4zG157
 JB/dr4h7hrvsRaX21ifR3H25C1cxtbKMDO1c52fCLj3ShIv2NdMN6n3QIcEFBdgPZzPtgOM
 BUt8iXdU+MfvD+cQZ98a1aaDh+TOFuI=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id D533B8065E
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 06 May 2026 22:22:45 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1778098965;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=BuZvFWw1MbKJMcgf8OOAeF/pAwjRrYLsKUqU3J2KTpY=;
	b=mnToCaIhFdt65FMEL5T6DEnaBl+49eeZVG4c7dRK95eD9R2NftvnWIOWh7AEtYJ9F7wtJW
	Bj768trebBlI9bSQXTB+JZrWD8+Lw+m8hw84Ne2ZFsaq12HXEEYHKSdoTO0TmY5Ua0d1yJ
	BsnLfE56p4nzZdFNSjiRE76BYK1CoM8=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=hSSDVZqy;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1778098965;
	b=XsGPEY03DsJuejIkvA80SEG3ZwlNwMMWkx5c3uPFAjwVMJuBhNB85WYLSil1HAYd4wHFDn
	ugom9+1N9roluIC/cz0kPfWKka8abcmffO5PRUtcKz5CNdGTKwEBixsK1vXgQ3QoF4lw4A
	cq1qkx5xHhbQtlFk1wfMlxgm2GYjtV4=
Received: by dvalin.narfation.org (Postfix) id 7D5F820D39;
	Wed, 06 May 2026 20:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1778098965;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BuZvFWw1MbKJMcgf8OOAeF/pAwjRrYLsKUqU3J2KTpY=;
	b=hSSDVZqyc+sFoBeoBTKAlYQDlyYAfRIceAOc5vh25F+fT7Uoc0usXoHWpJb1EX30+2Fbl9
	cXJNjuCxrVScE795Vg0ntZEMnzuVTqH+93m2frhcUs81RVAQdv1qMmCjWBi8PLGILmciva
	EE5J27nMY9Hmsa5SAn6br/XiHa8jbu8=
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 06 May 2026 22:20:58 +0200
Subject: [PATCH batadv v2 11/11] batman-adv: tt: prevent TVLV entry number
 overflow
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260506-fixes-followup-v2-11-ce32a2d8d4da@narfation.org>
References: <20260506-fixes-followup-v2-0-ce32a2d8d4da@narfation.org>
In-Reply-To: <20260506-fixes-followup-v2-0-ce32a2d8d4da@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Ao Zhou <n05ec@lzu.edu.cn>, Haoze Xie <royenheart@gmail.com>,
 Jiexun Wang <wangjiexun2025@gmail.com>, Juefei Pu <tomapufckgml@gmail.com>,
 Luxing Yin <tr0jan@lzu.edu.cn>, Ren Wei <n05ec@lzu.edu.cn>,
 Ruide Cao <caoruide123@gmail.com>, Xin Liu <bird@lzu.edu.cn>,
 Yifan Wu <yifanwucs@gmail.com>, Yuan Tan <yuantan098@gmail.com>,
 Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2279; i=sven@narfation.org;
 h=from:subject:message-id; bh=kaFQlN362gjem1e9G+GWtQRzBDLiT2gsLPe7GCBtQ2M=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDJm/Fx2MvL9RS79o5au9K5k91+8+3x+hIOolpbl+Y4FGh
 NDrENF5HaUsDGJcDLJiiix7ruSf38z+Vv7ztI9HYeawMoEMYeDiFICJlD1m+M1+p+JFlIRI6rS/
 qvGe7spxJXJLUvzXHpG8qmZVVmcYF8rIsCFBzn5N8Sv+v7/NfnjJPrGvl9W4KxaaHZLwUsjnMs8
 vTgA=
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: JZELE4B7UTZEW7SYIZCKWQ5W5LYCQTMP
X-Message-ID-Hash: JZELE4B7UTZEW7SYIZCKWQ5W5LYCQTMP
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/JZELE4B7UTZEW7SYIZCKWQ5W5LYCQTMP/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

The helpers to prepare the buffers for the local and global TT based
replies are trying to sum up all TT entries which can be found for each
VLAN. In theory, this sum can be too big for an u16 and therefore overflow.
A too small buffer would then be allocated for the TVLV.

The too small buffer will be handled gracefully by
batadv_tt_tvlv_generate() and is not causing a buffer overflow - just a
truncated reply. But this overflow shouldn't have happened in the first and
the too small buffer should never have been allocated when an overflow was
detected.

Fixes: 21a57f6e7a3b ("batman-adv: make the TT CRC logic VLAN specific")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/translation-table.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 66c2bf3d..d72adda4 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -844,11 +844,18 @@ batadv_tt_prepare_tvlv_global_data(struct batadv_orig_node *orig_node,
 	u16 total_entries = 0;
 	u8 *tt_change_ptr;
 	int vlan_entries;
+	u16 sum_entries;
 
 	spin_lock_bh(&orig_node->vlan_list_lock);
 	hlist_for_each_entry(vlan, &orig_node->vlan_list, list) {
 		vlan_entries = atomic_read(&vlan->tt.num_entries);
-		total_entries += vlan_entries;
+
+		if (check_add_overflow(vlan_entries, total_entries, &sum_entries)) {
+			*tt_len = 0;
+			goto out;
+		}
+
+		total_entries = sum_entries;
 		num_vlan++;
 	}
 
@@ -933,15 +940,22 @@ batadv_tt_prepare_tvlv_local_data(struct batadv_priv *bat_priv,
 	struct batadv_meshif_vlan *vlan;
 	size_t change_offset;
 	u16 num_vlan = 0;
-	u16 vlan_entries = 0;
 	u16 total_entries = 0;
 	u16 tvlv_len;
 	u8 *tt_change_ptr;
+	int vlan_entries;
+	u16 sum_entries;
 
 	spin_lock_bh(&bat_priv->meshif_vlan_list_lock);
 	hlist_for_each_entry(vlan, &bat_priv->meshif_vlan_list, list) {
 		vlan_entries = atomic_read(&vlan->tt.num_entries);
-		total_entries += vlan_entries;
+
+		if (check_add_overflow(vlan_entries, total_entries, &sum_entries)) {
+			tvlv_len = 0;
+			goto out;
+		}
+
+		total_entries = sum_entries;
 		num_vlan++;
 	}
 

-- 
2.47.3

