Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C514ECD5BD1
	for <batman-adv@archiver.kernel.org>; Mon,  1 Jun 2026 12:43:29 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 63E75841F6
	for <batman-adv@archiver.kernel.org>; Mon, 01 Jun 2026 14:43:28 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1780317808;
 b=3qpAzRZ3QbOsBMus8guwmjTVJioApx5MZK4y48HztxMXPomI8u11VAJpkRlGVeVLqybn5
 vv0K9G4Tbjid11UjqQfIQcWd1BHp8bxKrXDVU9zCJSe33PsA/OFv+Mdm+CA4CfdiZrP1DRq
 TVfmtfCgswldw/5hWu1/F9qxmSZ+aEo=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1780317808; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=sghBfIAPiUxG5S1mQ0ZrqzvwGu+2urKA+zJPDqPMWh4=;
 b=w3zPG/ZFe8U8WYmYvBx6cPf/iufkScoxuexEPs9fjw+fgCei1a793hgcJS9OYIffY9LUJ
 ztrDStKl5CYou8Fz3tkG3NlTyBIdujI7oieS5toNPF5YbinlhCV8aCZkgPmLv57LN1D5Y5C
 9hIqynTYicuFaWZ5CXUGWWwJzj1Ht6Q=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id F34208050E
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 01 Jun 2026 14:36:49 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1780317410;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=sghBfIAPiUxG5S1mQ0ZrqzvwGu+2urKA+zJPDqPMWh4=;
	b=cadguQ0Cupa+e22dOVhMaeAUEdoLwXn2hbeOfg+rGK35X33O/1QCPGRAnKWWbMTJbd3rvh
	clxqodtuw1fxHNDQHyBZxUYtMI1RsPKRPiDGpIBNvEphT0y8G103yPSNWhWQt83niNv0VN
	kgL4E4wToGY+8BJZCUhoojZOzm/e3lE=
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1780317410;
	b=ina9C6UuwLv8/RKmNj/bew21QAXUgS6QVM06kIV1T+CIhzC7H04OT1JGe5p7HQW1ptG/P8
	Tl1WuTWQQVGRWF14LVoDgEvaM5SkLeLI+NTT9g6eYlDBdSk9JkBHGG3N1Dfdi1eOCSdZ17
	QIBXDGL2gJCfmBxFz5REKymKg+26KZo=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=K7iiN8Vj;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 23.88.38.48 as permitted sender) smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1780317409;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sghBfIAPiUxG5S1mQ0ZrqzvwGu+2urKA+zJPDqPMWh4=;
	b=K7iiN8VjNFCQ+1FkFXETziV2oknEQaUyi7K7D8vwecGlSDZO7te0ZO/iBDVPbrRezRHH9A
	lttj6YkfXHN0wr0QJlxQlx4sf7Q1SVD3rK2qUjnwthuHaAM8tdS1qQsJHdcc9nCnN/bgaS
	kxKaK/TZCiF4sfuIWq56VmxFZYqA5UASs6JrfUdPc4DCISo45wE6rXLGFGtDGxuyPao15i
	Jvgh87il/BWwmAxj10EXXJvPizaxW0g5Z7sX4kzRj7bl7L3ePfc9qCFpLPNK5keB4wyqa+
	bFdzIGK3xAV9MY8L8OoYIwQizCwKoHAur22V5re7hJriTEnW8HuIn8QtGXUZqQ==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Sven Eckelmann <sven@narfation.org>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net-next 08/15] batman-adv: replace non-atomic hardif config
 fields with (READ|WRITE)_ONCE
Date: Mon,  1 Jun 2026 14:36:22 +0200
Message-ID: <20260601123629.707089-9-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260601123629.707089-1-sw@simonwunderlich.de>
References: <20260601123629.707089-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: 52XWCJ36FEQQSO7YKTWBNAC3QBTECB3A
X-Message-ID-Hash: 52XWCJ36FEQQSO7YKTWBNAC3QBTECB3A
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/52XWCJ36FEQQSO7YKTWBNAC3QBTECB3A/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Sven Eckelmann <sven@narfation.org>

