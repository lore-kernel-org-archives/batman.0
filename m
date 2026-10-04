Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54DB0CA5FCE
	for <batman@archiver.kernel.org>; Sun,  4 Oct 2026 08:10:35 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 98AF384438
	for <batman@archiver.kernel.org>; Sun, 04 Oct 2026 10:10:33 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1791101433;
 b=dA2Y/kOD7qdSFH34WBWIE6GgYYjxypLmVJMlYM9JIr0c4vbF9LhldGXy0DffwpS4/yf+s
 kLxE2WaMnzHLzMoDIvFBK0Hx/0PE5I2MM+c3D8dtvZZDwvVnjhLXqAFEq38P2xOnTRxsGuw
 5hIjSqFqM8PEpov2KfcGomTPj/bOgMk=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1791101433; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=ksHE8Kmr7LVI1FmXRZsVnUKC5ZtXkYvafHS21jbVNY0=;
 b=e9DoPbwnj4T1poAA8kELZbfTJ7iiAsecDvHfxrZ2Rf6MRo7Y8p1Lze1Sng6aaorrdvJvF
 luRyq9riebaQ+HhWF6j7FxqIRDcvy90OdbKub4e9j0dKFd37GlKlyGcoFR0P7LwjQcTv3hw
 rt19YnS5LWvWFHHnVuyA+rHbc2eBgmY=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 1C74B81101
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 04 Oct 2026 10:10:14 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1791101425;
	b=gDnFvZwZqdz0xWjyUTI7kIh7tknblRCuBj22eAc4YgbFLTJVJGo9ZhuIXI9XWw7B2Rr9CE
	NNkpXn38M5rxWylipDHgJ34V5yRaVnBDy8VcLWva5JFarvNUF6EQMC10IggiC2+OEMxY9J
	KVvZH6yA2DfXNs5zRCYZvZJ430Ecvd4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1791101425;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=ksHE8Kmr7LVI1FmXRZsVnUKC5ZtXkYvafHS21jbVNY0=;
	b=1COl4w49r4+0lzgKknQhNoM+8LCWlEuz3IAd/GLBLBg306/lieYqs8Ro+7NL73smad6nv4
	HgM71vZ0a0epCx5ZzZPD/prrhJ2F63kwIDrIRnJaq7huw742mPzcMb7kWkgHIN+BmU5ODf
	VApXN+v8/0IpMp13BdlUGtACNtM7YLY=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=g9nikUXS;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 9A8C02046C;
	Sun, 04 Oct 2026 08:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1791101413;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ksHE8Kmr7LVI1FmXRZsVnUKC5ZtXkYvafHS21jbVNY0=;
	b=g9nikUXSDoXEdG7H5qRSta6lYeLWW7h7z4uAyLdwYRjyZOxRokw6C7+SZn6tCtW36KY5d8
	K6AQ420OywdqHJkqkseull76nMuYWSK0UI9aWt8mqkvGJ5KGg0hA5NxG0LGi4xqI3jvYKt
	jVC7okRRLiS0VUYBAUgBVec+ip1D3bE=
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 04 Oct 2026 10:10:06 +0200
Subject: [PATCH batadv] batman-adv: dat: initialize orig_node of unfilled
 candidate slots
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: 
 <20261004-dat-eligable-uninitialized-v1-1-9674029343da@narfation.org>
X-B4-Tracking: v=1; b=H4sIAN0JwmoC/yXMQQ6CMBBA0auQWTtJW4EYr2JcTJkBxzTVtIUYC
 Xe34PL/xVshS1LJcG1WSLJo1lesYU8NDA+Kk6BybXDG9daYFpkKStCJfBCco0YtSkG/wsiXrmu
 dNeO5Z6jAO8monwO/gadCvMD9//PsnzKUXYZt+wEobL0lhgAAAA==
X-Change-ID: 20261004-dat-eligable-uninitialized-d8554210f36d
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sashiko <sashiko-bot@kernel.org>, Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1612; i=sven@narfation.org;
 h=from:subject:message-id; bh=io0Y0lpVEp/+ohbE5/F1RHxoVAXkNc4lEVVzhMu1ObA=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFmHOB+5L1yYesxg1STpRmVp1/RK8WzfzDknhA39J789/
 v7B7jiJjlIWBjEuBlkxRZY9V/LPb2Z/K/952sejMHNYmUCGMHBxCsBErt1m+O9WaLMqceuUDOl5
 TRY1ZxZ/1lmyYFUpg3VvyG6F3i5bhx+MDFPfsYa5l7aF/LBJuVB4kOG0Y+2baNY7am/Ob245+0F
 AmBsA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: RIZ4WJ6Y3RRQRMWQZU73KZSJ5BPLHQ66
X-Message-ID-Hash: RIZ4WJ6Y3RRQRMWQZU73KZSJ5BPLHQ66
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/RIZ4WJ6Y3RRQRMWQZU73KZSJ5BPLHQ66/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

batadv_dat_select_candidates() allocates the candidate array without
zeroing it. batadv_choose_next_candidate() marks each slot as
BATADV_DAT_CANDIDATE_NOT_FOUND but only sets orig_node when an eligible
originator was found. In the following rounds,
batadv_is_orig_node_eligible() compares res[j].orig_node of all previous
slots against the evaluated originator. For slots without candidates, it
reads uninitialized memory.

The orig_node has to be cleared together with the
BATADV_DAT_CANDIDATE_NOT_FOUND type.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/bug/linux-b25d9aa4-10bb-427c-a145-ccaadc2a1bb9
Fixes: 34b3c3850e7d ("batman-adv: Distributed ARP Table - create DHT helper functions")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/distributed-arp-table.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/batman-adv/distributed-arp-table.c b/net/batman-adv/distributed-arp-table.c
index 74050bff..0260ed7e 100644
--- a/net/batman-adv/distributed-arp-table.c
+++ b/net/batman-adv/distributed-arp-table.c
@@ -653,6 +653,7 @@ static void batadv_choose_next_candidate(struct batadv_priv *bat_priv,
 	 * NOT_FOUND
 	 */
 	cands[select].type = BATADV_DAT_CANDIDATE_NOT_FOUND;
+	cands[select].orig_node = NULL;
 
 	/* iterate over the originator list and find the node with the closest
 	 * dat_address which has not been selected yet

---
base-commit: 4fa5cbac90fa7b8936779b4313debb3d89701c59
change-id: 20261004-dat-eligable-uninitialized-d8554210f36d

Best regards,
--  
Sven Eckelmann <sven@narfation.org>

