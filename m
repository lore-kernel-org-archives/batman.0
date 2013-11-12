Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Tue, 12 Nov 2013 10:18:19 +0100
Message-Id: <1384247902-789-3-git-send-email-antonio@meshcoding.com>
In-Reply-To: <1384247902-789-1-git-send-email-antonio@meshcoding.com>
References: <1384247902-789-1-git-send-email-antonio@meshcoding.com>
Subject: [B.A.T.M.A.N.] [PATCH 2/5] batman-adv: mark a local client as
	isolated when needed
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

A client sending packets which mark matches the value
configured via sysfs has to be identified as isolated using
the TT_CLIENT_ISOLA flag.

The match is mask based, meaning that only bits set in the
mask are compared with those in the mark value.

If the configured mask is equal to 0 no operation is
performed.

Such flag is then advertised within the classic client
announcement mechanism.

Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
---
 main.h              |  2 ++
 multicast.c         |  3 ++-
 packet.h            |  1 +
 soft-interface.c    |  7 ++++---
 translation-table.c | 14 +++++++++++++-
 translation-table.h |  2 +-
 6 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/main.h b/main.h
index 5686bd1..744af47 100644
--- a/main.h
+++ b/main.h
@@ -67,6 +67,8 @@
 
 #define BATADV_NULL_IFINDEX 0 /* dummy ifindex used to avoid iface checks */
 
+#define BATADV_NO_MARK 0
+
 #define BATADV_NUM_WORDS BITS_TO_LONGS(BATADV_TQ_LOCAL_WINDOW_SIZE)
 
 #define BATADV_LOG_BUF_LEN 8192	  /* has to be a power of 2 */
diff --git a/multicast.c b/multicast.c
index cb1984d..3d479b6 100644
--- a/multicast.c
+++ b/multicast.c
@@ -145,7 +145,8 @@ static void batadv_mcast_mla_tt_add(struct batadv_priv *bat_priv,
 			continue;
 
 		batadv_tt_local_add(bat_priv->soft_iface, mcast_entry->addr,
-				    BATADV_NO_FLAGS, BATADV_NULL_IFINDEX);
+				    BATADV_NO_FLAGS, BATADV_NULL_IFINDEX,
+				    BATADV_NO_MARK);
 		hlist_del(&mcast_entry->list);
 		hlist_add_head(&mcast_entry->list, &bat_priv->mcast.mla_list);
 	}
diff --git a/packet.h b/packet.h
index cbebac6..5f402c9 100644
--- a/packet.h
+++ b/packet.h
@@ -112,6 +112,7 @@ enum batadv_tt_client_flags {
 	BATADV_TT_CLIENT_DEL     = BIT(0),
 	BATADV_TT_CLIENT_ROAM    = BIT(1),
 	BATADV_TT_CLIENT_WIFI    = BIT(4),
+	BATADV_TT_CLIENT_ISOLA	 = BIT(5),
 	BATADV_TT_CLIENT_NOPURGE = BIT(8),
 	BATADV_TT_CLIENT_NEW     = BIT(9),
 	BATADV_TT_CLIENT_PENDING = BIT(10),
diff --git a/soft-interface.c b/soft-interface.c
index c945cea..2d629ee 100644
--- a/soft-interface.c
+++ b/soft-interface.c
@@ -116,7 +116,7 @@ static int batadv_interface_set_mac_addr(struct net_device *dev, void *p)
 		batadv_tt_local_remove(bat_priv, old_addr, BATADV_NO_FLAGS,
 				       "mac address changed", false);
 		batadv_tt_local_add(dev, addr->sa_data, BATADV_NO_FLAGS,
-				    BATADV_NULL_IFINDEX);
+				    BATADV_NULL_IFINDEX, BATADV_NO_MARK);
 	}
 
 	return 0;
@@ -196,7 +196,8 @@ static int batadv_interface_tx(struct sk_buff *skb,
 	/* Register the client MAC in the transtable */
 	if (!is_multicast_ether_addr(ethhdr->h_source)) {
 		client_added = batadv_tt_local_add(soft_iface, ethhdr->h_source,
-						   vid, skb->skb_iif);
+						   vid, skb->skb_iif,
+						   skb->mark);
 		if (!client_added)
 			goto dropped;
 	}
@@ -480,7 +481,7 @@ int batadv_softif_create_vlan(struct batadv_priv *bat_priv, unsigned short vid)
 	 */
 	batadv_tt_local_add(bat_priv->soft_iface,
 			    bat_priv->soft_iface->dev_addr, vid,
-			    BATADV_NULL_IFINDEX);
+			    BATADV_NULL_IFINDEX, BATADV_NO_MARK);
 
 	spin_lock_bh(&bat_priv->softif_vlan_list_lock);
 	hlist_add_head_rcu(&vlan->list, &bat_priv->softif_vlan_list);
diff --git a/translation-table.c b/translation-table.c
index 9eaadbb..373997b 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -475,7 +475,7 @@ static void batadv_tt_global_free(struct batadv_priv *bat_priv,
  * Returns true if the client was successfully added, false otherwise.
  */
 bool batadv_tt_local_add(struct net_device *soft_iface, const uint8_t *addr,
-			 unsigned short vid, int ifindex)
+			 unsigned short vid, int ifindex, uint32_t mark)
 {
 	struct batadv_priv *bat_priv = netdev_priv(soft_iface);
 	struct batadv_tt_local_entry *tt_local;
@@ -486,6 +486,7 @@ bool batadv_tt_local_add(struct net_device *soft_iface, const uint8_t *addr,
 	int hash_added, table_size, packet_size_max;
 	bool ret = false, roamed_back = false;
 	uint8_t remote_flags;
+	uint32_t match_mark;
 
 	if (ifindex != BATADV_NULL_IFINDEX)
 		in_dev = dev_get_by_index(&init_net, ifindex);
@@ -615,6 +616,17 @@ check_roaming:
 	else
 		tt_local->common.flags &= ~BATADV_TT_CLIENT_WIFI;
 
+	/* check the mark in the skb: if it's equal to the configured
+	 * isolation_mark, it means the packet is coming from an isolated
+	 * non-mesh client
+	 */
+	match_mark = (mark & bat_priv->isolation_mark_mask);
+	if (bat_priv->isolation_mark_mask &&
+	    match_mark == bat_priv->isolation_mark)
+		tt_local->common.flags |= BATADV_TT_CLIENT_ISOLA;
+	else
+		tt_local->common.flags &= ~BATADV_TT_CLIENT_ISOLA;
+
 	/* if any "dynamic" flag has been modified, resend an ADD event for this
 	 * entry so that all the nodes can get the new flags
 	 */
diff --git a/translation-table.h b/translation-table.h
index 270773e..202c289 100644
--- a/translation-table.h
+++ b/translation-table.h
@@ -17,7 +17,7 @@
 
 int batadv_tt_init(struct batadv_priv *bat_priv);
 bool batadv_tt_local_add(struct net_device *soft_iface, const uint8_t *addr,
-			 unsigned short vid, int ifindex);
+			 unsigned short vid, int ifindex, uint32_t mark);
 uint16_t batadv_tt_local_remove(struct batadv_priv *bat_priv,
 				const uint8_t *addr, unsigned short vid,
 				const char *message, bool roaming);
-- 
1.8.4.3

