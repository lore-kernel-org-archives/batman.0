Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E426CD37BE
	for <batman@archiver.kernel.org>; Mon, 11 May 2026 17:33:47 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id C3E9C85D40
	for <batman@archiver.kernel.org>; Mon, 11 May 2026 19:33:45 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1778520825;
 b=nQ6QwbRTop3ot5BQv6luev1tXikJsLUCyllgELLPzi+YUnTioFL7WXwNmsA0FJSVdDluc
 36DrAtUNK8rR826Cb+uo6cpucqtQIl80GUafVEuc4cPVN5cg3FSjYkobIMtA75hNN194cTF
 4N4OI0nu2vQKR43NLlP0DzTDgL49C74=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1778520825; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=kXJdvG/Cvglft5gqBzEH4twv5RHfSjMGn2vCVhMHxck=;
 b=aYU/gUzhaZoCzPockl+MRc2+/QATZYrLZwnAcGZkuwI8i0MAN3DrUEDmT9TTJ/QSQxKX/
 vjbFsS96yoMsHtUEXu8fe8HeHwopgMV0dzs9z0o4+6i6A75VFOkoHzriKKzy0ZTM6XYDgqQ
 NsmLzqR7qUbFHWS+7BWzCG6uznMQ+20=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 2890D85A89
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 11 May 2026 19:30:18 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1778520618;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=kXJdvG/Cvglft5gqBzEH4twv5RHfSjMGn2vCVhMHxck=;
	b=vXaSVjaUzVG5UMFBEKqw30lQBoSnFfXFogEAYW9KKniCDNQslWJJyXF8jpNW7t8iQXngBg
	tB9YJEZU3YTXLdnRpSfxT+SvhW8x/HO7CAFIOLg5Igu2UQOeURp1b6952m+fmZX6pOTgXC
	evzMtVhQmF9nqIGs7p9np4n7uHBgzzw=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=xfohePqd;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1778520618;
	b=lhjcMWV7AVAVK+IIhQIU+eFyQvS/JdCkH7eI5CDGF3hyYyWwy0qOYLRVAQMiA4E6Yf3RGS
	qLtujtVJP+iP2iuTgayCiHt3xM+df4Gb7EBqpaFjNZ7qB4D5rmxRnsbLUrC/BETemEblaw
	Eua+lECobN7wV0xAs34ySOajbg2vAwc=
Received: by dvalin.narfation.org (Postfix) id B214A1FFD9;
	Mon, 11 May 2026 17:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1778520617;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kXJdvG/Cvglft5gqBzEH4twv5RHfSjMGn2vCVhMHxck=;
	b=xfohePqdP2Z4vPh+jiXILSScMCIaKgzHh87XXGjphzuzGREan2n0xxZWADG7/zCfU4hQS1
	JdzeaxLPvIv/zeu+p6ttkkdpT02Awwf53LRpe2gN8y7tNUxRdCYlFTohS5msf9w9lVjdt6
	nJyXNWtn7eUAvz3qWIz7MTM6+nmI0Ec=
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 11 May 2026 19:30:02 +0200
Subject: [PATCH batadv 4/5] batman-adv: tvlv: reject oversized TVLV packets
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260511-yuantan098-bugfixes-v1-4-6adf6965f2b3@narfation.org>
References: <20260511-yuantan098-bugfixes-v1-0-6adf6965f2b3@narfation.org>
In-Reply-To: <20260511-yuantan098-bugfixes-v1-0-6adf6965f2b3@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Yuan Tan <yuantan098@gmail.com>, Sven Eckelmann <sven@narfation.org>,
 stable@kernel.org, Yifan Wu <yifanwucs@gmail.com>,
 Juefei Pu <tomapufckgml@gmail.com>, Xin Liu <bird@lzu.edu.cn>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2681; i=sven@narfation.org;
 h=from:subject:message-id; bh=733yn4sorp59gcJF0qsKQld0NbE/UBHmOraDoFC2OLQ=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFlMQtLHO7evULO3+R29V7Q1J2Ter8OrZ6SJW3LMkeX1F
 Lw0pZOvo5SFQYyLQVZMkWXPlfzzm9nfyn+e9vEozBxWJpAhDFycAjARowRGhkZ2qbIb5bPXJJxf
 XsI6a966rASlaVeZ102+0O9Z9kLR/yQjw8Vtn7/uDEtwmJEqdvb3uS/m8VcubU/s//klI1o9y0N
 IkAMA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: V7M6BDB6AHKIZXSUC5OSSWWI5V4ZWBQR
