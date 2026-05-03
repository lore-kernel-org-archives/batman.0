Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3AC8FF886F
	for <batman@archiver.kernel.org>; Sun,  3 May 2026 20:48:21 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 5490285B9F
	for <batman@archiver.kernel.org>; Sun, 03 May 2026 22:48:20 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1777841300;
 b=wlgV9k8IYMiVDLRpjzRNHUkkyWISL7/7T6QWjvb6ssL1lv/SZ+fhMZSGq8yrxMYLv+FSn
 GVfmONpMKrxVXJCU6VXlD9M73poFgzws1knc8P9PQRbq64IJtUsNj/B/OFshBzj/MEAuAdW
 tFqi7Ulvfsiekar0S4Ip40TYKzgtrxo=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1777841300; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=85J0pCyPVfqI7cY3B2818eUg94JB2W47d+TYWfeXVeg=;
 b=VwZKkHAvzCCvIrDL0r2B+4XbQyuuEi8LVjq3HoEc9S1gOCz405sdhMTjcAPdYRUomChvr
 bV84z+Y6V+xXVaPEq4Vj2CWAlpAROVYsG1sVrILBCLtXLjXq3348Zvl3Z92fbJyNY1rRrz6
 ZyCrl7rQ7SjNoBn+NCiP4G4UMl5B8iM=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id D01A784730
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 03 May 2026 22:47:08 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1777841228;
	b=djZeeSS/7U14osnnoX5E3I5gop4BSxSsxgSDBrHryFlfHCrSWv8GmC+rECV9inqXTV/a+g
	9AIwIwsAo+E1jXKB+qCTzE1hxGc5tLOR/SfhVFJcA2XD88T+O/8FppnksDl+h/f595lSx0
	P/CXc7kwXjhUtuk+oZ6q6swFPLP0fYc=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=VBrgblMJ;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1777841228;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=85J0pCyPVfqI7cY3B2818eUg94JB2W47d+TYWfeXVeg=;
	b=KsVFHqAAiXur8GDq0zvuQwkfhiWrWoZUlgQZZmOrS4U4fICZrWM2xqOsohNLf232UyHEeA
	a4t6bIf6ZpqELaLHbYFuLMYy88qRpXQhsrdnyQYY7NVag2EyBoyBuMm5E54b9SxKCA4lKj
	c3VCxdlY/iQstbKyPtZtpQK+bI749WM=
Received: by dvalin.narfation.org (Postfix) id D23F21FDD3;
	Sun, 03 May 2026 20:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1777841226;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=85J0pCyPVfqI7cY3B2818eUg94JB2W47d+TYWfeXVeg=;
	b=VBrgblMJNdvO/jaoN3TFiAI/BPNWy6mH6FSn8KEBKdgXeAUXpd54CJHMWWeWooPvZhUpjP
	D3C7sI9hflqyVlgzEW/Vd/bGofvP3JC4aUkMz/jm8E6Eyh8SqQYNAH5PaFjZ4gOFsOxWBU
	QC5emgPyGK5/NXjm4TxpZn8ept/mnFk=
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 03 May 2026 22:46:15 +0200
Subject: [PATCH batadv-next 2/2] batman-adv: tt: replace open-coded
 overflow check with helper
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260503-post-fixes-cleanup-v1-2-9c5c0ff0fcb4@narfation.org>
References: <20260503-post-fixes-cleanup-v1-0-9c5c0ff0fcb4@narfation.org>
In-Reply-To: <20260503-post-fixes-cleanup-v1-0-9c5c0ff0fcb4@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1511; i=sven@narfation.org;
 h=from:subject:message-id; bh=04CPPcxm8ENVA7fxl5TwC56urUDWryAlGS/NFlDoQDo=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDJnft0hoHJtzN0H76MaAfs3oKxK+TLcVeBf5vBVf1+yzt
 a7qZ9ajjlIWBjEuBlkxRZY9V/LPb2Z/K/952sejMHNYmUCGMHBxCsBExG8yMuzQ0RJ7unDJpJn3
 5NdVdM3RcyiKef/AbNb0YvaHFz9MeWjJyHD56e2DbSG7w0vknioy824/u9Dq1bQrr197x+y09Fe
 7G8gGAA==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: GGEI32YZ2HFQOQ52LSZHHK657IV3IMSX
X-Message-ID-Hash: GGEI32YZ2HFQOQ52LSZHHK657IV3IMSX
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/GGEI32YZ2HFQOQ52LSZHHK657IV3IMSX/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

The commit 6043a632dd06 ("batman-adv: reject oversized global TT response
buffers") introduced an open-coded check to ensure that the allocated
buffer size can be stored in a u16. The check_add_overflow() helper can
perform the addition and overflow check in one step, so use that instead.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/translation-table.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 8ab93458..72c0057b 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -840,9 +840,9 @@ batadv_tt_prepare_tvlv_global_data(struct batadv_orig_node *orig_node,
 	u16 num_vlan = 0;
 	u16 num_entries = 0;
 	u16 tvlv_len = 0;
-	unsigned int change_offset;
 	struct batadv_tvlv_tt_vlan_data *tt_vlan;
 	struct batadv_orig_node_vlan *vlan;
+	size_t change_offset;
 	u8 *tt_change_ptr;
 
 	spin_lock_bh(&orig_node->vlan_list_lock);
@@ -857,14 +857,11 @@ batadv_tt_prepare_tvlv_global_data(struct batadv_orig_node *orig_node,
 	if (*tt_len < 0)
 		*tt_len = batadv_tt_len(num_entries);
 
-	if (change_offset > U16_MAX || *tt_len > U16_MAX - change_offset) {
+	if (check_add_overflow(*tt_len, change_offset, &tvlv_len)) {
 		*tt_len = 0;
 		goto out;
 	}
 
-	tvlv_len = *tt_len;
-	tvlv_len += change_offset;
-
 	*tt_data = kmalloc(tvlv_len, GFP_ATOMIC);
 	if (!*tt_data) {
 		*tt_len = 0;

-- 
2.47.3

