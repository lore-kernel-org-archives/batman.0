Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Thu, 24 Nov 2016 16:11:01 +0100
Message-Id: <20161124151101.31677-1-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: don't add loop detect macs to TT
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
Cc: Simon Wunderlich <simon.wunderlich@open-mesh.com>

From: Simon Wunderlich <simon.wunderlich@open-mesh.com>

The bridge loop avoidance (BLA) feature of batman-adv sends packets to
probe for Mesh/LAN packet loops. Those packets are not sent by real
clients and should therefore not be added to the translation table (TT).

Signed-off-by: Simon Wunderlich <simon.wunderlich@open-mesh.com>
---
 net/batman-adv/bridge_loop_avoidance.h | 18 ++++++++++++++++++
 net/batman-adv/soft-interface.c        |  3 ++-
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/net/batman-adv/bridge_loop_avoidance.h b/net/batman-adv/bridge_loop_avoidance.h
index 1ae93e4..af550d8 100644
--- a/net/batman-adv/bridge_loop_avoidance.h
+++ b/net/batman-adv/bridge_loop_avoidance.h
@@ -20,6 +20,8 @@
 
 #include "main.h"
 
+#include <linux/compiler.h>
+#include <linux/stddef.h>
 #include <linux/types.h>
 
 struct net_device;
@@ -27,6 +29,22 @@ struct netlink_callback;
 struct seq_file;
 struct sk_buff;
 
+/**
+ * batadv_bla_is_loopdetect_mac - check if the mac address is from a loop detect
+ *  frame sent by bridge loop avoidance
+ * @mac: mac address to check
+ *
+ * Returns true if the it looks like a loop detect frame
+ * (mac starts with BA:BE), false otherwise
+ */
+static inline bool batadv_bla_is_loopdetect_mac(const uint8_t *mac)
+{
+	if (mac[0] == 0xba && mac[1] == 0xbe)
+		return true;
+
+	return false;
+}
+
 #ifdef CONFIG_BATMAN_ADV_BLA
 bool batadv_bla_rx(struct batadv_priv *bat_priv, struct sk_buff *skb,
 		   unsigned short vid, bool is_bcast);
diff --git a/net/batman-adv/soft-interface.c b/net/batman-adv/soft-interface.c
index 7b3494a..1f55b4b 100644
--- a/net/batman-adv/soft-interface.c
+++ b/net/batman-adv/soft-interface.c
@@ -258,7 +258,8 @@ static int batadv_interface_tx(struct sk_buff *skb,
 	ethhdr = eth_hdr(skb);
 
 	/* Register the client MAC in the transtable */
-	if (!is_multicast_ether_addr(ethhdr->h_source)) {
+	if (!is_multicast_ether_addr(ethhdr->h_source) &&
+	    !batadv_bla_is_loopdetect_mac(ethhdr->h_source)) {
 		client_added = batadv_tt_local_add(soft_iface, ethhdr->h_source,
 						   vid, skb->skb_iif,
 						   skb->mark);
-- 
2.10.2

