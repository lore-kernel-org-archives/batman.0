Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 740F5C43458
	for <batman-adv@archiver.kernel.org>; Sun, 28 Jun 2026 15:11:39 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id B477484077
	for <batman-adv@archiver.kernel.org>; Sun, 28 Jun 2026 17:11:37 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1782659497;
 b=3hZB2nBHTPbxnz3w2g9zcL/J8WAeb+YpGU3aq8dZdfCnt48tGwWPqHKJ29r7jpXRMchBm
 PASFJfgpjydHwyqsGVaqtpR2wUBqULqCEESnZ+sHduZ+MHKr6Oh2Q3xfJm4hpzUSRDSeUkW
 S6haIzI93HCJSh0kG7cLIGVWXKHtgeg=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1782659497; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=5/I+xGCdPClbJ4r8YkUvMBXqSDs4BTT3QNmUy3wyLqU=;
 b=cMhbvYByjeQhHHt31s6BYlSwhktQ+mHGj+Z5bgCL3nvQ/dwV0b6zWMTK/+JtLDckQ3cvB
 rKs7tQXW3fcdNShwOsYfoTXMfk0RPWdv1KCdge/vwVmXGa2x+cwlqEk5hD2unh086YTnMza
 Vl8Th/ZVa4cQc4oUn8zgEcR34B7sjik=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=universe-factory.net;
 arc=pass;
 dmarc=none
Authentication-Results: open-mesh.org;
 dkim=pass header.d=universe-factory.net; arc=pass; dmarc=none
Received: from mail.universe-factory.net (osgiliath.universe-factory.net
 [141.95.161.142])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 39FB38051A
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 28 Jun 2026 17:08:07 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1782659287;
	b=lRt7UAFWsDn+FWdXAVGicGM91qV7ugDvh4duR4MDsiCiN7z3lmQshkaKGCVirLkbQ0vc9h
	gLRQHY5k0yY5LBxNEqcTGnfzseb3/f92wqIF3LF4Bfm0TYEluQXm9ZqL2PxYd45hTKkFP6
	cPCDtKkZHDZG3QtD0wIr6CK5GBRHGdY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1782659287;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=5/I+xGCdPClbJ4r8YkUvMBXqSDs4BTT3QNmUy3wyLqU=;
	b=mq7pSzuksCTsruzkyCCWYIRjOGdVeFFgu/9Uf4tB0DDa/9IgkH/ha/wP2NvbS7HR+9w+QN
	FSiusAnzPYwdlo+5sZ3CldACznL8/rN2gnbH56RhQYYQ0ZhYiRTvSJr3z89AzVBRkzh1qT
	hps+jPKU7HK5qPWPtYvM2rJ/jfS+iUs=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=universe-factory.net header.s=dkim header.b="Xzk1uJ/E";
	spf=pass (diktynna.open-mesh.org: domain of neocturne@universe-factory.net
 designates 141.95.161.142 as permitted sender)
 smtp.mailfrom=neocturne@universe-factory.net;
	dmarc=pass (policy=reject) header.from=universe-factory.net
From: Nora Schiffer <neocturne@universe-factory.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=universe-factory.net;
	s=dkim; t=1782659286;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5/I+xGCdPClbJ4r8YkUvMBXqSDs4BTT3QNmUy3wyLqU=;
	b=Xzk1uJ/ErfUheeVOChQCO5EdK/r25WGim+MGBcwzcAinfLxfkBU6k/hjHATQhmy/6YZ2LE
	Seaf0vwO2iynaaiP5lf6tTdTw5I9lFQVUWyxm6lKHqp7bOdUI0nBHnW385STowHEIYiyV2
	13sIZScFLWrTQ2t1hQKcATdPiYHGvi0mUVjowCBY8tvCyHorgm8R57xi4QGTXaOsp83BX2
	RQa8l0PR6Lppm5IgzcPlCnU1rMg7VteeAtaOK2xpzrpnsTwNqDI6o2SOTY1korjnITm1bl
	pFLC1/A8xM5DncbeYx3LA7M2DbESdFq3x6tqDZaZWR/HOBViQQUgAVxm5vH+HA==
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: sven@narfation.org,
	Nora Schiffer <neocturne@universe-factory.net>
Subject: [PATCH batadv v5 4/6] batman-adv: remove BATADV_IF_NOT_IN_USE hardif
 state
Date: Sun, 28 Jun 2026 17:07:31 +0200
Message-ID: 
 <37b87dd9d258a49092d9f0e970cf805fe08c3200.1782658366.git.neocturne@universe-factory.net>
