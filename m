Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10AFCCD5BD1
	for <batman-adv@archiver.kernel.org>; Mon,  1 Jun 2026 12:45:14 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id A9E0B84590
	for <batman-adv@archiver.kernel.org>; Mon, 01 Jun 2026 14:45:12 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1780317912;
 b=fC7+HobzfvOFqY8CYdQEoRwbOxy219l6uyGHL7M7psqoz8019Yzmos/yizHbqCKfXJv6a
 a0x/NdZJVvWn5LDyEXpGi9EJsBIwYdsSi567TfFWsX/JhT3O9zbzXwizQxbIfHyZSeFPZVC
 ADAnGz61mCja4pAeiztDjt54YYgB+is=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1780317912; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=Z9+WB8YF39qEgw1TjmumqQ3RHGa+ipeDa6dcaa8I518=;
 b=fi2QKB2r5wn8/uXR1ohtbJAwuPdIGbnLpaDAz6gNF5xoNZ128sPlvFBoDzRMZK5FFKHBO
 RDu1asdEgfDI/gHm7lV0LltA/FgW1H5upC81giE00YC+2myS4CM2VYPA0l7jorHTpP07Ddm
 +KvjSt/HyAae9bSBf+mp+D9bP2sBBjY=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de
 [IPv6:2a01:4f8:c17:e8c0::1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 0AA36806D6
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 01 Jun 2026 14:36:52 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1780317412;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=Z9+WB8YF39qEgw1TjmumqQ3RHGa+ipeDa6dcaa8I518=;
	b=04I68Ptxslu6jqCdkx3eiaR0qVLinuBN8XPBLlxupvZ2XXZFsu2imU6vy9BW7AB4mSNNG2
	ikEMtNP2Ke2Q0hlg0YY23Xl/lPeu7iifhy5b12Co9AZLjfyqqQdThFlNZVwVQzHAiVTs0+
	fVh8kyJFxoVGMDwhIuVlLArwmMeYz3E=
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1780317412;
	b=H9VLslRQvRTQh+k1pECkzUwRJ8r9553GtLv5/RHZtHsj6HpJas98L5prB6coHCcX65QwB2
	TYWUOHoGVdZEpRxm/L29fIApqHLUyJTIN1kuryC19FgR3A05+u/PM7xDPDjEYyrW+esaK0
	f1uAlGYgoB0Gw9VoXPg4grNrWzd/0m4=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=0oLQ6s6g;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 2a01:4f8:c17:e8c0::1 as permitted sender)
 smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1780317411;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z9+WB8YF39qEgw1TjmumqQ3RHGa+ipeDa6dcaa8I518=;
	b=0oLQ6s6gcvYuNLOS6kNbLQ92IjGStv/WkmvVbn9BvYNa0a5FCUGpaesmHqWs1hPgTniylj
	65CSPWEcNAqayAVpZ4Kzs4DoATultyGqWKF1oZR5+58dxEAUcaUm1vstKGW6wcVYLtVNh4
	Odw7ER2Fm5bIhHPaKbM27j9MX5wQnyLIYqbw1xsCOyApsSjIbYyA1nzDR/m8tcWnkNrMom
	fIaB6p2nImwla+K4w3Q2QZVS+sl/ry3lYgIXitYKVDgrh+t4mkaqfMQB4khLWEVIrm3uTq
	xGea/Vg+0x4HNMaF0QLNW2TSXAwSGGJ4Lr0zOR8eFE81HNzDMpeaToGB/8Syog==
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
Subject: [PATCH net-next 10/15] batman-adv: replace non-atomic mesh state with
 (READ|WRITE)_ONCE
Date: Mon,  1 Jun 2026 14:36:24 +0200
Message-ID: <20260601123629.707089-11-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260601123629.707089-1-sw@simonwunderlich.de>
References: <20260601123629.707089-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: KVZKNXYD3OVCKHSSEKCA3EYROIKUWQI5
X-Message-ID-Hash: KVZKNXYD3OVCKHSSEKCA3EYROIKUWQI5
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/KVZKNXYD3OVCKHSSEKCA3EYROIKUWQI5/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Sven Eckelmann <sven@narfation.org>

The mesh state is only accessed as plain loads/stores and does not require
full atomic_t semantics. Convert to an enum and replace its users with
READ_ONCE()/WRITE_ONCE() to avoid load/store tearing.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
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
index df8e64588e1e7..c436b77674a56 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -1777,7 +1777,7 @@ static void batadv_iv_send_outstanding_bat_ogm_packet(struct work_struct *work)
 				   delayed_work);
 	bat_priv = netdev_priv(forw_packet->if_incoming->mesh_iface);
 