X-Message-ID-Hash: V7M6BDB6AHKIZXSUC5OSSWWI5V4ZWBQR
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/V7M6BDB6AHKIZXSUC5OSSWWI5V4ZWBQR/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

batadv_tvlv_container_ogm_append() builds a TVLV packet section from
the tvlv.container_list. The total size of this section is computed by
batadv_tvlv_container_list_size(), which sums the sizes of all registered
containers.

The return type and accumulator in batadv_tvlv_container_list_size() were
u16. If the accumulated size exceeds U16_MAX, the value wraps around,
causing the subsequent allocation in batadv_tvlv_container_ogm_append()
to be undersized. The memcpy-style copy that follows would then write
beyond the end of the allocated buffer, corrupting kernel memory.

Fix this by widening the return type of batadv_tvlv_container_list_size()
to size_t. In batadv_tvlv_container_ogm_append(), check the computed length
against U16_MAX before proceeding, and bail out as if the allocation had
failed when the limit is exceeded.

Cc: stable@kernel.org
Fixes: ef26157747d4 ("batman-adv: tvlv - basic infrastructure")
Reported-by: Yuan Tan <yuantan098@gmail.com>
Reported-by: Yifan Wu <yifanwucs@gmail.com>
Reported-by: Juefei Pu <tomapufckgml@gmail.com>
Reported-by: Xin Liu <bird@lzu.edu.cn>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/tvlv.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/net/batman-adv/tvlv.c b/net/batman-adv/tvlv.c
index 328636c4..278007e8 100644
--- a/net/batman-adv/tvlv.c
+++ b/net/batman-adv/tvlv.c
@@ -13,6 +13,7 @@
 #include <linux/gfp.h>
 #include <linux/if_ether.h>
 #include <linux/kref.h>
+#include <linux/limits.h>
 #include <linux/list.h>
 #include <linux/lockdep.h>
 #include <linux/netdevice.h>
@@ -160,10 +161,10 @@ batadv_tvlv_container_get(struct batadv_priv *bat_priv, u8 type, u8 version)
  *
  * Return: size of all currently registered tvlv containers in bytes.
  */
-static u16 batadv_tvlv_container_list_size(struct batadv_priv *bat_priv)
+static size_t batadv_tvlv_container_list_size(struct batadv_priv *bat_priv)
 {
 	struct batadv_tvlv_container *tvlv;
-	u16 tvlv_len = 0;
+	size_t tvlv_len = 0;
 
 	lockdep_assert_held(&bat_priv->tvlv.container_list_lock);
 
@@ -315,12 +316,14 @@ u16 batadv_tvlv_container_ogm_append(struct batadv_priv *bat_priv,
 {
 	struct batadv_tvlv_container *tvlv;
 	struct batadv_tvlv_hdr *tvlv_hdr;
-	u16 tvlv_value_len;
+	size_t tvlv_value_len;
 	void *tvlv_value;
 	bool ret;
 
 	spin_lock_bh(&bat_priv->tvlv.container_list_lock);
 	tvlv_value_len = batadv_tvlv_container_list_size(bat_priv);
+	if (tvlv_value_len > U16_MAX)
+		goto end;
 
 	ret = batadv_tvlv_realloc_packet_buff(packet_buff, packet_buff_len,
 					      packet_min_len, tvlv_value_len);

-- 
2.47.3

