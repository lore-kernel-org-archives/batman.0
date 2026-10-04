Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9569CA5FE6
	for <batman@archiver.kernel.org>; Sun,  4 Oct 2026 07:57:21 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id E579C8449F
	for <batman@archiver.kernel.org>; Sun, 04 Oct 2026 09:57:19 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1791100639;
 b=jjx8RdfsZqJHINtbrhq4Q/SDdSiqt51E1mJxh9p53N7LiyQooEiuFe1fiFd2cqfbjjTUv
 x+v0acSGk7aYgfsHxiUWhgQ8GGdxzF2mgwIXPR2NKrfUZSrCWVxb/wPK0YI9sqJIwI2H324
 T/fcJZOPbmsnc4FJdtfvPEGbDpeYGWo=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1791100639; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=2KcrtIMnuQRQN1ge6Yz1FFT4AIGJvNxJpEN9BZ7258I=;
 b=NRm8/4loHXfe+Govx2BKeGCgN+3qxPeJaqc1nvp8Gh/Zc1hgVh4x8weEIyiUwyMA6IoVd
 4i02Jrc2gQadngDSdB8hvnb5oDnFPg2+xB7Zp630bK/dLBDC0uHOayH8buKaALAWJh+76Y9
 grsMHa8K1iiXwumSjBYBY/DxSCAnwtE=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 11E0380914
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 04 Oct 2026 09:57:10 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1791100630;
	b=T0AhpdRMRao5YBiwVVkRet/aypvp6gizpF0UwZ8Itd57Gnu2kEgWNUFHFOXKmx6BKlCc7E
	CXExrmBzvD7KcdDOHnWyPGYjPqKyJe40juORnEB2D81qHXB6TgoQvFw7hBZIdYOa4lc6vM
	/EfE5rxpJgmXqtlWSjxqKJG8tmWIG1c=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1791100630;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=2KcrtIMnuQRQN1ge6Yz1FFT4AIGJvNxJpEN9BZ7258I=;
	b=FVkSfFvEmEPUgUnZz2NEOdbDb/2zaA7iBmLMxpr6GEi6LB6iJHyQHHEziU7udd4VsBmHDt
	mUse23B5WEk37hSdMyNe2tSkKNsafk9lrDGX3WtvXMiB7EP14JfV/tLLs6eOqQIk80At02
	6ulimG1Bx4yzGCYTUj1Hi9ViGl6yT5o=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=AAgVC8al;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 42579202F3;
	Sun, 04 Oct 2026 07:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1791100629;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2KcrtIMnuQRQN1ge6Yz1FFT4AIGJvNxJpEN9BZ7258I=;
	b=AAgVC8alUIZetvI2Fl2GaZNu+389SjA/2xzndaWdbs100omrsHrpk1Tr74qSCRD6NwLKcA
	/FIYn1pTZ25eeSz6hsfUiavsJz+gKmHOlj6U4QMtACqccL48GwC5TdsnCeoY/lhjzMH7UC
	ViZlzJ1eBRb+Dic3LQONMqli9yHSinI=
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 04 Oct 2026 09:56:59 +0200
Subject: [PATCH batadv] batman-adv: dat: annotate last_update with
 READ/WRITE_ONCE
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261004-dat-last_update-once-v1-1-f774d740e498@narfation.org>
X-B4-Tracking: v=1; b=H4sIAMoGwmoC/yWMUQrCMBAFr1L224WkFkWvIiKb5EUjkpZsWoTSu
 xv1782DmZUUJUHp3K1UsCRNY25gdx35h+Q7OIXG1Jv+YI0ZOEjll2i9zVOb4DF7MI6DnPw+wkV
 LTZ0KYnr/shdyUiUsdP3/OrsnfP02ads+rh5Q34AAAAA=
