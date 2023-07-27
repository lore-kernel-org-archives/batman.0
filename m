Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57512C0015E
	for <batman-adv@archiver.kernel.org>; Thu, 27 Jul 2023 08:16:28 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id ECEF982E82
	for <batman-adv@archiver.kernel.org>; Thu, 27 Jul 2023 10:16:26 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1690445786;
 b=jlnw79yL1UMWncDnz3fV6IMjN6gEm1X6zRu6Kau2frd2a2p9QabBoQEwKU0xBpCKeAeud
 wgQzXj0eZXYikyOXj85P4smWD8YZPcZQHyaTPHDdipV9kGYOpPKLpABXhkNkpnMgzMYp9Eq
 wNC2pq1pmtjCAOj5pF+kKY1L0QWT070=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1690445786; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=NS7gyUKoETP+1MLS1RjejPltvPqzjb9KcusR7H9Md08=;
 b=Fwa9ou7wrrX0E0YQDz6/3KFP5LE0c+ShejReSDiWL9L30QDPUVwwwqNlPpGLd8N6dfIw3
 u1ZkKr2mz7vImqXPLn97KMrP1qhrkPIc6MPB0+EmLWYIedCFSZh1BzMIVT8ioouGj3+52yp
 FuV4u/HiypC7zQr7r4B/7FDFm459NQA=
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
	by diktynna.open-mesh.org (Postfix) with ESMTPS id DD75D81E6A
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 27 Jul 2023 10:14:24 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1690445666;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=NS7gyUKoETP+1MLS1RjejPltvPqzjb9KcusR7H9Md08=;
	b=BYjWNq1vI1hdT7EDaCVYty5fLn5oyKbocdThoA5L0fNpkFzRbhxO3G9Hc2vnzlVvWzyTIW
	LItWQct457PabNjoSzvUGhpujwwIVFelxayi3noR9yWl3E5QhHZHV5eafdUg/k9c4KxX0i
	CyfyAU8bdBkVaqYsZCtyCUGGPQqwpzk=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=E4omFk5a;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1690445666; a=rsa-sha256;
	cv=none;
	b=dbSpx3YBHL9uVapQoEdnYsiQrzCleQKyNI4cRHAfE18TqqK27dQ4ATcPvjrQpbOWo3ZF6y
	I25yWr9ycruzu8Rugqq5W1ZOR/eLoK49erpOWjms4bDjmcCxkYiCQ0z2gGL1Mx3fMDQmgt
	sl0b30JNY6U6lvlox2XZ1CLNOH6y4Jc=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1690445664;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NS7gyUKoETP+1MLS1RjejPltvPqzjb9KcusR7H9Md08=;
	b=E4omFk5asuUfdzYehQnEW5YtMr2B+/eE86eRJ16Wy4MFFRVZtK1cfrjWmYCnyoOXZL19VS
	v1fGWvtDSom1gKL1fcu/3zXWTx2psgA11qby3RV4DHIqs9eQhyzaZvkfOcp8mlvEW05F0G
	qcsrHlfZn/w8+RHVi4gEHROxl/i9Y68=
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 27 Jul 2023 10:13:44 +0200
Subject: [PATCH RFC 3/3] batman-adv: Add support for jumbo frames
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230727-jumbo-mtu-v1-3-036ce1a6e33c@narfation.org>
References: <20230727-jumbo-mtu-v1-0-036ce1a6e33c@narfation.org>
In-Reply-To: <20230727-jumbo-mtu-v1-0-036ce1a6e33c@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2423; i=sven@narfation.org;
 h=from:subject:message-id; bh=MVq/l4cZCBP8srzEoasJnRvPRiFvg4I14VjEWf5N1HQ=;
 b=owEBbQKS/ZANAwAKAV2HCgfBJntGAcsmYgBkwidHBEqBvw+b9dSDaCmOEaTCCXeoA+DwJiy8m
 LOHPD+ju6eJAjMEAAEKAB0WIQQXXSuHYSVz3OMy4AJdhwoHwSZ7RgUCZMInRwAKCRBdhwoHwSZ7
 RmpAEACOj+6mVjJVmxCbDj/KhUclf6K/MFJvI+MEUJhi5M0uvHbrYQMAz79AKnbPehb8jfYbn2R
 XahUGTDcJ4tc4ZPqQqE7Xx+1RhtgZmXBq9mHL43QkpmUfshxj7ByMmdLO3NRfMogF0RROTnNK5g
 YXSKXfiEQ+ZxNcdo2FdjA+KOFV65LnTt5civ9Ujvf/6k/GZDRymPQoLGNae6fWzItZZNtH5L2BG
 7MybjCpBZnxKdHFuRZ1jVWVUqdgff8F7tBtmGS5/hanh6/D4QOCWsdG+EBwLP6b5uepwJu6kYsw
 Xs7n5ipRZUDCdOnu/lXk4gCfczy27UPSwRwoYKnqDTbOrCYwSvxHP+UUKwfabfu9d7nXDF3/tWu
 tsujTjUwpuuH1UDVAI5hBPJtbWuyHws22kqqvt0fipOC75WYmq7CdjrKkD7WESA1mH6MNDF7yQp
 KDRenKW1TNhdxmcnF6EZYs0Fhmpwl6ZxapyZSjB5DpehkEol6ReSqSd9qx2HM5P2M+nkzV7sdWs
 5avJMW2n63LW6vojLfi9SWNyrObRvWL49AzhneFpunkXbOQtkuAKD5OmbGoczaCZw6eccBJ0Zns
 DGUBXch8nqP95YVsI4F4SOygmOJFn/GW2lKS1t1sCzoXwSBYqCGxIp+2Nt3X0HnWhuRmrgIyWwi
 rPBRS4nK+bvmB3A==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: BMLC66VW6FCULO57GNZS5FP5ACJDATID
