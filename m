Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D459CD6E44
	for <batman-adv@archiver.kernel.org>; Thu, 28 May 2026 14:39:59 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id B2F0684538
	for <batman-adv@archiver.kernel.org>; Thu, 28 May 2026 16:39:57 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1779979197;
 b=OLu3VFk8jcFU/7+1XGg7dhTXkEONmLSzINY2gt75bP3O5ZTOhcn9ahCYX1iq7H+4f2jMO
 HhhyZba4oyaArn8JoSa4atgWWinOwqG83OkGmsiJTCL0eMWca9m/Lb4NH6cDmPf4O2Xqj2p
 z7TKxfRujWfGl7rQcRz115dZBt20nQA=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1779979197; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=4x7fYtKt6TJrTs4d6ISmPTw7WCMg1rpDK5hrgQIb/fw=;
 b=RWWl1ymfPahCiOXM7ws914vAgDta2ejP5i6cTWh+RFQ33cChLKuUbC8ljmDxSJznkcejt
 4DHdlux7TC8ppGbRDgrMxAiMauy1W7GUKy/yvcaGnE/3h0E5YwX+nEp2xeCoTAp7elxCDb3
 3DjTRgLvsEBeCD6kkBMKGsku9tIo+Ik=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 469A883E26
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 28 May 2026 16:29:36 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1779978576;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=4x7fYtKt6TJrTs4d6ISmPTw7WCMg1rpDK5hrgQIb/fw=;
	b=nuGAPXthWR3ljhF99n3LpHUGpXY2Ak+GICf4v0dLoeAGK4EaKp2OQ4Qazl3dBXkvMO8jhw
	xkjlt5eNmW0hfwavlBNn2EUeVOjUXfyFAXOYklr6OyTGLKVu5/wXqUoN49OTRC3VRsSPsp
	wZZL25z/n0vHs8j1CxgYnwR2xyRrWj8=
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1779978576;
	b=1VynTaXTqJuJ2SCw0HzWJVnoPMMXC7dXnfW2vXE01k6X8m6aBf4Gtc0B1kkHkUoZ9IY749
	oDW0BvGgHtVhhAOcMFfjWWSXE7LwMd+5UO72jw2VDOF4IWet8nfS9VKsXiqEAdbvbbresN
	AV8zSj3COVLTrDpkpKQh1aVbfbWx6qI=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=q5ZNYbkr;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 23.88.38.48 as permitted sender) smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1779978575;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4x7fYtKt6TJrTs4d6ISmPTw7WCMg1rpDK5hrgQIb/fw=;
	b=q5ZNYbkrONDvLP63+NJIuAzoE7w7Y+6WbS+cLRKdfISEh93dx8CfV4KN7yoSb+1QnDqPds
	jXQUmXgf/hN/QRXEUCOYaY+TD9DBKQG+NpLUWstLwj022725SYQnkCsygITwjH8PXSSjTe
	IpfIyUWqSXbsn9kYRcj1HYKmJl2BonHL9KEnG8rYq9OZS8c6mwwJaVjdLvHE9gYskclmDA
	2EQZM7oOc6u3NIOq21mucWkum/+jj0D9LldwNdhhx42pon1RA0PDgiQxqSNwhZKkqXo01v
	bB6h3b+FAWQMOVpcjY3YIwdDHDfjRawyj6FYlUd3niSfzzst32HBjc44X2Cjow==
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
Date: Thu, 28 May 2026 16:29:22 +0200
Message-ID: <20260528142924.329658-14-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260528142924.329658-1-sw@simonwunderlich.de>
References: <20260528142924.329658-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: SWV7FCBGG3REVEYGWVWPXRM4F7HSLE64
X-Message-ID-Hash: SWV7FCBGG3REVEYGWVWPXRM4F7HSLE64
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/SWV7FCBGG3REVEYGWVWPXRM4F7HSLE64/>
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

