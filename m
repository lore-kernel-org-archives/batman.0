Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5C0ACD3426
	for <batman@archiver.kernel.org>; Sun,  3 May 2026 12:28:04 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 6F6FE85B3B
	for <batman@archiver.kernel.org>; Sun, 03 May 2026 14:28:03 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1777811283;
 b=ZkLlE4CRTzfcw94HdhnMJ0UuQ/4AR56AGVsrNnzmaI6aNtN/sI9O/WR+vZkrA9Ic7vz6g
 oS++b5Dwcrpcz56sndvDjgxwuTMAdb4TWwP7F4pWrKCfngBzkayNNVTCOFdDdue5ihMePzK
 Yje20p25vm00GmiwB9fzHklxH0bV0lM=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1777811283; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=hSyX5MT+xkx/hCaIOWcjkKX9ZFfOmihuKJssQ1j3tks=;
 b=ql+ncj8F3Y2KhPQplEbJNnAuAL1c9MXucOlCQ4S4XZJwNJoNplsotR7/f5lTrqTRiHRJ8
 JhViPCO+JnNVSfDjpCBWnWJemEdkuzkwWDL/46yDc+KNqM3Tmr9dkIomNEnuz6ugAWb3QtJ
 4bkhH0PzLnkKn2bJ39p7Dr7ewYHRIAA=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id C38298565E
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 03 May 2026 14:23:29 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1777811009;
	b=zIyplYQQOkTtZKUxj+sVrPPnHl9m4hhlaf9d2m0+utY41cuKv5Iqu7ipLiOBdLxgBbPgy0
	mWwxc2un9dNv7LQSGqPwqg00GvnPv+sx68r84kyPXm/2JKrtKgXYIwlK/m7RrlzSRys8xj
	3ljkpfRGEB2qj/QNhH6unikDWIDCGgE=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b="xr/hJnZN";
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1777811009;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=hSyX5MT+xkx/hCaIOWcjkKX9ZFfOmihuKJssQ1j3tks=;
	b=LtogW0AjG9Y1pCuAiCfO1zj2g3Jpk5qgm8bl82gN9weBC/255EUl/Kh16P/ghKMYEU4Gc6
	GZVJsH/b1qjhKdncLmoJV7iyvLOLnOZFG+BGLWRLXCySuQziDtWtfK6v/2SD/0auOlGi+v
	guDV/iSP+av0fkDAGA8sHi6V3oDB8Ts=
Received: by dvalin.narfation.org (Postfix) id 406FE20D39;
	Sun, 03 May 2026 12:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1777811009;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hSyX5MT+xkx/hCaIOWcjkKX9ZFfOmihuKJssQ1j3tks=;
	b=xr/hJnZNQ2+6FAuEXL7UOsZ/deQGwk4U4YyaCSkuAJlHGL7c0GgnlSsOq+bOpTluzW7x+r
	qXQeKodZiHUjPae7uIUENdfVUcqatilXfKElSyDryUFuuO6+Ll2Ufhq0TioefrEw8ojJmI
	YQwaHNXVfw9aOA17KqWj2665uzLCQxA=
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 03 May 2026 14:22:38 +0200
Subject: [PATCH batadv 5/8] batman-adv: tt: reject oversized local TVLV
 buffers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260503-fixes-followup-v1-5-4313278918d3@narfation.org>
References: <20260503-fixes-followup-v1-0-4313278918d3@narfation.org>
In-Reply-To: <20260503-fixes-followup-v1-0-4313278918d3@narfation.org>
To: Marek Lindner <marek.lindner@mailbox.org>,
 Simon Wunderlich <sw@simonwunderlich.de>,
 Antonio Quartulli <antonio@mandelbit.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Ao Zhou <n05ec@lzu.edu.cn>,
 Haoze Xie <royenheart@gmail.com>, Jiexun Wang <wangjiexun2025@gmail.com>,
 Juefei Pu <tomapufckgml@gmail.com>, Luxing Yin <tr0jan@lzu.edu.cn>,
 Ren Wei <n05ec@lzu.edu.cn>, Ruide Cao <caoruide123@gmail.com>,
 Xin Liu <bird@lzu.edu.cn>, Yifan Wu <yifanwucs@gmail.com>,
 Yuan Tan <yuantan098@gmail.com>, Sven Eckelmann <sven@narfation.org>,
 stable@kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1820; i=sven@narfation.org;
 h=from:subject:message-id; bh=l+L76yAQhUzV6/M374uvOPJNw5UvXliEJ0luu1nNMwU=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDJnf7WQzwh+sjpy778ST2Yvfx/+fPulkK0t0+5EYxSWnX
 okEvQu61FHKwiDGxSArpsiy50r++c3sb+U/T/t4FGYOKxPIEAYuTgGYiPR9hn+2vWvEuLavexey
 wFRu7uZr0tprzJad2iTzQvm5dS5n5lYPhv+ub0Ki6yzENn0KK/rVJ/9b17ooVLNCTPH6gRb9hkk
 JSmwA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
X-MailFrom: sven@narfation.org
X-Mailman-Rule-Hits: max-recipients
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-3; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-size;
 news-moderation; no-subject; digests; suspicious-header
Message-ID-Hash: QAZUOLXPL6QYVGMZWCEYNVQUPGSKS32I
X-Message-ID-Hash: QAZUOLXPL6QYVGMZWCEYNVQUPGSKS32I
X-Mailman-Approved-At: Sun, 03 May 2026 14:24:15 +0200
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/QAZUOLXPL6QYVGMZWCEYNVQUPGSKS32I/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

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
---
 net/batman-adv/translation-table.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 05cddcf994f6..06548dae1039 100644
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

