Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA18606A88E
	for <batman@archiver.kernel.org>; Wed, 11 Nov 2026 10:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.a=rsa-sha256 header.s=09092022 header.b=roXxJRjd
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 5F90E84A73
	for <batman@archiver.kernel.org>; Wed, 11 Nov 2026 11:30:14 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1794393014;
 b=kInNITIJRySshB3SjEBI80AKkVBhPueKDSqFeCtIQw2tByJlVithZPj1YTH1MyNDQC4vT
 bpUOio14XTS5TKeZgJ0uUEcNaAtszZk/fbsEoB+ndGnOuxXUD/vOBoEI4/iNpxWzlJuinTi
 81EIzixSO/IKXdeo9IGzwOTb/bK4HoA=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1794393014; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=w9zFH06fEtJge9QM/CiLbfVi79PwZvBhoxCVWpR4J3Q=;
 b=fYAL1eCycbgWkO8F3Gl/dn2BMVoAJ75f7A/XUHaoWli7lo4mGsr9WQ01RwqII85e6K+b1
 BqOb9qea/IC9yUlGC/HvTqimHPKCRWqzYCLflwG6GOUo6kvNtxsFj29Z2qbWs1Qu/Po0ard
 K5uXPL9wEEVaYhL9+cKM6WNB4ah/jAs=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de
 [IPv6:2a01:4f8:c17:e8c0::1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id F208080444
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 11 Nov 2026 11:27:34 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1794392865;
	b=3k5UFTRstHDrg5cjvsDCsZrpV6EB6lkOaNFmHizn2eNsU2Q0GZVfndAuQPKLil7Jq3C00F
	szgETh9AA2umy43ieP6rok2n/hQpo7kU5cy1kpMlAOJA3m1fhjG/qAKyg0hyTv4Q/RO0sq
	FaRxgbS3bCnBvBU/Vu8pwehdE5be0nk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1794392865;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=w9zFH06fEtJge9QM/CiLbfVi79PwZvBhoxCVWpR4J3Q=;
	b=rrbasdqTaXRHDRTVUzIZes9YEDhxcyij9P1MZaTAqDHqb+Eg6GDz9SNlBIAlhxY4O0dmaE
	TOp8o5Bt9MkyoP1L91Ckiu4eLYy4QWDnMNtmU0n73+yP28r8A5dOvC67fMkVSTW29/Vs5l
	S75PZbeHEq6v93Alal0iA2+DlG4f6AA=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=roXxJRjd;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 2a01:4f8:c17:e8c0::1 as permitted sender)
 smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
Received: from kero.packetmixer.de
 (p200300C59740ded843Be7e4a980e9C65.dip0.t-ipconnect.de
 [IPv6:2003:c5:9740:ded8:43be:7e4a:980e:9c65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with UTF8SMTPSA id 5C778FA156;
	Wed, 11 Nov 2026 11:27:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1794392854;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w9zFH06fEtJge9QM/CiLbfVi79PwZvBhoxCVWpR4J3Q=;
	b=roXxJRjdiLI5Xe4NJnZYAct5/NLsQfKc4Lo4Jr6xvU9QLh1J/vpsQxWJ6UM4dD3yUk6BmU
	9OfUlRziUAhfvlhKv610y6UsMLDCZEqUSBOnE1jPGWPuEWydtK8ylgNww+8f6pXAxWjFCa
	qlwaurqk5IZiJns5YJNVb0+aK1Ud7FAsO2V93TTcYViGi8QDL0CnHc9h11N7wzZAA5jQEW
	bbHepONhRuEgx9EwtjkLAgzL3ZHuHs+pWkxPo8d1FZ3rqiTffdVejnljVltZhB4nnJWrlO
	tQYWL79qL3YZbpwd/aznTV0ZBHhh91OFi+zppqZdRyFq/LqEXWVkA/AjYytMBA==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Sven Eckelmann <sven@narfation.org>,
	Sashiko <sashiko-bot@kernel.org>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net-next 04/15] batman-adv: avoid torn u64 counter reads on
 32-bit systems
Date: Wed, 11 Nov 2026 11:27:18 +0100
Message-ID: <20261111102729.2096241-5-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261111102729.2096241-1-sw@simonwunderlich.de>
References: <20261111102729.2096241-1-sw@simonwunderlich.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: LVQBGICHSKBWVXKBY5LINIHPPHXRNKGA
X-Message-ID-Hash: LVQBGICHSKBWVXKBY5LINIHPPHXRNKGA
X-MailFrom: sw@simonwunderlich.de
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/LVQBGICHSKBWVXKBY5LINIHPPHXRNKGA/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_NONE,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Sven Eckelmann <sven@narfation.org>

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
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/main.h           | 15 +++++++++++++--
 net/batman-adv/mesh-interface.c | 23 +++++++++++++++++++----
 net/batman-adv/types.h          | 21 ++++++++++++++++-----
 3 files changed, 48 insertions(+), 11 deletions(-)

diff --git a/net/batman-adv/main.h b/net/batman-adv/main.h
index e738758ee4a7a..fb938e08a3eb2 100644
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
index 6ffc505ce2aba..16b681e10b33d 100644
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
index b3e6dbb360dae..0fece14c7e7f8 100644
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
-- 
2.47.3

