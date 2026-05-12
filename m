Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F22C5CD4855
	for <batman@archiver.kernel.org>; Tue, 12 May 2026 06:57:33 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 33B6E85805
	for <batman@archiver.kernel.org>; Tue, 12 May 2026 08:57:32 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1778569052;
 b=dIVEMO3QJGKihQIFOARbyK1VvBfkADD+zXIp/g7ov1TR4WHZebaDG72rS1X0qz1IzBg8M
 3cu7CoEJ4/uwFaVus8FbqLHY6YvRTMxsMxv1qveRBNLT7J1/hg18dXEoqr52YbO/m9pxJVh
 TNHN8sirCLDW2NEnp5ae/Mdz4dwOfRU=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1778569052; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=AL4FTfVuuvGj2yxqnssGRLsGSd37UbwTn1aOY62ZaOs=;
 b=GWjNKxUaFIDIXyPG93cBwHaC52zUR+q72sjUMyVmxVeQC3XPe7dGbtXYDI2NP91gfr2/t
 mPHGG1R5MbJpmtOZVa+txCIvv4QUjmQ3mBAbRhp73+OosyzXLrSBB2B9CuytMpjN5e8jiOd
 82iVEJJJxqkp6mFDOWDxyPq+tX+XsRs=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 7F62E81A3F
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 12 May 2026 08:56:57 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1778569027;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=AL4FTfVuuvGj2yxqnssGRLsGSd37UbwTn1aOY62ZaOs=;
	b=VAJ+U1cxZGvEsoat72AIF6i5Lyb9uxFwRhGNa9NTazEZGt7+QnhAcTioZbiTti05vpe2kR
	hrha4NZ3SvhC8wi8XZ0QjBCz20GB1DeAUjdgTbjMXLzUCxJfG2SS0nJrU/z83fWE+6v41L
	GqT73/cw656CUI7CBWn3tmNgmKg+w04=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=CCYYr0zw;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1778569027;
	b=fD4XXQ4rHfUU8CyCngQkav+BdqGnYZnvFB+tJd3339rEAfV+BSyx1QslcIf7gxWkH2ZdQl
	xwMGDmkpEISNlZYK2CHfW3O+bFZ+e5U4qIMsfPCJB/VbGlNi5X39Urwl2WGR++JjkZxtby
	Tyek/AA4BCDttOG9SGnIm8DHc4oO4Zg=
Received: by dvalin.narfation.org (Postfix) id AEE4C202A2;
	Tue, 12 May 2026 06:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1778569016;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=AL4FTfVuuvGj2yxqnssGRLsGSd37UbwTn1aOY62ZaOs=;
	b=CCYYr0zwdnNfoT9rFILoJOSPB2N75+IDfb2OdtoiCQ4nQDKkJsfu2dUpVR6M7kD11jmK4S
	TaRjY00bAjP21aRuuobVXGcIg4waWJkHacOQHoadPZrfpTB8d3GkP7TeXkjHF/QZxJNR/S
	hizaiEDe3HDqQfjI4J73gf1PCx7Yc2M=
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 12 May 2026 08:56:52 +0200
Subject: [PATCH batadv v2] batman-adv: extract netdev wifi detection
 information object
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-hardif-wifi-cache-v2-1-8127ff56a4e5@narfation.org>
X-B4-Tracking: v=1; b=H4sIADTPAmoC/31Oyw6CMBD8FbJna1oi+Dj5H4bD0m7pegCzrVVD+
 HcL3s2cZjKvGSIJU4RLNYNQ5sjTWEi9q8AGHAdS7AqHWtetboxWAcWxVy/2rCzaQEoftCk4aaQ
 jlNxDyPN767xBjwldhu6nx2d/J5vWwtUZOKZJPtt4Npv/z042yqjWWWqI2l7783VE8ZjK4/0kA
 3TLsnwBwa7X99AAAAA=
