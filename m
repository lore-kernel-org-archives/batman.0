Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8080ECD3427
	for <batman@archiver.kernel.org>; Sun, 10 May 2026 09:32:24 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id EC8E585B6E
	for <batman@archiver.kernel.org>; Sun, 10 May 2026 11:32:22 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1778405542;
 b=bMbnKCi92MQRH+mNZMONvQGU1oY/OydUw/Zk9deny8KymumI6+Dfyl7wmZ83LpwnNE5Bp
 ttlUgeGrScrQGQ5z4cAcGAJM3i4o9mdH0Vo7HBkrWcCJ/fD9BzNRedP+PyVPRmBZ5Hmb0M3
 XAvEO+tL8v2Tohov1AIb4E6PNFk6XiE=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1778405542; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=JtH+1gaBp7r1iu55Vt/3MBQzlOwokMddmqWibFzTEFc=;
 b=e7/jh8C8vmisnaP/vLzUawKaOweWNUHl2GGbwupgN9Li/VmiDqeWV9qkNsU9T7TjcFoEH
 C398aCLaYhHUKodtc5rEpMTZdwY8dRIUxD7LQlWxYJ+JcCsucHtcWhHMMXBTtJpNLq9NSAB
 ISiaRSzcsuVIwlOGUusqQXe27Q1G1oI=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 48ED584508
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 10 May 2026 11:31:15 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1778405475;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=JtH+1gaBp7r1iu55Vt/3MBQzlOwokMddmqWibFzTEFc=;
	b=QekhvyIe8vNapoxQa4Ho7YYZbmcseaoCUVFf+63QxpFAUI5JHBdNjLrqpy7IaadNf/b3yz
	/KplJ/0ee8MN9w6kX+g5/9Tv/gCcEr4qW+A92/dsxxOJkzTVp2Vw+edM3GOVCibRff9exM
	Gj4XoWJgDjrMuhLPJyQDmM8A9IjbObI=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=0x8F8Sri;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1778405475;
	b=AzhCDFV60IlyPWzOEFM4lCyveMGPHpZcqrBhGxi31wJyLyg2z11qTLIttZ2FFM3ehAF3RZ
	+4eISdSGfxGfRpx9D11s8XvjT8YqGC/wVRD3ARoBwJX3McbNbwMEG+1lAQ1BN5+z1eHGtq
	USfAZhlk2Ik0NfT+gcXHuItgQstUeo0=
Received: by dvalin.narfation.org (Postfix) id 7A07C217E2;
	Sun, 10 May 2026 09:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1778405473;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JtH+1gaBp7r1iu55Vt/3MBQzlOwokMddmqWibFzTEFc=;
	b=0x8F8Sri6jKxmzX1Ks8A+OCTacYUdi5cnvO+kUw5EleF21yh+1KZLf5C8MInqxgZ9Wza4M
	LIKfjK1r/8jDuZEVZCXPkNIiczDLZKRSHjmgeVKD2jdIzbRDm4YvXFa6eUyeO2HlMfc33R
	VfWuDNZtEQ3RLg6fGTi0IKnlbT6MEj0=
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 10 May 2026 11:30:59 +0200
Subject: [PATCH batadv v3 3/7] batman-adv: tt: reject oversized local TVLV
 buffers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260510-fixes-followup-v3-3-1079a93bc964@narfation.org>
References: <20260510-fixes-followup-v3-0-1079a93bc964@narfation.org>
In-Reply-To: <20260510-fixes-followup-v3-0-1079a93bc964@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1789; i=sven@narfation.org;
 h=from:subject:message-id; bh=r6v8uIhTpWTnQCIF3XCU6173jTWOBZQ1VRKmTt4uW2o=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFkMASEr8nxVRZhV7ryS/8ZrElQWFcZfYybI3rlMXKPGf
 ulDyZyOUhYGMS4GWTFFlj1X8s9vZn8r/3nax6Mwc1iZQIYwcHEKwETC1Bn++2xhnbTUca7W90Xy
 pyfdlGR6dT9R51fCZuX1R/eyFj0/fZ2R4ex2n9tW+5eETjt2rCbEKMvq21yZisvTni7MYM3OPen
 0nRUA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: EXJ7NU2QT3UBWMEWKHCRCLTEQRCCMXTL
X-Message-ID-Hash: EXJ7NU2QT3UBWMEWKHCRCLTEQRCCMXTL
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/EXJ7NU2QT3UBWMEWKHCRCLTEQRCCMXTL/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

The commit 6043a632dd06 ("batman-adv: reject oversized global TT response
buffers") added a check to ensure that a global return buffer size can be
stored in an u16. The same buffer handling also exists for the local data
buffer but was not touched.

A similar check should be also be in place for the local TVLV buffer. It
doesn't have the similar attack surface because it is only generated from
locally discovered MAC addresses but the dynamic nature could still cause
temporarily to large buffers.

Fixes: 21a57f6e7a3b ("batman-adv: make the TT CRC logic VLAN specific")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/translation-table.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index d39332ea..e65bd3ea 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -917,12 +917,12 @@ batadv_tt_prepare_tvlv_local_data(struct batadv_priv *bat_priv,
 {
 	struct batadv_tvlv_tt_vlan_data *tt_vlan;
 	struct batadv_meshif_vlan *vlan;
+	size_t change_offset;
 	u16 num_vlan = 0;
 	u16 vlan_entries = 0;
 	u16 total_entries = 0;
 	u16 tvlv_len;
 	u8 *tt_change_ptr;
-	int change_offset;
 
 	spin_lock_bh(&bat_priv->meshif_vlan_list_lock);
 	hlist_for_each_entry(vlan, &bat_priv->meshif_vlan_list, list) {
@@ -940,8 +940,10 @@ batadv_tt_prepare_tvlv_local_data(struct batadv_priv *bat_priv,
 	if (*tt_len < 0)
 		*tt_len = batadv_tt_len(total_entries);
 
-	tvlv_len = *tt_len;
-	tvlv_len += change_offset;
+	if (check_add_overflow(*tt_len, change_offset, &tvlv_len)) {
+		tvlv_len = 0;
+		goto out;
+	}
 
 	*tt_data = kmalloc(tvlv_len, GFP_ATOMIC);
 	if (!*tt_data) {

-- 
2.47.3

