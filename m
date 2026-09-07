Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 727ECC79F9E
	for <batman-adv@archiver.kernel.org>; Mon,  7 Sep 2026 08:19:19 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id DDCE884262
	for <batman-adv@archiver.kernel.org>; Mon, 07 Sep 2026 10:19:17 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1788769157;
 b=ffkR8BfTeqvKJWnwQebvN2Ao0f9Mxfm7dxadzHIWEeSFeVtWieC/9FXMevTt70qL1XuGR
 vQkJ1VN3rmbhUQq6d1ogh8z9UbAMZKNgvRNkns1/Sf8Nb5Xhy8V/f9j7it/3dzqYkGORtyV
 PEiOMITGrDBSq0eFPW9u7iUyltC9t3k=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1788769157; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=PosylnRdopBGGbUx4+CxBeYiMFQkzo2EZ1jdqvLtlIk=;
 b=UHgM/P3Q8JRmKIy6rps/qmEeAI8FP418kV/APHL+b7rlvq44Nlf7TgQajIWtjGQDVf8NX
 bJy4DSJMp/dzOMXMafRIWqqcvseqvL0iOm5Q9ZIc+osCmxkI7mZWwKEwYyjTYNW3m5sWWVH
 pfMqAq1w/IdALJvBKsgtDWCAjIp24H8=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 777C980888
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 07 Sep 2026 10:18:37 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1788769117;
	b=hoNIXfrvUozk+as5/htD4WwT8K53e+ZAAi3qg5Tspg0hFpR+CTFitBp24Vs5Q3+M3o2wT/
	FiMAKavdzRMPunSQRtU7qIvgKVsv0Jt0TbxKKDfIQ76c9jnaiIe4RJ0+5AyVhXqU1Rg0bS
	aEhU4joQYhssT9+TAFZS2lEhscdURG0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1788769117;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=PosylnRdopBGGbUx4+CxBeYiMFQkzo2EZ1jdqvLtlIk=;
	b=dGVcHUnKMsFrPo9dvmjvYQCKVHAfvK2g8ghHYbZha1Ay80BI5KNoM6F4bYcoumHH8pGQ+f
	PE7nUOMpTXCYWKWxavBJmV6IvuMTeSCs8S+cePEnWwir9khsylN8Fph7J6vyN6sd5wiFoo
	9mhO1gqU1252C3HtcIqofuXZxDh4Kyg=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b="RaceJ/Mt";
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 23.88.38.48 as permitted sender) smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
Received: from kero.packetmixer.de
 (p200300C59748D0d8C3747188E6DFE6c0.dip0.t-ipconnect.de
 [IPv6:2003:c5:9748:d0d8:c374:7188:e6df:e6c0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with UTF8SMTPSA id 76A18FA039;
	Mon, 07 Sep 2026 10:18:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1788769106;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PosylnRdopBGGbUx4+CxBeYiMFQkzo2EZ1jdqvLtlIk=;
	b=RaceJ/MtCpQ9FxDp0co5fyGxRc6GljIG2OMNq9amuStL0VaK0PTzmSj38uD2SN3C/nm2Id
	HJ2EDZSTCb2cQ7RttsKDIz9Q+n5J6lZdRaloP6vJvGi80HFda4PIavlZ6lGUKlNbCD7uT0
	VCm4Bpsd6+zmX6WgOBgGddAbOC0zwUHqe+dnW3Jvs3iWphNVpJXRwTNNezQTiPPPWghAoZ
	h9O91i5VvnZQRsmOkpnNuYMe5CweTq9vXbhh0ED2e1kU2wHjG1qrkAsW4WDYMhjWl8omGD
	Bviz8yzdq3BDjpQIkMA5V1L7c7EcQriFDpmPEkesw/LxglKzUeWkUUCuvuH3Gw==
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
Subject: [PATCH net-next 01/15] batman-adv: tt: look up wifi state of incoming
 interface in helper
Date: Mon,  7 Sep 2026 10:18:10 +0200
Message-ID: <20260907081824.2474040-2-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260907081824.2474040-1-sw@simonwunderlich.de>
References: <20260907081824.2474040-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: 56QBTMZTKPV5NMFRYEQ5CDASWGR5MCY5
X-Message-ID-Hash: 56QBTMZTKPV5NMFRYEQ5CDASWGR5MCY5
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/56QBTMZTKPV5NMFRYEQ5CDASWGR5MCY5/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Sven Eckelmann <sven@narfation.org>

batadv_tt_local_add() only needs to know whether the client was seen on a
wifi interface. But it kept the net_device reference of the incoming
interface alive until its own cleanup section, together with a "net" and an
"in_dev" variable which are of no interest to the rest of the function.

Move the lookup to a small helper which acquires and releases the
net_device reference itself.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/translation-table.c | 41 +++++++++++++++++++++---------
 1 file changed, 29 insertions(+), 12 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 44a8cf89382c6..1c22db348267e 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -41,6 +41,7 @@
 #include <linux/string.h>
 #include <linux/workqueue.h>
 #include <net/genetlink.h>
+#include <net/net_namespace.h>
 #include <net/netlink.h>
 #include <uapi/linux/batadv_packet.h>
 #include <uapi/linux/batman_adv.h>
@@ -693,6 +694,32 @@ static void batadv_tt_local_add_roam(struct batadv_priv *bat_priv,
 		batadv_tt_global_free(bat_priv, tt_global, "Roaming canceled");
 }
 
+/**
+ * batadv_tt_iif_is_wifi() - check whether a client is connected via wifi
+ * @net: namespace to search the incoming interface in
+ * @ifindex: index of the interface where the client is connected to
+ *
+ * Return: true if @ifindex refers to a wifi interface, false otherwise (which
+ * includes the case of an unknown or missing incoming interface).
+ */
+static bool batadv_tt_iif_is_wifi(struct net *net, int ifindex)
+{
+	struct net_device *in_dev;
+	u32 wifi_flags;
+
+	if (ifindex == BATADV_NULL_IFINDEX)
+		return false;
+
+	in_dev = dev_get_by_index(net, ifindex);
+	if (!in_dev)
+		return false;
+
+	wifi_flags = batadv_netdev_get_wifi_flags(in_dev);
+	dev_put(in_dev);
+
+	return batadv_is_wifi(wifi_flags);
+}
+
 /**
  * batadv_tt_local_add() - add a new client to the local table or update an
  *  existing client
@@ -712,12 +739,10 @@ bool batadv_tt_local_add(struct net_device *mesh_iface, const u8 *addr,
 	struct batadv_priv *bat_priv = netdev_priv(mesh_iface);
 	struct batadv_tt_global_entry *tt_global = NULL;
 	struct batadv_tt_local_entry *tt_local;
-	struct net *net = dev_net(mesh_iface);
-	struct net_device *in_dev = NULL;
 	struct batadv_meshif_vlan *vlan;
 	bool roamed_back = false;
-	bool iif_is_wifi = false;
 	int packet_size_max;
+	bool iif_is_wifi;
 	bool ret = false;
 	u8 remote_flags;
 	int hash_added;
@@ -725,14 +750,7 @@ bool batadv_tt_local_add(struct net_device *mesh_iface, const u8 *addr,
 	u32 match_mark;
 	bool modified;
 
-	if (ifindex != BATADV_NULL_IFINDEX)
-		in_dev = dev_get_by_index(net, ifindex);
-
-	if (in_dev) {
-		u32 wifi_flags = batadv_netdev_get_wifi_flags(in_dev);
-
-		iif_is_wifi = batadv_is_wifi(wifi_flags);
-	}
+	iif_is_wifi = batadv_tt_iif_is_wifi(dev_net(mesh_iface), ifindex);
 
 	tt_local = batadv_tt_local_hash_find(bat_priv, addr, vid);
 
@@ -881,7 +899,6 @@ bool batadv_tt_local_add(struct net_device *mesh_iface, const u8 *addr,
 
 	ret = true;
 out:
-	dev_put(in_dev);
 	batadv_tt_local_entry_put(tt_local);
 	batadv_tt_global_entry_put(tt_global);
 	return ret;
-- 
2.47.3

