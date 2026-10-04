Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACAB9CA5FEC
	for <batman@archiver.kernel.org>; Sun,  4 Oct 2026 09:02:50 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 0893183CCD
	for <batman@archiver.kernel.org>; Sun, 04 Oct 2026 11:02:49 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1791104569;
 b=GEmd5tQoSPDgbo6ko19T0g58eoMxUw0TDC+LG5hiD2OUtOayrXCs9arPlBhuGCdZDbgnI
 WePbKeopI1v6NIzqrW4ElqYnTxXqWe+Z2hcP7MgjJy36udYK+AA9OSHTfWXrGoo8rN9GfYQ
 1fhPKSmkQOyF2eilM3eD4DvWWgs26r4=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1791104569; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=356uWOPZeqrhhQgiKTeYTDcZTJQdZKVtZe/0R+b/NuI=;
 b=qXXdGBFQ28jgr5luBpdEkSK2+ejTjbamN3h4FTBipSRUl+OsaGkqHxLHFXbI9lDS+FYFZ
 bAgtpdMWvnCHSP2FpnwBjthFq2TJaUOGM2R5mMLEX9klwkyC5PKT7m4InoQLtvDBnaevacD
 SzltAOXRkdntvs9hMZzb4cuo0RAfM0E=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 76B0F81098
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 04 Oct 2026 11:02:29 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1791104560;
	b=FZFVxMDovaXLVf5OW/HDv0fSJLOXaeq7nhfRsjHgWLCRs9BpGHeHxnpzkG6yumSSsriWuB
	GMthTE5BOi3/oSm6FYM+RLTSjNNznMJf5s61YW+OeIaksHYv8usGUdX3YTZRepZhCj+yzx
	g91EqM79fqZdIn5lJGlgk6TXVlDbmn4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1791104560;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=356uWOPZeqrhhQgiKTeYTDcZTJQdZKVtZe/0R+b/NuI=;
	b=gxzLLO133an0Cc2p+fs/ffrnc5G9huhFaVYIfHEV+U3vdHsA9/iO9vMi6IAGbrin2wI0Fs
	/dT5Sf4JIfATmchTqztiV5WYI21xTQVcA5pDkh3g1C+18/VwR3dGi64BpFhIwT71gdJ+S9
	z3JELGkkSH54z16vFtA3FkfE/eYGqzM=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=xl2CAZzH;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id C2429202F3;
	Sun, 04 Oct 2026 09:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1791104548;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=356uWOPZeqrhhQgiKTeYTDcZTJQdZKVtZe/0R+b/NuI=;
	b=xl2CAZzHcLx48zsyaIwpZiCFggqYviTs3Sv4jh6TSSwQN4rtByULrdGNkK9H9DiTcPAwXH
	iNTcXcHNLkFlwaJtTlKRd1Mc43e2JCeVq0oXOS8QKqtJPWImCNHhfcW8Bj/i/JYkVdQYJX
	8R1xpU4E+TEz4nGfoyOhNIHu0SOOAco=
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 04 Oct 2026 11:02:22 +0200
Subject: [PATCH batadv] batman-adv: avoid torn u64 counter reads on u32
 systems
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261004-torn-u64-counters-v1-1-8419ff9c6d8a@narfation.org>
X-B4-Tracking: v=1; b=H4sIAB0WwmoC/yWMywrCMBAAf6Xs2YWkxoj+ivSQx1bjIZHdpAil/
 95YjzMws4IQJxK4DyswLUlSyR30aYDwcvlJmGJnGNVotVIGa+GMzRoMpeVKLDjHqz/fLlqbaKF
 3H6Y5fY/nA7yrLi4w/b00/6ZQf0PYth0VDMeUfQAAAA==
