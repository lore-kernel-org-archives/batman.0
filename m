Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 435B9C61DD6
	for <batman-adv@archiver.kernel.org>; Sat, 29 Aug 2026 06:23:20 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id D4A7B8272B
	for <batman-adv@archiver.kernel.org>; Sat, 29 Aug 2026 08:23:18 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1787984598;
 b=UrjvUykhiXaLzkwMBnnru1FO09a5c7da5JOy3ZyMNeNTOEijs1rYjbLwk7RqLAD7j/Huu
 OZJumwRB2Npn6mBPOxvCqXVFaiEJlz73skLHplD91BowknqRvs1Z72YaLxZzbk/FjEuZuP+
 3Wuv4uG7VRuluju39PpO2Hzkexkg+dE=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1787984598; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=f6YD1VjF5TdpcsvZW7DhTzzwqxa8KJfc8yhzy2Iu2DE=;
 b=g/qcSnJkCiyipNtep5a6e6+f95IRFOXmp8lyCUiPn7e9KG0Jag2C7J6vRpwQjHtHZ8XSI
 MySlDSY6ku5htpknBVPDvz/Q3UpAlCf6zPS9E35J5rBd3GQNmta6suLzLo+JaoDPw+aF96P
 pKDF81T40CSbXNwPFLoLaczRt7XSEi0=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 9B07083BA9
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sat, 29 Aug 2026 08:20:25 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1787984425;
	b=Bggk5LrB1FpBQhjb3KHvtLNG/plmQwpW8WPs8skXBI4S7zFh/DB5hv1sYK25UtRKLv2C66
	pgRECaJuknLFOAt1yjpbEDp1/uYbgCPfzkobasUaO66W6GlYdOzMrqiScNB7cY0daaaHrU
	Vc3brKXxxTe31JR6DEqy3CUib8Y3lHE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1787984425;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=f6YD1VjF5TdpcsvZW7DhTzzwqxa8KJfc8yhzy2Iu2DE=;
	b=uT0qjO9Jd+KyWvMrtcA/+CSY5c7JRGPGZBX7FOKyh32UelTue4Ku0lkpIaHFjkkxBq+O23
	u9mdyUCx35cEiTGRnkJ/o//yHPIP+vUAvM9TCbGug6y5fRVdKSFBb7QTQmNSkdgAagrJuq
	/PI5fs3fAJbigAV8RTRQVDaB/Rk+KIg=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=NL36asma;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 3B91B1FDC6;
	Sat, 29 Aug 2026 06:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1787984421;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f6YD1VjF5TdpcsvZW7DhTzzwqxa8KJfc8yhzy2Iu2DE=;
	b=NL36asma5gTCIUdpU+x8lEYnCAnnkWin75bhO+CdK1ophSntADLDNx04eff9NmZCcQ25r2
	qG9jM6LIIDd3s2DWBM4Xvrt8jPQ+2crU0CLMhgGeg1gWyIcApdptFt1M/OVQc1qKABlZtE
	HERu22QzSEfGZMPB4bnr/UixOHfcXt8=
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 29 Aug 2026 08:18:19 +0200
Subject: [PATCH batadv v5 08/20] batman-adv: tt: decrement count for
 committed client on local_remove
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260829-tt-fixes-v5-8-88fce8fd683d@narfation.org>
References: <20260829-tt-fixes-v5-0-88fce8fd683d@narfation.org>
In-Reply-To: <20260829-tt-fixes-v5-0-88fce8fd683d@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1235; i=sven@narfation.org;
 h=from:subject:message-id; bh=F4qA1S5XzL0zpeKCHcq5raf9MfCL7+q5fRMzsKjaRcw=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFmTKtf0n848p2fy1GHNt1N/Dv+tUjp9xDGf//SSfZ9fv
 FBY1c5e0VHKwiDGxSArpsiy50r++c3sb+U/T/t4FGYOKxPIEAYuTgGYiOM7hv9+btsq12V/fbCA
 L3ynWfLRu+cu72UrTjhVuy3kAu+36SY7Gf4pnNQMUJTd+un7+8x7S3yW1q+sWKXotnSpgvn0CWp
 fXY2YAQ==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: X4IAOOZAONKFCK5OG3R2OOHLM2Y5FR7Z
X-Message-ID-Hash: X4IAOOZAONKFCK5OG3R2OOHLM2Y5FR7Z
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/X4IAOOZAONKFCK5OG3R2OOHLM2Y5FR7Z/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Local TT entries which have the BATADV_TT_CLIENT_NEW no longer set are
committed. The batadv_tt_local_size_inc() was called for them and thus the
batadv_tt_local_size_dec() has to be called also when
batadv_tt_local_remove() is called for them when the BATADV_TT_CLIENT_NEW
wasn't consumed in the remove path.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/translation-table.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index ee4e3594..63948ee2 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -1476,6 +1476,13 @@ u16 batadv_tt_local_remove(struct batadv_priv *bat_priv, const u8 *addr,
 	if (!tt_removed_node)
 		goto out;
 
+	/* batadv_tt_local_transition_new() may have committed the entry and
+	 * thus counted it in the local table size since the BATADV_TT_CLIENT_NEW
+	 * check above.
+	 */
+	if (!(batadv_tt_flags_get(&tt_local_entry->common) & BATADV_TT_CLIENT_NEW))
+		batadv_tt_local_size_dec(bat_priv, tt_local_entry->common.vid);
+
 	/* drop reference of remove hash entry */
 	batadv_tt_local_entry_put(tt_local_entry);
 

-- 
2.47.3

