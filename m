Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6446606A31B
	for <batman@archiver.kernel.org>; Sat, 24 Oct 2026 21:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=narfation.org header.i=@narfation.org header.a=rsa-sha256 header.s=20121 header.b=NQu+VfXg
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 4D869809A8
	for <batman@archiver.kernel.org>; Sat, 24 Oct 2026 23:36:00 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1792877760;
 b=hnj/qCKomN6mQ9uqc7/70QWGhTpnLcupFNOjvpfPpOF5Q0kpxOSAa2PC37W2zADX8AbwW
 5jZMuvrLaPMCrahvORUGBFWf/Kzrb6q61JKjyP6HP548POlaDRXqn43A9JugH3uM2mnFMdO
 4HtBeuVIE0BdaqtRWRGYHYBnGLLQG88=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1792877760; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=c+IULnCRmGgDQ4Ky+E5btZxwFybao3UmuGwaIJ7sFfs=;
 b=pvdiNo9P1xvEle7YUJYjadkZn5jOiVEInI3t598Cy3j/QijtKP/446k+BbTUSH1YW/SVa
 xI8lpwlBQrYz+yTLrV7MUN4jJ/0aeoV2SICwGC28q6rb0q39/7jPjyWyGvechOQW31Uq8Sy
 WiP/Y/TsdjMgADVqUeLrrKJyULYEmuo=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 0A78E802EB
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sat, 24 Oct 2026 23:35:32 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1792877743;
	b=IZ6jpw84Q7qYTnQa1zwwSWP7XT57EskQ3p2rfE57Gd8PgKt7gwFNFTsghbn2QhWvPJE29+
	ZeC3q9R6Wfxdm5qCvKngU7nCfbCcISZunbQNG8hoK2XgrWi3vBj6+/njufkW3CwpETgZOg
	z98XxOQDoLFmNPxzOSB5iRGTyN68Wb8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1792877743;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=c+IULnCRmGgDQ4Ky+E5btZxwFybao3UmuGwaIJ7sFfs=;
	b=iZsf8RIrgINPMfcDEf/lyGAq0+/KeInu34ozT0AU+eXLXG6ltd6tv7Ud4oYo3Tst3kfs3x
	RtVmOhlCp9mPr+ZtXen5Z2WZpRzL09d3t12WPj7ShaGdd5IyNwdRGbvk0vIPZGkOkZar1j
	jzrRSAsb+rZIdVuJOWLZCB1xhUsEj5E=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=NQu+VfXg;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 3538D2106B;
	Sat, 24 Oct 2026 21:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1792877731;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=c+IULnCRmGgDQ4Ky+E5btZxwFybao3UmuGwaIJ7sFfs=;
	b=NQu+VfXgC1DQK3qd1B487gxlPb8QJ6cdIwoafhNKdhkJ8LYyUz8PxFYbOWC/gBfz22sYeT
	OtdYrh1avpXIhE9Z6Xajx5tiSid1hhn/iVjD0/fCPLv3/K4yyhTEVC3s14RHe7W2itlzzV
	pdl+kxyoJS7VVGhyvUdexYpzyVKhNUw=
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 24 Oct 2026 23:35:27 +0200
Subject: [PATCH batadv v2] batman-adv: tt: limit local table to single TVLV
 response size
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: 
 <20261024-tvlv-limited-tt-response-reservation-v2-1-16fdc630cebb@narfation.org>
X-B4-Tracking: v=1; b=H4sIAJ4k3WoC/42OSw7CMAxEr4K8JqgJUj+suAfqIh+nDSpplZgIV
 PXupIEDsJsZj+Z5hYjBYYTLYYWAyUU3+2zE8QB6lH5A5kz2ICpR86oSjNKU2OQejtAwIhYwLrO
 PuAsMSVIeYK1qa9nYhpumhjy1BLTuVTA3UJKkSdB/8/hUd9S0M/bm6CLN4V3+Sbz0f+jzf+jEG
 WetsErLTnTadFcvgy230xwG6Ldt+wDhqqCb9gAAAA==