X-Change-ID: 20260510-hardif-wifi-cache-040101080ae7
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=16018; i=sven@narfation.org;
 h=from:subject:message-id; bh=bdI8VKz3ZoPdUaSIAufQtRvSaXm/sd678W2tOEe/skQ=;
 b=kA0DAAoWTQ93K9MU9csByyZiAGoCzzWhdvIlBItB3DYkvRljQ2SeXDlxI8iFirYBKSHsNDVjQ
 4h1BAAWCgAdFiEEvNRvz7MH7R/zlvHFTQ93K9MU9csFAmoCzzUACgkQTQ93K9MU9cuGmgEA50wo
 UAKNx87bXFlKPBCETapiQGwbZ4DOJNPrOYIQDQsBAKtyjI+vxxmS2rwR2txeDer2hF8An+ULI+E
 dM33KhRYG
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: ZXQNBFJYIHM546DJAMDB3VGXNVQIIPPP
X-Message-ID-Hash: ZXQNBFJYIHM546DJAMDB3VGXNVQIIPPP
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/ZXQNBFJYIHM546DJAMDB3VGXNVQIIPPP/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Previously, wifi_flags were stored directly in batadv_hard_iface, which is
created for every network interface on the system (including those never
attached to a mesh interface). This wastes memory and complicates the
long-term goal of lazily allocating batadv_hard_iface only for interfaces
that actually join a mesh.

The problem is that several batman-adv features need wifi detection for
net_devices (and their underlying devices) regardless of whether a
batadv_hard_iface exists for them:

* B.A.T.M.A.N. IV TQ hop penalty calculation
* B.A.T.M.A.N. V ELP probing / throughput estimation
* AP isolation

To decouple wifi detection from batadv_hard_iface lifetime, introduce a
global rhashtable (batadv_wifi_net_devices) mapping net_device pointers to
batadv_wifi_net_device_state objects. Only net_devices that are actually
detected as (indirect) wifi interfaces occupy an entry, keeping the common
(non-wifi) case allocation-free.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
Changes in v2:
- clean the already allocated workqueue on batadv_wifi_net_devices_init()
  fail
- Add explicit batadv_wifi_net_devices_deinit()
- Link to v1: https://patch.msgid.link/20260510-hardif-wifi-cache-v1-1-6dce5ee6b0f9@narfation.org
---
 net/batman-adv/bat_v_elp.c      |   6 +-
 net/batman-adv/hard-interface.c | 189 +++++++++++++++++++++++++++++++++++++---
 net/batman-adv/hard-interface.h |  34 +++++++-
 net/batman-adv/main.c           |  17 +++-
 net/batman-adv/types.h          |  30 +++++--
 5 files changed, 251 insertions(+), 25 deletions(-)

