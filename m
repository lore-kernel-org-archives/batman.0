Return-Path: <martin@hundeboll.net>
From: =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@hundeboll.net>
Date: Mon, 14 Jan 2013 00:20:32 +0100
Message-Id: <1358119232-14781-1-git-send-email-martin@hundeboll.net>
In-Reply-To: <1358118740-10458-1-git-send-email-martin@hundeboll.net>
References: <1358118740-10458-1-git-send-email-martin@hundeboll.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCHv3] batman-adv: Return reason for failure in
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
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@hundeboll.net>

batadv_check_unicast_packet() is changed to return a value based on the
reason to drop the packet, which will be useful information for
future users of batadv_check_unicast_packet().

---
v2:
 * Changed return values to defined error codes.
 * Send as separate patch

v3:
 * Fixed typo in kernel doc

Signed-off-by: Martin Hundebøll <martin@hundeboll.net>
---
 routing.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/routing.c b/routing.c
index 60ba03f..b070163 100644
--- a/routing.c
+++ b/routing.c
@@ -550,27 +550,37 @@ batadv_find_ifalter_router(struct batadv_orig_node *primary_orig,
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
1.8.1

