Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Thu, 24 Nov 2011 23:21:18 +0100
Message-Id: <1322173279-18338-7-git-send-email-ordex@autistici.org>
In-Reply-To: <1322173279-18338-1-git-send-email-ordex@autistici.org>
References: <1322173279-18338-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCHv4 6/7] batman-adv: Distributed ARP Table -
	increase default soft_iface ARP table timeout
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

The default timeout value for ARP entries belonging to any soft_iface
ARP table has been incremented by a factor 4. This is necessary because the DHT
will store several network entries in the soft_iface ARP table.

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 main.h           |    4 ++++
 soft-interface.c |   17 +++++++++++++++++
 2 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/main.h b/main.h
index a915db6..8672b04 100644
--- a/main.h
+++ b/main.h
@@ -69,6 +69,10 @@
 /* numbers of originator to contact for any STORE/GET DHT operation */
 #define DHT_CANDIDATES_NUM 3
 
+/* Factor which default ARP timeout values of the soft_iface table are
+ * multiplied by */
+#define ARP_TIMEOUT_FACTOR 4
+
 #define NUM_WORDS (TQ_LOCAL_WINDOW_SIZE / WORD_BIT_SIZE)
 
 #define LOG_BUF_LEN 8192	  /* has to be a power of 2 */
diff --git a/soft-interface.c b/soft-interface.c
index 21991e1..1194cf7 100644
--- a/soft-interface.c
+++ b/soft-interface.c
@@ -36,6 +36,7 @@
 #include <linux/ethtool.h>
 #include <linux/etherdevice.h>
 #include <linux/if_vlan.h>
+#include <linux/inetdevice.h>
 #include "unicast.h"
 
 
@@ -825,6 +826,7 @@ static void interface_setup(struct net_device *dev)
 struct net_device *softif_create(const char *name)
 {
 	struct net_device *soft_iface;
+	struct in_device *in_dev;
 	struct bat_priv *bat_priv;
 	int ret;
 
@@ -840,6 +842,21 @@ struct net_device *softif_create(const char *name)
 		goto free_soft_iface;
 	}
 
+	in_dev = in_dev_get(soft_iface);
+	if (!in_dev) {
+		pr_err("Unable to set ARP parameters for the batman interface "
+		       "'%s'\n", name);
+		goto free_soft_iface;
+	}
+
+	/* Introduce a delay in the ARP state-machine transactions. Entries
+	 * will be kept in the ARP table for the default time multiplied by 4 */
+	in_dev->arp_parms->base_reachable_time *= ARP_TIMEOUT_FACTOR;
+	in_dev->arp_parms->gc_staletime *= ARP_TIMEOUT_FACTOR;
+	in_dev->arp_parms->reachable_time *= ARP_TIMEOUT_FACTOR;
+
+	in_dev_put(in_dev);
+
 	bat_priv = netdev_priv(soft_iface);
 
 	atomic_set(&bat_priv->aggregated_ogms, 1);
-- 
1.7.3.4

