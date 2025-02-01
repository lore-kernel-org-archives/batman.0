Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96FC5C0218F
	for <batman-adv@archiver.kernel.org>; Sat,  1 Feb 2025 04:39:27 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id E53DE842AE
	for <batman-adv@archiver.kernel.org>; Sat,  1 Feb 2025 05:39:25 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1738384765;
 b=leqc5deXT71FYt0fW6VIwgGrW2/bUg6UBurUZYC5Wy46GmUfN7zS0NH7bwnfjLK74Tyft
 TrSpBmZNJMohzue7ZW+TCy6gIj0xbYmHsNP8mR8vAzEorbyQj14sfPettNeHjAwPJQk5m9B
 AINsedqHvcE3hUPXHvuZMv4r0DQ8uLE=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1738384765; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=aqIqL5+C/sniiuWkgEwlBFr6rBgBbyP7sqOhwjSl5Wk=;
 b=IVzkESACRz0zsHLIABdQ+96hn8teBqIPmq68wxt74hYDBJcR62TZr0hnl+Q9yHSiJ+4K5
 meUMO+4RWUZEMDkggxOeonvHnUkn88gj9BogXilVaUxbo+qn/7HC0IBlT4A2G+/41Wh7F8w
 OqWrr2Qz8w54nxV1k/npZxqqurseXnU=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=fail;
  arc=pass;
  dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass; dmarc=none
Received: from mail.aperture-lab.de (mail.aperture-lab.de [116.203.183.178])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 536F2805FC
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sat,  1 Feb 2025 05:37:55 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1738384675;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aqIqL5+C/sniiuWkgEwlBFr6rBgBbyP7sqOhwjSl5Wk=;
	b=MpCBpjbSJUt8O9XLom9FboPPWs7EtfYYpjpxMciuJCFbv3+Gitowvut/wQ6e7K+xTj2pVL
	FEAnr3Zf0Vk97t5TKMJjsqOQhTb4xCmwomN/0PY4o/8So6oyr4srtSZVsFlpq7oqVry6Vv
	PBb9js5jZuboRggsNftfEp3E0UeEqLI=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	spf=pass (diktynna.open-mesh.org: domain of linus.luessing@c0d3.blue
 designates 116.203.183.178 as permitted sender)
 smtp.mailfrom=linus.luessing@c0d3.blue;
	dmarc=none
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1738384675; a=rsa-sha256;
	cv=none;
	b=ifbdXV/TNm6SkVV119IkL/7GjHqP084N4jjbI0Ug/nplocWTLcnOzj2qB9WGxB4XtDHAtL
	g0pnIwpVw/MQ/3dd7p3ezdVeeshsE6QNeKlC1MtBFiAxToWNLKEF2hTExEZ0YwChnB27IW
	rB35fL/ti844AINvSUzb5iJ95getj6M=
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id A6F32540DDF;
	Sat,  1 Feb 2025 05:37:54 +0100 (CET)
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Subject: [PATCH v5 2/3] batman-adv: limit number of learned VLANs from
 bridged-in clients
Date: Sat,  1 Feb 2025 05:31:29 +0100
Message-ID: <20250201043725.15217-3-linus.luessing@c0d3.blue>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250201043725.15217-1-linus.luessing@c0d3.blue>
References: <20250201043725.15217-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
Message-ID-Hash: 2UIOGDP6D2MMOZD5VGELHB66IC7ILODT
X-Message-ID-Hash: 2UIOGDP6D2MMOZD5VGELHB66IC7ILODT
X-MailFrom: linus.luessing@c0d3.blue
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/2UIOGDP6D2MMOZD5VGELHB66IC7ILODT/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

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
 net/batman-adv/netlink.c           | 15 +++++++++++++++
 net/batman-adv/soft-interface.c    | 29 +++++++++++++++++++++++++----
 net/batman-adv/soft-interface.h    |  4 ++--
 net/batman-adv/translation-table.c |  3 ++-
 net/batman-adv/types.h             |  6 ++++++
 6 files changed, 56 insertions(+), 7 deletions(-)

diff --git a/include/uapi/linux/batman_adv.h b/include/uapi/linux/batman_adv.h
index 35dc016c9bb4..44018dd6affd 100644
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
diff --git a/net/batman-adv/netlink.c b/net/batman-adv/netlink.c
index c37e0995f67e..1afd1ab1db2e 100644
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
+			bat_priv->softif_vlan_dyn_max))
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
+		bat_priv->softif_vlan_dyn_max = vlan_dyn_max;
+	}
+
 	batadv_netlink_notify_mesh(bat_priv);
 
 	return 0;
diff --git a/net/batman-adv/soft-interface.c b/net/batman-adv/soft-interface.c
index a5ccbdf12171..806c30fd17ce 100644
--- a/net/batman-adv/soft-interface.c
+++ b/net/batman-adv/soft-interface.c
@@ -46,6 +46,7 @@
 #include "distributed-arp-table.h"
 #include "gateway_client.h"
 #include "hard-interface.h"
+#include "log.h"
 #include "multicast.h"
 #include "network-coding.h"
 #include "send.h"
