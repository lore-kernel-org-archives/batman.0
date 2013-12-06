Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Fri,  6 Dec 2013 15:07:15 +0100
Message-Id: <1386338835-3302-1-git-send-email-antonio@meshcoding.com>
Subject: [B.A.T.M.A.N.] [PATCH maint] batman-adv: free nf_bridge member on
	locally delivered skb
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
Cc: Antonio Quartulli <antonio@meshcoding.com>

If an interface enslaved into batman-adv is a bridge (or a
virtual interface built on top of a bridge) the nf_bridge
member of the skbs reaching the soft-interface is filled
with the state about "netfilter bridge" operations.

Then, if one of such skbs is locally delivered, the nf_bridge
member should be cleaned up to avoid that the old state
could mess up with other "netfilter bridge" operations when
entering a second bridge.
This is needed because batman-adv is an encapsulation
protocol.

However at the moment skb->nf_bridge is not released at all
leading to bogus "netfilter bridge" behaviours.
Fix this by releasing skb->nf_bridge before an skb gets
delivered to the upper layer in interface_rx().

Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
---
 soft-interface.c |  8 ++++++++
 soft-interface.h | 16 ++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/soft-interface.c b/soft-interface.c
index 33b6144..5dd1247 100644
--- a/soft-interface.c
+++ b/soft-interface.c
@@ -371,6 +371,14 @@ void batadv_interface_rx(struct net_device *soft_iface,
 	if (batadv_is_ap_isolated(bat_priv, ethhdr->h_source, ethhdr->h_dest))
 		goto dropped;
 
+	/* Clean the netfilter state before delivering the skb.
+	 * This packet may have traversed a bridge when it was encapsulated into
+	 * the batman header. Now that the header has been removed, the
+	 * netfilter state must be cleaned up to avoid to mess up with a
+	 * possible second bridge
+	 */
+	batadv_nf_bridge_skb_free(skb);
+
 	netif_rx(skb);
 	goto out;
 
diff --git a/soft-interface.h b/soft-interface.h
index 2f2472c..5c19c42 100644
--- a/soft-interface.h
+++ b/soft-interface.h
@@ -29,4 +29,20 @@ void batadv_softif_destroy_sysfs(struct net_device *soft_iface);
 int batadv_softif_is_valid(const struct net_device *net_dev);
 extern struct rtnl_link_ops batadv_link_ops;
 
+#ifdef CONFIG_BRIDGE_NETFILTER
+/**
+ * batadv_nf_bridge_skb_free - clean the NF bridge data in an skb
+ * @skb: the skb which nf data has to be free'd
+ */
+static inline void batadv_nf_bridge_skb_free(struct sk_buff *skb)
+{
+	nf_bridge_put(skb->nf_bridge);
+	skb->nf_bridge = NULL;
+}
+#else
+static inline void batadv_nf_bridge_skb_free(struct sk_buff *skb)
+{
+}
+#endif /* CONFIG_BRIDGE_NETFILTER */
+
 #endif /* _NET_BATMAN_ADV_SOFT_INTERFACE_H_ */
-- 
1.8.5.1

