Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23292CAC5B5
	for <batman@archiver.kernel.org>; Sun, 28 Sep 2025 18:35:11 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id AAC8183DDB
	for <batman@archiver.kernel.org>; Sun, 28 Sep 2025 20:35:09 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1759084509;
 b=jp7xOF9RWFW8JFWuSIE59HqeU5mDeDDGNnCwJ+2uhM2Jkfv3fYFEdbljWHreMYAFDsVuN
 WC1gGG/rLVYRkiORcM+568OX+URCAVXKAEVAHi0Xnmd5gOBWNUODeM/EegqKNQBYrHf3mPz
 R6SncLSRjz2Vl9EucbYYpRM8reONHGQ=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1759084509; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=kXp16vAeEcnn6JiHFoqCbKnUWmn5F+F55OKohF6islY=;
 b=vlwE9nJdbxJNzU2MUJjwQGUJd4bPJiMXk+RxsANkE1a4VmAeXIrFGXdyrGOsNFhz3cNuh
 oQL6cTKZJnMMhek148n8TdHb2IY+8PZiRqfoSZ4bc6mZYVUzVwqmOY1jMwIMqzhbRPF+xdH
 HxtpTcGgGxhWGS1mY2GI+e1fVQejBWU=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 1B57B806A6
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 28 Sep 2025 20:34:48 +0200 (CEST)
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1759084498; a=rsa-sha256;
	cv=none;
	b=w1fp10mizafmsgLcJBoFCubgKDyj7OC+nnDZKIOKY0Nqx443L/JioxhsWgoXWoMcVeBY6F
	n+6BEv8sJtpmgSUPaK/BVq5QnlyYbfa0STZ2n9dEearTvibyrNswGzk8K+ota4K2CxFNzC
	kTNUR7NaYFWN5VqVSVXpGaGqaEsjzpc=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=mB2Q00WA;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1759084498;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=kXp16vAeEcnn6JiHFoqCbKnUWmn5F+F55OKohF6islY=;
	b=ysVCtQITiCJPf4WWCvGRrMITMuf6Jk2GjlICO/Q4dbHiOtzJpB7A2O1n5yYD7AZ+CTHITr
	eSd/WxIMIRnAsdp3e2Hvob1lv3bSv5iLD4z+qHgtj4BjMsoaKKZn6LBQxN1xKZoZ+c2WWi
	aleXyG+Z/QZqlx0OTNPd2gp5hJ/f1cQ=
Received: by dvalin.narfation.org (Postfix) id 5E007200DE
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 28 Sep 2025 18:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1759084482;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=kXp16vAeEcnn6JiHFoqCbKnUWmn5F+F55OKohF6islY=;
	b=mB2Q00WAVm1YwXGQdWJaHOUG6RlEXiTynRj3WxeZWbqEVcbcWhcIVBPBdbtoII6YFzNsYm
	7XaBsRHm//UoFbTcAd0xPbdJHRKBC8SJd2ZB2iJJr3UhUiAqKuWTGdGBvpiQ154vdD1Vqc
	9tDlOeA+6DH7kA2TyjZEZwfCr8rft3Q=
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 28 Sep 2025 20:34:14 +0200
Subject: [PATCH] batman-adv: use skb_crc32c() instead of skb_seq_read()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250928-skb_crc32c-v1-1-d2669ab0ffe9@narfation.org>
X-B4-Tracking: v=1; b=H4sIAKV/2WgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDSyML3eLspPjkomRjo2RdAxMjCwvLpDSjlFRTJaCGgqLUtMwKsGHRsbW
 1APLLX4FcAAAA
X-Change-ID: 20250928-skb_crc32c-042889bf2de5
To: b.a.t.m.a.n@lists.open-mesh.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6734; i=sven@narfation.org;
 h=from:subject:message-id; bh=gUOVyVbZLNEoNLmziZuOmNbzLWRrCLkaqJPoSYj++5I=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDBk361cX5C1oeJZlbHVt975lV6NaMy6b7ngjd2va9//Jh
 2/OqD4e21HKwiDGxSArpsiy50r++c3sb+U/T/t4FGYOKxPIEAYuTgGYiGgOI0NzBZuyY6f9ZscQ
 V6W7d7/3Cl7o+nTRJdR54af+8jupV7wZ/spOqPgtId318O/G1+xd2yR3LHi+P6dTs2qphSSLzv4
 JEpwA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: L5EGUNQA326V6EGICPNK7FP3RIS4Y7UB
