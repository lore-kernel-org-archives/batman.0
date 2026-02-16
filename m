Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 571EAE83827
	for <batman@archiver.kernel.org>; Mon, 16 Feb 2026 19:53:00 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id B534D8561E
	for <batman@archiver.kernel.org>; Mon, 16 Feb 2026 20:52:58 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1771271578;
 b=BkC3Z9Sr6zZrcGTYyI7ThcOx/7lVQYayUHRKc9RWl+/M9mgjVpL1IH0RA+PFJn19K+zPe
 QHJm/TT/LPpHvTpNEsKp4Mks/Fg1Mb3vp4UZ3ZPZXQLvAIbmPfMJrXBI0y7rX4yMvc4bfGJ
 C2c9f5pF/UnmXe8wGxYos/QNia0U9Ew=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1771271578; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=7eRLHvhRo8rlr8IbjqlArcy5MBxrjigw18Z1ocPPia0=;
 b=P+2eB//ube2XjGZHlWNsIlMkefHPVG0eBcepzjjkAlzvYyh9g1qYLOixGL/dqsjt4hIeS
 w8DmI+7KkuLPAmcevaJSVTLIq3Nc5CLaAmCKkLgWZhMi2bxkkefHL2V/wgOKMGZThTI2m4Q
 3WGoATmxcH8ruurnsyDNhbf4L/W8NB4=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 300358281E
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 16 Feb 2026 20:52:52 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1771271572;
	b=GtIrcofgoV/StEhyv7FezCywtV3woBkEZC9RI7Yrt6LEKD+7Xsjc5SQf9vc56VPWpecbr+
	klLwbUruIKkaT769l2xwb+J6/cdJv4FUUoKBZjwKIKuVxqWGSXIhMVea8CgJ12pVMVwNm0
	t9qbK2U7x0lXzqFfHxX6WvQQpUYLAW8=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=CgREwmP1;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1771271572;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=7eRLHvhRo8rlr8IbjqlArcy5MBxrjigw18Z1ocPPia0=;
	b=EkP+kbA+I7kcj7YRY/iVr36UOuXzu60EfEBWw+Ujw1GkRQG7JTmIIL5TSh76MYZZx6O1Ax
	wCxtpnanzkbCqbRGzdJfYFgjPaaRZ5NUOsEES6JBoK7VEuFmsXADXt0T7Sg07UJhRS7xDE
	Ss/4SdhdyMYo3m1RovNrHr7CYUyKqKc=
Received: by dvalin.narfation.org (Postfix) id 5C9411FFF0;
	Mon, 16 Feb 2026 19:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1771271571;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7eRLHvhRo8rlr8IbjqlArcy5MBxrjigw18Z1ocPPia0=;
	b=CgREwmP1S3ZO//2NLDZ/ruuzN3SG0DwZEMhKlDZbyoiR+inZ2niIz1UWA+tiKpNs5Duffu
	LB5kaJomv/7ZIptjM231VnobhkZzF57I+e5jZt2bPpLsNfHs9dLNzAoErt2wi53q1nr1Kq
	ycuvWE63FwES/2qIrI95QiCrkob9KeM=
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 16 Feb 2026 20:52:44 +0100
Subject: [PATCH] batman-adv: Switch to type-aware kmalloc-family helpers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260216-alloc_obj-v1-1-4d72b5f32e2d@narfation.org>
X-B4-Tracking: v=1; b=H4sIAIt1k2kC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDI0Mz3cScnPzk+PykLN0UQ9OkRJM0MwNjo1QloPqCotS0zAqwWdGxtbU
 APF7meVsAAAA=
X-Change-ID: 20260216-alloc_obj-d15ba4f6032e
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=12578; i=sven@narfation.org;
 h=from:subject:message-id; bh=aRRY6eIXB2T9hPaOvaJ6nKKfommuGLBVDXVS/ng2ui8=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDJmTS3ue5fo3nNvjx8tRcvVf1CevdcuZchRkFD93TzjK9
 WXl9RVGHaUsDGJcDLJiiix7ruSf38z+Vv7ztI9HYeawMoEMYeDiFICJSIgx/BUs/+vsr8ubFWLm
 +fHHzf83JVSDlyaF6t++lrwjzXmtyn9GhnOnLj9e9yNdZ+eH2OPn+CU6r6sEhdd2xqap/gzd6rP
 jEDcA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: 3I6VMCBAJD6US2JHROIEPDM2JGDV7AJE
