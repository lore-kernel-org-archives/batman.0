Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51D05CD343F
	for <batman@archiver.kernel.org>; Tue, 12 May 2026 19:54:33 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id BF01A85A7B
	for <batman@archiver.kernel.org>; Tue, 12 May 2026 21:54:31 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1778615671;
 b=QMn4dTPRInhYoUnp87B1LR5/bRJlC/AfUhQUhXJCdSOKE6oJZnuNA1xPEv3+WhpnNq+13
 If92fyllIvawXGTqS5Xf7LAP32ZJ/xdfUHIdTdpj1/9lhR2VCoXT3CZT3cT45XhN97PAkwW
 6fxzrj/0R3lOi+7u4noK3Jw9mUHGoNY=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1778615671; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=vf17YTn+8gGdkTOx+LgjEiptUXnmXq8vWVHtq4Cq8oc=;
 b=1wNT3P9PN0CD4KBGjHpuKJmbu+UQTK6ecPNWvv7ltijL7dIxHG8OzgAN4YyCeKUOp+M+W
 t/hDgXvRJrZJCFz9K7ZzgDWv4Jbg463ty7IdqVi51lKbE1dK14CFwRjb7gt9B1+gF3XAVY4
 VfPAi+F9Ikq9CzLmWvNfBP71V9RUNV0=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id CED4785594
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 12 May 2026 21:53:33 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1778615613;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=vf17YTn+8gGdkTOx+LgjEiptUXnmXq8vWVHtq4Cq8oc=;
	b=rCYvcxvO/sNOsh0HE6YpWOhq7Id/IQqAbI28ym1emcmsrbYEuSp99NaDxuZvIdfRtYaTX1
	n6stC68JOBzC57l4OPqcA6KBSUwpVUTVVq7nP/oPNx6W4D7PS4cRbHBVQc6JThxSKzNdeU
	Xd3ipUkjtnwTSquqvjAentcyp3lhRmY=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=kXnc8Axj;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1778615613;
	b=2ebvnW0kEDyBPhDyHaBYEEtAiCDACzYy6yAmlYaHOGGL7mKM+WPtvx6gkwvpgeOpqo5zrm
	jb0BfzBXHP3HFLS1xqAkwHl5h6qF/45s7BaWBhoDEejlg668GCDDIgivvF255uZTA3YSLt
	NiW7a3mcLQIrYpgoZhtxh6LnEU8LnHA=
Received: by dvalin.narfation.org (Postfix) id 79B54217E2;
	Tue, 12 May 2026 19:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1778615613;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vf17YTn+8gGdkTOx+LgjEiptUXnmXq8vWVHtq4Cq8oc=;
	b=kXnc8AxjtMVJRb7waHpYdiCVg6XfbslruKNIJl3R3dns0P1P27ui/43OBopFDL70y6UGDB
	wA7n6+sskfs3jihjr+XHoC4P0+M6Md9JM5GWhBw3iMp9HpEigBUUTFSBqpGu4TA79ALL08
	UjUmpGc54mEM7Eix1stttooRzdMPr9o=
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 12 May 2026 21:53:07 +0200
Subject: [PATCH batadv 2/7] batman-adv: replace non-atomic hardif config
 fields with (READ|WRITE)_ONCE
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-atomic-to-write-once-v1-2-76a4272fac0d@narfation.org>
References: <20260512-atomic-to-write-once-v1-0-76a4272fac0d@narfation.org>
In-Reply-To: <20260512-atomic-to-write-once-v1-0-76a4272fac0d@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=8032; i=sven@narfation.org;
 h=from:subject:message-id; bh=RRNw9I8ErFKJgWv73VD/R314INaYNHfyE37Uj5Alywo=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFnMrcoKAcG3vgXaLv/1tWZd76OjymcUq7dZP513RqpsW
 8j9XNfWjlIWBjEuBlkxRZY9V/LPb2Z/K/952sejMHNYmUCGMHBxCsBE/s5h+B++uiiAwWAzd+dG
 W68L3OyOL9lfuGx/HntB8fWT2zujL4oyMqwt7VOcf8Ks87ui6fR7j7dLF5y4vNKrjMFti9g5hm1
 aNUwA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: Q4DLTEWLATXMZVT6AJ35YPY6GI3JLJMA
X-Message-ID-Hash: Q4DLTEWLATXMZVT6AJ35YPY6GI3JLJMA
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/Q4DLTEWLATXMZVT6AJ35YPY6GI3JLJMA/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

