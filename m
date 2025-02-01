Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA83CC0218A
	for <batman-adv@archiver.kernel.org>; Sat,  1 Feb 2025 04:40:08 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 452D5841DE
	for <batman-adv@archiver.kernel.org>; Sat,  1 Feb 2025 05:40:07 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1738384807;
 b=bQ69avZJtwgoQ1itvkTm8w7dBGtbFmhsMSiQiw1koqLxtpJvb+1SVm6zkNpd1xS3cBPnK
 wqj89/qvdVMmJRb0Kv4PeAc+68IOzllZpIsh5GuyOmY3+wfqBIRcFKrANv8j36kbLRVjLtT
 /sK3TIB7xVWb5ZsfU7Qc5jFqdZanJyQ=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1738384807; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=7cB8dMzpRl0Td2hCrLAkbaGX0YPw0GRzdUxFOhyapdM=;
 b=tk7sdTkATLjdHMcYEEOWCU/0xjDRACOZBRzSuy7eYBMw6lXEDLqO53IPDLiHVk+QGeNBN
 0/LvDGfpOK9m2Ugw+7+yWfd+wWX+HSxSyjjBQ88vmXJzYaYmLVSshBjwRoqhPpBShK+miHm
 7As0ohY2P9hke06GkoEr8jlxonixnVg=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=fail;
  arc=pass;
  dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass; dmarc=none
Received: from mail.aperture-lab.de (mail.aperture-lab.de [116.203.183.178])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id D9211805FC
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sat,  1 Feb 2025 05:37:55 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1738384675;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7cB8dMzpRl0Td2hCrLAkbaGX0YPw0GRzdUxFOhyapdM=;
	b=zC3Lr67Or92nYU51hgE4Zj4aPvhh0r4NxXGC0cX91XGpXk+OjK/a1m3o14P7IHa7Q459m5
	FCMLxRDJW4SOzRO3LieDKJumWLncUobagQAIviTj97RHIVdc2kHH7d6sWx7H07IoeJKzU3
	l3GM0ROy4WnKxgVL3+cH4vX+i/sAwzI=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	spf=pass (diktynna.open-mesh.org: domain of linus.luessing@c0d3.blue
 designates 116.203.183.178 as permitted sender)
 smtp.mailfrom=linus.luessing@c0d3.blue;
	dmarc=none
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1738384675; a=rsa-sha256;
	cv=none;
	b=i0VlBk9YMpFAYRUrWBgBPSsxcpJvgA+wQEn5fnM80NokRmDD8MA3Fwp9bdj1/xgJ+MlS/N
	hvU7ZvHrJqR1uNJTWNPy2+/ctRoe4XmqpTZgU8Qa5uQzSMfjKoFMiOe9v01Mi/8KlOQuj/
	uGD2YhfptPtyBI8dgEVD+K7rTHa5tBA=
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 6C27654D0C9;
	Sat,  1 Feb 2025 05:37:55 +0100 (CET)
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Subject: [PATCH v5 3/3] batman-adv: avoid adding bridge VLAN IDs through
 ndo_vlan_rx_add_vid()
Date: Sat,  1 Feb 2025 05:31:30 +0100
Message-ID: <20250201043725.15217-4-linus.luessing@c0d3.blue>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250201043725.15217-1-linus.luessing@c0d3.blue>
References: <20250201043725.15217-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
Message-ID-Hash: W3QLJ6V3HVFD6EBDIO6YH4CRMAQW4AT2
X-Message-ID-Hash: W3QLJ6V3HVFD6EBDIO6YH4CRMAQW4AT2
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/W3QLJ6V3HVFD6EBDIO6YH4CRMAQW4AT2/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

The Linux bridge by default adds the PVID of a port (default VID 1) and
by that triggers our ndo_vlan_rx_add_vid() handler. The PVID is
for ingress traffic from bat0 to the bridge and other bridge ports.
However this makes no statement about what is received or send on bat0
itself, bat0 might as well be an untagged access port, even with a PVID
configured. Therefore ignoring here when a bridge is involved.

Also, similarly a "bridge vlan add vid 42 dev bat0 untagged" would call
this handler with VID 42. Even though we wouldn't be interested in this
VLAN as its traffic would be untagged on our side.

The issue is that any extra VLAN currently increases our own
OGM protocol overhead quite a bit, so we want to avoid that
by only adding VLANs that we are sure someone will be using.
So only add VLANs through snooping of actual, VLAN tagged
traffic, not through kernel internal network events
if we have a bridge on top.

Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
---
 net/batman-adv/multicast.c      | 30 +++------------------
 net/batman-adv/soft-interface.c | 47 +++++++++++++++++++++++++++++++++
 net/batman-adv/soft-interface.h |  1 +
 3 files changed, 51 insertions(+), 27 deletions(-)

diff --git a/net/batman-adv/multicast.c b/net/batman-adv/multicast.c
index b39c214c0c6d..9b7290bf05bd 100644
--- a/net/batman-adv/multicast.c
+++ b/net/batman-adv/multicast.c
@@ -56,6 +56,7 @@
 #include "log.h"
 #include "netlink.h"
 #include "send.h"
+#include "soft-interface.h"
 #include "translation-table.h"
 #include "tvlv.h"
 
@@ -71,31 +72,6 @@ static void batadv_mcast_start_timer(struct batadv_priv *bat_priv)
 			   msecs_to_jiffies(BATADV_MCAST_WORK_PERIOD));
 }
 
