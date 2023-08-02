Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC851C00528
	for <batman-adv@archiver.kernel.org>; Wed,  2 Aug 2023 10:01:42 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 497028321E
	for <batman-adv@archiver.kernel.org>; Wed,  2 Aug 2023 12:01:41 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1690970501;
 b=sR6nNUPU+CgdA8yLhkGGSmgJfivNlX8f05HUPy958RWkAYY5FmDFoVLW5ffRY6sV10dBI
 A4eS12cykRH9DxFbNr3FYANr9NFtJ1gIrVumh04tgfH0rvRDFVViN/H2HEfZNYgt95bXo9S
 k4nXwFQkVISLdvdaX3JGQfAhEZb1fpI=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1690970501; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=PyWEl2ADGOEIH8PHWY9Wo65xHZhjP9kWt9AxXpKxeqM=;
 b=2fviRrLEc3vVsX77Gz97bh8t6TA/dWhKDwCdSUWLxdn3qRMVslbJonqLxab4enFs+EKCW
 z5ek2vHZoEW/Yv6JzKa7OnTlHODexsZdc9r62Y4HXOt2LfjrAYcG7aUo3uo5rJO8ntW/IVd
 jgp7/qdeV4wHcqI3+ndmBnNTUtI+6Hs=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=narfation.org
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 7F45482DD5
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed,  2 Aug 2023 12:00:31 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1690970431;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=PyWEl2ADGOEIH8PHWY9Wo65xHZhjP9kWt9AxXpKxeqM=;
	b=tW6hMXxVpuncIHlxyclNkElbeydfyx0xLJb9xjoxI4BkuCtE2mJ+St5NAkOG3TnHJfns8I
	KjHISvrn+0kcTkcCtWuun4Wjp8dvxEf9yHYcUlcLhigOe5E30Ejo9JL+noMiN0pSVdnH6y
	+yVCCUPrHI2fRDblwndDd9r4/wX4yDM=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=snttJk1q;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1690970431; a=rsa-sha256;
	cv=none;
	b=dHbAEOPkE8aOgjRDOakhNlftl5yUlGu8adXpdIajBxHNTzY7VU8IIfjz2SwTGLV8xyJv2w
	8XQvjM0hvByH9bppPISc4rUORr3mStTOvdEThGfDAxCsZa4BcBsy9M4TiYiANPP+VT7KWu
	LL/nt6Kcmssf+DiA8n0SEU7eCtEtqI8=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1690970431;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PyWEl2ADGOEIH8PHWY9Wo65xHZhjP9kWt9AxXpKxeqM=;
	b=snttJk1qDD8WcSGhfef2zc+SiVqM6BZ/tlXRA3lUoIuZ4vYOI3ulbABIjSGIvCdkgOpsri
	x91VhmgNkVcHJbw4fAvdFXMHTQbpejdjjzSSw6xq9gQ2swdsXIN/QbS2rByTU+SfQi8mQD
	uE7DxTr1jl0HopyNQ2LrCvLBzMlu6+Y=
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 02 Aug 2023 12:00:22 +0200
Subject: [PATCH 1/3] batman-adv: Drop unused function
 batadv_gw_bandwidth_set
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230802-cleanup_functions-v1-1-1f9bfb914696@narfation.org>
References: <20230802-cleanup_functions-v1-0-1f9bfb914696@narfation.org>
In-Reply-To: <20230802-cleanup_functions-v1-0-1f9bfb914696@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4280; i=sven@narfation.org;
 h=from:subject:message-id; bh=l36GwvJf8OgASoa+NCqB/ZVAhdTUEmOX3JiSaPzAU+4=;
 b=owEBbQKS/ZANAwAKAV2HCgfBJntGAcsmYgBkyik3qhHeaxYQPgRuNRS/COU9fYFymUkVJubTB
 oUfWjY8M76JAjMEAAEKAB0WIQQXXSuHYSVz3OMy4AJdhwoHwSZ7RgUCZMopNwAKCRBdhwoHwSZ7
 Rvr2D/94Ix6IB/oPdXWSOoB+J6W/S4At4rwK/cLWb7BDN1qnOtv9Dey7PngwA1mtHdAiEE8PT03
 8VA3jU9w3pS3loD7ia9N8WUGA8bQzEkOvaMAOibPArdGf8uFakZvpHtd000cUlbptWHJ5Gm41N4
 cT/evP/Onai3IEQ34n7+jpaqmjMz+GVaXy9DbH0lu7hIN3OFojNa03VVbossjh9slPkJS5r07Pb
 dOp4eyLzGp9S1RsSnkXaMNmBg5U9ZhMpuj7EQ3ZiDTMWrI2Ba4ZnU6wdHCtIiWYTbYQ2+lyI3En
 p/jFxKtUu4B2CTKQXJvhG9Oxl2j6nwWq0P05dvRQrpazVaub6DJ8uypapwM7jVNjg6+fzOq/hwv
 xEf+YvXuOXCPYd6VgEsCoFOg6+YG55R97kEk5QEcT0vpLsZxqEBfCplcxDomBgZ7yoLQC6vb/uu
 ErKG769eEtyH6ltzKa+18k9pQy7QfdMa9KYxqcF2Yrcq3VEeCsRa39/xTTFZ0EFaa1OGRj3cVOr
 hPCsAV2gEy49SOpwAGauMI+e7Csgk02Z6VNbUoz6q1fhFgfcP080EvmsBLYqhte0U7nD4UXmf2Q
 rT7tx/fsdK63avNE3ewZp37PbO8bMGy0c2SKkKznlzX9BYQ4nrSpP9k9eUxEEzxsYJdMHdemnVu
 K0tVBBMlcdbkjiA==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: 6R27IZHL3VVHODHWJGVYOBEKXS2ROJSY