X-Message-ID-Hash: L5EGUNQA326V6EGICPNK7FP3RIS4Y7UB
X-MailFrom: sven@narfation.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/L5EGUNQA326V6EGICPNK7FP3RIS4Y7UB/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Make batadv_bla_check_duplist() just use the new function skb_crc32c(),
instead of calling skb_seq_read() with crc32c(). This is faster and
simpler.

Suggested-by: Eric Biggers <ebiggers@kernel.org>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 compat-include/linux/skbuff.h          | 45 ++++++++++++++++++++++++++++++
 net/batman-adv/Kconfig                 |  1 +
 net/batman-adv/bridge_loop_avoidance.c | 51 ++++++----------------------------
 net/batman-adv/types.h                 |  2 +-
 4 files changed, 55 insertions(+), 44 deletions(-)

diff --git a/compat-include/linux/skbuff.h b/compat-include/linux/skbuff.h
new file mode 100644
index 0000000000000000000000000000000000000000..96a2e86f3f0cd694344a9614661de8de730a797c
--- /dev/null
+++ b/compat-include/linux/skbuff.h
@@ -0,0 +1,45 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) B.A.T.M.A.N. contributors:
+ *
+ * Marek Lindner, Simon Wunderlich
+ *
+ * This file contains macros for maintaining compatibility with older versions
+ * of the Linux kernel.
+ */
+
+#ifndef _NET_BATMAN_ADV_COMPAT_LINUX_SKBUFF_H_
+#define _NET_BATMAN_ADV_COMPAT_LINUX_SKBUFF_H_
+
+#include <linux/version.h>
+#include_next <linux/skbuff.h>
+
+#if LINUX_VERSION_IS_LESS(6, 16, 0) || !defined(CONFIG_NET_CRC32C)
+
+#include <linux/crc32.h>
+
+static inline u32 batadv_skb_crc32c(struct sk_buff *skb, int offset,
+				    int len, u32 crc)
+{
+	unsigned int to = offset + len;
+	unsigned int consumed = 0;
+	struct skb_seq_state st;
+	unsigned int l;
+	const u8 *data;
+
+	if (len <= 0)
+	       return crc;
+
+	skb_prepare_seq_read(skb, offset, to, &st);
+	while ((l = skb_seq_read(consumed, &data, &st)) != 0) {
+		crc = crc32c(crc, data, l);
+		consumed += l;
+	}
+
+	return crc;
+}
+
+#define skb_crc32c batadv_skb_crc32c
+
+#endif /* LINUX_VERSION_IS_LESS(6, 16, 0) || !defined(CONFIG_NET_CRC32C) */
+
+#endif /* _NET_BATMAN_ADV_COMPAT_LINUX_TIMER_H_ */
diff --git a/net/batman-adv/Kconfig b/net/batman-adv/Kconfig
index c299e2bc87eda118f35c4d9b6a718927951e09b2..58c408b7a7d9c3f78394bc038dbdaad287126013 100644
--- a/net/batman-adv/Kconfig
+++ b/net/batman-adv/Kconfig
@@ -35,6 +35,7 @@ config BATMAN_ADV_BLA
 	bool "Bridge Loop Avoidance"
 	depends on BATMAN_ADV && INET
 	select CRC16
+	select NET_CRC32C
 	default y
 	help
 	  This option enables BLA (Bridge Loop Avoidance), a mechanism
diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
index b992ba12aa2478a338155d2fe46a75e970306bd5..3dc791c15bf72edd4884c1c41f90a729846df41b 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -12,7 +12,6 @@
 #include <linux/compiler.h>
 #include <linux/container_of.h>
 #include <linux/crc16.h>
-#include <linux/crc32.h>
 #include <linux/err.h>
 #include <linux/errno.h>
 #include <linux/etherdevice.h>
@@ -1585,45 +1584,11 @@ int batadv_bla_init(struct batadv_priv *bat_priv)
 	return 0;
 }
 
