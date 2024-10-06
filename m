Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B3E0CFB424
	for <batman-adv@archiver.kernel.org>; Sun,  6 Oct 2024 17:40:23 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 169AC83D25
	for <batman-adv@archiver.kernel.org>; Sun,  6 Oct 2024 19:40:20 +0200 (CEST)
ARC-Seal: i=2; cv=fail; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1728236420;
 b=xg31t7HmzgnXG97RbZ/VdaXLEEB1XHnyqpABrukF9jAb9ISEhNHpgmDtZvMPPvEo1RkXU
 fPlYVQU1mHFHSdSAu2vnFBRwFvAccFii9eTORV7StCTOV61hdGHkXuO6p800ZGCpqbRnnhd
 iE9ahKE3f74OnakrQEY+XNW0HrQQGgg=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1728236420; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=ZnEHWRV66BIPn61iQgS6r8BgQWEuqe6JSs+rJ3Yl99w=;
 b=FlQu1TotY0xAtu/lUhb9q4yxMEBEd7N35fmBAMoeAoYn9icq0mMQr6XtwrJKwxGlPSXlu
 cv990RTaLvSD+ArxTDgaaenySv/ewGcL84jaIKlwu1MeNfVBgrgxlBMb0hbD6ERkErZJSDr
 uFRNR2nQoO/wm0Apd+2XlCX+ruuFvBQ=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
  arc=fail (ARC-Seal[1] did not validate);
  dmarc=pass (Used From Domain Record) header.from=narfation.org
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=fail (ARC-Seal[1] did not validate);
 dmarc=pass (Used From Domain Record) header.from=narfation.org
 policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id B7FFC8180D
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun,  6 Oct 2024 19:40:00 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1728236401;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=ZnEHWRV66BIPn61iQgS6r8BgQWEuqe6JSs+rJ3Yl99w=;
	b=tkSC7OuH0/G8nh08Rq8LkyHvVthpSaBgWI99sUNu4LbLRVKBs3sBzhIl4Y4RUVy5maE59K
	3PbOxMq9jofFU/gHAzwfUXop45yRISfm6b9WyD08WtLESJdfOI0Z5v27Gm2RweXPr1N42H
	f6S40JFRLN24qnt1NemaegB7uchJmk0=
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1728236401; a=rsa-sha256;
	cv=none;
	b=P4XbKuanqQCWjQnLoVkBBHZ2J7KTx+/VvUjRcrdAwQV9VtCvjSfSk38l6bcbQ54zDy04Vl
	kfHaXC/YLAQyfLYyn0LAqLE1CeJ5WWwcxhkSTfCyyxxVH3sQwrSLDYamKsmCW7aPo2S0Gn
	0DLW0a5Ax0cjEiXB48GerOXR3pz4wbE=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b="pphm/9wA";
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1728236400;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ZnEHWRV66BIPn61iQgS6r8BgQWEuqe6JSs+rJ3Yl99w=;
	b=pphm/9wA5W5ulGePG0UmSrGJl12rLduDrRrbwU9J2ODH5nevy0Gmz+Of9zW5lxswYM9+XD
	9u9NHGskmDYoKjwrVg2cEQLGIhSdDbksgfUpDPu9oEyHtqvp7kwxfhim9Hj6+MJEBl6Fw2
	ukENOwPlx9KVFn4dOMR1j9rdkn88G84=
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 06 Oct 2024 19:39:31 +0200
Subject: [PATCH] batman-adv: Use string choice helper to print booleans
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241006-string_choices-v1-1-688e5b3f11a6@narfation.org>
X-B4-Tracking: v=1; b=H4sIAFLLAmcC/x2MQQqAIBAAvxJ7TlCLqL4SEbVtuhcNNyKQ/p50G
 uYwk0EoMQmMVYZENwvHUMTUFaBfgyPFe3Gw2rZG607JlTi4BX1kJFHYrLj1ui8coERnooOffzj
 N7/sB2Ou6vWAAAAA=
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3796; i=sven@narfation.org;
 h=from:subject:message-id; bh=h393a2lFX1YQvFKWj9A2YEoFeV6ikvrF4fgIjPjtd1w=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDOlMp6OOGy7yP3f15dY/BUeyNjr/yvl95tvj3YkuWxYvW
 VJ6u9YxsKOUhUGMi0FWTJFlz5X885vZ38p/nvbxKMwcViaQIQxcnAIwEVslhv+Rjlr52ktOfPp3
 gudDnVNSvMC1K6XZp3RL3z5cWvvg750ZjAwfkqOMyv2fLrb/0fN5c0/J/iebd/K4pu++8Pjj3n8
 rZ9/nAAA=
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: EJPQASFA545DUCAQFIJJO7NTXSJV5MIN
X-Message-ID-Hash: EJPQASFA545DUCAQFIJJO7NTXSJV5MIN
X-MailFrom: sven@narfation.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/EJPQASFA545DUCAQFIJJO7NTXSJV5MIN/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