X-Message-ID-Hash: 3I6VMCBAJD6US2JHROIEPDM2JGDV7AJE
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
Archived-At: <>
List-Archive: <>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

The commit 2932ba8d9c99 ("slab: Introduce kmalloc_obj() and family")
introduced helpers to provide type information to the allocator. At the
same time, the open-coding of kmalloc assignments was deprecated.

Use the new helpers to benefit from the future enhancements in the
allocator/validator infrastructure.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 compat-include/linux/slab.h            | 29 +++++++++++++++++++++++++++++
 compat-include/net/addrconf.h          |  2 +-
 net/batman-adv/bat_v_elp.c             |  2 +-
 net/batman-adv/bridge_loop_avoidance.c |  4 ++--
 net/batman-adv/distributed-arp-table.c |  5 ++---
 net/batman-adv/fragmentation.c         |  2 +-
 net/batman-adv/gateway_client.c        |  2 +-
 net/batman-adv/hard-interface.c        |  2 +-
 net/batman-adv/hash.c                  |  7 +++----
 net/batman-adv/mesh-interface.c        |  2 +-
 net/batman-adv/multicast.c             |  6 +++---
 net/batman-adv/originator.c            | 12 ++++++------
 net/batman-adv/send.c                  |  2 +-
 net/batman-adv/tp_meter.c              |  6 +++---
 net/batman-adv/tvlv.c                  |  2 +-
 15 files changed, 56 insertions(+), 29 deletions(-)

