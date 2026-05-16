Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2393ECD4F25
	for <batman-adv@archiver.kernel.org>; Sat, 16 May 2026 07:15:16 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 41C50854EE
	for <batman-adv@archiver.kernel.org>; Sat, 16 May 2026 09:15:15 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1778915715;
 b=Vg8uIU1HDe4YYZ7sjCP5Zj7jxhVpaFCuNGIwdDX1Lq/bQ+HkI4kqLs48VeKTHalHImf1D
 mr6/YsYG3SU0ojJXG+1m6GllJ2w2eIIzwE7T2fzWsfCEgCzTPxbeDJ0XruiskNnj28K6iy/
 vGkWcw8Lg/1UC/nPlJEL4hgKFh9l11A=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1778915715; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=TL4xqoJAcgrk21GcH6aBpgQyahiJNxWg6DmghVkCTds=;
 b=qeZ8Qe2ff/tHquHfcoWtBKRaGHYT5fjJrI8XcqfjwfrMpy0xUi+DKggAHTIBaS57PDW6S
 /4fDlZeQgxuWryUYdSwHPUJimq56lkRJfBMsU1NC36bN2uCBmZX3iv7OHZ2PkbE/ulfohpd
 UspBEem0DbqIKb/cuId+fHyDzQngOp0=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 880E984A7F
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sat, 16 May 2026 09:15:10 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1778915710;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=TL4xqoJAcgrk21GcH6aBpgQyahiJNxWg6DmghVkCTds=;
	b=V6B5EqYJv6+ItufBkH33OGSi/knwKwq6wdgvYDDBUA7DrhZQUW7+MCq28YqneY2wCpgF6Y
	hRkIiHGVOelWEq0r1/pT9QBuIf0W4i2AAZ+U+xHjJL+N7w7qQrCdJHtTydC73lTGpbkz1i
	bWyo1T0kDyqxCI5tXCpkJr4hD15/S/k=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=iV54Gs11;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1778915710;
	b=V4RdsUKHZDVvckyv+dnTdEF2odLfcvtI/AkwRdlsMzFd731mKg/sjA8XQIh6bAYofAF1yi
	1y20fxrS/BzwiFV4++FbsTbTyMXFEBWmm1Z1vDHQpxXVRsfX+sqEVo5TgQVxAtxvOd6YLr
	6qEcYZwx/q+cJuf/ZGFu2Zt+EqAk75U=
Received: by dvalin.narfation.org (Postfix) id E54F921EB8
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sat, 16 May 2026 07:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1778915710;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TL4xqoJAcgrk21GcH6aBpgQyahiJNxWg6DmghVkCTds=;
	b=iV54Gs11jXEMMNNRQI6DbgrrxjX7K79N0l4P7/Rqx5XocWMpF4dG1GlzbSdZdjq6yIyrNw
	yiQN5lOqAzfPeYyOgB8xT+Q1pCEJ1B9TLHugezj5CYoqdjtGNZVV9nsLHuE/oFzd4G6EMr
	2jqcVHW2lA3Uq5tLl84MuskNH/fmdJE=
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 16 May 2026 09:14:58 +0200
Subject: [PATCH batadv v4 3/4] batman-adv: tvlv: reject oversized TVLV
 packets
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260516-yuantan098-bugfixes-v4-3-9b5743d147bd@narfation.org>
References: <20260516-yuantan098-bugfixes-v4-0-9b5743d147bd@narfation.org>
In-Reply-To: <20260516-yuantan098-bugfixes-v4-0-9b5743d147bd@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2785; i=sven@narfation.org;
 h=from:subject:message-id; bh=mwABAPNPuaQVWRtdMKKDwv5FugLUej6ZoxSvJQmg1lU=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFkckkV89TFWNXGfOsxalOR+sx72v7TqEQ9DN7dzokLY5
 9Wf7KZ1lLIwiHExyIopsuy5kn9+M/tb+c/TPh6FmcPKBDKEgYtTACZyZRcjwxXTPUyR5U6fPLT/
 ap5vTeBOPmXUcpFphtS9q/G196cHNzMyrMoqtZG3NjnxYfazTaqNPmoTHly12jctKelQoEuRcrg
 hGwA=
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: P65EMS2L5N75RJUXMMKYUNYQJLWLRHUZ
X-Message-ID-Hash: P65EMS2L5N75RJUXMMKYUNYQJLWLRHUZ
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/P65EMS2L5N75RJUXMMKYUNYQJLWLRHUZ/>
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
 net/batman-adv/tvlv.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/net/batman-adv/tvlv.c b/net/batman-adv/tvlv.c
index 46ed61db..cc6ac580 100644
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
 
@@ -316,13 +317,17 @@ int batadv_tvlv_container_ogm_append(struct batadv_priv *bat_priv,
 {
 	struct batadv_tvlv_container *tvlv;
 	struct batadv_tvlv_hdr *tvlv_hdr;
-	u16 tvlv_value_len;
+	size_t tvlv_value_len;
 	void *tvlv_value;
 	int tvlv_len_ret;
 	bool ret;
 
 	spin_lock_bh(&bat_priv->tvlv.container_list_lock);
 	tvlv_value_len = batadv_tvlv_container_list_size(bat_priv);
+	if (tvlv_value_len > U16_MAX) {
+		tvlv_len_ret = -E2BIG;
+		goto end;
+	}
 
 	ret = batadv_tvlv_realloc_packet_buff(packet_buff, packet_buff_len,
 					      packet_min_len, tvlv_value_len);

-- 
2.47.3

