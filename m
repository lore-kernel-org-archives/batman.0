Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFD1BCCD1AB
	for <batman@archiver.kernel.org>; Fri, 24 Oct 2025 09:24:47 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 691BF80385
	for <batman@archiver.kernel.org>; Fri, 24 Oct 2025 11:24:46 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1761297886;
 b=oLq3PugD/51cyEUDlZx/3kj6ZdVPwxMG7EB9NoWHVr7ixy/Q2KbgNW5eDykzSwHkG9h/q
 604ZibhFicq+hYDiLDIrM67tFfsFZfFPh6qB6SU+ID9LKLDsEdllCCXvFczjp5FIQhP2I6Z
 QR0DC/eGYCXL6bwKJ4thzJ6+FQH0UHg=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1761297886; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=OkqVMFSSUwxydrKYN6Sc7lNcaHEl0uHnVntkQefuHws=;
 b=NNGWm8zG+m6qiLju2Mz5f3YLPGJicIivqE5aa9CDUKC+zZxDWJjTAZ/ViEmYFJflMpAmX
 HbSqeXgoIQJpmlLnHRLNUxpBJN4iisvfw2YEGzKxx4U9pDMxiolsI7Uyy9y8DzGgeQHMys7
 EWPDZzbqcPtcc5yxjNni330lre2j89g=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=fail;
 arc=pass;
 dmarc=fail header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass;
 dmarc=fail (Used From Domain Record) header.from=simonwunderlich.de
 policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id F2B44802F2
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 24 Oct 2025 11:23:29 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1761297810;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OkqVMFSSUwxydrKYN6Sc7lNcaHEl0uHnVntkQefuHws=;
	b=CbfvR59Tj1XU7+T3bwfMcwTlnp0Mm0DZBialZue764r0VH7I5Zvc7p7JevVInHy9p/J5N9
	9GK6E14AF60TfLE44RCTRfE7yhGsBQGa0b1oVaG6u2WAhfmRoqtPw8+TafhsSfSs1Kxlcl
	79Qf/fLhhhjYjz5nJ+vIzqS2F5sIm3k=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 23.88.38.48 as permitted sender) smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1761297810; a=rsa-sha256;
	cv=none;
	b=arIm3yMJEWHz/L2bsucd/f1v8bFoeL411Eh5NVqh9gh6Eglj5Uj2NdyqcUOAaopo6CHhJo
	BlkM4ljBCtlfNWON/NYX0sPQShUJfFTrH75jDrqO3M8jdFNxtUFnG9cdX8OXLIKCeoy/1M
	40YRyeOgiXjsIptGyssg0bPYwv1qpzg=
Received: from kero.packetmixer.de
 (p200300C5970781D8B076411Bb4C554a3.dip0.t-ipconnect.de
 [IPv6:2003:c5:9707:81d8:b076:411b:b4c5:54a3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id 8837EFA182;
	Fri, 24 Oct 2025 11:23:29 +0200 (CEST)
From: Simon Wunderlich <sw@simonwunderlich.de>
To: kuba@kernel.org,
	davem@davemloft.net
Cc: netdev@vger.kernel.org,
	b.a.t.m.a.n@lists.open-mesh.org,
	Sven Eckelmann <sven@narfation.org>,
	Eric Biggers <ebiggers@kernel.org>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net-next 2/2] batman-adv: use skb_crc32c() instead of
 skb_seq_read()
Date: Fri, 24 Oct 2025 11:23:15 +0200
Message-ID: <20251024092315.232636-3-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251024092315.232636-1-sw@simonwunderlich.de>
References: <20251024092315.232636-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: XQSUK3IRHYZQWGGS3O657LUM3EQQW7XR
X-Message-ID-Hash: XQSUK3IRHYZQWGGS3O657LUM3EQQW7XR
X-MailFrom: sw@simonwunderlich.de
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/XQSUK3IRHYZQWGGS3O657LUM3EQQW7XR/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Sven Eckelmann <sven@narfation.org>

Make batadv_bla_check_duplist() just use the new function skb_crc32c(),
instead of calling skb_seq_read() with crc32c(). This is faster and
simpler.

Suggested-by: Eric Biggers <ebiggers@kernel.org>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/Kconfig                 |  1 +
 net/batman-adv/bridge_loop_avoidance.c | 51 ++++----------------------
 net/batman-adv/types.h                 |  2 +-
 3 files changed, 10 insertions(+), 44 deletions(-)

diff --git a/net/batman-adv/Kconfig b/net/batman-adv/Kconfig
index c299e2bc87eda..58c408b7a7d9c 100644
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
index b992ba12aa247..3dc791c15bf72 100644
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
index ae1d7a8dc480f..8fc5fe0e9b053 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -734,7 +734,7 @@ struct batadv_bcast_duplist_entry {
 	u8 orig[ETH_ALEN];
 
 	/** @crc: crc32 checksum of broadcast payload */
-	__be32 crc;
+	u32 crc;
 
 	/** @entrytime: time when the broadcast packet was received */
 	unsigned long entrytime;
-- 
2.47.3

