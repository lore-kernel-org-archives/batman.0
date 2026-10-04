Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 043A0CA5FCE
	for <batman@archiver.kernel.org>; Sun,  4 Oct 2026 10:10:55 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 9826F844AC
	for <batman@archiver.kernel.org>; Sun, 04 Oct 2026 12:10:53 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1791108653;
 b=gnEys24IHtndQmqSyV/RPhbpU1NBW2f8ki1fDltjfJR5R0Gw9IboiwSnh/O5vgApbWUq2
 V5v9xxxft4K7Y3lcYlbR0DBnahr1a6p/7dZyb207mQQRFmQBJqLH6VYIWM7UQISMrlYBkh+
 1j//gvzPBHGkZHQgU3VV+17THPHVp68=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1791108653; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=IVFjybQF2hMCbeHhUc4Qupj6B2GRKGvWelIv6DPNWQA=;
 b=0Ugo7D4XrJx/TCwp7DWUphDHuFSPW3d8dguMyUDjAV7GrknT423Z9JsuNuydUJaBReHtL
 OvorpAjnhxYvXOLzN6um6EkkLSlOUBy/PClsupdwjWo/3gugiQl8nxSU3Xw7WKzKIumO4x5
 xUV0U/LQZWCGhEKRakWjNiFIVKUFOcQ=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id A9A2D80F1E
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 04 Oct 2026 12:09:03 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1791108553;
	b=N2Ahsg5e1hvV1f9Zbbsj8hWfP0t8R+ffTI0xhLvEjAEp/tQtvwzW7nfQUl6/QvX0ZKcLwU
	shVebOvBa1j4eOJOJKUXCytFPR5hDUv4mGECgapo/P7+o1Yq9+5LgQacVw+UziZwheGFS/
	glOIEWYoFBTSd4NBpsbHTy9dN7nS0C4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1791108553;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=IVFjybQF2hMCbeHhUc4Qupj6B2GRKGvWelIv6DPNWQA=;
	b=4HDwYEZcxFCwJvOb3VruC4ae3J67yV5+LLEaPLJ+tW2FH2D9l7NRCN2crwtC/2KOa+6x/2
	ptzpyuek7qy06WDutjZ0HGIjs32iL3mSSZsgZpbKodHp03u5osccOvR8L8vQ6RQKynACZ4
	R3YsiRW1k6xHJJk/RvwmIJW55GujzPw=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=SWrOERq8;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 0F06320494;
	Sun, 04 Oct 2026 10:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1791108543;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IVFjybQF2hMCbeHhUc4Qupj6B2GRKGvWelIv6DPNWQA=;
	b=SWrOERq88ytYTc07A+XWKgUFYPNVZlSJP5fIW7b0BimMto8ZWE4yRMMzd0Ny14ZZLgWIF9
	6HkSTBOPJzPwg4NMXsO+cp5DgmmC55UvKMXEI5R0gkiINXUYP4Jze4W5ZcfB9UP8IY6E8v
	8M5W1h6geB/MqjyRdfKM1H+03B/uDIk=
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 04 Oct 2026 12:08:36 +0200
Subject: [PATCH batadv v2 1/9] batman-adv: dat: annotate last_update with
 READ/WRITE_ONCE
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261004-dat-last_update-once-v2-1-ab012a4b18ed@narfation.org>
References: <20261004-dat-last_update-once-v2-0-ab012a4b18ed@narfation.org>
In-Reply-To: <20261004-dat-last_update-once-v2-0-ab012a4b18ed@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>, Sashiko <sashiko-bot@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2890; i=sven@narfation.org;
 h=from:subject:message-id; bh=W4RdApywG5PyCd++wvUvBJkB4UkL443SXPgUqyaZTUk=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFmHVLe83bWjc17zi60i09ea/LY/+d9Do7BN7eqkv/47e
 epf3I9c2lHKwiDGxSArpsiy50r++c3sb+U/T/t4FGYOKxPIEAYuTgGYiGUJw2+WE2dcg9gmfsmY
 uePzzd69N3cZNMq84G162h79/oz9lY2LGH4yBkwXFTsV91rhZ3u1kfLMg8ynpkWdf5XiGZhYn3X
 psRgDAA==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: ZSUGBV5ZGBHLMVUW3FUAGLD3PO3D62M4
X-Message-ID-Hash: ZSUGBV5ZGBHLMVUW3FUAGLD3PO3D62M4
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/ZSUGBV5ZGBHLMVUW3FUAGLD3PO3D62M4/>
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

To avoid an underflow due to an non-strict order read of jffies vs
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
 

-- 
2.47.3

