Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 20 Jan 2011 23:48:56 +0100
Message-Id: <1295563736-27526-2-git-send-email-sven@narfation.org>
In-Reply-To: <1295563736-27526-1-git-send-email-sven@narfation.org>
References: <1295563736-27526-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 2/2] batman-adv: Calculate correct size for
	merged packets
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

The routing algorithm must be able to decide if a fragment can be merged with
the missing part and still be passed to a forwarding interface. The fragments
can only differ by one byte in case that the original payload had an uneven
length. In that situation the sender has to inform all possible receivers that
the tail is one byte longer using the flag UNI_FRAG_LARGETAIL.

The combination of UNI_FRAG_LARGETAIL and UNI_FRAG_HEAD flag makes it possible
to calculate the correct length for even and uneven sized payloads.

The original formula missed to add the unicast header at all and forgot to
remove the fragment header of the second fragment. This made the results highly
unreliable and only useful for machines with large differences between the
configured MTUs.

Reported-by: Russell Senior <russell@personaltelco.net>
Reported-by: Marek Lindner <lindner_marek@yahoo.de>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
This patch is completely untested and is currently only to support marec and
russell-- during their debugging sessions. Maybe it doesn't even compile.

 batman-adv/packet.h  |    1 +
 batman-adv/routing.c |   24 +++++++++++++++++++++++-
 batman-adv/unicast.c |   10 ++++++++--
 3 files changed, 32 insertions(+), 3 deletions(-)

diff --git a/batman-adv/packet.h b/batman-adv/packet.h
index 2284e81..03ce0d3 100644
--- a/batman-adv/packet.h
+++ b/batman-adv/packet.h
@@ -50,6 +50,7 @@
 
 /* fragmentation defines */
 #define UNI_FRAG_HEAD 0x01
+#define UNI_FRAG_LARGETAIL 0x02
 
 struct batman_packet {
 	uint8_t  packet_type;
diff --git a/batman-adv/routing.c b/batman-adv/routing.c
index a90d105..71dd69f 100644
--- a/batman-adv/routing.c
+++ b/batman-adv/routing.c
@@ -1243,6 +1243,28 @@ static int check_unicast_packet(struct sk_buff *skb, int hdr_size)
 	return 0;
 }
 
+static int frag_can_reassemble(struct sk_buff *skb, int mtu)
+{
+	struct unicast_frag_packet *unicast_packet;
+	int uneven_correction = 0;
+	unsigned int merged_size;
+
+	unicast_packet = (struct unicast_frag_packet *)skb->data;
+
+	if (unicast_packet->flags & UNI_FRAG_LARGETAIL) {
+		if (unicast_packet->flags & UNI_FRAG_HEAD)
+			uneven_correction = 1;
+		else
+			uneven_correction = -1;
+	}
+
+	merged_size = (skb->len - sizeof(struct unicast_frag_packet)) * 2;
+	merged_size += sizeof(struct unicast_packet);
+	merged_size += uneven_correction;
+
+	return merged_size <= mtu;
+}
+
 int route_unicast_packet(struct sk_buff *skb, struct batman_if *recv_if,
 			 int hdr_size)
 {
@@ -1297,7 +1319,7 @@ int route_unicast_packet(struct sk_buff *skb, struct batman_if *recv_if,
 	}
 
 	if (unicast_packet->packet_type == BAT_UNICAST_FRAG &&
-	    2 * skb->len - hdr_size <= neigh_node->if_incoming->net_dev->mtu) {
+	    frag_can_reassemble(skb, neigh_node->if_incoming->net_dev->mtu)) {
 
 		ret = frag_reassemble_skb(skb, bat_priv, &new_skb);
 
diff --git a/batman-adv/unicast.c b/batman-adv/unicast.c
index 84e70bc..6340f28 100644
--- a/batman-adv/unicast.c
+++ b/batman-adv/unicast.c
@@ -231,6 +231,7 @@ int frag_send_skb(struct sk_buff *skb, struct bat_priv *bat_priv,
 	int uc_hdr_len = sizeof(struct unicast_packet);
 	int ucf_hdr_len = sizeof(struct unicast_frag_packet);
 	int data_len = skb->len - uc_hdr_len;
+	int large_tail;
 
 	if (!bat_priv->primary_if)
 		goto dropped;
@@ -260,8 +261,13 @@ int frag_send_skb(struct sk_buff *skb, struct bat_priv *bat_priv,
 	memcpy(frag1->orig, bat_priv->primary_if->net_dev->dev_addr, ETH_ALEN);
 	memcpy(frag2, frag1, sizeof(struct unicast_frag_packet));
 
-	frag1->flags |= UNI_FRAG_HEAD;
-	frag2->flags &= ~UNI_FRAG_HEAD;
+	if (data_len & 1)
+		large_tail = UNI_FRAG_LARGETAIL;
+	else
+		large_tail = 0;
+
+	frag1->flags = UNI_FRAG_HEAD | large_tail;
+	frag2->flags = large_tail;
 
 	frag1->seqno = htons((uint16_t)atomic_inc_return(
 			     &batman_if->frag_seqno));
-- 
1.7.2.3

