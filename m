Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A837C83F17
	for <batman@archiver.kernel.org>; Thu, 10 Jul 2025 16:46:31 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 0134A84B4E
	for <batman@archiver.kernel.org>; Thu, 10 Jul 2025 18:46:30 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1752165989;
 b=X23fFzjZSqILRDiPvKs1YJqevekJzvJ+UKVnmDCsJURoDF2geMq394FNmmhbu5dicCLA1
 NojpuQ9oHu3T4dzYbM+3wsbGNyfF4Ol0BuaIceOijHfwBVjT8SBeKttEh9/6jwHp6Q0Hza0
 tu4GJouBBnJdXDbJFNSpAAEBwovTghA=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1752165989; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=OD2PJ3TMw4tFNobJIm05QY0XzLpJh18kFf2wZST2c0k=;
 b=285/TvjZe8ua/9Z7um5AP6ORmrzf5fSjJG43QHHPZQEs8VfrlIf6zYeLM2UXxZbzp+1wg
 yguLAHcvg7rUZsLpi2Y1eatnm13CPY2Y8z0TidX8/F4O8Iypc/xSqoSNzYlCCTCIhq9sfkM
 3gdnppdnwPa+XSeeO8NwqpvbP5g7jlM=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=fail;
  arc=pass;
  dmarc=fail (Used From Domain Record) header.from=simonwunderlich.de
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass;
 dmarc=fail (Used From Domain Record) header.from=simonwunderlich.de
 policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de
 [IPv6:2a01:4f8:c17:e8c0::1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 034BE8461F
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 10 Jul 2025 18:45:13 +0200 (CEST)
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1752165918; a=rsa-sha256;
	cv=none;
	b=wYMeBgT8qxRJ7h/wHdX4BVXIFjuPWZXOfFg2mVVIVB2JsYD/tCKlKU63mO7HPP4+ia+rkh
	/DlIlfjgay+au9WezEefZYbICpZxNH5MFFh36d9EAK6Sz743kWpCLbd1XFW0UPN0+w6MgB
	7nicfbGHJnGPidoWyTHqN1GjvEsnbpw=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 2a01:4f8:c17:e8c0::1 as permitted sender)
 smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1752165918;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OD2PJ3TMw4tFNobJIm05QY0XzLpJh18kFf2wZST2c0k=;
	b=MwxyvfUWbk2+Gu3VtNFr+fw3C8qkitOv7qh54zuPczMWTOCCf5gdlCxiJd13uglaxswT2U
	HZTTdo8mepxKpwlAsZmvaxCOhSZc5md6lx3+bglCFROjr+bh6oC9bD83zmiWwp15iFUihW
	ZgYSilzKn4nFB9j6iucewp3TDyOlcvU=
Received: from kero.packetmixer.de
 (p200300FA271Bac80353E86De392ba4aF.dip0.t-ipconnect.de
 [IPv6:2003:fa:271b:ac80:353e:86de:392b:a4af])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id BAC28FA131;
	Thu, 10 Jul 2025 18:45:12 +0200 (CEST)
From: Simon Wunderlich <sw@simonwunderlich.de>
To: kuba@kernel.org,
	davem@davemloft.net
Cc: netdev@vger.kernel.org,
	b.a.t.m.a.n@lists.open-mesh.org,
	Matthias Schiffer <mschiffer@universe-factory.net>,
	Sven Eckelmann <sven@narfation.org>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net-next 2/2] batman-adv: store hard_iface as iflink private
 data
Date: Thu, 10 Jul 2025 18:45:01 +0200
Message-Id: <20250710164501.153872-3-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250710164501.153872-1-sw@simonwunderlich.de>
References: <20250710164501.153872-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: E7TXFDQ234WCDCI5P3DFE4WTYSYVDE3M
X-Message-ID-Hash: E7TXFDQ234WCDCI5P3DFE4WTYSYVDE3M
X-MailFrom: sw@simonwunderlich.de
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/E7TXFDQ234WCDCI5P3DFE4WTYSYVDE3M/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Matthias Schiffer <mschiffer@universe-factory.net>

