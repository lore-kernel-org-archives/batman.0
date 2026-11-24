Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597E1606A331
	for <batman@archiver.kernel.org>; Tue, 24 Nov 2026 21:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.a=rsa-sha256 header.s=20121 header.b=F3ilugB/
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id D772C844DF
	for <batman@archiver.kernel.org>; Tue, 24 Nov 2026 22:13:50 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1795554830;
 b=XTc2sQfUQJEAChjYvEqoyz59ExAV8b7jH3W9CBHasrUeR1QyBKUuOtATiapDOr2y/zMZS
 U2VMWlV8DCuG+GcKOSkZ4OK9SDmIWyfcltO1cfEdZZO3fQZMSx7N2WLIn/PCDdkMtXEgEsw
 4gT+irudQoQ3zsiNh4a4zM6jeYvXYeE=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1795554830; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=mf7buGo+vnViwyOxwcfI2+9LmRFxYn/Jh+iXVheE0L8=;
 b=jh0zbeFJUryo6lesWpIQ/lvahFZeXX9hbLq+M7cGZLkCTmaNQkOEKj46VqXg96GqRAbbq
 ewYLGx7dayty52mbJm6Q5lSag/Sr0Eue/uGJbYcvqNirtbQTq1KCG134B0YhtQ+FsFzHUgr
 LqNWjobLHZgFaPaBKX84btbSWh/djLQ=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 7593E83C6F
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 24 Nov 2026 22:12:15 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1795554735;
	b=0mt8wPiOczHHsMie2exQkxOINrTyXSMobUJxl9uwjlYbUbDOqOqE4jcbF5zDjDQQnJnPf0
	F9awoQf//kmvUKyemYO1Ia4rAdBanZSjjIcySMZGdueYywN9y0+TynwIE0TPl+EPPSJW8e
	ws5BgfJFOAFdAgIFfKEKIl0WVeySMOg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1795554735;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=mf7buGo+vnViwyOxwcfI2+9LmRFxYn/Jh+iXVheE0L8=;
	b=Q6scj2WsRlcvFya07YUcYY12hykjL3rG1etq+fkyDPwbPVdtQschgzIAKjhGIKOrjhQC2d
	M9QCdvZs3Zk0yEejKGlBLUPy+3DsRbpcdVi0BykbdhPsNTvG0to6qC2+7aOxk4DF1qXfsH
	UpsXPxVLqDlDt6WSPHuTAkvehLnJMZY=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b="F3ilugB/";
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 21B382014F;
	Tue, 24 Nov 2026 21:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1795554735;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mf7buGo+vnViwyOxwcfI2+9LmRFxYn/Jh+iXVheE0L8=;
	b=F3ilugB/zycqfQICnGsHDwkK7dIO+/5FSyNi2Qba4+HuauFpHr2EmYk0n0aPLpC9wzU0zl
	GtiRD20OVSZhupjf/vXGDl2H7rKDqRjCvZuG/FvI8ayoQWcb+G+2hCSPEPcFviV8mrYUCv
	BETOmPjqXg6Pesh5skVm3Gf+DToIPew=
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 24 Nov 2026 22:12:07 +0100
Subject: [PATCH batadv 3/5] batman-adv: tt: mention purge of pending
 clients as concurrent removal
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261124-sashiko-kdoc-2026-11-24-v1-3-27282884274f@narfation.org>
References: <20261124-sashiko-kdoc-2026-11-24-v1-0-27282884274f@narfation.org>
In-Reply-To: 
 <20261124-sashiko-kdoc-2026-11-24-v1-0-27282884274f@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>, Sashiko <sashiko-bot@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1595; i=sven@narfation.org;
 h=from:subject:message-id; bh=0JiU3W2QeKRU/24wU+cjTvX1DmtAOZbb3tZMx7lHpLg=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDNmsf5cVPLv8Z/qVuK23D2hO3cLy14BTjc/4U1xZsCFrm
 83j+TulO0pZGMS4GGTFFFn2XMk/v5n9rfznaR+PwsxhZQIZwsDFKQATybnByPAq2Up++ZEL/qf+
 SASukDs75eOLAgc/qZc32OTLJV9PO5HO8D8m5pvFt4bUPwvzdWofz7u9he0Kh8eKn+uZnJt8pIV
 /dXABAA==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: YMRI7KYUPCHQWFCX4ELCV6SGN63PXIPI
X-Message-ID-Hash: YMRI7KYUPCHQWFCX4ELCV6SGN63PXIPI
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/YMRI7KYUPCHQWFCX4ELCV6SGN63PXIPI/>
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
index a436c39c..7de69a30 100644
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

