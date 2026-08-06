Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38219C56208
	for <batman-adv@archiver.kernel.org>; Thu,  6 Aug 2026 09:45:36 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 772D884257
	for <batman-adv@archiver.kernel.org>; Thu, 06 Aug 2026 11:45:34 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1786009534;
 b=oonKce1ObA85fVNJqlkr4rQlNusqUDeDUfkkNeBM97UkxZaotzYE39WZtEUDb2VGQUw2p
 8SjBNVdcaF+gVrK/jwfmuN7PUxofdDpJN2TtOx1C6daKx7QJYL4YxVv92+QKlbJ4V+lcsWE
 RI/D+Qld5lYUqsNChpHQlIdMTdtzIPw=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1786009534; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=fqf8ii4iuD2l1/UGCSh9nIuzzupDQj6ybsLs8b6n4Qs=;
 b=UeQnTmB7/qKOm5l2W/6GBbV3YpTX0uOlU/rncmwKeHULydtAKEvNPogRYXhns3iZYldGW
 bxkKehwxtHO3etP0ZmNjyP60ZCnB+t7Qz6mW50nrkvhK9DhtIgE9ENnZAiuJHyWZ6Gb8+jY
 VhqhjFLj+NkGTwdPHyI5w6+lG41p+zE=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 079CB84215
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 06 Aug 2026 11:44:55 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1786009495;
	b=OIxJIVccEzcsFETCHJ6Rq1GHEHGZORzyb5H0ygD6i6/VMrreW54VdrVkYfJ2IVl9ek+6Zm
	d7mflg7NwJnRdVlLZfcovi5mQNNbNxg+v8DxPB2yn/3ZXwXVlk6x4XxFPDEoQ1tDYAIMNN
	Wqi36H2skhbhw3JNGz5q4mqjuWqMIa8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1786009495;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=fqf8ii4iuD2l1/UGCSh9nIuzzupDQj6ybsLs8b6n4Qs=;
	b=jcipsOORRGXHLUzCLLh4XwMzDJF73X5vx4vlAp85+XlbblFG9l/38EovSg4UWCxShzoIbg
	bIhmr9sJK9lFww1fnb+goKVAAAMtIezbz3kWS9v+QRshBU5oX9Mw/pYbjN/wFRlWZSAhn0
	NybSkHa+mmwKRvdyhIHxmic/C4yx9sw=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=wN3YFmzd;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 67B7920590;
	Thu, 06 Aug 2026 09:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1786009490;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fqf8ii4iuD2l1/UGCSh9nIuzzupDQj6ybsLs8b6n4Qs=;
	b=wN3YFmzdXEXaRM/BA8ewOyil4nYmvz3BB/XW9S7euklm6Z7SOVlqVEHRd5jRtvK5yon9uZ
	BqbT1+pGsVzqBG4zSkxSjCK4OPevftBlSBKTvkcHnJXL2rrDslE1nLxYoPRSuO2Va8eYjo
	c0XaPRdzbcqTuYtW7010oYEo5PgUKxA=
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 06 Aug 2026 11:44:14 +0200
Subject: [PATCH RFC batadv 01/12] batman-adv: tt: look up wifi state of
 incoming interface in helper
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260806-tt-add-cleanup-v1-1-ffcad65bccc4@narfation.org>
References: <20260806-tt-add-cleanup-v1-0-ffcad65bccc4@narfation.org>
In-Reply-To: <20260806-tt-add-cleanup-v1-0-ffcad65bccc4@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3327; i=sven@narfation.org;
 h=from:subject:message-id; bh=yUBo56PNmO4dZY3Evfho9qNT69IxmoZXkZwLPHZzZkw=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFkl4U3clpHn5P5dzzisEuHzxOvo/za1xdPs58lLWHz9e
 K70l//RjlIWBjEuBlkxRZY9V/LPb2Z/K/952sejMHNYmUCGMHBxCsBEZv5k+Kc/a+tev7/eviv+
 n7wze5X9Q45br594du7c8rvQvvPfecssRoYZqT1hotee35z2952+3T7ubyyWKieuR81VWqHptKX
 1ngYXAA==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: ZL2ABSMGRQCOJV3GIYHZA5YBRYSDPSOM
X-Message-ID-Hash: ZL2ABSMGRQCOJV3GIYHZA5YBRYSDPSOM
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/ZL2ABSMGRQCOJV3GIYHZA5YBRYSDPSOM/>
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

