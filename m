Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9834ECA0FF2
	for <batman-adv@archiver.kernel.org>; Sun, 31 Aug 2025 15:42:11 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 24C7584380
	for <batman-adv@archiver.kernel.org>; Sun, 31 Aug 2025 17:42:10 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1756654930;
 b=elS5Ma+UBTL+7CzJtNz4FTMFEXwjJLUefhlMUiWc8ns5Jk57DS+JLwtGQWVgWJEMk0EJF
 4jcCoqFpm23o4f4rFrd6oNNQ7nyUKb1c5/ip1/kTgWSCIe9Lg5GaYiDx5UZ8LVm3H6WVB1A
 ILFWgfPkQ4NIaJ/X4+5RFm5OYTMI+Vc=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1756654930; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=bLfaCSeZh8HpLBZQcHqlzMUVy/XVPr2WwY7q513T5Bk=;
 b=niS+iESaVOHjKCy9VdUJt0doUO2ZlzOT2p6QXFo1kzfrZ9rAtt/avOIggDzRd/bHufJvo
 B/5LamfXGjizBTV0cHWldw4C8eDOs9XHKArGyC6qER2RWzDd7keaYyca4f5V2tYaTh48l1E
 bI2ELgHKIoTG8o+I7LOAHFRBYYh7XgM=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 13BCF83C7D
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 31 Aug 2025 17:40:16 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1756654816;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=bLfaCSeZh8HpLBZQcHqlzMUVy/XVPr2WwY7q513T5Bk=;
	b=gRJoUwd+8cMGv9nKLN7+Yrbc+Uh+qMSJEZ77OnzYqzK1RwwN2/F4OSlqU3YyaoX1x70BOx
	PSUVIxOuqLRp5Lt27EI0MOuj5gVNuJYxcp9Kf3b4JP8vjiKW8DbtBOjk0Plkq2LHANdlUG
	zAV3/kiRpDTgfQHlTYhuCraCT8An02E=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b="i6b/MPju";
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1756654816; a=rsa-sha256;
	cv=none;
	b=rpqMi51uzZl0JgLd1zwL0OiHGCWdGmDGE7WdOOV65cxj/vVOBhqueaimTA0j4IEw88Aj7f
	nzWW5J/cPQJ/519urLqhQV3N6dx/zSFneIj1R/AtDfOIicQNOn4HboJMQ1VuO+MzwWU0HB
	658YMikcIEUeiHuhyo/2C81eqd3Sq9Y=
Received: by dvalin.narfation.org (Postfix) id B7BE32009B;
	Sun, 31 Aug 2025 15:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1756654815;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bLfaCSeZh8HpLBZQcHqlzMUVy/XVPr2WwY7q513T5Bk=;
	b=i6b/MPjurQJCP8vIqEk0t+M4rNq5R82cuoZXQfHry7JmEblGPDk3hQCIgkMKbDs58S1cGE
	wfLgCpUYxpgK8AL67HN66Q6LR1+35HWaivFGsHx5Fu4zSGx4lSqOIqg5zzefMpGf9CmHPk
	2W/gaGtJMqbScTMMc9e3TQZpo+b+irE=
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 31 Aug 2025 17:40:02 +0200
Subject: [PATCH 2/2] batman-adv: keep skb crc32 helper local in BLA
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250831-drop-catwoman-v1-2-1071bb2a159a@narfation.org>
References: <20250831-drop-catwoman-v1-0-1071bb2a159a@narfation.org>
In-Reply-To: <20250831-drop-catwoman-v1-0-1071bb2a159a@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4473; i=sven@narfation.org;
 h=from:subject:message-id; bh=IwctTqncvhkg8nKT+ekFgWEk2KBvSqinw7NZtrKHi7k=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDBlbcq6oXs266JCjMFNph8mn4zb3iuJWSXd97Z6bfGH2h
 rhlyvtYOkpZGMS4GGTFFFn2XMk/v5n9rfznaR+PwsxhZQIZwsDFKQATqT3JyNCyepXOi7R9flfP
 se8yuBBwaqpEm71hKEvtOffDvxfMOM/AyHBlz82vM941f9y43CDFYNdjwaTJ6ROZw3daet+6xJj
 zdi0XAA==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: IXK523WRUDEY7CHJP6RAEUO6UG6SFWNX
