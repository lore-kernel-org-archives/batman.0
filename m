Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44752CD4F21
	for <batman@archiver.kernel.org>; Tue, 12 May 2026 19:57:05 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id AB10F85BF6
	for <batman@archiver.kernel.org>; Tue, 12 May 2026 21:57:03 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1778615823;
 b=x57/ZSp61e74NSSianizLf6x79kESRRr/hGJ0sqs2Gyzo7xmB+9v3WL2zrZTyu4RGGNXM
 KsVjXDyWOO/hGKwLlbiLAfB8sOdzv8+YGLyVDkjnaAru1sQFNRW4Fg4KdSYKFwADDf2/xGZ
 fwAImbSDR99vqDyOVYumCOLGZH7lu84=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1778615823; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=3sn7SAiiZ0qmk05VuOCms2HyAPtG1xWxDuu+sz0QAuw=;
 b=mHPi+rAb/Y/sG5obKAVPfhRSBkBMCMd+Yg0p3wQX/Ydv4bLkaWmqUsgZTwqt0XrUjKRq2
 ELHy6gTv6FnZ7HxLC+Y+jHm3ga0IoTfae2NQp3XzvGS9Dji4USOIo98Cpyhr3l/E7+8N48C
 aons5doHpy/8y4tet/Zd+kDCR3Cd0uU=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 5B9D5859C5
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 12 May 2026 21:53:39 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1778615619;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=3sn7SAiiZ0qmk05VuOCms2HyAPtG1xWxDuu+sz0QAuw=;
	b=Njbw/SQCa3U+xYUbQSZeRZTJgTxYzRgWvQUgCloiO7E5bwF2XlphFG5guLThvKtD86m0b9
	5Q7ZkG5VG7SNDflAdndvuNPL4yIM+m5+WZLR3UUpNQ0iYVow2PfcHgt7bxEb3dz1qw62sD
	k4ab+MmOeImbiN6em1xUB+AsepuxBos=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=RvVRKxjX;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1778615619;
	b=JfhKnC9tFZJB0zBEq430L/pzWqVpBY2fx9wsB/ljPI6tlyYjnA1C6nQQIpy88wIr6q/mSo
	Z1/d+oNit9AMTN3mCM3fuuNKAg6/veI+x/+g1R1OAIVSWiToyH8ogkZM+vcqaNTY8d7qYu
	ae4h65txVsB0kgqvpEnK8xnzUUQOGmk=
Received: by dvalin.narfation.org (Postfix) id 1CA951FE70;
	Tue, 12 May 2026 19:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1778615619;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3sn7SAiiZ0qmk05VuOCms2HyAPtG1xWxDuu+sz0QAuw=;
	b=RvVRKxjX/+ZQ8TDuKTK/0H8w0LpjddBq5rRrW+9TmD66ZQVJwZsRlAm4VGiL89qbUnYuTr
	pFxgmJknSEBGnUgWUIGYNFkTurVNQf6ZN+7Vk8APDpWCM8DfXNuZ6dOc0ORp/n/v+64fQo
	LcqguSk4tfZSEy/Gk1LAh6pVO/FlhaQ=
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 12 May 2026 21:53:09 +0200
Subject: [PATCH batadv 4/7] batman-adv: replace non-atomic mesh state with
 (READ|WRITE)_ONCE
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-atomic-to-write-once-v1-4-76a4272fac0d@narfation.org>
References: <20260512-atomic-to-write-once-v1-0-76a4272fac0d@narfation.org>
In-Reply-To: <20260512-atomic-to-write-once-v1-0-76a4272fac0d@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=8961; i=sven@narfation.org;
 h=from:subject:message-id; bh=UtNxilqLcdFTWjWf5HDfOi6sCPNG/S6Vgy6uE7lmkL8=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFnMrcoHNisdirjy7NNBab8nm3f+/dx1evPKs81b9KP3F
 c1VYTIW6ihlYRDjYpAVU2TZcyX//Gb2t/Kfp308CjOHlQlkCAMXpwBMxF+EkeEO2+og4dtJZf4T
 HGfd2lTTqsO1M+vum7Rc6+THf4Oi2QwZGeYufBaxT2j948dP+SzVT+3sck2wWcHc9qyuRNpl6o4
 VkbwA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: 67HLG33WKXPM2DOTGA6COMAMV7V45NI5
