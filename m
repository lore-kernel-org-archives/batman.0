Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08FF3D4979F
	for <batman@archiver.kernel.org>; Mon,  2 Dec 2024 05:37:15 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 5AFCD84038
	for <batman@archiver.kernel.org>; Mon,  2 Dec 2024 06:37:13 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1733117833;
 b=l84BJAmdy7JNcQpTT9KFtIIFsVY4N0PPPE5nK1dyaYqxWl7SxkV8iYTCgrKJZXqEaYZAV
 GjY9+DtRL5teVei4pM/1PqnWtwY1L2+6WP8ovmGBOwMk5iNOcxhGALf9Z9PlvR/vakgh+ZK
 7uYUp6Qu1kA+8cdqMajy70tT2Wtgtrc=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1733117833; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=dAdC+qc5OIyFsfpKLL/tV9D2SPD0EW+1EZ6/u9aK7CM=;
 b=ZFT+aL1D7mM253IimjbKvnVehMWXzeGM+2R7scsQKJX80hoem90ZcRNKzSIHdTuJ+5K/r
 /e6s9lfUDTrQ0HKEkZndsi/z9tGMRQgG0PG589jSCbjeP9IwTY94Ds//+BtDCDA5JluXnQX
 T8p3XjXCd5jMrToLPjlbrxUiaxo9xOk=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=fail;
  arc=pass;
  dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass; dmarc=none
Received: from mail.aperture-lab.de (mail.aperture-lab.de
 [IPv6:2a01:4f8:c2c:665b::1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 13A5A8189D
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon,  2 Dec 2024 06:35:23 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1733117723;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dAdC+qc5OIyFsfpKLL/tV9D2SPD0EW+1EZ6/u9aK7CM=;
	b=uOj34Fm+zs0XVAqm7P3QOeZOVAQSAe3exPmfYB5t3I8HTFow17H2lJFwrQTdVaq/gktOcP
	5FZQ78ejzYgSBBnqG3f3BTfmAKpD42UwPwkTOJwilDd8XVxt9jpnqBxl2N/wFXeGLONHAG
	pCt3yXA3KWR/FK0rnhtwbA/vg9mtFWA=
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1733117723; a=rsa-sha256;
	cv=none;
	b=rDuX9hQH7w+7AFcWI69A0uw2HAnEaZkWNRp6i04NN/xlB5OHVt+dE8OFxLOx+/JlVHMs8n
	3Gg3OnyjszO2zrJCNC9Omv82u6ke+tJl1nCIewF39MdT2n2qbytEDeC9i2DA71x1YKM4Yw
	MkmRT3qbI4MzFvK2eaHLZPaPkKd367s=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	spf=pass (diktynna.open-mesh.org: domain of linus.luessing@c0d3.blue
 designates 2a01:4f8:c2c:665b::1 as permitted sender)
 smtp.mailfrom=linus.luessing@c0d3.blue;
	dmarc=none
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id B1806541073;
	Mon,  2 Dec 2024 06:35:22 +0100 (CET)
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Subject: [PATCH v3 2/3] batman-adv: limit number of learned VLANs from
 bridged-in clients
Date: Mon,  2 Dec 2024 06:05:21 +0100
Message-ID: <20241202053511.326-3-linus.luessing@c0d3.blue>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241202053511.326-1-linus.luessing@c0d3.blue>
References: <20241202053511.326-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
Message-ID-Hash: 7ZHWLAYRGHZU2QMWVHOOCXRHM5NLIZM2
X-Message-ID-Hash: 7ZHWLAYRGHZU2QMWVHOOCXRHM5NLIZM2
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/7ZHWLAYRGHZU2QMWVHOOCXRHM5NLIZM2/>
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
index 3f0003fc502c..5c02cf6c0dc3 100644
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
@@ -357,6 +358,10 @@ static int batadv_netlink_mesh_fill(struct sk_buff *msg,
 			atomic_read(&bat_priv->orig_interval)))
 		goto nla_put_failure;
 
+	if (nla_put_u16(msg, BATADV_ATTR_VLAN_DYN_MAX,
+			bat_priv->softif_vlan_dyn_max))
+		goto nla_put_failure;
+
 	batadv_hardif_put(primary_if);
 
 	genlmsg_end(msg, hdr);
@@ -611,6 +616,16 @@ static int batadv_netlink_set_mesh(struct sk_buff *skb, struct genl_info *info)
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
index d3a3b735ac32..d08f5e99f39f 100644
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
@@ -810,6 +829,8 @@ static int batadv_softif_init_late(struct net_device *dev)
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
index 7b31ecf7cdf1..9cbce8fa5fda 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -635,6 +635,7 @@ static void batadv_tt_global_free(struct batadv_priv *bat_priv,
 int batadv_tt_local_add(struct net_device *soft_iface, const u8 *addr,
 			unsigned short vid, int ifindex, u32 mark)
 {
+	bool own = (ifindex == BATADV_NULL_IFINDEX) ? true : false;
 	struct batadv_priv *bat_priv = netdev_priv(soft_iface);
 	struct batadv_tt_local_entry *tt_local;
 	struct batadv_tt_global_entry *tt_global = NULL;
@@ -710,7 +711,7 @@ int batadv_tt_local_add(struct net_device *soft_iface, const u8 *addr,
 	}
 
 	/* increase the refcounter of the related vlan */
-	vlan = batadv_softif_vlan_get_or_create(bat_priv, vid);
+	vlan = batadv_softif_vlan_get_or_create(bat_priv, addr, vid, own);
 	if (!vlan) {
 		kmem_cache_free(batadv_tl_cache, tt_local);
 		tt_local = NULL;
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 04f6398b3a40..a480e99dfe4d 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -1771,6 +1771,12 @@ struct batadv_priv {
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
2.45.2