By passing the hard_iface to netdev_master_upper_dev_link() as private
data, we can iterate over hardifs of a mesh interface more efficiently
using netdev_for_each_lower_private*() (instead of iterating over the
global hardif list). In addition, this will enable resolving a hardif
from its netdev using netdev_lower_dev_get_private() and getting rid of
the global list altogether in the following patches.

A similar approach can be seen in the bonding driver.

Signed-off-by: Matthias Schiffer <mschiffer@universe-factory.net>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/bat_algo.c       |  1 +
 net/batman-adv/bat_algo.h       |  2 --
 net/batman-adv/bat_iv_ogm.c     | 25 +++++++--------------
 net/batman-adv/bat_v.c          |  6 ++---
 net/batman-adv/bat_v_elp.c      |  8 ++-----
 net/batman-adv/bat_v_ogm.c      | 14 ++++--------
 net/batman-adv/hard-interface.c | 39 ++++++++++++---------------------
 net/batman-adv/main.c           |  7 ++----
 net/batman-adv/mesh-interface.c |  6 ++---
 net/batman-adv/multicast.c      |  6 ++---
 net/batman-adv/netlink.c        |  7 ++----
 net/batman-adv/originator.c     |  7 ++----
 net/batman-adv/send.c           |  7 ++----
 13 files changed, 44 insertions(+), 91 deletions(-)

diff --git a/net/batman-adv/bat_algo.c b/net/batman-adv/bat_algo.c
index c0c982b6f029..49e5861b58ec 100644
--- a/net/batman-adv/bat_algo.c
+++ b/net/batman-adv/bat_algo.c
@@ -14,6 +14,7 @@
 #include <linux/skbuff.h>
 #include <linux/stddef.h>
 #include <linux/string.h>
+#include <linux/types.h>
 #include <net/genetlink.h>
 #include <net/netlink.h>
 #include <uapi/linux/batman_adv.h>
diff --git a/net/batman-adv/bat_algo.h b/net/batman-adv/bat_algo.h
index 2c486374af58..7ce9abbdb4b4 100644
--- a/net/batman-adv/bat_algo.h
+++ b/net/batman-adv/bat_algo.h
@@ -11,10 +11,8 @@
 
 #include <linux/netlink.h>
 #include <linux/skbuff.h>
-#include <linux/types.h>
 
 extern char batadv_routing_algo[];
-extern struct list_head batadv_hardif_list;
 
 void batadv_algo_init(void);
 struct batadv_algo_ops *batadv_algo_get(const char *name);
diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index 458879d21d66..54fe38b3b2fd 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -791,6 +791,7 @@ static void batadv_iv_ogm_schedule_buff(struct batadv_hard_iface *hard_iface)
 	struct batadv_ogm_packet *batadv_ogm_packet;
 	struct batadv_hard_iface *primary_if, *tmp_hard_iface;
 	int *ogm_buff_len = &hard_iface->bat_iv.ogm_buff_len;
+	struct list_head *iter;
 	u32 seqno;
 	u16 tvlv_len = 0;
 	unsigned long send_time;
@@ -847,10 +848,7 @@ static void batadv_iv_ogm_schedule_buff(struct batadv_hard_iface *hard_iface)
 	 * interfaces.
 	 */
 	rcu_read_lock();
