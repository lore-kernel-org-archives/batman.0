Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Sat, 16 Nov 2013 12:03:52 +0100
Message-Id: <1384599832-3959-7-git-send-email-antonio@meshcoding.com>
In-Reply-To: <1384599832-3959-1-git-send-email-antonio@meshcoding.com>
References: <1384599832-3959-1-git-send-email-antonio@meshcoding.com>
Subject: [B.A.T.M.A.N.] [PATCHv3 6/6] batman-adv: set the isolation mark in
	the skb if needed
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
Cc: Antonio Quartulli <antonio@open-mesh.com>

From: Antonio Quartulli <antonio@open-mesh.com>

If a broadcast packet is coming from a client marked as
isolated, then mark the skb using the isolation mark so
that netfilter (or any other application) can recognise
them.

The mark is written in the skb based on the mask value:
only bits set in the mask are substitued by those in the
mark value

Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
---
 soft-interface.c    | 18 ++++++++++++++++--
 translation-table.c | 26 ++++++++++++++++++++++++++
 translation-table.h |  2 ++
 3 files changed, 44 insertions(+), 2 deletions(-)

diff --git a/soft-interface.c b/soft-interface.c
index 2d629ee..97441d8 100644
--- a/soft-interface.c
+++ b/soft-interface.c
@@ -390,9 +390,23 @@ void batadv_interface_rx(struct net_device *soft_iface,
 		batadv_tt_add_temporary_global_entry(bat_priv, orig_node,
 						     ethhdr->h_source, vid);
 
-	if (batadv_is_ap_isolated(bat_priv, ethhdr->h_source, ethhdr->h_dest,
-				  vid))
+	if (is_multicast_ether_addr(ethhdr->h_dest)) {
+		/* set the mark on broadcast packets if AP isolation is ON and
+		 * the packet is coming from an "isolated" client
+		 */
+		if (batadv_vlan_ap_isola_get(bat_priv, vid) &&
+		    batadv_tt_global_is_isolated(bat_priv, ethhdr->h_source,
+						 vid)) {
+			/* save bits in skb->mark not covered by the mask and
+			 * apply the mark on the rest
+			 */
+			skb->mark &= ~bat_priv->isolation_mark_mask;
+			skb->mark |= bat_priv->isolation_mark;
+		}
+	} else if (batadv_is_ap_isolated(bat_priv, ethhdr->h_source,
+					 ethhdr->h_dest, vid)) {
 		goto dropped;
+	}
 
 	netif_rx(skb);
 	goto out;
diff --git a/translation-table.c b/translation-table.c
index 42c7664..f9a1fb4 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -3572,3 +3572,29 @@ int batadv_tt_init(struct batadv_priv *bat_priv)
 
 	return 1;
 }
+
+/**
+ * batadv_tt_global_is_isolated - check if a client is marked as isolated
+ * @bat_priv: the bat priv with all the soft interface information
+ * @addr: the mac address of the client
+ * @vid: the identifier of the VLAN where this client is connected
+ *
+ * Return true if the client is marked with the TT_CLIENT_ISOLA flag, flase
+ * otherwise
+ */
+bool batadv_tt_global_is_isolated(struct batadv_priv *bat_priv,
+				  const uint8_t *addr, unsigned short vid)
+{
+	struct batadv_tt_global_entry *tt;
+	bool ret;
+
+	tt = batadv_tt_global_hash_find(bat_priv, addr, vid);
+	if (!tt)
+		return false;
+
+	ret = tt->common.flags & BATADV_TT_CLIENT_ISOLA;
+
+	batadv_tt_global_entry_free_ref(tt);
+
+	return ret;
+}
diff --git a/translation-table.h b/translation-table.h
index 202c289..3ab8a7b 100644
--- a/translation-table.h
+++ b/translation-table.h
@@ -45,5 +45,7 @@ bool batadv_tt_add_temporary_global_entry(struct batadv_priv *bat_priv,
 					  struct batadv_orig_node *orig_node,
 					  const unsigned char *addr,
 					  unsigned short vid);
+bool batadv_tt_global_is_isolated(struct batadv_priv *bat_priv,
+				  const uint8_t *addr, unsigned short vid);
 
 #endif /* _NET_BATMAN_ADV_TRANSLATION_TABLE_H_ */
-- 
1.8.4.3

