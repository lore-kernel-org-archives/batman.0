Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE5A3C02180
	for <batman-adv@archiver.kernel.org>; Mon, 13 Jan 2025 20:06:09 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 69AB7841DF
	for <batman-adv@archiver.kernel.org>; Mon, 13 Jan 2025 21:06:08 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1736798768;
 b=jxkHoml3nVafVRsZ5BWPFT8pHoVAGdBGXMSxlyGdq7bHf2DKqXUeGwVFP8/0rXKGIXRrK
 cddppWTZ4eNYj2IGKL1VDIFbkvjea9D8rWod6pXh+Xlqiz7HdDu5rnhBU5NUz115unmhaWz
 EL9whpidEYbQsGKTi2h/KQAcrKG86gA=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1736798768; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=I5S3HSpT4PgK+kbuxK0qCzTcvXT/rq804AavMbYArqs=;
 b=AUdihOgFKj5pEgSdAayIDfv3254fzvl1+GibIqm0vwIyhuxaaE9qgV2DLqTd6y9r2FfnE
 o6lkzvVLuBMfwf5/wt3mSe4ihPUJaYOUJcGfCFjAzpnP5j6Aslrh3dujXcOJy4VtqigNg3F
 0fEM50oPtkMEuHgJ+Xn89xZ5mrMLHKk=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=fail;
  arc=pass;
  dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass; dmarc=none