The commit ea4692c75e1c ("lib/string_helpers: Consolidate string helpers
implementation") introduced common helpers to print string representations
of boolean helpers. These are supposed to be used instead of open coded
versions.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 compat-include/linux/string_choices.h  | 32 ++++++++++++++++++++++++++++++++
 net/batman-adv/bat_iv_ogm.c            |  4 ++--
 net/batman-adv/bridge_loop_avoidance.c |  8 ++++----
 3 files changed, 38 insertions(+), 6 deletions(-)

diff --git a/compat-include/linux/string_choices.h b/compat-include/linux/string_choices.h
new file mode 100644
index 00000000..9a6aba7f
--- /dev/null
+++ b/compat-include/linux/string_choices.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) B.A.T.M.A.N. contributors:
+ *
+ * Marek Lindner, Simon Wunderlich
+ *
+ * This file contains macros for maintaining compatibility with older versions
+ * of the Linux kernel.
+ */
+
+#ifndef _NET_BATMAN_ADV_COMPAT_LINUX_STRING_CHOICES_H_
+#define _NET_BATMAN_ADV_COMPAT_LINUX_STRING_CHOICES_H_
+
+#include <linux/version.h>
+#if LINUX_VERSION_IS_GEQ(6, 5, 0)
+#include_next <linux/string_choices.h>
+#elif LINUX_VERSION_IS_GEQ(5, 18, 0)
+#include <linux/string_helpers.h>
+#else
+
+static inline const char *str_yes_no(bool v)
+{
+	return v ? "yes" : "no";
+}
+
+static inline const char *str_on_off(bool v)
+{
+	return v ? "on" : "off";
+}
+
+#endif
+
+#endif /* _NET_BATMAN_ADV_COMPAT_LINUX_STRING_CHOICES_H_ */
diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index 74b49c35..07ae5dd1 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -36,6 +36,7 @@
 #include <linux/spinlock.h>
 #include <linux/stddef.h>
 #include <linux/string.h>
+#include <linux/string_choices.h>
 #include <linux/types.h>
 #include <linux/workqueue.h>
 #include <net/genetlink.h>
@@ -371,8 +372,7 @@ static void batadv_iv_ogm_send_to_if(struct batadv_forw_packet *forw_packet,
 			   batadv_ogm_packet->orig,
 			   ntohl(batadv_ogm_packet->seqno),
 			   batadv_ogm_packet->tq, batadv_ogm_packet->ttl,
-			   ((batadv_ogm_packet->flags & BATADV_DIRECTLINK) ?
-			    "on" : "off"),
+			   str_on_off(batadv_ogm_packet->flags & BATADV_DIRECTLINK),
 			   hard_iface->net_dev->name,
 			   hard_iface->net_dev->dev_addr);
 
diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
index 5f46ca3d..449faf5a 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -33,6 +33,7 @@
 #include <linux/sprintf.h>
 #include <linux/stddef.h>
 #include <linux/string.h>
+#include <linux/string_choices.h>
 #include <linux/workqueue.h>
 #include <net/arp.h>
 #include <net/genetlink.h>
@@ -1946,16 +1947,15 @@ bool batadv_bla_rx(struct batadv_priv *bat_priv, struct sk_buff *skb,
 	claim = batadv_claim_hash_find(bat_priv, &search_claim);
 
 	if (!claim) {
+		bool local = batadv_is_my_client(bat_priv, ethhdr->h_source, vid);
+
 		/* possible optimization: race for a claim */
 		/* No claim exists yet, claim it for us!
 		 */
 
 		batadv_dbg(BATADV_DBG_BLA, bat_priv,
 			   "%s(): Unclaimed MAC %pM found. Claim it. Local: %s\n",
-			   __func__, ethhdr->h_source,
-			   batadv_is_my_client(bat_priv,
-					       ethhdr->h_source, vid) ?
-			   "yes" : "no");
+			   __func__, ethhdr->h_source, str_yes_no(local));
 		batadv_handle_claim(bat_priv, primary_if,
 				    primary_if->net_dev->dev_addr,
 				    ethhdr->h_source, vid);

---
base-commit: 6398f63b783812c10554e65d4a5dc453d69697f7
change-id: 20241006-string_choices-c3acb808c3a9

Best regards,
-- 
Sven Eckelmann <sven@narfation.org>

