Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70162CA600C
	for <batman@archiver.kernel.org>; Thu,  8 Oct 2026 15:53:19 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id BC08484271
	for <batman@archiver.kernel.org>; Thu, 08 Oct 2026 17:53:17 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1791474797;
 b=ERZWMvURLdskiyWz2NcRQ1ItkPho2EASJ6fd4IzmtmtqOhXhUQX7oJ1ZYj82nxRfx5xyg
 Qj9hpl9Ifhd6oX5DcFcbmXy+ADcXZG8eUFIGuj2LSIScfJXmcowm6wzi9pRAMgRQGEGMv4P
 oJIpgG6ARGf8peiaoLCLThyOeufj9PA=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1791474797; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=Rm3fIJfbh5vGnqBcsnQC8yS5vPcWhHheRJ31CyR9Ak0=;
 b=x+/XXdqmWNPuwdkMsec1+d0iljoTFTkmzhCSnMfYtpxIY8u+3CDMUd7JFbMv+nj7gl85q
 SElo7LQ2ZiJSLoDveFNpziOBCTWJeRnLGflNhL5wv6I5Q0jV8qHHMRho6y5ON0FLCZP6S9t
 zLeh7yfSlyHkNVoJ37r6sFwLGcggyZE=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id ED4DE83AB1
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 08 Oct 2026 17:53:07 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1791474788;
	b=h8p/vqoX6A1IVHCIJTm7t8MPfBO6s5zK9cWpm+d5u8PGgegRz+EvFLB1mi7+9puGeGVBgu
	Rc6YsxDtCLVzMTnkGDdezPwHHgEztIsgYmGGUIZL0HD78+jyCOHWNVPiS/FjTssmxeztbA
	Ulg16xLJ8g9XceAuFossX9usu/aw7L0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1791474788;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=Rm3fIJfbh5vGnqBcsnQC8yS5vPcWhHheRJ31CyR9Ak0=;
	b=QnYBO3RRMXLu8fdHrQaJGbA7iH7lLDC+H06FlaQq699OqlE10Pe7szTIyfXBFIdxfY3BKy
	0UZvGwE8BXj8Fjle4iyALQHFnlY/kh0NxgCeCWjXpAJZiao6htiTKOvRyZmn3AcFHTsnB3
	WsfJf+QohJ2ZG89C1JteZOm5OZ/Ntoc=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=k39cj3GQ;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id E2A451FEA4;
	Thu, 08 Oct 2026 15:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1791474787;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Rm3fIJfbh5vGnqBcsnQC8yS5vPcWhHheRJ31CyR9Ak0=;
	b=k39cj3GQLDRVtZM5rtnBA0wj6lWSUB1jFZaroGBGcFFXxHNdqKGDhsQpBg4p6iLKmsx0wG
	t8XUeC9cqeGBPLL6fb/iD6yqjX72jtbE+o0JYGaOODiEAu2Taez2fMv4YjtgKlA/X4MZ/U
	YdUZ4GZoyqTHpiuR0lm3gG9P5bvo70E=
From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH batadv v2 0/4] batman-adv: increase hash generation when
 manually purging entries
Date: Thu, 08 Oct 2026 17:52:58 +0200
Message-Id: <20261008-tt-hash-generatopn-v2-0-72b61e956a81@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFq8x2oC/32OTQ6CMBCFr0JmbU0HBMGV9zAshjLQumhJWxsN4
 e4W3Lt8L9/7WSGwNxzgVqzgOZlgnM2iPBWgNNmZhRmzhlKWDUrZihiFpqDFzJY9RbdY0SikTmJ
 XYzVCDi6eJ/M+Sh8wUKQxQf/zw2t4sop7405qE6Lzn2M94cH/G0ooUNRETXutLpVivFvyE8X8+
 ez8DP22bV/5Z0WD0gAAAA==
X-Change-ID: 20261008-tt-hash-generatopn-6c1a9019513d
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>, Sashiko <sashiko-bot@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1354; i=sven@narfation.org;
 h=from:subject:message-id; bh=LyuB3PCzzNbnmzDqgpCABcgGPduAEbUYXe2GrwZK8Ps=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFnH98Q7tr7z3a6t//XZmqq8y/8bFAqFJYPcWH13Ll7/O
 jb1ruSNjlIWBjEuBlkxRZY9V/LPb2Z/K/952sejMHNYmUCGMHBxCsBEuooZGV7wmRvumbyY57mn
 q9MUHbaHL4XuS+x0vvhysvqfJReen3BkZDh1+pd0ytO3ywIVDmxR99stc2dBhfQikdCo1cZ5ggU
 3YjgB
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: AAUKP556UPDJDCKSNZ6A4VJD4X5LQUZV
X-Message-ID-Hash: AAUKP556UPDJDCKSNZ6A4VJD4X5LQUZV
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/AAUKP556UPDJDCKSNZ6A4VJD4X5LQUZV/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

If a netlink table dumpiung function is preempted during a and resumes in
the middle of a hash bucket while a cleanup function concurrently removes
an entry, the dump offset will be shifted.

Without incrementing the hash generation counter, netlink won't set
NLM_F_DUMP_INTR and the userspace will not be informed about the
inconsistent dump.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
Changes in v2:
- add dat, bla, orig patches as requested in
  https://sashiko.dev/#/bug/linux-83da443f-ce69-4393-a29f-e02b70d1ec96
- Link to v1: https://patch.msgid.link/20261008-tt-hash-generatopn-v1-1-5aa687343ce1@narfation.org

---
Sven Eckelmann (4):
      batman-adv: tt: increase hash generation when purging clients
      batman-adv: dat: increase hash generation when purging entries
      batman-adv: bla: increase hash generation when purging entries
      batman-adv: increase orig hash generation when purging originators

 net/batman-adv/bridge_loop_avoidance.c | 2 ++
 net/batman-adv/distributed-arp-table.c | 1 +
 net/batman-adv/originator.c            | 1 +
 net/batman-adv/translation-table.c     | 1 +
 4 files changed, 5 insertions(+)
---
base-commit: 0eaac0f4187bc9b69b41d90998fd7b93ab07e53e
change-id: 20261008-tt-hash-generatopn-6c1a9019513d

Best regards,
--  
Sven Eckelmann <sven@narfation.org>

