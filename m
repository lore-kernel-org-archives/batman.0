Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3786B606A31A
	for <batman@archiver.kernel.org>; Sun, 25 Oct 2026 15:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=narfation.org header.i=@narfation.org header.a=rsa-sha256 header.s=20121 header.b=xNIspeyc
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id C1963842E5
	for <batman@archiver.kernel.org>; Sun, 25 Oct 2026 16:51:04 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1792943464;
 b=dhV3PNBmpuYd5su6wBXifjbb7qlU44oxPVxl9QooGN9XZCUvlWQn2HmwRQo2yjlqHvado
 QnGypM6lq7GWsgT6XJjo8aN1DpQHVX6n0EQ7pqL+OegqCO6R3pL7kGUHtuzoTf0d7QMD9vU
 4i4dgNnmxl3EYLVjSf8sED61LSKGUlA=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1792943464; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=ehYMEHHGo7NQDw42PEfMrASiO3ASzL/CMLI1n6NGrTw=;
 b=0bDKBWXekZUiuWUda0SolYtCIblP/qRRGTTXjKRke6OzZFy1v2uu3jpdpQrc7b2HI7wDP
 U6JmOARQrlH+RVRiFaW9ZFXCxpW10xxfmP2BhRCNUMMFuin0DJzeXcujT6QxIrMkowuXJ9d
 p3VqPDbc4G5M/4z623hkro6OLo/JtJE=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id EFA5B80110
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 25 Oct 2026 16:50:49 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1792943450;
	b=enHnLAR7hGwcHhgdR5B6WrCQheZYOQYqEagEYosPpP4O/FKfAi9ZjSy9gqPjxhV+s/ow92
	xabFh7odPxWRCNtZUDzA+TFMf82CLoPvtDUzDhFgf4glnh33CpfStSeqYTjORL6yMKBtVj
	u7eSRt/DrL5IenoJ+O6Z+FWld4gSVFs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1792943450;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=ehYMEHHGo7NQDw42PEfMrASiO3ASzL/CMLI1n6NGrTw=;
	b=1mpneekWaHzSe0xcuRhG/8uaCUrSHTPu0CQipFRrsChq96z3+unWGMf4F2FzHB4bumW7EO
	MVvNTwgwvex2HiVpL2PJqpXVz45PWuTTDWT+u4aZWl6OJt6BuFrux+4vMBHtP3aQXzEode
	wufZk1cHrZwTTNp/USGxRtAlKACIl30=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=xNIspeyc;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id E8CB720210;
	Sun, 25 Oct 2026 15:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1792943449;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ehYMEHHGo7NQDw42PEfMrASiO3ASzL/CMLI1n6NGrTw=;
	b=xNIspeycz0Naaf9JorgWAC85ymxE4Ong2yaS0FIU4WQqQ65rjGDPrIMV50A/Kkp/T24/q6
	O3j6CbqciQKtumBPXLL5YormF9JIfannbQfpCDMQ/C1z6YXel6uUsz9qtn2ePH2/GgrlHO
	cJBissemIBh1g1J0gWUmgWqnbZa27nM=
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 25 Oct 2026 16:50:30 +0100
Subject: [PATCH batadv v2] batman-adv: avoid torn u64 counter reads on
 32-bit systems
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261025-torn-u64-counters-v2-1-becb0a291d4f@narfation.org>
X-B4-Tracking: v=1; b=H4sIAEUl3moC/32OQQ6DIBREr2L+ur8RS6l21Xs0LhA+ShdgAEkb4
 92Ldt/lTGbezAqRgqUI92qFQNlG610RzakCNUk3ElpdNDR1I1hdc0w+OFwER+UXlyhENPo2XLo
 rY1wLKL05kLHvg/mEQSapM/Q/Py7Di1TagXtysrHgPsd4Zkf+z05myLDlrDOmU0K38uFkMDKVx
 2cfRui3bfsCD4NbQtAAAAA=
