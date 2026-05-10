Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0805DCD37AF
	for <batman@archiver.kernel.org>; Sun, 10 May 2026 09:33:08 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 5371C85C12
	for <batman@archiver.kernel.org>; Sun, 10 May 2026 11:33:07 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1778405587;
 b=QJIzJFR9NBUf6Ob5T7m7MSvPcI27DNxhq70oy3k4KDxshCJ1X0D6Al29JGXmcZHX0rlbO
 Yd4HmPABPFaCFa4hgKG6trPbd0KF0EtXEMwOYRgVFBLWWNSRW4wsgZLaC9qKgvD8YzZAReO
 8LehnehyFwsb3JhpBG1DOVWRnsc4+6Q=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1778405587; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=PCUiU671og5mU7SQihPEafA8emKZUawbchYXjCoa+cQ=;
 b=Fv8o8j+901YleiipB5hU2uqhrK0dC+tQ4ce8mQ2QNGuWJyhTzJL15a+Td6AWzFMMoDXV0
 fIUsRH963efURTOGV7TXO2s9c6ZIA8Yph4nONyyYNuIAGEyy0KQK12hBC/Kg6ybGFkE8Hte
 sKyXd7NDXU++RYYQIWEPeWJF7JObjdU=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 14192859D3
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 10 May 2026 11:31:16 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1778405476;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=PCUiU671og5mU7SQihPEafA8emKZUawbchYXjCoa+cQ=;
	b=hQphIouYYx4yiAavtxvI7w0YNWpE5s7uy1rU3FOyOPHgBkOU0UPsilmupCPcx7ktabrQ5q
	I7h0lzZm/vN4yQ+abmInWS+F2gHVhBztwWFgAgFZewVXi4baY3Yw2eOlCzJiKi6cyXjg/0
	ot2pVmT7osY0A5PTy/qvxRjc63PZwdI=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b="rLF/BHTK";
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1778405476;
	b=cA1T4OJo30LVeKAQWtNMBKfAZxgdZSrFWjnIic+MtQ4qb0Z0238SMC6j/EaTByvMoH+Hur
	QeVNx/8ttd0IIkVfXpwgA/fccy1KI3IZXu3s/bXTUyUDYtfGntNSc1YP6IQ6dCJ0rELgYe
	w4z5iP6jUVoL0kDdywTNxywGklLcd8w=
Received: by dvalin.narfation.org (Postfix) id AD13E21617;
	Sun, 10 May 2026 09:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1778405475;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PCUiU671og5mU7SQihPEafA8emKZUawbchYXjCoa+cQ=;
	b=rLF/BHTKA78pq6hBFIMKfYTRdn7pJ2h+jgLk0ApFHBPs9kvOilLx9RbYVv7WT7hm7NOZol
	QwgGlg+JC0ikYu8ISq3GLsnr6oJtWLamuqpG6nzKiXZIuc9RDVE41vy4OBYBNIL+9PTQ7/
	BRu6nCbyFkrj0xhJqJjk+9zmjtFF++E=
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 10 May 2026 11:31:00 +0200
Subject: [PATCH batadv v3 4/7] batman-adv: tt: fix TOCTOU race for reported
 vlans
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260510-fixes-followup-v3-4-1079a93bc964@narfation.org>
References: <20260510-fixes-followup-v3-0-1079a93bc964@narfation.org>
In-Reply-To: <20260510-fixes-followup-v3-0-1079a93bc964@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2608; i=sven@narfation.org;
 h=from:subject:message-id; bh=o1jALkBeu3YwznwSlcv20X1Cqa5GOtdkMooiE4tr2mc=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFkMASGfpb5PaPZmSXR8HlhacLTtUqvV9qtWrSW2+47lS
 d6dd1Wno5SFQYyLQVZMkWXPlfzzm9nfyn+e9vEozBxWJpAhDFycAjAR7oOMDCu/Xkr4OMNmXrnK
 rTcfKw67O2zp7W2ONed7fsi9li2ukoGRYWn3fwaxdxOTpZ5e2cp6XneuQvf/cKYkGZaNYvoV50O
 qGQE=
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: O4CEYB4QSQENKNVFJGZCN5O4CNAC4WDF
X-Message-ID-Hash: O4CEYB4QSQENKNVFJGZCN5O4CNAC4WDF
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/O4CEYB4QSQENKNVFJGZCN5O4CNAC4WDF/>
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