X-Change-ID: 20261004-torn-u64-counters-fd7b395114d6
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sashiko <sashiko-bot@kernel.org>, Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6034; i=sven@narfation.org;
 h=from:subject:message-id; bh=89cD3r7ZGBXBDUlEhyv8o/paYxzcRG4doBFC9bt1xAE=;
 b=kA0DAAoWTQ93K9MU9csByyZiAGrCFiCjayotiispIJXMDOjJjvq1juBUKxGhqVgbH6ZDxBTZ1
 Ih1BAAWCgAdFiEEvNRvz7MH7R/zlvHFTQ93K9MU9csFAmrCFiAACgkQTQ93K9MU9csnvAEA3TWR
 sUIENgpYddJwpICDbe+NFRGxg2C6psMuZ+02X1QA/iHrjkzVNOc44IIc17LyAe5cpj0qRghQdnW
 vXqfzgGQF
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: 2FONIMKVURYK6YPF35HOE4D7B45CXEMO
X-Message-ID-Hash: 2FONIMKVURYK6YPF35HOE4D7B45CXEMO
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/2FONIMKVURYK6YPF35HOE4D7B45CXEMO/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

On a 32-bit architecture, concurrent updates and reads of the 64-bit
per-CPU counters result in torn reads. It is necessary to share a
sync-point with the batadv_add_counter() and batadv_sum_counter() to ensure
that a potential write (which modifies the upper u32 too) can be retried by
batadv_sum_counter().

The overhead in the batadv_add_counter() can be avoided on a 64 bit system
because the whole u64 can be written with a single instruction.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/bug/linux-34735281-9ca5-437f-9539-e7cd553e3b18
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/main.h           | 20 ++++++++++++++++++--
 net/batman-adv/mesh-interface.c | 23 +++++++++++++++++++----
 net/batman-adv/types.h          | 21 ++++++++++++++++-----
 3 files changed, 53 insertions(+), 11 deletions(-)

