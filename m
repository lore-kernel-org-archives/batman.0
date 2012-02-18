Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Sat, 18 Feb 2012 17:38:52 +0100
Message-Id: <1329583133-11681-7-git-send-email-ordex@autistici.org>
In-Reply-To: <1329583133-11681-1-git-send-email-ordex@autistici.org>
References: <1329583133-11681-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCHv6 6/7] batman-adv: Distributed ARP Table -
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
 distributed-arp-table.c |   19 +++++++++++++++++++
 distributed-arp-table.h |    1 +
 main.h                  |    3 +++
 soft-interface.c        |    2 ++
 4 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/distributed-arp-table.c b/distributed-arp-table.c
index 3693879..57b0c43 100644
--- a/distributed-arp-table.c
+++ b/distributed-arp-table.c
@@ -23,6 +23,7 @@
 #include <linux/if_arp.h>
 /* needed to use arp_tbl */
 #include <net/arp.h>
+#include <linux/inetdevice.h>
 
 #include "main.h"
 #include "distributed-arp-table.h"
@@ -573,3 +574,21 @@ bool arp_drop_broadcast_packet(struct bat_priv *bat_priv,
 	}
 	return false;
 }
+
+void arp_change_timeout(struct net_device *soft_iface, const char *name)
+{
+	struct in_device *in_dev = in_dev_get(soft_iface);
+	if (!in_dev) {
+		pr_err("Unable to set ARP parameters for the batman interface "
+		       "'%s'\n", name);
+		return;
+	}
+
+	/* Introduce a delay in the ARP state-machine transactions. Entries
+	 * will be kept in the ARP table for the default time multiplied by 4 */
+	in_dev->arp_parms->base_reachable_time *= ARP_TIMEOUT_FACTOR;
+	in_dev->arp_parms->gc_staletime *= ARP_TIMEOUT_FACTOR;
+	in_dev->arp_parms->reachable_time *= ARP_TIMEOUT_FACTOR;
+
+	in_dev_put(in_dev);
+}
diff --git a/distributed-arp-table.h b/distributed-arp-table.h
index 3b90b73..bf4390d 100644
--- a/distributed-arp-table.h
+++ b/distributed-arp-table.h
@@ -47,6 +47,7 @@ bool dat_snoop_incoming_arp_reply(struct bat_priv *bat_priv,
 				  struct sk_buff *skb, int hdr_size);
 bool arp_drop_broadcast_packet(struct bat_priv *bat_priv,
 			       struct forw_packet *forw_packet);
+void arp_change_timeout(struct net_device *soft_iface, const char *name);
 
 /* hash function to choose an entry in a hash table of given size */
 /* hash algorithm from http://en.wikipedia.org/wiki/Hash_table */
diff --git a/main.h b/main.h
index 7384abb..9c8f4c1 100644
--- a/main.h
+++ b/main.h
@@ -71,6 +71,9 @@
 #define ARP_REQ_DELAY 250
 /* numbers of originator to contact for any PUT/GET DHT operation */
 #define DHT_CANDIDATES_NUM 3
+/* Factor which default ARP timeout values of the soft_iface table are
+ * multiplied by */
+#define ARP_TIMEOUT_FACTOR 4
 
 #define LOG_BUF_LEN 8192	  /* has to be a power of 2 */
 
diff --git a/soft-interface.c b/soft-interface.c
index f27ea7e..766d073 100644
--- a/soft-interface.c
+++ b/soft-interface.c
@@ -382,6 +382,8 @@ struct net_device *softif_create(const char *name)
 		goto free_soft_iface;
 	}
 
+	arp_change_timeout(soft_iface, name);
+
 	bat_priv = netdev_priv(soft_iface);
 
 	atomic_set(&bat_priv->aggregated_ogms, 1);
-- 
1.7.3.4