X-Message-ID-Hash: IXK523WRUDEY7CHJP6RAEUO6UG6SFWNX
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/IXK523WRUDEY7CHJP6RAEUO6UG6SFWNX/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

The batadv_skb_crc32() helper was shared between Bridge Loop Avoidance and
Network Coding. With the removal of the network coding feature, it is
possible to just move this helper directly to Bridge Loop Avoidance.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/bridge_loop_avoidance.c | 34 ++++++++++++++++++++++++++++++++++
 net/batman-adv/main.c                  | 34 ----------------------------------
 net/batman-adv/main.h                  |  1 -
 3 files changed, 34 insertions(+), 35 deletions(-)

diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
index 747755647c6a4a6130856cb822551b7ec51ea7ce..b992ba12aa2478a338155d2fe46a75e970306bd5 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -12,6 +12,7 @@
 #include <linux/compiler.h>
 #include <linux/container_of.h>
 #include <linux/crc16.h>
+#include <linux/crc32.h>
 #include <linux/err.h>
 #include <linux/errno.h>
 #include <linux/etherdevice.h>
@@ -1584,6 +1585,39 @@ int batadv_bla_init(struct batadv_priv *bat_priv)
 	return 0;
 }
 
+/**
+ * batadv_skb_crc32() - calculate CRC32 of the whole packet and skip bytes in
+ *  the header
+ * @skb: skb pointing to fragmented socket buffers
+ * @payload_ptr: Pointer to position inside the head buffer of the skb
+ *  marking the start of the data to be CRC'ed
+ *
+ * payload_ptr must always point to an address in the skb head buffer and not to
+ * a fragment.
+ *
+ * Return: big endian crc32c of the checksummed data
+ */
+static __be32 batadv_skb_crc32(struct sk_buff *skb, u8 *payload_ptr)
+{
+	unsigned int to = skb->len;
+	unsigned int consumed = 0;
+	struct skb_seq_state st;
+	unsigned int from;
+	unsigned int len;
+	const u8 *data;
+	u32 crc = 0;
+
+	from = (unsigned int)(payload_ptr - skb->data);
+
+	skb_prepare_seq_read(skb, from, to, &st);
+	while ((len = skb_seq_read(consumed, &data, &st)) != 0) {
+		crc = crc32c(crc, data, len);
+		consumed += len;
+	}
+
+	return htonl(crc);
+}
+
 /**
  * batadv_bla_check_duplist() - Check if a frame is in the broadcast dup.
  * @bat_priv: the bat priv with all the mesh interface information
diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index 1dcacfc310ee9ccbe58519e96ce3a317eaf3ac58..3a35aadd8b41913fbe1e16ada1203cf3b22fbb32 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -11,7 +11,6 @@
 #include <linux/build_bug.h>
 #include <linux/byteorder/generic.h>
 #include <linux/container_of.h>
-#include <linux/crc32.h>
 #include <linux/device.h>
 #include <linux/errno.h>
 #include <linux/gfp.h>
@@ -561,39 +560,6 @@ void batadv_recv_handler_unregister(u8 packet_type)
 	batadv_rx_handler[packet_type] = batadv_recv_unhandled_packet;
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
-__be32 batadv_skb_crc32(struct sk_buff *skb, u8 *payload_ptr)
-{
-	u32 crc = 0;
-	unsigned int from;
-	unsigned int to = skb->len;
-	struct skb_seq_state st;
-	const u8 *data;
-	unsigned int len;
-	unsigned int consumed = 0;
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
  * batadv_get_vid() - extract the VLAN identifier from skb if any
  * @skb: the buffer containing the packet
diff --git a/net/batman-adv/main.h b/net/batman-adv/main.h
index 170689de7288a50b5c85dd9fb5911c1f1476421b..9ec31b62a7222ab3a1019cf88d03a0693c5ee912 100644
--- a/net/batman-adv/main.h
+++ b/net/batman-adv/main.h
@@ -248,7 +248,6 @@ batadv_recv_handler_register(u8 packet_type,
 			     int (*recv_handler)(struct sk_buff *,
 						 struct batadv_hard_iface *));
 void batadv_recv_handler_unregister(u8 packet_type);
-__be32 batadv_skb_crc32(struct sk_buff *skb, u8 *payload_ptr);
 
 /**
  * batadv_compare_eth() - Compare two not u16 aligned Ethernet addresses

-- 
2.47.2