The hardif configuration values are only accessed as plain loads/stores and
do not require full atomic_t semantics. Convert these fields to native
integer types and replace their users with READ_ONCE()/WRITE_ONCE() to
avoid load/store tearing.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/bat_iv_ogm.c     |  2 +-
 net/batman-adv/bat_v.c          |  5 ++---
 net/batman-adv/bat_v_elp.c      |  7 ++++---
 net/batman-adv/bat_v_ogm.c      |  6 +++---
 net/batman-adv/hard-interface.c |  2 +-
 net/batman-adv/netlink.c        | 12 ++++++------
 net/batman-adv/types.h          |  6 +++---
 7 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index 06cecc32..c7751e0a 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -1172,7 +1172,7 @@ static bool batadv_iv_ogm_calc_tq(struct batadv_orig_node *orig_node,
 	inv_asym_penalty = BATADV_TQ_MAX_VALUE * neigh_rq_inv_cube;
 	inv_asym_penalty /= neigh_rq_max_cube;
 	tq_asym_penalty = BATADV_TQ_MAX_VALUE - inv_asym_penalty;
-	tq_iface_hop_penalty -= atomic_read(&if_incoming->hop_penalty);
+	tq_iface_hop_penalty -= READ_ONCE(if_incoming->hop_penalty);
 
 	/* penalize if the OGM is forwarded on the same interface. WiFi
 	 * interfaces and other half duplex devices suffer from throughput
diff --git a/net/batman-adv/bat_v.c b/net/batman-adv/bat_v.c
index 492058a8..ac2932da 100644
--- a/net/batman-adv/bat_v.c
+++ b/net/batman-adv/bat_v.c
@@ -7,7 +7,6 @@
 #include "bat_v.h"
 #include "main.h"
 
-#include <linux/atomic.h>
 #include <linux/cache.h>
 #include <linux/compiler.h>
 #include <linux/errno.h>
@@ -813,8 +812,8 @@ void batadv_v_hardif_init(struct batadv_hard_iface *hard_iface)
 	/* enable link throughput auto-detection by setting the throughput
 	 * override to zero
 	 */
-	atomic_set(&hard_iface->bat_v.throughput_override, 0);
-	atomic_set(&hard_iface->bat_v.elp_interval, 500);
+	WRITE_ONCE(hard_iface->bat_v.throughput_override, 0);
+	WRITE_ONCE(hard_iface->bat_v.elp_interval, 500);
 
 	hard_iface->bat_v.aggr_len = 0;
 	skb_queue_head_init(&hard_iface->bat_v.aggr_list);
diff --git a/net/batman-adv/bat_v_elp.c b/net/batman-adv/bat_v_elp.c
index fdc2abe9..075a58dd 100644
--- a/net/batman-adv/bat_v_elp.c
+++ b/net/batman-adv/bat_v_elp.c
@@ -10,6 +10,7 @@
 #include <linux/atomic.h>
 #include <linux/bitops.h>
 #include <linux/byteorder/generic.h>
+#include <linux/compiler.h>
 #include <linux/container_of.h>
 #include <linux/errno.h>
 #include <linux/etherdevice.h>
@@ -62,7 +63,7 @@ static void batadv_v_elp_start_timer(struct batadv_hard_iface *hard_iface)
 {
 	unsigned int msecs;
 
-	msecs = atomic_read(&hard_iface->bat_v.elp_interval) - BATADV_JITTER;
+	msecs = READ_ONCE(hard_iface->bat_v.elp_interval) - BATADV_JITTER;
 	msecs += get_random_u32_below(2 * BATADV_JITTER);
 
 	queue_delayed_work(batadv_event_workqueue, &hard_iface->bat_v.elp_wq,
@@ -97,7 +98,7 @@ static bool batadv_v_elp_get_throughput(struct batadv_hardif_neigh_node *neigh,
 	/* if the user specified a customised value for this interface, then
 	 * return it directly
 	 */
-	throughput =  atomic_read(&hard_iface->bat_v.throughput_override);
+	throughput =  READ_ONCE(hard_iface->bat_v.throughput_override);
 	if (throughput != 0) {
 		*pthroughput = throughput;
 		return true;
@@ -322,7 +323,7 @@ static void batadv_v_elp_periodic_work(struct work_struct *work)
 
 	elp_packet = (struct batadv_elp_packet *)skb->data;
 	elp_packet->seqno = htonl(atomic_read(&hard_iface->bat_v.elp_seqno));
-	elp_interval = atomic_read(&hard_iface->bat_v.elp_interval);
+	elp_interval = READ_ONCE(hard_iface->bat_v.elp_interval);
 	elp_packet->elp_interval = htonl(elp_interval);
 
 	batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
diff --git a/net/batman-adv/bat_v_ogm.c b/net/batman-adv/bat_v_ogm.c
index 4c637e00..1326a166 100644
--- a/net/batman-adv/bat_v_ogm.c
+++ b/net/batman-adv/bat_v_ogm.c
@@ -475,9 +475,9 @@ static u32 batadv_v_forward_penalty(struct batadv_priv *bat_priv,
 				    struct batadv_hard_iface *if_outgoing,
 				    u32 throughput)
 {
-	int if_hop_penalty = atomic_read(&if_incoming->hop_penalty);
-	int hop_penalty = READ_ONCE(bat_priv->hop_penalty);
-	int hop_penalty_max = BATADV_TQ_MAX_VALUE;
+	u32 if_hop_penalty = READ_ONCE(if_incoming->hop_penalty);
+	u32 hop_penalty = READ_ONCE(bat_priv->hop_penalty);
+	u32 hop_penalty_max = BATADV_TQ_MAX_VALUE;
 
 	/* Apply per hardif hop penalty */
 	throughput = throughput * (hop_penalty_max - if_hop_penalty) /
diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index 389be6f8..fb90779d 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -894,7 +894,7 @@ batadv_hardif_add_interface(struct net_device *net_dev)
 	if (batadv_is_wifi_hardif(hard_iface))
 		hard_iface->num_bcasts = BATADV_NUM_BCASTS_WIRELESS;
 
-	atomic_set(&hard_iface->hop_penalty, 0);
+	WRITE_ONCE(hard_iface->hop_penalty, 0);
 
 	batadv_v_hardif_init(hard_iface);
 
diff --git a/net/batman-adv/netlink.c b/net/batman-adv/netlink.c
index dcf06536..64e26313 100644
--- a/net/batman-adv/netlink.c
+++ b/net/batman-adv/netlink.c
@@ -810,16 +810,16 @@ static int batadv_netlink_hardif_fill(struct sk_buff *msg,
 	}
 
 	if (nla_put_u8(msg, BATADV_ATTR_HOP_PENALTY,
-		       atomic_read(&hard_iface->hop_penalty)))
+		       READ_ONCE(hard_iface->hop_penalty)))
 		goto nla_put_failure;
 
 #ifdef CONFIG_BATMAN_ADV_BATMAN_V
 	if (nla_put_u32(msg, BATADV_ATTR_ELP_INTERVAL,
-			atomic_read(&hard_iface->bat_v.elp_interval)))
+			READ_ONCE(hard_iface->bat_v.elp_interval)))
 		goto nla_put_failure;
 
 	if (nla_put_u32(msg, BATADV_ATTR_THROUGHPUT_OVERRIDE,
-			atomic_read(&hard_iface->bat_v.throughput_override)))
+			READ_ONCE(hard_iface->bat_v.throughput_override)))
 		goto nla_put_failure;
 #endif /* CONFIG_BATMAN_ADV_BATMAN_V */
 
