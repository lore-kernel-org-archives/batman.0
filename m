Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 14 Jun 2016 08:34:53 +0200
Message-Id: <1465886093-9609-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH next] batman-adv: remove NET_XMIT_POLICED
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

From: Florian Westphal <fw@strlen.de>

BATMAN uses it as an intermediate return value to signal
forwarding vs. buffering, but it did not return POLICED to
callers outside of BATMAN.

Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: David S. Miller <davem@davemloft.net>
[sven@narfation.org: rebased on top of TX path rewrite]
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
Taken from upstream commit 99860208bc62 ("sched: remove NET_XMIT_POLICED").

Please make sure you first apply

 * https://patchwork.open-mesh.org/patch/16362/
 * https://patchwork.open-mesh.org/patch/16363/
 * https://patchwork.open-mesh.org/patch/16364/
---
 net/batman-adv/send.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/send.c b/net/batman-adv/send.c
index 49836da..729deec 100644
--- a/net/batman-adv/send.c
+++ b/net/batman-adv/send.c
@@ -20,6 +20,7 @@
 
 #include <linux/atomic.h>
 #include <linux/byteorder/generic.h>
+#include <linux/errno.h>
 #include <linux/etherdevice.h>
 #include <linux/fs.h>
 #include <linux/if.h>
@@ -156,7 +157,7 @@ int batadv_send_unicast_skb(struct sk_buff *skb,
  * host, NULL can be passed as recv_if and no interface alternating is
  * attempted.
  *
- * Return: -1 on failure (and the skb is not consumed), NET_XMIT_POLICED if the
+ * Return: -1 on failure (and the skb is not consumed), -EINPROGRESS if the
  * skb is buffered for later transmit or the NET_XMIT status returned by the
  * lower routine if the packet has been passed down.
  *
@@ -191,7 +192,7 @@ int batadv_send_skb_to_orig(struct sk_buff *skb,
 	 * network coding fails, then send the packet as usual.
 	 */
 	if (recv_if && batadv_nc_skb_forward(skb, neigh_node))
-		ret = NET_XMIT_POLICED;
+		ret = -EINPROGRESS;
 	else
 		ret = batadv_send_unicast_skb(skb, neigh_node);
 
-- 
2.8.1

