Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 793C5C54EAA
	for <batman-adv@archiver.kernel.org>; Fri, 27 Jan 2023 10:23:39 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 0BD4984584
	for <batman-adv@archiver.kernel.org>; Fri, 27 Jan 2023 11:23:38 +0100 (CET)
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [IPv6:2a01:4f8:c17:e8c0::1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 36244815A7
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 27 Jan 2023 11:21:37 +0100 (CET)
ARC-Seal: i=2; s=20121; d=open-mesh.org; t=1674814897; a=rsa-sha256;
	cv=pass;
	b=x2+Atz4TtPxVmlGsz5uSDqE8A/vOixG+d5WV6SPkaWwaRP7KbCTb05jiqfPIWhjcBMLJ/r
	jIO8AL3QUHVUujbp5sdcGulsuaND7EULYZf/3A3oz70WBexy3C7KGyfinZ7hKTz18pylMm
	funV1XHnYEU9E7+3lQv6JauiY+51M3E=
ARC-Authentication-Results: i=2;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=AFYgcjnF;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates 2a01:4f8:c17:e8c0::1 as permitted sender) smtp.mailfrom=sw@simonwunderlich.de;
	arc=pass ("simonwunderlich.de:s=09092022:i=1");
	dmarc=pass (policy=none) header.from=simonwunderlich.de
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1674814897;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=OkI4Op5NmFlUbJf6LZCtGkkkSLpzMMNyZfYraFDlRZI=;
	b=FJafjjNDZ2XEGRLb9InqY2VMvrCVk8TwjiIvbsvYfUjVYn70SP5smtNf58nMzRbeU8nJd9
	3Heakaop2iToq7TbYScVzZ2in41L9UJbLc9foFIdL+aG9P4zJEdZf48h81DUrDfgoaHkdC
	X1+jgFkR2ZvDy68BU3/wIfuibslR91k=
Received: from kero.packetmixer.de (p200300C5973eaED8832e80845eB11f67.dip0.t-ipconnect.de [IPv6:2003:c5:973e:aed8:832e:8084:5eb1:1f67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id 06532FAFDD;
	Fri, 27 Jan 2023 11:21:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1674814897; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OkI4Op5NmFlUbJf6LZCtGkkkSLpzMMNyZfYraFDlRZI=;
	b=AFYgcjnFSL4ubLcTDUWOi1MCHrN0Yt0k77V/ogOa4Xx4JeC6cgFrNZBnG5u/RByBQLWteT
	DI0hiQarATsUyuSl2WaOin9kyqm2juKIQegzyir5vXJCzVq/HFs3vk+mx58QyBTstjWVTD
	Cx55ZhC58Qa/hPETPWu1nbTgp8aHfR4NkrxszcDuiuMGzUREpAM/eMcRsuwN6PgB1uUSz1
	38p5gSpHWpv3PgIfpZqnCw/RcIIB8Mul9y9wnDgZXt1JtPyd+PrFKKtC3FX69zC0yshp8u
	dN0FZMP44vNnSi+rEapakCuWKIQTkdjMNSgNHiUkGLf0elIE6XjY9ihJHfURUA==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: kuba@kernel.org,
	davem@davemloft.net
Subject: [PATCH 3/5] batman-adv: Fix mailing list address
Date: Fri, 27 Jan 2023 11:21:31 +0100
Message-Id: <20230127102133.700173-4-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230127102133.700173-1-sw@simonwunderlich.de>
References: <20230127102133.700173-1-sw@simonwunderlich.de>
MIME-Version: 1.0
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
	d=simonwunderlich.de; s=09092022; t=1674814897;
	h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OkI4Op5NmFlUbJf6LZCtGkkkSLpzMMNyZfYraFDlRZI=;
	b=lIxFeWMJ+rpLO8Bs8E1HpXOJ932Bd6j5jqVjmbKWB0Q8cwPjy6AeEu1AJa6g9hCpMVC+vb
	5EOGyV8Io1qvNIvQt02JGvi16XGOpEbNR5c5tvecJ8mBt4xQTimSx18tynzwd33WjEEIeQ
	uUW4AF8BA8Wb42+QB107VHO6Ni0J9Gql2OpDctV5SVgK/aRkh+Om7CDbvhCXW0KV/vXtef
	2lqTraLeYLl4vUGbFuV99gftmTKExqiLUbbOWXG0b/K9ZXbx5F9vqG/Dwd8U+oEFwbpfjo
	9bGTZT9wNvKwdYTL3joyKHal3CqrNmKUwxj3cMS3sHorznKs/3H2nQD+VJCi1Q==
ARC-Seal: i=1; s=09092022; d=simonwunderlich.de; t=1674814897; a=rsa-sha256;
	cv=none;
	b=wXP2QKZqLYRrPWzf/uNsxqk2gVQaRC8ZxSWRA3izji1c9UaHY+td4+Q6e7Rwv0Ed8E3DrMxQmSlb71jnIEgEKnlddeSQ46LgQM5nmC/zYqSD0tcJGKI4kTaaBsAZ08Ayf0BTRmyucl6tNQ3P/eZ9WE7oE+SRrtlo0LG70g2/YWZR/i43qu92ZNc0vekqjFuSMr29wTbMwMa9vQpHGq8PriCSCuIWL+bo7GUZgbcumv+A02Jt+2tLyRZhUHsGRtx/38SJXAXDdOFnJ2kf/F92pQJifumdx3vHFnBSjBn1BwYM20xoo8ak/SDN4HBUu1nCbetWupxzshi/3ba5m9TMXg==
ARC-Authentication-Results: i=1;
	mail.simonwunderlich.de;
	auth=pass smtp.auth=sw@simonwunderlich.de smtp.mailfrom=sw@simonwunderlich.de
Content-Transfer-Encoding: quoted-printable
Message-ID-Hash: LBWRWVLJZC4LGTKK7ED2PDYYEZVGVW7K
X-Message-ID-Hash: LBWRWVLJZC4LGTKK7ED2PDYYEZVGVW7K
X-MailFrom: sw@simonwunderlich.de
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-b.a.t.m.a.n.lists.open-mesh.org-0; header-match-b.a.t.m.a.n.lists.open-mesh.org-1; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org
X-Mailman-Version: 3.2.1
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/LBWRWVLJZC4LGTKK7ED2PDYYEZVGVW7K/>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Sven Eckelmann <sven@narfation.org>

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 Documentation/networking/batman-adv.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/networking/batman-adv.rst b/Documentation/netw=
orking/batman-adv.rst
index b85563ea3682..8a0dcb1894b4 100644
--- a/Documentation/networking/batman-adv.rst
+++ b/Documentation/networking/batman-adv.rst
@@ -159,7 +159,7 @@ Please send us comments, experiences, questions, anyt=
hing :)
 IRC:
   #batadv on ircs://irc.hackint.org/
 Mailing-list:
-  b.a.t.m.a.n@open-mesh.org (optional subscription at
+  b.a.t.m.a.n@lists.open-mesh.org (optional subscription at
   https://lists.open-mesh.org/mailman3/postorius/lists/b.a.t.m.a.n.lists=
.open-mesh.org/)
=20
 You can also contact the Authors:
--=20
2.30.2