-/**
- * batadv_skb_crc32() - calculate CRC32 of the whole packet and skip bytes in
- *  the header
- * @skb: skb pointing to fragmented socket buffers
- * @payload_ptr: Pointer to position inside the head buffer of the skb
- *  marking the start of the data to be CRC'ed
- *
- * payload_ptr must always point to an address in the skb head buffer and not to
- * a fragment.
- *
- * Return: big endian crc32c of the checksummed data
- */
-static __be32 batadv_skb_crc32(struct sk_buff *skb, u8 *payload_ptr)
-{
-	unsigned int to = skb->len;
-	unsigned int consumed = 0;
-	struct skb_seq_state st;
-	unsigned int from;
-	unsigned int len;
-	const u8 *data;
-	u32 crc = 0;
-
-	from = (unsigned int)(payload_ptr - skb->data);
-
-	skb_prepare_seq_read(skb, from, to, &st);
-	while ((len = skb_seq_read(consumed, &data, &st)) != 0) {
-		crc = crc32c(crc, data, len);
-		consumed += len;
-	}
-
-	return htonl(crc);
-}
-
 /**
  * batadv_bla_check_duplist() - Check if a frame is in the broadcast dup.
  * @bat_priv: the bat priv with all the mesh interface information
  * @skb: contains the multicast packet to be checked
- * @payload_ptr: pointer to position inside the head buffer of the skb
- *  marking the start of the data to be CRC'ed
+ * @payload_offset: offset in the skb, marking the start of the data to be CRC'ed
  * @orig: originator mac address, NULL if unknown
  *
  * Check if it is on our broadcast list. Another gateway might have sent the
@@ -1638,16 +1603,18 @@ static __be32 batadv_skb_crc32(struct sk_buff *skb, u8 *payload_ptr)
  * Return: true if a packet is in the duplicate list, false otherwise.
  */
 static bool batadv_bla_check_duplist(struct batadv_priv *bat_priv,
-				     struct sk_buff *skb, u8 *payload_ptr,
+				     struct sk_buff *skb, int payload_offset,
 				     const u8 *orig)
 {
 	struct batadv_bcast_duplist_entry *entry;
 	bool ret = false;
+	int payload_len;
 	int i, curr;
-	__be32 crc;
+	u32 crc;
 
 	/* calculate the crc ... */
-	crc = batadv_skb_crc32(skb, payload_ptr);
+	payload_len = skb->len - payload_offset;
+	crc = skb_crc32c(skb, payload_offset, payload_len, 0);
 
 	spin_lock_bh(&bat_priv->bla.bcast_duplist_lock);
 
@@ -1727,7 +1694,7 @@ static bool batadv_bla_check_duplist(struct batadv_priv *bat_priv,
 static bool batadv_bla_check_ucast_duplist(struct batadv_priv *bat_priv,
 					   struct sk_buff *skb)
 {
-	return batadv_bla_check_duplist(bat_priv, skb, (u8 *)skb->data, NULL);
+	return batadv_bla_check_duplist(bat_priv, skb, 0, NULL);
 }
 
 /**
@@ -1745,12 +1712,10 @@ bool batadv_bla_check_bcast_duplist(struct batadv_priv *bat_priv,
 				    struct sk_buff *skb)
 {
 	struct batadv_bcast_packet *bcast_packet;
-	u8 *payload_ptr;
 
 	bcast_packet = (struct batadv_bcast_packet *)skb->data;
-	payload_ptr = (u8 *)(bcast_packet + 1);
 
-	return batadv_bla_check_duplist(bat_priv, skb, payload_ptr,
+	return batadv_bla_check_duplist(bat_priv, skb, sizeof(*bcast_packet),
 					bcast_packet->orig);
 }
 
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index ae1d7a8dc480fd6b49bb8d5ec02359b8aa21d5c2..8fc5fe0e9b05398c9e1af6417453f4a09bc74e14 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -734,7 +734,7 @@ struct batadv_bcast_duplist_entry {
 	u8 orig[ETH_ALEN];
 
 	/** @crc: crc32 checksum of broadcast payload */
-	__be32 crc;
+	u32 crc;
 
 	/** @entrytime: time when the broadcast packet was received */
 	unsigned long entrytime;

---
base-commit: def64eeace3150b88d5823fcb733dadd79d7562a
change-id: 20250928-skb_crc32c-042889bf2de5

Best regards,
-- 
Sven Eckelmann <sven@narfation.org>