X-Message-ID-Hash: 67HLG33WKXPM2DOTGA6COMAMV7V45NI5
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/67HLG33WKXPM2DOTGA6COMAMV7V45NI5/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

The mesh state is only accessed as plain loads/stores and does not require
full atomic_t semantics. Convert to an enum and replace its users with
READ_ONCE()/WRITE_ONCE() to avoid load/store tearing.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/bat_iv_ogm.c     |  2 +-
 net/batman-adv/bat_v_elp.c      |  2 +-
 net/batman-adv/bat_v_ogm.c      |  2 +-
 net/batman-adv/main.c           | 20 ++++++++++----------
 net/batman-adv/mesh-interface.c |  6 +++---
 net/batman-adv/send.c           |  2 +-
 net/batman-adv/tp_meter.c       |  6 +++---
 net/batman-adv/types.h          |  2 +-
 8 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index c7751e0a..abd752db 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -1731,7 +1731,7 @@ static void batadv_iv_send_outstanding_bat_ogm_packet(struct work_struct *work)
 				   delayed_work);
 	bat_priv = netdev_priv(forw_packet->if_incoming->mesh_iface);
 
-	if (atomic_read(&bat_priv->mesh_state) == BATADV_MESH_DEACTIVATING) {
+	if (READ_ONCE(bat_priv->mesh_state) == BATADV_MESH_DEACTIVATING) {
 		dropped = true;
 		goto out;
 	}
diff --git a/net/batman-adv/bat_v_elp.c b/net/batman-adv/bat_v_elp.c
index 075a58dd..a94e31a7 100644
--- a/net/batman-adv/bat_v_elp.c
+++ b/net/batman-adv/bat_v_elp.c
@@ -305,7 +305,7 @@ static void batadv_v_elp_periodic_work(struct work_struct *work)
 	hard_iface = container_of(bat_v, struct batadv_hard_iface, bat_v);
 	bat_priv = netdev_priv(hard_iface->mesh_iface);
 
-	if (atomic_read(&bat_priv->mesh_state) == BATADV_MESH_DEACTIVATING)
+	if (READ_ONCE(bat_priv->mesh_state) == BATADV_MESH_DEACTIVATING)
 		goto out;
 
 	/* we are in the process of shutting this interface down */
diff --git a/net/batman-adv/bat_v_ogm.c b/net/batman-adv/bat_v_ogm.c
index 1326a166..e1982602 100644
--- a/net/batman-adv/bat_v_ogm.c
+++ b/net/batman-adv/bat_v_ogm.c
@@ -272,7 +272,7 @@ static void batadv_v_ogm_send_meshif(struct batadv_priv *bat_priv)
 
 	lockdep_assert_held(&bat_priv->bat_v.ogm_buff_mutex);
 
-	if (atomic_read(&bat_priv->mesh_state) == BATADV_MESH_DEACTIVATING)
+	if (READ_ONCE(bat_priv->mesh_state) == BATADV_MESH_DEACTIVATING)
 		goto out;
 
 	ogm_buff = bat_priv->bat_v.ogm_buff;
diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index 4ee2b14d..4d83577f 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -187,31 +187,31 @@ int batadv_mesh_init(struct net_device *mesh_iface)
 
 	ret = batadv_originator_init(bat_priv);
 	if (ret < 0) {
-		atomic_set(&bat_priv->mesh_state, BATADV_MESH_DEACTIVATING);
+		WRITE_ONCE(bat_priv->mesh_state, BATADV_MESH_DEACTIVATING);
 		goto err_orig;
 	}
 
 	ret = batadv_tt_init(bat_priv);
 	if (ret < 0) {
-		atomic_set(&bat_priv->mesh_state, BATADV_MESH_DEACTIVATING);
+		WRITE_ONCE(bat_priv->mesh_state, BATADV_MESH_DEACTIVATING);
 		goto err_tt;
 	}
 
 	ret = batadv_v_mesh_init(bat_priv);
 	if (ret < 0) {
-		atomic_set(&bat_priv->mesh_state, BATADV_MESH_DEACTIVATING);
+		WRITE_ONCE(bat_priv->mesh_state, BATADV_MESH_DEACTIVATING);
 		goto err_v;
 	}
 
 	ret = batadv_bla_init(bat_priv);
 	if (ret < 0) {
-		atomic_set(&bat_priv->mesh_state, BATADV_MESH_DEACTIVATING);
+		WRITE_ONCE(bat_priv->mesh_state, BATADV_MESH_DEACTIVATING);
 		goto err_bla;
 	}
 
 	ret = batadv_dat_init(bat_priv);
 	if (ret < 0) {
-		atomic_set(&bat_priv->mesh_state, BATADV_MESH_DEACTIVATING);
+		WRITE_ONCE(bat_priv->mesh_state, BATADV_MESH_DEACTIVATING);
 		goto err_dat;
 	}
 
@@ -219,7 +219,7 @@ int batadv_mesh_init(struct net_device *mesh_iface)
 	batadv_mcast_init(bat_priv);
 
 	atomic_set(&bat_priv->gw.reselect, 0);
-	atomic_set(&bat_priv->mesh_state, BATADV_MESH_ACTIVE);
+	WRITE_ONCE(bat_priv->mesh_state, BATADV_MESH_ACTIVE);
 
 	return 0;
 
@@ -233,7 +233,7 @@ int batadv_mesh_init(struct net_device *mesh_iface)
 	batadv_originator_free(bat_priv);
 err_orig:
 	batadv_purge_outstanding_packets(bat_priv, NULL);
-	atomic_set(&bat_priv->mesh_state, BATADV_MESH_INACTIVE);
+	WRITE_ONCE(bat_priv->mesh_state, BATADV_MESH_INACTIVE);
 
 	return ret;
 }