The hardif configuration values are only accessed as plain loads/stores and
do not require full atomic_t semantics. Convert these fields to native
integer types and replace their users with READ_ONCE()/WRITE_ONCE() to
avoid load/store tearing.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
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
index 5628017bee511..df8e64588e1e7 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -1218,7 +1218,7 @@ static bool batadv_iv_ogm_calc_tq(struct batadv_orig_node *orig_node,
 	inv_asym_penalty = BATADV_TQ_MAX_VALUE * neigh_rq_inv_cube;
 	inv_asym_penalty /= neigh_rq_max_cube;
 	tq_asym_penalty = BATADV_TQ_MAX_VALUE - inv_asym_penalty;
-	tq_iface_hop_penalty -= atomic_read(&if_incoming->hop_penalty);
+	tq_iface_hop_penalty -= READ_ONCE(if_incoming->hop_penalty);
 
 	/* penalize if the OGM is forwarded on the same interface. WiFi
 	 * interfaces and other half duplex devices suffer from throughput
diff --git a/net/batman-adv/bat_v.c b/net/batman-adv/bat_v.c
index 492058a87682b..ac2932da5472d 100644
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
index e207093de79fe..0190fafcbed2d 100644
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
@@ -98,7 +99,7 @@ static bool batadv_v_elp_get_throughput(struct batadv_hardif_neigh_node *neigh,
 	/* if the user specified a customised value for this interface, then
 	 * return it directly
 	 */
-	throughput =  atomic_read(&hard_iface->bat_v.throughput_override);
+	throughput =  READ_ONCE(hard_iface->bat_v.throughput_override);
 	if (throughput != 0) {
 		*pthroughput = throughput;
 		return true;
@@ -324,7 +325,7 @@ static void batadv_v_elp_periodic_work(struct work_struct *work)
 
 	elp_packet = (struct batadv_elp_packet *)skb->data;
 	elp_packet->seqno = htonl(atomic_read(&hard_iface->bat_v.elp_seqno));
-	elp_interval = atomic_read(&hard_iface->bat_v.elp_interval);
+	elp_interval = READ_ONCE(hard_iface->bat_v.elp_interval);
 	elp_packet->elp_interval = htonl(elp_interval);
 
 	batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
diff --git a/net/batman-adv/bat_v_ogm.c b/net/batman-adv/bat_v_ogm.c
index 28f28b61ad6bc..f4cd8cad97e0c 100644
--- a/net/batman-adv/bat_v_ogm.c
+++ b/net/batman-adv/bat_v_ogm.c
@@ -486,9 +486,9 @@ static u32 batadv_v_forward_penalty(struct batadv_priv *bat_priv,
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
index e89aa4b61a7cd..86e7d10864e2f 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -910,7 +910,7 @@ batadv_hardif_add_interface(struct net_device *net_dev)
 	if (batadv_is_wifi_hardif(hard_iface))
 		hard_iface->num_bcasts = BATADV_NUM_BCASTS_WIRELESS;
 
-	atomic_set(&hard_iface->hop_penalty, 0);
+	WRITE_ONCE(hard_iface->hop_penalty, 0);
 
 	batadv_v_hardif_init(hard_iface);
 
diff --git a/net/batman-adv/netlink.c b/net/batman-adv/netlink.c
index 027e9fe1042a2..368072f0513c2 100644
--- a/net/batman-adv/netlink.c
+++ b/net/batman-adv/netlink.c
@@ -811,16 +811,16 @@ static int batadv_netlink_hardif_fill(struct sk_buff *msg,
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
 
@@ -913,7 +913,7 @@ static int batadv_netlink_set_hardif(struct sk_buff *skb,
 	if (info->attrs[BATADV_ATTR_HOP_PENALTY]) {
 		attr = info->attrs[BATADV_ATTR_HOP_PENALTY];
 
-		atomic_set(&hard_iface->hop_penalty, nla_get_u8(attr));
+		WRITE_ONCE(hard_iface->hop_penalty, nla_get_u8(attr));
 	}
 
 #ifdef CONFIG_BATMAN_ADV_BATMAN_V
@@ -921,13 +921,13 @@ static int batadv_netlink_set_hardif(struct sk_buff *skb,
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
index c4845b5e43be0..dd63cd28914d7 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -114,7 +114,7 @@ enum batadv_v_hard_iface_flags {
  */
 struct batadv_hard_iface_bat_v {
 	/** @elp_interval: time interval between two ELP transmissions */
-	atomic_t elp_interval;
+	u32 elp_interval;
 
 	/** @elp_seqno: current ELP sequence number */
 	atomic_t elp_seqno;
@@ -138,7 +138,7 @@ struct batadv_hard_iface_bat_v {
 	 * @throughput_override: throughput override to disable link
 	 *  auto-detection
 	 */
-	atomic_t throughput_override;
+	u32 throughput_override;
 
 	/** @flags: interface specific flags */
 	u8 flags;
@@ -236,7 +236,7 @@ struct batadv_hard_iface {
 	 * @hop_penalty: penalty which will be applied to the tq-field
 	 * of an OGM received via this interface
 	 */
-	atomic_t hop_penalty;
+	u8 hop_penalty;
 
 	/** @bat_iv: per hard-interface B.A.T.M.A.N. IV data */
 	struct batadv_hard_iface_bat_iv bat_iv;
-- 
2.47.3

