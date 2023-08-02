Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB09AC001DF
	for <batman-adv@archiver.kernel.org>; Wed,  2 Aug 2023 10:03:02 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 508D7830D9
	for <batman-adv@archiver.kernel.org>; Wed,  2 Aug 2023 12:03:01 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1690970581;
 b=d0JT0Zw7fO0sZNy/f2qyNZ11w0Mp69fsP1m9K/itA4IUqszQblnENKbscXZW+zOss09M4
 h46Dt7aTm1HXow9Qywlne7HARWL6nn8sS0mEMa5yzrRg/3dA1fSEasEA9gxXfE6MBzz4/LU
 BkxrDRwkL7P8yGtBK5aDoVL+ZjAhEd0=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1690970581; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=2XSfUxLOFgQdChL2Fte7AAhyefhPKoz/VGDLjGIu/40=;
 b=hz0HjMskB+bPscVSMtg1LCU2admfTn8GkPSO6n0dpDZaXuGtq2UHRfUWayVg52y+dN4JF
 ncbcUp2cRXKnUS6SkU6ZqdjDUpsyXcFkjOXHscviTijrl4GfZPI24YFI0n1WBVZ1y5JA3YA
 7TkD0ZyxFZlxD99Ln6v2WwcQoya69HY=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=narfation.org
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 7050582EE4
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed,  2 Aug 2023 12:00:36 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1690970436;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=2XSfUxLOFgQdChL2Fte7AAhyefhPKoz/VGDLjGIu/40=;
	b=24WdVGzay1AtfRGdm17uA90uMQrm/wtNK6ktCYWxXG1HMHrf4seSOi1maxDy7mPUpcyuSf
	PCvFVBgKniy8iF3DRJ98wcV1DvlMtKnfOmjzHZI+Pah6yieI2n7dxypfQ7rOvzFf+iqbIh
	0DacBn4PebXmFCLUzYf3gT7A8sgJG9I=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=rYeChhcj;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1690970436; a=rsa-sha256;
	cv=none;
	b=uU+Bqi3qzJh5gfeYyBi54oqLTRBmzD5vHHCUQQk/FeJug8CjwO46eyhlvY2ME+ZU7CJBnK
	jKrVQB3LlycKpaiTWkryhbW+Z2/+W2b6cDKx7dj/wwLaScKnPsv7d9EH650kUtaavExSZ1
	+r8mQP7+n35IdXoZCUeY3QE+B4hz720=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1690970436;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2XSfUxLOFgQdChL2Fte7AAhyefhPKoz/VGDLjGIu/40=;
	b=rYeChhcjTh03aowSDsMSjFLegmKSldtt0yTb4OLba+apxB28crg5B0GMgsWDrWyU7UB/YS
	tHJ6QctcYvTEynKIjk4GrWuS9k0UiC2f4iVuOXhLpvmwfwwb8WY3tO8wmjl0X0uMSBlVaC
	3iXq2Rlr7Zxouq0FLEFzL0Ko0QTXh58=
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 02 Aug 2023 12:00:24 +0200
Subject: [PATCH 3/3] batman-adv: Drop per algo GW section class code
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230802-cleanup_functions-v1-3-1f9bfb914696@narfation.org>
References: <20230802-cleanup_functions-v1-0-1f9bfb914696@narfation.org>
In-Reply-To: <20230802-cleanup_functions-v1-0-1f9bfb914696@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=7631; i=sven@narfation.org;
 h=from:subject:message-id; bh=0XSIqEuEreAbkL1wMiVmJyRkmrHmcP1dUAT79fYG0tw=;
 b=owEBbQKS/ZANAwAKAV2HCgfBJntGAcsmYgBkyik4ilAg3yQEKJwNQfItBnreE4t2oQcOctiK+
 MgMAS0l/4yJAjMEAAEKAB0WIQQXXSuHYSVz3OMy4AJdhwoHwSZ7RgUCZMopOAAKCRBdhwoHwSZ7
 Rtf4EAC12Qu4uLaxl4nVdNhRNsAzQOCaluQikXgtcuRl6NtP/8JHrmhswYT6tW/3cKkyWFS03rb
 8AW83tSNDw3UuPtCu81u70O+ldU6RzllSpT9u2auTMoxEraAUpY3kw0LHt2az4+dxPxCwKq3osW
 YF2XIQsTPB3S5/t0QpHBH3vvXKF0lnqTiNucxjwMFt7ayEH5476UuU16QkiqA/cOeOeliaurCtf
 ppLxRxX7OYQn9ZMNev7xtptWpIUc/D85X4G8Gy8eaf78f8xIL/KKF96bZP814EM2SBiaeIIpnUs
 7lpK0/zznr/1ZZZ/Lxx+DgF6/+at1XqEQq5UvDMRTS+1jlcIuDkeBNCd9uleXTMx0WhPb1yhcxX
 mYk5zyvcaRFBmPDdcWGfPy4JGis4x7Qtar7VICMmteoanIWf88zS5/xBSZ5U90xWaDjyN7hdRXu
 cnV3Xt7JExGvIoPaTDZsfLGIl5af9QnPL6z3LQ5aTaW6oJHCSXDtOiuipDGDgg/zZ5WkICeW2LG
 Pzyw9uELPjf2DHB1vkVV24Cktcr1/i+XF1R29M0vPzOqYEwgRC6gtCVpUgGtRz2tV7x9PEopgET
 PReRENxr0Dif0Oi0T9W3tn80+uNXxf9TD0gAYA/eZfEt+oYsuD99kvjUH0jIWifFufAB9D3RMwT
 US7oZSeVsJP7weA==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: QOIRESJOXRAXPY33X772JFBYTCQF4VER
