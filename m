Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Wed,  5 Aug 2015 14:51:44 +0200
Message-Id: <1438779107-12665-2-git-send-email-antonio@meshcoding.com>
In-Reply-To: <1438779107-12665-1-git-send-email-antonio@meshcoding.com>
References: <1438779107-12665-1-git-send-email-antonio@meshcoding.com>
Subject: [B.A.T.M.A.N.] [PATCH 1/4] batman-adv: avoid DAT to mess up LAN
	state
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
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <mareklindner@neomailbox.ch>, Antonio Quartulli <antonio@meshcoding.com>

When a node running DAT receives an ARP request from the LAN for the
first time, it is likely that this node will request the ARP entry
through the distributed ARP table (DAT) in the mesh.

Once a DAT reply is received the asking node must check if the MAC
address for which the IP address has been asked is local. If it is, the
node must drop the ARP reply bceause the client should have replied on
its own locally.

Forwarding this reply means fooling any L2 bridge (e.g. Ethernet
switches) lying between the batman-adv node and the LAN. This happens
because the L2 bridge will think that the client sending the ARP reply
lies somewhere in the mesh, while this node is sitting in the same LAN.

Reported-by: Simon Wunderlich <sw@simonwunderlich.de>
Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
---
 net/batman-adv/distributed-arp-table.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/net/batman-adv/distributed-arp-table.c b/net/batman-adv/distributed-arp-table.c
index fb54e6a..6d0b471 100644
--- a/net/batman-adv/distributed-arp-table.c
+++ b/net/batman-adv/distributed-arp-table.c
@@ -1138,6 +1138,9 @@ void batadv_dat_snoop_outgoing_arp_reply(struct batadv_priv *bat_priv,
  * @bat_priv: the bat priv with all the soft interface information
  * @skb: packet to check
  * @hdr_size: size of the encapsulation header
+ *
+ * Returns true if the packet was snooped and consumed by DAT. False if the
+ * packet has to be delivered to the interface
  */
 bool batadv_dat_snoop_incoming_arp_reply(struct batadv_priv *bat_priv,
 					 struct sk_buff *skb, int hdr_size)
@@ -1145,7 +1148,7 @@ bool batadv_dat_snoop_incoming_arp_reply(struct batadv_priv *bat_priv,
 	uint16_t type;
 	__be32 ip_src, ip_dst;
 	uint8_t *hw_src, *hw_dst;
-	bool ret = false;
+	bool dropped = false;
 	unsigned short vid;
 
 	if (!atomic_read(&bat_priv->distributed_arp_table))
@@ -1174,12 +1177,17 @@ bool batadv_dat_snoop_incoming_arp_reply(struct batadv_priv *bat_priv,
 	/* if this REPLY is directed to a client of mine, let's deliver the
 	 * packet to the interface
 	 */
-	ret = !batadv_is_my_client(bat_priv, hw_dst, vid);
+	dropped = !batadv_is_my_client(bat_priv, hw_dst, vid);
+
+	/* if this REPLY is sent on behalf of a client of mine, let's drop the
+	 * packet because the client will reply by itself
+	 */
+	dropped |= batadv_is_my_client(bat_priv, hw_src, vid);
 out:
-	if (ret)
+	if (dropped)
 		kfree_skb(skb);
-	/* if ret == false -> packet has to be delivered to the interface */
-	return ret;
+	/* if dropped == false -> deliver to the interface */
+	return dropped;
 }
 
 /**
-- 
2.5.0

