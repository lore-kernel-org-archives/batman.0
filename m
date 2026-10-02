Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65CF6CA5FDD
	for <batman@archiver.kernel.org>; Fri,  2 Oct 2026 22:01:25 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 7D24883EEB
	for <batman@archiver.kernel.org>; Sat, 03 Oct 2026 00:01:23 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1790978483;
 b=CE5z9Bvy7nRE3gdY0BlQfmbAT0II7bE2Ii+UyWNapNUJmlFUCkk6CCtwe79vSzpxMegNo
 /OdYfL7MQZRGTR+TcEXMxD59PO1pkwi2habKzBmiD5j6YIQ1z85mDXb5x52+WrYvuKVpNGO
 Q3Cr66I2x9cG4WQfSWXQl5buuGpSJE0=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1790978483; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=ioIlrPYL97vDx76+LArvDtwtCSDFG3Zsp98z5FdR3bo=;
 b=14uOOHbPYs7uRO6i6S8RWWuQww760ulT9YoPvyM6DKSFBj5JW74PwyU/IMjt5mNmuSlsG
 5H43w6M+TtpjWriD4KNXJNAqT7c5thQipwX1EZoT5zsb59ZmglnJ13N9xgZ5DJgjKz5T154
 +yamqNfsAp+9vMIPkso6Ss93ovnCyEc=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 5BF82822C6
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sat, 03 Oct 2026 00:01:04 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1790978474;
	b=FB9dI3aMyGj6/0Hdc/ENFEH7PVbo4NZc6N4l632suBIR6QUWeXqY3/YK2D2YXigEh6b8Jx
	9vbHR+QEuDkw3BzHIHCMa9z4cEQsrzhjO08RZIDFfyvAyaP/SzGo31By+ikopsdHISY22Y
	8K0D6yIEWpyFzlR9U7kVIoK1Pez4qEk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1790978474;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=ioIlrPYL97vDx76+LArvDtwtCSDFG3Zsp98z5FdR3bo=;
	b=vmsoQwgzT/ah97/xPx5yi7qIsTcMBy6IcZ4X86dWGkpUMTw7N+a7ztt/jszkiXawr87Ozg
	GOLVKPEkdRHBgnFMpdw1d0GgpVYBR6zGCNiArAUWaz0tWm4KbPXcTlnpKeSiL41VtnHYmq
	hCKCVVWZky323NnYU2IP72w3q3R58vU=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=n9Zjw3VY;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 42D4220494;
	Fri, 02 Oct 2026 22:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1790978462;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ioIlrPYL97vDx76+LArvDtwtCSDFG3Zsp98z5FdR3bo=;
	b=n9Zjw3VYq+gfjmvueXrq8QT8I9WUcRM6kEhehNJXsv+uTWqfDSLPOmnXyLJR0+Waw3cEcY
	ARnR05OsY0BFSIosAYoq5OBd0+oauwxsTDzjAmqUyUedgXy/Uz7WEdBRGcg8zKzYsncZs/
	sEMk/inxhFBjx80ijZHptJJhbFOtK2I=
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 03 Oct 2026 00:00:51 +0200
Subject: [PATCH batadv] batman-adv: tt: limit local table to single TVLV
 response size
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: 
 <20261003-tvlv-limited-tt-response-reservation-v1-1-82fbca929cd9@narfation.org>
X-B4-Tracking: v=1; b=H4sIAJIpwGoC/yWNQQ6CMBBFr0Jm7SRtFy3xKsZFoYOOwUI6Q2NCu
 LtFd//9xXs7CBUmgWu3Q6HKwktuYC8djM+YH4ScGoMzzltjHGqdK878ZqWEqlhI1iULnYNKjdo
 E2A+9j2EKNgUPTbUWmvjzy9xgiBpThfv/l2140ahnA47jCxOoBnyQAAAA
