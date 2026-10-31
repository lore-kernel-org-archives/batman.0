Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C7A606A31A
	for <batman@archiver.kernel.org>; Sat, 31 Oct 2026 20:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=narfation.org header.i=@narfation.org header.a=rsa-sha256 header.s=20121 header.b=BjYsvLDu
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 6889F81181
	for <batman@archiver.kernel.org>; Sat, 31 Oct 2026 21:32:15 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1793478735;
 b=Ayk953aq6YpScWmCMtuw7PJicpU9sx1d3ivnCISgPj+gI+j/+oyWTJWx1usNZgO1nj/rH
 IGPNGK3i0eyUHOQQWmsxCU2hML2+kuGnYjmqjUlO4f7wgGvldniBsNTEMD/qoc0EmCm/dVE
 RovXFDBTG11uQyJD19GNdnoZUb/kmTs=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1793478735; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=6tyOMpVUjKjpXOBCeo1mB9pQtNhNLB0s1nUKm5gsAc4=;
 b=QOaWS5OoRUKDmRxwxn1ob45gvpczJwTKkUKAII/4MTpPhsWPV22bPDdkT7U9K5QNCXwS5
 AGuvWu0wS+wK2xQ++RLJu/LamO5cEQIQMyYh/YVHWkd0ecJ7KU0isGUbOwkAOvNL9ssUOpy
 g7E8HtioEbQSv3Xi7st7+IAJF+cWkMM=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id A531184134
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sat, 31 Oct 2026 21:30:28 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1793478638;
	b=KQXhFxIYtBCvkEs0lKhzx3y1l3B0skVnLW7Cr6eoZXexyz+grTAJxc9t9WNxKWCUT2m0Kq
	LuP730A94biTMFBg7CrKxJ9G+4XQmH2cNTzkcoEN9plwoGGTYxHJ1h/C3uocf+uIr9ktnY
	JtXcnK23dtBE6Tq48d3i7E5LrAMD4FQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1793478638;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=6tyOMpVUjKjpXOBCeo1mB9pQtNhNLB0s1nUKm5gsAc4=;
	b=ssa7ZsPDJ2Yh+2PrVgxDFNkwWfTiS12F5RLhvhjnio22h8rrTQAox+vwXcVfaDMMS5nxVZ
	ziHqEwvqtY3SJg+nu/BtpRCV9oC4SZTiqg8I3e4JxS0vgShn6s0cA8qN7M0hTUj/+4oczP
	LQu2TMf6/LWCZxPpFrptY4ohrQtp5Hw=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=BjYsvLDu;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id CFD2120FED;
	Sat, 31 Oct 2026 20:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1793478627;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6tyOMpVUjKjpXOBCeo1mB9pQtNhNLB0s1nUKm5gsAc4=;
	b=BjYsvLDu7umT9VWua3vrWQJc0lyzZRPOsBDcDAN6yv4EITGHDTH8jLpOfr3fSlUSEUgkri
	i2Op3Ks+hTexXHxRww/dcq2eIkl7fAqHtR/HdUpeHgimqCD5nOTsDwnX/69+0kDPH/5IKp
	phnzh/5ydkTknfMrLGlDV9HdAvn0sDw=
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 31 Oct 2026 21:29:42 +0100
Subject: [PATCH batadv v4 2/7] batman-adv: dat: annotate last_update with
 READ/WRITE_ONCE
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261031-dat-last_update-once-v4-2-3f7994b1f5fe@narfation.org>
References: <20261031-dat-last_update-once-v4-0-3f7994b1f5fe@narfation.org>
In-Reply-To: <20261031-dat-last_update-once-v4-0-3f7994b1f5fe@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>, Sashiko <sashiko-bot@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2891; i=sven@narfation.org;
 h=from:subject:message-id; bh=XXV/Pz2q1TVKXg9k9wLkuNW4nf4jf1BYLwliKiadWas=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFnP/HfZ7z98pLqx+R/P9b0N15Y0+z/Sjv3MJe79I2PnH
 f+Tf96KdJSyMIhxMciKKbLsuZJ/fjP7W/nP0z4ehZnDygQyhIGLUwAmInyLkeHAHq4Sz9741fcO
 My5aJCOSu/eE99L4Q2+unPdLuj6r0PsuI8OZiI87bXYf9GOfeDN0na2tWshlq21bt10rlvBJ22N
 7Yg4LAA==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: KU2WXSBLU36ECCA6WZ6VGI2C4VMR7CRN
X-Message-ID-Hash: KU2WXSBLU36ECCA6WZ6VGI2C4VMR7CRN
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/KU2WXSBLU36ECCA6WZ6VGI2C4VMR7CRN/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_NONE,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The last_update field for batadv_dat_entry tracks the jiffies value of
the most recent activity and is used to detect timeouts. These accesses are
not consistently protected by a lock, so READ_ONCE/WRITE_ONCE must be used
to prevent data races caused by compiler optimizations.

To avoid an underflow due to an non-strict order read of jiffies vs
last_update, use jiffies_delta_to_msecs instead of jiffies_to_msecs to
evaluate the delta.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/bug/linux-4933a0a0-367e-43b3-8da5-29ae37dfdff3
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/distributed-arp-table.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/net/batman-adv/distributed-arp-table.c b/net/batman-adv/distributed-arp-table.c
index 0260ed7e..7e82c154 100644
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
@@ -940,6 +941,7 @@ batadv_dat_cache_dump_entry(struct sk_buff *msg, u32 portid,
 			    struct batadv_dat_entry *dat_entry)
 {
 	u8 mac[ETH_ALEN] __aligned(2);
+	unsigned long last_update;
 	u64 u64_mac;
 	int msecs;
 	void *hdr;
@@ -952,7 +954,8 @@ batadv_dat_cache_dump_entry(struct sk_buff *msg, u32 portid,
 
 	genl_dump_check_consistent(cb, hdr);
 
-	msecs = jiffies_to_msecs(jiffies - dat_entry->last_update);
+	last_update = READ_ONCE(dat_entry->last_update);
+	msecs = jiffies_delta_to_msecs(jiffies - last_update);
 	u64_mac = atomic64_read(&dat_entry->mac_addr);
 	u64_to_ether_addr(u64_mac, mac);
 

-- 
2.47.3

