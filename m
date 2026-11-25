Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF15606A323
	for <batman@archiver.kernel.org>; Wed, 25 Nov 2026 19:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.a=rsa-sha256 header.s=20121 header.b=Mx+I8v8y
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id BF64184047
	for <batman@archiver.kernel.org>; Wed, 25 Nov 2026 20:44:22 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1795635862;
 b=rkldzErPcvPAVJUoLABSkGD32BOczTAdgt+AOOptVgeT9vAXzxDtvqFCvfudUhP8loBDB
 rfTCHWe0U9GX0gMZ8f5p+V11Zx/hT7ImxwUMJhegzyziGVHFGR1zqUGuFlHLDjHsF98FnLa
 DItmyBrsz+r2/3siVVMyo7I1zlm2OEc=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1795635862; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=XMIitSyfOAlXBoPkKj55fQnCvV3XE3OnAw8APkfm6Og=;
 b=W7n6D2cUBUJqIaAiqKek+p60hC638aYlzMxJy2VLq09zgmq9Hh9Rgqogn+JBQvnQ7z3wh
 miN1TDPadBXlYbiTFZBOhGManrAmu2sTFtcoltdoTS6UpUiJfFxjAfK8Y+oX3K2xf0fULO6
 Wdt8TGb9VRCdx/KiyCHymRn8VgliU/Y=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 50DD382EDF
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 25 Nov 2026 20:42:08 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1795635738;
	b=grJeEIc5NP1JyyWqiin6q03QSOJ0WpbOKPWnJFEqrn+b19BdL+M/0HYYAV1QQ8cuA5SLhu
	9TnJ7WiIPZK5DlPOk+38s/4D5wzy5lih1mTqCqMNAbySzelY1lr1HIv7/IN8ytdrwSH4Cv
	7HRdnqWW6MTdX5pfQbuZAnYr4lzkYl4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1795635738;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=XMIitSyfOAlXBoPkKj55fQnCvV3XE3OnAw8APkfm6Og=;
	b=RObDLMIdH24DCstz2kzux2BaMvHYCsdojAZi0j5iZwliFvUHSDqD7rU2feWwqCq2SB7kq+
	YTPTxG/wq3nkAxHlkla1ExFOgqmcwhgsVretJzYQQ2Tj3na6VQ7oqniymlZmp7zIOwpcg6
	6AbNH8PsrFDiUJp8JYVK7vQ+HmtvL/4=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=Mx+I8v8y;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id ADCC120F26;
	Wed, 25 Nov 2026 19:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1795635727;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XMIitSyfOAlXBoPkKj55fQnCvV3XE3OnAw8APkfm6Og=;
	b=Mx+I8v8yyKHIR3gUOXDyASOWUcy3H0fg1ogNMdFolf40zd5U0FYAKnTd6HNK94uOrIZk6a
	hICiFQ2rG/elDpJYedggUlUT7Ir8TnbB7IyDJ3zOPl7MYa4DlyFcUfyqFWL5LRPyOUpQm8
	rJZUGnkYczzMzKlfiGiU0XtatKaG+YE=
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 25 Nov 2026 20:41:58 +0100
Subject: [PATCH batadv v2 3/5] batman-adv: tt: mention purge of pending
 clients as concurrent removal
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261125-sashiko-kdoc-2026-11-24-v2-3-d26231bfcbd3@narfation.org>
References: <20261125-sashiko-kdoc-2026-11-24-v2-0-d26231bfcbd3@narfation.org>
In-Reply-To: 
 <20261125-sashiko-kdoc-2026-11-24-v2-0-d26231bfcbd3@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>, Sashiko <sashiko-bot@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1595; i=sven@narfation.org;
 h=from:subject:message-id; bh=eIK/4vUft/Q2+yZyMv1TRXeedCO6GppCj1227iwEyDI=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDNnsVqzHH/ll1pTvFjCWUPe95OH0aFNxnEVTxqq7qy5t2
 5N3/cq8jlIWBjEuBlkxRZY9V/LPb2Z/K/952sejMHNYmUCGMHBxCsBE3kxmZNhd/4lrvunCvAYN
 h6rD325ujv5r6dnnIinyr0o3YnZ3jDojQ/P9Mosn7upqWwW+b9LYwpBjuGtmgYKh5x6mruSWcod
 wJgA=
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: 6GIBP6O3HIUM65ZYOW4ODJLHCVUUDJNR
X-Message-ID-Hash: 6GIBP6O3HIUM65ZYOW4ODJLHCVUUDJNR
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/6GIBP6O3HIUM65ZYOW4ODJLHCVUUDJNR/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_NONE,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The kernel-doc of batadv_tt_local_remove_entry() only mentions
batadv_tt_local_commit_change() as concurrent context which can remove the
entry. But batadv_tt_local_purge_pending_clients() is still called by
batadv_tt_local_resize_to_mtu() and removes BATADV_TT_CLIENT_PENDING
entries under the same hash bucket list_lock and flags_lock. It only holds
the commit_lock, which is not taken by batadv_tt_local_remove_entry().

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261123171827.3294525-2-sw%40simonwunderlich.de?part=13
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/translation-table.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 74ebf7af..46c0c1dc 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -2053,8 +2053,9 @@ batadv_tt_local_set_pending(struct batadv_priv *bat_priv,
  *
  * All checks and modifications happen under the hash bucket list_lock and the
  * flags_lock of the entry. This prevents a concurrent
- * batadv_tt_local_commit_change() from removing the entry and
- * batadv_tt_local_refresh() from modifying it after it was checked.
+ * batadv_tt_local_commit_change() or batadv_tt_local_purge_pending_clients()
+ * from removing the entry and batadv_tt_local_refresh() from modifying it after
+ * it was checked.
  */
 static void
 batadv_tt_local_remove_entry(struct batadv_priv *bat_priv,

-- 
2.47.3

