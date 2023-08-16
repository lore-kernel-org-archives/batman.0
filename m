Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E515FC53219
	for <batman@archiver.kernel.org>; Tue, 28 Jul 2026 20:37:19 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 0FF8A81878
	for <batman@archiver.kernel.org>; Tue, 28 Jul 2026 22:37:14 +0200 (CEST)
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=none (ARC-Seal[2] reported failure, the chain is terminated);
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de
 policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 4DAE2814CF
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 16 Aug 2023 18:40:03 +0200 (CEST)
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1692204003;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=UT5bWjQUXdZ8j9sjM7T/pgcycgN7Pea95gbAyeXlz18=;
	b=FE+3uP5+xdYr1h/w+XprNOH+64hvCIne7zyahpeEBbogtKZ0vD4M6Yttv2qGIFBrLduPfq
	U2ID1ixK3QGhmGReR7JSZQW3VVOnhjKTxdhINXnUUOCs0+7JdiCJQ+fOPHYNN86wo05M3q
	f7MHbTNfoa4SoHue3spLd8MW30iRUsY=
ARC-Authentication-Results: i=2;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=jPijjvC2;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 23.88.38.48 as permitted sender) smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de;
	arc=reject ("seal check failed: fail, {[1] = sig:simonwunderlich.de:reject}")
ARC-Seal: i=2; s=20121; d=open-mesh.org; t=1692204003; a=rsa-sha256;
	cv=fail;
	b=IyKv9ACjHclHLdig3fH0gB3gtpqGPlor1xW0LL6hGjb+zkiZS8KqTnUAAq/SfrpKDDUSbq
	2od5qLDWbpZ400LleAeDyMnedYNehx4iFzbk0wopyfA7b3HwZkQXQhX846hCToY5QzoO1H
	PJZEYBmrZX21yQp9VmOtJqpCh6tP2Gc=
Received: from kero.packetmixer.de
 (p200300fa272a67000Bb2D6Dcaf57D46e.dip0.t-ipconnect.de
 [IPv6:2003:fa:272a:6700:bb2:d6dc:af57:d46e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits)
 server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id E596FFB5C7;
	Wed, 16 Aug 2023 18:40:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1692204003;
 h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UT5bWjQUXdZ8j9sjM7T/pgcycgN7Pea95gbAyeXlz18=;
	b=jPijjvC2lINWEf8VJ2UH43qa9m2yI32Mo8yEWbouwA+ycZYGXWlaylS/M67RdSg7QT/PkB
	e9IoceNZHto/2KRfdHJmc+HxMYeCKrhQ0Nw4Dw/7kwcF+vIW+1QnyITiIK0SsiNw68IF0J
	dAOFmSA6Rh/CJSEP/Ya4D+JqlOo1zW9mjUqsS7HI4jPF1PU2M62L4iw31Q+lP+h1SF8l4W
	DaFnm+I2b0z6PoCRy4LkYV3Ka3yYtv8b5BQptfc/Oll9QRr50TOy6CfCoPDcRsW0RHqpUB
	v+mnTQne3E8kzQmpOsQ81NSLyiCm1cZ6lkQRywNclsxSfvHVVri223Q+WJ2rYA==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: kuba@kernel.org,
	davem@davemloft.net
Cc: netdev@vger.kernel.org,
	b.a.t.m.a.n@lists.open-mesh.org,
	Sven Eckelmann <sven@narfation.org>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 4/7] batman-adv: Check hardif MTU against runtime MTU
Date: Wed, 16 Aug 2023 18:39:57 +0200
Message-Id: <20230816164000.190884-5-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230816164000.190884-1-sw@simonwunderlich.de>
References: <20230816164000.190884-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
	d=simonwunderlich.de; s=09092022; t=1692204003;
	h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UT5bWjQUXdZ8j9sjM7T/pgcycgN7Pea95gbAyeXlz18=;
	b=pdII1L7HnGeer3jsLVCRxGz6O3JBiUaa2tm2Sv725tW7lEt95mKUXambiYyq6YStR36c0N
	sQYqFDdPN28+SwONWlFZi4zEI0oVk5Kz9a1FRWbB1l6k013Tv2WtAq05/aF2jrdhmfIgtP
	X5Ln2qF+P2Qd9R8TKxBayLoC0VgZ2EF6NDI3yFJpjpJPoeeOikNqIgJVH+MAKLwmBngGVi
	7Lw3oLOVRE7bEhw+PT3DGY2f+0iYxWvhrdQJc5GR/9HRuMXxFnS8yVHG+PObStcRBddyhU
	O9d/LEQWerDTXWH79cfztVZV2B+eP3t1krpj5f5vkrSwtRflZxc93HOoBOJvLA==
