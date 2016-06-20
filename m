Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 20 Jun 2016 19:54:48 +0200
Message-Id: <1466445289-17840-1-git-send-email-sven@narfation.org>
In-Reply-To: <1466445210-17616-1-git-send-email-sven@narfation.org>
References: <1466445210-17616-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH next v2 3/4] batman-adv: remove
	NET_XMIT_POLICED
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
Cc: Florian Westphal <fw@strlen.de>, "David S . Miller" <davem@davemloft.net>

From: Florian Westphal <fw@strlen.de>

BATMAN uses it as an intermediate return value to signal
forwarding vs. buffering, but it did not return POLICED to
callers outside of BATMAN.

Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: David S. Miller <davem@davemloft.net>
[sven@narfation.org: rebased on top of TX path rewrite]
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
v2:
 - rebased on current master
 - added patch to a common set of related patches

 net/batman-adv/send.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/send.c b/net/batman-adv/send.c
index 70a8c1d..80208f1 100644
--- a/net/batman-adv/send.c
+++ b/net/batman-adv/send.c
@@ -20,6 +20,7 @@
 
 #include <linux/atomic.h>
 #include <linux/byteorder/generic.h>
+#include <linux/errno.h>
 #include <linux/etherdevice.h>
 #include <linux/fs.h>
 #include <linux/if.h>
@@ -164,7 +165,7 @@ int batadv_send_unicast_skb(struct sk_buff *skb,
  * host, NULL can be passed as recv_if and no interface alternating is
  * attempted.
  *
- * Return: -1 on failure (and the skb is not consumed), NET_XMIT_POLICED if the
+ * Return: -1 on failure (and the skb is not consumed), -EINPROGRESS if the
  * skb is buffered for later transmit or the NET_XMIT status returned by the
  * lower routine if the packet has been passed down.
  *
@@ -199,7 +200,7 @@ int batadv_send_skb_to_orig(struct sk_buff *skb,
 	 * network coding fails, then send the packet as usual.
 	 */
 	if (recv_if && batadv_nc_skb_forward(skb, neigh_node))
-		ret = NET_XMIT_POLICED;
+		ret = -EINPROGRESS;
 	else
 		ret = batadv_send_unicast_skb(skb, neigh_node);
 
-- 
2.8.1

