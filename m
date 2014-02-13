Return-Path: <russell@personaltelco.net>
From: Russell Senior <russell@personaltelco.net>
Date: Thu, 13 Feb 2014 05:54:59 -0800
Message-ID: <86r4775d8s.fsf@coulee.tdb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [B.A.T.M.A.N.] [PATCH 1/4] openwrt routing feed: add three ordex
	patches for anti-panic, anti-leaking
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: "b.a.t.m.a.n@lists.open-mesh.org" <b.a.t.m.a.n@lists.open-mesh.org>


These three patches successfully stopped panics and memory leaks for
me, tested during some extended IRC sessions.  Thanks Antonio!

This patch adds them to the OpenWrt routing feed patches directory for batman-adv.

Signed-off-by: Russell Senior <russell@personaltelco.net>
---
 ...set-mac_header-when-forging-an-ARP-reply-.patch | 38 ++++++++++
 .../0010-batman-adv-byte-order-affects-crc.patch   | 83 ++++++++++++++++++++++
 .../patches/0011-batman-adv-memory-leak-fix.patch  | 39 ++++++++++
 3 files changed, 160 insertions(+)
 create mode 100644 batman-adv/patches/0008-batman-adv-set-mac_header-when-forging-an-ARP-reply-.patch
 create mode 100644 batman-adv/patches/0010-batman-adv-byte-order-affects-crc.patch
 create mode 100644 batman-adv/patches/0011-batman-adv-memory-leak-fix.patch