In-Reply-To: <cover.1782658366.git.neocturne@universe-factory.net>
References: <cover.1782658366.git.neocturne@universe-factory.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: -----
X-MailFrom: neocturne@universe-factory.net
X-Mailman-Rule-Hits: member-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-3; emergency
Message-ID-Hash: 34ZAWYSXTYD36RBDHBXJISQYZ3G6NYKS
X-Message-ID-Hash: 34ZAWYSXTYD36RBDHBXJISQYZ3G6NYKS
X-Mailman-Approved-At: Sun, 28 Jun 2026 17:11:17 +0200
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/34ZAWYSXTYD36RBDHBXJISQYZ3G6NYKS/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

With hardifs only existing while an interface is part of a mesh, the
BATADV_IF_NOT_IN_USE state has become redundant.

Signed-off-by: Nora Schiffer <neocturne@universe-factory.net>
---

v2-v5: no changes


 net/batman-adv/bat_iv_ogm.c     | 3 +--
 net/batman-adv/bat_v_elp.c      | 3 +--
 net/batman-adv/hard-interface.c | 9 ---------
 net/batman-adv/hard-interface.h | 6 ------
 net/batman-adv/originator.c     | 4 ----
 5 files changed, 2 insertions(+), 23 deletions(-)

diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index bb2f012b454e..4514c51bba77 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -910,8 +910,7 @@ static void batadv_iv_ogm_schedule_buff(struct batadv_hard_iface *hard_iface)
 
 static void batadv_iv_ogm_schedule(struct batadv_hard_iface *hard_iface)
 {
-	if (hard_iface->if_status == BATADV_IF_NOT_IN_USE ||
-	    hard_iface->if_status == BATADV_IF_TO_BE_REMOVED)
+	if (hard_iface->if_status == BATADV_IF_TO_BE_REMOVED)
 		return;
 
 	mutex_lock(&hard_iface->bat_iv.ogm_buff_mutex);
diff --git a/net/batman-adv/bat_v_elp.c b/net/batman-adv/bat_v_elp.c
index 4841f0f1a9b1..bc3e4f264afa 100644
--- a/net/batman-adv/bat_v_elp.c
+++ b/net/batman-adv/bat_v_elp.c
@@ -311,8 +311,7 @@ static void batadv_v_elp_periodic_work(struct work_struct *work)
 		goto out;
 
 	/* we are in the process of shutting this interface down */
-	if (hard_iface->if_status == BATADV_IF_NOT_IN_USE ||
-	    hard_iface->if_status == BATADV_IF_TO_BE_REMOVED)
+	if (hard_iface->if_status == BATADV_IF_TO_BE_REMOVED)
 		goto out;
 
 	/* the interface was enabled but may not be ready yet */
diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index a0b8b06f9a64..86010bc32818 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -547,9 +547,6 @@ static void batadv_check_known_mac_addr(const struct batadv_hard_iface *hard_ifa
 		if (tmp_hard_iface == hard_iface)
 			continue;
 
-		if (tmp_hard_iface->if_status == BATADV_IF_NOT_IN_USE)
-			continue;
-
 		if (!batadv_compare_eth(tmp_hard_iface->net_dev->dev_addr,
 					hard_iface->net_dev->dev_addr))
 			continue;
@@ -575,9 +572,6 @@ static void batadv_hardif_recalc_extra_skbroom(struct net_device *mesh_iface)
 
 	rcu_read_lock();
 	netdev_for_each_lower_private_rcu(mesh_iface, hard_iface, iter) {
-		if (hard_iface->if_status == BATADV_IF_NOT_IN_USE)
-			continue;
-
 		lower_header_len = max_t(unsigned short, lower_header_len,
 					 hard_iface->net_dev->hard_header_len);
 
@@ -1065,9 +1059,6 @@ static int batadv_hard_if_event(struct notifier_block *this,
 			batadv_update_min_mtu(hard_iface->mesh_iface);
 		break;
 	case NETDEV_CHANGEADDR:
-		if (hard_iface->if_status == BATADV_IF_NOT_IN_USE)
-			goto hardif_put;
-
 		batadv_check_known_mac_addr(hard_iface);
 
 		bat_priv = netdev_priv(hard_iface->mesh_iface);
diff --git a/net/batman-adv/hard-interface.h b/net/batman-adv/hard-interface.h
index aa9275dec097..935f47ca9a48 100644
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
index 9b38bd9e8da7..48f837cf665a 100644
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
2.54.0

