Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46779CD3427
	for <batman@archiver.kernel.org>; Sun, 10 May 2026 09:33:53 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id CDFB185B08
	for <batman@archiver.kernel.org>; Sun, 10 May 2026 11:33:51 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1778405631;
 b=10I9c9HSNZ5UBNcuNfNpFZAEOK10wy9jRNrA7jR/1BATpGiSS3p2oAE+cGYCEoVI1IjqY
 FdKNjSBN7EXyynn5ygx8boaDOIcjKR826uCywVdEqvQ5yX0Rxki58O1kiVNfSOP8snkNh+w
 exQcfmdzfyx9r3R452tscid4AsEgdcs=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1778405631; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=E7oeW+d2kTwQUAiPKP99mh83CAh/EVd6tcUzolSnDz8=;
 b=TubH4T0IACCYuhgjWzyoA86CNrdo7nC2npkQi4519v7gDkKwjJDUuLp41YYLRuIEKeDOP
 iDbMtlH7NpMhjx7BM9lMTRANEsmF9gVBQISJcTKMpkggpc+KK6Q2SPCqEaGeHLY7CC2cjyn
 fxceIcS7mgF3YnkyZxgRVh93qleKO/A=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 8FD89859D3
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 10 May 2026 11:31:11 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1778405476;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=E7oeW+d2kTwQUAiPKP99mh83CAh/EVd6tcUzolSnDz8=;
	b=VEE92T7LSNq9TrW/tz55myA30GaA1IygKFSTEoCXSEuTVvw9oGAA4++cRnuBid8/rWiAb5
	Mo6hxQznIskq8A9X3H+CyTk0xp5+tTuY69zboPXFJuKP58uLf9HvqEzjphjte8QM85p6u6
	9ikHY8KCPq5CYBYWjop1m2wj6Km0HKc=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=llsa64bc;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1778405476;
	b=T15izUIwOWRTMWAStOn/+zgMLC/PCE/M5QAGr+Hg2uY2rG5Zo+nPpE3jB/vDPFXmNzpLHS
	ll1xzFVwsfiuMW4SjKoTR5+WpfIEa5h6BLf5ABKGXbL9xGeNgyuQpkUBvASAUyD6N2D7eX
	FsJMtdRZLFK8MhZ2HFgth1t3P2GZLgo=
Received: by dvalin.narfation.org (Postfix) id 0CC3321722;
	Sun, 10 May 2026 09:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1778405471;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E7oeW+d2kTwQUAiPKP99mh83CAh/EVd6tcUzolSnDz8=;
	b=llsa64bc7golY5oqal7X24ICDKPG74mBcYW5CnsfIw07L4VpJwZgBqugObPZa/7Uso7T7P
	TIxSXft9K9AH+dfMSp5rlwtcj8xuLLGGOjJd73Br/7x6XqkPuVY9vwuys9cT0+G6X3s9iw
	nz/5GS5TRTT/aSb3WSaXa8vudmIPFsQ=
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 10 May 2026 11:30:58 +0200
Subject: [PATCH batadv v3 2/7] batman-adv: tt: fix negative
 last_changeset_len
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260510-fixes-followup-v3-2-1079a93bc964@narfation.org>
References: <20260510-fixes-followup-v3-0-1079a93bc964@narfation.org>
In-Reply-To: <20260510-fixes-followup-v3-0-1079a93bc964@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1330; i=sven@narfation.org;
 h=from:subject:message-id; bh=yi60lbuycw7okgeAErpbOVkSJ72iiXwdg0ZPDtPalvI=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFkMASE+NhIS21Ij/RkZn0UskkusOvD1gbe++ayjvdvsN
 j1qT5XpKGVhEONikBVTZNlzJf/8Zva38p+nfTwKM4eVCWQIAxenAExkjy0jw76Mf/GvvxdnsJxl
 KsjlVzSMMXzDd2D1K93Ns5rPfV9Zf4/hf/yLnd4x6sap1cvEJRJueaSFlMc/ybj7zi4j9c8WqR0
 z+QA=
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: IYCYCUOAHKDQQQ3FVC4FWXFL577VBHXN
X-Message-ID-Hash: IYCYCUOAHKDQQQ3FVC4FWXFL577VBHXN
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/IYCYCUOAHKDQQQ3FVC4FWXFL577VBHXN/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

batadv_piv_tt::last_changeset_len len was declared as s16, but the field is
never intended to hold a negative value. When a value greater than 32767 is
assigned, it wraps to a negative signed integer.

In batadv_send_my_tt_response(), last_changeset_len is temporarily widened
to s32. The incorrectly negative s16 value propagates into the s32, causing
batadv_tt_prepare_tvlv_local_data() to allocate a full sized buffer but
populates only a small portion of it with the collected changeset. All
remaining bits are kept uninitialized.

Using an u16 avoids this type confusion and ensures that no (negative) sign
extension is performed in batadv_send_my_tt_response().

Fixes: cea194d90b11 ("batman-adv: improved client announcement mechanism")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/types.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 0f3814b4..179b90c1 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -993,7 +993,7 @@ struct batadv_priv_tt {
 	 * @last_changeset_len: length of last tt changeset this host has
 	 *  generated
 	 */
-	s16 last_changeset_len;
+	u16 last_changeset_len;
 
 	/**
 	 * @last_changeset_lock: lock protecting last_changeset &

-- 
2.47.3