X-Change-ID: 20261004-dat-last_update-once-e74a9c3febf1
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sashiko <sashiko-bot@kernel.org>, Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3052; i=sven@narfation.org;
 h=from:subject:message-id; bh=qeEdNYjIfLH9Q2NbifYPMN9AjnG1p0HAhgYDQMbepNw=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFmH2C7N8OM+c3H7LL3lO4932j9wUHpTG2W9/+Lu3DM7v
 EU800+97ShlYRDjYpAVU2TZcyX//Gb2t/Kfp308CjOHlQlkCAMXpwBMRMWV4b9D2JPt5R1BLI9+
 BNsvupl6y/LPnxu+G7VqE1xUBVQLKpcy/GaviLi2KNPZ6YaMB4P+8+YH0kJH5544mWQSO/uhI7u
 COj8A
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: 2VTQJPOJQGOVLC3YW2QONA4BO6R6LHWS
X-Message-ID-Hash: 2VTQJPOJQGOVLC3YW2QONA4BO6R6LHWS
X-MailFrom: sven@narfation.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-3; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/2VTQJPOJQGOVLC3YW2QONA4BO6R6LHWS/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

The last_update field for batadv_dat_entry tracks the jiffies value of
the most recent activity and is used to detect timeouts. These accesses are
not consistently protected by a lock, so READ_ONCE/WRITE_ONCE must be used
to prevent data races caused by compiler optimizations.

To avoid an underflow dua to an non-strict order read of jffies vs
last_update, use jiffies_delta_to_msecs instead of jiffies_to_msecs to
evaluate the delta.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/bug/linux-4933a0a0-367e-43b3-8da5-29ae37dfdff3
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/distributed-arp-table.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/net/batman-adv/distributed-arp-table.c b/net/batman-adv/distributed-arp-table.c
index 74050bff..79f42a1f 100644
--- a/net/batman-adv/distributed-arp-table.c
+++ b/net/batman-adv/distributed-arp-table.c
@@ -11,6 +11,7 @@
 #include <linux/bitops.h>
 #include <linux/bug.h>
 #include <linux/byteorder/generic.h>
+#include <linux/compiler.h>
 #include <linux/container_of.h>
 #include <linux/err.h>
 #include <linux/errno.h>
@@ -206,7 +207,7 @@ static void batadv_dat_entry_put(struct batadv_dat_entry *dat_entry)
  */
 static bool batadv_dat_to_purge(struct batadv_dat_entry *dat_entry)
 {
-	return batadv_has_timed_out(dat_entry->last_update,
+	return batadv_has_timed_out(READ_ONCE(dat_entry->last_update),
 				    BATADV_DAT_ENTRY_TIMEOUT);
 }
 
@@ -453,7 +454,7 @@ static void batadv_dat_entry_add(struct batadv_priv *bat_priv, __be32 ip,
 	if (dat_entry) {
 		atomic64_set(&dat_entry->mac_addr, u64_mac);
 
-		dat_entry->last_update = jiffies;
+		WRITE_ONCE(dat_entry->last_update, jiffies);
 		batadv_dbg(BATADV_DBG_DAT, bat_priv,
 			   "Entry updated: %pI4 %pM (vid: %d)\n",
 			   &dat_entry->ip, mac_addr,
@@ -468,7 +469,7 @@ static void batadv_dat_entry_add(struct batadv_priv *bat_priv, __be32 ip,
 	dat_entry->ip = ip;
 	dat_entry->vid = vid;
 	atomic64_set(&dat_entry->mac_addr, u64_mac);
-	dat_entry->last_update = jiffies;
+	WRITE_ONCE(dat_entry->last_update, jiffies);
 	kref_init(&dat_entry->refcount);
 
 	kref_get(&dat_entry->refcount);
@@ -939,6 +940,7 @@ batadv_dat_cache_dump_entry(struct sk_buff *msg, u32 portid,
 			    struct batadv_dat_entry *dat_entry)
 {
 	u8 mac[ETH_ALEN] __aligned(2);
+	unsigned long last_update;
 	u64 u64_mac;
 	int msecs;
 	void *hdr;
@@ -951,7 +953,8 @@ batadv_dat_cache_dump_entry(struct sk_buff *msg, u32 portid,
 
 	genl_dump_check_consistent(cb, hdr);
 
-	msecs = jiffies_to_msecs(jiffies - dat_entry->last_update);
+	last_update = READ_ONCE(dat_entry->last_update);
+	msecs = jiffies_delta_to_msecs(jiffies - last_update);
 	u64_mac = atomic64_read(&dat_entry->mac_addr);
 	u64_to_ether_addr(u64_mac, mac);
 

---
base-commit: 4fa5cbac90fa7b8936779b4313debb3d89701c59
change-id: 20261004-dat-last_update-once-e74a9c3febf1

Best regards,
--  
Sven Eckelmann <sven@narfation.org>

