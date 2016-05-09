Return-Path: <andrew@lunn.ch>
From: Andrew Lunn <andrew@lunn.ch>
Date: Mon,  9 May 2016 20:03:36 +0200
Message-Id: <1462817016-17867-3-git-send-email-andrew@lunn.ch>
In-Reply-To: <1462817016-17867-1-git-send-email-andrew@lunn.ch>
References: <1462817016-17867-1-git-send-email-andrew@lunn.ch>
Subject: [B.A.T.M.A.N.] [PATCH 2/2] batman-adv: Include frame priority in
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
To: "B.A.T.M.A.N" <b.a.t.m.a.n@lists.open-mesh.org>

Unfragmented frames which traverse a node have their skb->priority set
by looking at the IP ToS byte, or the 802.1p header. However for
fragments this is not possible, only one of the fragments will contain
the headers. Instead, place the priority into the fragment header and
on receiving a fragment, use this information to set the skb->priority
for when the fragment is forwarded.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 net/batman-adv/fragmentation.c | 2 ++
 net/batman-adv/packet.h        | 7 +++++--
 net/batman-adv/routing.c       | 2 ++
 3 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/fragmentation.c b/net/batman-adv/fragmentation.c
index a3fefbd..c703767 100644
--- a/net/batman-adv/fragmentation.c
+++ b/net/batman-adv/fragmentation.c
@@ -473,6 +473,8 @@ bool batadv_frag_send_packet(struct sk_buff *skb,
 	frag_header.reserved = 0;
 	frag_header.no = 0;
 	frag_header.total_size = htons(skb->len);
+	if (skb->priority >= 256 && skb->priority <= 263)
+		frag_header.priority = skb->priority - 256;
 	ether_addr_copy(frag_header.orig, primary_if->net_dev->dev_addr);
 	ether_addr_copy(frag_header.dest, orig_node->orig);
 
diff --git a/net/batman-adv/packet.h b/net/batman-adv/packet.h
index b45460d..7acc6a2 100644
--- a/net/batman-adv/packet.h
+++ b/net/batman-adv/packet.h
@@ -384,6 +384,7 @@ struct batadv_unicast_4addr_packet {
  * @dest: final destination used when routing fragments
  * @orig: originator of the fragment used when merging the packet
  * @no: fragment number within this sequence
+ * @priority: priority of frame, from ToS IP precedence or 802.1p
  * @reserved: reserved byte for alignment
  * @seqno: sequence identification
  * @total_size: size of the merged packet
@@ -394,9 +395,11 @@ struct batadv_frag_packet {
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
index ae850f2..01d36e3 100644
--- a/net/batman-adv/routing.c
+++ b/net/batman-adv/routing.c
@@ -1004,6 +1004,8 @@ int batadv_recv_frag_packet(struct sk_buff *skb,
 	if (!orig_node_src)
 		goto out;
 
+	skb->priority = frag_packet->priority + 256;
+
 	/* Route the fragment if it is not for us and too big to be merged. */
 	if (!batadv_is_my_mac(bat_priv, frag_packet->dest) &&
 	    batadv_frag_skb_fwd(skb, recv_if, orig_node_src)) {
-- 
2.8.0.rc3

