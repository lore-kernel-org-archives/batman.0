Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC807C021B5
	for <batman-adv@archiver.kernel.org>; Fri, 21 Feb 2025 17:31:10 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 5AB4D8446C
	for <batman-adv@archiver.kernel.org>; Fri, 21 Feb 2025 18:31:09 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1740159069;
 b=Lf7B69IWupwwRvrLGSBDFc+xR9PWAj1zrqBUxCz4MS0i4qCIppaxrltOXrSibzQJGTRtS
 w4bhKe89vXaj2vOh2rMyYXvedEGLKNFbA1imvvWzl4ZfmwBGZj+nTYkuc3fYuXAPAFUwhcF
 aru9AA7TE2nIlts8qx3ri4GOYUTJkfY=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1740159069; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=d8E0KCTJcKpTpIbzYmadCCoweUJ51WRfHfeeRgIaVn8=;
 b=oTRvKPgKaG/ReJpaail7p0efi48aW2V6FvSeLGxbA7McrMu0blUftb/FUcyrTwkcX+lQ+
 NH/0RljENBZD4dBibLhiy0ZA7vYLLaj9IJvzuqLvJxTBs6KWtLc7Rmcv5hhQ4YnGgatA2VU
 vELCbYUEzNB+DqO/P33RSpUAllCfPe4=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=narfation.org
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id A11D083FFC
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 21 Feb 2025 18:28:47 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1740158927;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=d8E0KCTJcKpTpIbzYmadCCoweUJ51WRfHfeeRgIaVn8=;
	b=C3y6INTA/KXXCy1Euc8gQ2VEcATAU1ql/T4BbvGENi7kKcAdbfCHKQZP0GdsBUfj1hiSIt
	kuKB57CPNk0SB5yg5ZjLNtmynLZrx3GcQyRAitSJVoYng+mxaXFBvVHilMrRyxynDIsu0u
	D1ryxnIGK44Rcs+Kc3NmOtNB/0StZyU=
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1740158927; a=rsa-sha256;
	cv=none;
	b=u4HckCk6Vtm5+wyHJdHSTgyZpoowlEVrKCJBM3hxxHcWimwhWtS6KkaWlIX5vBC1kbv9qW
	X0sPXKwO2ADkxiiUnks58l+bex5gEuszr83Cq9+ka7vJqvJaPqcl/LOidR92mGE5OGtizM
	dGou3gFhxpUQQKLqg3fEXXgMNx9kobA=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=NKoUb1db;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1740158926;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d8E0KCTJcKpTpIbzYmadCCoweUJ51WRfHfeeRgIaVn8=;
	b=NKoUb1dbBp+F9+6gy6ZOUTpVbCHE777/iF2djEeqRxEnqSSuIv83nxQaBHF6YDWfE+nk+x
	wSSahGNcIm8j9hoYJ/vnPBQS/4solT5r61vXbLc27N0uO+Srx1l65yV0iKX7yLs6zEtpJ2
	esLUv+JK4p5dKOXcgqFEjjlEXwSBKyk=
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 21 Feb 2025 18:27:32 +0100
Subject: [PATCH v6 2/3] batman-adv: limit number of learned VLANs from
 bridged-in clients
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250221-dynamic-vlans-v6-2-fd94c9b782a7@narfation.org>
References: <20250221-dynamic-vlans-v6-0-fd94c9b782a7@narfation.org>
In-Reply-To: <20250221-dynamic-vlans-v6-0-fd94c9b782a7@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: =?utf-8?q?Linus_L=C3=BCssing?= <linus.luessing@c0d3.blue>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=9417; i=sven@narfation.org;
 h=from:subject:message-id; bh=flSgFf4Ye9OUXMO27pKP03bd7BYaBNAikOqK34X4Fio=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDOk7tu+6+HBusnKCSdLG7is+7AlpPDNYP4hvrayvZVq87
 HjAPLaZHaUsDGJcDLJiiix7ruSf38z+Vv7ztI9HYeawMoEMYeDiFICJbNdiZJhw/nPwundiOgGm
 N1P3fbyrNZPvpvJyP57rBxMs30g+3D2bkWFJe1KfvlT7W92lsiueOZ0+tKHIVMg+uH6J7+41m5/
 FzmECAA==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: I5M4RK45EICAUTLJPL3OLY4GHENR4ZGG
