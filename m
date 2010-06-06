Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Sun,  6 Jun 2010 21:28:17 +0200
Message-Id: <1275852501-28523-6-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <1275852501-28523-1-git-send-email-sven.eckelmann@gmx.de>
References: <1275852501-28523-1-git-send-email-sven.eckelmann@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 5/9] Staging: batman-adv: Adding
	netfilter-bridge hooks
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
To: gregkh@suse.de, b.a.t.m.a.n@lists.open-mesh.net

From: Linus Lüssing <linus.luessing@web.de>

batman-adv is receiving and sending the packets of its own ether type
on a very early/low level. Therefore we need to add explicit hooks to
give netfilter/ebtables a chance to filter them.

Reported-by: Antonio Quartulli <ordex@ritirata.org>
Signed-off-by: Linus Lüssing <linus.luessing@web.de>
Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 drivers/staging/batman-adv/hard-interface.c |   14 +++++++++++++-
 drivers/staging/batman-adv/send.c           |    9 +++++++--
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/batman-adv/hard-interface.c b/drivers/staging/batman-adv/hard-interface.c
index 7a582e8..6939b8d 100644
--- a/drivers/staging/batman-adv/hard-interface.c
+++ b/drivers/staging/batman-adv/hard-interface.c
@@ -30,6 +30,7 @@
 #include "hash.h"
 
 #include <linux/if_arp.h>
+#include <linux/netfilter_bridge.h>
 
 #define MIN(x, y) ((x) < (y) ? (x) : (y))
 
@@ -432,6 +433,11 @@ out:
 	return NOTIFY_DONE;
 }
 
+static int batman_skb_recv_finish(struct sk_buff *skb)
+{
+	return NF_ACCEPT;
+}
+
 /* receive a packet with the batman ethertype coming on a hard
  * interface */
 int batman_skb_recv(struct sk_buff *skb, struct net_device *dev,
@@ -451,6 +457,13 @@ int batman_skb_recv(struct sk_buff *skb, struct net_device *dev,
 	if (atomic_read(&module_state) != MODULE_ACTIVE)
 		goto err_free;
 
+	/* if netfilter/ebtables wants to block incoming batman
+	 * packets then give them a chance to do so here */
+	ret = NF_HOOK(PF_BRIDGE, NF_BR_LOCAL_IN, skb, dev, NULL,
+		      batman_skb_recv_finish);
+	if (ret != 1)
+		goto err_out;
+
 	/* packet should hold at least type and version */
 	if (unlikely(skb_headlen(skb) < 2))
 		goto err_free;
@@ -530,7 +543,6 @@ err_out:
 	return NET_RX_DROP;
 }
 
-
 struct notifier_block hard_if_notifier = {
 	.notifier_call = hard_if_event,
 };
diff --git a/drivers/staging/batman-adv/send.c b/drivers/staging/batman-adv/send.c
index ac69ed8..7365f6d 100644
--- a/drivers/staging/batman-adv/send.c
+++ b/drivers/staging/batman-adv/send.c
@@ -29,6 +29,8 @@
 #include "vis.h"
 #include "aggregation.h"
 
+#include <linux/netfilter_bridge.h>
+
 /* apply hop penalty for a normal link */
 static uint8_t hop_penalty(const uint8_t tq)
 {
@@ -90,9 +92,12 @@ int send_skb_packet(struct sk_buff *skb,
 
 	/* dev_queue_xmit() returns a negative result on error.	 However on
 	 * congestion and traffic shaping, it drops and returns NET_XMIT_DROP
-	 * (which is > 0). This will not be treated as an error. */
+	 * (which is > 0). This will not be treated as an error.
+	 * Also, if netfilter/ebtables wants to block outgoing batman
+	 * packets then giving them a chance to do so here */
 
-	return dev_queue_xmit(skb);
+	return NF_HOOK(PF_BRIDGE, NF_BR_LOCAL_OUT, skb, NULL, skb->dev,
+		       dev_queue_xmit);
 send_skb_err:
 	kfree_skb(skb);
 	return NET_XMIT_DROP;
-- 
1.7.1

