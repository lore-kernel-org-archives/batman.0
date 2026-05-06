Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5913ECD342C
	for <batman-adv@archiver.kernel.org>; Wed,  6 May 2026 20:28:48 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id DC9E385ACB
	for <batman-adv@archiver.kernel.org>; Wed, 06 May 2026 22:28:46 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1778099326;
 b=raUsMQoDh8G41zne8P0/NczUzLbVq0q9qLB/aOHQpDc5/c4L9yZRDyacDrqirlk6a9T16
 mgJgRo/YulS2jMra2saZ8XQATCa5e5Xii8F4NXxH77wL10mjKL62oLhRm/biHJYwFNJPcLP
 rf5w8bCEfFhz/1LSTOhyWWulIXV1t6Y=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1778099326; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=PCUiU671og5mU7SQihPEafA8emKZUawbchYXjCoa+cQ=;
 b=h/qbTLw2HbyGAbIlkYEdSNiZ6DhQvCtM9J0g6RmfpZQjQWuYYUXOD5PdOLMzHZz3bUeWT
 pLrM9tEFe8HHXxrjezxx4c8hKKrT7i03TneRzjcYeGuffB4U+wrZcHBaQimonCpaepoRPw0
 cFLWTooN9DYRhp+HBdRxPeBTE8BrzhU=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id D4791845AB
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 06 May 2026 22:22:25 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1778098945;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=PCUiU671og5mU7SQihPEafA8emKZUawbchYXjCoa+cQ=;
	b=ZSZ+EduMkXJBwezNbUFfcmxbtEPhhW8m31goC79CV68zQbZU2icNJPAC1Dw6rMOxYZYcPR
	qxe4pBuxiS+dVh96A1tvaCf4Px8m4H5SoZ2QrAVjHuYB2OIN63WQUhqVkxYddJfNp7wx2O
	OG7QbNG3kCNZusndKIxnEJv2dl2IaEo=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=OMw+fzrR;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1778098945;
	b=Z3CJtNB51wHhSCQ93NT61LHtIIN1lyoxaZtBki9OcJHnv+zlEIyWAWz3xDHNNEYEqCLlsw
	w9X0BV2Ric+9w3nXmI87q1NZTlNNdBQIFMxyoRAb4XdiDpsGHygntl99074sATQ28J7Iki
	0RF5lVFDxTdDYXxwn8nYb+1T67hFXIU=
Received: by dvalin.narfation.org (Postfix) id 5728D2170A;
	Wed, 06 May 2026 20:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1778098945;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PCUiU671og5mU7SQihPEafA8emKZUawbchYXjCoa+cQ=;
	b=OMw+fzrRaL2wfcBonVuAT9boA/WyFOMSe1vC0t0mhGnmDMMOqdZwq1XPPcic1b89w4pUx8
	q7B8MhzwzhmiXCyP125Usx18X6Q/Hrfkqq4JWtVV2w4MLromDm1Bf2lyO7vcimKG7e94du
	IGAQkcGwEfCw9+FhrD343R6nZxO0wAM=
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 06 May 2026 22:20:56 +0200
Subject: [PATCH batadv v2 09/11] batman-adv: tt: fix TOCTOU race for
 reported vlans
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260506-fixes-followup-v2-9-ce32a2d8d4da@narfation.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2608; i=sven@narfation.org;
 h=from:subject:message-id; bh=o1jALkBeu3YwznwSlcv20X1Cqa5GOtdkMooiE4tr2mc=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDJm/Fx2s0bD/tO/un8Xh1hZb5vuKMtyu5HA/e8YiQepK8
 2Ldl7cSOkpZGMS4GGTFFFn2XMk/v5n9rfznaR+PwsxhZQIZwsDFKQATmaHGyLD2+jpHht9/eJW1
 o9eIirYnx5uE62x7LGJqeWzXhHo9rkiG/zHrH+tbcEXWvLEW2+rluGB20TVj4X1RFnsWhs1z5Wr
 6yAQA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: QNYNVE3BJKWTFVF72LSW74HTSYL4QA6S
X-Message-ID-Hash: QNYNVE3BJKWTFVF72LSW74HTSYL4QA6S
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/QNYNVE3BJKWTFVF72LSW74HTSYL4QA6S/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

The local TT based TVLV is generated by first checking the number of VLANs
which have at least one TT entry. A new buffer with the correct size for
the VLANs is then allocated. Only then, the list of VLANs s used to fill
the VLAN entries in the buffer. During this time, the meshif_vlan_list_lock
is held. But the actual number of TT entries of each VLAN can still
increase during this time - just not the number of VLANs in the list.

But the prefilter used in the buffer size calculation might still cause an
increase of the number of VLANs which need to be stored. Simply because a
VLAN might now suddenly have at least one entry when it had none in the
pre-alloc check - and then needs to occupy space which was not allocated.

It is better to overestimate the buffer size at the beginning and then fill
the buffer only with the VLANs which are not empty.

Fixes: e4687b4be274 ("batman-adv: prevent TT request storms by not sending inconsistent TT TLVLs")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/translation-table.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index e65bd3ea..23e06cc4 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -927,11 +927,8 @@ batadv_tt_prepare_tvlv_local_data(struct batadv_priv *bat_priv,
 	spin_lock_bh(&bat_priv->meshif_vlan_list_lock);
 	hlist_for_each_entry(vlan, &bat_priv->meshif_vlan_list, list) {
 		vlan_entries = atomic_read(&vlan->tt.num_entries);
-		if (vlan_entries < 1)
-			continue;
-
-		num_vlan++;
 		total_entries += vlan_entries;
+		num_vlan++;
 	}
 
 	change_offset = struct_size(*tt_data, vlan_data, num_vlan);
@@ -956,6 +953,7 @@ batadv_tt_prepare_tvlv_local_data(struct batadv_priv *bat_priv,
 	(*tt_data)->num_vlan = htons(num_vlan);
 
 	tt_vlan = (*tt_data)->vlan_data;
+	num_vlan = 0;
 	hlist_for_each_entry(vlan, &bat_priv->meshif_vlan_list, list) {
 		vlan_entries = atomic_read(&vlan->tt.num_entries);
 		if (vlan_entries < 1)
@@ -966,8 +964,15 @@ batadv_tt_prepare_tvlv_local_data(struct batadv_priv *bat_priv,
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

