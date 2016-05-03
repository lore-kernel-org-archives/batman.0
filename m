Return-Path: <a@unstable.cc>
From: Antonio Quartulli <a@unstable.cc>
Date: Wed,  4 May 2016 06:23:43 +0800
Message-Id: <1462314230-16257-9-git-send-email-a@unstable.cc>
In-Reply-To: <1462314230-16257-1-git-send-email-a@unstable.cc>
References: <1462314230-16257-1-git-send-email-a@unstable.cc>
Subject: [B.A.T.M.A.N.] [PATCH 08/15] batman-adv: Fix checkpatch warning
	about 'unsigned' type
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
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Antonio Quartulli <a@unstable.cc>, Marek Lindner <mareklindner@neomailbox.ch>

From: Sven Eckelmann <sven@narfation.org>

checkpatch.pl warns about the use of 'unsigned' as a short form for
'unsigned int'.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
Signed-off-by: Antonio Quartulli <a@unstable.cc>
---
 net/batman-adv/fragmentation.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/batman-adv/fragmentation.c b/net/batman-adv/fragmentation.c
index e6956d0746a2..65536db1bff7 100644
--- a/net/batman-adv/fragmentation.c
+++ b/net/batman-adv/fragmentation.c
@@ -407,8 +407,8 @@ static struct sk_buff *batadv_frag_create(struct sk_buff *skb,
 					  unsigned int mtu)
 {
 	struct sk_buff *skb_fragment;
-	unsigned header_size = sizeof(*frag_head);
-	unsigned fragment_size = mtu - header_size;
+	unsigned int header_size = sizeof(*frag_head);
+	unsigned int fragment_size = mtu - header_size;
 
 	skb_fragment = netdev_alloc_skb(NULL, mtu + ETH_HLEN);
 	if (!skb_fragment)
@@ -444,15 +444,15 @@ bool batadv_frag_send_packet(struct sk_buff *skb,
 	struct batadv_hard_iface *primary_if = NULL;
 	struct batadv_frag_packet frag_header;
 	struct sk_buff *skb_fragment;
-	unsigned mtu = neigh_node->if_incoming->net_dev->mtu;
-	unsigned header_size = sizeof(frag_header);
-	unsigned max_fragment_size, max_packet_size;
+	unsigned int mtu = neigh_node->if_incoming->net_dev->mtu;
+	unsigned int header_size = sizeof(frag_header);
+	unsigned int max_fragment_size, max_packet_size;
 	bool ret = false;
 
 	/* To avoid merge and refragmentation at next-hops we never send
 	 * fragments larger than BATADV_FRAG_MAX_FRAG_SIZE
 	 */
-	mtu = min_t(unsigned, mtu, BATADV_FRAG_MAX_FRAG_SIZE);
+	mtu = min_t(unsigned int, mtu, BATADV_FRAG_MAX_FRAG_SIZE);
 	max_fragment_size = mtu - header_size;
 	max_packet_size = max_fragment_size * BATADV_FRAG_MAX_FRAGMENTS;
 
-- 
2.8.2

