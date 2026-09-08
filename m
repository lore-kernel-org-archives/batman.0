Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51089C79F82
	for <batman-adv@archiver.kernel.org>; Tue,  8 Sep 2026 17:24:02 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 043D084033
	for <batman-adv@archiver.kernel.org>; Tue, 08 Sep 2026 19:24:00 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1788888240;
 b=Y5fRlon5KCxM/B4AndNZYJDXcKZBFRTHKO2cf+PvYy/ywVpt2SuBZzlZa5xBR+T9sUubf
 etT7kB1wF01EstiS0VlzJIXXcsgEtACncAQr7ioFRVEOYxs8w3y5PNL3B3GvVcbAac1xNBJ
 x3wWZ+l0010dlTS75EZpkZowMrycZYQ=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1788888240; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=9NkDiQkY/nwsb/8xNsMnXmeozWVx5KON1OQeIOMNnrM=;
 b=nuZinY3oHCIpCRjq5bNFzpLvHm256QlhTk8orpyRMa58Xxz0lThUSEJcPskPmQdIDm/iK
 VwuPRWYuZbcYf7xY0yPGHisCrWsBBq4DPtHgq17rlt4AwDOdB2IhMkh1kA6vigLRaFMLJ6U
 bwF1q5QAFY2FFWOTMI9ozQuy5vLnCmE=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 0941F80F8E
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 08 Sep 2026 19:23:45 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1788888231;
	b=GCDKr8u76YMSmOaTPAH299i1CUZBXtSmBcGG5e8W5AlWwXpqQrZewZrNhoSW2CnShLLbwH
	/ECBSLRuJaNW7RjZ1jrwaMnOkN703Jib9lZdUn9OCHCoQDz7EKelLuLh5Ki0cmbgAsaxsF
	hRMw7y7Flu/CG/b5eAhvHkPgVIl/rgM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1788888231;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=9NkDiQkY/nwsb/8xNsMnXmeozWVx5KON1OQeIOMNnrM=;
	b=OPBgh+R/SLpi4VB58H7csbYRWifLScb4X6rYpxQf14qrYO4iBNaxHGZjAG+x3/nIqqKyA5
	uwm1cg6rI2wvaE0jJjWJFMHWzmvIpMIaq2y9qQZIZsPNHqxcibYCsVgnOAXnp1m0DpXJR2
	lEjtLQIQ35YGuvjZUbDV3cZzhbtDMyE=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=rNwJa2hn;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 0C7251FE4D;
	Tue, 08 Sep 2026 17:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1788888224;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9NkDiQkY/nwsb/8xNsMnXmeozWVx5KON1OQeIOMNnrM=;
	b=rNwJa2hn3hJWMrfsgQvWszG3Au/3m2v0QfyDUGhE732N2MBjhUFPZ2lPi6pmvWSMRIZ8vT
	bPu/T+2O3PzsOknNaStxBt0V/RhS0Td8CyaI+M4SZQ/rdgCmOAPW2hvlVoQNUJZkIewUrj
	MfLgTQCKFcIxegkUVvevUZn0rckrHiA=
From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH batadv 0/3] batman-adv: kdoc: handle sashiko complaints
Date: Tue, 08 Sep 2026 19:23:34 +0200
Message-Id: <20260908-sashiko-kdoc-v1-0-535b498f2519@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJZEoGoC/yWMwQrCMBAFf6W8s4E0tMH4K+Jhm6x2LTSSrUUo/
 fdGPc7AzAblIqy4NBsKr6KS5wrtqUEcaX6wkVQZzjpvgz0bJR1lymZKOZoQfcd978mFFjV5Fb7
 L57e7YqCF0orb3+t7eHJcvi/s+wEGLf+VeAAAAA==
X-Change-ID: 20260908-sashiko-kdoc-9c64e556a291
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>, Sashiko <sashiko-bot@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=877; i=sven@narfation.org;
 h=from:subject:message-id; bh=owg7Kdptt5qz6oHrG48PRQRryw0vxTCAwMeq3Jj1OTc=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFkLXOYsP5gfef5XUilvs/INk4KAxugkv0P2iax71xaHN
 L2SOF3fUcrCIMbFICumyLLnSv75zexv5T9P+3gUZg4rE8gQBi5OAZgI72dGhp9q8xrmKUyZ3R0e
 a1t8v4whp/Tm61K97XsD2JsuHtFYV8nIcNgrtTFZTuvBNOW6sw0FR9Kd0zk/hnyyPVRrav1SOi+
 OGQA=
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: ZC2ZQQOMWBCVS4IRA3J44PTYKF2LC3GB
X-Message-ID-Hash: ZC2ZQQOMWBCVS4IRA3J44PTYKF2LC3GB
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/ZC2ZQQOMWBCVS4IRA3J44PTYKF2LC3GB/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

In the last PR, Sashiko complained about various kernel-doc for functions
which were created based on (previously) inline code.

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260907081824.2474040-1-sw%40simonwunderlich.de

This PR will try to address them.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
Sven Eckelmann (3):
      batman-adv: tt: clarify kernel-doc for batadv_tt_global_purge_local
      batman-adv: tt: clarify responsibility for roam flag during removal
      batman-adv: tt: soften kernel-doc for batadv_tt_local_remove_now()

 net/batman-adv/translation-table.c | 41 ++++++++++++++++++++++----------------
 1 file changed, 24 insertions(+), 17 deletions(-)
---
base-commit: 9c7a6f34298562179691007cf8698d0405891e3c
change-id: 20260908-sashiko-kdoc-9c64e556a291

Best regards,
--  
Sven Eckelmann <sven@narfation.org>