X-Message-ID-Hash: BMLC66VW6FCULO57GNZS5FP5ACJDATID
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/BMLC66VW6FCULO57GNZS5FP5ACJDATID/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Since batman-adv is not actually depending on hardware capabilities, it has
no limit on the MTU. Only the lower hard interfaces can limit it. In case
these have an high enough MTU or fragmentation is enabled, a higher MTU
than 1500 can be enabled.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/hard-interface.c | 4 +---
 net/batman-adv/main.h           | 2 ++
 net/batman-adv/soft-interface.c | 3 ++-
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index 5a4ff9a8..4fbb6339 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -618,10 +618,8 @@ int batadv_hardif_min_mtu(struct net_device *soft_iface)
 
 	/* the real soft-interface MTU is computed by removing the payload
 	 * overhead from the maximum amount of bytes that was just computed.
-	 *
-	 * However batman-adv does not support MTUs bigger than ETH_DATA_LEN
 	 */
-	return min_t(int, min_mtu - batadv_max_header_len(), ETH_DATA_LEN);
+	return min_t(int, min_mtu - batadv_max_header_len(), BATADV_MAX_MTU);
 }
 
 /**
diff --git a/net/batman-adv/main.h b/net/batman-adv/main.h
index e0d53273..4dc81ddb 100644
--- a/net/batman-adv/main.h
+++ b/net/batman-adv/main.h
@@ -22,6 +22,8 @@
 #define BATADV_THROUGHPUT_MAX_VALUE 0xFFFFFFFF
 #define BATADV_JITTER 20
 
+#define BATADV_MAX_MTU (ETH_MAX_MTU - batadv_max_header_len())
+
 /* Time To Live of broadcast messages */
 #define BATADV_TTL 50
 
diff --git a/net/batman-adv/soft-interface.c b/net/batman-adv/soft-interface.c
index f7947fad..13d5f993 100644
--- a/net/batman-adv/soft-interface.c
+++ b/net/batman-adv/soft-interface.c
@@ -769,7 +769,7 @@ static int batadv_softif_init_late(struct net_device *dev)
 	atomic_set(&bat_priv->log_level, 0);
 #endif
 	atomic_set(&bat_priv->fragmentation, 1);
-	atomic_set(&bat_priv->packet_size_max, ETH_DATA_LEN);
+	atomic_set(&bat_priv->packet_size_max, BATADV_MAX_MTU);
 	atomic_set(&bat_priv->bcast_queue_left, BATADV_BCAST_QUEUE_LEN);
 	atomic_set(&bat_priv->batman_queue_left, BATADV_BATMAN_QUEUE_LEN);
 
@@ -1009,6 +1009,7 @@ static void batadv_softif_init_early(struct net_device *dev)
 	 * have not been initialized yet
 	 */
 	dev->mtu = ETH_DATA_LEN;
+	dev->max_mtu = BATADV_MAX_MTU;
 
 	/* generate random address */
 	eth_hw_addr_random(dev);

-- 
2.39.2

