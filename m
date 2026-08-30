Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2010BC61DE1
	for <batman-adv@archiver.kernel.org>; Sun, 30 Aug 2026 15:26:57 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 933108039A
	for <batman-adv@archiver.kernel.org>; Sun, 30 Aug 2026 17:26:55 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1788103615;
 b=BM5HI2FYDxJUzmh7A3IvUqJuvP1pzhZ3Y9Xpaj51UJPfvgyb0QATTuz/X/BUMAAaOASAa
 zSptoMz4oxuj6oIC5WsIj5mpH6SdjtdudWgPomkSdb84shA0tsDanySH5UkoN/Jg5Lk7i5e
 bZJ59dChbnu02WCYqc1YBjGRNCPFLxI=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1788103615; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=MlmijC1VlrDVxaFXGeVWeAMr7GGVmrNKuAA8bJBzgGY=;
 b=x86mBWKubETSgYTbZBe9MiU6mbMVbNC90vSho8l+b+9JGyKvf5JNtIuDF5mGm9ViEsHiv
 AVhI43Rwb971itKyMxPDrC4MCbXDlI/A1Fy93qt60aRGZBOb1Mt8ORLlqTJ+cOpLOihxtrP
 Glz6ASSZ7a8ePhEDuVl/k+5WF2XLqVM=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id B5B52803FF
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 30 Aug 2026 17:22:30 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1788103350;
	b=nziybKK55+F5G7UoN8gyuBn151WktQhPN6pTOxkCD8yHcnPMg8uPEkqV8ALbf4XJ/P5cv4
	Ahx4p+6nt43rtThBccGTbvaJpU66RzX+m+TSjDO3/mYhHEFMJLKn0qp/WUZrOnsl7LcQ4x
	Jol5Zkpwr+tfM5n1APTcAsC8KaZ92IQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1788103350;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=MlmijC1VlrDVxaFXGeVWeAMr7GGVmrNKuAA8bJBzgGY=;
	b=j6LrMcPqt9Ke7WWhvDlT4XE2DdutCMAhwOrQvioV7zScRNIdP3g6ScZkiRK0Vld6wjuASH
	9rnI/sTHWnbtGmXzpdMjPSQMI9pBbVI0KEG1V0dRHMjr0K9ONShNSlqJMQcd5g5H9KX1xy
	2hz3Oa9NG3NkAaDpa5WD1581nav2Q0s=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=fSLbRxg+;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 437A920131;
	Sun, 30 Aug 2026 15:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1788103346;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MlmijC1VlrDVxaFXGeVWeAMr7GGVmrNKuAA8bJBzgGY=;
	b=fSLbRxg+BR3JceBL0AlKLijnBVcZpXZw1W6dv7L/bBRvlSvdazLM1o3UTjSRHftMt1ysDi
	5l+td0hPp634o7FSnsAniNT5VTPjpVZJh8QuVoMCclHeJb0IqVUQVxl9pvq6M/GVWQlIFE
	lAePeTBwZJ6wd6x4AUKDsG2A6Hc4HR4=
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 30 Aug 2026 17:21:46 +0200
Subject: [PATCH batadv v6 09/20] batman-adv: tt: look up wifi state of
 incoming interface in helper
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260830-tt-fixes-v6-9-a56568a15041@narfation.org>
References: <20260830-tt-fixes-v6-0-a56568a15041@narfation.org>
In-Reply-To: <20260830-tt-fixes-v6-0-a56568a15041@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3327; i=sven@narfation.org;
 h=from:subject:message-id; bh=XSCtYgNzwfL1IwmcBHFKmwOIkB5oJrmBXL44Ckjg0xY=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFlTvNqqTjkGbayRWL6oR/zy1qnz9t+aXcHozKReUJ6sx
 G72hJO7o5SFQYyLQVZMkWXPlfzzm9nfyn+e9vEozBxWJpAhDFycAjCRJ8WMDBeP22X4FEo9u7t/
 fpMPkyfXhlMFddvFfz45Z3c0tfTQFHOG/3EegqV9r79XCAeVNx2sapxxRmUdy6sXJh43m2yON7K
 85gUA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: X2EGT2QPOR3NWARVDON4IG3XGHAYZUP7
X-Message-ID-Hash: X2EGT2QPOR3NWARVDON4IG3XGHAYZUP7
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/X2EGT2QPOR3NWARVDON4IG3XGHAYZUP7/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

batadv_tt_local_add() only needs to know whether the client was seen on a
wifi interface. But it kept the net_device reference of the incoming
interface alive until its own cleanup section, together with a "net" and an
"in_dev" variable which are of no interest to the rest of the function.

Move the lookup to a small helper which acquires and releases the
net_device reference itself.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/translation-table.c | 41 +++++++++++++++++++++++++++-----------
 1 file changed, 29 insertions(+), 12 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 2bd0362e..3b76d1f7 100644
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
@@ -746,6 +747,32 @@ static void batadv_tt_local_add_roam(struct batadv_priv *bat_priv,
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
@@ -765,12 +792,10 @@ bool batadv_tt_local_add(struct net_device *mesh_iface, const u8 *addr,
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
@@ -778,14 +803,7 @@ bool batadv_tt_local_add(struct net_device *mesh_iface, const u8 *addr,
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
 
@@ -934,7 +952,6 @@ bool batadv_tt_local_add(struct net_device *mesh_iface, const u8 *addr,
 
 	ret = true;
 out:
-	dev_put(in_dev);
 	batadv_tt_local_entry_put(tt_local);
 	batadv_tt_global_entry_put(tt_global);
 	return ret;

-- 
2.47.3