X-Message-ID-Hash: QOIRESJOXRAXPY33X772JFBYTCQF4VER
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/QOIRESJOXRAXPY33X772JFBYTCQF4VER/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

This code was  only used in the past for the sysfs interface. But since
this was replace with netlink, it was never executed. The function pointer
was only checked to figure out whether the limit 255 (B.A.T.M.A.N. IV) or
2**32-1 (B.A.T.M.A.N. V) should be used as limit.

So instead of keeping the function pointer, just store the limits directly
in struct batadv_algo_gw_ops.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/bat_iv_ogm.c     |  1 +
 net/batman-adv/bat_v.c          | 23 ++-----------
 net/batman-adv/gateway_common.c | 74 +----------------------------------------
 net/batman-adv/gateway_common.h |  5 ---
 net/batman-adv/netlink.c        |  5 +--
 net/batman-adv/types.h          |  7 ++--
 6 files changed, 8 insertions(+), 107 deletions(-)

diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index 828fb393..74b49c35 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -2516,6 +2516,7 @@ static struct batadv_algo_ops batadv_batman_iv __read_mostly = {
 	},
 	.gw = {
 		.init_sel_class = batadv_iv_init_sel_class,
+		.sel_class_max = BATADV_TQ_MAX_VALUE,
 		.get_best_gw_node = batadv_iv_gw_get_best_gw_node,
 		.is_eligible = batadv_iv_gw_is_eligible,
 		.dump = batadv_iv_gw_dump,
diff --git a/net/batman-adv/bat_v.c b/net/batman-adv/bat_v.c
index 54e41fc7..ac11f1f0 100644
--- a/net/batman-adv/bat_v.c
+++ b/net/batman-adv/bat_v.c
@@ -14,6 +14,7 @@
 #include <linux/init.h>
 #include <linux/jiffies.h>
 #include <linux/kref.h>
+#include <linux/limits.h>
 #include <linux/list.h>
 #include <linux/minmax.h>
 #include <linux/netdevice.h>
@@ -34,7 +35,6 @@
 #include "bat_v_elp.h"
 #include "bat_v_ogm.h"
 #include "gateway_client.h"
-#include "gateway_common.h"
 #include "hard-interface.h"
 #include "hash.h"
 #include "log.h"
@@ -512,25 +512,6 @@ static void batadv_v_init_sel_class(struct batadv_priv *bat_priv)
 	atomic_set(&bat_priv->gw.sel_class, 50);
 }
 