Received: from mail.aperture-lab.de (mail.aperture-lab.de
 [IPv6:2a01:4f8:c2c:665b::1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 3B2C581A5F
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 13 Jan 2025 21:05:16 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1736798716;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I5S3HSpT4PgK+kbuxK0qCzTcvXT/rq804AavMbYArqs=;
	b=N9N9xvQvHahddpTBwmAGuoPTI/43bfxImebEwUlT5RTbuXyk32Vxk5k93iDtk+cgFVUGYf
	VapmFmS0q/EIWiIUSQaUxWojCKOOMIAcD/Cn7LOYvIo9tXbTzjWAKrYMPB6xnvITQ3gGZH
	R/Np2CJLqrqklwuzMgUBp6ezh2TUdL4=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	spf=pass (diktynna.open-mesh.org: domain of linus.luessing@c0d3.blue
 designates 2a01:4f8:c2c:665b::1 as permitted sender)
 smtp.mailfrom=linus.luessing@c0d3.blue;
	dmarc=none
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1736798716; a=rsa-sha256;
	cv=none;
	b=aKR+QpmClyOFaYJjtxFjarDeHOrqzxcKlHhvfZlR2buoUEPGxZPCi2GFGxJbEzYCR0R+28
	JTuXLswcVGsSVoqTFYuxFXqQPn2Nvop61B3++23wcxSlc8Zi0vEhvDDHliXdciMbWcZbQH
	TajGYvNv9MZoU4p2yeOe1Tgt8AQQwVM=
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 73ABC54CCF7;
	Mon, 13 Jan 2025 21:05:15 +0100 (CET)
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Subject: [PATCH v8 1/3] batman-adv: netlink: reduce duplicate code by
 returning interfaces
Date: Mon, 13 Jan 2025 20:31:39 +0100
Message-ID: <20250113200510.18681-2-linus.luessing@c0d3.blue>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250113200510.18681-1-linus.luessing@c0d3.blue>
References: <20250113200510.18681-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
Message-ID-Hash: 3K3MHPVQA2PEIQQAXUOP3YHFIJNTDDC2
X-Message-ID-Hash: 3K3MHPVQA2PEIQQAXUOP3YHFIJNTDDC2
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/3K3MHPVQA2PEIQQAXUOP3YHFIJNTDDC2/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Reduce duplicate code by using netlink helpers which return the
soft/hard interface directly. Instead of returning an interface index
which we are typically not interested in.

Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
---
 net/batman-adv/bridge_loop_avoidance.c |  33 ++----
 net/batman-adv/distributed-arp-table.c |  18 +--
 net/batman-adv/gateway_client.c        |  18 +--
 net/batman-adv/multicast.c             |  17 +--
 net/batman-adv/netlink.c               | 146 +++++++++++++++++--------
 net/batman-adv/netlink.h               |   5 +-
 net/batman-adv/originator.c            | 116 +++++++-------------
 net/batman-adv/translation-table.c     |  30 ++---
 8 files changed, 174 insertions(+), 209 deletions(-)

diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
index 449faf5a5487..8c814f790d17 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -12,6 +12,7 @@
 #include <linux/compiler.h>
 #include <linux/container_of.h>
 #include <linux/crc16.h>
+#include <linux/err.h>
 #include <linux/errno.h>
 #include <linux/etherdevice.h>
 #include <linux/gfp.h>
@@ -38,7 +39,6 @@
 #include <net/arp.h>
 #include <net/genetlink.h>
 #include <net/netlink.h>
-#include <net/sock.h>
 #include <uapi/linux/batadv_packet.h>
 #include <uapi/linux/batman_adv.h>
 
@@ -47,7 +47,6 @@
 #include "log.h"
 #include "netlink.h"
 #include "originator.h"
-#include "soft-interface.h"
 #include "translation-table.h"
 
 static const u8 batadv_announce_mac[4] = {0x43, 0x05, 0x43, 0x05};
@@ -2233,25 +2232,16 @@ int batadv_bla_claim_dump(struct sk_buff *msg, struct netlink_callback *cb)
 {
 	struct batadv_hard_iface *primary_if = NULL;
 	int portid = NETLINK_CB(cb->skb).portid;
-	struct net *net = sock_net(cb->skb->sk);
 	struct net_device *soft_iface;
 	struct batadv_hashtable *hash;
 	struct batadv_priv *bat_priv;
 	int bucket = cb->args[0];
 	int idx = cb->args[1];
-	int ifindex;
 	int ret = 0;
 
-	ifindex = batadv_netlink_get_ifindex(cb->nlh,
-					     BATADV_ATTR_MESH_IFINDEX);
-	if (!ifindex)
-		return -EINVAL;
-
-	soft_iface = dev_get_by_index(net, ifindex);
-	if (!soft_iface || !batadv_softif_is_valid(soft_iface)) {
-		ret = -ENODEV;
-		goto out;
-	}
+	soft_iface = batadv_netlink_get_softif(cb);
+	if (IS_ERR(soft_iface))
+		return PTR_ERR(soft_iface);
 
 	bat_priv = netdev_priv(soft_iface);
 	hash = bat_priv->bla.claim_hash;
@@ -2403,25 +2393,16 @@ int batadv_bla_backbone_dump(struct sk_buff *msg, struct netlink_callback *cb)
 {
 	struct batadv_hard_iface *primary_if = NULL;
 	int portid = NETLINK_CB(cb->skb).portid;
-	struct net *net = sock_net(cb->skb->sk);
 	struct net_device *soft_iface;
 	struct batadv_hashtable *hash;
 	struct batadv_priv *bat_priv;
 	int bucket = cb->args[0];
 	int idx = cb->args[1];
-	int ifindex;
 	int ret = 0;
 
-	ifindex = batadv_netlink_get_ifindex(cb->nlh,
-					     BATADV_ATTR_MESH_IFINDEX);
-	if (!ifindex)
-		return -EINVAL;
-
-	soft_iface = dev_get_by_index(net, ifindex);
-	if (!soft_iface || !batadv_softif_is_valid(soft_iface)) {
-		ret = -ENODEV;
-		goto out;
-	}
+	soft_iface = batadv_netlink_get_softif(cb);
+	if (IS_ERR(soft_iface))
+		return PTR_ERR(soft_iface);
 
 	bat_priv = netdev_priv(soft_iface);
 	hash = bat_priv->bla.backbone_hash;
diff --git a/net/batman-adv/distributed-arp-table.c b/net/batman-adv/distributed-arp-table.c
index 48b72c2be098..e5a07152d4ec 100644
--- a/net/batman-adv/distributed-arp-table.c
+++ b/net/batman-adv/distributed-arp-table.c
@@ -11,6 +11,7 @@
 #include <linux/bitops.h>
 #include <linux/byteorder/generic.h>
 #include <linux/container_of.h>
+#include <linux/err.h>
 #include <linux/errno.h>
 #include <linux/etherdevice.h>
 #include <linux/gfp.h>
@@ -36,7 +37,6 @@
 #include <net/arp.h>
 #include <net/genetlink.h>
 #include <net/netlink.h>
-#include <net/sock.h>
 #include <uapi/linux/batman_adv.h>
 
 #include "bridge_loop_avoidance.h"
@@ -46,7 +46,6 @@
 #include "netlink.h"
 #include "originator.h"
 #include "send.h"
-#include "soft-interface.h"
 #include "translation-table.h"
 #include "tvlv.h"
 
@@ -937,25 +936,16 @@ int batadv_dat_cache_dump(struct sk_buff *msg, struct netlink_callback *cb)
 {
 	struct batadv_hard_iface *primary_if = NULL;
 	int portid = NETLINK_CB(cb->skb).portid;
-	struct net *net = sock_net(cb->skb->sk);
 	struct net_device *soft_iface;
 	struct batadv_hashtable *hash;
 	struct batadv_priv *bat_priv;
 	int bucket = cb->args[0];
 	int idx = cb->args[1];
-	int ifindex;
 	int ret = 0;
 
-	ifindex = batadv_netlink_get_ifindex(cb->nlh,
-					     BATADV_ATTR_MESH_IFINDEX);
-	if (!ifindex)
-		return -EINVAL;
-
-	soft_iface = dev_get_by_index(net, ifindex);
-	if (!soft_iface || !batadv_softif_is_valid(soft_iface)) {
-		ret = -ENODEV;
-		goto out;
-	}
+	soft_iface = batadv_netlink_get_softif(cb);
+	if (IS_ERR(soft_iface))
+		return PTR_ERR(soft_iface);
 
 	bat_priv = netdev_priv(soft_iface);
 	hash = bat_priv->dat.hash;
diff --git a/net/batman-adv/gateway_client.c b/net/batman-adv/gateway_client.c
index 0ddd8b4b3f4c..f68e34ed1f62 100644
--- a/net/batman-adv/gateway_client.c
+++ b/net/batman-adv/gateway_client.c
@@ -10,6 +10,7 @@
 #include <linux/atomic.h>
 #include <linux/byteorder/generic.h>
 #include <linux/container_of.h>
+#include <linux/err.h>
 #include <linux/errno.h>
 #include <linux/etherdevice.h>
 #include <linux/gfp.h>
@@ -31,7 +32,6 @@
 #include <linux/sprintf.h>
 #include <linux/stddef.h>
 #include <linux/udp.h>
-#include <net/sock.h>
 #include <uapi/linux/batadv_packet.h>
 #include <uapi/linux/batman_adv.h>
 
@@ -40,7 +40,6 @@
 #include "netlink.h"
 #include "originator.h"
 #include "routing.h"
-#include "soft-interface.h"
 #include "translation-table.h"
 
 /* These are the offsets of the "hw type" and "hw address length" in the dhcp
@@ -502,22 +501,13 @@ void batadv_gw_node_free(struct batadv_priv *bat_priv)
 int batadv_gw_dump(struct sk_buff *msg, struct netlink_callback *cb)
 {
 	struct batadv_hard_iface *primary_if = NULL;
-	struct net *net = sock_net(cb->skb->sk);
 	struct net_device *soft_iface;
 	struct batadv_priv *bat_priv;
-	int ifindex;
 	int ret;
 
-	ifindex = batadv_netlink_get_ifindex(cb->nlh,
-					     BATADV_ATTR_MESH_IFINDEX);
-	if (!ifindex)
-		return -EINVAL;
-
-	soft_iface = dev_get_by_index(net, ifindex);
-	if (!soft_iface || !batadv_softif_is_valid(soft_iface)) {
-		ret = -ENODEV;
-		goto out;
-	}
+	soft_iface = batadv_netlink_get_softif(cb);
+	if (IS_ERR(soft_iface))
+		return PTR_ERR(soft_iface);
 
 	bat_priv = netdev_priv(soft_iface);
 
diff --git a/net/batman-adv/multicast.c b/net/batman-adv/multicast.c
index 38fab5e46ae2..bcb5fd4e0219 100644
--- a/net/batman-adv/multicast.c
+++ b/net/batman-adv/multicast.c
@@ -12,6 +12,7 @@
 #include <linux/bug.h>
 #include <linux/byteorder/generic.h>
 #include <linux/container_of.h>
+#include <linux/err.h>
 #include <linux/errno.h>
 #include <linux/etherdevice.h>
 #include <linux/gfp.h>
@@ -46,7 +47,6 @@
 #include <net/ip.h>
 #include <net/ipv6.h>
 #include <net/netlink.h>
-#include <net/sock.h>
 #include <uapi/linux/batadv_packet.h>
 #include <uapi/linux/batman_adv.h>
 
@@ -56,7 +56,6 @@
 #include "log.h"
 #include "netlink.h"
 #include "send.h"
-#include "soft-interface.h"
 #include "translation-table.h"
 #include "tvlv.h"
 
@@ -2112,21 +2111,13 @@ batadv_mcast_netlink_get_primary(struct netlink_callback *cb,
 				 struct batadv_hard_iface **primary_if)
 {
 	struct batadv_hard_iface *hard_iface = NULL;
-	struct net *net = sock_net(cb->skb->sk);
 	struct net_device *soft_iface;
 	struct batadv_priv *bat_priv;
-	int ifindex;
 	int ret = 0;
 
-	ifindex = batadv_netlink_get_ifindex(cb->nlh, BATADV_ATTR_MESH_IFINDEX);
-	if (!ifindex)
-		return -EINVAL;
-
-	soft_iface = dev_get_by_index(net, ifindex);
-	if (!soft_iface || !batadv_softif_is_valid(soft_iface)) {
-		ret = -ENODEV;
-		goto out;
-	}
+	soft_iface = batadv_netlink_get_softif(cb);
+	if (IS_ERR(soft_iface))
+		return PTR_ERR(soft_iface);
 
 	bat_priv = netdev_priv(soft_iface);
 
diff --git a/net/batman-adv/netlink.c b/net/batman-adv/netlink.c
index 3f0003fc502c..c37e0995f67e 100644
--- a/net/batman-adv/netlink.c
+++ b/net/batman-adv/netlink.c
@@ -158,8 +158,7 @@ static const struct nla_policy batadv_netlink_policy[NUM_BATADV_ATTR] = {
  *
  * Return: interface index, or 0.
  */
-int
-batadv_netlink_get_ifindex(const struct nlmsghdr *nlh, int attrtype)
+static int batadv_netlink_get_ifindex(const struct nlmsghdr *nlh, int attrtype)
 {
 	struct nlattr *attr = nlmsg_find_attr(nlh, GENL_HDRLEN, attrtype);
 
@@ -881,14 +880,14 @@ static int batadv_netlink_notify_hardif(struct batadv_priv *bat_priv,
 }
 
 /**
- * batadv_netlink_get_hardif() - Get hardif attributes
+ * batadv_netlink_cmd_get_hardif() - Get hardif attributes
  * @skb: Netlink message with request data
  * @info: receiver information
  *
  * Return: 0 on success or negative error number in case of failure
  */
-static int batadv_netlink_get_hardif(struct sk_buff *skb,
-				     struct genl_info *info)
+static int batadv_netlink_cmd_get_hardif(struct sk_buff *skb,
+					 struct genl_info *info)
 {
 	struct batadv_hard_iface *hard_iface = info->user_ptr[1];
 	struct batadv_priv *bat_priv = info->user_ptr[0];
@@ -964,28 +963,16 @@ static int batadv_netlink_set_hardif(struct sk_buff *skb,
 static int
 batadv_netlink_dump_hardif(struct sk_buff *msg, struct netlink_callback *cb)
 {
-	struct net *net = sock_net(cb->skb->sk);
 	struct net_device *soft_iface;
 	struct batadv_hard_iface *hard_iface;
 	struct batadv_priv *bat_priv;
-	int ifindex;
 	int portid = NETLINK_CB(cb->skb).portid;
 	int skip = cb->args[0];
 	int i = 0;
 
-	ifindex = batadv_netlink_get_ifindex(cb->nlh,
-					     BATADV_ATTR_MESH_IFINDEX);
-	if (!ifindex)
-		return -EINVAL;
-
-	soft_iface = dev_get_by_index(net, ifindex);
-	if (!soft_iface)
-		return -ENODEV;
-
-	if (!batadv_softif_is_valid(soft_iface)) {
-		dev_put(soft_iface);
-		return -ENODEV;
-	}
+	soft_iface = batadv_netlink_get_softif(cb);
+	if (IS_ERR(soft_iface))
+		return PTR_ERR(soft_iface);
 
 	bat_priv = netdev_priv(soft_iface);
 
@@ -1150,23 +1137,17 @@ static int batadv_netlink_set_vlan(struct sk_buff *skb, struct genl_info *info)
 }
 
 /**
- * batadv_get_softif_from_info() - Retrieve soft interface from genl attributes
+ * batadv_netlink_get_softif_from_ifindex() - Get soft-iface from ifindex
  * @net: the applicable net namespace
- * @info: receiver information
+ * @ifindex: index of the soft interface
  *
  * Return: Pointer to soft interface (with increased refcnt) on success, error
  *  pointer on error
  */
 static struct net_device *
-batadv_get_softif_from_info(struct net *net, struct genl_info *info)
+batadv_netlink_get_softif_from_ifindex(struct net *net, int ifindex)
 {
 	struct net_device *soft_iface;
-	int ifindex;
-
-	if (!info->attrs[BATADV_ATTR_MESH_IFINDEX])
-		return ERR_PTR(-EINVAL);
-
-	ifindex = nla_get_u32(info->attrs[BATADV_ATTR_MESH_IFINDEX]);
 
 	soft_iface = dev_get_by_index(net, ifindex);
 	if (!soft_iface)
@@ -1184,28 +1165,61 @@ batadv_get_softif_from_info(struct net *net, struct genl_info *info)
 }
 
 /**
- * batadv_get_hardif_from_info() - Retrieve hardif from genl attributes
- * @bat_priv: the bat priv with all the soft interface information
+ * batadv_netlink_get_softif_from_info() - Get soft-iface from genl attributes
  * @net: the applicable net namespace
  * @info: receiver information
  *
+ * Return: Pointer to soft interface (with increased refcnt) on success, error
+ *  pointer on error
+ */
+static struct net_device *
+batadv_netlink_get_softif_from_info(struct net *net, struct genl_info *info)
+{
+	int ifindex;
+
+	if (!info->attrs[BATADV_ATTR_MESH_IFINDEX])
+		return ERR_PTR(-EINVAL);
+
+	ifindex = nla_get_u32(info->attrs[BATADV_ATTR_MESH_IFINDEX]);
+
+	return batadv_netlink_get_softif_from_ifindex(net, ifindex);
+}
+
+/**
+ * batadv_netlink_get_softif() - Retrieve soft interface from netlink callback
+ * @cb: callback structure containing arguments
+ *
+ * Return: Pointer to soft interface (with increased refcnt) on success, error
+ *  pointer on error
+ */
+struct net_device *batadv_netlink_get_softif(struct netlink_callback *cb)
+{
+	int ifindex = batadv_netlink_get_ifindex(cb->nlh,
+						 BATADV_ATTR_MESH_IFINDEX);
+	if (!ifindex)
+		return ERR_PTR(-ENONET);
+
+	return batadv_netlink_get_softif_from_ifindex(sock_net(cb->skb->sk),
+						      ifindex);
+}
+
+/**
+ * batadv_netlink_get_hardif_from_ifindex() - Get hard-iface from ifindex
+ * @bat_priv: the bat priv with all the soft interface information
+ * @net: the applicable net namespace
+ * @ifindex: index of the hard interface
+ *
  * Return: Pointer to hard interface (with increased refcnt) on success, error
  *  pointer on error
  */
 static struct batadv_hard_iface *
-batadv_get_hardif_from_info(struct batadv_priv *bat_priv, struct net *net,
-			    struct genl_info *info)
+batadv_netlink_get_hardif_from_ifindex(struct batadv_priv *bat_priv,
+				       struct net *net, int ifindex)
 {
 	struct batadv_hard_iface *hard_iface;
 	struct net_device *hard_dev;
-	unsigned int hardif_index;
 
-	if (!info->attrs[BATADV_ATTR_HARD_IFINDEX])
-		return ERR_PTR(-EINVAL);
-
-	hardif_index = nla_get_u32(info->attrs[BATADV_ATTR_HARD_IFINDEX]);
-
-	hard_dev = dev_get_by_index(net, hardif_index);
+	hard_dev = dev_get_by_index(net, ifindex);
 	if (!hard_dev)
 		return ERR_PTR(-ENODEV);
 
@@ -1229,6 +1243,51 @@ batadv_get_hardif_from_info(struct batadv_priv *bat_priv, struct net *net,
 	return ERR_PTR(-EINVAL);
 }
 
+/**
+ * batadv_netlink_get_hardif_from_info() - Get hard-iface from genl attributes
+ * @bat_priv: the bat priv with all the soft interface information
+ * @net: the applicable net namespace
+ * @info: receiver information
+ *
+ * Return: Pointer to hard interface (with increased refcnt) on success, error
+ *  pointer on error
+ */
+static struct batadv_hard_iface *
+batadv_netlink_get_hardif_from_info(struct batadv_priv *bat_priv,
+				    struct net *net, struct genl_info *info)
+{
+	int ifindex;
+
+	if (!info->attrs[BATADV_ATTR_HARD_IFINDEX])
+		return ERR_PTR(-EINVAL);
+
+	ifindex = nla_get_u32(info->attrs[BATADV_ATTR_HARD_IFINDEX]);
+
+	return batadv_netlink_get_hardif_from_ifindex(bat_priv, net, ifindex);
+}
+
+/**
+ * batadv_netlink_get_hardif() - Retrieve hard interface from netlink callback
+ * @bat_priv: the bat priv with all the soft interface information
+ * @cb: callback structure containing arguments
+ *
+ * Return: Pointer to hard interface (with increased refcnt) on success, error
+ *  pointer on error
+ */
+struct batadv_hard_iface *
+batadv_netlink_get_hardif(struct batadv_priv *bat_priv,
+			  struct netlink_callback *cb)
+{
+	int ifindex = batadv_netlink_get_ifindex(cb->nlh,
+						 BATADV_ATTR_HARD_IFINDEX);
+	if (!ifindex)
+		return ERR_PTR(-ENONET);
+
+	return batadv_netlink_get_hardif_from_ifindex(bat_priv,
+						      sock_net(cb->skb->sk),
+						      ifindex);
+}
+
 /**
  * batadv_get_vlan_from_info() - Retrieve vlan from genl attributes
  * @bat_priv: the bat priv with all the soft interface information
@@ -1288,7 +1347,7 @@ static int batadv_pre_doit(const struct genl_split_ops *ops,
 		return -EINVAL;
 
 	if (ops->internal_flags & BATADV_FLAG_NEED_MESH) {
-		soft_iface = batadv_get_softif_from_info(net, info);
+		soft_iface = batadv_netlink_get_softif_from_info(net, info);
 		if (IS_ERR(soft_iface))
 			return PTR_ERR(soft_iface);
 
@@ -1297,7 +1356,8 @@ static int batadv_pre_doit(const struct genl_split_ops *ops,
 	}
 
 	if (ops->internal_flags & BATADV_FLAG_NEED_HARDIF) {
-		hard_iface = batadv_get_hardif_from_info(bat_priv, net, info);
+		hard_iface = batadv_netlink_get_hardif_from_info(bat_priv, net,
+								 info);
 		if (IS_ERR(hard_iface)) {
 			ret = PTR_ERR(hard_iface);
 			goto err_put_softif;
@@ -1390,7 +1450,7 @@ static const struct genl_small_ops batadv_netlink_ops[] = {
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		/* can be retrieved by unprivileged users */
 		.dumpit = batadv_netlink_dump_hardif,
-		.doit = batadv_netlink_get_hardif,
+		.doit = batadv_netlink_cmd_get_hardif,
 		.internal_flags = BATADV_FLAG_NEED_MESH |
 				  BATADV_FLAG_NEED_HARDIF,
 	},
diff --git a/net/batman-adv/netlink.h b/net/batman-adv/netlink.h
index 876d2806a67d..2097c2ae98f1 100644
--- a/net/batman-adv/netlink.h
+++ b/net/batman-adv/netlink.h
@@ -15,7 +15,10 @@
 
 void batadv_netlink_register(void);
 void batadv_netlink_unregister(void);
-int batadv_netlink_get_ifindex(const struct nlmsghdr *nlh, int attrtype);
+struct net_device *batadv_netlink_get_softif(struct netlink_callback *cb);
+struct batadv_hard_iface *
+batadv_netlink_get_hardif(struct batadv_priv *bat_priv,
+			  struct netlink_callback *cb);
 
 int batadv_netlink_tpmeter_notify(struct batadv_priv *bat_priv, const u8 *dst,
 				  u8 result, u32 test_time, u64 total_bytes,
diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
index 8f6dd2c6ee41..8f94fcc52f34 100644
--- a/net/batman-adv/originator.c
+++ b/net/batman-adv/originator.c
@@ -9,6 +9,7 @@
 
 #include <linux/atomic.h>
 #include <linux/container_of.h>
+#include <linux/err.h>
 #include <linux/errno.h>
 #include <linux/etherdevice.h>
 #include <linux/gfp.h>
@@ -26,9 +27,7 @@
 #include <linux/spinlock.h>
 #include <linux/stddef.h>
 #include <linux/workqueue.h>
-#include <net/sock.h>
 #include <uapi/linux/batadv_packet.h>
-#include <uapi/linux/batman_adv.h>
 
 #include "bat_algo.h"
 #include "distributed-arp-table.h"
@@ -41,7 +40,6 @@
 #include "netlink.h"
 #include "network-coding.h"
 #include "routing.h"
-#include "soft-interface.h"
 #include "translation-table.h"
 
 /* hash class keys */
@@ -755,64 +753,48 @@ batadv_neigh_node_get_or_create(struct batadv_orig_node *orig_node,
  */
 int batadv_hardif_neigh_dump(struct sk_buff *msg, struct netlink_callback *cb)
 {
-	struct net *net = sock_net(cb->skb->sk);
+	struct batadv_hard_iface *primary_if, *hard_iface;
 	struct net_device *soft_iface;
-	struct net_device *hard_iface = NULL;
-	struct batadv_hard_iface *hardif = BATADV_IF_DEFAULT;
 	struct batadv_priv *bat_priv;
-	struct batadv_hard_iface *primary_if = NULL;
 	int ret;
-	int ifindex, hard_ifindex;
 
-	ifindex = batadv_netlink_get_ifindex(cb->nlh, BATADV_ATTR_MESH_IFINDEX);
-	if (!ifindex)
-		return -EINVAL;
-
-	soft_iface = dev_get_by_index(net, ifindex);
-	if (!soft_iface || !batadv_softif_is_valid(soft_iface)) {
-		ret = -ENODEV;
-		goto out;
-	}
+	soft_iface = batadv_netlink_get_softif(cb);
+	if (IS_ERR(soft_iface))
+		return PTR_ERR(soft_iface);
 
 	bat_priv = netdev_priv(soft_iface);
 
 	primary_if = batadv_primary_if_get_selected(bat_priv);
 	if (!primary_if || primary_if->if_status != BATADV_IF_ACTIVE) {
 		ret = -ENOENT;
-		goto out;
+		goto out_put_soft_iface;
 	}
 
-	hard_ifindex = batadv_netlink_get_ifindex(cb->nlh,
-						  BATADV_ATTR_HARD_IFINDEX);
-	if (hard_ifindex) {
-		hard_iface = dev_get_by_index(net, hard_ifindex);
-		if (hard_iface)
-			hardif = batadv_hardif_get_by_netdev(hard_iface);
-
-		if (!hardif) {
-			ret = -ENODEV;
-			goto out;
-		}
-
-		if (hardif->soft_iface != soft_iface) {
-			ret = -ENOENT;
-			goto out;
-		}
+	hard_iface = batadv_netlink_get_hardif(bat_priv, cb);
+	if (IS_ERR(hard_iface) && PTR_ERR(hard_iface) != -ENONET) {
+		ret = PTR_ERR(hard_iface);
+		goto out_put_primary_if;
+	} else if (IS_ERR(hard_iface)) {
+		/* => PTR_ERR(hard_iface) == -ENOENT
+		 * => no hard-iface given, ok
+		 */
+		hard_iface = BATADV_IF_DEFAULT;
 	}
 
 	if (!bat_priv->algo_ops->neigh.dump) {
 		ret = -EOPNOTSUPP;
-		goto out;
+		goto out_put_hard_iface;
 	}
 
-	bat_priv->algo_ops->neigh.dump(msg, cb, bat_priv, hardif);
+	bat_priv->algo_ops->neigh.dump(msg, cb, bat_priv, hard_iface);
 
 	ret = msg->len;
 
- out:
-	batadv_hardif_put(hardif);
-	dev_put(hard_iface);
+out_put_hard_iface:
+	batadv_hardif_put(hard_iface);
+out_put_primary_if:
 	batadv_hardif_put(primary_if);
+out_put_soft_iface:
 	dev_put(soft_iface);
 
 	return ret;
@@ -1342,64 +1324,48 @@ static void batadv_purge_orig(struct work_struct *work)
  */
 int batadv_orig_dump(struct sk_buff *msg, struct netlink_callback *cb)
 {
-	struct net *net = sock_net(cb->skb->sk);
+	struct batadv_hard_iface *primary_if, *hard_iface;
 	struct net_device *soft_iface;
-	struct net_device *hard_iface = NULL;
-	struct batadv_hard_iface *hardif = BATADV_IF_DEFAULT;
 	struct batadv_priv *bat_priv;
-	struct batadv_hard_iface *primary_if = NULL;
 	int ret;
-	int ifindex, hard_ifindex;
 
-	ifindex = batadv_netlink_get_ifindex(cb->nlh, BATADV_ATTR_MESH_IFINDEX);
-	if (!ifindex)
-		return -EINVAL;
-
-	soft_iface = dev_get_by_index(net, ifindex);
-	if (!soft_iface || !batadv_softif_is_valid(soft_iface)) {
-		ret = -ENODEV;
-		goto out;
-	}
+	soft_iface = batadv_netlink_get_softif(cb);
+	if (IS_ERR(soft_iface))
+		return PTR_ERR(soft_iface);
 
 	bat_priv = netdev_priv(soft_iface);
 
 	primary_if = batadv_primary_if_get_selected(bat_priv);
 	if (!primary_if || primary_if->if_status != BATADV_IF_ACTIVE) {
 		ret = -ENOENT;
-		goto out;
+		goto out_put_soft_iface;
 	}
 
-	hard_ifindex = batadv_netlink_get_ifindex(cb->nlh,
-						  BATADV_ATTR_HARD_IFINDEX);
-	if (hard_ifindex) {
-		hard_iface = dev_get_by_index(net, hard_ifindex);
-		if (hard_iface)
-			hardif = batadv_hardif_get_by_netdev(hard_iface);
-
-		if (!hardif) {
-			ret = -ENODEV;
-			goto out;
-		}
-
-		if (hardif->soft_iface != soft_iface) {
-			ret = -ENOENT;
-			goto out;
-		}
+	hard_iface = batadv_netlink_get_hardif(bat_priv, cb);
+	if (IS_ERR(hard_iface) && PTR_ERR(hard_iface) != -ENONET) {
+		ret = PTR_ERR(hard_iface);
+		goto out_put_primary_if;
+	} else if (IS_ERR(hard_iface)) {
+		/* => PTR_ERR(hard_iface) == -ENOENT
+		 * => no hard-iface given, ok
+		 */
+		hard_iface = BATADV_IF_DEFAULT;
 	}
 
 	if (!bat_priv->algo_ops->orig.dump) {
 		ret = -EOPNOTSUPP;
-		goto out;
+		goto out_put_hard_iface;
 	}
 
-	bat_priv->algo_ops->orig.dump(msg, cb, bat_priv, hardif);
+	bat_priv->algo_ops->orig.dump(msg, cb, bat_priv, hard_iface);
 
 	ret = msg->len;
 
- out:
-	batadv_hardif_put(hardif);
-	dev_put(hard_iface);
+out_put_hard_iface:
+	batadv_hardif_put(hard_iface);
+out_put_primary_if:
 	batadv_hardif_put(primary_if);
+out_put_soft_iface:
 	dev_put(soft_iface);
 
 	return ret;
diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 9b73268ddfd3..7e9b8a3db6fc 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -15,6 +15,7 @@
 #include <linux/compiler.h>
 #include <linux/container_of.h>
 #include <linux/crc32c.h>
+#include <linux/err.h>
 #include <linux/errno.h>
 #include <linux/etherdevice.h>
 #include <linux/gfp.h>
@@ -39,7 +40,6 @@
 #include <linux/workqueue.h>
 #include <net/genetlink.h>
 #include <net/netlink.h>
-#include <net/sock.h>
 #include <uapi/linux/batadv_packet.h>
 #include <uapi/linux/batman_adv.h>
 
@@ -1170,26 +1170,18 @@ batadv_tt_local_dump_bucket(struct sk_buff *msg, u32 portid,
  */
 int batadv_tt_local_dump(struct sk_buff *msg, struct netlink_callback *cb)
 {
-	struct net *net = sock_net(cb->skb->sk);
 	struct net_device *soft_iface;
 	struct batadv_priv *bat_priv;
 	struct batadv_hard_iface *primary_if = NULL;
 	struct batadv_hashtable *hash;
 	int ret;
-	int ifindex;
 	int bucket = cb->args[0];
 	int idx = cb->args[1];
 	int portid = NETLINK_CB(cb->skb).portid;
 
-	ifindex = batadv_netlink_get_ifindex(cb->nlh, BATADV_ATTR_MESH_IFINDEX);
-	if (!ifindex)
-		return -EINVAL;
-
-	soft_iface = dev_get_by_index(net, ifindex);
-	if (!soft_iface || !batadv_softif_is_valid(soft_iface)) {
-		ret = -ENODEV;
-		goto out;
-	}
+	soft_iface = batadv_netlink_get_softif(cb);
+	if (IS_ERR(soft_iface))
+		return PTR_ERR(soft_iface);
 
 	bat_priv = netdev_priv(soft_iface);
 
@@ -1945,28 +1937,20 @@ batadv_tt_global_dump_bucket(struct sk_buff *msg, u32 portid, u32 seq,
  */
 int batadv_tt_global_dump(struct sk_buff *msg, struct netlink_callback *cb)
 {
-	struct net *net = sock_net(cb->skb->sk);
 	struct net_device *soft_iface;
 	struct batadv_priv *bat_priv;
 	struct batadv_hard_iface *primary_if = NULL;
 	struct batadv_hashtable *hash;
 	struct hlist_head *head;
 	int ret;
-	int ifindex;
 	int bucket = cb->args[0];
 	int idx = cb->args[1];
 	int sub = cb->args[2];
 	int portid = NETLINK_CB(cb->skb).portid;
 
-	ifindex = batadv_netlink_get_ifindex(cb->nlh, BATADV_ATTR_MESH_IFINDEX);
-	if (!ifindex)
-		return -EINVAL;
-
-	soft_iface = dev_get_by_index(net, ifindex);
-	if (!soft_iface || !batadv_softif_is_valid(soft_iface)) {
-		ret = -ENODEV;
-		goto out;
-	}
+	soft_iface = batadv_netlink_get_softif(cb);
+	if (IS_ERR(soft_iface))
+		return PTR_ERR(soft_iface);
 
 	bat_priv = netdev_priv(soft_iface);
 
-- 
2.45.2

