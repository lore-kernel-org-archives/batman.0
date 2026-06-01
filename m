Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85A7ECD5BD1
	for <batman-adv@archiver.kernel.org>; Mon,  1 Jun 2026 12:47:26 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 34320855B2
	for <batman-adv@archiver.kernel.org>; Mon, 01 Jun 2026 14:47:25 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1780318045;
 b=e1KzKe4wi/hzyxPaL9QPk//bVYkdMgnLEBHA3S68eCvkQLYmUeLO2R5PorWkvilKDvIRJ
 sRaROyyS3lvLU35+Vj1+TnugdXZVBmV7IPWNG3rwrB1SBIXCQ+yUGfW84R08CMMHf0WyC4F
 jMS6vCe7mM0yGHou2XWFkp5+GLOTwbQ=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1780318045; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=4x7fYtKt6TJrTs4d6ISmPTw7WCMg1rpDK5hrgQIb/fw=;
 b=oFxzG2X17lxxUUtXVmL2OO20JvNDEDjqYbPCyoyD2v57zbGPQfdOPWfU4e04A49bN3Kzs
 Wt2HBhL5+rLh7MyuaT1QQyH369Z7riQ2qmBejqie58tX3FS/PUUh2sy7iESFyjlphZmx4Oo
 hByP8qMRR6BvZALUz3FO7IdOKyK6R40=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id E2381806CD
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 01 Jun 2026 14:36:53 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1780317413;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=4x7fYtKt6TJrTs4d6ISmPTw7WCMg1rpDK5hrgQIb/fw=;
	b=o5rLtap9/788ROzT4aHTlWD5v2XT+OCiBrewuxkeZy2sMKYLieIC41XLv6HyEo6xJqNxXY
	mUl3EBpcrIkeqxehCbaaujRdP7UMio48ucOR4gZ9Y0NxzVAOouYByPcYZjBPaqkT3D9+WI
	nuSg4KiI2kpJT8K1evcX55l+qTAu/DU=
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1780317413;
	b=K2VjcjBKTez91w43sZ2odZPGw17vBrl36iqazXEV1MbNT82Tl6PUuw69r128aAZWpRac18
	iRw0btK8CCophQfhgc10C1kgTBKYeZvlHlln8+dvWqO7YOYPcvEImKP0Kjm/vx1t18J54H
	KfXPb8QfAxHq4jAGCQ8slbEsPAS7kDI=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=BKokBU8l;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 23.88.38.48 as permitted sender) smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1780317413;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4x7fYtKt6TJrTs4d6ISmPTw7WCMg1rpDK5hrgQIb/fw=;
	b=BKokBU8lE+K6Fe0Io/S+cQ/6Z3y6DMKYCm7vopirP7gGxGzR4TAczIXlwwEHxNeoSD5iiK
	C0AGnsAvKo7cBcQjXlxDKEQ4EqSTwIhBYPoCU1agIr03HP25Lzr3KV75kZDfiv18/jeeYs
	Fl/FaTkJ+6DJtJkxbssOsXF0vwTY4lhz8j3jL7T8UFCWatJonfGPhfA709PkJgRqV0V3T0
	3Nn16WhBs4qs4Zo+JJZBwjEStjhgf7bwLV10IANPn90fBzRvvyClB8MCic1vdqLb4reYNd
	kInv+M0+fUTCZ3Fx2mDY6iNG46/xaTpNlPbK9Z03crHKm7u/zmRElkkyMbldaw==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Sven Eckelmann <sven@narfation.org>,
	Antonio Quartulli <antonio@mandelbit.com>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net-next 13/15] batman-adv: tt: replace open-coded overflow
 check with helper
Date: Mon,  1 Jun 2026 14:36:27 +0200
Message-ID: <20260601123629.707089-14-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260601123629.707089-1-sw@simonwunderlich.de>
References: <20260601123629.707089-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: 6DGAVREWYCM57QWT4CYHVBCATOTU6LHO
X-Message-ID-Hash: 6DGAVREWYCM57QWT4CYHVBCATOTU6LHO
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/6DGAVREWYCM57QWT4CYHVBCATOTU6LHO/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Sven Eckelmann <sven@narfation.org>

The commit 6043a632dd06 ("batman-adv: reject oversized global TT response
buffers") introduced an open-coded check to ensure that the allocated
buffer size can be stored in a u16. The check_add_overflow() helper can
perform the addition and overflow check in one step, so use that instead.

Acked-by: Antonio Quartulli <antonio@mandelbit.com>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/translation-table.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 8903b2f84f512..5e134d08a80fd 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -799,10 +799,10 @@ batadv_tt_prepare_tvlv_global_data(struct batadv_orig_node *orig_node,
 {
 	u16 num_vlan = 0;
 	u16 tvlv_len = 0;
-	unsigned int change_offset;
 	struct batadv_tvlv_tt_vlan_data *tt_vlan;
 	struct batadv_orig_node_vlan *vlan;
 	u16 total_entries = 0;
+	size_t change_offset;
 	u8 *tt_change_ptr;
 	int vlan_entries;
 	u16 sum_entries;
@@ -826,14 +826,11 @@ batadv_tt_prepare_tvlv_global_data(struct batadv_orig_node *orig_node,
 	if (*tt_len < 0)
 		*tt_len = batadv_tt_len(total_entries);
 
-	if (change_offset > U16_MAX || *tt_len > U16_MAX - change_offset) {
+	if (check_add_overflow(*tt_len, change_offset, &tvlv_len)) {
 		*tt_len = 0;
 		goto out;
 	}
 
-	tvlv_len = *tt_len;
-	tvlv_len += change_offset;
-
 	*tt_data = kmalloc(tvlv_len, GFP_ATOMIC);
 	if (!*tt_data) {
 		*tt_len = 0;
-- 
2.47.3