diff --git a/batman-adv/patches/0008-batman-adv-set-mac_header-when-forging-an-ARP-reply-.patch b/batman-adv/patches/0008-batman-adv-set-mac_header-when-forging-an-ARP-reply-.patch
new file mode 100644
index 0000000..67c6dde
--- /dev/null
+++ b/batman-adv/patches/0008-batman-adv-set-mac_header-when-forging-an-ARP-reply-.patch
@@ -0,0 +1,38 @@
+From 9cfee06f7350c28881b5cb0bfa2901c3b726eb1a Mon Sep 17 00:00:00 2001
+From: Antonio Quartulli <antonio@meshcoding.com>
+Date: Fri, 31 Jan 2014 00:51:50 +0100
+Subject: [PATCH 8/9] batman-adv: set mac_header when forging an ARP reply in
+ DAT
+
+In the TX path we now have functions that rely on the
+skb->mac_header field. DAT does not set such field when
+creating its own ARP packets thus leading to wrong memory
+access.
+
+Fix it by always setting the mac_header after having forged
+the ARP packet.
+
+Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
+---
+ distributed-arp-table.c | 5 +++++
+ 1 file changed, 5 insertions(+)
+
+diff --git a/distributed-arp-table.c b/distributed-arp-table.c
+index 6da587a..0b69b61 100644
+--- a/distributed-arp-table.c
++++ b/distributed-arp-table.c
+@@ -1028,6 +1028,11 @@ bool batadv_dat_snoop_incoming_arp_request(struct batadv_priv *bat_priv,
+ 	if (!skb_new)
+ 		goto out;
+ 
++	/* the rest of the TX path assumes that the mac_header offset pointing
++	 * to the inner Ethernet header has been set, therefore reset it now.
++	 */
++	skb_reset_mac_header(skb_new);
++
+ 	if (vid & BATADV_VLAN_HAS_TAG)
+ 		skb_new = vlan_insert_tag(skb_new, htons(ETH_P_8021Q),
+ 					  vid & VLAN_VID_MASK);
+-- 
+1.8.5.3
+
diff --git a/batman-adv/patches/0010-batman-adv-byte-order-affects-crc.patch b/batman-adv/patches/0010-batman-adv-byte-order-affects-crc.patch
new file mode 100644
index 0000000..577d9b7
--- /dev/null
+++ b/batman-adv/patches/0010-batman-adv-byte-order-affects-crc.patch
@@ -0,0 +1,83 @@
+From: Antonio Quartulli <antonio@meshcoding.com>
+Date: Tue, 11 Feb 2014 17:05:06 +0100
+Message-Id: <1392134707-2318-1-git-send-email-antonio@meshcoding.com>
+Subject: [B.A.T.M.A.N.] [PATCH maint 1/2] batman-adv: fix TT CRC computation
+	by ensuring byte order
+
+From: Antonio Quartulli <antonio@open-mesh.com>
+
+When computing the CRC on a 2byte variable the order of
+the bytes obviously alters the final result. This means
+that computing the CRC over the same value on two archs
+having different endianess leads to different numbers.
+
+The global and local translation table CRC computation
+routine makes this mistake while processing the clients
+VIDs. The result is a continuous CRC mismatching between
+nodes having different endianess.
+
+Fix this by converting the VID to Network Order before
+processing it. This guarantees that every node uses the same
+byte order.
+
+Introduced by 21a57f6e7a3b4455dfe68ee07a7b901d9e7f200b
+("batman-adv: make the TT CRC logic VLAN specific")
+
+Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
+---
+ translation-table.c | 16 ++++++++++++----
+ 1 file changed, 12 insertions(+), 4 deletions(-)
+
+diff --git a/translation-table.c b/translation-table.c
+index 05c2a9b..24e3267 100644
+--- a/translation-table.c
++++ b/translation-table.c
+@@ -1961,6 +1961,7 @@ static uint32_t batadv_tt_global_crc(struct batadv_priv *bat_priv,
+ 	struct hlist_head *head;
+ 	uint32_t i, crc_tmp, crc = 0;
+ 	uint8_t flags;
++	__be16 tmp_vid;
+ 
+ 	for (i = 0; i < hash->size; i++) {
+ 		head = &hash->table[i];
+@@ -1997,8 +1998,11 @@ static uint32_t batadv_tt_global_crc(struct batadv_priv *bat_priv,
+ 							     orig_node))
+ 				continue;
+ 
+-			crc_tmp = crc32c(0, &tt_common->vid,
+-					 sizeof(tt_common->vid));
++			/* use network order to read the VID: this ensures that
++			 * every node reads the bytes in the same order.
++			 */
++			tmp_vid = htons(tt_common->vid);
++			crc_tmp = crc32c(0, &tmp_vid, sizeof(tmp_vid));
+ 
+ 			/* compute the CRC on flags that have to be kept in sync
+ 			 * among nodes
+@@ -2032,6 +2036,7 @@ static uint32_t batadv_tt_local_crc(struct batadv_priv *bat_priv,
+ 	struct hlist_head *head;
+ 	uint32_t i, crc_tmp, crc = 0;
+ 	uint8_t flags;
++	__be16 tmp_vid;
+ 
+ 	for (i = 0; i < hash->size; i++) {
+ 		head = &hash->table[i];
+@@ -2050,8 +2055,11 @@ static uint32_t batadv_tt_local_crc(struct batadv_priv *bat_priv,
+ 			if (tt_common->flags & BATADV_TT_CLIENT_NEW)
+ 				continue;
+ 
+-			crc_tmp = crc32c(0, &tt_common->vid,
+-					 sizeof(tt_common->vid));
++			/* use network order to read the VID: this ensures that
++			 * every node reads the bytes in the same order.
++			 */
++			tmp_vid = htons(tt_common->vid);
++			crc_tmp = crc32c(0, &tmp_vid, sizeof(tmp_vid));
+ 
+ 			/* compute the CRC on flags that have to be kept in sync
+ 			 * among nodes
+-- 
+1.8.5.3
+
+
+
diff --git a/batman-adv/patches/0011-batman-adv-memory-leak-fix.patch b/batman-adv/patches/0011-batman-adv-memory-leak-fix.patch
new file mode 100644
index 0000000..c991d5d
--- /dev/null
+++ b/batman-adv/patches/0011-batman-adv-memory-leak-fix.patch
@@ -0,0 +1,39 @@
+From: Antonio Quartulli <antonio@meshcoding.com>
+To: b.a.t.m.a.n@lists.open-mesh.org
+Date: Tue, 11 Feb 2014 17:05:07 +0100
+Subject: [B.A.T.M.A.N.] [PATCH maint 2/2] batman-adv: free skb on TVLV
+	parsing success
+
+From: Antonio Quartulli <antonio@open-mesh.com>
+
+When the TVLV parsing routine succeed the skb is left
+untouched thus leading to a memory leak.
+
+Fix this by consuming the skb in case of success.
+
+Introduced by 0b6aa0d43767889eeda43a132cf5e73df4e63bf2
+("batman-adv: tvlv - basic infrastructure")
+
+Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
+---
+ routing.c | 2 ++
+ 1 file changed, 2 insertions(+)
+
+diff --git a/routing.c b/routing.c
+index f7579d0..71bf698 100644
+--- a/routing.c
++++ b/routing.c
+@@ -1063,6 +1063,8 @@ int batadv_recv_unicast_tvlv(struct sk_buff *skb,
+ 
+ 	if (ret != NET_RX_SUCCESS)
+ 		ret = batadv_route_unicast_packet(skb, recv_if);
++	else
++		consume_skb(skb);
+ 
+ 	return ret;
+ }
+-- 
+1.8.5.3
+
+
+
-- 
1.8.1.2



-- 
Russell Senior, President
russell@personaltelco.net
