Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 621C2EB64DA
	for <batman-adv@archiver.kernel.org>; Sat,  8 Jul 2023 21:52:33 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id AC73C82225
	for <batman-adv@archiver.kernel.org>; Sat,  8 Jul 2023 23:52:31 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1688853151;
 b=VU6W9Z5nZkBPWWE0h0LdhCaRO8gRLqbcpaFt2lBde2e+HsigtJOxuMBpcSHKmxgPDop8m
 tIFZz+WftJekziqabtc/Zuho7t9iMoB9gD5tbWdw1JK2xUuzOtaUnkfWzaVNRErMapbJQbR
 nQgb6h5uAWFMycmQJMGhfPk2JMKvQBw=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1688853151; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=8Ew9NlNBzJqDA6MgZ2K+G12+adcQmh1yKB8lEjyQxQk=;
 b=Ux0HrSqOkXqzYXlibyeEIDtLR3QlivlkYwIeBlbt5bPpd0NhnrAIQWdNLOijp4kmWiN1I
 HaaWEsXkwDjvqGcuyiL8AgRxTCkiOd62N/dFIEBin8lUZEHwkWXW1RUJ5ed2Pqt9doX7qqT
 DQTeE7Yb51MeNecpzrqGxsRCaNTY+J4=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=fail;
  arc=pass;
  dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass; dmarc=none