diff --git a/net/batman-adv/main.h b/net/batman-adv/main.h
index e738758e..b3f2b445 100644
--- a/net/batman-adv/main.h
+++ b/net/batman-adv/main.h
@@ -198,7 +198,9 @@ enum batadv_uev_type {
 
 /* Kernel headers */
 
+#include <asm/bitsperlong.h>
 #include <linux/atomic.h>
+#include <linux/bottom_half.h>
 #include <linux/compiler.h>
 #include <linux/etherdevice.h>
 #include <linux/if_vlan.h>
@@ -207,6 +209,7 @@ enum batadv_uev_type {
 #include <linux/percpu.h>
 #include <linux/skbuff.h>
 #include <linux/types.h>
+#include <linux/u64_stats_sync.h>
 #include <uapi/linux/batadv_packet.h>
 
 #include "types.h"
@@ -339,12 +342,25 @@ static inline bool batadv_has_timed_out(unsigned long timestamp,
  * @idx: counter index which should be modified
  * @count: value to increase counter by
  *
- * Stop preemption on local cpu while incrementing the counter
+ * Stop preemption on local cpu while incrementing the counter. On 32 bit
+ * systems, the 64 bit update is additionally guarded by the u64_stats_sync to
+ * allow readers on other CPUs to detect torn reads.
  */
 static inline void batadv_add_counter(struct batadv_priv *bat_priv, size_t idx,
 				      size_t count)
 {
-	this_cpu_add(bat_priv->bat_counters[idx], count);
+#if BITS_PER_LONG == 32
+	struct batadv_pcpu_counters *counters;
+
+	local_bh_disable();
+	counters = this_cpu_ptr(bat_priv->bat_counters);
+	u64_stats_update_begin(&counters->syncp);
+	counters->cnt[idx] += count;
+	u64_stats_update_end(&counters->syncp);
+	local_bh_enable();
+#else
+	this_cpu_add(bat_priv->bat_counters->cnt[idx], count);
+#endif
 }
 
 /**
diff --git a/net/batman-adv/mesh-interface.c b/net/batman-adv/mesh-interface.c
index 41d14863..412dfad1 100644
--- a/net/batman-adv/mesh-interface.c
+++ b/net/batman-adv/mesh-interface.c
@@ -37,6 +37,7 @@
 #include <linux/stddef.h>
 #include <linux/string.h>
 #include <linux/types.h>
+#include <linux/u64_stats_sync.h>
 #include <linux/utsname.h>
 #include <net/netlink.h>
 #include <net/rtnetlink.h>
@@ -92,13 +93,21 @@ int batadv_skb_head_push(struct sk_buff *skb, unsigned int len)
  */
 static u64 batadv_sum_counter(struct batadv_priv *bat_priv,  size_t idx)
 {
-	u64 *counters;
+	struct batadv_pcpu_counters *counters;
+	unsigned int start;
 	u64 sum = 0;
+	u64 val;
 	int cpu;
 
 	for_each_possible_cpu(cpu) {
 		counters = per_cpu_ptr(bat_priv->bat_counters, cpu);
-		sum += counters[idx];
+
+		do {
+			start = u64_stats_fetch_begin(&counters->syncp);
+			val = counters->cnt[idx];
+		} while (u64_stats_fetch_retry(&counters->syncp, start));
+
+		sum += val;
 	}
 
 	return sum;
@@ -802,9 +811,10 @@ static void batadv_set_lockdep_class(struct net_device *dev)
  */
 static int batadv_meshif_init_late(struct net_device *dev)
 {
-	size_t cnt_len = sizeof(u64) * BATADV_CNT_NUM;
+	struct batadv_pcpu_counters *counters;
 	struct batadv_priv *bat_priv;
 	u32 random_seqno;
+	int cpu;
 	int ret;
 
 	batadv_set_lockdep_class(dev);
@@ -815,10 +825,15 @@ static int batadv_meshif_init_late(struct net_device *dev)
 	/* batadv_interface_stats() needs to be available as soon as
 	 * register_netdevice() has been called
 	 */
-	bat_priv->bat_counters = __alloc_percpu(cnt_len, __alignof__(u64));
+	bat_priv->bat_counters = alloc_percpu(struct batadv_pcpu_counters);
 	if (!bat_priv->bat_counters)
 		return -ENOMEM;
 
+	for_each_possible_cpu(cpu) {
+		counters = per_cpu_ptr(bat_priv->bat_counters, cpu);
+		u64_stats_init(&counters->syncp);
+	}
+
 	WRITE_ONCE(bat_priv->aggregated_ogms, 1);
 	WRITE_ONCE(bat_priv->bonding, 0);
 #ifdef CONFIG_BATMAN_ADV_BLA
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index c19caa84..5b501202 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -27,6 +27,7 @@
 #include <linux/spinlock.h>
 #include <linux/timer.h>
 #include <linux/types.h>
+#include <linux/u64_stats_sync.h>
 #include <linux/wait.h>
 #include <linux/workqueue.h>
 #include <uapi/linux/batadv_packet.h>
@@ -986,6 +987,19 @@ enum batadv_counters {
 	BATADV_CNT_NUM,
 };
 
+/**
+ * struct batadv_pcpu_counters - per cpu traffic counters
+ */
+struct batadv_pcpu_counters {
+	/** @cnt: traffic counters (see batadv_counters) */
+	u64 cnt[BATADV_CNT_NUM];
+
+	/**
+	 * @syncp: synchronization for 64 bit counter access on 32 bit systems
+	 */
+	struct u64_stats_sync syncp;
+};
+
 /**
  * struct batadv_priv_tt - per mesh interface translation table data
  */
@@ -1564,11 +1578,8 @@ struct batadv_priv {
 	 */
 	int mtu_set_by_user;
 
-	/**
-	 * @bat_counters: mesh internal traffic statistic counters (see
-	 *  batadv_counters)
-	 */
-	u64 __percpu *bat_counters; /* Per cpu counters */
+	/** @bat_counters: mesh internal traffic statistic counters */
+	struct batadv_pcpu_counters __percpu *bat_counters;
 
 	/**
 	 * @aggregated_ogms: bool indicating whether OGM aggregation is enabled

---
base-commit: 4fa5cbac90fa7b8936779b4313debb3d89701c59
change-id: 20261004-torn-u64-counters-fd7b395114d6

Best regards,
--  
Sven Eckelmann <sven@narfation.org>

