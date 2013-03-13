Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Wed, 13 Mar 2013 23:56:32 +0100
Message-Id: <1363215399-18875-3-git-send-email-ordex@autistici.org>
In-Reply-To: <1363215399-18875-1-git-send-email-ordex@autistici.org>
References: <1363215399-18875-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 2/9] batman-adv: Return reason for failure in
	batadv_check_unicast_packet()
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
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@hundeboll.net>, b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <lindner_marek@yahoo.de>

From: Martin Hundebøll <martin@hundeboll.net>

batadv_check_unicast_packet() is changed to return a value based on the
reason to drop the packet, which will be useful information for
future users of batadv_check_unicast_packet().

Signed-off-by: Martin Hundebøll <martin@hundeboll.net>
Acked-by: Antonio Quartulli <ordex@autistici.org>
Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 net/batman-adv/routing.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/net/batman-adv/routing.c b/net/batman-adv/routing.c
index 5ee21ce..322c97a 100644
--- a/net/batman-adv/routing.c
+++ b/net/batman-adv/routing.c
@@ -548,27 +548,37 @@ batadv_find_ifalter_router(struct batadv_orig_node *primary_orig,
 	return router;
 }
 
+/**
+ * batadv_check_unicast_packet - Check for malformed unicast packets
+ * @skb: packet to check
+ * @hdr_size: size of header to pull
+ *
+ * Check for short header and bad addresses in given packet. Returns negative
+ * value when check fails and 0 otherwise. The negative value depends on the
+ * reason: -ENODATA for bad header, -EBADR for broadcast destination or source,
+ * and -EREMOTE for non-local (other host) destination.
+ */
 static int batadv_check_unicast_packet(struct sk_buff *skb, int hdr_size)
 {
 	struct ethhdr *ethhdr;
 
 	/* drop packet if it has not necessary minimum size */
 	if (unlikely(!pskb_may_pull(skb, hdr_size)))
-		return -1;
+		return -ENODATA;
 
 	ethhdr = (struct ethhdr *)skb_mac_header(skb);
 
 	/* packet with unicast indication but broadcast recipient */
 	if (is_broadcast_ether_addr(ethhdr->h_dest))
-		return -1;
+		return -EBADR;
 
 	/* packet with broadcast sender address */
 	if (is_broadcast_ether_addr(ethhdr->h_source))
-		return -1;
+		return -EBADR;
 
 	/* not for me */
 	if (!batadv_is_my_mac(ethhdr->h_dest))
-		return -1;
+		return -EREMOTE;
 
 	return 0;
 }
-- 
1.8.1.5