Received: from mail.aperture-lab.de (mail.aperture-lab.de
 [IPv6:2a01:4f8:c2c:665b::1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 812A38045B
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sat,  8 Jul 2023 23:51:39 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1688853099;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8Ew9NlNBzJqDA6MgZ2K+G12+adcQmh1yKB8lEjyQxQk=;
	b=Rp3cmKCZOy8k3IxpU4sUB8oUIHSwChMtJDTuvtTVUz9G5g59CFo0pRin6mt5lGSQAdsRTv
	AFeop5jPhPsohKrZHAL3o/bLNXHPbW54xNVMBPvWrTJW0akr3BWQ3qmZI+K+Sl6pMDSffc
	QDZeiOI/M84PN2OWfb7pE5Jmca/MCDE=
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1688853099; a=rsa-sha256;
	cv=none;
	b=rclwh+A2XvWIPHzbroFTisOD9dhEyPWGK/k5Lhqc/6NUqvQa+/2qVSMd43PmKH2e2/4pDu
	BrCzj0WDJFpjCBrdO4o7VG/YFj+MqYey3TmtFOtflt6N7QMgidDms7wrmX6CiFl9jBO71F
	NjnVFAZEWyRYR1JKySrr6ip6OnRY76Q=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	spf=none (diktynna.open-mesh.org: domain of linus.luessing@c0d3.blue has no
 SPF policy when checking 2a01:4f8:c2c:665b::1)
 smtp.mailfrom=linus.luessing@c0d3.blue;
	dmarc=none
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id CB413419D1;
	Sat,  8 Jul 2023 23:51:38 +0200 (CEST)
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
To: b.a.t.m.a.n@lists.open-mesh.org
Subject: [PATCH v5 1/3] batman-adv: mcast: implement multicast packet
 reception and forwarding
Date: Sat,  8 Jul 2023 23:51:11 +0200
Message-Id: <20230708215113.15325-2-linus.luessing@c0d3.blue>
In-Reply-To: <20230708215113.15325-1-linus.luessing@c0d3.blue>
References: <20230708215113.15325-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
Message-ID-Hash: NAN3DPHLWMZ3ON56PCNOET4ZUW5PGEZ3
X-Message-ID-Hash: NAN3DPHLWMZ3ON56PCNOET4ZUW5PGEZ3
X-MailFrom: linus.luessing@c0d3.blue
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/NAN3DPHLWMZ3ON56PCNOET4ZUW5PGEZ3/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Implement functionality to receive and forward a new TVLV capable
multicast packet type.

The new batman-adv multicast packet type allows to contain several
originator destination addresses within a TVLV. Routers on the way will
potentially split the batman-adv multicast packet and adjust its tracker
TVLV contents.

Routing decisions are still based on the selected BATMAN IV or BATMAN V
routing algorithm. So this new batman-adv multicast packet type retains
the same loop-free properties.

Also a new OGM multicast TVLV flag is introduced to signal to other
nodes that we are capable of handling a batman-adv multicast packet and
multicast tracker TVLV. And that all of our hard interfaces have an MTU
of at least 1280 bytes (IPv6 minimum MTU), as a simple solution for now
to avoid MTU issues while forwarding.

Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
---
 include/uapi/linux/batadv_packet.h |  45 ++++-
 net/batman-adv/Makefile            |   1 +
 net/batman-adv/main.c              |   2 +
 net/batman-adv/multicast.c         |  48 +++++-
 net/batman-adv/multicast.h         |   5 +
 net/batman-adv/multicast_forw.c    | 256 +++++++++++++++++++++++++++++
 net/batman-adv/originator.c        |   1 +
 net/batman-adv/routing.c           |  70 ++++++++
 net/batman-adv/routing.h           |  11 ++
 net/batman-adv/soft-interface.c    |  12 ++
 net/batman-adv/types.h             |  64 ++++++++
 11 files changed, 504 insertions(+), 11 deletions(-)
 create mode 100644 net/batman-adv/multicast_forw.c

diff --git a/include/uapi/linux/batadv_packet.h b/include/uapi/linux/batadv_packet.h
index 9204e4494b25..6e25753015df 100644
--- a/include/uapi/linux/batadv_packet.h
+++ b/include/uapi/linux/batadv_packet.h
@@ -116,6 +116,9 @@ enum batadv_icmp_packettype {
  * only need routable IPv4 multicast packets we signed up for explicitly
  * @BATADV_MCAST_WANT_NO_RTR6: we have no IPv6 multicast router and therefore
  * only need routable IPv6 multicast packets we signed up for explicitly
+ * @BATADV_MCAST_HAVE_MC_PTYPE_CAPA: we can parse, receive and forward
+ * batman-adv multicast packets with a multicast tracker TVLV. And all our
+ * hard interfaces have an MTU of at least 1280 bytes.
  */
 enum batadv_mcast_flags {
 	BATADV_MCAST_WANT_ALL_UNSNOOPABLES	= 1UL << 0,
@@ -123,6 +126,7 @@ enum batadv_mcast_flags {
 	BATADV_MCAST_WANT_ALL_IPV6		= 1UL << 2,
 	BATADV_MCAST_WANT_NO_RTR4		= 1UL << 3,
 	BATADV_MCAST_WANT_NO_RTR6		= 1UL << 4,
+	BATADV_MCAST_HAVE_MC_PTYPE_CAPA		= 1UL << 5,
 };
 
 /* tt data subtypes */
@@ -174,14 +178,16 @@ enum batadv_bla_claimframe {
  * @BATADV_TVLV_TT: translation table tvlv
  * @BATADV_TVLV_ROAM: roaming advertisement tvlv
  * @BATADV_TVLV_MCAST: multicast capability tvlv
+ * @BATADV_TVLV_MCAST_TRACKER: multicast tracker tvlv
  */
 enum batadv_tvlv_type {
-	BATADV_TVLV_GW		= 0x01,
-	BATADV_TVLV_DAT		= 0x02,
-	BATADV_TVLV_NC		= 0x03,
-	BATADV_TVLV_TT		= 0x04,
-	BATADV_TVLV_ROAM	= 0x05,
-	BATADV_TVLV_MCAST	= 0x06,
+	BATADV_TVLV_GW			= 0x01,
+	BATADV_TVLV_DAT			= 0x02,
+	BATADV_TVLV_NC			= 0x03,
+	BATADV_TVLV_TT			= 0x04,
+	BATADV_TVLV_ROAM		= 0x05,
+	BATADV_TVLV_MCAST		= 0x06,
+	BATADV_TVLV_MCAST_TRACKER	= 0x07,
 };
 
 #pragma pack(2)
@@ -487,6 +493,25 @@ struct batadv_bcast_packet {
 	 */
 };
 
+/**
+ * struct batadv_mcast_packet - multicast packet for network payload
+ * @packet_type: batman-adv packet type, part of the general header
+ * @version: batman-adv protocol version, part of the general header
+ * @ttl: time to live for this packet, part of the general header
+ * @reserved: reserved byte for alignment
+ * @tvlv_len: length of the appended tvlv buffer (in bytes)
+ */
+struct batadv_mcast_packet {
+	__u8 packet_type;
+	__u8 version;
+	__u8 ttl;
+	__u8 reserved;
+	__be16 tvlv_len;
+	/* "4 bytes boundary + 2 bytes" long to make the payload after the
+	 * following ethernet header again 4 bytes boundary aligned
+	 */
+};
+
 /**
  * struct batadv_coded_packet - network coded packet
  * @packet_type: batman-adv packet type, part of the general header
@@ -628,6 +653,14 @@ struct batadv_tvlv_mcast_data {
 	__u8 reserved[3];
 };
 
+/**
+ * struct batadv_tvlv_mcast_tracker - payload of a multicast tracker tvlv
+ * @num_dests: number of subsequent destination originator MAC addresses
+ */
+struct batadv_tvlv_mcast_tracker {
+	__be16	num_dests;
+};
+
 #pragma pack()
 
 #endif /* _UAPI_LINUX_BATADV_PACKET_H_ */
diff --git a/net/batman-adv/Makefile b/net/batman-adv/Makefile
index 3bd0760c76a2..b51d8b071b56 100644
--- a/net/batman-adv/Makefile
+++ b/net/batman-adv/Makefile
@@ -20,6 +20,7 @@ batman-adv-y += hash.o
 batman-adv-$(CONFIG_BATMAN_ADV_DEBUG) += log.o
 batman-adv-y += main.o
 batman-adv-$(CONFIG_BATMAN_ADV_MCAST) += multicast.o
+batman-adv-$(CONFIG_BATMAN_ADV_MCAST) += multicast_forw.o
 batman-adv-y += netlink.o
 batman-adv-$(CONFIG_BATMAN_ADV_NC) += network-coding.o
 batman-adv-y += originator.o
diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index e8a449915566..50b2bf2b748c 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -532,6 +532,8 @@ static void batadv_recv_handler_init(void)
 
 	/* broadcast packet */
 	batadv_rx_handler[BATADV_BCAST] = batadv_recv_bcast_packet;
+	/* multicast packet */
+	batadv_rx_handler[BATADV_MCAST] = batadv_recv_mcast_packet;
 
 	/* unicast packets ... */
 	/* unicast with 4 addresses packet */
diff --git a/net/batman-adv/multicast.c b/net/batman-adv/multicast.c
index 27511a063311..f2b1e523fd85 100644
--- a/net/batman-adv/multicast.c
+++ b/net/batman-adv/multicast.c
@@ -243,6 +243,37 @@ static u8 batadv_mcast_mla_rtr_flags_get(struct batadv_priv *bat_priv,
 	return flags;
 }
 
+/**
+ * batadv_mcast_mla_forw_flags_get() - get multicast forwarding flags
+ * @bat_priv: the bat priv with all the soft interface information
+ *
+ * Checks if all active hard interfaces have an MTU larger or equal to 1280
+ * bytes (IPv6 minimum MTU).
+ *
+ * Return: BATADV_MCAST_HAVE_MC_PTYPE_CAPA if yes, BATADV_NO_FLAGS otherwise.
+ */
+static u8 batadv_mcast_mla_forw_flags_get(struct batadv_priv *bat_priv)
+{
+	const struct batadv_hard_iface *hard_iface;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(hard_iface, &batadv_hardif_list, list) {
+		if (hard_iface->if_status != BATADV_IF_ACTIVE)
+			continue;
+
+		if (hard_iface->soft_iface != bat_priv->soft_iface)
+			continue;
+
+		if (hard_iface->net_dev->mtu < IPV6_MIN_MTU) {
+			rcu_read_unlock();
+			return BATADV_NO_FLAGS;
+		}
+	}
+	rcu_read_unlock();
+
+	return BATADV_MCAST_HAVE_MC_PTYPE_CAPA;
+}
+
 /**
  * batadv_mcast_mla_flags_get() - get the new multicast flags
  * @bat_priv: the bat priv with all the soft interface information
@@ -264,6 +295,7 @@ batadv_mcast_mla_flags_get(struct batadv_priv *bat_priv)
 	mla_flags.enabled = 1;
 	mla_flags.tvlv_flags |= batadv_mcast_mla_rtr_flags_get(bat_priv,
 							       bridge);
+	mla_flags.tvlv_flags |= batadv_mcast_mla_forw_flags_get(bat_priv);
 
 	if (!bridge)
 		return mla_flags;
@@ -814,23 +846,25 @@ static void batadv_mcast_flags_log(struct batadv_priv *bat_priv, u8 flags)
 {
 	bool old_enabled = bat_priv->mcast.mla_flags.enabled;
 	u8 old_flags = bat_priv->mcast.mla_flags.tvlv_flags;
-	char str_old_flags[] = "[.... . ]";
+	char str_old_flags[] = "[.... . .]";
 
-	sprintf(str_old_flags, "[%c%c%c%s%s]",
+	sprintf(str_old_flags, "[%c%c%c%s%s%c]",
 		(old_flags & BATADV_MCAST_WANT_ALL_UNSNOOPABLES) ? 'U' : '.',
 		(old_flags & BATADV_MCAST_WANT_ALL_IPV4) ? '4' : '.',
 		(old_flags & BATADV_MCAST_WANT_ALL_IPV6) ? '6' : '.',
 		!(old_flags & BATADV_MCAST_WANT_NO_RTR4) ? "R4" : ". ",
-		!(old_flags & BATADV_MCAST_WANT_NO_RTR6) ? "R6" : ". ");
+		!(old_flags & BATADV_MCAST_WANT_NO_RTR6) ? "R6" : ". ",
+		!(old_flags & BATADV_MCAST_HAVE_MC_PTYPE_CAPA) ? 'P' : '.');
 
 	batadv_dbg(BATADV_DBG_MCAST, bat_priv,
-		   "Changing multicast flags from '%s' to '[%c%c%c%s%s]'\n",
+		   "Changing multicast flags from '%s' to '[%c%c%c%s%s%c]'\n",
 		   old_enabled ? str_old_flags : "<undefined>",
 		   (flags & BATADV_MCAST_WANT_ALL_UNSNOOPABLES) ? 'U' : '.',
 		   (flags & BATADV_MCAST_WANT_ALL_IPV4) ? '4' : '.',
 		   (flags & BATADV_MCAST_WANT_ALL_IPV6) ? '6' : '.',
 		   !(flags & BATADV_MCAST_WANT_NO_RTR4) ? "R4" : ". ",
-		   !(flags & BATADV_MCAST_WANT_NO_RTR6) ? "R6" : ". ");
+		   !(flags & BATADV_MCAST_WANT_NO_RTR6) ? "R6" : ". ",
+		   !(flags & BATADV_MCAST_HAVE_MC_PTYPE_CAPA) ? 'P' : '.');
 }
 
 /**
@@ -1828,6 +1862,10 @@ void batadv_mcast_init(struct batadv_priv *bat_priv)
 	batadv_tvlv_handler_register(bat_priv, batadv_mcast_tvlv_ogm_handler,
 				     NULL, NULL, BATADV_TVLV_MCAST, 2,
 				     BATADV_TVLV_HANDLER_OGM_CIFNOTFND);
+	batadv_tvlv_handler_register(bat_priv, NULL, NULL,
+				     batadv_mcast_forw_tracker_tvlv_handler,
+				     BATADV_TVLV_MCAST_TRACKER, 1,
+				     BATADV_TVLV_HANDLER_OGM_CIFNOTFND);
 
 	INIT_DELAYED_WORK(&bat_priv->mcast.work, batadv_mcast_mla_update);
 	batadv_mcast_start_timer(bat_priv);
diff --git a/net/batman-adv/multicast.h b/net/batman-adv/multicast.h
index a9770d8d6d36..a5c0f384bb9a 100644
--- a/net/batman-adv/multicast.h
+++ b/net/batman-adv/multicast.h
@@ -52,6 +52,11 @@ void batadv_mcast_free(struct batadv_priv *bat_priv);
 
 void batadv_mcast_purge_orig(struct batadv_orig_node *orig_node);
 
+/* multicast_forw.c */
+
+int batadv_mcast_forw_tracker_tvlv_handler(struct batadv_priv *bat_priv,
+					   struct sk_buff *skb);
+
 #else
 
 static inline enum batadv_forw_mode
diff --git a/net/batman-adv/multicast_forw.c b/net/batman-adv/multicast_forw.c
new file mode 100644
index 000000000000..08f31b977777
--- /dev/null
+++ b/net/batman-adv/multicast_forw.c
@@ -0,0 +1,256 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) B.A.T.M.A.N. contributors:
+ *
+ * Linus Lüssing
+ */
+
+#include "multicast.h"
+#include "main.h"
+
+#include <linux/byteorder/generic.h>
+#include <linux/errno.h>
+#include <linux/etherdevice.h>
+#include <linux/gfp.h>
+#include <linux/if_ether.h>
+#include <linux/netdevice.h>
+#include <linux/skbuff.h>
+#include <linux/stddef.h>
+#include <linux/types.h>
+#include <uapi/linux/batadv_packet.h>
+
+#include "originator.h"
+#include "routing.h"
+#include "send.h"
+
+#define batadv_mcast_forw_tracker_for_each_dest(dest, num_dests) \
+	for (; num_dests; num_dests--, (dest) += ETH_ALEN)
+
+/**
+ * batadv_mcast_forw_orig_to_neigh() - get next hop neighbor to an orig address
+ * @bat_priv: the bat priv with all the soft interface information
+ * @orig_addr: the originator MAC address to search the best next hop router for
+ *
+ * Return: A neighbor node which is the best router towards the given originator
+ * address.
+ */
+static struct batadv_neigh_node *
+batadv_mcast_forw_orig_to_neigh(struct batadv_priv *bat_priv, u8 *orig_addr)
+{
+	struct batadv_neigh_node *neigh_node;
+	struct batadv_orig_node *orig_node;
+
+	orig_node = batadv_orig_hash_find(bat_priv, orig_addr);
+	if (!orig_node)
+		return NULL;
+
+	neigh_node = batadv_find_router(bat_priv, orig_node, NULL);
+	batadv_orig_node_put(orig_node);
+
+	return neigh_node;
+}
+
+/**
+ * batadv_mcast_forw_scrub_dests() - scrub destinations in a tracker TVLV
+ * @bat_priv: the bat priv with all the soft interface information
+ * @comp_neigh: next hop neighbor to scrub+collect destinations for
+ * @dest: start MAC entry in original skb's tracker TVLV
+ * @next_dest: start MAC entry in to be sent skb's tracker TVLV
+ * @num_dests: number of remaining destination MAC entries to iterate over
+ *
+ * This sorts destination entries into either the original batman-adv
+ * multicast packet or the skb (copy) that is going to be sent to comp_neigh
+ * next.
+ *
+ * In preparation for the next, to be (unicast) transmitted batman-adv multicast
+ * packet skb to be sent to the given neighbor node, tries to collect all
+ * originator MAC addresses that have the given neighbor node as their next hop
+ * in the to be transmitted skb (copy), which next_dest points into. That is we
+ * zero all destination entries in next_dest which do not have comp_neigh as
+ * their next hop. And zero all destination entries in the original skb that
+ * would have comp_neigh as their next hop (to avoid redundant transmissions and
+ * duplicated payload later).
+ */
+static void
+batadv_mcast_forw_scrub_dests(struct batadv_priv *bat_priv,
+			      struct batadv_neigh_node *comp_neigh, u8 *dest,
+			      u8 *next_dest, u16 num_dests)
+{
+	struct batadv_neigh_node *next_neigh;
+
+	/* skip first entry, this is what we are comparing with */
+	eth_zero_addr(dest);
+	dest += ETH_ALEN;
+	next_dest += ETH_ALEN;
+	num_dests--;
+
+	batadv_mcast_forw_tracker_for_each_dest(next_dest, num_dests) {
+		if (is_zero_ether_addr(next_dest))
+			goto scrub_next;
+
+		if (is_multicast_ether_addr(next_dest)) {
+			eth_zero_addr(dest);
+			eth_zero_addr(next_dest);
+			goto scrub_next;
+		}
+
+		next_neigh = batadv_mcast_forw_orig_to_neigh(bat_priv,
+							     next_dest);
+		if (!next_neigh) {
+			eth_zero_addr(next_dest);
+			goto scrub_next;
+		}
+
+		/* Is this for our next packet to transmit? */
+		if (batadv_compare_eth(next_neigh->addr, comp_neigh->addr))
+			eth_zero_addr(dest);
+		else
+			eth_zero_addr(next_dest);
+
+		batadv_neigh_node_put(next_neigh);
+scrub_next:
+		dest += ETH_ALEN;
+	}
+}
+
+/**
+ * batadv_mcast_forw_packet() - forward a batman-adv multicast packet
+ * @bat_priv: the bat priv with all the soft interface information
+ * @skb: the received or locally generated batman-adv multicast packet
+ * @local_xmit: indicates that the packet was locally generated and not received
+ *
+ * Parses the tracker TVLV of a batman-adv multicast packet and forwards the
+ * packet as indicated in this TVLV.
+ *
+ * Caller needs to set the skb network header to the start of the multicast
+ * tracker TVLV (excluding the generic TVLV header) and the skb transport header
+ * to the next byte after this multicast tracker TVLV.
+ *
+ * Caller needs to free the skb.
+ *
+ * Return: NET_RX_SUCCESS or NET_RX_DROP on success or a negative error
+ * code on failure. NET_RX_SUCCESS if the received packet is supposed to be
+ * decapsulated and forwarded to the own soft interface, NET_RX_DROP otherwise.
+ */
+static int batadv_mcast_forw_packet(struct batadv_priv *bat_priv,
+				    struct sk_buff *skb, bool local_xmit)
+{
+	struct batadv_tvlv_mcast_tracker *mcast_tracker;
+	struct batadv_neigh_node *neigh_node;
+	unsigned long offset, num_dests_off;
+	struct sk_buff *nexthop_skb;
+	unsigned char *skb_net_hdr;
+	bool local_recv = false;
+	unsigned int tvlv_len;
+	bool xmitted = false;
+	u8 *dest, *next_dest;
+	u16 num_dests;
+	int ret;
+
+	/* check if num_dests is within skb length */
+	num_dests_off = offsetof(struct batadv_tvlv_mcast_tracker, num_dests);
+	if (num_dests_off > skb_network_header_len(skb))
+		return -EINVAL;
+
+	skb_net_hdr = skb_network_header(skb);
+	mcast_tracker = (struct batadv_tvlv_mcast_tracker *)skb_net_hdr;
+	num_dests = ntohs(mcast_tracker->num_dests);
+
+	dest = (u8 *)mcast_tracker + sizeof(*mcast_tracker);
+
+	/* check if full tracker tvlv is within skb length */
+	tvlv_len = sizeof(*mcast_tracker) + ETH_ALEN * num_dests;
+	if (tvlv_len > skb_network_header_len(skb))
+		return -EINVAL;
+
+	/* invalidate checksum: */
+	skb->ip_summed = CHECKSUM_NONE;
+
+	batadv_mcast_forw_tracker_for_each_dest(dest, num_dests) {
+		if (is_zero_ether_addr(dest))
+			continue;
+
+		/* only unicast originator addresses supported */
+		if (is_multicast_ether_addr(dest)) {
+			eth_zero_addr(dest);
+			continue;
+		}
+
+		if (batadv_is_my_mac(bat_priv, dest)) {
+			eth_zero_addr(dest);
+			local_recv = true;
+			continue;
+		}
+
+		neigh_node = batadv_mcast_forw_orig_to_neigh(bat_priv, dest);
+		if (!neigh_node) {
+			eth_zero_addr(dest);
+			continue;
+		}
+
+		nexthop_skb = skb_copy(skb, GFP_ATOMIC);
+		if (!nexthop_skb) {
+			batadv_neigh_node_put(neigh_node);
+			return -ENOMEM;
+		}
+
+		offset = dest - skb->data;
+		next_dest = nexthop_skb->data + offset;
+
+		batadv_mcast_forw_scrub_dests(bat_priv, neigh_node, dest,
+					      next_dest, num_dests);
+
+		batadv_inc_counter(bat_priv, BATADV_CNT_MCAST_TX);
+		batadv_add_counter(bat_priv, BATADV_CNT_MCAST_TX_BYTES,
+				   nexthop_skb->len + ETH_HLEN);
+		xmitted = true;
+		ret = batadv_send_unicast_skb(nexthop_skb, neigh_node);
+
+		batadv_neigh_node_put(neigh_node);
+
+		if (ret < 0)
+			return ret;
+	}
+
+	if (xmitted) {
+		if (local_xmit) {
+			batadv_inc_counter(bat_priv, BATADV_CNT_MCAST_TX_LOCAL);
+			batadv_add_counter(bat_priv,
+					   BATADV_CNT_MCAST_TX_LOCAL_BYTES,
+					   skb->len -
+					   skb_transport_offset(skb));
+		} else {
+			batadv_inc_counter(bat_priv, BATADV_CNT_MCAST_FWD);
+			batadv_add_counter(bat_priv, BATADV_CNT_MCAST_FWD_BYTES,
+					   skb->len + ETH_HLEN);
+		}
+	}
+
+	if (local_recv)
+		return NET_RX_SUCCESS;
+	else
+		return NET_RX_DROP;
+}
+
+/**
+ * batadv_mcast_forw_tracker_tvlv_handler() - handle an mcast tracker tvlv
+ * @bat_priv: the bat priv with all the soft interface information
+ * @skb: the received batman-adv multicast packet
+ *
+ * Parses the tracker TVLV of an incoming batman-adv multicast packet and
+ * forwards the packet as indicated in this TVLV.
+ *
+ * Caller needs to set the skb network header to the start of the multicast
+ * tracker TVLV (excluding the generic TVLV header) and the skb transport header
+ * to the next byte after this multicast tracker TVLV.
+ *
+ * Caller needs to free the skb.
+ *
+ * Return: NET_RX_SUCCESS or NET_RX_DROP on success or a negative error
+ * code on failure. NET_RX_SUCCESS if the received packet is supposed to be
+ * decapsulated and forwarded to the own soft interface, NET_RX_DROP otherwise.
+ */
+int batadv_mcast_forw_tracker_tvlv_handler(struct batadv_priv *bat_priv,
+					   struct sk_buff *skb)
+{
+	return batadv_mcast_forw_packet(bat_priv, skb, false);
+}
diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
index 34903df4fe93..e46ce83c516a 100644
--- a/net/batman-adv/originator.c
+++ b/net/batman-adv/originator.c
@@ -942,6 +942,7 @@ struct batadv_orig_node *batadv_orig_node_new(struct batadv_priv *bat_priv,
 #ifdef CONFIG_BATMAN_ADV_MCAST
 	orig_node->mcast_flags = BATADV_MCAST_WANT_NO_RTR4;
 	orig_node->mcast_flags |= BATADV_MCAST_WANT_NO_RTR6;
+	orig_node->mcast_flags |= BATADV_MCAST_HAVE_MC_PTYPE_CAPA;
 	INIT_HLIST_NODE(&orig_node->mcast_want_all_unsnoopables_node);
 	INIT_HLIST_NODE(&orig_node->mcast_want_all_ipv4_node);
 	INIT_HLIST_NODE(&orig_node->mcast_want_all_ipv6_node);
diff --git a/net/batman-adv/routing.c b/net/batman-adv/routing.c
index 163cd43c4821..f1061985149f 100644
--- a/net/batman-adv/routing.c
+++ b/net/batman-adv/routing.c
@@ -1270,3 +1270,73 @@ int batadv_recv_bcast_packet(struct sk_buff *skb,
 	batadv_orig_node_put(orig_node);
 	return ret;
 }
+
+#ifdef CONFIG_BATMAN_ADV_MCAST
+/**
+ * batadv_recv_mcast_packet() - process received batman-adv multicast packet
+ * @skb: the received batman-adv multicast packet
+ * @recv_if: interface that the skb is received on
+ *
+ * Parses the given, received batman-adv multicast packet. Depending on the
+ * contents of its TVLV forwards it and/or decapsulates it to hand it to the
+ * soft interface.
+ *
+ * Return: NET_RX_DROP if the skb is not consumed, NET_RX_SUCCESS otherwise.
+ */
+int batadv_recv_mcast_packet(struct sk_buff *skb,
+			     struct batadv_hard_iface *recv_if)
+{
+	struct batadv_priv *bat_priv = netdev_priv(recv_if->soft_iface);
+	struct batadv_mcast_packet *mcast_packet;
+	int hdr_size = sizeof(*mcast_packet);
+	unsigned char *tvlv_buff;
+	int ret = NET_RX_DROP;
+	u16 tvlv_buff_len;
+
+	if (batadv_check_unicast_packet(bat_priv, skb, hdr_size) < 0)
+		goto free_skb;
+
+	/* create a copy of the skb, if needed, to modify it. */
+	if (skb_cow(skb, ETH_HLEN) < 0)
+		goto free_skb;
+
+	/* packet needs to be linearized to access the tvlv content */
+	if (skb_linearize(skb) < 0)
+		goto free_skb;
+
+	mcast_packet = (struct batadv_mcast_packet *)skb->data;
+	if (mcast_packet->ttl-- < 2)
+		goto free_skb;
+
+	tvlv_buff = (unsigned char *)(skb->data + hdr_size);
+	tvlv_buff_len = ntohs(mcast_packet->tvlv_len);
+
+	if (tvlv_buff_len > skb->len - hdr_size)
+		goto free_skb;
+
+	ret = batadv_tvlv_containers_process(bat_priv, BATADV_MCAST, NULL, skb,
+					     tvlv_buff, tvlv_buff_len);
+	if (ret >= 0) {
+		batadv_inc_counter(bat_priv, BATADV_CNT_MCAST_RX);
+		batadv_add_counter(bat_priv, BATADV_CNT_MCAST_RX_BYTES,
+				   skb->len + ETH_HLEN);
+	}
+
+	hdr_size += tvlv_buff_len;
+
+	if (ret == NET_RX_SUCCESS && (skb->len - hdr_size >= ETH_HLEN)) {
+		batadv_inc_counter(bat_priv, BATADV_CNT_MCAST_RX_LOCAL);
+		batadv_add_counter(bat_priv, BATADV_CNT_MCAST_RX_LOCAL_BYTES,
+				   skb->len - hdr_size);
+
+		batadv_interface_rx(bat_priv->soft_iface, skb, hdr_size, NULL);
+		/* skb was consumed */
+		skb = NULL;
+	}
+
+free_skb:
+	kfree_skb(skb);
+
+	return ret;
+}
+#endif /* CONFIG_BATMAN_ADV_MCAST */
diff --git a/net/batman-adv/routing.h b/net/batman-adv/routing.h
index 5f387786e9a7..d8293a83fb82 100644
--- a/net/batman-adv/routing.h
+++ b/net/batman-adv/routing.h
@@ -27,6 +27,17 @@ int batadv_recv_frag_packet(struct sk_buff *skb,
 			    struct batadv_hard_iface *iface);
 int batadv_recv_bcast_packet(struct sk_buff *skb,
 			     struct batadv_hard_iface *recv_if);
+#ifdef CONFIG_BATMAN_ADV_MCAST
+int batadv_recv_mcast_packet(struct sk_buff *skb,
+			     struct batadv_hard_iface *recv_if);
+#else
+static inline int batadv_recv_mcast_packet(struct sk_buff *skb,
+					   struct batadv_hard_iface *recv_if)
+{
+	kfree_skb(skb);
+	return NET_RX_DROP;
+}
+#endif
 int batadv_recv_tt_query(struct sk_buff *skb,
 			 struct batadv_hard_iface *recv_if);
 int batadv_recv_roam_adv(struct sk_buff *skb,
diff --git a/net/batman-adv/soft-interface.c b/net/batman-adv/soft-interface.c
index d3fdf82282af..72b7120e4629 100644
--- a/net/batman-adv/soft-interface.c
+++ b/net/batman-adv/soft-interface.c
@@ -922,6 +922,18 @@ static const struct {
 	{ "tt_response_rx" },
 	{ "tt_roam_adv_tx" },
 	{ "tt_roam_adv_rx" },
+#ifdef CONFIG_BATMAN_ADV_MCAST
+	{ "mcast_tx" },
+	{ "mcast_tx_bytes" },
+	{ "mcast_tx_local" },
+	{ "mcast_tx_local_bytes" },
+	{ "mcast_rx" },
+	{ "mcast_rx_bytes" },
+	{ "mcast_rx_local" },
+	{ "mcast_rx_local_bytes" },
+	{ "mcast_fwd" },
+	{ "mcast_fwd_bytes" },
+#endif
 #ifdef CONFIG_BATMAN_ADV_DAT
 	{ "dat_get_tx" },
 	{ "dat_get_rx" },
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index ca9449ec9836..a2fee3325b29 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -862,6 +862,70 @@ enum batadv_counters {
 	 */
 	BATADV_CNT_TT_ROAM_ADV_RX,
 
+#ifdef CONFIG_BATMAN_ADV_MCAST
+	/**
+	 * @BATADV_CNT_MCAST_TX: transmitted batman-adv multicast packets
+	 *  counter
+	 */
+	BATADV_CNT_MCAST_TX,
+
+	/**
+	 * @BATADV_CNT_MCAST_TX_BYTES: transmitted batman-adv multicast packets
+	 *  bytes counter
+	 */
+	BATADV_CNT_MCAST_TX_BYTES,
+
+	/**
+	 * @BATADV_CNT_MCAST_TX_LOCAL: counter for multicast packets which
+	 *  were locally encapsulated and transmitted as batman-adv multicast
+	 *  packets
+	 */
+	BATADV_CNT_MCAST_TX_LOCAL,
+
+	/**
+	 * @BATADV_CNT_MCAST_TX_LOCAL_BYTES: bytes counter for multicast packets
+	 *  which were locally encapsulated and transmitted as batman-adv
+	 *  multicast packets
+	 */
+	BATADV_CNT_MCAST_TX_LOCAL_BYTES,
+
+	/**
+	 * @BATADV_CNT_MCAST_RX: received batman-adv multicast packet counter
+	 */
+	BATADV_CNT_MCAST_RX,
+
+	/**
+	 * @BATADV_CNT_MCAST_RX_BYTES: received batman-adv multicast packet
+	 *  bytes counter
+	 */
+	BATADV_CNT_MCAST_RX_BYTES,
+
+	/**
+	 * @BATADV_CNT_MCAST_RX_LOCAL: counter for received batman-adv multicast
+	 *  packets which were forwarded to the local soft interface
+	 */
+	BATADV_CNT_MCAST_RX_LOCAL,
+
+	/**
+	 * @BATADV_CNT_MCAST_RX_LOCAL_BYTES: bytes counter for received
+	 *  batman-adv multicast packets which were forwarded to the local soft
+	 *  interface
+	 */
+	BATADV_CNT_MCAST_RX_LOCAL_BYTES,
+
+	/**
+	 * @BATADV_CNT_MCAST_FWD: counter for received batman-adv multicast
+	 *  packets which were forwarded to other, neighboring nodes
+	 */
+	BATADV_CNT_MCAST_FWD,
+
+	/**
+	 * @BATADV_CNT_MCAST_FWD_BYTES: bytes counter for received batman-adv
+	 *  multicast packets which were forwarded to other, neighboring nodes
+	 */
+	BATADV_CNT_MCAST_FWD_BYTES,
+#endif
+
 #ifdef CONFIG_BATMAN_ADV_DAT
 	/**
 	 * @BATADV_CNT_DAT_GET_TX: transmitted dht GET traffic packet counter
-- 
2.40.1

