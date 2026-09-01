Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D70C2C61DD3
	for <batman-adv@archiver.kernel.org>; Tue,  1 Sep 2026 17:19:08 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id EDDCA814B9
	for <batman-adv@archiver.kernel.org>; Tue, 01 Sep 2026 19:19:06 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1788283146;
 b=XhXvXiR24ZsjPXS9Es7bIs7b9fciC1jNSbkKSE9Ca8QscAD9c6hSOC3B3fnh+MZ3AyI9p
 kQWU8VrPFh9TV9fwDNL+p/R6flfKivN5u8/a4FpB4IUaZZNo/rZzZCVkUxIQQUi41ctzY/v
 UqTW675uaIc0xeoA8kURhxQb3hbO/bc=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1788283146; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=j5sbUCtZg2xid3EBIGJR+Y9GOmVRYN2bdTQgyXxCjW4=;
 b=UO3Wyj1bbXFww3j4ZlueBRIU9k6pib0TUydZYQwjmDNdMCFuwlCPpw43lDbn7nqw9EXp7
 POWUR4W4jB+5uvat2+P/rcRynGrgQpZyMw9swnBHES8hLQanaJd8fkKjuApn7wen1tkHHpG
 MBrrmNI7x94sWzmx9Mg5Zfwiv95dmEI=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id BCF9280F42
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 01 Sep 2026 19:18:49 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1788283139;
	b=RFCAXnLKwX4/cP7e6KkWD0VuVfCKnox5JxCPwzTjrf/Y9yWSWTvuxLA/1kPepwBsMd6Xsk
	PYfQmE3jABPmDFs7gZSj1LTgEd8tdPiWoOoCyD8mO5Ji1jXJcDlz5X8SYIC686OMlNShbu
	UGB5lW6tYuFoQmfsePHndJFKLg6m+Nc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1788283139;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=j5sbUCtZg2xid3EBIGJR+Y9GOmVRYN2bdTQgyXxCjW4=;
	b=0TWYvSlGU+9NxjJT1+5Tl4paE3zM3kYc83mMIpkyD62qGRpdatD0zV7STG0druFueNwhYQ
	5m126Um5gLlZfScsHHcaSlwFF6k7HTlio75x7CxEmaATFGEtRc9rIwqPUZIelymWxJFnMJ
	XWfmc4D7NB0rRvXFG0vQ8kjMIHEquDc=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=E+5NwPia;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 1DDEF2043A;
	Tue, 01 Sep 2026 17:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1788283125;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=j5sbUCtZg2xid3EBIGJR+Y9GOmVRYN2bdTQgyXxCjW4=;
	b=E+5NwPiaP6SsqLSv646xruZKamYUZpVLuGpK7qC5TIFjm2d+cTucFe8Hn5yh3NAFG8v0Qr
	5wPzD+hMd9r2wm8KvkPNjEGcSeV+vJUbapTndl5oQ/2ssVne8UHHZqvvswxIqTRZpXnEfu
	qAndyxTDcPR5GlG2XGple3IoIE2gmQk=
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 01 Sep 2026 19:18:42 +0200
Subject: [PATCH batadv] batman-adv: bat_iv: fix ogm_neigh_is_sob parameters
 references
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260901-bat_iv-sob-kdoc-v1-1-54be2f58b715@narfation.org>
X-B4-Tracking: v=1; b=H4sIAPEIl2oC/yWM2wrCMBAFf6XsswvZoNL6KyIll227Co1kayiU/
 nujPs7hzGygnIUVbs0GmYuopLkCnRoIk5tHRomVwRp7NZ0h9G7ppaAmj6+YArZnIkdkzWXwUK1
 35kHWX/EO9exigcd/149/cli+Odj3AyAMAyZ7AAAA
X-Change-ID: 20260901-bat_iv-sob-kdoc-8411a11205fb
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1238; i=sven@narfation.org;
 h=from:subject:message-id; bh=J9Ij1AfYbI5hdtJOohobRrsfCpEGOAR+G2Ot8XfWRrE=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFnTOT79i/lw8mJI5mylJebWamKnf/bWvDT5f6VNu/R39
 IRrT+6f6ShlYRDjYpAVU2TZcyX//Gb2t/Kfp308CjOHlQlkCAMXpwBM5DEzwz+r05FrMuXE7t9a
 uyP23vOJN2PLlzrzHBK7vkj/TfxKVolVDH84lBoD6yNfrTmQNb2Cd7fIDBtJj1iDHv65f89M21C
 ++RA/AA==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: EI2VRA366IO4UFIJEBLT46KVV6WITPV2
X-Message-ID-Hash: EI2VRA366IO4UFIJEBLT46KVV6WITPV2
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/EI2VRA366IO4UFIJEBLT46KVV6WITPV2/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

The batadv_iv_ogm_neigh_is_sob() kernel-doc summary line is still
referencing the old parameter names "neigh1" and "neigh2". But these are
now called "candidate" and "reference".

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/bat_iv_ogm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index 3fe09b4c..89b499f7 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -2422,8 +2422,8 @@ static int batadv_iv_ogm_neigh_cmp(struct batadv_neigh_node *neigh1,
 }
 
 /**
- * batadv_iv_ogm_neigh_is_sob() - check if neigh1 is similarly good or better
- *  than neigh2 from the metric prospective
+ * batadv_iv_ogm_neigh_is_sob() - check if @candidate is similarly good or
+ *  better than @reference from the metric prospective
  * @candidate: the first neighbor object of the comparison
  * @if_outgoing_cand: outgoing interface for the @candidate neighbor
  * @reference: the second neighbor object of the comparison

---
base-commit: bd881c94108e3fb3f3d9ef7186d74e51afe1e5a6
change-id: 20260901-bat_iv-sob-kdoc-8411a11205fb

Best regards,
--  
Sven Eckelmann <sven@narfation.org>