-	if (atomic_read(&bat_priv->mesh_state) == BATADV_MESH_DEACTIVATING) {
+	if (READ_ONCE(bat_priv->mesh_state) == BATADV_MESH_DEACTIVATING) {
 		dropped = true;
 		goto out;
 	}
diff --git a/net/batman-adv/bat_v_elp.c b/net/batman-adv/bat_v_elp.c
index 0190fafcbed2d..d53485d17220e 100644
--- a/net/batman-adv/bat_v_elp.c
+++ b/net/batman-adv/bat_v_elp.c
@@ -307,7 +307,7 @@ static void batadv_v_elp_periodic_work(struct work_struct *work)
 	hard_iface = container_of(bat_v, struct batadv_hard_iface, bat_v);
 	bat_priv = netdev_priv(hard_iface->mesh_iface);
 
-	if (atomic_read(&bat_priv->mesh_state) == BATADV_MESH_DEACTIVATING)
+	if (READ_ONCE(bat_priv->mesh_state) == BATADV_MESH_DEACTIVATING)
 		goto out;
 
 	/* we are in the process of shutting this interface down */
diff --git a/net/batman-adv/bat_v_ogm.c b/net/batman-adv/bat_v_ogm.c
index f4cd8cad97e0c..b337bd8e58e7d 100644
--- a/net/batman-adv/bat_v_ogm.c
+++ b/net/batman-adv/bat_v_ogm.c
@@ -279,7 +279,7 @@ static void batadv_v_ogm_send_meshif(struct batadv_priv *bat_priv)
 
 	lockdep_assert_held(&bat_priv->bat_v.ogm_buff_mutex);
 
-	if (atomic_read(&bat_priv->mesh_state) == BATADV_MESH_DEACTIVATING)
+	if (READ_ONCE(bat_priv->mesh_state) == BATADV_MESH_DEACTIVATING)
 		goto out;
 
 	ogm_buff = &bat_priv->bat_v.ogm_buff;
diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index a5398c5df2632..60d4f60066c80 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -200,31 +200,31 @@ int batadv_mesh_init(struct net_device *mesh_iface)
 
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
 
@@ -232,7 +232,7 @@ int batadv_mesh_init(struct net_device *mesh_iface)
 	batadv_mcast_init(bat_priv);
 
 	atomic_set(&bat_priv->gw.reselect, 0);
-	atomic_set(&bat_priv->mesh_state, BATADV_MESH_ACTIVE);
+	WRITE_ONCE(bat_priv->mesh_state, BATADV_MESH_ACTIVE);
 
 	return 0;
 
@@ -246,7 +246,7 @@ int batadv_mesh_init(struct net_device *mesh_iface)
 	batadv_originator_free(bat_priv);
 err_orig:
 	batadv_purge_outstanding_packets(bat_priv, NULL);
-	atomic_set(&bat_priv->mesh_state, BATADV_MESH_INACTIVE);
+	WRITE_ONCE(bat_priv->mesh_state, BATADV_MESH_INACTIVE);
 
 	return ret;
 }
@@ -259,7 +259,7 @@ void batadv_mesh_free(struct net_device *mesh_iface)
 {
 	struct batadv_priv *bat_priv = netdev_priv(mesh_iface);
 
-	atomic_set(&bat_priv->mesh_state, BATADV_MESH_DEACTIVATING);
+	WRITE_ONCE(bat_priv->mesh_state, BATADV_MESH_DEACTIVATING);
 
 	batadv_purge_outstanding_packets(bat_priv, NULL);
 	batadv_tp_stop_all(bat_priv);
@@ -290,7 +290,7 @@ void batadv_mesh_free(struct net_device *mesh_iface)
 	free_percpu(bat_priv->bat_counters);
 	bat_priv->bat_counters = NULL;
 
-	atomic_set(&bat_priv->mesh_state, BATADV_MESH_INACTIVE);
+	WRITE_ONCE(bat_priv->mesh_state, BATADV_MESH_INACTIVE);
 }
 
 /**
@@ -454,7 +454,7 @@ int batadv_batman_skb_recv(struct sk_buff *skb, struct net_device *dev,
 
 	bat_priv = netdev_priv(hard_iface->mesh_iface);
 
-	if (atomic_read(&bat_priv->mesh_state) != BATADV_MESH_ACTIVE)
+	if (READ_ONCE(bat_priv->mesh_state) != BATADV_MESH_ACTIVE)
 		goto err_free;
 
 	/* discard frames on not active interfaces */