-/**
- * batadv_mcast_get_bridge() - get the bridge on top of the softif if it exists
- * @soft_iface: netdev struct of the mesh interface
- *
- * If the given soft interface has a bridge on top then the refcount
- * of the according net device is increased.
- *
- * Return: NULL if no such bridge exists. Otherwise the net device of the
- * bridge.
- */
-static struct net_device *batadv_mcast_get_bridge(struct net_device *soft_iface)
-{
-	struct net_device *upper = soft_iface;
-
-	rcu_read_lock();
-	do {
-		upper = netdev_master_upper_dev_get_rcu(upper);
-	} while (upper && !netif_is_bridge_master(upper));
-
-	dev_hold(upper);
-	rcu_read_unlock();
-
-	return upper;
-}
-
 /**
  * batadv_mcast_mla_rtr_flags_softif_get_ipv4() - get mcast router flags from
  *  node for IPv4
@@ -288,7 +264,7 @@ batadv_mcast_mla_flags_get(struct batadv_priv *bat_priv)
 	struct batadv_mcast_mla_flags mla_flags;
 	struct net_device *bridge;
 
-	bridge = batadv_mcast_get_bridge(dev);
+	bridge = batadv_softif_get_bridge(dev);
 
 	memset(&mla_flags, 0, sizeof(mla_flags));
 	mla_flags.enabled = 1;
@@ -530,7 +506,7 @@ batadv_mcast_mla_softif_get(struct net_device *dev,
 			    struct hlist_head *mcast_list,
 			    struct batadv_mcast_mla_flags *flags)
 {
-	struct net_device *bridge = batadv_mcast_get_bridge(dev);
+	struct net_device *bridge = batadv_softif_get_bridge(dev);
 	int ret4, ret6 = 0;
 
 	if (bridge)
diff --git a/net/batman-adv/soft-interface.c b/net/batman-adv/soft-interface.c
index 806c30fd17ce..70a27eb1db8e 100644
--- a/net/batman-adv/soft-interface.c
+++ b/net/batman-adv/soft-interface.c
@@ -677,6 +677,31 @@ static void batadv_softif_destroy_vlan_own(struct batadv_priv *bat_priv,
 			       "vlan interface destroyed", false);
 }
 
+/**
+ * batadv_softif_get_bridge() - get the bridge on top of the softif if it exists
+ * @soft_iface: netdev struct of the mesh interface
+ *
+ * If the given soft interface has a bridge on top then the refcount
+ * of the according net device is increased.
+ *
+ * Return: NULL if no such bridge exists. Otherwise the net device of the
+ * bridge.
+ */
+struct net_device *batadv_softif_get_bridge(struct net_device *soft_iface)
+{
+	struct net_device *upper = soft_iface;
+
+	rcu_read_lock();
+	do {
+		upper = netdev_master_upper_dev_get_rcu(upper);
+	} while (upper && !netif_is_bridge_master(upper));
+
+	dev_hold(upper);
+	rcu_read_unlock();
+
+	return upper;
+}
+
 /**
  * batadv_interface_add_vid() - ndo_add_vid API implementation
  * @dev: the netdev of the mesh interface
@@ -692,6 +717,7 @@ static int batadv_interface_add_vid(struct net_device *dev, __be16 proto,
 				    unsigned short vid)
 {
 	struct batadv_priv *bat_priv = netdev_priv(dev);
+	struct net_device *bridge;
 
 	/* only 802.1Q vlans are supported.
 	 * batman-adv does not know how to handle other types
@@ -707,6 +733,20 @@ static int batadv_interface_add_vid(struct net_device *dev, __be16 proto,
 	if (vid == 0)
 		return 0;
 
+	/* The Linux bridge adds the PVID of a port (default VID 1) and
+	 * triggers this handler. The PVID is for ingress traffic from
+	 * bat0 to the bridge and other bridge ports. However this makes no
+	 * statement about what is received or send on bat0 itself, bat0
+	 * might as well be an untagged access port, even with a PVID
+	 * configured. Therefore ignoring here when a bridge is involved.
+	 * Instead learn VLANs on the fly from traffic.
+	 */
+	bridge = batadv_softif_get_bridge(dev);
+	if (bridge) {
+		dev_put(bridge);
+		return 0;
+	}
+
 	vid |= BATADV_VLAN_HAS_TAG;
 
 	return batadv_softif_create_vlan_own(bat_priv, vid);
@@ -728,6 +768,7 @@ static int batadv_interface_kill_vid(struct net_device *dev, __be16 proto,
 				     unsigned short vid)
 {
 	struct batadv_priv *bat_priv = netdev_priv(dev);
+	struct net_device *bridge;
 
 	/* only 802.1Q vlans are supported. batman-adv does not know how to
 	 * handle other types
@@ -741,6 +782,12 @@ static int batadv_interface_kill_vid(struct net_device *dev, __be16 proto,
 	if (vid == 0)
 		return 0;
 
+	bridge = batadv_softif_get_bridge(dev);
+	if (bridge) {
+		dev_put(bridge);
+		return 0;
+	}
+
 	batadv_softif_destroy_vlan_own(bat_priv, vid | BATADV_VLAN_HAS_TAG);
 	return 0;
 }
diff --git a/net/batman-adv/soft-interface.h b/net/batman-adv/soft-interface.h
index f5334d275229..130447cb22a8 100644
--- a/net/batman-adv/soft-interface.h
+++ b/net/batman-adv/soft-interface.h
@@ -19,6 +19,7 @@ int batadv_skb_head_push(struct sk_buff *skb, unsigned int len);
 void batadv_interface_rx(struct net_device *soft_iface,
 			 struct sk_buff *skb, int hdr_size,
 			 struct batadv_orig_node *orig_node);
+struct net_device *batadv_softif_get_bridge(struct net_device *soft_iface);
 bool batadv_softif_is_valid(const struct net_device *net_dev);
 extern struct rtnl_link_ops batadv_link_ops;
 int batadv_softif_create_vlan_own(struct batadv_priv *bat_priv,
-- 
2.47.2

