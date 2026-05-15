Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BA10CD343F
	for <batman@archiver.kernel.org>; Fri, 15 May 2026 09:57:00 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id B4B2A85AF9
	for <batman@archiver.kernel.org>; Fri, 15 May 2026 11:56:58 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1778839018;
 b=cDBtEWSvqp+HypYnaEmSYPa34QdhktClzwDugI80ixaX3btjm1RtXDrwFhSsGcObkLAma
 AEuugE5pvtPIfYHMp5eQnyha0IBnnt413zfO3sp2HOfBIFePNh/6lLmF7i/YoXA0Ojm44sQ
 y8ggR95JpBapmwphVCNDpXTXa6Yx3gk=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1778839018; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=5vHw8qJWEIvBilfY5fBWVPvS5Ezs8Kaj2eIYWlXyjaw=;
 b=qAZPxiHeZCqyNv+4fnpwvuCf0VGTnwHMAsEFyNGt2byJo5I08CtpQTE5jr9JH+RuIitLZ
 l72i9qeI7G+4Tw8D0Qgtq4DTy1b/GmamR1rIWP4A0wzxHB/imOj2QqThsaNfvwj7jVt1eGR
 MVeSCkWzqLbNxX9+AXsjDbrhiS72unE=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de
 [IPv6:2a01:4f8:c17:e8c0::1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id DD03A81FDC
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 15 May 2026 11:55:50 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1778838951;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=5vHw8qJWEIvBilfY5fBWVPvS5Ezs8Kaj2eIYWlXyjaw=;
	b=DApws4maIyWOaiQaK/10oZb6QCtl9aOJUDrrQeF76zVSPHFma5d8qpWtYCVxSku+zk8sBk
	f5HaXxWZpmi10f5EVRXbbcgXs9NL2yTPz9wPxFUgVjrc5Ekb0xtas9Ls/VJS7DZdPy9YfV
	4/3hpuGWLadWq5jJWVjSMJ15I3iYPaU=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=V01Z0WQM;
	dmarc=pass (policy=none) header.from=simonwunderlich.de;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 2a01:4f8:c17:e8c0::1 as permitted sender) smtp.mailfrom=sw@simonwunderlich.de
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1778838951;
	b=GiEfbOV8VdFYMg6hkfXJGgsVVDgiIGJBPZkF0PFe1eWbGUmcr1zYM26sN6MtZV+4f2LDYO
	qsms34M+s8mbjGeZWqWUf2z0W7NFjyJLMcTuO7BzLUGuVexVhF8u3ZEOHM5TNngkREuV3p
	394JvXE5pa2fiOXD4iJoN37ZFikW5dw=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1778838949;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5vHw8qJWEIvBilfY5fBWVPvS5Ezs8Kaj2eIYWlXyjaw=;
	b=V01Z0WQMZR6jNOF1A9Ewe9eDDyqrr14hrivvqZKqu6LlMwhC3AqUmjHB2yXRGPanhotjCu
	66pmmFGXzg7Q1neib2JTWsz46uVSquplZFvM/LRbD/U/T6z/ye0nzngtGhNFihKweDwgz6
	KUK+GV6BM/cOhwWGpzjkztrar6Fih1PQsIzKYHO5+/M/LwBSsJyGQ4fuyTgrl4adKlQR//
	bv74AxTINZYpEpNoyvQN/i9n2U2BcHJATyxEPv0W+/h3NHECCvijcTi3Xnu/vP74cYYX9l
	FxJmBuaQ2zNuzO7ZN5ZWcQ/RvZ35ov+HBblssyE4/IJIEfogUwuAuds0wS1rNA==
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
Subject: [PATCH net 03/14] batman-adv: tt: reject oversized local TVLV buffers
Date: Fri, 15 May 2026 11:55:28 +0200
Message-ID: <20260515095540.325586-4-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260515095540.325586-1-sw@simonwunderlich.de>
References: <20260515095540.325586-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: TQFLBQDMK3UJDKDYZ2R4LPJDMY5XNWD5
X-Message-ID-Hash: TQFLBQDMK3UJDKDYZ2R4LPJDMY5XNWD5
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/TQFLBQDMK3UJDKDYZ2R4LPJDMY5XNWD5/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Sven Eckelmann <sven@narfation.org>

The commit 3a359bf5c61d ("batman-adv: reject oversized global TT response
buffers") added a check to ensure that a global return buffer size can be
stored in an u16. The same buffer handling also exists for the local data
buffer but was not touched.

A similar check should be also be in place for the local TVLV buffer. It
doesn't have the similar attack surface because it is only generated from
locally discovered MAC addresses but the dynamic nature could still cause
temporarily to large buffers.

Cc: stable@kernel.org
Fixes: 7ea7b4a14275 ("batman-adv: make the TT CRC logic VLAN specific")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/translation-table.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 05cddcf994f65..06548dae1039d 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -877,12 +877,12 @@ batadv_tt_prepare_tvlv_local_data(struct batadv_priv *bat_priv,
 {
 	struct batadv_tvlv_tt_vlan_data *tt_vlan;
 	struct batadv_meshif_vlan *vlan;
+	size_t change_offset;
 	u16 num_vlan = 0;
 	u16 vlan_entries = 0;
 	u16 total_entries = 0;
 	u16 tvlv_len;
 	u8 *tt_change_ptr;
-	int change_offset;
 
 	spin_lock_bh(&bat_priv->meshif_vlan_list_lock);
 	hlist_for_each_entry(vlan, &bat_priv->meshif_vlan_list, list) {
@@ -900,8 +900,10 @@ batadv_tt_prepare_tvlv_local_data(struct batadv_priv *bat_priv,
 	if (*tt_len < 0)
 		*tt_len = batadv_tt_len(total_entries);
 
-	tvlv_len = *tt_len;
-	tvlv_len += change_offset;
+	if (check_add_overflow(*tt_len, change_offset, &tvlv_len)) {
+		tvlv_len = 0;
+		goto out;
+	}
 
 	*tt_data = kmalloc(tvlv_len, GFP_ATOMIC);
 	if (!*tt_data) {
-- 
2.47.3

