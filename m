Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CFFAC61DBE
	for <batman-adv@archiver.kernel.org>; Sat, 29 Aug 2026 06:23:50 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id C2434842B5
	for <batman-adv@archiver.kernel.org>; Sat, 29 Aug 2026 08:23:48 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1787984628;
 b=LJT1duOhBEe8WccHWNA94aD910jRc67ExhTHISTLlB8lBCEwFb7GqPdbz8b8SF6S1/YFA
 DvqKjDnJ79iwWnPKsE3MVL5sWaNG5RW2PjCJ/KLVdqSHp9FRfEncyM3YJFGFfBdc0fRv4yj
 aOQX11p8puJEnsalPtujoh8q2g3REd8=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1787984628; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=fqf8ii4iuD2l1/UGCSh9nIuzzupDQj6ybsLs8b6n4Qs=;
 b=2qKl1uP0svLhQCpdKBBK/oY/xH14qlV9/wpuxOGUvb0pZd7g0YhZ1Lc+N+bVov8yopXN2
 P765/g+Z4ntMqYIOevbShG58nNtYwd/KBFSl1UWjE5RXIku4wt77v2GHQ22X7v1MWr2Npvx
 Efrfhymb069IQkkg76amFa8ammmpFok=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 6D0F5841F4
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sat, 29 Aug 2026 08:20:35 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1787984435;
	b=2GzNhrW9/3+vRlPZCMJbfdpQyXXdi0i/3Mc6sWminn4rD+X7ODiQC1wsfpZTHTXXnWjMyd
	dD7IUz/P+2IpCHgWx9C/kvEjSM+T/LayuByhpd8ryhMHahiBZcobYk38m7AUjG9QdaBehh
	iQb+17/V/rCZAGAPEj8QFqZRMnRidI4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1787984435;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=fqf8ii4iuD2l1/UGCSh9nIuzzupDQj6ybsLs8b6n4Qs=;
	b=1e6/c8+Q9n4TohtKHVAKpXdoDIR+wjrH2KbwqO7yP5lnkt1dtKroUqUEneRog9OynaKK0P
	oicwCRoy5zXoiQ7DVEZODLkfFoc4hQkMv7HLo+bOK4rE8DTT0pJGHDP6IwqEmoAt2GkYmS
	/vZYXFrGkCnX7cVclvg+D/dqBhzQvro=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=ZqQOzkgH;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id F33BD1FEC4;
	Sat, 29 Aug 2026 06:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1787984431;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fqf8ii4iuD2l1/UGCSh9nIuzzupDQj6ybsLs8b6n4Qs=;
	b=ZqQOzkgHC1uvAn3k46/TJYGxwV2lMg+bgOz5InYNrFINvkyFIw9t2dOWQosgNR7lYIwbg/
	Jn3PlgRMu8n2xXDZdTxmKa+6B/GEn0eCDwsIC8DfRx587kTXmM7JfqFX887m0vNDBwAkIu
	j+wgDGrepgg1/bCrS2XjEiH03Cb/8V0=
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 29 Aug 2026 08:18:20 +0200
Subject: [PATCH batadv v5 09/20] batman-adv: tt: look up wifi state of
 incoming interface in helper
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260829-tt-fixes-v5-9-88fce8fd683d@narfation.org>
References: <20260829-tt-fixes-v5-0-88fce8fd683d@narfation.org>
In-Reply-To: <20260829-tt-fixes-v5-0-88fce8fd683d@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3327; i=sven@narfation.org;
 h=from:subject:message-id; bh=yUBo56PNmO4dZY3Evfho9qNT69IxmoZXkZwLPHZzZkw=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFmTKtd0Pvyore3FsOzvjzeuTk8v/HgrZn/S9dryHvf0r
 8lL5rwQ7ChlYRDjYpAVU2TZcyX//Gb2t/Kfp308CjOHlQlkCAMXpwBM5LgGw3+/d8ufTdly4sLU
 ACHhAoGlZx5fKRJM9V9lvYB1d9lPdW8bRob3F9Yb+sv1ZPx3y3u+xnKqucVES629sjKsDjcurV/
 yai87AA==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: GPT724NXA3WOEWI4PG3MKN4G2AUDLA4W
X-Message-ID-Hash: GPT724NXA3WOEWI4PG3MKN4G2AUDLA4W
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/GPT724NXA3WOEWI4PG3MKN4G2AUDLA4W/>
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
index 63948ee2..d040c0d3 100644
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
@@ -745,6 +746,32 @@ static void batadv_tt_local_add_roam(struct batadv_priv *bat_priv,
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
@@ -764,12 +791,10 @@ bool batadv_tt_local_add(struct net_device *mesh_iface, const u8 *addr,
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
@@ -777,14 +802,7 @@ bool batadv_tt_local_add(struct net_device *mesh_iface, const u8 *addr,
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
 
@@ -933,7 +951,6 @@ bool batadv_tt_local_add(struct net_device *mesh_iface, const u8 *addr,
 
 	ret = true;
 out:
-	dev_put(in_dev);
 	batadv_tt_local_entry_put(tt_local);
 	batadv_tt_global_entry_put(tt_global);
 	return ret;

-- 
2.47.3

