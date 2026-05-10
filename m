Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06643CD3427
	for <batman@archiver.kernel.org>; Sun, 10 May 2026 13:56:17 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 14C4485B4C
	for <batman@archiver.kernel.org>; Sun, 10 May 2026 15:56:04 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1778421364;
 b=k/O3Ed3jQ26y1DD98X7JXBilEOKJ8nk/+vltjFYMnIZeYxVZvbbCxlBKDMd1ThydBUMtL
 /JbhV+V73uXdYcjA9JZoBNXCwLMmsVTDQGz4ynZpl7CSeV3pmnf+rkEQ8I6tBK84SBCNg8E
 wYwJT/TqbyU72sJaaqkIoO8mqYaMORk=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1778421364; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=pTz8y80rai9IHFv1b5mG4B3qy5ukFxU8MnivUQvbYSU=;
 b=12xHvNEikXueGft53UpX2uwsr0Y1WkdQ//uVMvw2OrtxI7l4sFbwrgPmKBJhCUsZNZLit
 NO7af+UNHCKGGJMw7G17uVrn3bKlh2qGKxUtQ9+dO47eUXRyXdCkVd75E9RbUxJkuDWPgeN
 LDKHsZR9hox8DKj0W1e4mSDxi0HGw2s=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 7364881FC3
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 10 May 2026 15:55:28 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1778421338;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=pTz8y80rai9IHFv1b5mG4B3qy5ukFxU8MnivUQvbYSU=;
	b=tuczsITb3Nlxwd5hhiBOIBUsYEs8JC56SciW9n4KTxKBNTdjlv2bfGe8OtRs2/nXShUKeu
	VwxbEL/ccg+gcV5Ur0IW6NnxmAdRSkth4N0VZnOxRXKf6uPZFK7PCb7bOnHT7go0p+IpJ8
	EsngQMgPHkz35yJY1OXekOhSCy7dHWE=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=IEM9b2pt;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1778421338;
	b=VN08jm6wHbqn4OQ/M0WItqjXxqClyAfz9zYYpt2ep6UPUsl9VfvLHDyGVdfrZl2BNWJQsW
	jyyLjf5C3qQZRryI1cC2D3P1H1phZ4IDvBc22fGGGtDeC5JhYgXPgjv0i/hhaP+efssRVg
	+9qJ4OGU4TkwbSMGEwn7H81VPsA8M28=
Received: by dvalin.narfation.org (Postfix) id 85A0C1FEED;
	Sun, 10 May 2026 13:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1778421327;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=pTz8y80rai9IHFv1b5mG4B3qy5ukFxU8MnivUQvbYSU=;
	b=IEM9b2pt8Qdfl96xLdsXkB9YkWtiVwxaPuSzTClqzEgQomIZqDzDwiiIWGA5SHC76VzcZx
	89F9AvuZ4PNFrJ1UJRNpTCkOEFM9knVYTiTlOSTf0rlTiEdMGn8xKS/nwQ69qJrnDFtPcR
	LlIzRCr1ZSlb0x4ZvjpJ4t1I0rge92Q=
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 10 May 2026 15:55:19 +0200
Subject: [PATCH batadv] batman-adv: extract netdev wifi detection
 information object
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260510-hardif-wifi-cache-v1-1-6dce5ee6b0f9@narfation.org>
X-B4-Tracking: v=1; b=H4sIAEaOAGoC/yWMywrCMBBFf6XcdQcmxUfxV6SLaTIx46KVpFah9
 N+Nyl2dC+dsKJpNCy7NhqyrFZunCq5t4JNMNyULldFxd+KjY0qSg0V6WTTy4pMSH9jV9Sx6RvU
 eWaO9f80rRlkkrBj+f3mOd/XLN4h9/wBfnWtIfQAAAA==
X-Change-ID: 20260510-hardif-wifi-cache-040101080ae7
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=15259; i=sven@narfation.org;
 h=from:subject:message-id; bh=llR2nKs2R9odcu9+0fZ7V/MdnwrtIdrKv4zAQsizKPQ=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFkMfd6J6U2vTrv8nqacEmBp2BigKfpfedmWgwdLffokp
 jnutXvdUcrCIMbFICumyLLnSv75zexv5T9P+3gUZg4rE8gQBi5OAZiI+3qGf4r1ZYmqzBwtHHfO
 PzlwUsjquC3vj7Q5iozreBMtdB7N383IcEXlyMv25SHyt27M7N2+SSXYPU14/yPVXOMNO7tsdv7
 fzggA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: AE77BFEFHHOMQGKDDETMLQ5HLUNCTEPH
X-Message-ID-Hash: AE77BFEFHHOMQGKDDETMLQ5HLUNCTEPH
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/AE77BFEFHHOMQGKDDETMLQ5HLUNCTEPH/>
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
 net/batman-adv/bat_v_elp.c      |   6 +-
 net/batman-adv/hard-interface.c | 181 ++++++++++++++++++++++++++++++++++++----
 net/batman-adv/hard-interface.h |  33 +++++++-
 net/batman-adv/main.c           |  12 ++-
 net/batman-adv/types.h          |  30 +++++--
 5 files changed, 237 insertions(+), 25 deletions(-)

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
index 4b3804ef..40ecf280 100644
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
@@ -1015,3 +1159,12 @@ static int batadv_hard_if_event(struct notifier_block *this,
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
diff --git a/net/batman-adv/hard-interface.h b/net/batman-adv/hard-interface.h
index 9ba8fb2b..d9fbcb74 100644
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
@@ -81,6 +82,7 @@ void batadv_update_min_mtu(struct net_device *mesh_iface);
 void batadv_hardif_release(struct kref *ref);
 int batadv_hardif_no_broadcast(struct batadv_hard_iface *if_outgoing,
 			       u8 *orig_addr, u8 *orig_neigh);
+int __init batadv_wifi_net_devices_init(void);
 
 /**
  * batadv_hardif_put() - decrement the hard interface refcounter and possibly
@@ -119,4 +121,33 @@ batadv_primary_if_get_selected(struct batadv_priv *bat_priv)
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
index a4d33ee0..4514889c 100644
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
@@ -116,10 +122,12 @@ static int __init batadv_init(void)
 
 	return 0;
 
+err_init_wifi:
+	unregister_netdevice_notifier(&batadv_hard_if_notifier);
 err_create_wq:
 	batadv_tt_cache_destroy();
 
-	return -ENOMEM;
+	return ret;
 }
 
 static void __exit batadv_exit(void)
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

