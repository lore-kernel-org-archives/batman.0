Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7EB1CD8C88
	for <batman-adv@archiver.kernel.org>; Sun,  7 Jun 2026 12:00:15 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 8109085075
	for <batman-adv@archiver.kernel.org>; Sun, 07 Jun 2026 14:00:14 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1780833614;
 b=VvPpO2AeWlj+W55JmNqnQ+8p0yioubOh3FMHqrGBMvD68toDvaZ581tYxa1NE7Mbted0C
 feOlyrSRcbKi40Jh3O4kdv/8rKBoGVQt6vhGkfC+YPru+/5Pjkkyu2MnI/pMDDwEX4uwgg7
 wegRpgDnt5loJaAQyr8JxmGO9waybrg=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1780833614; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=w5t2AQ6rxuYX3q8fnAhP0o43WSW1UFQ/QlX8ajDvhZc=;
 b=j8U6uzSVG/SwV/qnvtOQnYiegGL/tAfds3Be9YrHyhQW5fzkyP9buuUd2fsuT/kaxDgxw
 va58Iqtu6VorTZtupU7Q7f3YA3txcEAVfe5w2ACE466+KCCL3igwmLWqb2Hhow3Dg/HSwX0
 KIQNKcM/RVGYpbP6ki8ctFf/Ij2h9Hw=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id E40EE80DEB
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 07 Jun 2026 13:54:50 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1780833290;
	b=UrdCugTrNfmigTwcMraiDcfKjKtJ7Zq5BwbU4dgtokh7kKDcZPDj9eQGO4OCgjr94BO4Ul
	aqMqHgtBIouVZbjsGrlZNhTr/MGWF8dWHNWE0pg71DH5Hr2P3xBZe5TZYOzmE4CNwWFS4F
	kVYO4gYb0SmnxgYiS40EXmDJXdg8l00=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=UmImpkcN;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1780833290;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=w5t2AQ6rxuYX3q8fnAhP0o43WSW1UFQ/QlX8ajDvhZc=;
	b=Db/5ID310WgV/t9EMe9HF81cj7+O7RW76OuIUgECsszWPUEBTqW1dkga6yRRqRjYkZNA0o
	gkfTAiTizVLYb068F0D8nzv8HPuDIqY44L+MDfZD11bbs6IOEf0QenadddV3bwPEVo2abl
	WkcglxZOZrGhNzf8JngAfd/hoROaoKw=
Received: by dvalin.narfation.org (Postfix) id 9C8471FE06;
	Sun, 07 Jun 2026 11:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1780833290;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w5t2AQ6rxuYX3q8fnAhP0o43WSW1UFQ/QlX8ajDvhZc=;
	b=UmImpkcNYwdpmcxY5NM0TxclenXx49mdXnrn3cv3oSXl//0WO3J7X4d0Sryocv+GOpHnpG
	qSw5BBV/zviAvUrN52O1ofxzwbZ5gaoE6fIAyCD/YJmaRRTfnLvs9+ezL0Wkfx126hnWrL
	jPcfz9uLBrSO39H6X4jBF6k1NLMKyNo=
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 07 Jun 2026 13:54:01 +0200
Subject: [PATCH RFC batadv v4 7/7] batman-adv: iv: drop migration check for
 batadv_hard_iface
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260607-drop-hardif-list-v4-7-ade2931db295@narfation.org>
References: <20260607-drop-hardif-list-v4-0-ade2931db295@narfation.org>
In-Reply-To: <20260607-drop-hardif-list-v4-0-ade2931db295@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=937; i=sven@narfation.org;
 h=from:subject:message-id; bh=pl/Gg33m8RdaoqK+Tjhw3A5vLcZhQnKe96dhzKsTEy8=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFmq0bfslfbqeSzj3t+yVFrmt3mzmtulmJz9MiFbTt2Yp
 SOlXLm8o5SFQYyLQVZMkWXPlfzzm9nfyn+e9vEozBxWJpAhDFycAjARjgcM/5O6Zjfx9+5xFfa7
 ZqbxI3DC03NCrl7TVSp3T431v/8plIuR4bBHuOorf+VZWvYqC5N2fz3uX2w+w8qy/UrS/GudT18
 e4wIA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: XXBPS2ABZOV7775ATKK4OLK2NXTRTX3J
X-Message-ID-Hash: XXBPS2ABZOV7775ATKK4OLK2NXTRTX3J
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/XXBPS2ABZOV7775ATKK4OLK2NXTRTX3J/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

With the immutability guarantee of batadv_hard_iface->mesh_iface, the check
for "changed" (or NULL) mesh_iface is no longer necessary because and
batadv_hard_iface can no longer migrate from one batadv_mesh_iface to
another one.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/bat_iv_ogm.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index d9e4d023..89803a8a 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -407,11 +407,6 @@ static void batadv_iv_ogm_emit(struct batadv_forw_packet *forw_packet)
 	if (WARN_ON(!forw_packet->if_outgoing))
 		return;
 
-	if (forw_packet->if_outgoing->mesh_iface != mesh_iface) {
-		pr_warn("%s: mesh interface switch for queued OGM\n", __func__);
-		return;
-	}
-
 	if (forw_packet->if_incoming->if_status != BATADV_IF_ACTIVE)
 		return;
 

-- 
2.47.3

