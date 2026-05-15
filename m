Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81241CD4F47
	for <batman@archiver.kernel.org>; Fri, 15 May 2026 16:03:07 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id CBA6085AF5
	for <batman@archiver.kernel.org>; Fri, 15 May 2026 18:03:05 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1778860985;
 b=ejrPbUgSZqc72CupFQKzxCb76gn2rh/FEReWkPeO4gPDDmw/7gnDZMAX7+JBJSiV3b7q0
 UODcR/vkj3nx/S4wY3xSyq3qTTj+mWPw+I0TnTHEGwc5T0PeP5FoEXj8BUzy1OzHwf2ZrtY
 +DASG2vfLOZ85MjrUQiE5+L/ieXetmg=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1778860985; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=mvGI4X1jIj9swI/WmSEFN0ZYnQc4NYCnOiIFKVqawXQ=;
 b=dPoSczMXPTBPXwoRKtq2s3zIqxqxlpgA72yLz2kleHNAKeeBeWBksCrPuZQWDQnRCFDmC
 NBgf3IlqU5mnUsQeLJJI+ESC/8wZtqQaRnBL9DIUFV0SeMkPfFJk8UnNlXBXLiU9fYbC5gs
 3hvkU+2IDYCgumRQ2VaNk8vMyVX8/KI=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id C8B22855F9
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 15 May 2026 18:01:25 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1778860886;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=mvGI4X1jIj9swI/WmSEFN0ZYnQc4NYCnOiIFKVqawXQ=;
	b=mHoKEm2Z3JwJ74+aOszUbqlx92YtiBQcejzzCvk6mxySXvjlqkmNGr42oKNU8r3TKw6eu4
	fuvdw+7hsblxJasXKWJFtx6ms5lTz69OS9qol9DkKBUOxAKscDzav+BNNb6uZZ2gALS6jN
	/5tJO1+Wd++t6/+O7FzxNnBDyV3KfgQ=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=eDsPmc2C;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1778860886;
	b=C2+fpcQFsl50R4LX3uVYgC0kbgFYZCygPqU7A3YuXvaqN4/0hV7wblrEZLo+k5epKRan/Q
	DLAES/xHwgzLFIXlBSR/JPuRs2OL3uihSVM6ZRCarN/T7k+2IwlIcZOnP0TM0cg1tG+gSZ
	FIRR84+DMyFEOP6Yo1F4ak1mQGFVkF8=
Received: by dvalin.narfation.org (Postfix) id B81DF1FD98;
	Fri, 15 May 2026 16:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1778860883;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mvGI4X1jIj9swI/WmSEFN0ZYnQc4NYCnOiIFKVqawXQ=;
	b=eDsPmc2C0gOeByR7s6g3y3WDwk65L1VDglCjlSYZVAW97wJo7232MQmeZnVJ4FrcidQiZ6
	qDLgw1dTp9MsHjCwg1dApi6eRiEY7BSen9WVom+auaF9tm/nVmlCFVkJH11s77ZSWvdKiE
	ahH4Om1EE31gbJi8bmElhfENlzdoyxw=
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 15 May 2026 18:00:11 +0200
Subject: [PATCH batadv v3 2/4] batman-adv: tvlv: reject oversized TVLV
 packets
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260515-yuantan098-bugfixes-v3-2-5a5a91924562@narfation.org>
References: <20260515-yuantan098-bugfixes-v3-0-5a5a91924562@narfation.org>
In-Reply-To: <20260515-yuantan098-bugfixes-v3-0-5a5a91924562@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Yuan Tan <yuantan098@gmail.com>, Sven Eckelmann <sven@narfation.org>,
 stable@kernel.org, Yifan Wu <yifanwucs@gmail.com>,
 Juefei Pu <tomapufckgml@gmail.com>, Xin Liu <bird@lzu.edu.cn>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2727; i=sven@narfation.org;
 h=from:subject:message-id; bh=xLChZbjqsdUiIYscN5iIgg4JY6vpZc8UvM5gzsAWNHw=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFnszuZNWc+Tu52aWDsTtrGv992mt/pf97yQFyx1X/Ne6
 z2uKD/VUcrCIMbFICumyLLnSv75zexv5T9P+3gUZg4rE8gQBi5OAZjIhH2MDNPTfn54zj75zAaW
 jWssJfZPX+ZYJrMqciu3LyvPpnvKZy0YGboknP8c+nHr+Z9nYmcLPQ786xYInWS3f77o5llKuXL
 cS5gA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: SUHWBYL6VZED3NO56J2LUDGC43J35FLO
X-Message-ID-Hash: SUHWBYL6VZED3NO56J2LUDGC43J35FLO
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/SUHWBYL6VZED3NO56J2LUDGC43J35FLO/>
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
Reviewed-by: Yuan Tan <yuantan098@gmail.com>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/tvlv.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/net/batman-adv/tvlv.c b/net/batman-adv/tvlv.c
index 8129a3f9..4e2a9ec7 100644
--- a/net/batman-adv/tvlv.c
+++ b/net/batman-adv/tvlv.c
@@ -12,6 +12,7 @@
 #include <linux/gfp.h>
 #include <linux/if_ether.h>
 #include <linux/kref.h>
+#include <linux/limits.h>
 #include <linux/list.h>
 #include <linux/lockdep.h>
 #include <linux/netdevice.h>
@@ -159,10 +160,10 @@ batadv_tvlv_container_get(struct batadv_priv *bat_priv, u8 type, u8 version)
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
 
@@ -314,12 +315,14 @@ u16 batadv_tvlv_container_ogm_append(struct batadv_priv *bat_priv,
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

