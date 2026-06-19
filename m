Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D40FCD98E6
	for <batman@archiver.kernel.org>; Fri, 19 Jun 2026 07:08:33 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id BFB698550D
	for <batman@archiver.kernel.org>; Fri, 19 Jun 2026 09:08:31 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1781852911;
 b=VkAEbW4JnRvhGuj5v9BUdXw3ja6wq/Nofbxe5LVKB9i+4Kysrq/0T3Kubsd7vyCxnH96O
 4T2mEfDaKpns+LaI8pVUf+zOT/YS3THf6IxNDN/nHhGV52t79xnijxwB6CGLmvjneRmHrfy
 aAw64k0qJnRF75oFFKregLhTIFTI5lM=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1781852911; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=Sh8/d19dTv+BnqITWKo5mUC2hJ8B05RbL/Sh5BlrDOo=;
 b=Rj1ohFyrE6WWqmAw3f/wZ23+UCoHhGrAvzbzBOD+62ZqbuF1IHC74WdmKxUuDUlERTVvX
 lqG/I/TzPUUO3bAH+mtjqiSGBzRbAAuBxH8gMGXq5izXp0FvgN7mvdxHulCOsgG3r5/UaL1
 uZ6Uswip1CKa8OgQjVb00jQynKSzZMw=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 3F8948081E
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 19 Jun 2026 09:00:55 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1781852455;
	b=lV75f3CFwT77djoAeUZbT0ys8L40sjnI9epzi9m9gNJjz020ATX1z3vZvet9TH63+wnUbM
	Kwn1bz1GkGMEu0rDllfZtjiowZEQw+iD45HbNTn4JPTwffL0pDayz9Cfd2/qCxjv+APDen
	Tm89GcuuX5TELLx7KAcx3hT7Sz8m+Rw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1781852455;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=Sh8/d19dTv+BnqITWKo5mUC2hJ8B05RbL/Sh5BlrDOo=;
	b=IMr1qiIYugFvboCi6UnxmZBesT7SqivgAKiNoZYUrS5y8qqR7nT/58uMHa3haFnnyItv/X
	9HpiG6y1yoqBMeR25+Bpvegg6/T3snlY7rVcCyEbH3ktfnzTPzha1H4lQ6cGQQlxjqV0Pw
	wz+IJU2SnX3OnVakK5fvh+32GD4l2BE=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b="15P/FOiS";
	dmarc=pass (policy=none) header.from=simonwunderlich.de;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 23.88.38.48 as permitted sender) smtp.mailfrom=sw@simonwunderlich.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1781852454;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Sh8/d19dTv+BnqITWKo5mUC2hJ8B05RbL/Sh5BlrDOo=;
	b=15P/FOiSb2Egdx0WhrFpCTQj9sySCwZgzZwDyYL0e77yC8mkiuk4VeimCv0VY/KtLttsJh
	bBibLQ268eFDIJTvUNUbhDsmIvFhrjZV+/iHpxe0fNzPu+ncBBH7XBtpYj5EP3hFTFxLXN
	JiM8xMnGg3tSIvoOr8LTr0q33u7Jh+k5ZHQkPE7fyoUH3ys2Ur5SuNuDOJSol/I6L9Nv7z
	SSapBJsqbrAkRob71AxQWiVMvpl8TMgns9J+6mOz+/MK/8Ue7JzA/X3NU6M2xtYMz9DyQ3
	YKUImU8YR7sd5AZ7Sw4IyR+/42o2gXDXEnThW32i3oKwhv7nnXyURdnfeRGCKA==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Sven Eckelmann <sven@narfation.org>,
	stable@kernel.org,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net 11/15] batman-adv: tt: don't merge change entries with
 different VIDs
Date: Fri, 19 Jun 2026 09:00:41 +0200
Message-ID: <20260619070045.438101-12-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260619070045.438101-1-sw@simonwunderlich.de>
References: <20260619070045.438101-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: MNH3RL3QFDFQ5NTU43X276RQS7BU5HKE
X-Message-ID-Hash: MNH3RL3QFDFQ5NTU43X276RQS7BU5HKE
X-MailFrom: sw@simonwunderlich.de
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/MNH3RL3QFDFQ5NTU43X276RQS7BU5HKE/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Sven Eckelmann <sven@narfation.org>

batadv_tt_local_event() merges/cancels events for the same client which
would conflict or be duplicates. The matching of the queued events only
compares the MAC address - the VLAN ID stored in each event is ignored.

If a MAC would now appear on multiple VID, the two ADD change events (for
VID 1 and VID 2) would be merged to a single vid event. The remote can
therefore not calculate the correct TT table and desync. A full translation
table exchange is required to recover from this state.

A check of VID is therefore necessary to avoid such wrong merges/cancels.

Cc: stable@kernel.org
Fixes: c018ad3de61a ("batman-adv: add the VLAN ID attribute to the TT entry")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/translation-table.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 8b6c49c32c892..016ad100153bd 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -447,6 +447,9 @@ static void batadv_tt_local_event(struct batadv_priv *bat_priv,
 		if (!batadv_compare_eth(entry->change.addr, common->addr))
 			continue;
 
+		if (entry->change.vid != tt_change_node->change.vid)
+			continue;
+
 		del_op_entry = entry->change.flags & BATADV_TT_CLIENT_DEL;
 		if (del_op_requested != del_op_entry) {
 			/* DEL+ADD in the same orig interval have no effect and
-- 
2.47.3

