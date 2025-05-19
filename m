Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC97CC2D0CD
	for <batman-adv@archiver.kernel.org>; Mon, 19 May 2025 20:48:03 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 423DB84881
	for <batman-adv@archiver.kernel.org>; Mon, 19 May 2025 22:48:02 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1747687682;
 b=3ITPLFeHMP7QUM7Z7+ZgOWlqXlxN1Uar8fsHVuyB9rcVls3KUZYkyPqZ50+Y79KX4fF85
 v64HR8Ts4yutnvXEAL7q46stF1LZ0TIuqXF4c/Cldz6wiNb8P3aQOWdycU6mM1msGDi+fA0
 IltbrGgoT/QzQQG6UA1urSdpePUnVCM=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1747687682; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=EXMQi/xy0N2VP3mnfZigLdVH9AZQqcC95mPj0uq9XRs=;
 b=DCfeYdU/Ts49ir9mk4x/yvXtsrChT0NMPBXriaQuIUZttE8Vy6k/mNg63UNnxnSkERQke
 9pwOLYAgvvo2ewyMCeDnnBaq8tODQwTV38e7GW/WpunSMNEq/0Gb9NwYtdIf7D/KpEmCHyj
 LjmVTU+Au8WU4XxaZL3dLAwfmsuD2Pk=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=universe-factory.net;
  arc=pass;
  dmarc=none
Authentication-Results: open-mesh.org;
 dkim=pass header.d=universe-factory.net; arc=pass; dmarc=none
Received: from mail.universe-factory.net (osgiliath.universe-factory.net
 [141.95.161.142])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id EB572842E0
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 19 May 2025 22:47:04 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1747687630;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=EXMQi/xy0N2VP3mnfZigLdVH9AZQqcC95mPj0uq9XRs=;
	b=zh/irvZlqrpE9yKhGsJlc86XcLZZZ4m++2HOmWLnAXTlEGUerQmip86Lm517N5odBkHxfY
	OBVFVwVmLeydfB/e2ZRHqXbg0hUINwaePAS0rGAvz/MNolh0lnJkeCYdyoLB4GR6CWhzme
	KOTNm+mYyeaLfSmFqZu+v45qE1s7oWQ=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=universe-factory.net header.s=dkim header.b=Oat5xWuC;
	dmarc=pass (policy=reject) header.from=universe-factory.net;
	spf=pass (diktynna.open-mesh.org: domain of mschiffer@universe-factory.net
 designates 141.95.161.142 as permitted sender)
 smtp.mailfrom=mschiffer@universe-factory.net
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1747687630; a=rsa-sha256;
	cv=none;
	b=RVIH1BbJqIr4ig9KJ3LlAVFutm9vL0eUSlVJPfG7Gu4vvfc402asn8RhZviKSXGKa3CrC+
	3pZIui7soKE/yLeyecquEFzGKsoUkJvqiWrfd+OiR+FmtfulRfi/xj+BV8eeRiXGDDngzK
	iSz+7E7ZQJb8Gkl/hFBxDJmkcJH0X0Q=
From: Matthias Schiffer <mschiffer@universe-factory.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=universe-factory.net;
	s=dkim; t=1747687623;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=EXMQi/xy0N2VP3mnfZigLdVH9AZQqcC95mPj0uq9XRs=;
	b=Oat5xWuC41NdFze6idg61lNIb7wBIzu72hgO5s72gaaepD7XnH4XG7orvHU/Cv+LR3yRqo
	kq8BkWiiSM3irYOP2JFo0ArJncYJKvPUNS2eLgsXBEaWImTtN1bLxrZH5udbEqESdVg49w
	9h5vHQL3GYUzNNZ2B5S3rF4EBToHD2/5lWyRm6R6nwfWDZeFPty8gdDTsr8OWgGA4rKDd1
	l8Zu5n+YLoD5LxBFobTtzvOozalyGtu+T8Gns1/WjB1q6R0UK9rx7gEnY2yhRktSSX3HlW
	6pey1Fl5M3IjbKI2PwuKS2e+wQCiPMSAGAFid7jW1ZMpWpAXcrERTVfpVyjQ9Q==