X-Message-ID-Hash: 6R27IZHL3VVHODHWJGVYOBEKXS2ROJSY
X-MailFrom: sven@narfation.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/6R27IZHL3VVHODHWJGVYOBEKXS2ROJSY/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

This function is no longer used since the sysfs support was removed from
batman-adv.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/gateway_common.c | 88 -----------------------------------------
 net/batman-adv/gateway_common.h |  2 -
 2 files changed, 90 deletions(-)

diff --git a/net/batman-adv/gateway_common.c b/net/batman-adv/gateway_common.c
index 6a964a77..d9632607 100644
--- a/net/batman-adv/gateway_common.c
+++ b/net/batman-adv/gateway_common.c
@@ -9,7 +9,6 @@
 
 #include <linux/atomic.h>
 #include <linux/byteorder/generic.h>
-#include <linux/errno.h>
 #include <linux/kstrtox.h>
 #include <linux/limits.h>
 #include <linux/math64.h>
@@ -90,42 +89,6 @@ bool batadv_parse_throughput(struct net_device *net_dev, char *buff,
 	return true;
 }
 
-/**
- * batadv_parse_gw_bandwidth() - parse supplied string buffer to extract
- *  download and upload bandwidth information
- * @net_dev: the soft interface net device
- * @buff: string buffer to parse
- * @down: pointer holding the returned download bandwidth information
- * @up: pointer holding the returned upload bandwidth information
- *
- * Return: false on parse error and true otherwise.
- */
-static bool batadv_parse_gw_bandwidth(struct net_device *net_dev, char *buff,
-				      u32 *down, u32 *up)
-{
-	char *slash_ptr;
-	bool ret;
-
-	slash_ptr = strchr(buff, '/');
-	if (slash_ptr)
-		*slash_ptr = 0;
-
-	ret = batadv_parse_throughput(net_dev, buff, "download gateway speed",
-				      down);
-	if (!ret)
-		return false;
-
-	/* we also got some upload info */
-	if (slash_ptr) {
-		ret = batadv_parse_throughput(net_dev, slash_ptr + 1,
-					      "upload gateway speed", up);
-		if (!ret)
-			return false;
-	}
-
-	return true;
-}
-
 /**
  * batadv_gw_tvlv_container_update() - update the gw tvlv container after
  *  gateway setting change
@@ -155,57 +118,6 @@ void batadv_gw_tvlv_container_update(struct batadv_priv *bat_priv)
 	}
 }
 
-/**
- * batadv_gw_bandwidth_set() - Parse and set download/upload gateway bandwidth
- *  from supplied string buffer
- * @net_dev: netdev struct of the soft interface
- * @buff: the buffer containing the user data
- * @count: number of bytes in the buffer
- *
- * Return: 'count' on success or a negative error code in case of failure
- */
-ssize_t batadv_gw_bandwidth_set(struct net_device *net_dev, char *buff,
-				size_t count)
-{
-	struct batadv_priv *bat_priv = netdev_priv(net_dev);
-	u32 down_curr;
-	u32 up_curr;
-	u32 down_new = 0;
-	u32 up_new = 0;
-	bool ret;
-
-	down_curr = (unsigned int)atomic_read(&bat_priv->gw.bandwidth_down);
-	up_curr = (unsigned int)atomic_read(&bat_priv->gw.bandwidth_up);
-
-	ret = batadv_parse_gw_bandwidth(net_dev, buff, &down_new, &up_new);
-	if (!ret)
-		return -EINVAL;
-
-	if (!down_new)
-		down_new = 1;
-
-	if (!up_new)
-		up_new = down_new / 5;
-
-	if (!up_new)
-		up_new = 1;
-
-	if (down_curr == down_new && up_curr == up_new)
-		return count;
-
-	batadv_gw_reselect(bat_priv);
-	batadv_info(net_dev,
-		    "Changing gateway bandwidth from: '%u.%u/%u.%u MBit' to: '%u.%u/%u.%u MBit'\n",
-		    down_curr / 10, down_curr % 10, up_curr / 10, up_curr % 10,
-		    down_new / 10, down_new % 10, up_new / 10, up_new % 10);
-
-	atomic_set(&bat_priv->gw.bandwidth_down, down_new);
-	atomic_set(&bat_priv->gw.bandwidth_up, up_new);
-	batadv_gw_tvlv_container_update(bat_priv);
-
-	return count;
-}
-
 /**
  * batadv_gw_tvlv_ogm_handler_v1() - process incoming gateway tvlv container
  * @bat_priv: the bat priv with all the soft interface information
diff --git a/net/batman-adv/gateway_common.h b/net/batman-adv/gateway_common.h
index 87c37f90..cb2e72d7 100644
--- a/net/batman-adv/gateway_common.h
+++ b/net/batman-adv/gateway_common.h
@@ -27,8 +27,6 @@ enum batadv_bandwidth_units {
 #define BATADV_GW_MODE_CLIENT_NAME	"client"
 #define BATADV_GW_MODE_SERVER_NAME	"server"
 
-ssize_t batadv_gw_bandwidth_set(struct net_device *net_dev, char *buff,
-				size_t count);
 void batadv_gw_tvlv_container_update(struct batadv_priv *bat_priv);
 void batadv_gw_init(struct batadv_priv *bat_priv);
 void batadv_gw_free(struct batadv_priv *bat_priv);

-- 
2.39.2

