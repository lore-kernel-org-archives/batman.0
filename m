Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F325CA5FED
	for <batman@archiver.kernel.org>; Tue,  6 Oct 2026 16:48:44 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id E6C6E8409C
	for <batman@archiver.kernel.org>; Tue, 06 Oct 2026 18:48:42 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1791305322;
 b=bhAsPTa7Th5poVS0n0XyEzJ36GdjeixyOu+zwFMl8pBGpOznW5Q5KKqV1z0EfQ9UPY0pc
 lc4KQQFHulA8wXRVbeTG7HB/B/paaZ2g30joBWZtqJCENJDStIkJPwbLAP2ViXIm7YaB6j8
 8Swej+Cc7CvjD91oggfgcz1NEJUnDzo=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1791305322; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=IVFjybQF2hMCbeHhUc4Qupj6B2GRKGvWelIv6DPNWQA=;
 b=MO40fx+3CUHXCza0wXakG3/VjLPgWhiYSnCERcO/LNp6vd9csb+oD/CTrGa/7qTRj3Rgx
 qaGbufs2A7E6DayVFMYhp2e7KAWdOM0J+pDIzP8ZDG+h8E4ony02veBR/pUc8sx2JeLhZBC
 g2R+Z7Xnf02RuOg6N7eVmqBHnw/OISM=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 1024E83CB7
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 06 Oct 2026 18:48:11 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1791305302;
	b=VCAZLqD0a3BgJpGfHBs/7aqMMcimA6QczOviSqD0SCbrcdrm1PuR5LRuO/NDNqzprKtfrW
	xkczG10sGzcV4h0SfJgC+8hUj5Lr5vMN5RM9XDDiYm+fedJfW3mfO+Av4TQ29MU/AW82tB
	T36805yGONLjGRTyi7jJ40jCTrI4RPk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1791305302;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=IVFjybQF2hMCbeHhUc4Qupj6B2GRKGvWelIv6DPNWQA=;
	b=s6cS4mFXd7KFOVK7Y2YZwtcDJmynmXk/q+2MoBYHMeegejlcObAlOfAiyUTYGt46H7Esdk
	4Sm70u1aUdSKPDUaPyQx8EJgI88rj3iSoX4K0mfieFILr6HB569uhA/+yQixjHIuGv7t7Y
	sjLaOs/urrShmX8x98GD3rOBMdWnR1Q=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=YlYv8SCZ;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 6D5681FE24;
	Tue, 06 Oct 2026 16:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1791305291;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IVFjybQF2hMCbeHhUc4Qupj6B2GRKGvWelIv6DPNWQA=;
	b=YlYv8SCZ+pZzE6os4bRxVsWoY4GWrWhFaOG62xJdxeEEOp8b/C/dtdw1Y7JhXJGKnhkIPT
	Gfyh6Tmz0ISc1dlqchPVdtPiIv1rS/Lb2pEbUeZ4gJg/6dP0vKYdVvfxe6W+0bxzPvf8q9
	WdJ+vFQpowvfu2g3OWJu1sQkMEjuXLU=
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 06 Oct 2026 18:47:03 +0200
Subject: [PATCH batadv v3 1/9] batman-adv: dat: annotate last_update with
 READ/WRITE_ONCE
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261006-dat-last_update-once-v3-1-316aefdd5f5f@narfation.org>
References: <20261006-dat-last_update-once-v3-0-316aefdd5f5f@narfation.org>
In-Reply-To: <20261006-dat-last_update-once-v3-0-316aefdd5f5f@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>, Sashiko <sashiko-bot@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2890; i=sven@narfation.org;
 h=from:subject:message-id; bh=W4RdApywG5PyCd++wvUvBJkB4UkL443SXPgUqyaZTUk=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFlH1bg6ywpk5Cd8lH+/eF7flfBpCd/PfN9meeyZY4y9y
 Y/FN9IdO0pZGMS4GGTFFFn2XMk/v5n9rfznaR+PwsxhZQIZwsDFKQATOavI8D/nK69r7gp+rnT+
 59N/vLvSfubT/BeWyUbr+TaoT3vsM3s9I8Nj25Q4bzv2p4ca1zm5+DOcn6TSc+DcARa2nb1W6dM
 EPzECAA==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: NJTAGV5YPUQUWMGKOBJZZUDVEKFVDA6Z
X-Message-ID-Hash: NJTAGV5YPUQUWMGKOBJZZUDVEKFVDA6Z
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/NJTAGV5YPUQUWMGKOBJZZUDVEKFVDA6Z/>
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