To: Marek Lindner <marek.lindner@mailbox.org>,
	Simon Wunderlich <sw@simonwunderlich.de>,
	Antonio Quartulli <antonio@mandelbit.com>,
	Sven Eckelmann <sven@narfation.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Matthias Schiffer <mschiffer@universe-factory.net>
Subject: [PATCH batadv 1/5] batman-adv: store hard_iface as iflink private
 data
Date: Mon, 19 May 2025 22:46:28 +0200
Message-ID: 
 <0b26554afea5203820faef1dfb498af7533a9b5d.1747687504.git.mschiffer@universe-factory.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: -
Message-ID-Hash: RHMTDV55KIWQDPEJG2SYLFYMJONSBRF5
X-Message-ID-Hash: RHMTDV55KIWQDPEJG2SYLFYMJONSBRF5
X-MailFrom: mschiffer@universe-factory.net
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/RHMTDV55KIWQDPEJG2SYLFYMJONSBRF5/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

By passing the hard_iface to netdev_master_upper_dev_link() as private
data, we can iterate over hardifs of a mesh interface more efficiently
using netdev_for_each_lower_private*() (instead of iterating over the
global hardif list). In addition, this will enable resolving a hardif
from its netdev using netdev_lower_dev_get_private() and getting rid of
the global list altogether in the following patches.

A similar approach can be seen in the bonding driver.

Signed-off-by: Matthias Schiffer <mschiffer@universe-factory.net>
---
 net/batman-adv/bat_algo.h       |  1 -
 net/batman-adv/bat_iv_ogm.c     | 25 +++++++--------------
 net/batman-adv/bat_v.c          |  6 ++---
 net/batman-adv/bat_v_elp.c      |  7 ++----
 net/batman-adv/bat_v_ogm.c      | 12 ++++------
 net/batman-adv/hard-interface.c | 39 ++++++++++++---------------------
 net/batman-adv/main.c           |  6 ++---
 net/batman-adv/mesh-interface.c |  6 ++---
 net/batman-adv/multicast.c      |  6 ++---
 net/batman-adv/netlink.c        |  6 ++---
 net/batman-adv/originator.c     |  6 ++---
 net/batman-adv/send.c           |  6 ++---
 12 files changed, 43 insertions(+), 83 deletions(-)

