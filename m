Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12123C021B3
	for <batman-adv@archiver.kernel.org>; Fri, 21 Feb 2025 17:32:08 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 8B8AC8434D
	for <batman-adv@archiver.kernel.org>; Fri, 21 Feb 2025 18:32:07 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1740159127;
 b=Jusnyn0md8vmT2WQw4FEtyKuE5m/2qiXrFUJxBY05zg79w3BFJ0XuuA3EnU54yRcBc4Yh
 YT/0pVG9WQd2o+QqAhXBymL257tZApn0Oh4p1TsonmrMVwrTiqmjh4w0kDvR5MmyAl+6Bvs
 +bNjP7PFyjJicQ/muy9y+aupDMr8XbE=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1740159127; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=Ai1FMW2tKLlsyzfO1ALrSGqRSRk52N3GifJlO81BPYI=;
 b=crTwI20efrEOTCFPqg1P1p4YdchZaitQigFYBFUjHrmYdQnklnSzN0G9jbWKvT0KJmvOf
 moUX36xT3bnEAHQ8GGTVg8QFlwwJezVhQZ6AF/0p247z96VNQz3Pjez3Dk4Evsl1pBHjuP0
 jrEsPHfAgdA/TVbsOI3POgeVcwrfOeg=
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
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 3C47E841DE
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 21 Feb 2025 18:28:53 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1740158933;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=Ai1FMW2tKLlsyzfO1ALrSGqRSRk52N3GifJlO81BPYI=;
	b=TIbr71UhBF3+naQhb1nU1rN8KWsvSYgnERDImV9SA4CM1QZUEhF7tvanOCnZtaSksLnc5w
	UzgDKjL5WpVln+bQ9teLS9KZ5EnJq9BtOF8J2ZfFIWiS0UaQnwJlTYrUoNdFwxweK9aMyv
	A0AH7X0NeyWl/o2YvqBZ0fz7I4osG1k=
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1740158933; a=rsa-sha256;
	cv=none;
	b=K++QF9PD8Oq+F/wdjZAxWdv80JkySoqbuxbFqlpwAQEu07BHwGNUg8iwWlWq/knwGKu+C4
	2t6GjaIBnKpdZgZU15lE195MPjxkR2vw6MP6plGZHJlbCsACUZ0eJksY1lMk0wA8DJEkzr
	FanU/CvInTkh2sMRExToBX4NPUrUcSI=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=SEWNdDqB;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1740158932;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ai1FMW2tKLlsyzfO1ALrSGqRSRk52N3GifJlO81BPYI=;
	b=SEWNdDqBms6TpSO0KTglaukf+jex/r1dcC5KBJxd6ivdE0DA897exjSvvNin9TGHJbrti0
	+teUXUhCDZ+xRxdXrBhzHcJUHPjA3vZLSX3dArUTXjes4sPeKr4ihjJjh0qRpo9SV+UlD8
	jYJVWU5tQNfJzoAaCU4OW9YXwPIDEdM=
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 21 Feb 2025 18:27:33 +0100
Subject: [PATCH v6 3/3] batman-adv: avoid adding bridge VLAN IDs through
 ndo_vlan_rx_add_vid()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250221-dynamic-vlans-v6-3-fd94c9b782a7@narfation.org>
References: <20250221-dynamic-vlans-v6-0-fd94c9b782a7@narfation.org>
In-Reply-To: <20250221-dynamic-vlans-v6-0-fd94c9b782a7@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: =?utf-8?q?Linus_L=C3=BCssing?= <linus.luessing@c0d3.blue>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6954; i=sven@narfation.org;
 h=from:subject:message-id; bh=0IpLAv/oriwgMw3z2vJTTthIZRJhbA2IQA9o7yNvVjo=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDOk7tu/amvxqS1H1oS027fO6eXSNlkpfXT3jaGD2/ZnZr
 p8C+A9N7ChlYRDjYpAVU2TZcyX//Gb2t/Kfp308CjOHlQlkCAMXpwBMpHA5wz+9ConF+wqKzFX2
 pn6Lir8gZtFrGW48vcK/XbrzfINu92+G/3lZbXEs/ZVNP9bUvqm868O25qtRctAySYWAe21p33b
 n8QAA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: XWRAGSV4I6TXAGB65RAPFXM3PVORYXNZ
X-Message-ID-Hash: XWRAGSV4I6TXAGB65RAPFXM3PVORYXNZ
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/XWRAGSV4I6TXAGB65RAPFXM3PVORYXNZ/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Linus Lüssing <linus.luessing@c0d3.blue>

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
 net/batman-adv/mesh-interface.c | 47 +++++++++++++++++++++++++++++++++++++++++
 net/batman-adv/mesh-interface.h |  1 +
 net/batman-adv/multicast.c      | 30 +++-----------------------
 3 files changed, 51 insertions(+), 27 deletions(-)

diff --git a/net/batman-adv/mesh-interface.c b/net/batman-adv/mesh-interface.c
index 4a83e6b97afc801e6a1b3b7514a57f0996c68e7c..f1ae8d1b8458b8597121b783697d39032eae2600 100644
--- a/net/batman-adv/mesh-interface.c
+++ b/net/batman-adv/mesh-interface.c
@@ -680,6 +680,31 @@ static void batadv_meshif_destroy_vlan_own(struct batadv_priv *bat_priv,
 			       "vlan interface destroyed", false);
 }
 