diff --git a/net/batman-adv/mesh-interface.c b/net/batman-adv/mesh-interface.c
index 58cbb4f8a5abd..7497f307c10db 100644
--- a/net/batman-adv/mesh-interface.c
+++ b/net/batman-adv/mesh-interface.c
@@ -125,7 +125,7 @@ static int batadv_interface_set_mac_addr(struct net_device *dev, void *p)
 	eth_hw_addr_set(dev, addr->sa_data);
 
 	/* only modify transtable if it has been initialized before */
-	if (atomic_read(&bat_priv->mesh_state) != BATADV_MESH_ACTIVE)
+	if (READ_ONCE(bat_priv->mesh_state) != BATADV_MESH_ACTIVE)
 		return 0;
 
 	rcu_read_lock();
@@ -192,7 +192,7 @@ static netdev_tx_t batadv_interface_tx(struct sk_buff *skb,
 	int network_offset = ETH_HLEN;
 	__be16 proto;
 
-	if (atomic_read(&bat_priv->mesh_state) != BATADV_MESH_ACTIVE)
+	if (READ_ONCE(bat_priv->mesh_state) != BATADV_MESH_ACTIVE)
 		goto dropped;
 
 	/* reset control block to avoid left overs from previous users */
@@ -783,7 +783,7 @@ static int batadv_meshif_init_late(struct net_device *dev)
 	atomic_set(&bat_priv->bcast_queue_left, BATADV_BCAST_QUEUE_LEN);
 	atomic_set(&bat_priv->batman_queue_left, BATADV_BATMAN_QUEUE_LEN);
 
-	atomic_set(&bat_priv->mesh_state, BATADV_MESH_INACTIVE);
+	WRITE_ONCE(bat_priv->mesh_state, BATADV_MESH_INACTIVE);
 	atomic_set(&bat_priv->bcast_seqno, 1);
 	atomic_set(&bat_priv->tt.vn, 0);
 	atomic_set(&bat_priv->tt.ogm_append_cnt, 0);
diff --git a/net/batman-adv/send.c b/net/batman-adv/send.c
index 62ae98eef81e2..c7e86c83242a2 100644
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
index 0fc4ca78e84eb..aefe757277b20 100644
--- a/net/batman-adv/tp_meter.c
+++ b/net/batman-adv/tp_meter.c
@@ -999,7 +999,7 @@ void batadv_tp_start(struct batadv_priv *bat_priv, const u8 *dst,
 
 	/* look for an already existing test towards this node */
 	spin_lock_bh(&bat_priv->tp_list_lock);
-	if (atomic_read(&bat_priv->mesh_state) != BATADV_MESH_ACTIVE) {
+	if (READ_ONCE(bat_priv->mesh_state) != BATADV_MESH_ACTIVE) {
 		spin_unlock_bh(&bat_priv->tp_list_lock);
 		batadv_tp_batctl_error_notify(BATADV_TP_REASON_DST_UNREACHABLE,
 					      dst, bat_priv, session_cookie);
@@ -1387,7 +1387,7 @@ batadv_tp_init_recv(struct batadv_priv *bat_priv,
 	struct batadv_tp_vars *tp_vars = NULL;
 
 	spin_lock_bh(&bat_priv->tp_list_lock);
-	if (atomic_read(&bat_priv->mesh_state) != BATADV_MESH_ACTIVE)
+	if (READ_ONCE(bat_priv->mesh_state) != BATADV_MESH_ACTIVE)
 		goto out_unlock;
 
 	tp_vars = batadv_tp_list_find_session(bat_priv, icmp->orig,
@@ -1518,7 +1518,7 @@ void batadv_tp_meter_recv(struct batadv_priv *bat_priv, struct sk_buff *skb)
 {
 	struct batadv_icmp_tp_packet *icmp;
 
-	if (atomic_read(&bat_priv->mesh_state) != BATADV_MESH_ACTIVE)
+	if (READ_ONCE(bat_priv->mesh_state) != BATADV_MESH_ACTIVE)
 		goto out;
 
 	icmp = (struct batadv_icmp_tp_packet *)skb->data;
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index cf01a670d8250..58375c0a643b8 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -1504,7 +1504,7 @@ struct batadv_priv {
 	 * @mesh_state: current status of the mesh
 	 *  (inactive/active/deactivating)
 	 */
-	atomic_t mesh_state;
+	enum batadv_mesh_state mesh_state;
 
 	/** @mesh_iface: net device which holds this struct as private data */
 	struct net_device *mesh_iface;
-- 
2.47.3