X-Change-ID: 20261004-torn-u64-counters-fd7b395114d6
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sashiko <sashiko-bot@kernel.org>, Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6070; i=sven@narfation.org;
 h=from:subject:message-id; bh=Iwh4Nqi6npTv9Oa++ZuNclJ/go6WXU/wW6bcYPu3lW4=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFn3VN1uGEbWM37Yel1wfkDxu0fnqtfx7nf5/dMuRNFE4
 d+8vnuzOkpZGMS4GGTFFFn2XMk/v5n9rfznaR+PwsxhZQIZwsDFKQAT8V/KyHBj/7oy1v25TWxp
 NgUnWE7vmGaxbJVgwXWPK29n1/163d7HyDDjLd/Epta5WzZxc8VfW9q+NfBEaW3O/DNxCXarV/2
 ctYoJAA==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: UBUANA56GU5KT4ZFWOFL5AOWBG2N2I3Z
X-Message-ID-Hash: UBUANA56GU5KT4ZFWOFL5AOWBG2N2I3Z
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/UBUANA56GU5KT4ZFWOFL5AOWBG2N2I3Z/>
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

On a 32-bit architecture, concurrent updates and reads of the 64-bit
per-CPU counters result in torn reads. It is necessary to share a
sync-point with the batadv_add_counter() and batadv_sum_counter() to ensure
that a potential write (which modifies the upper u32 too) can be retried by
batadv_sum_counter().

The counters are switched to u64_stats_t to also get properly annotated
(local64) accesses on 64 bit systems.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/bug/linux-34735281-9ca5-437f-9539-e7cd553e3b18
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
Changes in v2:
- switch directly to u64_stats_t instead of u64
- Link to v1: https://patch.msgid.link/20261004-torn-u64-counters-v1-1-8419ff9c6d8a@narfation.org
---
 net/batman-adv/main.h           | 15 +++++++++++++--
 net/batman-adv/mesh-interface.c | 23 +++++++++++++++++++----
 net/batman-adv/types.h          | 21 ++++++++++++++++-----
 3 files changed, 48 insertions(+), 11 deletions(-)

diff --git a/net/batman-adv/main.h b/net/batman-adv/main.h
index e738758e..fb938e08 100644
--- a/net/batman-adv/main.h
+++ b/net/batman-adv/main.h
@@ -199,6 +199,7 @@ enum batadv_uev_type {
 /* Kernel headers */
 
 #include <linux/atomic.h>
+#include <linux/bottom_half.h>
 #include <linux/compiler.h>
 #include <linux/etherdevice.h>
 #include <linux/if_vlan.h>
@@ -207,6 +208,7 @@ enum batadv_uev_type {
 #include <linux/percpu.h>
 #include <linux/skbuff.h>
 #include <linux/types.h>
+#include <linux/u64_stats_sync.h>
 #include <uapi/linux/batadv_packet.h>
 
 #include "types.h"
@@ -339,12 +341,21 @@ static inline bool batadv_has_timed_out(unsigned long timestamp,
  * @idx: counter index which should be modified
  * @count: value to increase counter by
  *
- * Stop preemption on local cpu while incrementing the counter
+ * Stop bottom halves on local cpu while incrementing the counter. The 64 bit
+ * update is additionally guarded by the u64_stats_sync to allow (for 32 bit)
+ * readers on other CPUs to detect torn reads.
  */
 static inline void batadv_add_counter(struct batadv_priv *bat_priv, size_t idx,
 				      size_t count)
 {
-	this_cpu_add(bat_priv->bat_counters[idx], count);
+	struct batadv_pcpu_counters *counters;
+
+	local_bh_disable();
+	counters = this_cpu_ptr(bat_priv->bat_counters);
+	u64_stats_update_begin(&counters->syncp);
+	u64_stats_add(&counters->cnt[idx], count);
+	u64_stats_update_end(&counters->syncp);
+	local_bh_enable();
 }
 
 /**
diff --git a/net/batman-adv/mesh-interface.c b/net/batman-adv/mesh-interface.c
index d1263c77..b3323937 100644
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
+			val = u64_stats_read(&counters->cnt[idx]);
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
index c19caa84..ba76318b 100644
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
+	u64_stats_t cnt[BATADV_CNT_NUM];
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
base-commit: 08b79268afb43880f861c12ec9a34d1ccb85ab2f
change-id: 20261004-torn-u64-counters-fd7b395114d6

Best regards,
--  
Sven Eckelmann <sven@narfation.org>