@@ -246,7 +246,7 @@ void batadv_mesh_free(struct net_device *mesh_iface)
 {
 	struct batadv_priv *bat_priv = netdev_priv(mesh_iface);
 
-	atomic_set(&bat_priv->mesh_state, BATADV_MESH_DEACTIVATING);
+	WRITE_ONCE(bat_priv->mesh_state, BATADV_MESH_DEACTIVATING);
 
 	batadv_purge_outstanding_packets(bat_priv, NULL);
 	batadv_tp_stop_all(bat_priv);
@@ -277,7 +277,7 @@ void batadv_mesh_free(struct net_device *mesh_iface)
 	free_percpu(bat_priv->bat_counters);
 	bat_priv->bat_counters = NULL;
 
-	atomic_set(&bat_priv->mesh_state, BATADV_MESH_INACTIVE);
+	WRITE_ONCE(bat_priv->mesh_state, BATADV_MESH_INACTIVE);
 }
 
 /**
@@ -441,7 +441,7 @@ int batadv_batman_skb_recv(struct sk_buff *skb, struct net_device *dev,
 
 	bat_priv = netdev_priv(hard_iface->mesh_iface);
 
-	if (atomic_read(&bat_priv->mesh_state) != BATADV_MESH_ACTIVE)
+	if (READ_ONCE(bat_priv->mesh_state) != BATADV_MESH_ACTIVE)
 		goto err_free;
 
 	/* discard frames on not active interfaces */
diff --git a/net/batman-adv/mesh-interface.c b/net/batman-adv/mesh-interface.c
index 0e63fad0..9c53552a 100644
--- a/net/batman-adv/mesh-interface.c
+++ b/net/batman-adv/mesh-interface.c
@@ -123,7 +123,7 @@ static int batadv_interface_set_mac_addr(struct net_device *dev, void *p)
 	eth_hw_addr_set(dev, addr->sa_data);
 
 	/* only modify transtable if it has been initialized before */
-	if (atomic_read(&bat_priv->mesh_state) != BATADV_MESH_ACTIVE)
+	if (READ_ONCE(bat_priv->mesh_state) != BATADV_MESH_ACTIVE)
 		return 0;
 
 	rcu_read_lock();