ARC-Seal: i=1; s=09092022; d=simonwunderlich.de; t=1692204003; a=rsa-sha256;
	cv=none;
	b=QmDh7NbewUDhQFdQwRC2neGjevGDJcSpO9TcUG0Ebi0w2Iarc+ncXk9SRkTTrMZpOEeq9cusoonxe3TI3QgH/KnC9aKiJbVtBsC4TMnYapzvAL1U6U0D4x1nBNYOTjTNIPHPGIreUzf4RItJbiYY21NK8yUPf48FA2bHKIMOO8eMBBdgJsv0qSFRyksDBpttOt0otcTvhf3kWQWpFEvi6P+mf9XEzj1cQ11qUrhHn+xa2jttyXpWn4JfWEKzene4Fg89oG6p3/E4PHY+zgiWXSZm2su9Gx1Xu1mf+1BRlmc5r04D4kFGrW/3pCGH/++2AQJNYulX8QSX90JjE9s2dQ==
ARC-Authentication-Results: i=1;
	mail.simonwunderlich.de;
	auth=pass smtp.auth=sw@simonwunderlich.de smtp.mailfrom=sw@simonwunderlich.de
Message-ID-Hash: DLCREMAJ7AIZEU3L3VZR4HNYOGLEHMC3
X-Message-ID-Hash: DLCREMAJ7AIZEU3L3VZR4HNYOGLEHMC3
X-MailFrom: sw@simonwunderlich.de
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/DLCREMAJ7AIZEU3L3VZR4HNYOGLEHMC3/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Sven Eckelmann <sven@narfation.org>

If the MTU of the soft/mesh interface was already reduced (enough), it is
not necessary to print a warning about a hard interface not having a MTU to
transport ethernet payloads of 1500 bytes.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/hard-interface.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index 41c1ad33d009..5a4ff9a81e74 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -9,6 +9,7 @@
 
 #include <linux/atomic.h>
 #include <linux/byteorder/generic.h>
+#include <linux/compiler.h>
 #include <linux/container_of.h>
 #include <linux/errno.h>
 #include <linux/gfp.h>
@@ -699,9 +700,14 @@ int batadv_hardif_enable_interface(struct batadv_hard_iface *hard_iface,
 	struct batadv_priv *bat_priv;
 	__be16 ethertype = htons(ETH_P_BATMAN);
 	int max_header_len = batadv_max_header_len();
+	unsigned int required_mtu;
+	unsigned int hardif_mtu;
 	int ret;
 
-	if (hard_iface->net_dev->mtu < ETH_MIN_MTU + max_header_len)
+	hardif_mtu = READ_ONCE(hard_iface->net_dev->mtu);
+	required_mtu = READ_ONCE(soft_iface->mtu) + max_header_len;
+
+	if (hardif_mtu < ETH_MIN_MTU + max_header_len)
 		return -EINVAL;
 
 	if (hard_iface->if_status != BATADV_IF_NOT_IN_USE)
@@ -734,18 +740,18 @@ int batadv_hardif_enable_interface(struct batadv_hard_iface *hard_iface,
 		    hard_iface->net_dev->name);
 
 	if (atomic_read(&bat_priv->fragmentation) &&
-	    hard_iface->net_dev->mtu < ETH_DATA_LEN + max_header_len)
+	    hardif_mtu < required_mtu)
 		batadv_info(hard_iface->soft_iface,
 			    "The MTU of interface %s is too small (%i) to handle the transport of batman-adv packets. Packets going over this interface will be fragmented on layer2 which could impact the performance. Setting the MTU to %i would solve the problem.\n",
-			    hard_iface->net_dev->name, hard_iface->net_dev->mtu,
-			    ETH_DATA_LEN + max_header_len);
+			    hard_iface->net_dev->name, hardif_mtu,
+			    required_mtu);
 
 	if (!atomic_read(&bat_priv->fragmentation) &&
-	    hard_iface->net_dev->mtu < ETH_DATA_LEN + max_header_len)
+	    hardif_mtu < required_mtu)
 		batadv_info(hard_iface->soft_iface,
 			    "The MTU of interface %s is too small (%i) to handle the transport of batman-adv packets. If you experience problems getting traffic through try increasing the MTU to %i.\n",
-			    hard_iface->net_dev->name, hard_iface->net_dev->mtu,
-			    ETH_DATA_LEN + max_header_len);
+			    hard_iface->net_dev->name, hardif_mtu,
+			    required_mtu);
 
 	if (batadv_hardif_is_iface_up(hard_iface))
 		batadv_hardif_activate_interface(hard_iface);
-- 
2.39.2