X-Message-ID-Hash: I5M4RK45EICAUTLJPL3OLY4GHENR4ZGG
X-MailFrom: sven@narfation.org
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/I5M4RK45EICAUTLJPL3OLY4GHENR4ZGG/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Linus Lüssing <linus.luessing@c0d3.blue>

Currently with batman-adv compatibility version 15 each added VLAN
increases the OGM protocol overhead of this node considerably. Therefore
adding a configurable knob to limit the number of learned, snooped VLANs
from traffic from bridged-in clients.

There are currently also still issues in the BLA code that would
temporarily break any broadcast transmissions with every newly learned
VLAN. Therefore setting the default limit for externally learned VLANs to
zero for now.

Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
---
 include/uapi/linux/batman_adv.h    |  6 ++++++
 net/batman-adv/mesh-interface.c    | 32 ++++++++++++++++++++++++++++----
 net/batman-adv/mesh-interface.h    |  4 ++--
 net/batman-adv/netlink.c           | 15 +++++++++++++++
 net/batman-adv/translation-table.c |  3 ++-
 net/batman-adv/types.h             |  6 ++++++
 6 files changed, 59 insertions(+), 7 deletions(-)

diff --git a/include/uapi/linux/batman_adv.h b/include/uapi/linux/batman_adv.h
index 936bcac270b5e3b6fc10a0df64ee2f2925cef4bb..893140821c2a8e551c4ffee2a47144abb2069369 100644
--- a/include/uapi/linux/batman_adv.h
+++ b/include/uapi/linux/batman_adv.h
@@ -481,6 +481,12 @@ enum batadv_nl_attrs {
 	 */
 	BATADV_ATTR_MULTICAST_FANOUT,
 
+	/**
+	 * @BATADV_ATTR_VLAN_DYN_MAX: defines the maximum number of allowed
+	 * learned VLANs from bridged-in clients.
+	 */
+	BATADV_ATTR_VLAN_DYN_MAX,
+
 	/* add attributes above here, update the policy in netlink.c */
 
 	/**
diff --git a/net/batman-adv/mesh-interface.c b/net/batman-adv/mesh-interface.c
index 1e3ffca3fcf03236fb2403d7c6696b6135fc72fc..4a83e6b97afc801e6a1b3b7514a57f0996c68e7c 100644
--- a/net/batman-adv/mesh-interface.c
+++ b/net/batman-adv/mesh-interface.c
@@ -23,6 +23,7 @@
 #include <linux/kref.h>
 #include <linux/list.h>
 #include <linux/lockdep.h>
+#include <linux/net.h>
 #include <linux/netdevice.h>
 #include <linux/netlink.h>
 #include <linux/percpu.h>
@@ -46,6 +47,7 @@
 #include "distributed-arp-table.h"
 #include "gateway_client.h"
 #include "hard-interface.h"
+#include "log.h"
 #include "multicast.h"
 #include "network-coding.h"
 #include "send.h"
@@ -556,13 +558,15 @@ struct batadv_meshif_vlan *batadv_meshif_vlan_get(struct batadv_priv *bat_priv,
  * batadv_meshif_create_vlan() - create a meshif vlan struct
  * @bat_priv: the bat priv with all the mesh interface information
  * @vid: the VLAN identifier
+ * @own: VLAN was not detected via bridged in traffic
  *
  * Return: a pointer to the newly allocated meshif vlan struct on success, NULL
  * otherwise.
  */
 static struct batadv_meshif_vlan *
-batadv_meshif_create_vlan(struct batadv_priv *bat_priv, unsigned short vid)
+batadv_meshif_create_vlan(struct batadv_priv *bat_priv, unsigned short vid, bool own)
 {
+	unsigned short vlan_dyn_max, vlan_dyn_count;
 	struct batadv_meshif_vlan *vlan;
 
 	spin_lock_bh(&bat_priv->meshif_vlan_list_lock);
@@ -573,6 +577,19 @@ batadv_meshif_create_vlan(struct batadv_priv *bat_priv, unsigned short vid)
 		return vlan;
 	}
 
+	vlan_dyn_max = bat_priv->meshif_vlan_dyn_max;
+	vlan_dyn_count = bat_priv->meshif_vlan_dyn_count;
+
+	if (vid & BATADV_VLAN_HAS_TAG && !own &&
+	    vlan_dyn_max <= vlan_dyn_count) {
+		spin_unlock_bh(&bat_priv->meshif_vlan_list_lock);
+
+		net_ratelimited_function(batadv_info, bat_priv->mesh_iface,
+					 "not adding VLAN %d, already learned %hu VID(s)\n",
+					 batadv_print_vid(vid), vlan_dyn_max);
+		return NULL;
+	}
+
 	vlan = kzalloc(sizeof(*vlan), GFP_ATOMIC);
 	if (!vlan) {
 		spin_unlock_bh(&bat_priv->meshif_vlan_list_lock);
@@ -588,6 +605,9 @@ batadv_meshif_create_vlan(struct batadv_priv *bat_priv, unsigned short vid)
 
 	atomic_set(&vlan->ap_isolation, 0);
 
+	if (vid & BATADV_VLAN_HAS_TAG && !own)
+		bat_priv->meshif_vlan_dyn_count++;
+
 	hlist_add_head_rcu(&vlan->list, &bat_priv->meshif_vlan_list);
 	spin_unlock_bh(&bat_priv->meshif_vlan_list_lock);
 
@@ -597,20 +617,22 @@ batadv_meshif_create_vlan(struct batadv_priv *bat_priv, unsigned short vid)
 /**
  * batadv_meshif_vlan_get_or_create() - retrieve or create a meshif vlan struct
  * @bat_priv: the bat priv with all the mesh interface information
+ * @addr: the mac address of the client to add
  * @vid: the VLAN identifier
+ * @own: VLAN was not detected via bridged in traffic
  *
  * Return: the meshif vlan struct if found or created or NULL otherwise.
  */
 struct batadv_meshif_vlan *
-batadv_meshif_vlan_get_or_create(struct batadv_priv *bat_priv,
-				 unsigned short vid)
+batadv_meshif_vlan_get_or_create(struct batadv_priv *bat_priv, const u8 *addr,
+				 unsigned short vid, bool own)
 {
 	struct batadv_meshif_vlan *vlan = batadv_meshif_vlan_get(bat_priv, vid);
 
 	if (vlan)
 		return vlan;
 
-	return batadv_meshif_create_vlan(bat_priv, vid);
+	return batadv_meshif_create_vlan(bat_priv, vid, own);
 }
 
 /**
@@ -824,6 +846,8 @@ static int batadv_meshif_init_late(struct net_device *dev)
 	bat_priv->tt.last_changeset_len = 0;
 	bat_priv->isolation_mark = 0;
 	bat_priv->isolation_mark_mask = 0;
+	bat_priv->meshif_vlan_dyn_max = 0;
+	bat_priv->meshif_vlan_dyn_count = 0;
 
 	/* randomize initial seqno to avoid collision */
 	get_random_bytes(&random_seqno, sizeof(random_seqno));
diff --git a/net/batman-adv/mesh-interface.h b/net/batman-adv/mesh-interface.h
index afa29e99df85f7fc60bdf2754f32febabaddb9b2..48971400cacdf9485e48bd9be1657e1194c2292e 100644
--- a/net/batman-adv/mesh-interface.h
+++ b/net/batman-adv/mesh-interface.h
@@ -27,8 +27,8 @@ void batadv_meshif_vlan_release(struct kref *ref);
 struct batadv_meshif_vlan *batadv_meshif_vlan_get(struct batadv_priv *bat_priv,
 						  unsigned short vid);
 struct batadv_meshif_vlan *
-batadv_meshif_vlan_get_or_create(struct batadv_priv *bat_priv,
-				 unsigned short vid);
+batadv_meshif_vlan_get_or_create(struct batadv_priv *bat_priv, const u8 *addr,
+				 unsigned short vid, bool own);
 
 /**
  * batadv_meshif_vlan_put() - decrease the vlan object refcounter and
diff --git a/net/batman-adv/netlink.c b/net/batman-adv/netlink.c
index 1836f64ce8aa247331b003f69c1212f8128baf33..aa63bf92a5d5d46801ff2ea0cc84e58c7d2b0775 100644
--- a/net/batman-adv/netlink.c
+++ b/net/batman-adv/netlink.c
@@ -129,6 +129,7 @@ static const struct nla_policy batadv_netlink_policy[NUM_BATADV_ATTR] = {
 	[BATADV_ATTR_MCAST_FLAGS]		= { .type = NLA_U32 },
 	[BATADV_ATTR_MCAST_FLAGS_PRIV]		= { .type = NLA_U32 },
 	[BATADV_ATTR_VLANID]			= { .type = NLA_U16 },
+	[BATADV_ATTR_VLAN_DYN_MAX]		= { .type = NLA_U16 },
 	[BATADV_ATTR_AGGREGATED_OGMS_ENABLED]	= { .type = NLA_U8 },
 	[BATADV_ATTR_AP_ISOLATION_ENABLED]	= { .type = NLA_U8 },
 	[BATADV_ATTR_ISOLATION_MARK]		= { .type = NLA_U32 },
@@ -356,6 +357,10 @@ static int batadv_netlink_mesh_fill(struct sk_buff *msg,
 			atomic_read(&bat_priv->orig_interval)))
 		goto nla_put_failure;
 
+	if (nla_put_u16(msg, BATADV_ATTR_VLAN_DYN_MAX,
+			bat_priv->meshif_vlan_dyn_max))
+		goto nla_put_failure;
+
 	batadv_hardif_put(primary_if);
 
 	genlmsg_end(msg, hdr);
@@ -610,6 +615,16 @@ static int batadv_netlink_set_mesh(struct sk_buff *skb, struct genl_info *info)
 		atomic_set(&bat_priv->orig_interval, orig_interval);
 	}
 
+	if (info->attrs[BATADV_ATTR_VLAN_DYN_MAX]) {
+		u16 vlan_dyn_max;
+
+		attr = info->attrs[BATADV_ATTR_VLAN_DYN_MAX];
+		vlan_dyn_max = nla_get_u16(attr);
+		vlan_dyn_max = min_t(u16, vlan_dyn_max, VLAN_N_VID);
+
+		bat_priv->meshif_vlan_dyn_max = vlan_dyn_max;
+	}
+
 	batadv_netlink_notify_mesh(bat_priv);
 
 	return 0;
diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index efbe7addc121a777393f71d3b07f152d5b039113..75140cb1374d6a476e2e5a0d033423f137925a7c 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -629,6 +629,7 @@ static void batadv_tt_global_free(struct batadv_priv *bat_priv,
 int batadv_tt_local_add(struct net_device *mesh_iface, const u8 *addr,
 			unsigned short vid, int ifindex, u32 mark)
 {
+	bool own = (ifindex == BATADV_NULL_IFINDEX) ? true : false;
 	struct batadv_priv *bat_priv = netdev_priv(mesh_iface);
 	struct batadv_tt_local_entry *tt_local;
 	struct batadv_tt_global_entry *tt_global = NULL;
@@ -704,7 +705,7 @@ int batadv_tt_local_add(struct net_device *mesh_iface, const u8 *addr,
 	}
 
 	/* increase the refcounter of the related vlan */
-	vlan = batadv_meshif_vlan_get_or_create(bat_priv, vid);
+	vlan = batadv_meshif_vlan_get_or_create(bat_priv, addr, vid, own);
 	if (!vlan) {
 		kmem_cache_free(batadv_tl_cache, tt_local);
 		tt_local = NULL;
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 0ca0fc072fc9c1bac810d2a166ee2942f8176720..5f2f467b74a86661a075a9fc71075c32d934f453 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -1751,6 +1751,12 @@ struct batadv_priv {
 	/** @meshif_vlan_list_lock: lock protecting meshif_vlan_list */
 	spinlock_t meshif_vlan_list_lock;
 
+	/** @meshif_vlan_dyn_max: maximum number of allowed learned VLANs */
+	unsigned short meshif_vlan_dyn_max;
+
+	/** @meshif_vlan_dyn_count: current number of learned VLANs */
+	unsigned short meshif_vlan_dyn_count;
+
 #ifdef CONFIG_BATMAN_ADV_BLA
 	/** @bla: bridge loop avoidance data */
 	struct batadv_priv_bla bla;

-- 
2.39.5