diff --git a/compat-include/linux/slab.h b/compat-include/linux/slab.h
new file mode 100644
index 00000000..4211278e
--- /dev/null
+++ b/compat-include/linux/slab.h
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) B.A.T.M.A.N. contributors:
+ *
+ * Marek Lindner, Simon Wunderlich
+ *
+ * This file contains macros for maintaining compatibility with older versions
+ * of the Linux kernel.
+ */
+
+#ifndef _NET_BATMAN_ADV_COMPAT_LINUX_SLAB_H_
+#define _NET_BATMAN_ADV_COMPAT_LINUX_SLAB_H_
+
+#include <linux/version.h>
+#include_next <linux/slab.h>
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(7, 1, 0)
+
+#define kzalloc_obj(P, GFP) \
+	kzalloc(sizeof(P), GFP)
+
+#define kmalloc_obj(P, GFP) \
+	kmalloc(sizeof(P), GFP)
+
+#define kmalloc_objs(P, COUNT, GFP) \
+	kmalloc_array((COUNT), sizeof(P), GFP)
+
+#endif /* < KERNEL_VERSION(7, 1, 0) */
+
+#endif	/* _NET_BATMAN_ADV_COMPAT_LINUX_SLAB_H_ */
diff --git a/compat-include/net/addrconf.h b/compat-include/net/addrconf.h
index f0a3c0a6..2e48813a 100644
--- a/compat-include/net/addrconf.h
+++ b/compat-include/net/addrconf.h
@@ -61,7 +61,7 @@ compat_batadv_mcast_mla_meshif_get_ipv6(struct net_device *dev,
 		if (batadv_mcast_mla_is_duplicate(mcast_addr, mcast_list))
 			continue;
 
-		new = kmalloc(sizeof(*new), GFP_ATOMIC);
+		new = kmalloc_obj(*new, GFP_ATOMIC);
 		if (!new) {
 			ret = -ENOMEM;
 			break;
diff --git a/net/batman-adv/bat_v_elp.c b/net/batman-adv/bat_v_elp.c
index cb16c1ed..2ce4e5bf 100644
--- a/net/batman-adv/bat_v_elp.c
+++ b/net/batman-adv/bat_v_elp.c
@@ -355,7 +355,7 @@ static void batadv_v_elp_periodic_work(struct work_struct *work)
 		 * context. Therefore add it to metric_queue and process it
 		 * outside rcu protected context.
 		 */
-		metric_entry = kzalloc(sizeof(*metric_entry), GFP_ATOMIC);
+		metric_entry = kzalloc_obj(*metric_entry, GFP_ATOMIC);
 		if (!metric_entry) {
 			batadv_hardif_neigh_put(hardif_neigh);
 			continue;
diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
index 3dc791c1..49ae92b9 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -505,7 +505,7 @@ batadv_bla_get_backbone_gw(struct batadv_priv *bat_priv, const u8 *orig,
 		   "%s(): not found (%pM, %d), creating new entry\n", __func__,
 		   orig, batadv_print_vid(vid));
 
-	entry = kzalloc(sizeof(*entry), GFP_ATOMIC);
+	entry = kzalloc_obj(*entry, GFP_ATOMIC);
 	if (!entry)
 		return NULL;
 
@@ -699,7 +699,7 @@ static void batadv_bla_add_claim(struct batadv_priv *bat_priv,
 
 	/* create a new claim entry if it does not exist yet. */
 	if (!claim) {
-		claim = kzalloc(sizeof(*claim), GFP_ATOMIC);
+		claim = kzalloc_obj(*claim, GFP_ATOMIC);
 		if (!claim)
 			return;
 
diff --git a/net/batman-adv/distributed-arp-table.c b/net/batman-adv/distributed-arp-table.c
index 8b8132eb..3efc4cf5 100644
--- a/net/batman-adv/distributed-arp-table.c
+++ b/net/batman-adv/distributed-arp-table.c
@@ -381,7 +381,7 @@ static void batadv_dat_entry_add(struct batadv_priv *bat_priv, __be32 ip,
 		goto out;
 	}
 
-	dat_entry = kmalloc(sizeof(*dat_entry), GFP_ATOMIC);
+	dat_entry = kmalloc_obj(*dat_entry, GFP_ATOMIC);
 	if (!dat_entry)
 		goto out;
 
@@ -635,8 +635,7 @@ batadv_dat_select_candidates(struct batadv_priv *bat_priv, __be32 ip_dst,
 	if (!bat_priv->orig_hash)
 		return NULL;
 
-	res = kmalloc_array(BATADV_DAT_CANDIDATES_NUM, sizeof(*res),
-			    GFP_ATOMIC);
+	res = kmalloc_objs(*res, BATADV_DAT_CANDIDATES_NUM, GFP_ATOMIC);
 	if (!res)
 		return NULL;
 
diff --git a/net/batman-adv/fragmentation.c b/net/batman-adv/fragmentation.c
index cc14bc41..f4e45cc2 100644
--- a/net/batman-adv/fragmentation.c
+++ b/net/batman-adv/fragmentation.c
@@ -156,7 +156,7 @@ static bool batadv_frag_insert_packet(struct batadv_orig_node *orig_node,
 	seqno = ntohs(frag_packet->seqno);
 	bucket = seqno % BATADV_FRAG_BUFFER_COUNT;
 
-	frag_entry_new = kmalloc(sizeof(*frag_entry_new), GFP_ATOMIC);
+	frag_entry_new = kmalloc_obj(*frag_entry_new, GFP_ATOMIC);
 	if (!frag_entry_new)
 		goto err;
 
diff --git a/net/batman-adv/gateway_client.c b/net/batman-adv/gateway_client.c
index 7a11b245..51e9c081 100644
--- a/net/batman-adv/gateway_client.c
+++ b/net/batman-adv/gateway_client.c
@@ -332,7 +332,7 @@ static void batadv_gw_node_add(struct batadv_priv *bat_priv,
 	if (gateway->bandwidth_down == 0)
 		return;
 
-	gw_node = kzalloc(sizeof(*gw_node), GFP_ATOMIC);
+	gw_node = kzalloc_obj(*gw_node, GFP_ATOMIC);
 	if (!gw_node)
 		return;
 
diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index 5113f879..7b7640f3 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -871,7 +871,7 @@ batadv_hardif_add_interface(struct net_device *net_dev)
 	if (!batadv_is_valid_iface(net_dev))
 		return NULL;
 
-	hard_iface = kzalloc(sizeof(*hard_iface), GFP_ATOMIC);
+	hard_iface = kzalloc_obj(*hard_iface, GFP_ATOMIC);
 	if (!hard_iface)
 		return NULL;
 
diff --git a/net/batman-adv/hash.c b/net/batman-adv/hash.c
index 8016e619..759fa291 100644
--- a/net/batman-adv/hash.c
+++ b/net/batman-adv/hash.c
@@ -45,16 +45,15 @@ struct batadv_hashtable *batadv_hash_new(u32 size)
 {
 	struct batadv_hashtable *hash;
 
-	hash = kmalloc(sizeof(*hash), GFP_ATOMIC);
+	hash = kmalloc_obj(*hash, GFP_ATOMIC);
 	if (!hash)
 		return NULL;
 
-	hash->table = kmalloc_array(size, sizeof(*hash->table), GFP_ATOMIC);
+	hash->table = kmalloc_objs(*hash->table, size, GFP_ATOMIC);
 	if (!hash->table)
 		goto free_hash;
 
-	hash->list_locks = kmalloc_array(size, sizeof(*hash->list_locks),
-					 GFP_ATOMIC);
+	hash->list_locks = kmalloc_objs(*hash->list_locks, size, GFP_ATOMIC);
 	if (!hash->list_locks)
 		goto free_table;
 
diff --git a/net/batman-adv/mesh-interface.c b/net/batman-adv/mesh-interface.c
index 9d72fcdc..50c26037 100644
--- a/net/batman-adv/mesh-interface.c
+++ b/net/batman-adv/mesh-interface.c
@@ -555,7 +555,7 @@ int batadv_meshif_create_vlan(struct batadv_priv *bat_priv, unsigned short vid)
 		return -EEXIST;
 	}
 
-	vlan = kzalloc(sizeof(*vlan), GFP_ATOMIC);
+	vlan = kzalloc_obj(*vlan, GFP_ATOMIC);
 	if (!vlan) {
 		spin_unlock_bh(&bat_priv->meshif_vlan_list_lock);
 		return -ENOMEM;
diff --git a/net/batman-adv/multicast.c b/net/batman-adv/multicast.c
index 2d5244a1..7dba0c2b 100644
--- a/net/batman-adv/multicast.c
+++ b/net/batman-adv/multicast.c
@@ -406,7 +406,7 @@ batadv_mcast_mla_meshif_get_ipv4(struct net_device *dev,
 		if (batadv_mcast_mla_is_duplicate(mcast_addr, mcast_list))
 			continue;
 
-		new = kmalloc(sizeof(*new), GFP_ATOMIC);
+		new = kmalloc_obj(*new, GFP_ATOMIC);
 		if (!new) {
 			ret = -ENOMEM;
 			break;
@@ -479,7 +479,7 @@ batadv_mcast_mla_meshif_get_ipv6(struct net_device *dev,
 		if (batadv_mcast_mla_is_duplicate(mcast_addr, mcast_list))
 			continue;
 
-		new = kmalloc(sizeof(*new), GFP_ATOMIC);
+		new = kmalloc_obj(*new, GFP_ATOMIC);
 		if (!new) {
 			ret = -ENOMEM;
 			break;
@@ -639,7 +639,7 @@ static int batadv_mcast_mla_bridge_get(struct net_device *dev,
 		if (batadv_mcast_mla_is_duplicate(mcast_addr, mcast_list))
 			continue;
 
-		new = kmalloc(sizeof(*new), GFP_ATOMIC);
+		new = kmalloc_obj(*new, GFP_ATOMIC);
 		if (!new) {
 			ret = -ENOMEM;
 			break;
diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
index a662408a..b3468cca 100644
--- a/net/batman-adv/originator.c
+++ b/net/batman-adv/originator.c
@@ -179,7 +179,7 @@ batadv_orig_node_vlan_new(struct batadv_orig_node *orig_node,
 	if (vlan)
 		goto out;
 
-	vlan = kzalloc(sizeof(*vlan), GFP_ATOMIC);
+	vlan = kzalloc_obj(*vlan, GFP_ATOMIC);
 	if (!vlan)
 		goto out;
 
@@ -417,7 +417,7 @@ batadv_orig_ifinfo_new(struct batadv_orig_node *orig_node,
 	if (orig_ifinfo)
 		goto out;
 
-	orig_ifinfo = kzalloc(sizeof(*orig_ifinfo), GFP_ATOMIC);
+	orig_ifinfo = kzalloc_obj(*orig_ifinfo, GFP_ATOMIC);
 	if (!orig_ifinfo)
 		goto out;
 
@@ -495,7 +495,7 @@ batadv_neigh_ifinfo_new(struct batadv_neigh_node *neigh,
 	if (neigh_ifinfo)
 		goto out;
 
-	neigh_ifinfo = kzalloc(sizeof(*neigh_ifinfo), GFP_ATOMIC);
+	neigh_ifinfo = kzalloc_obj(*neigh_ifinfo, GFP_ATOMIC);
 	if (!neigh_ifinfo)
 		goto out;
 
@@ -575,7 +575,7 @@ batadv_hardif_neigh_create(struct batadv_hard_iface *hard_iface,
 	if (hardif_neigh)
 		goto out;
 
-	hardif_neigh = kzalloc(sizeof(*hardif_neigh), GFP_ATOMIC);
+	hardif_neigh = kzalloc_obj(*hardif_neigh, GFP_ATOMIC);
 	if (!hardif_neigh)
 		goto out;
 
@@ -683,7 +683,7 @@ batadv_neigh_node_create(struct batadv_orig_node *orig_node,
 	if (!hardif_neigh)
 		goto out;
 
-	neigh_node = kzalloc(sizeof(*neigh_node), GFP_ATOMIC);
+	neigh_node = kzalloc_obj(*neigh_node, GFP_ATOMIC);
 	if (!neigh_node)
 		goto out;
 
@@ -947,7 +947,7 @@ struct batadv_orig_node *batadv_orig_node_new(struct batadv_priv *bat_priv,
 	batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
 		   "Creating new originator: %pM\n", addr);
 
-	orig_node = kzalloc(sizeof(*orig_node), GFP_ATOMIC);
+	orig_node = kzalloc_obj(*orig_node, GFP_ATOMIC);
 	if (!orig_node)
 		return NULL;
 
diff --git a/net/batman-adv/send.c b/net/batman-adv/send.c
index 20d85c68..60cd67ec 100644
--- a/net/batman-adv/send.c
+++ b/net/batman-adv/send.c
@@ -503,7 +503,7 @@ batadv_forw_packet_alloc(struct batadv_hard_iface *if_incoming,
 		return NULL;
 	}
 
-	forw_packet = kmalloc(sizeof(*forw_packet), GFP_ATOMIC);
+	forw_packet = kmalloc_obj(*forw_packet, GFP_ATOMIC);
 	if (!forw_packet)
 		goto err;
 
diff --git a/net/batman-adv/tp_meter.c b/net/batman-adv/tp_meter.c
index 350b149e..2e42f6b3 100644
--- a/net/batman-adv/tp_meter.c
+++ b/net/batman-adv/tp_meter.c
@@ -967,7 +967,7 @@ void batadv_tp_start(struct batadv_priv *bat_priv, const u8 *dst,
 		return;
 	}
 
-	tp_vars = kmalloc(sizeof(*tp_vars), GFP_ATOMIC);
+	tp_vars = kmalloc_obj(*tp_vars, GFP_ATOMIC);
 	if (!tp_vars) {
 		spin_unlock_bh(&bat_priv->tp_list_lock);
 		batadv_dbg(BATADV_DBG_TP_METER, bat_priv,
@@ -1228,7 +1228,7 @@ static bool batadv_tp_handle_out_of_order(struct batadv_tp_vars *tp_vars,
 	u32 payload_len;
 	bool added = false;
 
-	new = kmalloc(sizeof(*new), GFP_ATOMIC);
+	new = kmalloc_obj(*new, GFP_ATOMIC);
 	if (unlikely(!new))
 		return false;
 
@@ -1343,7 +1343,7 @@ batadv_tp_init_recv(struct batadv_priv *bat_priv,
 		goto out_unlock;
 	}
 
-	tp_vars = kmalloc(sizeof(*tp_vars), GFP_ATOMIC);
+	tp_vars = kmalloc_obj(*tp_vars, GFP_ATOMIC);
 	if (!tp_vars)
 		goto out_unlock;
 
diff --git a/net/batman-adv/tvlv.c b/net/batman-adv/tvlv.c
index 76dff1f9..8129a3f9 100644
--- a/net/batman-adv/tvlv.c
+++ b/net/batman-adv/tvlv.c
@@ -557,7 +557,7 @@ void batadv_tvlv_handler_register(struct batadv_priv *bat_priv,
 		return;
 	}
 
-	tvlv_handler = kzalloc(sizeof(*tvlv_handler), GFP_ATOMIC);
+	tvlv_handler = kzalloc_obj(*tvlv_handler, GFP_ATOMIC);
 	if (!tvlv_handler) {
 		spin_unlock_bh(&bat_priv->tvlv.handler_list_lock);
 		return;

---
base-commit: 35208d1234584c536db431441445ce82f09273f6
change-id: 20260216-alloc_obj-d15ba4f6032e

Best regards,
-- 
Sven Eckelmann <sven@narfation.org>

