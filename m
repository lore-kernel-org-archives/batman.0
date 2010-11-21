Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Mon, 22 Nov 2010 00:56:03 +0100
Message-Id: <1290383767-32602-26-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <1290383767-32602-1-git-send-email-sven.eckelmann@gmx.de>
References: <1290383767-32602-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH 25/29] Staging: batman-adv: send DHCP
	requests directly to the chosen gw
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
Cc: b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <lindner_marek@yahoo.de>

From: Marek Lindner <lindner_marek@yahoo.de>

If the gateway client mode is active batman-adv will send the
broadcasted DHCP requests via unicast to the currently selected best
gateway. Therefore attached clients can profit from batman's knowledge
about the network topology.

Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
[sven.eckelmann@gmx.de: Rework on top of current version]
Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 drivers/staging/batman-adv/gateway_client.c |   60 +++++++++++++++++++++++++++
 drivers/staging/batman-adv/gateway_client.h |    1 +
 drivers/staging/batman-adv/soft-interface.c |   14 ++++++-
 drivers/staging/batman-adv/unicast.c        |   12 ++++--
 4 files changed, 82 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/batman-adv/gateway_client.c b/drivers/staging/batman-adv/gateway_client.c
index 1846a62..3d4e109 100644
--- a/drivers/staging/batman-adv/gateway_client.c
+++ b/drivers/staging/batman-adv/gateway_client.c
@@ -23,6 +23,9 @@
 #include "gateway_client.h"
 #include "gateway_common.h"
 #include "hard-interface.h"
+#include <linux/ip.h>
+#include <linux/udp.h>
+#include <linux/if_vlan.h>
 
 static void gw_node_free_ref(struct kref *refcount)
 {
@@ -40,6 +43,16 @@ static void gw_node_free_rcu(struct rcu_head *rcu)
 	kref_put(&gw_node->refcount, gw_node_free_ref);
 }
 
+void *gw_get_selected(struct bat_priv *bat_priv)
+{
+	struct gw_node *curr_gateway_tmp = bat_priv->curr_gw;
+
+	if (!curr_gateway_tmp)
+		return NULL;
+
+	return curr_gateway_tmp->orig_node;
+}
+
 void gw_deselect(struct bat_priv *bat_priv)
 {
 	struct gw_node *gw_node = bat_priv->curr_gw;
@@ -385,3 +398,50 @@ int gw_client_seq_print_text(struct seq_file *seq, void *offset)
 
 	return 0;
 }
