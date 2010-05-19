Return-Path: <linus.luessing@web.de>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@web.de>
Date: Wed, 19 May 2010 03:25:49 +0200
Message-Id: <1274232349-10414-1-git-send-email-linus.luessing@web.de>
In-Reply-To: <20100517072041.GA23674@ritirata.org>
References: <20100517072041.GA23674@ritirata.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linus.luessing@web.de
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Adding netfilter-bridge hooks
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

batman-adv is receiving and sending the packets of its own ether type
on a very early/low level. Therefore we need to add explicit hooks to
give netfilter/ebtables a chance to filter them.

Signed-off-by: Linus Lüssing <linus.luessing@web.de>
Reported-by: Antonio Quartulli <ordex@ritirata.org>
---
 batman-adv-kernelland/hard-interface.c |   17 +++++++++++++++--
 batman-adv-kernelland/send.c           |    8 ++++++--
 2 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/batman-adv-kernelland/hard-interface.c b/batman-adv-kernelland/hard-interface.c
index cc7fbae..6a64930 100644
--- a/batman-adv-kernelland/hard-interface.c
+++ b/batman-adv-kernelland/hard-interface.c
@@ -28,9 +28,11 @@
 #include "bat_sysfs.h"
 #include "originator.h"
 #include "hash.h"
-#include "compat.h"
 
 #include <linux/if_arp.h>
+#include <linux/netfilter_bridge.h>
+
+#include "compat.h"
 
 #define MIN(x, y) ((x) < (y) ? (x) : (y))
 
@@ -433,6 +435,11 @@ out:
 	return NOTIFY_DONE;
 }
 
+int batman_skb_recv_finish(struct sk_buff *skb)
+{
+	return NF_ACCEPT;
+}
+
 /* receive a packet with the batman ethertype coming on a hard
  * interface */
 int batman_skb_recv(struct sk_buff *skb, struct net_device *dev,
@@ -452,6 +459,13 @@ int batman_skb_recv(struct sk_buff *skb, struct net_device *dev,
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
@@ -531,7 +545,6 @@ err_out:
 	return NET_RX_DROP;
 }
 
-
 struct notifier_block hard_if_notifier = {
 	.notifier_call = hard_if_event,
 };
diff --git a/batman-adv-kernelland/send.c b/batman-adv-kernelland/send.c
index 99d11fe..b0d3627 100644
--- a/batman-adv-kernelland/send.c
+++ b/batman-adv-kernelland/send.c
@@ -29,6 +29,7 @@
 #include "vis.h"
 #include "aggregation.h"
 #include "gateway_common.h"
+#include <linux/netfilter_bridge.h>
 
 #include "compat.h"
 
@@ -93,9 +94,12 @@ int send_skb_packet(struct sk_buff *skb,
 
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
1.5.6.5

