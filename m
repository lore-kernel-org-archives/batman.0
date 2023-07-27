Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEC0AC0015E
	for <batman-adv@archiver.kernel.org>; Thu, 27 Jul 2023 08:15:48 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 112AF8214F
	for <batman-adv@archiver.kernel.org>; Thu, 27 Jul 2023 10:15:47 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1690445747;
 b=ww1DfWLEdt9nKqZvTrdsoE5zzUXfovWB30ytIYt+nRftQntdklBIvQpRT1YlvlZmY+WwU
 uJ5adNbKqmi29ThPgG4UW6SvOuuzNX44VQdWuHxsxgPwu/25QhElBdR+cowQMgNz86cfnsr
 Hj2tHVY7INx11u0tWXxib4Y7aUCo4d0=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1690445747; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=GrzKoxQ36tBxvWUSvUQSn4sunBOCaUcdksxW5Gl0tbc=;
 b=ns7JPkf9ytUHyqoIqBP6R8XB3s598XYPd6W+WrMRlgm9GR48m5q3c/rEP2O8xRm6pGmlu
 l+pE61dYw9kZ+g5QSpRQ1aMiynSyKLrDlmoDCVeCYMU8vTqUsDaKbUHUACuT1Dex9m3Pay5
 NEJMzbXYeN40tp5cFWZ8GOkcaG8vCzc=
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
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 83B0A81A3C
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 27 Jul 2023 10:14:20 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1690445661;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=GrzKoxQ36tBxvWUSvUQSn4sunBOCaUcdksxW5Gl0tbc=;
	b=R5Ffp/V5hVFsqWYI+CSTMfz3IjUTW6+n6vbamC9jxJAww+wxh2Cw2Bbdctl6IKHMCWvWgE
	4OsNF/Q4SO8Y7otfZ9vizRRY/VI4kjlzY0T1r0rzDeiN85SpRDyIvSsWqmjTi+/iq2w4Tm
	Uy+rMRE06/00IKW3jtImbfEbTYuiZhQ=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=GmjIngtd;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1690445661; a=rsa-sha256;
	cv=none;
	b=GWG1DmmlfRNv9XFQvE5/YgJUKUdV5CUuY+JT1S6ENbPuEwocJ31GRLP3TQ4Ukj9HrGoo0E
	cYTAhJ7A+Psw+7dpQN+9QcDDajZGLdL8BrUbjesY6qXima/s6rbSrM34ovXcv+NM5cpZqz
	Y8nN/rv01W07zjObZGSzlNe4I+f/S8Q=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1690445660;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GrzKoxQ36tBxvWUSvUQSn4sunBOCaUcdksxW5Gl0tbc=;
	b=GmjIngtdPi0g/KYQhkV7cXhTRDis7QrP4Iy7lwCZlelQr/hMIq1IrmuDMEgqjihZfbmDG6
	7sXqrobl8jyxc2XtX7id0siXMJQeQFFjz9CzDsbjHWA13cUnS61Ahbxgw9zy6Pa2QQTdhZ
	a8/KqOTXTXk54EtaxCIWB3AOAjSGvb4=
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 27 Jul 2023 10:13:43 +0200
Subject: [PATCH RFC 2/3] batman-adv: Check hardif MTU against runtime MTU
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230727-jumbo-mtu-v1-2-036ce1a6e33c@narfation.org>
References: <20230727-jumbo-mtu-v1-0-036ce1a6e33c@narfation.org>
In-Reply-To: <20230727-jumbo-mtu-v1-0-036ce1a6e33c@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2775; i=sven@narfation.org;
 h=from:subject:message-id; bh=ieJrSIN/6T9uLaha42I0Ifvxuf/346ht09P7/vwCdlQ=;
 b=owEBbQKS/ZANAwAKAV2HCgfBJntGAcsmYgBkwidHc4BWSe4cvsuIyjaq1Vox0+diczue7wNM+
 imLM/4nY1+JAjMEAAEKAB0WIQQXXSuHYSVz3OMy4AJdhwoHwSZ7RgUCZMInRwAKCRBdhwoHwSZ7
 RrhsEADMJk+BaJQebGQ5UGWF5j/azVG8APELqVoPuenw9GorJ56BCxdJSs6ytWeaeb+YRKH9BDb
 EPfJFiN/7lQOVgdBVI5DzHXARLPXWWP5jTuniLLAA8tDhtljCu/YdtMUQBPTmGKQOs0X8ePwghL
 A9XtZXyRoqMVwlO3z7lG1fPKMuG7m6Lq1+uYUcKlkNDDV+IYzUGcVJKoJCTt8vhAA/FV0+j9ucl
 JRax8ryESLb7t/KuPZMiQjV1QiJRcX0D34YydHlU+NPcXp8f0GMQSHar0rvjr+xZ6K1ditCo7XG
 AGN1PA/WcIUjpeLkrI3X8gbr+0KKBZXLSWjBO3a05X8+Nbk1ViNpeMlvHKVDY4vhSzhTQV0aHOl
 6/tBkGnsrBUs3AUXt0KocLvKpGJyBI3TcVifYX1LxGvidebxIxTiYxehtcXNAE+Lys/v0qQmBgh
 Xa3wsI/4mJTkTB0jKvDpsc42nwF433GU5hwFAVlA5w7rNnXPTu0Dce/q/AQjE8a4JInKTMEghwc
 ENDi8ag7gBQ2mmyZHt0F6FIW0gM9fa8h8IChNTrGdAmG0hiygBHEz7xYzAucf0IM2K7ltnRQpdS
 wm1fTcapl9+oP28eZEYnPwlIGxrJzdGD9hC3ZBfcDIgKkLAHETI3kZNrtD+HdHRmjXamCKZDjJX
 9YiabhcYTY/+QOg==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: POVPU3YCNJFOFENHBYX6BEXNNE3WKGKA
X-Message-ID-Hash: POVPU3YCNJFOFENHBYX6BEXNNE3WKGKA
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/POVPU3YCNJFOFENHBYX6BEXNNE3WKGKA/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

If the MTU of the soft/mesh interface was already reduced (enough), it is
not necessary to print a warning about a hard interface not having a MTU to
transport ethernet payloads of 1500 bytes.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/hard-interface.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index 41c1ad33..5a4ff9a8 100644
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