-	list_for_each_entry_rcu(tmp_hard_iface, &batadv_hardif_list, list) {
-		if (tmp_hard_iface->mesh_iface != hard_iface->mesh_iface)
-			continue;
-
+	netdev_for_each_lower_private_rcu(hard_iface->mesh_iface, tmp_hard_iface, iter) {
 		if (!kref_get_unless_zero(&tmp_hard_iface->refcount))
 			continue;
 
@@ -1567,6 +1565,7 @@ static void batadv_iv_ogm_process(const struct sk_buff *skb, int ogm_offset,
 	bool is_my_oldorig = false;
 	bool is_my_addr = false;
 	bool is_my_orig = false;
+	struct list_head *iter;
 
 	ogm_packet = (struct batadv_ogm_packet *)(skb->data + ogm_offset);
 	ethhdr = eth_hdr(skb);
@@ -1603,11 +1602,9 @@ static void batadv_iv_ogm_process(const struct sk_buff *skb, int ogm_offset,
 		   ogm_packet->version, has_directlink_flag);
 
 	rcu_read_lock();
-	list_for_each_entry_rcu(hard_iface, &batadv_hardif_list, list) {
-		if (hard_iface->if_status != BATADV_IF_ACTIVE)
-			continue;
 
-		if (hard_iface->mesh_iface != if_incoming->mesh_iface)
+	netdev_for_each_lower_private_rcu(if_incoming->mesh_iface, hard_iface, iter) {
+		if (hard_iface->if_status != BATADV_IF_ACTIVE)
 			continue;
 
 		if (batadv_compare_eth(ethhdr->h_source,
@@ -1668,13 +1665,10 @@ static void batadv_iv_ogm_process(const struct sk_buff *skb, int ogm_offset,
 					if_incoming, BATADV_IF_DEFAULT);
 
 	rcu_read_lock();
-	list_for_each_entry_rcu(hard_iface, &batadv_hardif_list, list) {
+	netdev_for_each_lower_private_rcu(bat_priv->mesh_iface, hard_iface, iter) {
 		if (hard_iface->if_status != BATADV_IF_ACTIVE)
 			continue;
 
-		if (hard_iface->mesh_iface != bat_priv->mesh_iface)
-			continue;
-
 		if (!kref_get_unless_zero(&hard_iface->refcount))
 			continue;
 
@@ -2142,6 +2136,7 @@ batadv_iv_ogm_neigh_dump(struct sk_buff *msg, struct netlink_callback *cb,
 			 struct batadv_hard_iface *single_hardif)
 {
 	struct batadv_hard_iface *hard_iface;
+	struct list_head *iter;
 	int i_hardif = 0;
 	int i_hardif_s = cb->args[0];
 	int idx = cb->args[1];
@@ -2158,11 +2153,7 @@ batadv_iv_ogm_neigh_dump(struct sk_buff *msg, struct netlink_callback *cb,
 				i_hardif++;
 		}
 	} else {
-		list_for_each_entry_rcu(hard_iface, &batadv_hardif_list,
-					list) {
-			if (hard_iface->mesh_iface != bat_priv->mesh_iface)
-				continue;
-
+		netdev_for_each_lower_private_rcu(bat_priv->mesh_iface, hard_iface, iter) {
 			if (i_hardif++ < i_hardif_s)
 				continue;
 
diff --git a/net/batman-adv/bat_v.c b/net/batman-adv/bat_v.c
index c16c2e60889d..de9444714264 100644
--- a/net/batman-adv/bat_v.c
+++ b/net/batman-adv/bat_v.c
@@ -212,6 +212,7 @@ batadv_v_neigh_dump(struct sk_buff *msg, struct netlink_callback *cb,
 		    struct batadv_hard_iface *single_hardif)
 {
 	struct batadv_hard_iface *hard_iface;
+	struct list_head *iter;
 	int i_hardif = 0;
 	int i_hardif_s = cb->args[0];
 	int idx = cb->args[1];
@@ -227,10 +228,7 @@ batadv_v_neigh_dump(struct sk_buff *msg, struct netlink_callback *cb,
 				i_hardif++;
 		}
 	} else {
-		list_for_each_entry_rcu(hard_iface, &batadv_hardif_list, list) {
-			if (hard_iface->mesh_iface != bat_priv->mesh_iface)
-				continue;
-
+		netdev_for_each_lower_private_rcu(bat_priv->mesh_iface, hard_iface, iter) {
 			if (i_hardif++ < i_hardif_s)
 				continue;
 
diff --git a/net/batman-adv/bat_v_elp.c b/net/batman-adv/bat_v_elp.c
index 70d6778da0d7..cb16c1ed2a58 100644
--- a/net/batman-adv/bat_v_elp.c
+++ b/net/batman-adv/bat_v_elp.c
@@ -35,7 +35,6 @@
 #include <net/cfg80211.h>
 #include <uapi/linux/batadv_packet.h>
 
-#include "bat_algo.h"
 #include "bat_v_ogm.h"
 #include "hard-interface.h"
 #include "log.h"
@@ -472,15 +471,12 @@ void batadv_v_elp_iface_activate(struct batadv_hard_iface *primary_iface,
 void batadv_v_elp_primary_iface_set(struct batadv_hard_iface *primary_iface)
 {
 	struct batadv_hard_iface *hard_iface;
+	struct list_head *iter;
 
 	/* update orig field of every elp iface belonging to this mesh */
 	rcu_read_lock();
-	list_for_each_entry_rcu(hard_iface, &batadv_hardif_list, list) {
-		if (primary_iface->mesh_iface != hard_iface->mesh_iface)
-			continue;
-
+	netdev_for_each_lower_private_rcu(primary_iface->mesh_iface, hard_iface, iter)
 		batadv_v_elp_iface_activate(primary_iface, hard_iface);
-	}
 	rcu_read_unlock();
 }
 
diff --git a/net/batman-adv/bat_v_ogm.c b/net/batman-adv/bat_v_ogm.c
index b86bb647da5b..e3870492dab7 100644
--- a/net/batman-adv/bat_v_ogm.c
+++ b/net/batman-adv/bat_v_ogm.c
@@ -22,7 +22,6 @@
 #include <linux/mutex.h>
 #include <linux/netdevice.h>
 #include <linux/random.h>
-#include <linux/rculist.h>
 #include <linux/rcupdate.h>
 #include <linux/skbuff.h>
 #include <linux/slab.h>
@@ -33,7 +32,6 @@
 #include <linux/workqueue.h>
 #include <uapi/linux/batadv_packet.h>
 
-#include "bat_algo.h"
 #include "hard-interface.h"
 #include "hash.h"
 #include "log.h"
@@ -265,6 +263,7 @@ static void batadv_v_ogm_send_meshif(struct batadv_priv *bat_priv)
 	struct batadv_ogm2_packet *ogm_packet;
 	struct sk_buff *skb, *skb_tmp;
 	unsigned char *ogm_buff;
+	struct list_head *iter;
 	int ogm_buff_len;
 	u16 tvlv_len = 0;
 	int ret;
@@ -301,10 +300,7 @@ static void batadv_v_ogm_send_meshif(struct batadv_priv *bat_priv)
 
 	/* broadcast on every interface */
 	rcu_read_lock();
-	list_for_each_entry_rcu(hard_iface, &batadv_hardif_list, list) {
-		if (hard_iface->mesh_iface != bat_priv->mesh_iface)
-			continue;
-
+	netdev_for_each_lower_private_rcu(bat_priv->mesh_iface, hard_iface, iter) {
 		if (!kref_get_unless_zero(&hard_iface->refcount))
 			continue;
 
@@ -859,6 +855,7 @@ static void batadv_v_ogm_process(const struct sk_buff *skb, int ogm_offset,
 	struct batadv_hard_iface *hard_iface;
 	struct batadv_ogm2_packet *ogm_packet;
 	u32 ogm_throughput, link_throughput, path_throughput;
+	struct list_head *iter;
 	int ret;
 
 	ethhdr = eth_hdr(skb);
@@ -921,13 +918,10 @@ static void batadv_v_ogm_process(const struct sk_buff *skb, int ogm_offset,
 				       BATADV_IF_DEFAULT);
 
 	rcu_read_lock();
-	list_for_each_entry_rcu(hard_iface, &batadv_hardif_list, list) {
+	netdev_for_each_lower_private_rcu(bat_priv->mesh_iface, hard_iface, iter) {
 		if (hard_iface->if_status != BATADV_IF_ACTIVE)
 			continue;
 
-		if (hard_iface->mesh_iface != bat_priv->mesh_iface)
-			continue;
-
 		if (!kref_get_unless_zero(&hard_iface->refcount))
 			continue;
 
diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index 558d39dffc23..bace57e4f9a5 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -438,15 +438,13 @@ int batadv_hardif_no_broadcast(struct batadv_hard_iface *if_outgoing,
 }
 
 static struct batadv_hard_iface *
-batadv_hardif_get_active(const struct net_device *mesh_iface)
+batadv_hardif_get_active(struct net_device *mesh_iface)
 {
 	struct batadv_hard_iface *hard_iface;
+	struct list_head *iter;
 
 	rcu_read_lock();
-	list_for_each_entry_rcu(hard_iface, &batadv_hardif_list, list) {
-		if (hard_iface->mesh_iface != mesh_iface)
-			continue;
-
+	netdev_for_each_lower_private_rcu(mesh_iface, hard_iface, iter) {
 		if (hard_iface->if_status == BATADV_IF_ACTIVE &&
 		    kref_get_unless_zero(&hard_iface->refcount))
 			goto out;
@@ -508,19 +506,17 @@ batadv_hardif_is_iface_up(const struct batadv_hard_iface *hard_iface)
 
 static void batadv_check_known_mac_addr(const struct batadv_hard_iface *hard_iface)
 {
-	const struct net_device *mesh_iface = hard_iface->mesh_iface;
+	struct net_device *mesh_iface = hard_iface->mesh_iface;
 	const struct batadv_hard_iface *tmp_hard_iface;
+	struct list_head *iter;
 
 	if (!mesh_iface)
 		return;
 
-	list_for_each_entry(tmp_hard_iface, &batadv_hardif_list, list) {
+	netdev_for_each_lower_private(mesh_iface, tmp_hard_iface, iter) {
 		if (tmp_hard_iface == hard_iface)
 			continue;
 
-		if (tmp_hard_iface->mesh_iface != mesh_iface)
-			continue;
-
 		if (tmp_hard_iface->if_status == BATADV_IF_NOT_IN_USE)
 			continue;
 
@@ -545,15 +541,13 @@ static void batadv_hardif_recalc_extra_skbroom(struct net_device *mesh_iface)
 	unsigned short lower_headroom = 0;
 	unsigned short lower_tailroom = 0;
 	unsigned short needed_headroom;
+	struct list_head *iter;
 
 	rcu_read_lock();
-	list_for_each_entry_rcu(hard_iface, &batadv_hardif_list, list) {
+	netdev_for_each_lower_private_rcu(mesh_iface, hard_iface, iter) {
 		if (hard_iface->if_status == BATADV_IF_NOT_IN_USE)
 			continue;
 
-		if (hard_iface->mesh_iface != mesh_iface)
-			continue;
-
 		lower_header_len = max_t(unsigned short, lower_header_len,
 					 hard_iface->net_dev->hard_header_len);
 
@@ -586,17 +580,15 @@ int batadv_hardif_min_mtu(struct net_device *mesh_iface)
 {
 	struct batadv_priv *bat_priv = netdev_priv(mesh_iface);
 	const struct batadv_hard_iface *hard_iface;
+	struct list_head *iter;
 	int min_mtu = INT_MAX;
 
 	rcu_read_lock();
-	list_for_each_entry_rcu(hard_iface, &batadv_hardif_list, list) {
+	netdev_for_each_lower_private_rcu(mesh_iface, hard_iface, iter) {
 		if (hard_iface->if_status != BATADV_IF_ACTIVE &&
 		    hard_iface->if_status != BATADV_IF_TO_BE_ACTIVATED)
 			continue;
 
-		if (hard_iface->mesh_iface != mesh_iface)
-			continue;
-
 		min_mtu = min_t(int, hard_iface->net_dev->mtu, min_mtu);
 	}
 	rcu_read_unlock();
@@ -734,7 +726,7 @@ int batadv_hardif_enable_interface(struct batadv_hard_iface *hard_iface,
 	bat_priv = netdev_priv(hard_iface->mesh_iface);
 
 	ret = netdev_master_upper_dev_link(hard_iface->net_dev,
-					   mesh_iface, NULL, NULL, NULL);
+					   mesh_iface, hard_iface, NULL, NULL);
 	if (ret)
 		goto err_dev;
 
@@ -803,18 +795,15 @@ int batadv_hardif_enable_interface(struct batadv_hard_iface *hard_iface,
  *
  * Return: number of connected/enslaved hard interfaces
  */
-static size_t batadv_hardif_cnt(const struct net_device *mesh_iface)
+static size_t batadv_hardif_cnt(struct net_device *mesh_iface)
 {
 	struct batadv_hard_iface *hard_iface;
+	struct list_head *iter;
 	size_t count = 0;
 
 	rcu_read_lock();
-	list_for_each_entry_rcu(hard_iface, &batadv_hardif_list, list) {
-		if (hard_iface->mesh_iface != mesh_iface)
-			continue;
-
+	netdev_for_each_lower_private_rcu(mesh_iface, hard_iface, iter)
 		count++;
-	}
 	rcu_read_unlock();
 
 	return count;
diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index c0bc75513355..20346d7b6b69 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -27,7 +27,6 @@
 #include <linux/module.h>
 #include <linux/netdevice.h>
 #include <linux/printk.h>
-#include <linux/rculist.h>
 #include <linux/rcupdate.h>
 #include <linux/skbuff.h>
 #include <linux/slab.h>
@@ -303,16 +302,14 @@ void batadv_mesh_free(struct net_device *mesh_iface)
 bool batadv_is_my_mac(struct batadv_priv *bat_priv, const u8 *addr)
 {
 	const struct batadv_hard_iface *hard_iface;
+	struct list_head *iter;
 	bool is_my_mac = false;
 
 	rcu_read_lock();
-	list_for_each_entry_rcu(hard_iface, &batadv_hardif_list, list) {
+	netdev_for_each_lower_private_rcu(bat_priv->mesh_iface, hard_iface, iter) {
 		if (hard_iface->if_status != BATADV_IF_ACTIVE)
 			continue;
 
-		if (hard_iface->mesh_iface != bat_priv->mesh_iface)
-			continue;
-
 		if (batadv_compare_eth(hard_iface->net_dev->dev_addr, addr)) {
 			is_my_mac = true;
 			break;
diff --git a/net/batman-adv/mesh-interface.c b/net/batman-adv/mesh-interface.c
index 5bbc366f974d..de2c2d9c6e4d 100644
--- a/net/batman-adv/mesh-interface.c
+++ b/net/batman-adv/mesh-interface.c
@@ -1101,9 +1101,9 @@ static void batadv_meshif_destroy_netlink(struct net_device *mesh_iface,
 	struct batadv_hard_iface *hard_iface;
 	struct batadv_meshif_vlan *vlan;
 
-	list_for_each_entry(hard_iface, &batadv_hardif_list, list) {
-		if (hard_iface->mesh_iface == mesh_iface)
-			batadv_hardif_disable_interface(hard_iface);
+	while (!list_empty(&mesh_iface->adj_list.lower)) {
+		hard_iface = netdev_adjacent_get_private(mesh_iface->adj_list.lower.next);
+		batadv_hardif_disable_interface(hard_iface);
 	}
 
 	/* destroy the "untagged" VLAN */
diff --git a/net/batman-adv/multicast.c b/net/batman-adv/multicast.c
index 5786680aff30..e8c6b0bf670f 100644
--- a/net/batman-adv/multicast.c
+++ b/net/batman-adv/multicast.c
@@ -246,15 +246,13 @@ static u8 batadv_mcast_mla_rtr_flags_get(struct batadv_priv *bat_priv,
 static u8 batadv_mcast_mla_forw_flags_get(struct batadv_priv *bat_priv)
 {
 	const struct batadv_hard_iface *hard_iface;
+	struct list_head *iter;
 
 	rcu_read_lock();
-	list_for_each_entry_rcu(hard_iface, &batadv_hardif_list, list) {
+	netdev_for_each_lower_private_rcu(bat_priv->mesh_iface, hard_iface, iter) {
 		if (hard_iface->if_status != BATADV_IF_ACTIVE)
 			continue;
 
-		if (hard_iface->mesh_iface != bat_priv->mesh_iface)
-			continue;
-
 		if (hard_iface->net_dev->mtu < IPV6_MIN_MTU) {
 			rcu_read_unlock();
 			return BATADV_NO_FLAGS;
diff --git a/net/batman-adv/netlink.c b/net/batman-adv/netlink.c
index e7c8f9f2bb1f..beb181b3a7d8 100644
--- a/net/batman-adv/netlink.c
+++ b/net/batman-adv/netlink.c
@@ -20,7 +20,6 @@
 #include <linux/if_vlan.h>
 #include <linux/init.h>
 #include <linux/limits.h>
-#include <linux/list.h>
 #include <linux/minmax.h>
 #include <linux/netdevice.h>
 #include <linux/netlink.h>
@@ -968,6 +967,7 @@ batadv_netlink_dump_hardif(struct sk_buff *msg, struct netlink_callback *cb)
 	struct batadv_priv *bat_priv;
 	int portid = NETLINK_CB(cb->skb).portid;
 	int skip = cb->args[0];
+	struct list_head *iter;
 	int i = 0;
 
 	mesh_iface = batadv_netlink_get_meshif(cb);
@@ -979,10 +979,7 @@ batadv_netlink_dump_hardif(struct sk_buff *msg, struct netlink_callback *cb)
 	rtnl_lock();
 	cb->seq = batadv_hardif_generation << 1 | 1;
 
-	list_for_each_entry(hard_iface, &batadv_hardif_list, list) {
-		if (hard_iface->mesh_iface != mesh_iface)
-			continue;
-
+	netdev_for_each_lower_private(mesh_iface, hard_iface, iter) {
 		if (i++ < skip)
 			continue;
 
diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
index d9cfc5c6b208..a464ff96b929 100644
--- a/net/batman-adv/originator.c
+++ b/net/batman-adv/originator.c
@@ -29,7 +29,6 @@
 #include <linux/workqueue.h>
 #include <uapi/linux/batadv_packet.h>
 
-#include "bat_algo.h"
 #include "distributed-arp-table.h"
 #include "fragmentation.h"
 #include "gateway_client.h"
@@ -1208,6 +1207,7 @@ static bool batadv_purge_orig_node(struct batadv_priv *bat_priv,
 	struct batadv_neigh_node *best_neigh_node;
 	struct batadv_hard_iface *hard_iface;
 	bool changed_ifinfo, changed_neigh;
+	struct list_head *iter;
 
 	if (batadv_has_timed_out(orig_node->last_seen,
 				 2 * BATADV_PURGE_TIMEOUT)) {
@@ -1232,13 +1232,10 @@ static bool batadv_purge_orig_node(struct batadv_priv *bat_priv,
 
 	/* ... then for all other interfaces. */
 	rcu_read_lock();
-	list_for_each_entry_rcu(hard_iface, &batadv_hardif_list, list) {
+	netdev_for_each_lower_private_rcu(bat_priv->mesh_iface, hard_iface, iter) {
 		if (hard_iface->if_status != BATADV_IF_ACTIVE)
 			continue;
 
-		if (hard_iface->mesh_iface != bat_priv->mesh_iface)
-			continue;
-
 		if (!kref_get_unless_zero(&hard_iface->refcount))
 			continue;
 
diff --git a/net/batman-adv/send.c b/net/batman-adv/send.c
index 9d72f4f15b3d..95849ba004e7 100644
--- a/net/batman-adv/send.c
+++ b/net/batman-adv/send.c
@@ -21,7 +21,6 @@
 #include <linux/list.h>
 #include <linux/netdevice.h>
 #include <linux/printk.h>
-#include <linux/rculist.h>
 #include <linux/rcupdate.h>
 #include <linux/skbuff.h>
 #include <linux/slab.h>
@@ -924,6 +923,7 @@ static int __batadv_forw_bcast_packet(struct batadv_priv *bat_priv,
 {
 	struct batadv_hard_iface *hard_iface;
 	struct batadv_hard_iface *primary_if;
+	struct list_head *iter;
 	int ret = NETDEV_TX_OK;
 
 	primary_if = batadv_primary_if_get_selected(bat_priv);
@@ -931,10 +931,7 @@ static int __batadv_forw_bcast_packet(struct batadv_priv *bat_priv,
 		return NETDEV_TX_BUSY;
 
 	rcu_read_lock();
-	list_for_each_entry_rcu(hard_iface, &batadv_hardif_list, list) {
-		if (hard_iface->mesh_iface != bat_priv->mesh_iface)
-			continue;
-
+	netdev_for_each_lower_private_rcu(bat_priv->mesh_iface, hard_iface, iter) {
 		if (!kref_get_unless_zero(&hard_iface->refcount))
 			continue;
 
-- 
2.39.5