+
+int gw_is_target(struct bat_priv *bat_priv, struct sk_buff *skb)
+{
+	struct ethhdr *ethhdr;
+	struct iphdr *iphdr;
+	struct udphdr *udphdr;
+	unsigned int header_len = 0;
+
+	if (atomic_read(&bat_priv->gw_mode) == GW_MODE_OFF)
+		return 0;
+
+	/* check for ethernet header */
+	if (!pskb_may_pull(skb, header_len + ETH_HLEN))
+		return 0;
+	ethhdr = (struct ethhdr *)skb->data;
+	header_len += ETH_HLEN;
+
+	/* check for ip header */
+	if (ntohs(ethhdr->h_proto) != ETH_P_IP)
+		return 0;
+
+	if (!pskb_may_pull(skb, header_len + sizeof(struct iphdr)))
+		return 0;
+	iphdr = (struct iphdr *)(skb->data + header_len);
+	header_len += iphdr->ihl * 4;
+
+	/* check for udp header */
+	if (iphdr->protocol != IPPROTO_UDP)
+		return 0;
+
+	if (!pskb_may_pull(skb, header_len + sizeof(struct udphdr)))
+		return 0;
+	udphdr = (struct udphdr *)(skb->data + header_len);
+	header_len += sizeof(struct udphdr);
+
+	/* check for bootp port */
+	if (ntohs(udphdr->dest) != 67)
+		return 0;
+
+	if (atomic_read(&bat_priv->gw_mode) == GW_MODE_SERVER)
+		return -1;
+
+	if (!bat_priv->curr_gw)
+		return 0;
+
+	return 1;
+}
diff --git a/drivers/staging/batman-adv/gateway_client.h b/drivers/staging/batman-adv/gateway_client.h
index 7383b90..4585e65 100644
--- a/drivers/staging/batman-adv/gateway_client.h
+++ b/drivers/staging/batman-adv/gateway_client.h
@@ -31,5 +31,6 @@ void gw_node_update(struct bat_priv *bat_priv,
 void gw_node_delete(struct bat_priv *bat_priv, struct orig_node *orig_node);
 void gw_node_purge(struct bat_priv *bat_priv);
 int gw_client_seq_print_text(struct seq_file *seq, void *offset);
+int gw_is_target(struct bat_priv *bat_priv, struct sk_buff *skb);
 
 #endif /* _NET_BATMAN_ADV_GATEWAY_CLIENT_H_ */
diff --git a/drivers/staging/batman-adv/soft-interface.c b/drivers/staging/batman-adv/soft-interface.c
index 64eaf2a..9b968df 100644
--- a/drivers/staging/batman-adv/soft-interface.c
+++ b/drivers/staging/batman-adv/soft-interface.c
@@ -29,6 +29,7 @@
 #include "types.h"
 #include "hash.h"
 #include "gateway_common.h"
+#include "gateway_client.h"
 #include "send.h"
 #include "bat_sysfs.h"
 #include <linux/slab.h>
@@ -346,6 +347,7 @@ int interface_tx(struct sk_buff *skb, struct net_device *soft_iface)
 	struct vlan_ethhdr *vhdr;
 	int data_len = skb->len, ret;
 	short vid = -1;
+	bool do_bcast = false;
 
 	if (atomic_read(&bat_priv->mesh_state) != MESH_ACTIVE)
 		goto dropped;
@@ -376,8 +378,18 @@ int interface_tx(struct sk_buff *skb, struct net_device *soft_iface)
 	/* TODO: check this for locks */
 	hna_local_add(soft_iface, ethhdr->h_source);
 
-	/* ethernet packet should be broadcasted */
 	if (is_bcast(ethhdr->h_dest) || is_mcast(ethhdr->h_dest)) {
+		ret = gw_is_target(bat_priv, skb);
+
+		if (ret < 0)
+			goto dropped;
+
+		if (ret == 0)
+			do_bcast = true;
+	}
+
+	/* ethernet packet should be broadcasted */
+	if (do_bcast) {
 		if (!bat_priv->primary_if)
 			goto dropped;
 
diff --git a/drivers/staging/batman-adv/unicast.c b/drivers/staging/batman-adv/unicast.c
index 3b62d99..7b9385b 100644
--- a/drivers/staging/batman-adv/unicast.c
+++ b/drivers/staging/batman-adv/unicast.c
@@ -23,6 +23,7 @@
 #include "unicast.h"
 #include "send.h"
 #include "soft-interface.h"
+#include "gateway_client.h"
 #include "originator.h"
 #include "hash.h"
 #include "translation-table.h"
@@ -282,10 +283,13 @@ int unicast_send_skb(struct sk_buff *skb, struct bat_priv *bat_priv)
 	spin_lock_bh(&bat_priv->orig_hash_lock);
 
 	/* get routing information */
-	orig_node = ((struct orig_node *)hash_find(bat_priv->orig_hash,
-						   compare_orig,
-						   choose_orig,
-						   ethhdr->h_dest));
+	if (is_bcast(ethhdr->h_dest) || is_mcast(ethhdr->h_dest))
+		orig_node = (struct orig_node *)gw_get_selected(bat_priv);
+	else
+		orig_node = ((struct orig_node *)hash_find(bat_priv->orig_hash,
+							   compare_orig,
+							   choose_orig,
+							   ethhdr->h_dest));
 
 	/* check for hna host */
 	if (!orig_node)
-- 
1.7.2.3