X-Change-ID: 20261002-tvlv-limited-tt-response-reservation-8b86a7f71d76
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sashiko <sashiko-bot@kernel.org>, Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5390; i=sven@narfation.org;
 h=from:subject:message-id; bh=LcXXtcJa2eDCfRKGco+HcPKXpb5VovP+HdW/pHhPSAQ=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFkHNGfxvS4+6v7jzhqrPYdXy63kXPwvUlJ83TJr1ayzg
 qsZjjbe6ihlYRDjYpAVU2TZcyX//Gb2t/Kfp308CjOHlQlkCAMXpwBMpFOS4Z+y2oEdKwPYppy8
 Vme9uOSepMj+i5WugXcz/h5623lovpUzI8Ovk/MWSi18fE9DVun3Oe9Jy03LbDlEpGrfHA2I2dN
 mEcsMAA==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: AWZSOCPKXKCSWOVAUIOOEXCDJ7BBDAMC
X-Message-ID-Hash: AWZSOCPKXKCSWOVAUIOOEXCDJ7BBDAMC
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/AWZSOCPKXKCSWOVAUIOOEXCDJ7BBDAMC/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

The reservation of local TT entries and VLANs only limits the local table
by (int) packet_size_max. But the full table response is sent as a single
unicast TVLV packet whose tvlv_len (covering the TVLV header and the TT
TVLV) is only 16 bit wide. The reservation must therefore be capped at the
minimum of both the packet_size_max and the maximum theoretic table
response.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260930094558.3723766-2-sw%40simonwunderlich.de?part=8
Fixes: 96006ce44fa3 ("batman-adv: tt: reject VLAN/TT entries before reaching size limit")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/translation-table.c | 55 +++++++++++++++++++++++++++-----------
 1 file changed, 39 insertions(+), 16 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index f2377ef6..8aecf515 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -294,7 +294,8 @@ static int batadv_tt_len(int changes_num)
  *
  * Return: local translation table size in bytes.
  */
-static int batadv_tt_local_transmit_size(u16 num_vlan, u16 num_entries)
+static int batadv_tt_local_transmit_size(unsigned int num_vlan,
+					 unsigned int num_entries)
 {
 	int hdr_size;
 
@@ -307,6 +308,25 @@ static int batadv_tt_local_transmit_size(u16 num_vlan, u16 num_entries)
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
@@ -331,22 +351,23 @@ static int batadv_tt_local_transmit_size(u16 num_vlan, u16 num_entries)
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
@@ -382,7 +403,8 @@ static bool batadv_tt_local_reserve_entry(struct batadv_priv *bat_priv,
 	net_ratelimited_function(batadv_info, bat_priv->mesh_iface,
 				 "Local translation table size (%i) exceeds maximum packet size (%i); Ignoring new local tt entry: %pM\n",
 				 table_size,
-				 READ_ONCE(bat_priv->packet_size_max), addr);
+				 batadv_tt_local_transmit_size_max(bat_priv),
+				 addr);
 
 	return false;
 }
@@ -416,7 +438,8 @@ bool batadv_tt_local_reserve_vlan(struct batadv_priv *bat_priv,
 
 	net_ratelimited_function(batadv_info, bat_priv->mesh_iface,
 				 "Local translation table size (%i) exceeds maximum packet size (%i); Ignoring new VLAN: %d\n",
-				 table_size, READ_ONCE(bat_priv->packet_size_max),
+				 table_size,
+				 batadv_tt_local_transmit_size_max(bat_priv),
 				 batadv_print_vid(vid));
 
 	return false;
@@ -767,9 +790,9 @@ static u16 batadv_tt_entries(u16 tt_len)
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
@@ -4699,7 +4722,7 @@ void batadv_tt_local_resize_to_mtu(struct net_device *mesh_iface)
 	int packet_size_max;
 	int table_size;
 
-	packet_size_max = READ_ONCE(bat_priv->packet_size_max);
+	packet_size_max = batadv_tt_local_transmit_size_max(bat_priv);
 
 	spin_lock_bh(&bat_priv->tt.commit_lock);
 

---
base-commit: 4fa5cbac90fa7b8936779b4313debb3d89701c59
change-id: 20261002-tvlv-limited-tt-response-reservation-8b86a7f71d76

Best regards,
--  
Sven Eckelmann <sven@narfation.org>

