Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3EC2C3ABDD
	for <batman-adv@archiver.kernel.org>; Mon, 19 May 2025 20:49:28 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 4B17084BA3
	for <batman-adv@archiver.kernel.org>; Mon, 19 May 2025 22:49:27 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1747687767;
 b=s27T2X0F9j91kTKts9/AZNS5afuD4pyDVkFU+DnsBBqAlpO90uVoxf1N0FpReJbs9OFBU
 0g82Yslk9F8OLhxLcneVHlDYpY8pTaOjjkYyXiX3XlFmgq4HErQfcxcwZh1hUhUqvU1p2CA
 1LPx52HnZ9MucsLZS/5r2PAbWJk+TQM=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1747687767; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=QjKLo/tOnJbbn4RE3qNlH9tuSfGKWChkWil4hpttwM4=;
 b=g6VvkvzC7YGJDbYT/qtRBQaqYT++cMQLn5PH9T0qzMdvhKXDwhJuAfD46LnTFlAzCwlqF
 RktJues55EKfZTVNrydNFs7uSjhZIj3qg9GM1r7mC6RFXVmjM92KG4uiUjNCsCN7KES26Ac
 dLIDfmtzqRoxJehRhFhhCFsQgp6hlFw=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=universe-factory.net;
  arc=pass;
  dmarc=none
Authentication-Results: open-mesh.org;
 dkim=pass header.d=universe-factory.net; arc=pass; dmarc=none
Received: from mail.universe-factory.net (osgiliath.universe-factory.net
 [141.95.161.142])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id C521783EF8
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 19 May 2025 22:47:05 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1747687630;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=QjKLo/tOnJbbn4RE3qNlH9tuSfGKWChkWil4hpttwM4=;
	b=nhaZSzAn3fI9ZZ41H2bkzVepiGLM+prnWS+Swo6LaiykOqs27FF/unDg8WhrfMNdkA0pzC
	9ig/TiR1eQmGMOiSMXzNth7G3SLAd/RDycZvQ/azoZ31c8nXvzf4WbsV39zTrBOiuMBSZx
	bwE47g5nmdNFqFG4tKfmL6O6IXN/WV0=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=universe-factory.net header.s=dkim header.b=ctEsFRqe;
	dmarc=pass (policy=reject) header.from=universe-factory.net;
	spf=pass (diktynna.open-mesh.org: domain of mschiffer@universe-factory.net
 designates 141.95.161.142 as permitted sender)
 smtp.mailfrom=mschiffer@universe-factory.net
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1747687630; a=rsa-sha256;
	cv=none;
	b=DcaDA4Cc7xRkYUc+A2gXICyCPUy5vxasxkq2p+hQQaZ5mpsbVKQptS82RiiDeAxkLaziZk
	MHvaautWSVCInfVZJ1G+Whc/DOBPNytqwK1OF3nNPSOrBhi3Gih4p3WrVEJ1b6V87Dgxtv
	TKPKxPUd+A9yERDIdWrtXI/dom/mMlc=
From: Matthias Schiffer <mschiffer@universe-factory.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=universe-factory.net;
	s=dkim; t=1747687625;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QjKLo/tOnJbbn4RE3qNlH9tuSfGKWChkWil4hpttwM4=;
	b=ctEsFRqe5Ac/NbKeEnR97EPb8EEaVr7ZcIbDP+gqCAKSqg9Hyn5tarkQ3bZSr1mmXSQ4cb
	1Ieg5OstWu3YDYPkD25JEn/bqn4Ic4yo9meg8gd9Lb5EEUVySrbUC1STxXGRDA8LSx0c+j
	kpI8uIPTwgi0rj3+BlvoRGXywt0VAHBz/biXuehhj/umVJptSZONd/cVz1SrWfcU3VBk9c
	7S66Iny0zaxmCCgH32/YMYe5ZsK4mE0JpwSOviQ0UdX0AD4Kz2qls9DxltB17bHt8XZM4F
	wtkrIC4X4WRxP6rI7FVobaQYfEWgnG2AiAGUD+49EH/yWFmlXrf5c1aPwPKX1g==
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
Subject: [PATCH batadv 3/5] batman-adv: remove BATADV_IF_NOT_IN_USE hardif
 state
Date: Mon, 19 May 2025 22:46:30 +0200
Message-ID: 
 <18929b62aafd4ce02940bea02b7a2bf6c5661089.1747687504.git.mschiffer@universe-factory.net>
In-Reply-To: 
 <0b26554afea5203820faef1dfb498af7533a9b5d.1747687504.git.mschiffer@universe-factory.net>
References: 
 <0b26554afea5203820faef1dfb498af7533a9b5d.1747687504.git.mschiffer@universe-factory.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: -----
Message-ID-Hash: TXTC46EQ6MEXAGCLBQCJWADFBJVRX72W
X-Message-ID-Hash: TXTC46EQ6MEXAGCLBQCJWADFBJVRX72W
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/TXTC46EQ6MEXAGCLBQCJWADFBJVRX72W/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

With hardifs only existing while an interface is part of a mesh, the
BATADV_IF_NOT_IN_USE state has become redundant.

Signed-off-by: Matthias Schiffer <mschiffer@universe-factory.net>
---
 net/batman-adv/bat_iv_ogm.c     | 3 +--
 net/batman-adv/bat_v_elp.c      | 3 +--
 net/batman-adv/hard-interface.c | 9 ---------
 net/batman-adv/hard-interface.h | 6 ------
 net/batman-adv/originator.c     | 4 ----
 5 files changed, 2 insertions(+), 23 deletions(-)

diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index 54fe38b3b2fd..c09ca4a896cc 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -866,8 +866,7 @@ static void batadv_iv_ogm_schedule_buff(struct batadv_hard_iface *hard_iface)
 
 static void batadv_iv_ogm_schedule(struct batadv_hard_iface *hard_iface)
 {
-	if (hard_iface->if_status == BATADV_IF_NOT_IN_USE ||
-	    hard_iface->if_status == BATADV_IF_TO_BE_REMOVED)
+	if (hard_iface->if_status == BATADV_IF_TO_BE_REMOVED)
 		return;
 
 	mutex_lock(&hard_iface->bat_iv.ogm_buff_mutex);
diff --git a/net/batman-adv/bat_v_elp.c b/net/batman-adv/bat_v_elp.c
index 42ec62387ce1..7c914bfac340 100644
--- a/net/batman-adv/bat_v_elp.c
+++ b/net/batman-adv/bat_v_elp.c
@@ -301,8 +301,7 @@ static void batadv_v_elp_periodic_work(struct work_struct *work)
 		goto out;
 
 	/* we are in the process of shutting this interface down */
-	if (hard_iface->if_status == BATADV_IF_NOT_IN_USE ||
-	    hard_iface->if_status == BATADV_IF_TO_BE_REMOVED)
+	if (hard_iface->if_status == BATADV_IF_TO_BE_REMOVED)
 		goto out;
 
 	/* the interface was enabled but may not be ready yet */
diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index 7e8c08fbd049..89e0e11250ca 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -517,9 +517,6 @@ static void batadv_check_known_mac_addr(const struct batadv_hard_iface *hard_ifa
 		if (tmp_hard_iface == hard_iface)
 			continue;
 
-		if (tmp_hard_iface->if_status == BATADV_IF_NOT_IN_USE)
-			continue;
-
 		if (!batadv_compare_eth(tmp_hard_iface->net_dev->dev_addr,
 					hard_iface->net_dev->dev_addr))
 			continue;
@@ -545,9 +542,6 @@ static void batadv_hardif_recalc_extra_skbroom(struct net_device *mesh_iface)
 
 	rcu_read_lock();
 	netdev_for_each_lower_private_rcu(mesh_iface, hard_iface, iter) {
-		if (hard_iface->if_status == BATADV_IF_NOT_IN_USE)
-			continue;
-
 		lower_header_len = max_t(unsigned short, lower_header_len,
 					 hard_iface->net_dev->hard_header_len);
 
@@ -950,9 +944,6 @@ static int batadv_hard_if_event(struct notifier_block *this,
 			batadv_update_min_mtu(hard_iface->mesh_iface);
 		break;
 	case NETDEV_CHANGEADDR:
-		if (hard_iface->if_status == BATADV_IF_NOT_IN_USE)
-			goto hardif_put;
-
 		batadv_check_known_mac_addr(hard_iface);
 
 		bat_priv = netdev_priv(hard_iface->mesh_iface);
diff --git a/net/batman-adv/hard-interface.h b/net/batman-adv/hard-interface.h
index ebde3d5077a4..ace7a0f6f3b6 100644
--- a/net/batman-adv/hard-interface.h
+++ b/net/batman-adv/hard-interface.h
@@ -21,12 +21,6 @@
  * enum batadv_hard_if_state - State of a hard interface
  */
 enum batadv_hard_if_state {
-	/**
-	 * @BATADV_IF_NOT_IN_USE: interface is not used as slave interface of a
-	 * batman-adv mesh interface
-	 */
-	BATADV_IF_NOT_IN_USE,
-
 	/**
 	 * @BATADV_IF_TO_BE_REMOVED: interface will be removed from mesh
 	 * interface
diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
index 2726f2905f3c..2e5ea70acbd9 100644
--- a/net/batman-adv/originator.c
+++ b/net/batman-adv/originator.c
@@ -1033,7 +1033,6 @@ batadv_purge_neigh_ifinfo(struct batadv_priv *bat_priv,
 
 		/* don't purge if the interface is not (going) down */
 		if (if_outgoing->if_status != BATADV_IF_INACTIVE &&
-		    if_outgoing->if_status != BATADV_IF_NOT_IN_USE &&
 		    if_outgoing->if_status != BATADV_IF_TO_BE_REMOVED)
 			continue;
 
@@ -1077,7 +1076,6 @@ batadv_purge_orig_ifinfo(struct batadv_priv *bat_priv,
 
 		/* don't purge if the interface is not (going) down */
 		if (if_outgoing->if_status != BATADV_IF_INACTIVE &&
-		    if_outgoing->if_status != BATADV_IF_NOT_IN_USE &&
 		    if_outgoing->if_status != BATADV_IF_TO_BE_REMOVED)
 			continue;
 
@@ -1127,10 +1125,8 @@ batadv_purge_orig_neighbors(struct batadv_priv *bat_priv,
 
 		if (batadv_has_timed_out(last_seen, BATADV_PURGE_TIMEOUT) ||
 		    if_incoming->if_status == BATADV_IF_INACTIVE ||
-		    if_incoming->if_status == BATADV_IF_NOT_IN_USE ||
 		    if_incoming->if_status == BATADV_IF_TO_BE_REMOVED) {
 			if (if_incoming->if_status == BATADV_IF_INACTIVE ||
-			    if_incoming->if_status == BATADV_IF_NOT_IN_USE ||
 			    if_incoming->if_status == BATADV_IF_TO_BE_REMOVED)
 				batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
 					   "neighbor purge: originator %pM, neighbor: %pM, iface: %s\n",
-- 
2.49.0

