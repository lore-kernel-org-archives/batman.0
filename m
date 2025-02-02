Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F783C0218F
	for <batman-adv@archiver.kernel.org>; Sun,  2 Feb 2025 16:04:29 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 45BD58115D
	for <batman-adv@archiver.kernel.org>; Sun,  2 Feb 2025 17:04:28 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1738512268;
 b=lls4017ttFsMuUi581qFfaNuxpG0QfI9cjcau16SCubw+wCndsfLX4FoGoq1rZGyNty+G
 UoUJjrSKLUqbO40vXU3ZfrcZLeGBCjDZz+C+MxVqfZzALImOAYhs+IMCj9xKTFjDJt46FDw
 p4cCBArz9uCor7rGe5YN8lROyeL3kEw=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1738512268; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=gj9xoV0jxwTKiY3Pd24Qw9VhK4da98dpGZkGHE+NeUg=;
 b=QVBI6Hp/yDbwoFG0IjQ59rGY0Jkumpk9+8jmy7s0eMEeOHU+W13ctVZDXmIBgBRQpcBYa
 YOAYaCjheQz/RA6GAYkFFAVnPdq1Oo80nGEtrnbHv6ZJGFmOnQRwvvhhVta7P0xXxvWodcG
 i0mTojQ/TmFdzODkqnwZxMVbo30OGRo=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=narfation.org
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 121A681867
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun,  2 Feb 2025 17:04:19 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1738512259;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=gj9xoV0jxwTKiY3Pd24Qw9VhK4da98dpGZkGHE+NeUg=;
	b=tWO+7zCmIiCcw0J+rN42Z9czaHqvNiVxIqz9EHqtBAv3sWQaVK+uqim+ylLnZOV4sV0HJL
	P3MWcIYyV1bak++jeUhvMPGMqQAOqmpHfiIfNMrEy+xWw4xRr6WnWxTLurm3+nx8wbar2F
	6b4sM9F/v5/SUZokBlL9NpNAn1NfGmo=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b="p0wmR2/N";
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1738512259; a=rsa-sha256;
	cv=none;
	b=2IxV76YixwgqT/XKoVIau8KmyEpK1sWIOdCkB77gBCqjDBYD8bUHjczlDFRx+hE0rs2O+g
	GKjuo+VtqjDrgnhR81YSRXpITlLZzRo83AWnntp1bAh5J883aNMiKMt9IviBL/rtb03uD/
	O6eKeXXEPhkGbqsHXGn0WZq0eus++x8=
Received: from sven-desktop.home.narfation.org (unknown
 [IPv6:2a00:1ca0:1d86:2efc::ab85])
	by dvalin.narfation.org (Postfix) with UTF8SMTPSA id 453D41FFC7;
	Sun,  2 Feb 2025 16:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1738512258;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=gj9xoV0jxwTKiY3Pd24Qw9VhK4da98dpGZkGHE+NeUg=;
	b=p0wmR2/NI2xeqG1DHm+ujQcI5zNxJCuQOmhW/Ai0/7o8eELzdNSvWginhuiPNNY/IuQz0j
	YDDDz+d3frl0frEr7qu0lyuxzYB3jjIlz1uldLNL8xYRznU0Zl/9jaCflylAgoNx4nmrFZ
	PMIpEIuMTZtgXaN9KtgrNj8MchiWu+4=
From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 0/5] batman-adv: Bitmap helper and size handling cleanup
 for aggregations
Date: Sun, 02 Feb 2025 17:04:09 +0100
Message-Id: <20250202-bitmap_aggregation-v1-0-6542a10e6fad@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHmXn2cC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDIKGblFmSm1gQn5ieXpSanlgCVK6bkmJmYGKWlpRsmpKsBNRYUJSallk
 BNjQ6trYWAEY2zCpkAAAA
X-Change-ID: 20250202-bitmap_aggregation-dd6046fbc5dc
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1636; i=sven@narfation.org;
 h=from:subject:message-id; bh=0SZK0bChJeBu1fPPG1Mcc7nf9lGMpHToTvLKI9Hdc80=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDOnzp1czTnzTnmXO6y12dY7oyavPM5T1f1RcP3MsyPqoz
 B0GB+++jlIWBjEuBlkxRZY9V/LPb2Z/K/952sejMHNYmUCGMHBxCsBEKmcwMrw345rWdeSzqVbW
 tddZZwI12ZrnxVur2pgH66QHlNfX1TAyfNCb4XGVe05hHfeHDbrBdZwJNoa/hW2CzVo3JzcdO2/
 HDwA=
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: OFIO6PNIFOH7LGDBYLAF3UDCF4GB3RXG
X-Message-ID-Hash: OFIO6PNIFOH7LGDBYLAF3UDCF4GB3RXG
X-MailFrom: sven@narfation.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/OFIO6PNIFOH7LGDBYLAF3UDCF4GB3RXG/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

The B.A.T.M.A.N. IV code enforced a limit on the size of an aggregated OGM
packet due to some self written (inline) code to perform bit operations on
an simple unsigned integer. The comment which explained this was too vague
to really understand the size limitations of the u32 vs. the packet size.

By using the Linux bitmap helpers, it is possible to untangle the maximum
number of fragmented packets from the maximum size of an aggregate. Which
can make the aggregation code more flexible for tests and maybe better
airtime usage in the future.

At the same time, it was noticed that the size handling code was slightly
off. For the RX side, the size of the aggregation was limited. And for the
TX side, it didn't consider the MTU for the outgoing interface.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
Sven Eckelmann (5):
      batman-adv: Limit number of aggregated packets directly
      batman-adv: Switch to bitmap helper for aggregation handling
      batman-adv: Use actual packet count for aggregated packets
      batman-adv: Ignore own maximum aggregation size during RX
      batman-adv: Limit aggregation size to outgoing MTU

 net/batman-adv/bat_iv_ogm.c | 43 +++++++++++++++++++++++++------------------
 net/batman-adv/bat_v_ogm.c  |  3 +--
 net/batman-adv/main.h       |  4 +---
 net/batman-adv/send.c       |  2 +-
 net/batman-adv/types.h      |  2 +-
 5 files changed, 29 insertions(+), 25 deletions(-)
---
base-commit: dfdce35d69c55b6b5d017a7e800e553089a26eb9
change-id: 20250202-bitmap_aggregation-dd6046fbc5dc

Best regards,
-- 
Sven Eckelmann <sven@narfation.org>

