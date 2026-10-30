Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA15F606A31D
	for <batman@archiver.kernel.org>; Fri, 30 Oct 2026 14:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.a=rsa-sha256 header.s=09092022 header.b=weEB+vu7
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 4621285662
	for <batman@archiver.kernel.org>; Fri, 30 Oct 2026 15:00:57 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1793368857;
 b=NDy/pE/X+vO1OavuQYHeYkYBtBIn4/Px2f3ZFA7eUGWAsOtdBr427Z76msgVBhULKaV+e
 if/ntDvN7x9FpccQ2ewn8r0d9Nycyuuv19LyMV6X68iBUdvs/MhR5ZGP7757yb8QoCC14Pa
 Fpsq442UtEfOr6GNYfvzumkDJdAtXik=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1793368857; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=FWL1F1vUJ7Rasf3dRTG7SOA/ia/4OoBsj5jwSa+rk1s=;
 b=4QysJHH4jqG7EEy1adUQtW7ftX0HphgQ8Mv1YfbG6chIPWg/RGzXX8w460fueThLX+fob
 FDPSBeRETAyzefgS14b4EqoCthhpEZXEvGUmi4wXCLs3xChwaAR9/AjMDJ4DmOGja3lO1lE
 v9Iy7bZVEpnC2Fu1Q00MgviJN7VeNqE=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de
 [IPv6:2a01:4f8:c17:e8c0::1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id D054D81097
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 30 Oct 2026 15:00:42 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1793368842;
	b=0p201ID/HfA+GqXO9aNeg7CI9rIHH0UEnB18Bdntac2gCZG7ZezNAjlWNfmOH2rhR1z0+7
	NKogSy+uqOpWdNJd3Z9+0pRKujJ5jMk1FvCUcXaLoqtdR/dRW6YxQRKbVtIDan1wRMCdTi
	TmXBhCig/BFLMypew6SLs4P9nnpmCQM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1793368842;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=FWL1F1vUJ7Rasf3dRTG7SOA/ia/4OoBsj5jwSa+rk1s=;
	b=dGrMiH4no56y3QFcGbMrWpzDvXtlmPuwwyyTvW8AuFJFopa8inqXBDRz1Qq0hLChm0cImS
	8zQ+WgiDqSWXKFOOpTiay16v+zCozOikqS5oRUvml09387ssO6HResHgQjw6QSs902v/1a
	Mz6R47m9gvPyweB3Dp5vh8A8eJGRW1o=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=weEB+vu7;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 2a01:4f8:c17:e8c0::1 as permitted sender)
 smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
