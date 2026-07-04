Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB893C43458
	for <batman-adv@archiver.kernel.org>; Sat,  4 Jul 2026 11:48:55 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 932F18418C
	for <batman-adv@archiver.kernel.org>; Sat, 04 Jul 2026 13:48:54 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1783165734;
 b=U9wEDS2mUO4HsUZfR/g5UcQvBMe8R73JS8MROWb9LbQ5TyeZxDqRWiyx50ivJsoNqvysq
 P2P5DEe+8eWoI83yikxIMoUOO6SBLcij1LT3WZOlNMOR+6hSXuihKWuwI5jAWXOeblOvubR
 j8Oz+nrJFeArYl4/k0C7Y3E8EG2ryAI=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1783165734; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=0RTT3tyaqCh38hX5R7GPYQMTuyoqEkW0enx2ssrsE28=;
 b=VN2c8+IryBTZJ0x66nk/1gdS+r1YJ3iGjVfBPuuy8JRLHg4SSzydVKIcP+6jxtwQA1k0r
 ovfFh6crL2e6g9j+AGxRBIOGOHGkr1NddkfW2KvkeJhj/brXvQiUP2QSQSOHRqlDobQYHW3
 hAPJr7q3Z3lYSHAqdaMWuj+epXECIc4=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 7C14681466
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sat, 04 Jul 2026 13:48:34 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1783165714;
	b=KSSGJWHBq2bOwpfSaVxeKgv3iscCfebswXSydBMY4xLE2+6njBtRSN04Mx/lc+LKa01cC/
	89Qx0mVP8xx3+6sG8xGnOtMuoeUo0t6k9pu4Fam/lQJ9UnK1DmEt9PTzkYvTIzpWDpxla8
	hhYMPxRt9w3qeTxx4ZCUPiDU7LELNDM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1783165714;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=0RTT3tyaqCh38hX5R7GPYQMTuyoqEkW0enx2ssrsE28=;
	b=wkFL19SBleji+d7shmprmsmM+bQRjbqo4vt6Bg8Ug4MnciWZcuVw6gSFzvQHY0YVZA/cFS
	iPShdegE7H+eJ/3SRhfth5qEuByhkEhL1Rmb+s/pneKOqQirzmWhFDGDG5VF82bZ33V/Te
	RGKlnWF/KECNkoYYoic5SfnmM5uG7tM=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=M4Oca2F4;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id D22141FEA4;
	Sat, 04 Jul 2026 11:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1783165713;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0RTT3tyaqCh38hX5R7GPYQMTuyoqEkW0enx2ssrsE28=;
	b=M4Oca2F4m47GtYLjm5lEieMGaNw6D+63GrylAnSAzqW9Vr553ypUwwZdCt0ACFQI9v500n
	G+vOrr195F2D2S8ujnPiG+Aby592hVAMZwzG1WcNkmwI5w6+q+x5ZoPqCwMJr9Uyhj69Q+
	jjVdOxerDDZbuuFcw81LwOamDZJzDhI=
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 04 Jul 2026 13:48:18 +0200
Subject: [PATCH] batctl: isolation_mark: fix error message for invalid
 mark/mask values
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260704-bugfixes-isolation-v1-1-247e221a6e5a@narfation.org>
X-B4-Tracking: v=1; b=H4sIAAHzSGoC/yWM2wpAQBBAf0XzbGvd41fkYa1ZRkI7SMm/GzyeO
 udcwOgJGargAo8HMS2zQBQGYAcz96ioE4ZYx7kudKravXd0IiviZTKb6CpzOnFYFmliLEi4evw
 U6ermZ97bEe32nuC+HxQnFfd2AAAA
X-Change-ID: 20260704-bugfixes-isolation-5f03fe9743ac
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1212; i=sven@narfation.org;
 h=from:subject:message-id; bh=MlCCZmlVXY+RNAKNj+GobE+4iopVvk0S2APuywtWZKY=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFken5n2HfQ9t2SS2t15Fz+sjpP+YNnC7DCJY2afysaME
 2d2/zSS6ihlYRDjYpAVU2TZcyX//Gb2t/Kfp308CjOHlQlkCAMXpwBMpG4dI8PyuevNbi7sMX7h
 ZZpyY+LkHvV9MhcFlBmnak788eXGHeMuhv/FMbE5PWsnxy76WCV/Pui3QjiHRdXiddONdJ8t23U
 xOogTAA==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: 3IVWD6ZH625CEA47NCO5RQXQYNFKNQBQ
X-Message-ID-Hash: 3IVWD6ZH625CEA47NCO5RQXQYNFKNQBQ
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/3IVWD6ZH625CEA47NCO5RQXQYNFKNQBQ/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

When the mark or mask argument fails to parse, error message claims
"incorrect number of arguments (expected 1)" even though exactly one
argument was given.

Print the offending value and say that the format is invalid instead.

Fixes: a319ec4dcbff ("batctl: Support generic netlink for isolation_mark command")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 isolation_mark.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/isolation_mark.c b/isolation_mark.c
index cef4de0..8770fad 100644
--- a/isolation_mark.c
+++ b/isolation_mark.c
@@ -67,7 +67,8 @@ static int parse_isolation_mark(struct state *state, int argc, char *argv[])
 	return 0;
 
 inval_format:
-	fprintf(stderr, "Error - incorrect number of arguments (expected 1)\n");
+	fprintf(stderr, "Error - invalid isolation mark/mask format: %s\n",
+		argv[1]);
 	fprintf(stderr, "The following formats for mark(/mask) are allowed:\n");
 	fprintf(stderr, " * 0x12345678\n");
 	fprintf(stderr, " * 0x12345678/0xabcdef09\n");

---
base-commit: e93995999e80513db80eba200ea682b5b15556af
change-id: 20260704-bugfixes-isolation-5f03fe9743ac

Best regards,
--  
Sven Eckelmann <sven@narfation.org>