+/**
+ * batadv_meshif_get_bridge() - get the bridge on top of the meshif if it exists
+ * @mesh_iface: netdev struct of the mesh interface
+ *
+ * If the given mesh interface has a bridge on top then the refcount
+ * of the according net device is increased.
+ *
+ * Return: NULL if no such bridge exists. Otherwise the net device of the
+ * bridge.
+ */
+struct net_device *batadv_meshif_get_bridge(struct net_device *mesh_iface)
+{
+	struct net_device *upper = mesh_iface;
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
@@ -695,6 +720,7 @@ static int batadv_interface_add_vid(struct net_device *dev, __be16 proto,
 				    unsigned short vid)
 {
 	struct batadv_priv *bat_priv = netdev_priv(dev);
+	struct net_device *bridge;
 
 	/* only 802.1Q vlans are supported.
 	 * batman-adv does not know how to handle other types
@@ -710,6 +736,20 @@ static int batadv_interface_add_vid(struct net_device *dev, __be16 proto,
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
+	bridge = batadv_meshif_get_bridge(dev);
+	if (bridge) {
+		dev_put(bridge);
+		return 0;
+	}
+
 	vid |= BATADV_VLAN_HAS_TAG;
 
 	return batadv_meshif_create_vlan_own(bat_priv, vid);
@@ -731,6 +771,7 @@ static int batadv_interface_kill_vid(struct net_device *dev, __be16 proto,
 				     unsigned short vid)
 {
 	struct batadv_priv *bat_priv = netdev_priv(dev);
+	struct net_device *bridge;
 
 	/* only 802.1Q vlans are supported. batman-adv does not know how to
 	 * handle other types
@@ -744,6 +785,12 @@ static int batadv_interface_kill_vid(struct net_device *dev, __be16 proto,
 	if (vid == 0)
 		return 0;
 
+	bridge = batadv_meshif_get_bridge(dev);
+	if (bridge) {
+		dev_put(bridge);
+		return 0;
+	}
+
 	batadv_meshif_destroy_vlan_own(bat_priv, vid | BATADV_VLAN_HAS_TAG);
 	return 0;
 }
diff --git a/net/batman-adv/mesh-interface.h b/net/batman-adv/mesh-interface.h
index 48971400cacdf9485e48bd9be1657e1194c2292e..290440b86484a52f313f6f6ca757d27cf44cf5e9 100644
--- a/net/batman-adv/mesh-interface.h
+++ b/net/batman-adv/mesh-interface.h
@@ -19,6 +19,7 @@ int batadv_skb_head_push(struct sk_buff *skb, unsigned int len);
 void batadv_interface_rx(struct net_device *mesh_iface,
 			 struct sk_buff *skb, int hdr_size,
 			 struct batadv_orig_node *orig_node);
+struct net_device *batadv_meshif_get_bridge(struct net_device *mesh_iface);
 bool batadv_meshif_is_valid(const struct net_device *net_dev);
 extern struct rtnl_link_ops batadv_link_ops;
 int batadv_meshif_create_vlan_own(struct batadv_priv *bat_priv,
diff --git a/net/batman-adv/multicast.c b/net/batman-adv/multicast.c
index 97665c3005c54591b205d0f429c98ce056260335..17463c28c04491711239e4f917092415f182ba19 100644
--- a/net/batman-adv/multicast.c
+++ b/net/batman-adv/multicast.c
@@ -56,6 +56,7 @@
 #include "log.h"
 #include "netlink.h"
 #include "send.h"
+#include "mesh-interface.h"
 #include "translation-table.h"
 #include "tvlv.h"
 
@@ -71,31 +72,6 @@ static void batadv_mcast_start_timer(struct batadv_priv *bat_priv)
 			   msecs_to_jiffies(BATADV_MCAST_WORK_PERIOD));
 }
 
-/**
- * batadv_mcast_get_bridge() - get the bridge on top of the meshif if it exists
- * @mesh_iface: netdev struct of the mesh interface
- *
- * If the given mesh interface has a bridge on top then the refcount
- * of the according net device is increased.
- *
- * Return: NULL if no such bridge exists. Otherwise the net device of the
- * bridge.
- */
-static struct net_device *batadv_mcast_get_bridge(struct net_device *mesh_iface)
-{
-	struct net_device *upper = mesh_iface;
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
  * batadv_mcast_mla_rtr_flags_meshif_get_ipv4() - get mcast router flags from
  *  node for IPv4
@@ -288,7 +264,7 @@ batadv_mcast_mla_flags_get(struct batadv_priv *bat_priv)
 	struct batadv_mcast_mla_flags mla_flags;
 	struct net_device *bridge;
 
-	bridge = batadv_mcast_get_bridge(dev);
+	bridge = batadv_meshif_get_bridge(dev);
 
 	memset(&mla_flags, 0, sizeof(mla_flags));
 	mla_flags.enabled = 1;
@@ -530,7 +506,7 @@ batadv_mcast_mla_meshif_get(struct net_device *dev,
 			    struct hlist_head *mcast_list,
 			    struct batadv_mcast_mla_flags *flags)
 {
-	struct net_device *bridge = batadv_mcast_get_bridge(dev);
+	struct net_device *bridge = batadv_meshif_get_bridge(dev);
 	int ret4, ret6 = 0;
 
 	if (bridge)

-- 
2.39.5

