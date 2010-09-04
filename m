Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Sun,  5 Sep 2010 01:58:18 +0200
Message-Id: <1283644718-653-2-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <1283644718-653-1-git-send-email-sven.eckelmann@gmx.de>
References: <1283644718-653-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH 01/21] Revert: "Staging: batman-adv: Adding
	netfilter-bridge hooks"
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
To: greg@kroah.com
Cc: b.a.t.m.a.n@lists.open-mesh.net

This reverts commit 96d592ed599434d2d5f339a1d282871bc6377d2c.

The netfilter hook seems to be misused and may leak skbs in situations
when NF_HOOK returns NF_STOLEN. It may not filter everything as
expected. Also the ethernet bridge tables are not yet capable to
understand batman-adv packet correctly.

It was only added for testing purposes and can be removed again.

Reported-by: Vasiliy Kulikov <segooon@gmail.com>
Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 drivers/staging/batman-adv/hard-interface.c |   13 -------------
 drivers/staging/batman-adv/send.c           |    8 ++------
 2 files changed, 2 insertions(+), 19 deletions(-)

diff --git a/drivers/staging/batman-adv/hard-interface.c b/drivers/staging/batman-adv/hard-interface.c
index baa8b05..6e973a7 100644
--- a/drivers/staging/batman-adv/hard-interface.c
+++ b/drivers/staging/batman-adv/hard-interface.c
@@ -30,7 +30,6 @@
 #include "hash.h"
 
 #include <linux/if_arp.h>
-#include <linux/netfilter_bridge.h>
 
 #define MIN(x, y) ((x) < (y) ? (x) : (y))
 
@@ -431,11 +430,6 @@ out:
 	return NOTIFY_DONE;
 }
 
-static int batman_skb_recv_finish(struct sk_buff *skb)
-{
-	return NF_ACCEPT;
-}
-
 /* receive a packet with the batman ethertype coming on a hard
  * interface */
 int batman_skb_recv(struct sk_buff *skb, struct net_device *dev,
@@ -456,13 +450,6 @@ int batman_skb_recv(struct sk_buff *skb, struct net_device *dev,
 	if (atomic_read(&module_state) != MODULE_ACTIVE)
 		goto err_free;
 
-	/* if netfilter/ebtables wants to block incoming batman
-	 * packets then give them a chance to do so here */
-	ret = NF_HOOK(PF_BRIDGE, NF_BR_LOCAL_IN, skb, dev, NULL,
-		      batman_skb_recv_finish);
-	if (ret != 1)
-		goto err_out;
-
 	/* packet should hold at least type and version */
 	if (unlikely(skb_headlen(skb) < 2))
 		goto err_free;
diff --git a/drivers/staging/batman-adv/send.c b/drivers/staging/batman-adv/send.c
index 055edee..da3c82e 100644
--- a/drivers/staging/batman-adv/send.c
+++ b/drivers/staging/batman-adv/send.c
@@ -29,7 +29,6 @@
 #include "vis.h"
 #include "aggregation.h"
 
-#include <linux/netfilter_bridge.h>
 
 static void send_outstanding_bcast_packet(struct work_struct *work);
 
@@ -92,12 +91,9 @@ int send_skb_packet(struct sk_buff *skb,
 
 	/* dev_queue_xmit() returns a negative result on error.	 However on
 	 * congestion and traffic shaping, it drops and returns NET_XMIT_DROP
-	 * (which is > 0). This will not be treated as an error.
-	 * Also, if netfilter/ebtables wants to block outgoing batman
-	 * packets then giving them a chance to do so here */
+	 * (which is > 0). This will not be treated as an error. */
 
-	return NF_HOOK(PF_BRIDGE, NF_BR_LOCAL_OUT, skb, NULL, skb->dev,
-		       dev_queue_xmit);
+	return dev_queue_xmit(skb);
 send_skb_err:
 	kfree_skb(skb);
 	return NET_XMIT_DROP;
-- 
1.7.1