diff --git a/net/batman-adv/bat_v_elp.c b/net/batman-adv/bat_v_elp.c
index fdc2abe9..e207093d 100644
--- a/net/batman-adv/bat_v_elp.c
+++ b/net/batman-adv/bat_v_elp.c
@@ -85,6 +85,7 @@ static bool batadv_v_elp_get_throughput(struct batadv_hardif_neigh_node *neigh,
 	struct ethtool_link_ksettings link_settings;
 	struct net_device *real_netdev;
 	struct station_info sinfo;
+	u32 wifi_flags;
 	u32 throughput;
 	int ret;
 
@@ -106,8 +107,9 @@ static bool batadv_v_elp_get_throughput(struct batadv_hardif_neigh_node *neigh,
 	/* if this is a wireless device, then ask its throughput through
 	 * cfg80211 API
 	 */
-	if (batadv_is_wifi_hardif(hard_iface)) {
-		if (!batadv_is_cfg80211_hardif(hard_iface))
+	wifi_flags = batadv_hardif_get_wifi_flags(hard_iface);
+	if (batadv_is_wifi(wifi_flags)) {
+		if (!batadv_is_cfg80211(wifi_flags))
 			/* unsupported WiFi driver version */
 			goto default_throughput;
 
diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index 4b3804ef..ca9f5c37 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -26,6 +26,8 @@
 #include <linux/notifier.h>
 #include <linux/printk.h>
 #include <linux/rculist.h>
+#include <linux/rhashtable-types.h>
+#include <linux/rhashtable.h>
 #include <linux/rtnetlink.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
@@ -43,6 +45,15 @@
 #include "send.h"
 #include "translation-table.h"
 
+static const struct rhashtable_params batadv_wifi_net_devices_params = {
+	.key_len		= sizeof(struct net_device *),
+	.key_offset		= offsetof(struct batadv_wifi_net_device_state, netdev),
+	.head_offset		= offsetof(struct batadv_wifi_net_device_state, l),
+	.automatic_shrinking	= true,
+};
+
+static struct rhashtable batadv_wifi_net_devices;
+
 /**
  * batadv_hardif_release() - release hard interface from lists and queue for
  *  free after rcu grace period
@@ -356,21 +367,28 @@ static u32 batadv_wifi_flags_evaluate(struct net_device *net_device)
 }
 
 /**
- * batadv_is_cfg80211_hardif() - check if the given hardif is a cfg80211 wifi
- *  interface
+ * batadv_hardif_get_wifi_flags() - retrieve wifi flags for hard_iface
  * @hard_iface: the device to check
  *
- * Return: true if the net device is a cfg80211 wireless device, false
- *  otherwise.
+ * Return: batadv_hard_iface_wifi_flags flags of the device
  */
-bool batadv_is_cfg80211_hardif(struct batadv_hard_iface *hard_iface)
+u32 batadv_hardif_get_wifi_flags(struct batadv_hard_iface *hard_iface)
 {
-	u32 allowed_flags = 0;
+	struct batadv_wifi_net_device_state *device_state;
+	u32 wifi_flags = 0;
 
-	allowed_flags |= BATADV_HARDIF_WIFI_CFG80211_DIRECT;
-	allowed_flags |= BATADV_HARDIF_WIFI_CFG80211_INDIRECT;
+	if (!hard_iface)
+		return 0;
 
-	return !!(hard_iface->wifi_flags & allowed_flags);
+	rcu_read_lock();
+	device_state = rhashtable_lookup_fast(&batadv_wifi_net_devices,
+					      &hard_iface->net_dev,
+					      batadv_wifi_net_devices_params);
+	if (device_state)
+		wifi_flags = READ_ONCE(device_state->wifi_flags);
+	rcu_read_unlock();
+
+	return wifi_flags;
 }
 
 /**
@@ -381,10 +399,9 @@ bool batadv_is_cfg80211_hardif(struct batadv_hard_iface *hard_iface)
  */
 bool batadv_is_wifi_hardif(struct batadv_hard_iface *hard_iface)
 {
-	if (!hard_iface)
-		return false;
+	u32 wifi_flags = batadv_hardif_get_wifi_flags(hard_iface);
 
-	return hard_iface->wifi_flags != 0;
+	return batadv_is_wifi(wifi_flags);
 }
 
 /**
@@ -890,7 +907,6 @@ batadv_hardif_add_interface(struct net_device *net_dev)
 	kref_init(&hard_iface->refcount);
 
 	hard_iface->num_bcasts = BATADV_NUM_BCASTS_DEFAULT;
-	hard_iface->wifi_flags = batadv_wifi_flags_evaluate(net_dev);
 	if (batadv_is_wifi_hardif(hard_iface))
 		hard_iface->num_bcasts = BATADV_NUM_BCASTS_WIRELESS;
 
@@ -942,6 +958,131 @@ static int batadv_hard_if_event_meshif(unsigned long event,
 	return NOTIFY_DONE;
 }
 
+/**
+ * batadv_wifi_net_device_insert() - save information about wifi net_device
+ * @net_dev: net_device to add to batadv_wifi_net_devices
+ * @wifi_flags: net_device which generated an event
+ *
+ * Return: 0 on result, negative value on error
+ */
+static int
+batadv_wifi_net_device_insert(struct net_device *net_dev, u32 wifi_flags)
+{
+	struct batadv_wifi_net_device_state *device_state;
+	int ret;
+
+	ASSERT_RTNL();
+
+	device_state = kzalloc_obj(*device_state, GFP_ATOMIC);
+	if (!device_state)
+		return -ENOMEM;
+
+	device_state->wifi_flags = wifi_flags;
+	netdev_hold(net_dev, &device_state->dev_tracker, GFP_ATOMIC);
+	device_state->netdev = net_dev;
+	WRITE_ONCE(device_state->wifi_flags, wifi_flags);
+
+	ret = rhashtable_insert_fast(&batadv_wifi_net_devices, &device_state->l,
+				     batadv_wifi_net_devices_params);
+	if (ret < 0)
+		goto err_free;
+
+	return 0;
+
+err_free:
+	netdev_put(device_state->netdev, &device_state->dev_tracker);
+	kfree(device_state);
+	return ret;
+}
+
+/**
+ * batadv_wifi_net_device_remove() - remove information about wifi net_device
+ * @device_state: wifi net_device state to remove from batadv_wifi_net_device_state
+ */
+static void
+batadv_wifi_net_device_remove(struct batadv_wifi_net_device_state *device_state)
+{
+	ASSERT_RTNL();
+
+	rhashtable_remove_fast(&batadv_wifi_net_devices, &device_state->l,
+			       batadv_wifi_net_devices_params);
+	netdev_put(device_state->netdev, &device_state->dev_tracker);
+	kfree_rcu(device_state, rcu);
+}
+
+/**
+ * batadv_wifi_net_device_update() - update wifi state of net_device
+ * @net_dev: net_device to update in batadv_wifi_net_devices
+ *
+ * The device will only be stored in batadv_wifi_net_devices when
+ * it could be identified as wifi device. If the net_device is no
+ * longer a wifi device, it is automatically removed from
+ * batadv_wifi_net_devices.
+ */
+static void
+batadv_wifi_net_device_update(struct net_device *net_dev)
+{
+	struct batadv_wifi_net_device_state *device_state;
+	u32 wifi_flags;
+
+	ASSERT_RTNL();
+
+	wifi_flags = batadv_wifi_flags_evaluate(net_dev);
+	device_state = rhashtable_lookup_fast(&batadv_wifi_net_devices,
+					      &net_dev,
+					      batadv_wifi_net_devices_params);
+
+	if (device_state) {
+		if (batadv_is_wifi(wifi_flags))
+			WRITE_ONCE(device_state->wifi_flags, wifi_flags);
+		else
+			batadv_wifi_net_device_remove(device_state);
+	} else if (batadv_is_wifi(wifi_flags)) {
+		batadv_wifi_net_device_insert(net_dev, wifi_flags);
+	}
+}
+
+/**
+ * batadv_wifi_net_device_unregister() - remove wifi state of net_device
+ * @net_dev: net_device to remove from batadv_wifi_net_devices
+ */
+static void
+batadv_wifi_net_device_unregister(struct net_device *net_dev)
+{
+	struct batadv_wifi_net_device_state *device_state;
+
+	ASSERT_RTNL();
+
+	device_state = rhashtable_lookup_fast(&batadv_wifi_net_devices,
+					      &net_dev,
+					      batadv_wifi_net_devices_params);
+	if (!device_state)
+		return;
+
+	batadv_wifi_net_device_remove(device_state);
+}
+
+/**
+ * batadv_wifi_net_device_event() - handle network events for batadv_wifi_net_devices
+ * @event: enum netdev_cmd event to handle
+ * @net_dev: net_device to update in batadv_wifi_net_devices
+ */
+static void batadv_wifi_net_device_event(unsigned long event,
+					 struct net_device *net_dev)
+{
+	switch (event) {
+	case NETDEV_REGISTER:
+	case NETDEV_POST_TYPE_CHANGE:
+	case NETDEV_CHANGEUPPER:
+		batadv_wifi_net_device_update(net_dev);
+		break;
+	case NETDEV_UNREGISTER:
+	case NETDEV_PRE_TYPE_CHANGE:
+		batadv_wifi_net_device_unregister(net_dev);
+		break;
+	}
+}
+
 static int batadv_hard_if_event(struct notifier_block *this,
 				unsigned long event, void *ptr)
 {
@@ -953,6 +1094,8 @@ static int batadv_hard_if_event(struct notifier_block *this,
 	if (batadv_meshif_is_valid(net_dev))
 		return batadv_hard_if_event_meshif(event, net_dev);
 
+	batadv_wifi_net_device_event(event, net_dev);
+
 	hard_iface = batadv_hardif_get_by_netdev(net_dev);
 	if (!hard_iface && (event == NETDEV_REGISTER ||
 			    event == NETDEV_POST_TYPE_CHANGE))
@@ -996,8 +1139,9 @@ static int batadv_hard_if_event(struct notifier_block *this,
 		if (hard_iface == primary_if)
 			batadv_primary_if_update_addr(bat_priv, NULL);
 		break;
+	case NETDEV_REGISTER:
+	case NETDEV_POST_TYPE_CHANGE:
 	case NETDEV_CHANGEUPPER:
-		hard_iface->wifi_flags = batadv_wifi_flags_evaluate(net_dev);
 		if (batadv_is_wifi_hardif(hard_iface))
 			hard_iface->num_bcasts = BATADV_NUM_BCASTS_WIRELESS;
 		break;
@@ -1015,3 +1159,20 @@ static int batadv_hard_if_event(struct notifier_block *this,
 struct notifier_block batadv_hard_if_notifier = {
 	.notifier_call = batadv_hard_if_event,
 };
+
+/**
+ * batadv_wifi_net_devices_init() - Initialize wifi devices cache
+ */
+int __init batadv_wifi_net_devices_init(void)
+{
+	return rhashtable_init(&batadv_wifi_net_devices,
+			       &batadv_wifi_net_devices_params);
+}
+
+/**
+ * batadv_wifi_net_devices_deinit() - Deinitialize wifi devices cache
+ */
+void batadv_wifi_net_devices_deinit(void)
+{
+	rhashtable_destroy(&batadv_wifi_net_devices);
+}
diff --git a/net/batman-adv/hard-interface.h b/net/batman-adv/hard-interface.h
index 9ba8fb2b..089e65c8 100644
--- a/net/batman-adv/hard-interface.h
+++ b/net/batman-adv/hard-interface.h
@@ -10,6 +10,7 @@
 #include "main.h"
 
 #include <linux/compiler.h>
+#include <linux/init.h>
 #include <linux/kref.h>
 #include <linux/netdevice.h>
 #include <linux/rcupdate.h>
@@ -69,7 +70,7 @@ extern struct notifier_block batadv_hard_if_notifier;
 
 struct net_device *__batadv_get_real_netdev(struct net_device *net_device);
 struct net_device *batadv_get_real_netdev(struct net_device *net_device);
-bool batadv_is_cfg80211_hardif(struct batadv_hard_iface *hard_iface);
+u32 batadv_hardif_get_wifi_flags(struct batadv_hard_iface *hard_iface);
 bool batadv_is_wifi_hardif(struct batadv_hard_iface *hard_iface);
 struct batadv_hard_iface*
 batadv_hardif_get_by_netdev(const struct net_device *net_dev);
@@ -81,6 +82,8 @@ void batadv_update_min_mtu(struct net_device *mesh_iface);
 void batadv_hardif_release(struct kref *ref);
 int batadv_hardif_no_broadcast(struct batadv_hard_iface *if_outgoing,
 			       u8 *orig_addr, u8 *orig_neigh);
+int __init batadv_wifi_net_devices_init(void);
+void batadv_wifi_net_devices_deinit(void);
 
 /**
  * batadv_hardif_put() - decrement the hard interface refcounter and possibly
@@ -119,4 +122,33 @@ batadv_primary_if_get_selected(struct batadv_priv *bat_priv)
 	return hard_iface;
 }
 
+/**
+ * batadv_is_cfg80211() - check if the given hardif is a cfg80211
+ *  wifi interface
+ * @wifi_flags: extracted batadv_hard_iface_wifi_flagss of an net_device
+ *
+ * Return: true if the net device is a cfg80211 wireless device, false
+ *  otherwise.
+ */
+static inline bool batadv_is_cfg80211(u32 wifi_flags)
+{
+	u32 allowed_flags = 0;
+
+	allowed_flags |= BATADV_HARDIF_WIFI_CFG80211_DIRECT;
+	allowed_flags |= BATADV_HARDIF_WIFI_CFG80211_INDIRECT;
+
+	return !!(wifi_flags & allowed_flags);
+}
+
+/**
+ * batadv_is_wifi() - check if flags belong to wifi interface
+ * @wifi_flags: extracted batadv_hard_iface_wifi_flagss of an net_device
+ *
+ * Return: true if the net device is a 802.11 wireless device, false otherwise.
+ */
+static inline bool batadv_is_wifi(u32 wifi_flags)
+{
+	return wifi_flags != 0;
+}
+
 #endif /* _NET_BATMAN_ADV_HARD_INTERFACE_H_ */
diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index a4d33ee0..8c2f1dfb 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -104,8 +104,14 @@ static int __init batadv_init(void)
 	batadv_tp_meter_init();
 
 	batadv_event_workqueue = create_singlethread_workqueue("bat_events");
-	if (!batadv_event_workqueue)
+	if (!batadv_event_workqueue) {
+		ret = -ENOMEM;
 		goto err_create_wq;
+	}
+
+	ret = batadv_wifi_net_devices_init();
+	if (ret < 0)
+		goto err_init_wifi;
 
 	register_netdevice_notifier(&batadv_hard_if_notifier);
 	rtnl_link_register(&batadv_link_ops);
@@ -116,10 +122,15 @@ static int __init batadv_init(void)
 
 	return 0;
 
+err_init_wifi:
+	destroy_workqueue(batadv_event_workqueue);
+	batadv_event_workqueue = NULL;
+	rcu_barrier();
+
 err_create_wq:
 	batadv_tt_cache_destroy();
 
-	return -ENOMEM;
+	return ret;
 }
 
 static void __exit batadv_exit(void)
@@ -131,6 +142,8 @@ static void __exit batadv_exit(void)
 	destroy_workqueue(batadv_event_workqueue);
 	batadv_event_workqueue = NULL;
 
+	batadv_wifi_net_devices_deinit();
+
 	rcu_barrier();
 
 	batadv_tt_cache_destroy();
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index daa06f42..4b659c05 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -21,6 +21,7 @@
 #include <linux/mutex.h>
 #include <linux/netdevice.h>
 #include <linux/netlink.h>
+#include <linux/rhashtable-types.h>
 #include <linux/sched.h> /* for linux/wait.h */
 #include <linux/skbuff.h>
 #include <linux/spinlock.h>
@@ -163,6 +164,29 @@ enum batadv_hard_iface_wifi_flags {
 	BATADV_HARDIF_WIFI_CFG80211_INDIRECT = BIT(3),
 };
 
+/**
+ * struct batadv_wifi_net_device_state - cache of wifi information of net_devices
+ */
+struct batadv_wifi_net_device_state {
+	/** @l: anchor in rhashtable */
+	struct rhash_head l;
+
+	/** @netdev: pointer to the net_device */
+	struct net_device *netdev;
+
+	/** @dev_tracker: device tracker for @netdev */
+	netdevice_tracker dev_tracker;
+
+	/**
+	 * @wifi_flags: flags whether this is (directly or indirectly) a wifi
+	 *  interface
+	 */
+	u32 wifi_flags;
+
+	/** @rcu: struct used for freeing in an RCU-safe manner */
+	struct rcu_head rcu;
+};
+
 /**
  * struct batadv_hard_iface - network device known to batman-adv
  */
@@ -178,12 +202,6 @@ struct batadv_hard_iface {
 	 */
 	u8 num_bcasts;
 
-	/**
-	 * @wifi_flags: flags whether this is (directly or indirectly) a wifi
-	 *  interface
-	 */
-	u32 wifi_flags;
-
 	/** @net_dev: pointer to the net_device */
 	struct net_device *net_dev;
 

---
base-commit: f876964b732393119a036ff1ce7a1c94290b09ed
change-id: 20260510-hardif-wifi-cache-040101080ae7

Best regards,
--  
Sven Eckelmann <sven@narfation.org>

