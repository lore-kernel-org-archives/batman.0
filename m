Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C874606A31E
	for <batman@archiver.kernel.org>; Mon, 26 Oct 2026 08:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.a=rsa-sha256 header.s=09092022 header.b=lSwW4vVq
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 6F30C85823
	for <batman@archiver.kernel.org>; Mon, 26 Oct 2026 09:57:29 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1793005049;
 b=v5p3Q7WbDIVaxiXvRo2eq34O3EsvPLdG7+0PiXzwxgqMZVth9rScXOUNRsHwclGBDMZHx
 fWyoy7cDCBnAoCimzMXOINJkWnbDxkAvPsocRLhID/eWT6RSNXkWgQ7qBVRKjouzPUHwnrp
 YTSH5OWLDzXgFOTv/MZVkUKuVqSVlVQ=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1793005049; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=8a/owQR7BJm0KvqIzWrZJw/lhP2sM9n2M+zPpLTBVGM=;
 b=E+tZO+kyXgl33kFglfbj3eZaiPYUCLCCvSvrte10bxpTYuRJ7sknZPp3DJwyaBJ+tkV67
 N3g9LZnGHFKBgqy/6bFDaOQ6oRKItbIbWadeNKC42OClredycp+it3FhAvjqEPWLkUxwGMW
 sd2cl2ZoKRaF3b+h5kZo6Kz9Ma+W2pc=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id B477E81EBB
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 26 Oct 2026 09:53:34 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1793004814;
	b=lOobNWpTPot7XHFdze4jvgmZMMt1imtFMTkpQe+XK1PuR41lkJCsX47pxI2FlQDXCyX17i
	vrKRTwKAFHfcUYt1OR5rBXczHDBsKl9JiU5pI/FxNSh2XZf39ywWyWTINyeM4Hrsg+OA9s
	CtoPBUVTZ0DkGMrWThiNrWixxoVKJ34=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1793004814;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=8a/owQR7BJm0KvqIzWrZJw/lhP2sM9n2M+zPpLTBVGM=;
	b=kmk/ov1UoKy035AmsxXrox9QHLVPIKQ4CkvPO4/6lMRd/WAdlze3nVFigUXrIIGqZBULwu
	Qnhe70pnPxMjnL4ItBKKTBaKyfaYWCyGlitWrcRmL3YR2DMwaLJhzqY4LaoGskCzWi0vwX
	cmaZcT2INlAdu0C0xM8VD31ZeDjbWEU=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=lSwW4vVq;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 23.88.38.48 as permitted sender) smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
Received: from kero.packetmixer.de
 (p200300C5973Ce5d80fC8dfe94A24022D.dip0.t-ipconnect.de
 [IPv6:2003:c5:973c:e5d8:fc8:dfe9:4a24:22d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with UTF8SMTPSA id 143EDFA26F;
	Mon, 26 Oct 2026 09:53:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1793004798;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8a/owQR7BJm0KvqIzWrZJw/lhP2sM9n2M+zPpLTBVGM=;
	b=lSwW4vVqgBDTWteUidlAnuOMamBAtz0qeklCTtp1ltBu4D9Hh7A4pFan7b4XKwMl+ailQy
	9NK/DuCThtOCpfBiPybffGy867eg7MA/Qsso7805BUNBWyvMuP5Pco3KZydbSa0UZOgpnh
	YvWLhrMugYiSZLmG1FQuuce5OqN8BGX1ktXn/o6LHFJX6KrrcfGjR6PS4E9SFSsNP+p4+M
	NIJAsPnDGnOIl46aDhJHDtNAkRCY3jQgiAFqjaz7EWvL0vHUgQsCJ9wdgP5Zvm3u6johnT
	fwK9QxIYFRoxUqw7nY98sFWK4f1Dg6os9JbBIoI4nQ3zBJXiSP98MFxXb4z8fQ==
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
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net 10/10] batman-adv: tt: limit local table to single TVLV
 response size
Date: Mon, 26 Oct 2026 09:53:09 +0100
Message-ID: <20261026085309.1074911-11-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261026085309.1074911-1-sw@simonwunderlich.de>
References: <20261026085309.1074911-1-sw@simonwunderlich.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: HW4PNXOBNGH2TZA4ZOPPGRSYPXLOFPYB
X-Message-ID-Hash: HW4PNXOBNGH2TZA4ZOPPGRSYPXLOFPYB
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/HW4PNXOBNGH2TZA4ZOPPGRSYPXLOFPYB/>
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

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260930094558.3723766-2-sw%40simonwunderlich.de?part=8
Fixes: 85fb027f611b ("batman-adv: tt: reject VLAN/TT entries before reaching size limit")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/translation-table.c | 69 ++++++++++++++++++++----------
 1 file changed, 47 insertions(+), 22 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 6774484f1c573..6931ce88c3062 100644
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
@@ -4686,16 +4711,16 @@ void batadv_tt_local_resize_to_mtu(struct net_device *mesh_iface)
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
@@ -4704,8 +4729,8 @@ void batadv_tt_local_resize_to_mtu(struct net_device *mesh_iface)
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

