Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed,  9 Mar 2016 22:22:51 +0100
Message-Id: <1457558571-5855-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Fix checkpatch warning about
	'unsigned' type
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

checkpatch.pl warns about the use of 'unsigned' as a short form for
'unsigned int'.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/fragmentation.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/batman-adv/fragmentation.c b/net/batman-adv/fragmentation.c
index e6956d0..910c841 100644
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
@@ -444,9 +444,9 @@ bool batadv_frag_send_packet(struct sk_buff *skb,
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
-- 
2.7.0