diff --git a/net/batman-adv/bat_algo.h b/net/batman-adv/bat_algo.h
index 2c486374af58..980ea75e1e94 100644
--- a/net/batman-adv/bat_algo.h
+++ b/net/batman-adv/bat_algo.h
@@ -14,7 +14,6 @@
 #include <linux/types.h>
 
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
index 70d6778da0d7..42ec62387ce1 100644
--- a/net/batman-adv/bat_v_elp.c
+++ b/net/batman-adv/bat_v_elp.c
@@ -472,15 +472,12 @@ void batadv_v_elp_iface_activate(struct batadv_hard_iface *primary_iface,
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
index b86bb647da5b..a04685ace339 100644
--- a/net/batman-adv/bat_v_ogm.c
+++ b/net/batman-adv/bat_v_ogm.c
@@ -265,6 +265,7 @@ static void batadv_v_ogm_send_meshif(struct batadv_priv *bat_priv)
 	struct batadv_ogm2_packet *ogm_packet;
 	struct sk_buff *skb, *skb_tmp;
 	unsigned char *ogm_buff;
+	struct list_head *iter;
 	int ogm_buff_len;
 	u16 tvlv_len = 0;
 	int ret;
@@ -301,10 +302,7 @@ static void batadv_v_ogm_send_meshif(struct batadv_priv *bat_priv)
 
 	/* broadcast on every interface */
 	rcu_read_lock();
-	list_for_each_entry_rcu(hard_iface, &batadv_hardif_list, list) {
-		if (hard_iface->mesh_iface != bat_priv->mesh_iface)
-			continue;
-
+	netdev_for_each_lower_private_rcu(bat_priv->mesh_iface, hard_iface, iter) {
 		if (!kref_get_unless_zero(&hard_iface->refcount))
 			continue;
 
@@ -859,6 +857,7 @@ static void batadv_v_ogm_process(const struct sk_buff *skb, int ogm_offset,
 	struct batadv_hard_iface *hard_iface;
 	struct batadv_ogm2_packet *ogm_packet;
 	u32 ogm_throughput, link_throughput, path_throughput;
+	struct list_head *iter;
 	int ret;
 
 	ethhdr = eth_hdr(skb);
@@ -921,13 +920,10 @@ static void batadv_v_ogm_process(const struct sk_buff *skb, int ogm_offset,
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
index c0bc75513355..f1a7233de1da 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -303,16 +303,14 @@ void batadv_mesh_free(struct net_device *mesh_iface)
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
index 72f684a4cb73..5872818f4e31 100644
--- a/net/batman-adv/mesh-interface.c
+++ b/net/batman-adv/mesh-interface.c
@@ -1115,9 +1115,9 @@ static void batadv_meshif_destroy_netlink(struct net_device *mesh_iface,
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
index f26892b362e2..70953b5bdfb4 100644
--- a/net/batman-adv/multicast.c
+++ b/net/batman-adv/multicast.c
@@ -254,15 +254,13 @@ static u8 batadv_mcast_mla_rtr_flags_get(struct batadv_priv *bat_priv,
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
index c33d2c6cb6c4..41c1e7e0cf0d 100644
--- a/net/batman-adv/netlink.c
+++ b/net/batman-adv/netlink.c
@@ -968,6 +968,7 @@ batadv_netlink_dump_hardif(struct sk_buff *msg, struct netlink_callback *cb)
 	struct batadv_priv *bat_priv;
 	int portid = NETLINK_CB(cb->skb).portid;
 	int skip = cb->args[0];
+	struct list_head *iter;
 	int i = 0;
 
 	mesh_iface = batadv_netlink_get_meshif(cb);
@@ -979,10 +980,7 @@ batadv_netlink_dump_hardif(struct sk_buff *msg, struct netlink_callback *cb)
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
index d9cfc5c6b208..2726f2905f3c 100644
--- a/net/batman-adv/originator.c
+++ b/net/batman-adv/originator.c
@@ -1208,6 +1208,7 @@ static bool batadv_purge_orig_node(struct batadv_priv *bat_priv,
 	struct batadv_neigh_node *best_neigh_node;
 	struct batadv_hard_iface *hard_iface;
 	bool changed_ifinfo, changed_neigh;
+	struct list_head *iter;
 
 	if (batadv_has_timed_out(orig_node->last_seen,
 				 2 * BATADV_PURGE_TIMEOUT)) {
@@ -1232,13 +1233,10 @@ static bool batadv_purge_orig_node(struct batadv_priv *bat_priv,
 
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
index 9d72f4f15b3d..225689b4f17d 100644
--- a/net/batman-adv/send.c
+++ b/net/batman-adv/send.c
@@ -924,6 +924,7 @@ static int __batadv_forw_bcast_packet(struct batadv_priv *bat_priv,
 {
 	struct batadv_hard_iface *hard_iface;
 	struct batadv_hard_iface *primary_if;
+	struct list_head *iter;
 	int ret = NETDEV_TX_OK;
 
 	primary_if = batadv_primary_if_get_selected(bat_priv);
@@ -931,10 +932,7 @@ static int __batadv_forw_bcast_packet(struct batadv_priv *bat_priv,
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
2.49.0

