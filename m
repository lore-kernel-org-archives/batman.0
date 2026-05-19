Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F825CD4F54
	for <batman-adv@archiver.kernel.org>; Tue, 19 May 2026 07:11:02 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id C8F5E811DF
	for <batman-adv@archiver.kernel.org>; Tue, 19 May 2026 09:11:00 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1779174660;
 b=r/cRNV6JzxwNfSb9w0BioeFqsn3EN60L5lkJKBhpW7lG9ubbQZDodgDX3dpkKoBdfArf7
 sJa4a8piOiDAnJsAVn1rrYghFnsdIOt2xCiqgm523w8h+edSL5ogH81GIcinMnW6MG5Rlfc
 87+vBM0xRZc5+58vb7P68vGgsFN00io=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1779174660; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=VcLfu5t0e8o7t6aspt5kkBaPWGbYlaVYxtMmXxFwX54=;
 b=3URaNa/wn7QcDtubgxBxFEp1iQpr9WCHE3lwGDPMa6FxXg4mg0X8aqg8lI9wjON2Irvw3
 s2RDdyMx8tyNL5J5ViOjTnicf2R5DLx/Ae7mhmDJSZydmJ7E848up+nTcAWXOCgjhbQSJ3Q
 Y5E7TEOUj3O2w/jZYdmheQkh2ezCEmM=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 4F22280DC9
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 19 May 2026 09:04:47 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1779174287;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=VcLfu5t0e8o7t6aspt5kkBaPWGbYlaVYxtMmXxFwX54=;
	b=TrRiwMpOxEKu70umgPky/7uroL3lhn7E7XUXqhwb+DgJ3OBYV/RFovdvUwacVTJ/UxtHyG
	PF8pAtFEgi3CIflFRLvd2u0zp0ggUA+hxg7t7v0sZMQY0ni56MB7pI/g1ggei6BY4j0Ewt
	efG4iP2Q5DDMa1D74baQLxFLkPQ1X8g=
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1779174287;
	b=xTejbyEp6oiX7OMUIgGPnqq5IqwwVDt2uOJ2fpWCdn7Udus2wDWO55hyQOuGzkyYbmDMk6
	Y2pyVGswviueRyXVAcIE6sZ6qQ74Gudq98V6r14w1qWLl73EX12wORgHXTRB11M0bU7XgX
	3ptDpR1CpAUtxTBqI2ti/vVvMQPBbb0=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=v3ionjlR;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 0654B1FE24;
	Tue, 19 May 2026 07:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1779174287;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VcLfu5t0e8o7t6aspt5kkBaPWGbYlaVYxtMmXxFwX54=;
	b=v3ionjlR21Cc33yCA6sFzu1svNnK0yuux52XMQNUrprgUrrVRre1SUDuRp0SBOkaqdCCzB
	3CmDLDW759VwuEPPo5aKo8HjqfLzZtcTNlItw3nKz4kDBPyQ5p4N8dAWYJdVD9iRYWUqne
	wqWzy+Dw9Fh8Q0L/vszoJe4DOOhI8uw=
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 19 May 2026 09:04:37 +0200
Subject: [PATCH batadv v2 2/7] batman-adv: replace non-atomic hardif config
 fields with (READ|WRITE)_ONCE
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-atomic-to-write-once-v2-2-1b643e847a56@narfation.org>
References: <20260519-atomic-to-write-once-v2-0-1b643e847a56@narfation.org>
In-Reply-To: <20260519-atomic-to-write-once-v2-0-1b643e847a56@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=8032; i=sven@narfation.org;
 h=from:subject:message-id; bh=eM9fkAG3z0Sh5W/Ql+wWlh8eOMjLNLumMLjfiQenk4U=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFk83K2ZwrrHmdWmOz8oNpP0lIw+UqrDUOq+d8+z3/ZWP
 4ss78ztKGVhEONikBVTZNlzJf/8Zva38p+nfTwKM4eVCWQIAxenAEzkVwkjw2wJs5UNrEXBMjfe
 Fjk9nrW8S62mo/Xv9G732w/XRG8/6MrwP/K1pm+tnYiP7KGvFxNeaHzu8XZbcE39EuOfhHDbeQs
 /sAEA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: XJBK2HUB4RH46GZNSB3CEILLSZU6C44B
X-Message-ID-Hash: XJBK2HUB4RH46GZNSB3CEILLSZU6C44B
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/XJBK2HUB4RH46GZNSB3CEILLSZU6C44B/>
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
index 9ab04a99..5e187fc8 100644
--- a/net/batman-adv/bat_v_ogm.c
+++ b/net/batman-adv/bat_v_ogm.c
@@ -474,9 +474,9 @@ static u32 batadv_v_forward_penalty(struct batadv_priv *bat_priv,
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
index 2cd314ff..8c64f06e 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -893,7 +893,7 @@ batadv_hardif_add_interface(struct net_device *net_dev)
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
index 13c3052a..c4b220fa 100644
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

