Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BCDAC5620A
	for <batman-adv@archiver.kernel.org>; Thu,  6 Aug 2026 09:49:24 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 42BAB8429C
	for <batman-adv@archiver.kernel.org>; Thu, 06 Aug 2026 11:49:23 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1786009763;
 b=gJ9T7KrW/QPBmcTSiMG3qac79mrvFG0g0qe7yMq/A3IdW5asE9NmMuq6SrKpc+rJL4uk3
 7tGSukseT1jdBUmfevZEkF/r3pK5Kc6gR3n+iE2hcADrfqPF4y1qYmkzrbU7vz/p9PrEEH3
 hSq4OtuSHDuyueXJkpAyNtC65xZD2tQ=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1786009763; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=R+F1nFM6RQuIJmO4sCr7uJOONBO6TnIT0+ttoPkLVzM=;
 b=fLHLugf4Ph13xEhMAu2edWwDLh9rcKN1+yeoCx+rpI6mj1YxFmJ8LIyz9R7Rn0QpygnG1
 xRQCx2SXqno7ILvnNkl594Wby3ZrPmCDPSHIlTyh2N2vi/hUgLILGle5uOUGsC5eLi/XOec
 WjKtwKlrprhxRb/GzKzEEyJBlMgKvpM=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 179DC84266
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 06 Aug 2026 11:45:38 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1786009538;
	b=AVK9jJP7M1/mqQoAVs28pQAx1B7QchwX751+WKrw7VL79VUZzo5RmTvEHAInN4rtYCxWna
	c7mtU6cxwYQ0k58MHpRVLb+SUMskJvNfQXIKdM7CerVimyqAzm+l467M9pgvIDvuMDK3S/
	1+RIWP/YIV8qompOljFLsk3L22G09j0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1786009538;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=R+F1nFM6RQuIJmO4sCr7uJOONBO6TnIT0+ttoPkLVzM=;
	b=4QB7hxQosLJN7GCi8aku2o3mmxP05pFiS6nuO+eTNyRb5TvRo0onOhWSJS7P7kJckRytga
	3Xtf3ZeK9Fe2AvR2+Lj+U/PPJnovSE+fB9uOUU6JEPn6erYZtECuqBTGv4J/GYM9hhYT4k
	XcA5nmcF7l3HQiZlRzhb5ibwzgbz0E4=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=XKKFH6kP;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id AF6FE20590;
	Thu, 06 Aug 2026 09:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1786009533;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R+F1nFM6RQuIJmO4sCr7uJOONBO6TnIT0+ttoPkLVzM=;
	b=XKKFH6kPP7hycJTNs/j6iWjIieXuJrf+9pMFO3UPllYlfQELITN08clA5zZLpdnAHM0wlX
	oBnnKg6v0NhR4NPLKHQi9PFl5ipTwvnSNZ7MztAIm6+B0IbHU3RqjJxZOycpIS84yUR+Xh
	kOSTTeG6+U6Us9+URI/GE17OxqzTEYc=
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 06 Aug 2026 11:44:21 +0200
Subject: [PATCH RFC batadv 08/12] batman-adv: tt: replace add_orig_entry
 goto in batadv_tt_global_add()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260806-tt-add-cleanup-v1-8-ffcad65bccc4@narfation.org>
References: <20260806-tt-add-cleanup-v1-0-ffcad65bccc4@narfation.org>
In-Reply-To: <20260806-tt-add-cleanup-v1-0-ffcad65bccc4@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1436; i=sven@narfation.org;
 h=from:subject:message-id; bh=QzC94YuN7tBaCFOXcSKOXBIHcpT4D8ZHaoEPPfEKbqw=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFkl4c3Pc9YrP1HdIfM6s1FfOGD2xCmPE1VYf+QWTX0+b
 fJKk7wpHaUsDGJcDLJiiix7ruSf38z+Vv7ztI9HYeawMoEMYeDiFICJBL5j+Cu+iv1ZwOnSOTec
 vghnKwVEa+d+dZfkEqh+tP/AKSZru36G/y6KPYxf1jAKLlNd1c10tGGdmTp3NN83QbeKTVuU2pv
 +cgEA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: HCZG5GXUPSS3ZFDUCBLFEOHR7QYXYZUX
X-Message-ID-Hash: HCZG5GXUPSS3ZFDUCBLFEOHR7QYXYZUX
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/HCZG5GXUPSS3ZFDUCBLFEOHR7QYXYZUX/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

The "add_orig_entry" label was only used to skip the flag merging of the
non-temporary path. Which means that the code jumping to it and the code
below it are the two halves of an if/else.

Both halves now only decide whether the originator list has to be purged,
so turn them into an if/else and purge the list at a single place.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/translation-table.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 71d9fcf6..17a92ff4 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -2073,15 +2073,16 @@ static bool batadv_tt_global_add(struct batadv_priv *bat_priv,
 			if (batadv_tt_global_entry_has_orig(tt_global_entry,
 							    orig_node, NULL))
 				goto out_remove;
-			batadv_tt_global_del_orig_list(tt_global_entry);
-			goto add_orig_entry;
+
+			delete = true;
+		} else {
+			delete = batadv_tt_global_merge_flags(tt_global_entry, flags);
 		}
 
-		delete = batadv_tt_global_merge_flags(tt_global_entry, flags);
 		if (delete)
 			batadv_tt_global_del_orig_list(tt_global_entry);
 	}
-add_orig_entry:
+
 	/* add the new orig_entry (if needed) or update it */
 	batadv_tt_global_orig_entry_add(tt_global_entry, orig_node, ttvn,
 					flags & BATADV_TT_SYNC_MASK);

-- 
2.47.3

