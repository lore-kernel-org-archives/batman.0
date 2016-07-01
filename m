Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Fri,  1 Jul 2016 15:09:05 +0200
Message-Id: <1467378549-9646-14-git-send-email-sw@simonwunderlich.de>
In-Reply-To: <1467378549-9646-1-git-send-email-sw@simonwunderlich.de>
References: <1467378549-9646-1-git-send-email-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH 13/17] batman-adv: Include frame priority in
	fragment header
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: davem@davemloft.net
Cc: Marek Lindner <mareklindner@neomailbox.ch>, netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org

From: Andrew Lunn <andrew@lunn.ch>

Unfragmented frames which traverse a node have their skb->priority set
by looking at the IP ToS byte, or the 802.1p header. However for
fragments this is not possible, only one of the fragments will contain
the headers. Instead, place the priority into the fragment header and
on receiving a fragment, use this information to set the skb->priority
for when the fragment is forwarded.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/fragmentation.c | 9 +++++++++
 net/batman-adv/packet.h        | 7 +++++--
 net/batman-adv/routing.c       | 2 ++
 3 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/fragmentation.c b/net/batman-adv/fragmentation.c
index a119b6a..9f41a0a 100644
--- a/net/batman-adv/fragmentation.c
+++ b/net/batman-adv/fragmentation.c
@@ -472,6 +472,15 @@ bool batadv_frag_send_packet(struct sk_buff *skb,
 	frag_header.reserved = 0;
 	frag_header.no = 0;
 	frag_header.total_size = htons(skb->len);
+
+	/* skb->priority values from 256->263 are magic values to
+	 * directly indicate a specific 802.1d priority.  This is used
+	 * to allow 802.1d priority to be passed directly in from VLAN
+	 * tags, etc.
+	 */
+	if (skb->priority >= 256 && skb->priority <= 263)
+		frag_header.priority = skb->priority - 256;
+
 	ether_addr_copy(frag_header.orig, primary_if->net_dev->dev_addr);
 	ether_addr_copy(frag_header.dest, orig_node->orig);
 
diff --git a/net/batman-adv/packet.h b/net/batman-adv/packet.h
index 372128d..7156779 100644
--- a/net/batman-adv/packet.h
+++ b/net/batman-adv/packet.h
@@ -420,6 +420,7 @@ struct batadv_unicast_4addr_packet {
  * @dest: final destination used when routing fragments
  * @orig: originator of the fragment used when merging the packet
  * @no: fragment number within this sequence
+ * @priority: priority of frame, from ToS IP precedence or 802.1p
  * @reserved: reserved byte for alignment
  * @seqno: sequence identification
  * @total_size: size of the merged packet
@@ -430,9 +431,11 @@ struct batadv_frag_packet {
 	u8     ttl;
 #if defined(__BIG_ENDIAN_BITFIELD)
 	u8     no:4;
-	u8     reserved:4;
+	u8     priority:3;
+	u8     reserved:1;
 #elif defined(__LITTLE_ENDIAN_BITFIELD)
-	u8     reserved:4;
+	u8     reserved:1;
+	u8     priority:3;
 	u8     no:4;
 #else
 #error "unknown bitfield endianness"
diff --git a/net/batman-adv/routing.c b/net/batman-adv/routing.c
index f75091c..24fc753 100644
--- a/net/batman-adv/routing.c
+++ b/net/batman-adv/routing.c
@@ -1006,6 +1006,8 @@ int batadv_recv_frag_packet(struct sk_buff *skb,
 	if (!orig_node_src)
 		goto out;
 
+	skb->priority = frag_packet->priority + 256;
+
 	/* Route the fragment if it is not for us and too big to be merged. */
 	if (!batadv_is_my_mac(bat_priv, frag_packet->dest) &&
 	    batadv_frag_skb_fwd(skb, recv_if, orig_node_src)) {
-- 
2.8.1

