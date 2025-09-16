Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0E97CAC599
	for <batman-adv@archiver.kernel.org>; Tue, 16 Sep 2025 12:28:42 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 86ED684942
	for <batman-adv@archiver.kernel.org>; Tue, 16 Sep 2025 14:28:41 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1758025721;
 b=rL1+Uxw8D9jN4+pATMW7RTAyGSvuu68wNiy2sEG78eHJLbUN88frxrceuGAGVWIDaBpCW
 jiRDMHAoL5W0V1/cpuilkp3dfZHMkoR3tnHdXQd93e7R+AdApa3m9nrwlQfQGhl/wPariM1
 cmnpTlrJAed7zfg8VObW8gJQlQfuawE=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1758025721; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=6c62MKOJXeTZLmCt0hSUry5kUwn8OUoQHI3nlhpFGEE=;
 b=pCPMxDUIBv2q51OFqvF/7fIfSfYMbWFsvgYg8CWSYP4v7fwWN60tkOycAr6CoHkgGyr+O
 k+nIHl+kYmGAOsWVD3imMHKb09rkfzga+piOrYPYXD8IoCneg/mTaFzSG+Dkp17Yzd8OQuy
 lcDn/YLtmfGKdvnewvxyYaiUCjbwPNs=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=fail;
 arc=pass;
 dmarc=fail header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass;
 dmarc=fail (Used From Domain Record) header.from=simonwunderlich.de
 policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de
 [IPv6:2a01:4f8:c17:e8c0::1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id CEB408460F
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 16 Sep 2025 14:24:52 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1758025497;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6c62MKOJXeTZLmCt0hSUry5kUwn8OUoQHI3nlhpFGEE=;
	b=mcE4fMD/00uE6KCGpcdqBQNyW4ZdmcGfvvHRcTLaRpXNZhCil5nliHlgaP3S+pgwPgn/A2
	aTMCAin1lX59cqTyQUrsYY9XyL2gsCdta13qm7bjU7I1MD1M0RTRVkEvPF7JbNSqe00EMJ
	KSBHLvxr6rzDJloBZDIgvi/i51n2Udg=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	dmarc=pass (policy=none) header.from=simonwunderlich.de;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 2a01:4f8:c17:e8c0::1 as permitted sender) smtp.mailfrom=sw@simonwunderlich.de
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1758025497; a=rsa-sha256;
	cv=none;
	b=jjpWAvqm4O9ZXENZqfmx4bm4F9/5X8AnxH6wVFescPRLY8iknU6YVgKgBPojUqh/3ZILff
	K9rpN0Uzw3+EzWRMmkcSx1H1F/9zQ4nIpsDYI2s52yeU2PPG1fi5ZVVsS3dXLprn6VGtYq
	vQ37n4b/35VzwRUpjW7OKusLTWKnxLg=
Received: from kero.packetmixer.de
 (p200300C5972536D8604E0a64D0d3AaD8.dip0.t-ipconnect.de
 [IPv6:2003:c5:9725:36d8:604e:a64:d0d3:aad8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id C9808FA184;
	Tue, 16 Sep 2025 14:24:51 +0200 (CEST)
From: Simon Wunderlich <sw@simonwunderlich.de>
To: kuba@kernel.org,
	davem@davemloft.net
Subject: [PATCH net-next 3/4] batman-adv: keep skb crc32 helper local in BLA
Date: Tue, 16 Sep 2025 14:24:40 +0200
Message-ID: <20250916122441.89246-4-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250916122441.89246-1-sw@simonwunderlich.de>
References: <20250916122441.89246-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: 3VZ2B7P7DC2MP7RUMT6P6TTKLKNZ4VLK
X-Message-ID-Hash: 3VZ2B7P7DC2MP7RUMT6P6TTKLKNZ4VLK
X-MailFrom: sw@simonwunderlich.de
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
CC: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/3VZ2B7P7DC2MP7RUMT6P6TTKLKNZ4VLK/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Sven Eckelmann <sven@narfation.org>

The batadv_skb_crc32() helper was shared between Bridge Loop Avoidance and
Network Coding. With the removal of the network coding feature, it is
possible to just move this helper directly to Bridge Loop Avoidance.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/bridge_loop_avoidance.c | 34 ++++++++++++++++++++++++++
 net/batman-adv/main.c                  | 34 --------------------------
 net/batman-adv/main.h                  |  1 -
 3 files changed, 34 insertions(+), 35 deletions(-)

diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
index 747755647c6a4..b992ba12aa247 100644
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
index 1dcacfc310ee9..3a35aadd8b419 100644
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
index 7352b11df968c..2be1ac17acaa4 100644
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
2.47.3