X-Change-ID: 20261002-tvlv-limited-tt-response-reservation-8b86a7f71d76
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sashiko <sashiko-bot@kernel.org>, Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7021; i=sven@narfation.org;
 h=from:subject:message-id; bh=8CgZj78eo7KeKTBsFnSwrTlXqgWIPKtNMQ0mcqeR/Zc=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFl3VeafuSP3UX7Jxvupp65wzpuzOez2pig/q24fz8N3/
 /R/tvzX2lHKwiDGxSArpsiy50r++c3sb+U/T/t4FGYOKxPIEAYuTgGYSNouRobfV7nmfP6+y0Nt
 c4rim7BCRS9mJ/+DKqpbIxyanU23i55kZPgaPrPYjvXS1bi6tveiD/dom+eu0g6289Ni5GWbxPz
 7KQ8A
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: B6UKTFBK7FV3V5THXVNKVNNASR627GPO
X-Message-ID-Hash: B6UKTFBK7FV3V5THXVNKVNNASR627GPO
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/B6UKTFBK7FV3V5THXVNKVNNASR627GPO/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_NONE,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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
Changes in v2:
- change printed messages to talk about "table response" instead of
  "packet" size
- Link to v1: https://patch.msgid.link/20261003-tvlv-limited-tt-response-reservation-v1-1-82fbca929cd9@narfation.org
---
 net/batman-adv/translation-table.c | 69 ++++++++++++++++++++++++++------------
 1 file changed, 47 insertions(+), 22 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index f2377ef6..99ca1b7c 100644
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
@@ -294,7 +296,8 @@ static int batadv_tt_len(int changes_num)
  *
  * Return: local translation table size in bytes.
  */
-static int batadv_tt_local_transmit_size(u16 num_vlan, u16 num_entries)
+static int batadv_tt_local_transmit_size(unsigned int num_vlan,
+					 unsigned int num_entries)
 {
 	int hdr_size;
 
@@ -307,6 +310,25 @@ static int batadv_tt_local_transmit_size(u16 num_vlan, u16 num_entries)
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
@@ -331,22 +353,23 @@ static int batadv_tt_local_transmit_size(u16 num_vlan, u16 num_entries)
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
@@ -380,9 +403,10 @@ static bool batadv_tt_local_reserve_entry(struct batadv_priv *bat_priv,
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
@@ -415,8 +439,9 @@ bool batadv_tt_local_reserve_vlan(struct batadv_priv *bat_priv,
 		return true;
 
 	net_ratelimited_function(batadv_info, bat_priv->mesh_iface,
-				 "Local translation table size (%i) exceeds maximum packet size (%i); Ignoring new VLAN: %d\n",
-				 table_size, READ_ONCE(bat_priv->packet_size_max),
+				 "Local translation table size (%i) exceeds maximum table response size (%i); Ignoring new VLAN: %d\n",
+				 table_size,
+				 batadv_tt_local_transmit_size_max(bat_priv),
 				 batadv_print_vid(vid));
 
 	return false;
@@ -767,9 +792,9 @@ static u16 batadv_tt_entries(u16 tt_len)
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
@@ -4696,16 +4721,16 @@ void batadv_tt_local_resize_to_mtu(struct net_device *mesh_iface)
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
@@ -4714,8 +4739,8 @@ void batadv_tt_local_resize_to_mtu(struct net_device *mesh_iface)
 		timeout /= 2;
 		reduced = true;
 		net_ratelimited_function(batadv_info, mesh_iface,
-					 "Forced to purge local tt entries to fit new maximum fragment MTU (%i)\n",
-					 packet_size_max);
+					 "Forced to purge local tt entries to fit new maximum table response size (%i)\n",
+					 size_max);
 	}
 
 	/* commit these changes immediately, to avoid synchronization problem

---
base-commit: 4fa5cbac90fa7b8936779b4313debb3d89701c59
change-id: 20261002-tvlv-limited-tt-response-reservation-8b86a7f71d76

Best regards,
--  
Sven Eckelmann <sven@narfation.org>

