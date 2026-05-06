Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8570CCD342C
	for <batman-adv@archiver.kernel.org>; Wed,  6 May 2026 20:29:33 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 1576E8516C
	for <batman-adv@archiver.kernel.org>; Wed, 06 May 2026 22:29:32 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1778099372;
 b=0OYMQ71vfQZhYSWBU27cCUrb2A8tYCeDQhSNZbYZdHv7+/g336PSd6JzeCI99j4dQOWKq
 faImqiYqo0BMH6oeMCDhL4acRzQCSxYFNkWOIMlNLX6oIpXSPdimaqr97xVnplYdj6QO+sE
 32VGOMFDX8E6mlW8PuDzXXYZWkIuhH4=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1778099372; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=TcQLngwNsKG/JrkNVA+jRacmX62sp4zj/3eg/EPm07M=;
 b=jzG3CXdp3JKvQHekNY9fm2qK+DNegurp437xw10xIL7PslSxzyPS+pyEI2xSvdEQpHDe4
 mxfJzcRpiN4uo1jpq3tjBBF66+rxLZeJHsqqO0E9NRfaZVfFUJ/SdIC8Dl8c1ljhoef6RFS
 x0BCt9Ay9Az9Th+X30wqpN4KFTfARBo=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id F289D8457B
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 06 May 2026 22:22:27 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1778098948;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=TcQLngwNsKG/JrkNVA+jRacmX62sp4zj/3eg/EPm07M=;
	b=uNvhl/aoyog+PrjgEIeol2c1qYrbxCR2XRiQLCyqzh/pDa2G/SToy3QSlZSudYk9rfhtXp
	zmakNXI4O5Wt+rtcm3XMjIjDSmTIYGC3KxVENd5HTU7xBuFqBXdrHZvnhwvEX2lfTVGkmy
	lu8Aar7R1AaTcMGIM+inFqQ+laoFZxY=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=WzRTd3Vs;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1778098948;
	b=SVfYfZ5r6LxQ1rB4Pca3QaimE2q4r3Q8Pbe6c1ysRc35Q0H5etRlUAFW4i+aScFEQX/Hig
	BUmgTv/LwOPAXOzeR1VO5180O9BHGQOYLTK1o9z+SrNzPp2VaUZi4sO76nRbiyRybZ62Js
	K+Y9pcrEDyPgVrKB/eM8+ELPx+Og2Bc=
Received: by dvalin.narfation.org (Postfix) id 9D0A020D39;
	Wed, 06 May 2026 20:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1778098947;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TcQLngwNsKG/JrkNVA+jRacmX62sp4zj/3eg/EPm07M=;
	b=WzRTd3VsD3pozPw2hTMbmsYv/6Hl7amC0/ps2uP0rnJaADSjKpnygnxy3qxzu+24vSZKjL
	eTVzZZ1NfjVxaM7J5M8BcnZVcY4FvbHjpn2OkWTDg29eenzih/BR2MCEA5GA4pGwym441o
	B9r8dSHPgO5D8VHytmFrnu8l+f6eWyg=
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 06 May 2026 22:20:57 +0200
Subject: [PATCH batadv v2 10/11] batman-adv: tt: avoid empty VLAN responses
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260506-fixes-followup-v2-10-ce32a2d8d4da@narfation.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2657; i=sven@narfation.org;
 h=from:subject:message-id; bh=OxE8+jtuQz3Ko7vMp1x7b+dHkLQ2GSJtSpFMzdGmbyk=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDJm/Fx0843x33Xf1W1r1rgX8uvySPl84inq/hHN9mnDv6
 E6O8s7PHaUsDGJcDLJiiix7ruSf38z+Vv7ztI9HYeawMoEMYeDiFICJaNgzMkxb5iAe23/sUHHX
 cQajnsjPCW9OCCxLWLT2RvSFD3+6vP4yMjzbx36L6/6pGh7V1qsqC2/a8Fz9PsurrS5o1trq9oe
 +LnwA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: Z7FOM6Y5SONVXLS6RDOGL5IJRO47Z2CJ
X-Message-ID-Hash: Z7FOM6Y5SONVXLS6RDOGL5IJRO47Z2CJ
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/Z7FOM6Y5SONVXLS6RDOGL5IJRO47Z2CJ/>
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

