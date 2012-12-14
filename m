Return-Path: <martin@hundeboll.net>
From: =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@hundeboll.net>
Date: Fri, 14 Dec 2012 07:32:46 +0100
Message-Id: <e283ab952a3393aa0128d377436bc127cedd244a.1355466678.git.martin@hundeboll.net>
In-Reply-To: <cover.1355466678.git.martin@hundeboll.net>
References: <cover.1355466678.git.martin@hundeboll.net>
In-Reply-To: <cover.1355466678.git.martin@hundeboll.net>
References: <cover.1355466678.git.martin@hundeboll.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCHv2 1/7] batman-adv: Return reason for failure
	in batadv_check_unicast_packet()
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
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@hundeboll.net>

For network coding it is needed to know if a packet has another host as
destination as the packet should be buffered for decoding. To avoid
double checking the destination, the behaviour of
batadv_check_unicast_packet() is changed to return a value based on the
reason to drop the packet, which will be used in later patches for
network coding.

Signed-off-by: Martin Hundebøll <martin@hundeboll.net>
---
 routing.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/routing.c b/routing.c
index 1aa1722..0cea96b 100644
--- a/routing.c
+++ b/routing.c
@@ -552,6 +552,16 @@ batadv_find_ifalter_router(struct batadv_orig_node *primary_orig,
 	return router;
 }
 
+/**
+ * batadv_check_unicast_packet - Check for malformed unicast packets
+ * @skb: packet to check
+ * @hdr_size: size of header to pull
+ *
+ * Check for short header and bad addresses in given packet. Returns negative
+ * value when check fails and 0 otherwise. The negative value depends on the
+ * reason: -1 for bad header, -2 for broadcast destination, -3 for broadcast
+ * source, and -4 for non-local (other host) destination.
+ */
 static int batadv_check_unicast_packet(struct sk_buff *skb, int hdr_size)
 {
 	struct ethhdr *ethhdr;
@@ -564,15 +574,15 @@ static int batadv_check_unicast_packet(struct sk_buff *skb, int hdr_size)
 
 	/* packet with unicast indication but broadcast recipient */
 	if (is_broadcast_ether_addr(ethhdr->h_dest))
-		return -1;
+		return -2;
 
 	/* packet with broadcast sender address */
 	if (is_broadcast_ether_addr(ethhdr->h_source))
-		return -1;
+		return -3;
 
 	/* not for me */
 	if (!batadv_is_my_mac(ethhdr->h_dest))
-		return -1;
+		return -4;
 
 	return 0;
 }
-- 
1.8.0.2