@@ -190,7 +190,7 @@ static netdev_tx_t batadv_interface_tx(struct sk_buff *skb,
 	int network_offset = ETH_HLEN;
 	__be16 proto;
 
-	if (atomic_read(&bat_priv->mesh_state) != BATADV_MESH_ACTIVE)
+	if (READ_ONCE(bat_priv->mesh_state) != BATADV_MESH_ACTIVE)
 		goto dropped;
 
 	/* reset control block to avoid left overs from previous users */
@@ -781,7 +781,7 @@ static int batadv_meshif_init_late(struct net_device *dev)
 	atomic_set(&bat_priv->bcast_queue_left, BATADV_BCAST_QUEUE_LEN);
 	atomic_set(&bat_priv->batman_queue_left, BATADV_BATMAN_QUEUE_LEN);
 
-	atomic_set(&bat_priv->mesh_state, BATADV_MESH_INACTIVE);
+	WRITE_ONCE(bat_priv->mesh_state, BATADV_MESH_INACTIVE);
 	atomic_set(&bat_priv->bcast_seqno, 1);
 	atomic_set(&bat_priv->tt.vn, 0);
 	atomic_set(&bat_priv->tt.ogm_append_cnt, 0);
diff --git a/net/batman-adv/send.c b/net/batman-adv/send.c
index 62ae98ee..c7e86c83 100644
--- a/net/batman-adv/send.c
+++ b/net/batman-adv/send.c
@@ -1047,7 +1047,7 @@ static void batadv_send_outstanding_bcast_packet(struct work_struct *work)
 				   delayed_work);
 	bat_priv = netdev_priv(forw_packet->if_incoming->mesh_iface);
 
-	if (atomic_read(&bat_priv->mesh_state) == BATADV_MESH_DEACTIVATING) {
+	if (READ_ONCE(bat_priv->mesh_state) == BATADV_MESH_DEACTIVATING) {
 		dropped = true;
 		goto out;
 	}
diff --git a/net/batman-adv/tp_meter.c b/net/batman-adv/tp_meter.c
index ca6c3f63..52dd848f 100644
--- a/net/batman-adv/tp_meter.c
+++ b/net/batman-adv/tp_meter.c
@@ -966,7 +966,7 @@ void batadv_tp_start(struct batadv_priv *bat_priv, const u8 *dst,
 
 	/* look for an already existing test towards this node */
 	spin_lock_bh(&bat_priv->tp_list_lock);
-	if (atomic_read(&bat_priv->mesh_state) != BATADV_MESH_ACTIVE) {
+	if (READ_ONCE(bat_priv->mesh_state) != BATADV_MESH_ACTIVE) {
 		spin_unlock_bh(&bat_priv->tp_list_lock);
 		batadv_tp_batctl_error_notify(BATADV_TP_REASON_DST_UNREACHABLE,
 					      dst, bat_priv, session_cookie);
@@ -1356,7 +1356,7 @@ batadv_tp_init_recv(struct batadv_priv *bat_priv,
 	struct batadv_tp_vars *tp_vars = NULL;
 
 	spin_lock_bh(&bat_priv->tp_list_lock);
-	if (atomic_read(&bat_priv->mesh_state) != BATADV_MESH_ACTIVE)
+	if (READ_ONCE(bat_priv->mesh_state) != BATADV_MESH_ACTIVE)
 		goto out_unlock;
 
 	tp_vars = batadv_tp_list_find_session(bat_priv, icmp->orig,
@@ -1494,7 +1494,7 @@ void batadv_tp_meter_recv(struct batadv_priv *bat_priv, struct sk_buff *skb)
 {
 	struct batadv_icmp_tp_packet *icmp;
 
-	if (atomic_read(&bat_priv->mesh_state) != BATADV_MESH_ACTIVE)
+	if (READ_ONCE(bat_priv->mesh_state) != BATADV_MESH_ACTIVE)
 		goto out;
 
 	icmp = (struct batadv_icmp_tp_packet *)skb->data;
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index d4437dd7..fcf879ce 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -1477,7 +1477,7 @@ struct batadv_priv {
 	 * @mesh_state: current status of the mesh
 	 *  (inactive/active/deactivating)
 	 */
-	atomic_t mesh_state;
+	enum batadv_mesh_state mesh_state;
 
 	/** @mesh_iface: net device which holds this struct as private data */
 	struct net_device *mesh_iface;

-- 
2.47.3