@@ -912,7 +912,7 @@ static int batadv_netlink_set_hardif(struct sk_buff *skb,
 	if (info->attrs[BATADV_ATTR_HOP_PENALTY]) {
 		attr = info->attrs[BATADV_ATTR_HOP_PENALTY];
 
-		atomic_set(&hard_iface->hop_penalty, nla_get_u8(attr));
+		WRITE_ONCE(hard_iface->hop_penalty, nla_get_u8(attr));
 	}
 
 #ifdef CONFIG_BATMAN_ADV_BATMAN_V
@@ -920,13 +920,13 @@ static int batadv_netlink_set_hardif(struct sk_buff *skb,
 	if (info->attrs[BATADV_ATTR_ELP_INTERVAL]) {
 		attr = info->attrs[BATADV_ATTR_ELP_INTERVAL];
 
-		atomic_set(&hard_iface->bat_v.elp_interval, nla_get_u32(attr));
+		WRITE_ONCE(hard_iface->bat_v.elp_interval, nla_get_u32(attr));
 	}
 
 	if (info->attrs[BATADV_ATTR_THROUGHPUT_OVERRIDE]) {
 		attr = info->attrs[BATADV_ATTR_THROUGHPUT_OVERRIDE];
 
-		atomic_set(&hard_iface->bat_v.throughput_override,
+		WRITE_ONCE(hard_iface->bat_v.throughput_override,
 			   nla_get_u32(attr));
 	}
 #endif /* CONFIG_BATMAN_ADV_BATMAN_V */
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index cf354f2c..0f861152 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -110,7 +110,7 @@ enum batadv_v_hard_iface_flags {
  */
 struct batadv_hard_iface_bat_v {
 	/** @elp_interval: time interval between two ELP transmissions */
-	atomic_t elp_interval;
+	u32 elp_interval;
 
 	/** @elp_seqno: current ELP sequence number */
 	atomic_t elp_seqno;
@@ -134,7 +134,7 @@ struct batadv_hard_iface_bat_v {
 	 * @throughput_override: throughput override to disable link
 	 *  auto-detection
 	 */
-	atomic_t throughput_override;
+	u32 throughput_override;
 
 	/** @flags: interface specific flags */
 	u8 flags;
@@ -215,7 +215,7 @@ struct batadv_hard_iface {
 	 * @hop_penalty: penalty which will be applied to the tq-field
 	 * of an OGM received via this interface
 	 */
-	atomic_t hop_penalty;
+	u8 hop_penalty;
 
 	/** @bat_iv: per hard-interface B.A.T.M.A.N. IV data */
 	struct batadv_hard_iface_bat_iv bat_iv;

-- 
2.47.3