-static ssize_t batadv_v_store_sel_class(struct batadv_priv *bat_priv,
-					char *buff, size_t count)
-{
-	u32 old_class, class;
-
-	if (!batadv_parse_throughput(bat_priv->soft_iface, buff,
-				     "B.A.T.M.A.N. V GW selection class",
-				     &class))
-		return -EINVAL;
-
-	old_class = atomic_read(&bat_priv->gw.sel_class);
-	atomic_set(&bat_priv->gw.sel_class, class);
-
-	if (old_class != class)
-		batadv_gw_reselect(bat_priv);
-
-	return count;
-}
-
 /**
  * batadv_v_gw_throughput_get() - retrieve the GW-bandwidth for a given GW
  * @gw_node: the GW to retrieve the metric for
@@ -818,7 +799,7 @@ static struct batadv_algo_ops batadv_batman_v __read_mostly = {
 	},
 	.gw = {
 		.init_sel_class = batadv_v_init_sel_class,
-		.store_sel_class = batadv_v_store_sel_class,
+		.sel_class_max = U32_MAX,
 		.get_best_gw_node = batadv_v_gw_get_best_gw_node,
 		.is_eligible = batadv_v_gw_is_eligible,
 		.dump = batadv_v_gw_dump,
diff --git a/net/batman-adv/gateway_common.c b/net/batman-adv/gateway_common.c
index d9632607..2dd36ef0 100644
--- a/net/batman-adv/gateway_common.c
+++ b/net/batman-adv/gateway_common.c
@@ -9,86 +9,14 @@
 
 #include <linux/atomic.h>
 #include <linux/byteorder/generic.h>
-#include <linux/kstrtox.h>
-#include <linux/limits.h>
-#include <linux/math64.h>
-#include <linux/netdevice.h>
 #include <linux/stddef.h>
-#include <linux/string.h>
+#include <linux/types.h>
 #include <uapi/linux/batadv_packet.h>
 #include <uapi/linux/batman_adv.h>
 
 #include "gateway_client.h"
-#include "log.h"
 #include "tvlv.h"
 
-/**
- * batadv_parse_throughput() - parse supplied string buffer to extract
- *  throughput information
- * @net_dev: the soft interface net device
- * @buff: string buffer to parse
- * @description: text shown when throughput string cannot be parsed
- * @throughput: pointer holding the returned throughput information
- *
- * Return: false on parse error and true otherwise.
- */
-bool batadv_parse_throughput(struct net_device *net_dev, char *buff,
-			     const char *description, u32 *throughput)
-{
-	enum batadv_bandwidth_units bw_unit_type = BATADV_BW_UNIT_KBIT;
-	u64 lthroughput;
-	char *tmp_ptr;
-	int ret;
-
-	if (strlen(buff) > 4) {
-		tmp_ptr = buff + strlen(buff) - 4;
-
-		if (strncasecmp(tmp_ptr, "mbit", 4) == 0)
-			bw_unit_type = BATADV_BW_UNIT_MBIT;
-
-		if (strncasecmp(tmp_ptr, "kbit", 4) == 0 ||
-		    bw_unit_type == BATADV_BW_UNIT_MBIT)
-			*tmp_ptr = '\0';
-	}
-
-	ret = kstrtou64(buff, 10, &lthroughput);
-	if (ret) {
-		batadv_err(net_dev,
-			   "Invalid throughput speed for %s: %s\n",
-			   description, buff);
-		return false;
-	}
-
-	switch (bw_unit_type) {
-	case BATADV_BW_UNIT_MBIT:
-		/* prevent overflow */
-		if (U64_MAX / 10 < lthroughput) {
-			batadv_err(net_dev,
-				   "Throughput speed for %s too large: %s\n",
-				   description, buff);
-			return false;
-		}
-
-		lthroughput *= 10;
-		break;
-	case BATADV_BW_UNIT_KBIT:
-	default:
-		lthroughput = div_u64(lthroughput, 100);
-		break;
-	}
-
-	if (lthroughput > U32_MAX) {
-		batadv_err(net_dev,
-			   "Throughput speed for %s too large: %s\n",
-			   description, buff);
-		return false;
-	}
-
-	*throughput = lthroughput;
-
-	return true;
-}
-
 /**
  * batadv_gw_tvlv_container_update() - update the gw tvlv container after
  *  gateway setting change
diff --git a/net/batman-adv/gateway_common.h b/net/batman-adv/gateway_common.h
index cb2e72d7..5d097d6a 100644
--- a/net/batman-adv/gateway_common.h
+++ b/net/batman-adv/gateway_common.h
@@ -9,9 +9,6 @@
 
 #include "main.h"
 
-#include <linux/netdevice.h>
-#include <linux/types.h>
-
 /**
  * enum batadv_bandwidth_units - bandwidth unit types
  */
@@ -30,7 +27,5 @@ enum batadv_bandwidth_units {
 void batadv_gw_tvlv_container_update(struct batadv_priv *bat_priv);
 void batadv_gw_init(struct batadv_priv *bat_priv);
 void batadv_gw_free(struct batadv_priv *bat_priv);
-bool batadv_parse_throughput(struct net_device *net_dev, char *buff,
-			     const char *description, u32 *throughput);
 
 #endif /* _NET_BATMAN_ADV_GATEWAY_COMMON_H_ */
diff --git a/net/batman-adv/netlink.c b/net/batman-adv/netlink.c
index 09b76b0f..4ddcc21b 100644
--- a/net/batman-adv/netlink.c
+++ b/net/batman-adv/netlink.c
@@ -548,15 +548,12 @@ static int batadv_netlink_set_mesh(struct sk_buff *skb, struct genl_info *info)
 		 * algorithm in use implements the GW API
 		 */
 
-		u32 sel_class_max = 0xffffffffu;
+		u32 sel_class_max = bat_priv->algo_ops->gw.sel_class_max;
 		u32 sel_class;
 
 		attr = info->attrs[BATADV_ATTR_GW_SEL_CLASS];
 		sel_class = nla_get_u32(attr);
 
-		if (!bat_priv->algo_ops->gw.store_sel_class)
-			sel_class_max = BATADV_TQ_MAX_VALUE;
-
 		if (sel_class >= 1 && sel_class <= sel_class_max) {
 			atomic_set(&bat_priv->gw.sel_class, sel_class);
 			batadv_gw_reselect(bat_priv);
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index cf1a0eaf..17d5ea1d 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -2197,11 +2197,10 @@ struct batadv_algo_gw_ops {
 	void (*init_sel_class)(struct batadv_priv *bat_priv);
 
 	/**
-	 * @store_sel_class: parse and stores a new GW selection class
-	 *  (optional)
+	 * @sel_class_max: maximum allowed GW selection class
 	 */
-	ssize_t (*store_sel_class)(struct batadv_priv *bat_priv, char *buff,
-				   size_t count);
+	u32 sel_class_max;
+
 	/**
 	 * @get_best_gw_node: select the best GW from the list of available
 	 *  nodes (optional)

-- 
2.39.2