Received: from kero.packetmixer.de
 (p200300c597124Fd839580C360D3ed6F6.dip0.t-ipconnect.de
 [IPv6:2003:c5:9712:4fd8:3958:c36:d3e:d6f6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with UTF8SMTPSA id C4F24FA2F0;
	Fri, 30 Oct 2026 14:51:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1793368280;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FWL1F1vUJ7Rasf3dRTG7SOA/ia/4OoBsj5jwSa+rk1s=;
	b=weEB+vu7I//jKEx/ZyXAZsMGs3Hr4ki0P+ytfDCwrTX7/4g4R6jdErl9XeIaXJI5bG3tjl
	r/MysQdsxPCuK1giVx6k19vp0404XIDz51GdBRzjkEbiiz+UX/V0umHpdqatu28Rca7yVX
	Bex/aml1ZNkVpP6RlANijFpdUv5yTFAvUWJLw0rhd/We2EUd13eiF7MLa6/US4oiAN5f5I
	8asOGtXk+ajWe3tQ1zdRigNWbdoJPT1DTXmCV8dILPTMobYvl1lySzAxfOYTYTq9u6Dnr3
	qi0uYsQk25HLpLuD74GgsKCQ7UwptmbXzp2NH8MBUY5MDVb9Hh7LSOhrp5a6Zg==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Sven Eckelmann <sven@narfation.org>,
	Sashiko <sashiko-bot@kernel.org>,
	stable+noautosel@kernel.org,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net v2 14/14] batman-adv: tt: limit local table to single TVLV
 response size
Date: Fri, 30 Oct 2026 14:51:05 +0100
Message-ID: <20261030135105.2555887-15-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261030135105.2555887-1-sw@simonwunderlich.de>
References: <20261030135105.2555887-1-sw@simonwunderlich.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: LG2ZYJUY7B5BLUL3QC35XPGPQUTJRTAY
X-Message-ID-Hash: LG2ZYJUY7B5BLUL3QC35XPGPQUTJRTAY
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/LG2ZYJUY7B5BLUL3QC35XPGPQUTJRTAY/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_NONE,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Sven Eckelmann <sven@narfation.org>

The reservation of local TT entries and VLANs only limits the local table
by (int) packet_size_max. But the full table response is sent as a single
unicast TVLV packet whose tvlv_len (covering the TVLV header and the TT
TVLV) is only 16 bit wide. The reservation must therefore be capped at the
minimum of both the packet_size_max and the maximum theoretic table
response.

The size limit was already missing the 16 bit tvlv_len cap since the
original packet_size_max check was introduced. But this check was only
reachable with fragmentation disabled and a hard interface MTU larger than
the maximum unicast TVLV packet. In this case,
batadv_tt_prepare_tvlv_local_data() refuses to build the full table
response and no oversized packet is created. It is therefore mostly
affecting the commit 85fb027f611b ("batman-adv: tt: reject VLAN/TT entries
before reaching size limit"), which should prevent this kind of
overallocation.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260930094558.3723766-2-sw%40simonwunderlich.de?part=8
Fixes: a19d3d85e1b8 ("batman-adv: limit local translation table max size")
Cc: <stable+noautosel@kernel.org> # requires 85fb027f611b, old behavior only affects MTU > 64KiB without fragmentation
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/translation-table.c | 69 ++++++++++++++++++++----------
 1 file changed, 47 insertions(+), 22 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index f0100ccf93deb..46304069b3b75 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -26,8 +26,10 @@
 #include <linux/jhash.h>
 #include <linux/jiffies.h>
 #include <linux/kref.h>
+#include <linux/limits.h>
 #include <linux/list.h>
 #include <linux/lockdep.h>
+#include <linux/minmax.h>
 #include <linux/net.h>
 #include <linux/netdevice.h>
 #include <linux/netlink.h>
@@ -253,7 +255,8 @@ static int batadv_tt_len(int changes_num)
  *
  * Return: local translation table size in bytes.
  */
-static int batadv_tt_local_transmit_size(u16 num_vlan, u16 num_entries)
+static int batadv_tt_local_transmit_size(unsigned int num_vlan,
+					 unsigned int num_entries)
 {
 	int hdr_size;
 
@@ -266,6 +269,25 @@ static int batadv_tt_local_transmit_size(u16 num_vlan, u16 num_entries)
 	return hdr_size + batadv_tt_len(num_entries);
 }
 
+/**
+ * batadv_tt_local_transmit_size_max() - get the maximum size of a full local table
+ *  response
+ * @bat_priv: the bat priv with all the mesh interface information
+ *
+ * The full table response is sent as a single unicast TVLV packet. Its
+ * tvlv_len, which covers the TVLV header and the TT TVLV, is only 16 bit wide.
+ * This limits the response size even when packet_size_max is larger.
+ *
+ * Return: maximum size of a full local table response in bytes
+ */
+static int batadv_tt_local_transmit_size_max(struct batadv_priv *bat_priv)
+{
+	int tvlv_size_max = sizeof(struct batadv_unicast_tvlv_packet) + U16_MAX;
+	int packet_size_max = READ_ONCE(bat_priv->packet_size_max);
+
+	return min(packet_size_max, tvlv_size_max);
+}
+
 /**
  * batadv_tt_local_reserve() - reserve room in the transmittable local table
  * @bat_priv: the bat priv with all the mesh interface information
@@ -290,22 +312,23 @@ static int batadv_tt_local_transmit_size(u16 num_vlan, u16 num_entries)
 static bool batadv_tt_local_reserve(struct batadv_priv *bat_priv, u16 num_vlan,
 				    u16 num_entries, int *table_size)
 {
-	int packet_size_max = READ_ONCE(bat_priv->packet_size_max);
+	int size_max = batadv_tt_local_transmit_size_max(bat_priv);
+	unsigned int entries;
+	unsigned int vlans;
 
 	scoped_guard(spinlock_bh, &bat_priv->tt.reserve_lock) {
-		bat_priv->tt.reserved_vlans += num_vlan;
-		bat_priv->tt.reserved_entries += num_entries;
+		vlans = bat_priv->tt.reserved_vlans + num_vlan;
+		entries = bat_priv->tt.reserved_entries + num_entries;
 
-		*table_size = batadv_tt_local_transmit_size(bat_priv->tt.reserved_vlans,
-							    bat_priv->tt.reserved_entries);
-		if (*table_size <= packet_size_max)
-			return true;
+		*table_size = batadv_tt_local_transmit_size(vlans, entries);
+		if (*table_size > size_max)
+			return false;
 
-		bat_priv->tt.reserved_vlans -= num_vlan;
-		bat_priv->tt.reserved_entries -= num_entries;
+		bat_priv->tt.reserved_vlans = vlans;
+		bat_priv->tt.reserved_entries = entries;
 	}
 
-	return false;
+	return true;
 }
 
 /**
@@ -339,9 +362,10 @@ static bool batadv_tt_local_reserve_entry(struct batadv_priv *bat_priv,
 		return true;
 
 	net_ratelimited_function(batadv_info, bat_priv->mesh_iface,
-				 "Local translation table size (%i) exceeds maximum packet size (%i); Ignoring new local tt entry: %pM\n",
+				 "Local translation table size (%i) exceeds maximum table response size (%i); Ignoring new local tt entry: %pM\n",
 				 table_size,
-				 READ_ONCE(bat_priv->packet_size_max), addr);
+				 batadv_tt_local_transmit_size_max(bat_priv),
+				 addr);
 
 	return false;
 }
@@ -374,8 +398,9 @@ bool batadv_tt_local_reserve_vlan(struct batadv_priv *bat_priv,
 		return true;
 
 	net_ratelimited_function(batadv_info, bat_priv->mesh_iface,
-				 "Local translation table size (%i) exceeds maximum packet size (%i); Ignoring new VLAN: %d\n",
-				 table_size, READ_ONCE(bat_priv->packet_size_max),
+				 "Local translation table size (%i) exceeds maximum table response size (%i); Ignoring new VLAN: %d\n",
+				 table_size,
+				 batadv_tt_local_transmit_size_max(bat_priv),
 				 batadv_print_vid(vid));
 
 	return false;
@@ -724,9 +749,9 @@ static u16 batadv_tt_entries(u16 tt_len)
  */
 static int batadv_tt_local_table_transmit_size(struct batadv_priv *bat_priv)
 {
+	unsigned int tt_local_entries = 0;
 	struct batadv_meshif_vlan *vlan;
-	u16 tt_local_entries = 0;
-	u16 num_vlan = 0;
+	unsigned int num_vlan = 0;
 
 	rcu_read_lock();
 	hlist_for_each_entry_rcu(vlan, &bat_priv->meshif_vlan_list, list) {
@@ -4727,16 +4752,16 @@ void batadv_tt_local_resize_to_mtu(struct net_device *mesh_iface)
 	struct batadv_priv *bat_priv = netdev_priv(mesh_iface);
 	int timeout = BATADV_TT_LOCAL_TIMEOUT / 2;
 	bool reduced = false;
-	int packet_size_max;
 	int table_size;
+	int size_max;
 
-	packet_size_max = READ_ONCE(bat_priv->packet_size_max);
+	size_max = batadv_tt_local_transmit_size_max(bat_priv);
 
 	spin_lock_bh(&bat_priv->tt.commit_lock);
 
 	while (timeout) {
 		table_size = batadv_tt_local_table_transmit_size(bat_priv);
-		if (packet_size_max >= table_size)
+		if (size_max >= table_size)
 			break;
 
 		batadv_tt_local_purge(bat_priv, timeout);
@@ -4745,8 +4770,8 @@ void batadv_tt_local_resize_to_mtu(struct net_device *mesh_iface)
 		timeout /= 2;
 		reduced = true;
 		net_ratelimited_function(batadv_info, mesh_iface,
-					 "Forced to purge local tt entries to fit new maximum fragment MTU (%i)\n",
-					 packet_size_max);
+					 "Forced to purge local tt entries to fit new maximum table response size (%i)\n",
+					 size_max);
 	}
 
 	/* commit these changes immediately, to avoid synchronization problem
-- 
2.47.3