@@ -561,8 +562,9 @@ struct batadv_softif_vlan *batadv_softif_vlan_get(struct batadv_priv *bat_priv,
  * otherwise.
  */
 static struct batadv_softif_vlan *
-batadv_softif_create_vlan(struct batadv_priv *bat_priv, unsigned short vid)
+batadv_softif_create_vlan(struct batadv_priv *bat_priv, unsigned short vid, bool own)
 {
+	unsigned short vlan_dyn_max, vlan_dyn_count;
 	struct batadv_softif_vlan *vlan;
 
 	spin_lock_bh(&bat_priv->softif_vlan_list_lock);
@@ -573,6 +575,19 @@ batadv_softif_create_vlan(struct batadv_priv *bat_priv, unsigned short vid)
 		return vlan;
 	}
 
+	vlan_dyn_max = bat_priv->softif_vlan_dyn_max;
+	vlan_dyn_count = bat_priv->softif_vlan_dyn_count;
+
+	if (vid & BATADV_VLAN_HAS_TAG && !own &&
+	    vlan_dyn_max <= vlan_dyn_count) {
+		spin_unlock_bh(&bat_priv->softif_vlan_list_lock);
+
+		net_ratelimited_function(batadv_info, bat_priv->soft_iface,
+					 "not adding VLAN %d, already learned %hu VID(s)\n",
+					 batadv_print_vid(vid), vlan_dyn_max);
+		return NULL;
+	}
+
 	vlan = kzalloc(sizeof(*vlan), GFP_ATOMIC);
 	if (!vlan) {
 		spin_unlock_bh(&bat_priv->softif_vlan_list_lock);
@@ -588,6 +603,9 @@ batadv_softif_create_vlan(struct batadv_priv *bat_priv, unsigned short vid)
 
 	atomic_set(&vlan->ap_isolation, 0);
 
+	if (vid & BATADV_VLAN_HAS_TAG && !own)
+		bat_priv->softif_vlan_dyn_count++;
+
 	hlist_add_head_rcu(&vlan->list, &bat_priv->softif_vlan_list);
 	spin_unlock_bh(&bat_priv->softif_vlan_list_lock);
 
@@ -597,20 +615,21 @@ batadv_softif_create_vlan(struct batadv_priv *bat_priv, unsigned short vid)
 /**
  * batadv_softif_vlan_get_or_create() - retrieve or create a softif vlan struct
  * @bat_priv: the bat priv with all the soft interface information
+ * @addr: the mac address of the client to add
  * @vid: the VLAN identifier
  *
  * Return: the softif vlan struct if found or created or NULL otherwise.
  */
 struct batadv_softif_vlan *
-batadv_softif_vlan_get_or_create(struct batadv_priv *bat_priv,
-				 unsigned short vid)
+batadv_softif_vlan_get_or_create(struct batadv_priv *bat_priv, const u8 *addr,
+				 unsigned short vid, bool own)
 {
 	struct batadv_softif_vlan *vlan = batadv_softif_vlan_get(bat_priv, vid);
 
 	if (vlan)
 		return vlan;
 
-	return batadv_softif_create_vlan(bat_priv, vid);
+	return batadv_softif_create_vlan(bat_priv, vid, own);
 }
 
 /**
@@ -824,6 +843,8 @@ static int batadv_softif_init_late(struct net_device *dev)
 	bat_priv->tt.last_changeset_len = 0;
 	bat_priv->isolation_mark = 0;
 	bat_priv->isolation_mark_mask = 0;
+	bat_priv->softif_vlan_dyn_max = 0;
+	bat_priv->softif_vlan_dyn_count = 0;
 
 	/* randomize initial seqno to avoid collision */
 	get_random_bytes(&random_seqno, sizeof(random_seqno));
diff --git a/net/batman-adv/soft-interface.h b/net/batman-adv/soft-interface.h
index 7050ccd304df..f5334d275229 100644
--- a/net/batman-adv/soft-interface.h
+++ b/net/batman-adv/soft-interface.h
@@ -27,8 +27,8 @@ void batadv_softif_vlan_release(struct kref *ref);
 struct batadv_softif_vlan *batadv_softif_vlan_get(struct batadv_priv *bat_priv,
 						  unsigned short vid);
 struct batadv_softif_vlan *
-batadv_softif_vlan_get_or_create(struct batadv_priv *bat_priv,
-				 unsigned short vid);
+batadv_softif_vlan_get_or_create(struct batadv_priv *bat_priv, const u8 *addr,
+				 unsigned short vid, bool own);
 
 /**
  * batadv_softif_vlan_put() - decrease the vlan object refcounter and
diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 144ce64e4600..342165da7e40 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -629,6 +629,7 @@ static void batadv_tt_global_free(struct batadv_priv *bat_priv,
 int batadv_tt_local_add(struct net_device *soft_iface, const u8 *addr,
 			unsigned short vid, int ifindex, u32 mark)
 {
+	bool own = (ifindex == BATADV_NULL_IFINDEX) ? true : false;
 	struct batadv_priv *bat_priv = netdev_priv(soft_iface);
 	struct batadv_tt_local_entry *tt_local;
 	struct batadv_tt_global_entry *tt_global = NULL;
@@ -704,7 +705,7 @@ int batadv_tt_local_add(struct net_device *soft_iface, const u8 *addr,
 	}
 
 	/* increase the refcounter of the related vlan */
-	vlan = batadv_softif_vlan_get_or_create(bat_priv, vid);
+	vlan = batadv_softif_vlan_get_or_create(bat_priv, addr, vid, own);
 	if (!vlan) {
 		kmem_cache_free(batadv_tl_cache, tt_local);
 		tt_local = NULL;
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index fe89f08533fe..9f81ab24f0ba 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -1768,6 +1768,12 @@ struct batadv_priv {
 	/** @softif_vlan_list_lock: lock protecting softif_vlan_list */
 	spinlock_t softif_vlan_list_lock;
 
+	/** @softif_vlan_dyn_max: maximum number of allowed learned VLANs */
+	unsigned short softif_vlan_dyn_max;
+
+	/** @softif_vlan_dyn_count: current number of learned VLANs */
+	unsigned short softif_vlan_dyn_count;
+
 #ifdef CONFIG_BATMAN_ADV_BLA
 	/** @bla: bridge loop avoidance data */
 	struct batadv_priv_bla bla;
-- 
2.47.2

